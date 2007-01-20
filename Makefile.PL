# $Id: Makefile.PL,v 1.3 2007/01/20 19:07:08 comdog Exp $
use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";

sub MY::postamble {
	<<'MAKE';
install :: iphoto-shell-install
	
iphoto-shell-install:
	$(ECHO) "Installing new-iterm symlink to module"
	/bin/ln -sfv $(INSTALLSITELIB)/Mac/iPhoto/Shell.pm $(INSTALLBIN)/iphoto-shell
	$(CHMOD) 755 $(INSTALLSITELIB)/Mac/iPhoto/Shell.pm
MAKE
	}

WriteMakefile(
	'NAME'      => 'Mac::iPhoto::Shell',
	'VERSION'   => '0.13',
	'LICENSE'	=> 'perl',
		
	'PREREQ_PM' => {
			Mac::Glue => '0',
			},

	'PM'           => {
		'lib/Shell.pm'         => '$(INST_LIBDIR)/Shell.pm',
		},

	'MAN3PODS'  => {
		'lib/Shell.pm' => "\$(INST_MAN3DIR)/Mac::iPhoto::Shell.1",
		},

	'MAN1PODS'  => {
		'lib/Shell.pm' => "\$(INST_MAN1DIR)/iphoto_shell.1",
		},

	clean => { FILES => "*.bak Mac-*" },
	);
        
1;

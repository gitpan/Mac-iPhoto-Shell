# $Id: Makefile.PL 2235 2007-03-19 06:12:04Z comdog $
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
	'VERSION'   => '0.15',
	'LICENSE'	=> 'perl',
	'AUTHOR'    => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM' => {
			Mac::Glue => '1.28',
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
        
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# An auto installer should already have installed Mac::Glue
{
require Mac::Glue;

my $iterm = eval { Mac::Glue->new( 'iPhoto' ) };

if( $@ ) 
	{
	require Mac::Processes; Mac::Processes->import;
	
	my $path = LSFindApplicationForInfo( undef, undef, 'iPhoto.app' );

	if( $path ) 
		{
		print <<"HERE";
To create the Mac::Glue bindings for iTerm you need to run:

	sudo gluemac $iterm_path

HERE

		print "Would you like to run this now? (y/N) ";

		chomp( my $confirm = <> );

		if( lc( $confirm ) eq 'y' ) 
			{
			system 'sudo', 'gluemac', $path;
			$iterm = eval { Mac::Glue->new( 'iPhoto' ) };
			}
		}
	else
		{
		die "Could not find iPhoto. Ensure you have it and try again\n";
		}
	}

unless( defined $iterm )
	{
	die "Cannot continue: Ensure that the iPhoto glue for Mac::Glue is installed\n";
	}

}

1;

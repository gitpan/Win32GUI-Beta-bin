@rem = '--*-Perl-*--';
@rem = '
@echo off
perl.exe install.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
@rem ';

#   Win32::GUI Install Program
#   by Aldo Calpini <dada@divinf.it>

$MODULE    = "Win32::GUI";
$VERSION   = "Beta";
$PM        = "GUI.pm";
$DLL       = "GUI.dll";
$FIRSTNAME = "GUI";

print "\n   $MODULE version $VERSION Install Program\n".
        "   by Aldo Calpini <dada\@divinf.it>\n\n";

# thanks once again to Gurusamy Sarathy for his fixes :-)

use Config;

$PERLLIB     = $Config{'privlib'};
$SITELIB     = $Config{'sitelib'};
$SITEARCHLIB = $Config{'sitearch'};

CheckDir($SITELIB);
CheckDir($SITELIB."\\Win32");

print "Copying $PM to $SITELIB\\Win32...\n";
`copy $PM "$SITELIB\\Win32"`;

CheckDir($SITEARCHLIB);
CheckDir($SITEARCHLIB."\\auto");
CheckDir($SITEARCHLIB."\\auto\\Win32");
CheckDir($SITEARCHLIB."\\auto\\Win32\\$FIRSTNAME");

print "Copying $DLL to $SITEARCHLIB\\auto\\Win32\\$FIRSTNAME...\n";
`copy $DLL "$SITEARCHLIB\\auto\\Win32\\$FIRSTNAME"`;

# manually append installation 
# information to perllocal.pod
# (what a bad trick... :-)

open( DOC_INSTALL, ">> $PERLLIB/perllocal.pod");

print DOC_INSTALL "=head2 ", scalar(localtime), ": C<Module> L<$MODULE>\n\n".
                  "=over 4\n\n".
                  "=item *\n\n".
                  "C<installed into: $SITELIB>\n\n".
                  "=item *\n\n".
                  "C<LINKTYPE: dynamic>\n\n".
                  "=item *\n\n".
                  "C<VERSION: $VERSION>\n\n".
                  "=item *\n\n".
                  "C<EXE_FILES: >\n\n".
                  "=back\n\n";

close(DOC_INSTALL);

print "Installation complete.\n";

sub CheckDir {
    my($dir) = @_;
    if(! -d $dir) {
        print "Creating directory $dir...\n";
        mkdir($dir, 0) or die "ERROR: ($!)\n";
    }
}    

__END__
:endofperl

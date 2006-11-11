Message-ID: <4555C56B.3070205@domain.hid>
Date: Sat, 11 Nov 2006 13:43:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050807060309080005080300"
Subject: [Xenomai-core] [PATCH] Xenomai configuration help for Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050807060309080005080300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch adds Xenomai configuration help for Linux 2.4:

2006-11-11  Wolfgang Grandegger  <wg@domain.hid>

	* scripts/prepare_kernel.sh, scripts/help_from_kconfig.pl:
	prepare_kernel.sh will now add help for Xenomai configuration
	parameters to the Configure.help file of 2.4 kernels. The help
	is extracted from Xenomai's Kconfig files using a perl script.

Wolfgang.

--------------050807060309080005080300
Content-Type: text/x-patch;
 name="xenomai-help-from-kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-help-from-kconfig.patch"

+ diff -u xenomai/ChangeLog.ORIG xenomai/ChangeLog
--- xenomai/ChangeLog.ORIG	2006-11-09 22:16:54.000000000 +0100
+++ xenomai/ChangeLog	2006-11-11 13:10:06.000000000 +0100
@@ -1,3 +1,10 @@
+2006-11-11  Wolfgang Grandegger  <wg@domain.hid>
+
+	* scripts/prepare_kernel.sh, scripts/help_from_kconfig.pl:
+	prepare_kernel.sh will now add help for Xenomai configuration
+	parameters to the Configure.help file of 2.4 kernels. The help
+	is extracted from Xenomai's Kconfig files using a perl script.
+
 2006-11-08  Wolfgang Grandegger  <wg@domain.hid>
 
 	* ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Fix warnings when
+ diff -u xenomai/scripts/help_from_kconfig.pl.ORIG xenomai/scripts/help_from_kconfig.pl
--- xenomai/scripts/help_from_kconfig.pl.ORIG	2006-11-11 12:56:06.000000000 +0100
+++ xenomai/scripts/help_from_kconfig.pl	2006-11-11 12:37:21.000000000 +0100
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+
+my $config=0;
+my $help=0;
+
+foreach $file (@ARGV)
+{
+    open (FILE, $file) || die "Can't open $file: $!\n";
+    while (<FILE>) {
+        if (/^[a-z]/) {
+	    if ($help>0) {
+		printf "\n";
+	    }
+	    $help=0;
+	    $config=0;
+	    if (/^config\s+(\w*)/) {
+		$config=1;
+		$config_name="CONFIG_$1";
+	    }
+	} else {
+	    if ($config==1) {
+		if (/^\s+(bool|tristate||string|int|hex)\s"+(.*)"+\s*$/) {
+		    $type=$2;
+		}
+		if (/^\s+([-]*help[-]*)\s*$/) {
+		    $help=rindex($_, $1);
+		    $help_start=0;
+		    printf "$type\n";
+		    printf "$config_name\n";
+		} else {
+		    if ($help>0) {
+			$line=substr($_, $help);
+			if ($help_start==0) {
+			    if ($line =~ /\S+/) {
+				$help_start=1;
+			    }
+			}
+			if ($help_start==1) {
+			    printf "  $line";
+			}
+		    }
+		}
+	    }
+	}
+    }
+    if ($help>0) {
+	printf "\n";
+    }
+    close (FILE);
+}
+ diff -u xenomai/scripts/prepare-kernel.sh.ORIG xenomai/scripts/prepare-kernel.sh
--- xenomai/scripts/prepare-kernel.sh.ORIG	2006-11-09 22:15:41.000000000 +0100
+++ xenomai/scripts/prepare-kernel.sh	2006-11-11 13:32:25.000000000 +0100
@@ -129,6 +129,23 @@
 
 }
 
+patch_help() {
+    if which perl > /dev/null; then
+	hfile=$linux_tree/Documentation/Configure.help
+	if ! grep -iq CONFIG_XENO $hfile; then
+	    kfiles=$xenomai_root/scripts/Kconfig.frag
+	    for d in ksrc/nucleus ksrc/skins ksrc/arch/$xenomai_arch \
+		ksrc/drivers sim; do
+		kfiles="$kfiles `find $xenomai_root/$d -name Kconfig`"
+	    done
+	    perl $xenomai_root/scripts/help_from_kconfig.pl $kfiles >> $hfile
+	    if test x$verbose = x1; then
+		echo 'Configuration help added.'
+	    fi
+	fi
+    fi
+}
+
 generate_patch() {
     (
     cd "$temp_tree"
@@ -483,7 +500,10 @@
 .
 wq
 EOF
+
     fi
+
+    patch_help
     ;;
 
     #

--------------050807060309080005080300--


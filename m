Message-ID: <4794E556.1030904@domain.hid>
Date: Mon, 21 Jan 2008 19:32:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4794DDF7.9070009@domain.hid>
In-Reply-To: <4794DDF7.9070009@domain.hid>
Content-Type: multipart/mixed; boundary="------------010301020509060305000005"
Subject: Re: [Xenomai-core] Patch selection by prepare-kernel.sh (again)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------010301020509060305000005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Philippe,
> 
> what was the idea behind commit #3256 [1]? It breaks the original
> behavior of selection adeos-ipipe-2.6.23-... in the presence of 2.6.23.x
> - and leaves a bad first impression for beginners (I received such a
> notice here...). Was this for the special case
> adeos-ipipe-2.6.20.21-i386-1.12-02.patch? But I think the common case
> should take precedence over this corner case here. Unless there are more
> issues with the original version, I would vote for restoring it.
> 
> Alternatively, we could add a safety belt by trying to apply the patch
> with --dry-run first and only continue if this works out without
> failures. Can hack this up if it's acceptable.

Oh, this check already exists!

So let's try this version, which additionally cleans up the related
documentation. Catches both 2.6.23* and 2.6.24* for me here, but I may
miss some cases (2.4?).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------010301020509060305000005
Content-Type: text/x-patch;
 name="improve-patch-detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="improve-patch-detection.patch"

---
 README.INSTALL            |    5 ++++-
 scripts/prepare-kernel.sh |    8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

Index: xenomai/README.INSTALL
===================================================================
--- xenomai.orig/README.INSTALL
+++ xenomai/README.INSTALL
@@ -66,7 +66,6 @@ support:
 $ cd xenomai-2.4
 $ scripts/prepare-kernel.sh
   --linux=/usr/src/linux-2.6.23-ipipe
-  --adeos=/tmp/adeos-ipipe-2.6.23-i386-1.10-12.patch
   --arch=i386
 
 Note: The script will infer the location of the Xenomai kernel code
@@ -75,6 +74,10 @@ if /usr/src/xenomai-2.4/script/prepare-k
 Xenomai's kernel support available from /usr/src/xenomai-2.4/ksrc will
 be bound to the target kernel.
 
+Second note: If the script fails to figure out a matching Adeos patch,
+it will ask for the correct patch file. Suitable patches are available
+under ksrc/arch/<target-arch>/patches.
+
 1.2 Configuring and building the target kernel
 ----------------------------------------------
 
Index: xenomai/scripts/prepare-kernel.sh
===================================================================
--- xenomai.orig/scripts/prepare-kernel.sh
+++ xenomai/scripts/prepare-kernel.sh
@@ -353,10 +353,10 @@ eval linux_`grep '^PATCHLEVEL =' $linux_
 eval linux_`grep '^SUBLEVEL =' $linux_tree/Makefile | sed -e 's, ,,g'`
 eval linux_`grep '^VERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
 
-linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL$linux_EXTRAVERSION"
+linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
 
 if test x$verbose = x1; then
-echo "Preparing kernel $linux_version in $linux_tree..."
+echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
 fi
 
 if test -r $linux_tree/include/linux/ipipe.h; then
@@ -369,7 +369,7 @@ elif test -r $linux_tree/include/linux/a
    exit 2
 else
    if test x$adeos_patch = x; then
-      default_adeos_patch=`( ls $xenomai_root/ksrc/arch/$xenomai_arch/patches/adeos-ipipe-$linux_version-$linux_arch-*|sort -r ) 2>/dev/null | head -n1`
+      default_adeos_patch="`( ls $xenomai_root/ksrc/arch/$xenomai_arch/patches/adeos-ipipe-$linux_version*-{$linux_arch,$xenomai_arch}-*|sort -r ) 2>/dev/null | head -n1`"
    fi
    if test x$default_adeos_patch = x; then
       default_adeos_patch=/dev/null
@@ -393,7 +393,7 @@ else
    curdir=$PWD
    cd $linux_tree && patch --dry-run -p1 -f < $adeos_patch || { 
         cd $curdir;
-        echo "$me: Unable to patch kernel $linux_version with `basename $adeos_patch`." >&2
+        echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $adeos_patch`." >&2
         exit 2;
    }
    patch -p1 -f -s < $adeos_patch

--------------010301020509060305000005--


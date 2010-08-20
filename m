Message-ID: <4C6EB0AD.2020206@domain.hid>
Date: Fri, 20 Aug 2010 18:43:25 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6B870C.7090600@domain.hid>
	<201008181003.09206.paul_c@domain.hid>
	<4C6BA2A1.4030005@domain.hid> <4C6D4C01.2010402@domain.hid>
	<4C6D4D9F.2060200@domain.hid> <4C6D663C.9010709@domain.hid>
	<4C6D7CC1.3080104@domain.hid>
In-Reply-To: <4C6D7CC1.3080104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEF474B6D925AA9617C900CA"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEF474B6D925AA9617C900CA
Content-Type: multipart/mixed;
 boundary="------------050501060807000503030309"

This is a multi-part message in MIME format.
--------------050501060807000503030309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19.08.2010 20:49, Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
>  =20
> [...]
>> ok, as you said above it's 'non-trivial' but on the other side we are
>> not in a hurry.
>>    =20
> Ok. I will try and have a look at modifying prepare-kernel.sh, probably=

> this week-end. When done, I will let someone else (probably you ?)
>  =20
Thank you.
> modify prepare-patch.sh. In the meantime, I will merge the patch you
> sent which fixes prepare-patch.sh, and the other one which moves
> prepare-patch.sh.
>  =20

I sent only one, attached both now.

Stefan


--------------050501060807000503030309
Content-Type: text/x-patch;
 name="0001-debian-fix-asm-include-directory-linking-in-prepare-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-debian-fix-asm-include-directory-linking-in-prepare-.pa";
 filename*1="tch"

=46rom 80e14710c85f35e9e62657c5b89ea5c271b977e4 Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Wed, 18 Aug 2010 20:24:15 +0200
Subject: [PATCH 1/2] debian: fix asm include directory linking in prepare=
-patch.sh

---
 debian/prepare-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/prepare-patch.sh b/debian/prepare-patch.sh
index 296638d..6ca734b 100755
--- a/debian/prepare-patch.sh
+++ b/debian/prepare-patch.sh
@@ -112,7 +112,7 @@ for linux_arch in $supported_arch ; do
     esac
=20
     patch_link r m ksrc/arch/$base_arch arch/$linux_arch/xenomai
-    patch_link r n include/asm-$base_arch include/asm-$linux_arch/xenoma=
i
+    patch_link r n include/asm-$base_arch arch/$linux_arch/include/asm/x=
enomai
=20
     p=3D"+drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_arch/xenomai/"
     echo $p | patch_append arch/$linux_arch/Makefile
--=20
1.7.1


--------------050501060807000503030309
Content-Type: text/x-patch;
 name="0002-debian-move-debian-prepare-patch.sh-to-scripts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0002-debian-move-debian-prepare-patch.sh-to-scripts.patch"

=46rom 1ebcd79e2b1dce0c52c7ad327245774ca053091b Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 20 Aug 2010 18:19:32 +0200
Subject: [PATCH 2/2] debian: move debian/prepare-patch.sh to scripts/

---
 debian/prepare-patch.sh  |  201 ----------------------------------------=
------
 debian/rules             |    2 +-
 scripts/prepare-patch.sh |  201 ++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 202 insertions(+), 202 deletions(-)
 delete mode 100755 debian/prepare-patch.sh
 create mode 100755 scripts/prepare-patch.sh

diff --git a/debian/prepare-patch.sh b/debian/prepare-patch.sh
deleted file mode 100755
index 6ca734b..0000000
--- a/debian/prepare-patch.sh
+++ /dev/null
@@ -1,201 +0,0 @@
-#! /bin/bash
-
-#----------------------------------------------------------------------
-# Description: Hacked down & butchered scripts/prepare-kernel.sh..
-#               Script to copy assorted sources to a temp directory and
-#               generate a kernel patch without the need of a virgin
-#               linux source tree.
-#----------------------------------------------------------------------
-
-set -e
-
-unset CDPATH
-
-patch_file=3Dxenomai_all.patch
-
-supported_arch=3D"$*"
-
-patch_append() {
-    file=3D"$1"
-
-#    echo "diff -u1wbr orig/$file new/$file" >> $patch_file
-    echo "--- linux/$file	1970-01-01 01:00:00.000000000 +0100" >> $patch=
_file
-    echo "+++ linux-patched/$file	2007-03-06 17:55:58.000000000 +0000" >=
> $patch_file
-    echo "@@ -500,0 +500,2 @@" >> $patch_file
-    echo "+" >> $patch_file
-    cat >> $patch_file
-}
-
-patch_link() {
-    recursive=3D"$1"              # "r" or "n"
-    link_makefiles=3D"$2"         # "m" or "n"
-    target_dir=3D"$3"
-    link_dir=3D"$4"
-
-    (
-        recursive_opt=3D""
-        directorytype_opt=3D""
-        if test x$recursive =3D xr; then
-            recursive_opts=3D"-mindepth 1"
-            directorytype_opt=3D"-type d -o"
-        else
-            recursive_opt=3D"-maxdepth 1"
-        fi
-        link_makefiles_opt=3D""
-        if test x$link_makefiles =3D xm; then
-            link_makefiles_opt=3D"-name Makefile -o"
-        fi
-
-        cd $xenomai_root/$target_dir &&
-        find . $recursive_opt \( $link_makefiles_opt -name Kconfig -o -n=
ame '*.[chS]' \) |
-        while read f; do
-            f=3D`echo $f | cut -d/ -f2-`
-            d=3D`dirname $f`
-            if test ! -d  $temp_tree/$link_dir/$d ; then
-                mkdir -p $temp_tree/$link_dir/$d
-            fi
-            cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
-        done
-    )
-
-}
-
-generate_patch() {
-    (
-    cd "$temp_tree"
-    find . -name demos -o -name snippets -exec rm -fR {} \+ &&
-    find . -type f |
-    while read f ; do
-        diff -Naurd "$linux_tree/$f" "$f" |
-        sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
-            -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
-    done
-    )
-}
-
-diff_addons() {
-    lines=3D`cat $xenomai_root/scripts/Kconfig.frag | wc -l`
-
-    echo "--- linux/init/Kconfig	1970-01-01 01:00:00.000000000 +0100" >>=
 $patch_file
-    echo "+++ linux-patched/init/Kconfig	2007-03-06 17:55:58.000000000 +=
0000" >> $patch_file
-    echo "@@ -1400,0 +1400,$lines @@" >> $patch_file
-    sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.=
frag | sed 's/^/+/' >> $patch_file
-    echo " " >> $patch_file
-}
-
-xenomai_root=3D`dirname $0`/..
-xenomai_root=3D`cd $xenomai_root && pwd`
-
-rm -fR $xenomai_root/tmp
-rm -f $patch_file
-
-mkdir -p $xenomai_root/tmp/linux
-mkdir -p $xenomai_root/tmp/linux.new
-linux_tree=3D"$xenomai_root/tmp/linux"
-temp_tree=3D"$xenomai_root/tmp/linux.new"
-
-
-for linux_arch in $supported_arch ; do
-    case $linux_arch in
-        i386)
-            base_arch=3Dx86
-            ;;
-        x86_64)
-            base_arch=3Dx86
-            ;;
-        x86)
-            base_arch=3Dx86
-            ;;
-        *)
-            base_arch=3D$linux_arch
-            ;;
-    esac
-
-    patch_link r m ksrc/arch/$base_arch arch/$linux_arch/xenomai
-    patch_link r n include/asm-$base_arch arch/$linux_arch/include/asm/x=
enomai
-
-    p=3D"+drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_arch/xenomai/"
-    echo $p | patch_append arch/$linux_arch/Makefile
-    diff_addons
-done
-
-p=3D"+obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-echo $p | patch_append drivers/Makefile
-
-p=3D"+obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-echo $p | patch_append kernel/Makefile
-
-# Create local directories then symlink to the source files from
-# there, so that we don't pollute the Xenomai source tree with
-# compilation files.
-patch_link n m ksrc/ kernel/xenomai
-patch_link n m ksrc/arch kernel/xenomai/arch
-patch_link r m ksrc/arch/generic kernel/xenomai/arch/generic
-patch_link n m ksrc/nucleus kernel/xenomai/nucleus
-patch_link r m ksrc/skins kernel/xenomai/skins
-patch_link r m ksrc/drivers drivers/xenomai
-patch_link r n include/asm-generic include/asm-generic/xenomai
-patch_link n n include include/xenomai
-cd $xenomai_root
-for d in include/* ; do
-    if test -d $d -a -z "`echo $d | grep '^include/asm-'`"; then
-        destdir=3D`echo $d | sed -e 's,^\(include\)\(/.*\)$,\1/xenomai\2=
,'`
-        patch_link r n $d $destdir
-    fi
-done
-
-generate_patch >> $patch_file
-
-cd $xenomai_root
-
-#echo "Patch-name: Xenomai realtime kernel patches" > $xenomai_root/debi=
an/linux-patch-xenomai.kpatches
-#echo "Patch-id: xenomai" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
-#echo "Architecture: all" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
-
-find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patc=
h" |
-while read f ; do
-
-    file=3D`basename $f`
-    arch=3D`echo $file | cut -d- -f4`
-    kver=3D`echo $file | cut -d- -f3`
-
-    case $arch in
-        arm)
-            march=3Darm
-        ;;
-        i386)
-            march=3Di386
-        ;;
-        ppc|ppc64|powerpc)
-            march=3Dpowerpc
-        ;;
-        x86_64)
-            march=3Damd64
-        ;;
-	x86)
-	    march=3Di386
-	;;
-    esac
-
-    # Only one patch per arch/kver - Having a common plus kver/arch patc=
h
-    # would require two linux-patch-foo packages.. When dh-kpatches Ver.=
1.0
-    # gets to testing, this can be looked at again..
-    echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
-    echo "Patch-file: $file" >> $xenomai_root/debian/linux-patch-xenomai=
=2Ekpatches
-    echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xen=
omai.kpatches
-    echo "Architecture: $march" >> $xenomai_root/debian/linux-patch-xeno=
mai.kpatches
-
-    if [ "$arch" =3D "x86" ] ; then
-	echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
-	echo "Patch-file: $file" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
-	echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xenoma=
i.kpatches
-	echo "Architecture: amd64" >> $xenomai_root/debian/linux-patch-xenomai.=
kpatches
-    fi
-
-    cp $f $xenomai_root/$file
-    cat $xenomai_root/$patch_file >> $xenomai_root/$file
-
-done
-
-exit 0
-
diff --git a/debian/rules b/debian/rules
index e39977d..788b031 100755
--- a/debian/rules
+++ b/debian/rules
@@ -63,7 +63,7 @@ patch-stamp:
 	dh_testdir
 	cp debian/linux-patch-xenomai.kpatches.in debian/linux-patch-xenomai.kp=
atches
 	for i in arm i386 powerpc x86_64 x86 ; do \
-		bash $(CURDIR)/debian/prepare-patch.sh $$i ; \
+		bash $(CURDIR)/scripts/prepare-patch.sh $$i ; \
 	done
 	touch patch-stamp
=20
diff --git a/scripts/prepare-patch.sh b/scripts/prepare-patch.sh
new file mode 100755
index 0000000..6ca734b
--- /dev/null
+++ b/scripts/prepare-patch.sh
@@ -0,0 +1,201 @@
+#! /bin/bash
+
+#----------------------------------------------------------------------
+# Description: Hacked down & butchered scripts/prepare-kernel.sh..
+#               Script to copy assorted sources to a temp directory and
+#               generate a kernel patch without the need of a virgin
+#               linux source tree.
+#----------------------------------------------------------------------
+
+set -e
+
+unset CDPATH
+
+patch_file=3Dxenomai_all.patch
+
+supported_arch=3D"$*"
+
+patch_append() {
+    file=3D"$1"
+
+#    echo "diff -u1wbr orig/$file new/$file" >> $patch_file
+    echo "--- linux/$file	1970-01-01 01:00:00.000000000 +0100" >> $patch=
_file
+    echo "+++ linux-patched/$file	2007-03-06 17:55:58.000000000 +0000" >=
> $patch_file
+    echo "@@ -500,0 +500,2 @@" >> $patch_file
+    echo "+" >> $patch_file
+    cat >> $patch_file
+}
+
+patch_link() {
+    recursive=3D"$1"              # "r" or "n"
+    link_makefiles=3D"$2"         # "m" or "n"
+    target_dir=3D"$3"
+    link_dir=3D"$4"
+
+    (
+        recursive_opt=3D""
+        directorytype_opt=3D""
+        if test x$recursive =3D xr; then
+            recursive_opts=3D"-mindepth 1"
+            directorytype_opt=3D"-type d -o"
+        else
+            recursive_opt=3D"-maxdepth 1"
+        fi
+        link_makefiles_opt=3D""
+        if test x$link_makefiles =3D xm; then
+            link_makefiles_opt=3D"-name Makefile -o"
+        fi
+
+        cd $xenomai_root/$target_dir &&
+        find . $recursive_opt \( $link_makefiles_opt -name Kconfig -o -n=
ame '*.[chS]' \) |
+        while read f; do
+            f=3D`echo $f | cut -d/ -f2-`
+            d=3D`dirname $f`
+            if test ! -d  $temp_tree/$link_dir/$d ; then
+                mkdir -p $temp_tree/$link_dir/$d
+            fi
+            cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+        done
+    )
+
+}
+
+generate_patch() {
+    (
+    cd "$temp_tree"
+    find . -name demos -o -name snippets -exec rm -fR {} \+ &&
+    find . -type f |
+    while read f ; do
+        diff -Naurd "$linux_tree/$f" "$f" |
+        sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
+            -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
+    done
+    )
+}
+
+diff_addons() {
+    lines=3D`cat $xenomai_root/scripts/Kconfig.frag | wc -l`
+
+    echo "--- linux/init/Kconfig	1970-01-01 01:00:00.000000000 +0100" >>=
 $patch_file
+    echo "+++ linux-patched/init/Kconfig	2007-03-06 17:55:58.000000000 +=
0000" >> $patch_file
+    echo "@@ -1400,0 +1400,$lines @@" >> $patch_file
+    sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.=
frag | sed 's/^/+/' >> $patch_file
+    echo " " >> $patch_file
+}
+
+xenomai_root=3D`dirname $0`/..
+xenomai_root=3D`cd $xenomai_root && pwd`
+
+rm -fR $xenomai_root/tmp
+rm -f $patch_file
+
+mkdir -p $xenomai_root/tmp/linux
+mkdir -p $xenomai_root/tmp/linux.new
+linux_tree=3D"$xenomai_root/tmp/linux"
+temp_tree=3D"$xenomai_root/tmp/linux.new"
+
+
+for linux_arch in $supported_arch ; do
+    case $linux_arch in
+        i386)
+            base_arch=3Dx86
+            ;;
+        x86_64)
+            base_arch=3Dx86
+            ;;
+        x86)
+            base_arch=3Dx86
+            ;;
+        *)
+            base_arch=3D$linux_arch
+            ;;
+    esac
+
+    patch_link r m ksrc/arch/$base_arch arch/$linux_arch/xenomai
+    patch_link r n include/asm-$base_arch arch/$linux_arch/include/asm/x=
enomai
+
+    p=3D"+drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_arch/xenomai/"
+    echo $p | patch_append arch/$linux_arch/Makefile
+    diff_addons
+done
+
+p=3D"+obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+echo $p | patch_append drivers/Makefile
+
+p=3D"+obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+echo $p | patch_append kernel/Makefile
+
+# Create local directories then symlink to the source files from
+# there, so that we don't pollute the Xenomai source tree with
+# compilation files.
+patch_link n m ksrc/ kernel/xenomai
+patch_link n m ksrc/arch kernel/xenomai/arch
+patch_link r m ksrc/arch/generic kernel/xenomai/arch/generic
+patch_link n m ksrc/nucleus kernel/xenomai/nucleus
+patch_link r m ksrc/skins kernel/xenomai/skins
+patch_link r m ksrc/drivers drivers/xenomai
+patch_link r n include/asm-generic include/asm-generic/xenomai
+patch_link n n include include/xenomai
+cd $xenomai_root
+for d in include/* ; do
+    if test -d $d -a -z "`echo $d | grep '^include/asm-'`"; then
+        destdir=3D`echo $d | sed -e 's,^\(include\)\(/.*\)$,\1/xenomai\2=
,'`
+        patch_link r n $d $destdir
+    fi
+done
+
+generate_patch >> $patch_file
+
+cd $xenomai_root
+
+#echo "Patch-name: Xenomai realtime kernel patches" > $xenomai_root/debi=
an/linux-patch-xenomai.kpatches
+#echo "Patch-id: xenomai" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
+#echo "Architecture: all" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
+
+find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patc=
h" |
+while read f ; do
+
+    file=3D`basename $f`
+    arch=3D`echo $file | cut -d- -f4`
+    kver=3D`echo $file | cut -d- -f3`
+
+    case $arch in
+        arm)
+            march=3Darm
+        ;;
+        i386)
+            march=3Di386
+        ;;
+        ppc|ppc64|powerpc)
+            march=3Dpowerpc
+        ;;
+        x86_64)
+            march=3Damd64
+        ;;
+	x86)
+	    march=3Di386
+	;;
+    esac
+
+    # Only one patch per arch/kver - Having a common plus kver/arch patc=
h
+    # would require two linux-patch-foo packages.. When dh-kpatches Ver.=
1.0
+    # gets to testing, this can be looked at again..
+    echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+    echo "Patch-file: $file" >> $xenomai_root/debian/linux-patch-xenomai=
=2Ekpatches
+    echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xen=
omai.kpatches
+    echo "Architecture: $march" >> $xenomai_root/debian/linux-patch-xeno=
mai.kpatches
+
+    if [ "$arch" =3D "x86" ] ; then
+	echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
+	echo "Patch-file: $file" >> $xenomai_root/debian/linux-patch-xenomai.kp=
atches
+	echo "Kernel-version: $kver" >> $xenomai_root/debian/linux-patch-xenoma=
i.kpatches
+	echo "Architecture: amd64" >> $xenomai_root/debian/linux-patch-xenomai.=
kpatches
+    fi
+
+    cp $f $xenomai_root/$file
+    cat $xenomai_root/$patch_file >> $xenomai_root/$file
+
+done
+
+exit 0
+
--=20
1.7.1


--------------050501060807000503030309--

--------------enigEEF474B6D925AA9617C900CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAkxusLYACgkQIPTw9rIdn6rq/QCfTPpmVq4M6NIlAcPvY28EAtE2
2YoAmJ6+/hOx/svVz/w6akZ2NFXm4cA=
=zAIV
-----END PGP SIGNATURE-----

--------------enigEEF474B6D925AA9617C900CA--


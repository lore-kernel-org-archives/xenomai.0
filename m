Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DA19D88C
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261245; cv=none; b=hm3AvB5dt2gJw0p8NnxaorIaCGULRI+DaFJ8L/uMRXbTqOLNUOaBn2WxVNzOayXAuU3qAs6AZa/JWw8oJ1IqpOIF/t8IXmJhwLx6PIOE6i4NN0ZNyOZpkJsidSwV5eH2TScGK6LxhPwJLRug1t0XNt2p3k30AXhi0tEyMua5OwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261245; c=relaxed/simple;
	bh=fN1Ww8H9n6f/gai5Z6mDfmvkPQ+TA0b/ff3oujkSoVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PT/8fNTXMsrLbU8BIcyOc4y4xCn7zW58jkCJYeqqGpg8x61d+MRiZaFJKpr0Y2hsSEAxTHX40B2OgOJx3yZzvbFwFkhb9zShZCePneilJbaJnKthU1WQZDmRWVvj/EhOW/zjTdHLmKy+jd3ksxksXXllpeKvB4rdYkKmybcD2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9C96C61F0AB9;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XSu1-rt2IPar; Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E90DD6195FD3;
	Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JAZoEjqbMf9f; Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id B748D61966B8;
	Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/14] prepare-kernel.sh: Convert to tabs
Date: Mon, 24 Jun 2024 22:33:28 +0200
Message-Id: <20240624203341.6263-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624203341.6263-1-richard@nod.at>
References: <20240624203341.6263-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the script used a mix of spaces of various lengths and tabs.
Let's use tabs everywhere.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 510 +++++++++++++++++++-------------------
 1 file changed, 253 insertions(+), 257 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index faf3e7235..9299aaa97 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -29,112 +29,110 @@ patch_architecture_filter=3D"b"
 linux_tree=3D.
=20
 patch_copytempfile() {
-    file=3D"$1"
-    if ! test -f "$temp_tree/$file"; then
-        subdir=3D`dirname "$file"`
-        mkdir -p "$temp_tree/$subdir"
-        cp "$linux_tree/$file" "$temp_tree/$file"
-    fi
+	file=3D"$1"
+	if ! test -f "$temp_tree/$file"; then
+		subdir=3D`dirname "$file"`
+		mkdir -p "$temp_tree/$subdir"
+		cp "$linux_tree/$file" "$temp_tree/$file"
+	fi
 }
=20
 check_filter() {
-    if test "$patch_kernelversion_specific" !=3D "$patch_kernelversion_f=
ilter" \
-        -a "$patch_architecture_specific" !=3D "$patch_architecture_filt=
er"; then
-        echo ok
-    elif test -e "$temp_tree/$1"; then
-        echo "$me: inconsistent multiple changes to $1 in Linux kernel t=
ree" >&2
-	echo error
-    else
-        echo ignore
-    fi
+	if test "$patch_kernelversion_specific" !=3D "$patch_kernelversion_filt=
er" \
+		-a "$patch_architecture_specific" !=3D "$patch_architecture_filter"; t=
hen
+		echo ok
+	elif test -e "$temp_tree/$1"; then
+		echo "$me: inconsistent multiple changes to $1 in Linux kernel tree" >=
&2
+		echo error
+	else
+		echo ignore
+	fi
 }
=20
 patch_append() {
-    file=3D"$1"
-    if test "x$output_patch" =3D "x"; then
-	if test -L "$linux_tree/$file" ; then
-	    mv "$linux_tree/$file" "$linux_tree/$file.orig"
-	    cp "$linux_tree/$file.orig" "$linux_tree/$file"
+	file=3D"$1"
+	if test "x$output_patch" =3D "x"; then
+		if test -L "$linux_tree/$file" ; then
+			mv "$linux_tree/$file" "$linux_tree/$file.orig"
+			cp "$linux_tree/$file.orig" "$linux_tree/$file"
+		fi
+		chmod +w "$linux_tree/$file"
+		cat >> "$linux_tree/$file"
+	else
+		if test `check_filter $file` =3D "ok"; then
+			patch_copytempfile "$file"
+			cat >> "$temp_tree/$file"
+		fi
 	fi
-	chmod +w "$linux_tree/$file"
-        cat >> "$linux_tree/$file"
-    else
-        if test `check_filter $file` =3D "ok"; then
-            patch_copytempfile "$file"
-            cat >> "$temp_tree/$file"
-        fi
-    fi
 }
=20
 patch_link() {
-    recursive=3D"$1"         # "r" or "n"
-    link_file=3D"$2"         # "m", "n" or some file (basename) from $ta=
rget_dir
-    target_dir=3D"$3"
-    link_dir=3D"$4"
-
-    (
-        if test \! \( x$link_file =3D xm -o x$link_file =3D xn \); then
-	   find_clean_opt=3D"-name $link_file"
-	   find_link_opt=3D$find_clean_opt
+	recursive=3D"$1"		   # "r" or "n"
+	link_file=3D"$2"		   # "m", "n" or some file (basename) from $target_di=
r
+	target_dir=3D"$3"
+	link_dir=3D"$4"
+
+	(
+	if test \! \( x$link_file =3D xm -o x$link_file =3D xn \); then
+		find_clean_opt=3D"-name $link_file"
+		find_link_opt=3D$find_clean_opt
 	else
-           link_makefiles_opt=3D""
-           if test x$link_file =3D xm; then
-              link_makefiles_opt=3D"-name Makefile -o"
-           fi
-           if test x$recursive =3D xr; then
-	       recursive_opt=3D"-mindepth 1"
-	       dir_opt=3D"-type d -o"
-           else
-	       recursive_opt=3D"-maxdepth 1"
-	       dir_opt=3D""
-           fi
-	   find_clean_opt=3D"$recursive_opt \( $dir_opt $link_makefiles_opt -na=
me Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
-	   find_link_opt=3D"$recursive_opt \( $link_makefiles_opt -name Kconfig=
 -o -name '*.[chS]' -o -name '*.sh' \)"
+		link_makefiles_opt=3D""
+		if test x$link_file =3D xm; then
+			link_makefiles_opt=3D"-name Makefile -o"
+		fi
+		if test x$recursive =3D xr; then
+			recursive_opt=3D"-mindepth 1"
+			dir_opt=3D"-type d -o"
+		else
+			recursive_opt=3D"-maxdepth 1"
+			dir_opt=3D""
+		fi
+		find_clean_opt=3D"$recursive_opt \( $dir_opt $link_makefiles_opt -name=
 Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
+		find_link_opt=3D"$recursive_opt \( $link_makefiles_opt -name Kconfig -=
o -name '*.[chS]' -o -name '*.sh' \)"
 	fi
=20
-        if test "x$output_patch" =3D "x" -a -e $linux_tree/$link_dir; th=
en
-            cd $linux_tree/$link_dir &&
-	    eval find . $find_clean_opt |
-	    while read f; do
-                if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then=
 rm -Rf $f; fi
-            done
-        fi
-
-        cd $xenomai_root/$target_dir &&
-        eval find . $find_link_opt |
-        while read f; do
-            f=3D`echo $f | cut -d/ -f2-`
-            d=3D`dirname $f`
-            if test "x$output_patch" =3D "x"; then
-                mkdir -p $linux_tree/$link_dir/$d
-                if test x$forcelink =3D x1 -o \
-		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
-		then
-                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$lin=
k_dir/$f
-                fi
-            else
-                if test `check_filter $link_dir/$f` =3D "ok"; then
-                    if test -e $linux_tree/$link_dir/$f; then
-                        echo "$me: warning: $link_dir/$f already present=
 in Linux kernel tree, output patch might be defective" >&2
-                    fi
-                    mkdir -p $temp_tree/$link_dir/$d
-                    cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir=
/$f
-                fi
-            fi
-        done
-    )
+	if test "x$output_patch" =3D "x" -a -e $linux_tree/$link_dir; then
+		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f=
; do
+			if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; f=
i
+		done
+	fi
+
+	cd $xenomai_root/$target_dir &&
+	eval find . $find_link_opt |
+	while read f; do
+		f=3D`echo $f | cut -d/ -f2-`
+		d=3D`dirname $f`
+		if test "x$output_patch" =3D "x"; then
+			mkdir -p $linux_tree/$link_dir/$d
+			if test x$forcelink =3D x1 -o \
+				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
+			then
+				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+			fi
+		else
+			if test `check_filter $link_dir/$f` =3D "ok"; then
+				if test -e $linux_tree/$link_dir/$f; then
+					echo "$me: warning: $link_dir/$f already present in Linux kernel tr=
ee, output patch might be defective" >&2
+				fi
+				mkdir -p $temp_tree/$link_dir/$d
+				cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
+			fi
+		fi
+	done
+	)
 }
=20
 generate_patch() {
-    (
-    cd "$temp_tree"
-    find . -type f |
-    while read f; do
-        diff -Naurd "$linux_tree/$f" "$f" |
-        sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
-            -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
-    done
-    )
+	(
+	cd "$temp_tree"
+	find . -type f |
+	while read f; do
+		diff -Naurd "$linux_tree/$f" "$f" |
+		sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
+			-e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
+	done
+	)
 }
=20
=20
@@ -142,49 +140,49 @@ usage=3D'usage: prepare-kernel --linux=3D<linux-tre=
e> [--dovetail=3D<dovetail-patch>]
 me=3D`basename $0`
=20
 while test $# -gt 0; do
-    case "$1" in
-    --linux=3D*)
-	linux_tree=3D`echo $1|sed -e 's,^--linux=3D\\(.*\\)$,\\1,g'`
-	linux_tree=3D`eval "echo $linux_tree"`
+	case "$1" in
+	--linux=3D*)
+		linux_tree=3D`echo $1|sed -e 's,^--linux=3D\\(.*\\)$,\\1,g'`
+		linux_tree=3D`eval "echo $linux_tree"`
 	;;
-    --dovetail=3D*)
-	pipeline_patch=3D`echo $1|sed -e 's,^--dovetail=3D\\(.*\\)$,\\1,g'`
-	pipeline_patch=3D`eval "echo $pipeline_patch"`
-	probe_header=3Dinclude/linux/dovetail.h
-	arch_probe_header=3Dinclude/asm/dovetail.h
+	--dovetail=3D*)
+		pipeline_patch=3D`echo $1|sed -e 's,^--dovetail=3D\\(.*\\)$,\\1,g'`
+		pipeline_patch=3D`eval "echo $pipeline_patch"`
+		probe_header=3Dinclude/linux/dovetail.h
+		arch_probe_header=3Dinclude/asm/dovetail.h
 	;;
-    --arch=3D*)
-	linux_arch=3D`echo $1|sed -e 's,^--arch=3D\\(.*\\)$,\\1,g'`
+	--arch=3D*)
+		linux_arch=3D`echo $1|sed -e 's,^--arch=3D\\(.*\\)$,\\1,g'`
 	;;
-    --outpatch=3D*)
-	output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
+	--outpatch=3D*)
+		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
 	;;
-    --filterkvers=3D*)
-        patch_kernelversion_filter=3D`echo $1|sed -e 's,^--filterkvers=3D=
\\(.*\\)$,\\1,g'`
-        ;;
-    --filterarch=3D*)
-        patch_architecture_filter=3D`echo $1|sed -e 's,^--filterarch=3D\=
\(.*\\)$,\\1,g'`
-        ;;
-    --forcelink)
-        forcelink=3D1
-        ;;
-    --default)
-        usedefault=3D1
-        ;;
-    --verbose)
-	verbose=3D1
+	--filterkvers=3D*)
+		patch_kernelversion_filter=3D`echo $1|sed -e 's,^--filterkvers=3D\\(.*=
\\)$,\\1,g'`
+		;;
+	--filterarch=3D*)
+		patch_architecture_filter=3D`echo $1|sed -e 's,^--filterarch=3D\\(.*\\=
)$,\\1,g'`
+		;;
+	--forcelink)
+		forcelink=3D1
+		;;
+	--default)
+		usedefault=3D1
+		;;
+	--verbose)
+		verbose=3D1
 	;;
-    --help)
-	echo "$usage"
-	exit 0
+	--help)
+		echo "$usage"
+		exit 0
 	;;
-    *)
-	echo "$me: unknown flag: $1" >&2
-	echo "$usage" >&2
-	exit 1
+	*)
+		echo "$me: unknown flag: $1" >&2
+		echo "$usage" >&2
+		exit 1
 	;;
-    esac
-    shift
+	esac
+	shift
 done
=20
 # Infere the location of the Xenomai source tree from
@@ -199,87 +197,86 @@ xenomai_root=3D`cd $xenomai_root && pwd`
 default_linux_tree=3D/lib/modules/`uname -r`/source
=20
 while test x$linux_tree =3D x; do
-   if test x$usedefault =3D x; then
-      echo -n "Linux tree [default $default_linux_tree]: "
-      read linux_tree
-   fi
-   if test x$linux_tree =3D x; then
-      linux_tree=3D$default_linux_tree
-   fi
-   if test \! -x "$linux_tree"; then
-      echo "$me: cannot access Linux tree in $linux_tree"
-      linux_tree=3D
-      usedefault=3D
-      default_linux_tree=3D/usr/src
-   else
-      break
-   fi
+	if test x$usedefault =3D x; then
+		echo -n "Linux tree [default $default_linux_tree]: "
+		read linux_tree
+	fi
+	if test x$linux_tree =3D x; then
+		linux_tree=3D$default_linux_tree
+	fi
+	if test \! -x "$linux_tree"; then
+		echo "$me: cannot access Linux tree in $linux_tree"
+		linux_tree=3D
+		usedefault=3D
+		default_linux_tree=3D/usr/src
+	else
+		break
+	fi
 done
=20
 linux_tree=3D`cd $linux_tree && pwd`
=20
 if test \! -r $linux_tree/Makefile; then
-   echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
-   exit 2
+	echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
+	exit 2
 fi
=20
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" !=3D "x"; then
+	temp_tree=3D`mktemp -d prepare-kernel-XXX --tmpdir`
+	if [ $? -ne 0 ]; then
+		echo Temporary directory could not be created.
+		exit 1
+	fi
=20
-    temp_tree=3D`mktemp -d prepare-kernel-XXX --tmpdir`
-    if [ $? -ne 0 ]; then
-	echo Temporary directory could not be created.
-	exit 1
-    fi
-
-    patchdir=3D`dirname $output_patch`
-    patchdir=3D`cd $patchdir && pwd`
-    output_patch=3D$patchdir/`basename $output_patch`
-    echo > "$output_patch"
+	patchdir=3D`dirname $output_patch`
+	patchdir=3D`cd $patchdir && pwd`
+	output_patch=3D$patchdir/`basename $output_patch`
+	echo > "$output_patch"
=20
 fi
=20
 # Infer the default architecture if unspecified.
=20
 if test x$linux_arch =3D x; then
-   build_arch=3D`$xenomai_root/config/config.guess`
-   default_linux_arch=3D`echo $build_arch|cut -f1 -d-`
+	build_arch=3D`$xenomai_root/config/config.guess`
+	default_linux_arch=3D`echo $build_arch|cut -f1 -d-`
 fi
=20
 while : ; do
-   if test x$linux_arch =3D x; then
-      if test x$usedefault =3D x; then
-         echo -n "Target architecture [default $default_linux_arch]: "
-         read linux_arch
-      fi
-      if test "x$linux_arch" =3D x; then
-         linux_arch=3D$default_linux_arch
-      fi
-   fi
-   case "$linux_arch" in
-   x86*|i*86|amd*)
-      linux_arch=3Dx86
-      ;;
-   arm)
-      linux_arch=3Darm
-      ;;
-   arm64|aarch64)
-      linux_arch=3Darm64
-      ;;
-   *)
-      echo "$me: unsupported architecture: $linux_arch" >&2
-      linux_arch=3D
-      usedefault=3D
-      ;;
-   esac
-   if test \! x$linux_arch =3D x; then
-      break
-   fi
+	if test x$linux_arch =3D x; then
+		if test x$usedefault =3D x; then
+			echo -n "Target architecture [default $default_linux_arch]: "
+			read linux_arch
+		fi
+		if test "x$linux_arch" =3D x; then
+			linux_arch=3D$default_linux_arch
+		fi
+	fi
+	case "$linux_arch" in
+		x86*|i*86|amd*)
+		linux_arch=3Dx86
+	;;
+	arm)
+		linux_arch=3Darm
+	;;
+	arm64|aarch64)
+		linux_arch=3Darm64
+	;;
+	*)
+		echo "$me: unsupported architecture: $linux_arch" >&2
+		linux_arch=3D
+		usedefault=3D
+	;;
+	esac
+	if test \! x$linux_arch =3D x; then
+		break
+	fi
 done
=20
-foo=3D`grep '^KERNELSRC    :=3D ' $linux_tree/Makefile | cut -d=3D -f2`
+foo=3D`grep '^KERNELSRC	 :=3D ' $linux_tree/Makefile | cut -d=3D -f2`
 if [ ! -z $foo ] ; then
-    linux_tree=3D$foo
+	linux_tree=3D$foo
 fi
 unset foo
=20
@@ -291,101 +288,100 @@ eval linux_`grep '^VERSION =3D' $linux_tree/Makef=
ile | sed -e 's, ,,g'`
 linux_version=3D"$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
=20
 if test x$verbose =3D x1; then
-echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree.=
.."
+	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree=
..."
 fi
=20
 if test -r $linux_tree/$probe_header; then
-    if test x$verbose =3D x1; then
-       echo "IRQ pipeline found - bypassing patch."
-    fi
+	if test x$verbose =3D x1; then
+		echo "IRQ pipeline found - bypassing patch."
+	fi
 else
-   if test x$verbose =3D x1; then
-      echo "$me: no IRQ pipeline support found." >&2
-   fi
-   while test x$pipeline_patch =3D x; do
-      echo -n "IRQ pipeline patch: "
-      read pipeline_patch
-      if test \! -r "$pipeline_patch" -o x$pipeline_patch =3D x; then
-         echo "$me: cannot read IRQ pipeline support from $pipeline_patc=
h" >&2
-         pipeline_patch=3D
-      fi
-   done
-   patchdir=3D`dirname $pipeline_patch`;
-   patchdir=3D`cd $patchdir && pwd`
-   pipeline_patch=3D$patchdir/`basename $pipeline_patch`
-   curdir=3D$PWD
-   cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
-        cd $curdir;
-        echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERS=
ION with `basename $pipeline_patch`." >&2
-        exit 2;
-   }
-   patch -p1 -f -s < $pipeline_patch
-   cd $curdir
+	if test x$verbose =3D x1; then
+		echo "$me: no IRQ pipeline support found." >&2
+	fi
+	while test x$pipeline_patch =3D x; do
+		echo -n "IRQ pipeline patch: "
+		read pipeline_patch
+		if test \! -r "$pipeline_patch" -o x$pipeline_patch =3D x; then
+			echo "$me: cannot read IRQ pipeline support from $pipeline_patch" >&2
+			pipeline_patch=3D
+		fi
+	done
+	patchdir=3D`dirname $pipeline_patch`;
+	patchdir=3D`cd $patchdir && pwd`
+	pipeline_patch=3D$patchdir/`basename $pipeline_patch`
+	curdir=3D$PWD
+	cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
+		cd $curdir;
+		echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION wi=
th `basename $pipeline_patch`." >&2
+		exit 2;
+	}
+	patch -p1 -f -s < $pipeline_patch
+	cd $curdir
 fi
=20
 if test \! -r $linux_tree/arch/$linux_arch/$arch_probe_header; then
-   echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >=
&2
-   exit 2
+	echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >&2
+	exit 2
 fi
=20
 if test x$verbose =3D x1; then
-   echo "IRQ pipeline installed."
+	echo "IRQ pipeline installed."
 fi
=20
 patch_kernelversion_specific=3D"y"
=20
 case $linux_VERSION.$linux_PATCHLEVEL in
=20
-    2.*)
+	2.*)
=20
-    echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEV=
EL.x" >&2
-    exit 2
-    ;;
+	echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.=
x" >&2
+	exit 2
+	;;
=20
-    *)
+	*)
=20
-    patch_architecture_specific=3D"y"
+	patch_architecture_specific=3D"y"
=20
-    if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
-	version_stamp=3D`cat $xenomai_root/config/version-code`
-	version_major=3D`expr $version_stamp : '\([[0-9]]*\)' || true`
-	version_minor=3D`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || tru=
e`
-	revision_level=3D`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*=
]*\)' || true`
+	if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
+		version_stamp=3D`cat $xenomai_root/config/version-code`
+		version_major=3D`expr $version_stamp : '\([[0-9]]*\)' || true`
+		version_minor=3D`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || tr=
ue`
+		revision_level=3D`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]=
*]*\)' || true`
 	if [ -z "$revision_level" ]; then
-	    revision_level=3D0
+		revision_level=3D0
 	fi
 	version_string=3D`cat $xenomai_root/config/version-label`
 	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
-	    -e "s,@VERSION_MINOR@,$version_minor,g" \
-	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
-	    -e "s,@VERSION_STRING@,$version_string,g" \
-	    -e "s,@SRCARCH@,$linux_arch,g" \
-	    $xenomai_root/scripts/Kconfig.frag |
-            patch_append init/Kconfig
-    fi
+		-e "s,@VERSION_MINOR@,$version_minor,g" \
+		-e "s,@REVISION_LEVEL@,$revision_level,g" \
+		-e "s,@VERSION_STRING@,$version_string,g" \
+		-e "s,@SRCARCH@,$linux_arch,g" \
+		$xenomai_root/scripts/Kconfig.frag |
+		patch_append init/Kconfig
+	fi
=20
 test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LEVE=
L=3D0
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; t=
hen
-	p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include =
-I\$(srctree)/include/xenomai"
-	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-	p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
-	echo $p | patch_append arch/$linux_arch/Makefile
-    fi
-
-    patch_architecture_specific=3D"n"
+	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
+		p=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include=
 -I\$(srctree)/include/xenomai"
+		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
+		p=3D"core-\$(CONFIG_XENOMAI)	+=3D arch/$linux_arch/xenomai/"
+		echo $p | patch_append arch/$linux_arch/Makefile
+	fi
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
-	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-	( echo ; echo $p ) | patch_append drivers/Makefile
-    fi
+	patch_architecture_specific=3D"n"
=20
-    if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
-	p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
-	( echo ; echo $p ) | patch_append kernel/Makefile
-    fi
-    ;;
+	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
+		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+		( echo ; echo $p ) | patch_append drivers/Makefile
+	fi
=20
+	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
+		p=3D"obj-\$(CONFIG_XENOMAI)		+=3D xenomai/"
+		( echo ; echo $p ) | patch_append kernel/Makefile
+	fi
+	;;
 esac
=20
 # Create local directories then symlink to the source files from
@@ -415,16 +411,16 @@ patch_link n version.h include/xenomai include/xeno=
mai
 patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
=20
 if test "x$output_patch" !=3D "x"; then
-    if test x$verbose =3D x1; then
-    echo 'Generating patch.'
-    fi
-    generate_patch > "$output_patch"
-    rm -rf $temp_tree
+	if test x$verbose =3D x1; then
+		echo 'Generating patch.'
+	fi
+	generate_patch > "$output_patch"
+	rm -rf $temp_tree
 fi
=20
 if test x$verbose =3D x1; then
-echo 'Links installed.'
-echo 'Build system ready.'
+	echo 'Links installed.'
+	echo 'Build system ready.'
 fi
=20
 exit 0
--=20
2.35.3


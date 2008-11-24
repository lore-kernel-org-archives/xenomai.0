Message-ID: <492AB8CA.1060208@domain.hid>
Date: Mon, 24 Nov 2008 09:23:06 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <d6c8ef150811240529x137a591fjd9f5c530dc501d63@domain.hid>
In-Reply-To: <d6c8ef150811240529x137a591fjd9f5c530dc501d63@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] copying instead of symlinking
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
> Hi all,
> 
> is there an "official" way of "preparing" kernel with copying
> xenomai/ksrc files instead of symlinking them into kernel dir?
> 
> Thanks
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 

I don't know about an official way, but I too wanted to copy the files,
so that I could keep the modified kernel in a git branch.  Attached is a
patch to the prepare-kernel.sh script that I use.  You will see that
there is a new option (--root) which I needed because I also don't want
to infer the root directory from the path to the script.

	Steve

--- xenomai-2.4.5/scripts/prepare-kernel.sh	2008-05-15 03:45:41.000000000 -0400
+++ prepare-kernel.sh	2008-05-23 14:27:20.000000000 -0400
@@ -116,7 +116,8 @@
                 if test x$forcelink = x1 -o \
 		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
 		then
-                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+                    # ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
+                    cp -f $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
                 fi
             else
                 if test `check_filter $link_dir/$f` = "ok"; then
@@ -173,6 +174,10 @@
 
 while test $# -gt 0; do
     case "$1" in
+    --root=*)
+        xenomai_root=`echo $1|sed -e 's,^--root=\\(.*\\)$,\\1,g'`
+	xenomai_root=`eval "echo $xenomai_root"`
+        ;;
     --linux=*)
 	linux_tree=`echo $1|sed -e 's,^--linux=\\(.*\\)$,\\1,g'`
 	linux_tree=`eval "echo $linux_tree"`
@@ -217,11 +222,6 @@
     shift
 done
 
-# Infere the location of the Xenomai source tree from
-# the path of the current script.
-
-script_path=`type -p $0`
-xenomai_root=`dirname $script_path`/..
 xenomai_root=`cd $xenomai_root && pwd`
 
 # Check the Linux tree
@@ -327,7 +327,6 @@
    *)
       echo "$me: unsupported architecture: $linux_arch" >&2
       linux_arch=
-      usedefault=
       ;;
    esac
    if test \! x$linux_arch = x; then
@@ -385,7 +384,6 @@
       fi
       if test \! -r "$adeos_patch"; then
          echo "$me: cannot read Adeos patch from $adeos_patch" >&2
-         usedefault=
          adeos_patch=
       fi
    done
@@ -582,7 +580,7 @@
 fi
 
 if test x$verbose = x1; then
-echo 'Links installed.'
+echo 'Files copied.'
 echo 'Build system ready.'
 fi
 


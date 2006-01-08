Message-ID: <43C166BB.4030606@domain.hid>
Date: Sun, 08 Jan 2006 20:23:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
References: <17343.42595.626357.181448@domain.hid>	<43C100A2.6040605@domain.hid>	<17345.3786.644399.982109@domain.hid>	<43C11EEB.8040003@domain.hid>
	<17345.17403.927352.223271@domain.hid>
In-Reply-To: <17345.17403.927352.223271@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > The current approach is to use the sources of the running kernel if the
>  > > only option specified is --enable-linux-build. Do you mean you find this
>  > > feature superfluous ?
>  > > 
>  > 
>  > If $enableval is "y", then no path has been specified, so you can 
>  > default to the running kernel in such a case.
> 
> Here is a third version of the patch, where :
> * the --enable-sim option is removed
> * the --with-linux-srcdir option is removed
> * the CC variable is passed to kernel build system
> * prepare-kernel.sh no longer removes target directories before
>   creating symbolic links.
> 
> 

This is needed for creating links in a new kernel for the fist time:

--- scripts/prepare-kernel.sh~  2006-01-08 20:14:05.000000000 +0100
+++ scripts/prepare-kernel.sh   2006-01-08 20:19:41.000000000 +0100
@@ -2,11 +2,12 @@
  set -e

  do_links() {
-    ( cd $2 &&
+    ( if test -x $2; then
+      cd $2 &&
        find . \( -name Makefile -o -name $config_file -o -name '*.[chS]' \) |
        while read f; do
          if test ! -e $1/$f; then rm -f $f; fi
-      done &&
+      done; else true; fi &&
        cd $1 &&
        find . \( -name Makefile -o -name $config_file -o -name '*.[chS]' \) |
        while read f; do


-- 

Philippe.


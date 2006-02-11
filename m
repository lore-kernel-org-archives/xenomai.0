Message-ID: <43EE1C9F.9070202@domain.hid>
Date: Sat, 11 Feb 2006 18:19:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] tweak scripts/prepare-kernel.sh to work
	with	O=../linux-output
References: <43E87C56.8040100@domain.hid>
In-Reply-To: <43E87C56.8040100@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> hi folks,
> 
> with this patch, you can run prepare-kernel.sh on a kernel output tree,
> at least once that tree contains the Makefile that the script looks for.
> 

Applied, thanks.

> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: scripts/prepare-kernel.sh
> ===================================================================
> --- scripts/prepare-kernel.sh	(revision 550)
> +++ scripts/prepare-kernel.sh	(working copy)
> @@ -74,13 +74,14 @@
>  done
>  
>  linux_tree=`cd $linux_tree && pwd`
> +linux_out=$linux_tree
>  
>  if test \! -r $linux_tree/Makefile; then
>     echo "$me: $linux_tree is not a valid Linux kernel tree"
>     exit 2
>  fi
>  
> -# Infere the default architecture if unspecified.
> +# Infer the default architecture if unspecified.
>  
>  if test x$linux_arch = x; then
>     build_arch=`$xenomai_root/config/config.guess`
> @@ -144,6 +145,12 @@
>     linux_arch=blackfin
>  fi
>  
> +foo=`grep '^KERNELSRC    := ' $linux_tree/Makefile | cut -d= -f2`
> +if [ ! -z $foo ] ; then
> +    linux_tree=$foo
> +fi
> +unset foo
> +
>  eval linux_`grep '^EXTRAVERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
>  eval linux_`grep '^PATCHLEVEL =' $linux_tree/Makefile | sed -e 's, ,,g'`
>  eval linux_`grep '^SUBLEVEL =' $linux_tree/Makefile | sed -e 's, ,,g'`
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.


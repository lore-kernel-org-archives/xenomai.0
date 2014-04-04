Message-ID: <533F0FDE.9010009@xenomai.org>
Date: Fri, 04 Apr 2014 22:02:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgnR1aU-A6KDq7uRCKqV0=sj8yoQE_zUeiVdxmemdfnyMQ@mail.gmail.com>
 <533E7855.3090309@xenomai.org>
 <CAEbDrgm-7SvkR1hgfuYvGKTnP_RxBP1uYbxzbcSsYaUadVx3=w@mail.gmail.com>
 <CAEbDrgn8xuqU92XSkzr7Ry=mrev6-vZbe=x5HW6f_N3WZy2fKw@mail.gmail.com>
In-Reply-To: <CAEbDrgn8xuqU92XSkzr7Ry=mrev6-vZbe=x5HW6f_N3WZy2fKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [patch] prepare_kernel.sh --board argument
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/04/2014 05:42 PM, Gregory Dymarek wrote:
> New patch below.
> Changes:
> - wrap the ipipe apply patch piece with a for loop that splits the
> ipipe_patch variable by comma and new line
> 
> 
> diff -rupN xenomai-2.6.3.orig/scripts/prepare-kernel.sh
> xenomai-2.6.3/scripts/prepare-kernel.sh
> --- xenomai-2.6.3.orig/scripts/prepare-kernel.sh        2013-05-25
> 14:44:03.000000000 +0100
> +++ xenomai-2.6.3/scripts/prepare-kernel.sh     2014-04-04
> 16:38:38.490435289 +0100
> @@ -403,16 +403,21 @@ else
>           ipipe_patch=
>        fi
>     done
> -   patchdir=`dirname $ipipe_patch`;
> -   patchdir=`cd $patchdir && pwd`
> -   ipipe_patch=$patchdir/`basename $ipipe_patch`
> -   curdir=$PWD
> -   cd $linux_tree && patch --dry-run -p1 -f < $ipipe_patch || {
> -        cd $curdir;
> -        echo "$me: Unable to patch kernel
> $linux_version$linux_EXTRAVERSION with `basename $ipipe_patch`." >&2
> -        exit 2;
> -   }
> -   patch -p1 -f -s < $ipipe_patch
> +   startdir=`pwd`
> +   for patch in $(echo $ipipe_patch | tr "," "\n")

Just a minor nit, $() is not used anywhere else in the script, and is
not strictly necessary here, you may use ``

> +   do
> +          cd $startdir
> +          patchdir=`dirname $patch`;  #relative dir
> +          patchdir=`cd $patchdir && pwd`; #absolute dir
> +          patch=$patchdir/`basename $patch`
> +          curdir=$PWD
> +          cd $linux_tree && patch --dry-run -p1 -f < $patch || {
> +               cd $curdir;
> +               echo "$me: Unable to patch kernel
> $linux_version$linux_EXTRAVERSION with `basename $patch`." >&2
> +               exit 2;
> +          }
> +          patch -p1 -f -s < $patch

That is not really correct. The point of running patch --dry-run is to
avoid leaving the code in a state where the patch is half-applied. By
applying some patches and stopping if patch --dry-run fails for some
other patch, this is exactly what you do. Note that I do not know how to
solve this, though.


-- 
                                                                Gilles.


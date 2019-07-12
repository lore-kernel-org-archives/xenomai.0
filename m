Subject: Re: [PATCH] prepare-kernal.sh: Add --copylinks option
References: <20190611105947.15478-1-johannes.kirchmair@sigmatek.at>
 <AM0PR08MB333013CCB8EB426A8595A85692F20@AM0PR08MB3330.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e38df8f5-505e-9939-77f3-7da6d750d66e@siemens.com>
Date: Fri, 12 Jul 2019 12:22:49 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR08MB333013CCB8EB426A8595A85692F20@AM0PR08MB3330.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.07.19 09:41, Johannes Kirchmair via Xenomai wrote:
> Hello everyone,
> 
> just a ping to see if anyone has any remarks about this patch.

Sorry, slipped through.

> 
> Best regards 
> Johannes Kirchmair
> 
> -----Ursprüngliche Nachricht-----
> Von: Johannes Kirchmair <johannes.kirchmair@sigmatek.at> 
> Gesendet: Dienstag, 11. Juni 2019 13:01
> An: xenomai@xenomai.org
> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Betreff: [PATCH] prepare-kernal.sh: Add --copylinks option
> 
> The prepare-kernal.sh script by default adds the xenomai kernel components to the kernel source using soft links.
> If you move/remove the xenomai source or move the patched kernel source to another workstation, you must change all this links or even replace them by the actual files.
> To simplify the deployment of the patched kernel source to our coworkers, we added the –copylinks option to the prepare-kernal.sh.
> The option causes the prepare-kernal.sh to copy the xenomai kernel components instead of linking them.
> This makes it easy to move the patched kernel source to different locations.
> Further, having the actual files in the kernel source makes the use of tools like git grep that do not follow symbolic links by default more convenient.
> E.g. it gets harder to miss symbols searched with git grep by accident.

What's the differentiation to using --outpatch

> 
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  scripts/prepare-kernel.sh | 47 +++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh index e88a9a757..b8cc5f6c1 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -84,6 +84,14 @@ patch_link() {
>      target_dir="$3"
>      link_dir="$4"
>  
> +
> +	if test "x$5" = "x"
> +	then
> +		ln_cmd="ln -sf"
> +	else
> +		ln_cmd="cp -f"
> +	fi
> +
>      (
>          if test \! \( x$link_file = xm -o x$link_file = xn \); then
>  	   find_clean_opt="-name $link_file"
> @@ -122,7 +130,7 @@ patch_link() {
>                  if test x$forcelink = x1 -o \
>  		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
>  		then
> -                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +                    $ln_cmd $xenomai_root/$target_dir/$f 
> + $linux_tree/$link_dir/$f
>                  fi
>              else
>                  if test `check_filter $link_dir/$f` = "ok"; then @@ -150,6 +158,8 @@ generate_patch() {
>  usage='usage: prepare-kernel --linux=<linux-tree> --ipipe=<ipipe-patch> [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
>  me=`basename $0`
>  
> +copylinks=""
> +
>  while test $# -gt 0; do
>      case "$1" in
>      --linux=*)
> @@ -182,6 +192,9 @@ while test $# -gt 0; do
>      --default)
>          usedefault=1
>          ;;
> +	--copylinks)
> +		copylinks="1"
> +		;;
>      --verbose)
>  	verbose=1
>  	;;
> @@ -416,23 +429,23 @@ esac
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
> -patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai -patch_link n n kernel/cobalt/include/ipipe arch/$linux_arch/include/ipipe
> +patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai 
> +$copylinks patch_link n n kernel/cobalt/include/ipipe 
> +arch/$linux_arch/include/ipipe $copylinks
>  patch_architecture_specific="n"
> -patch_link n m kernel/cobalt kernel/xenomai -patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events -patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events -patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events -patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xenomai -patch_link r n kernel/cobalt/include/linux/xenomai include/linux/xenomai -patch_link n m kernel/cobalt/posix kernel/xenomai/posix -patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm -patch_link r m kernel/drivers drivers/xenomai -patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm -patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi -patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi -patch_link n version.h include/xenomai include/xenomai
> +patch_link n m kernel/cobalt kernel/xenomai $copylinks patch_link n 
> +cobalt-core.h kernel/cobalt/trace include/trace/events $copylinks 
> +patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events 
> +$copylinks patch_link n cobalt-posix.h kernel/cobalt/trace 
> +include/trace/events $copylinks patch_link r n 
> +kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xenomai 
> +$copylinks patch_link r n kernel/cobalt/include/linux/xenomai 
> +include/linux/xenomai $copylinks patch_link n m kernel/cobalt/posix 
> +kernel/xenomai/posix $copylinks patch_link n m kernel/cobalt/rtdm 
> +kernel/xenomai/rtdm $copylinks patch_link r m kernel/drivers 
> +drivers/xenomai $copylinks patch_link n n include/cobalt/kernel 
> +include/xenomai/cobalt/kernel $copylinks patch_link r n 
> +include/cobalt/kernel/rtdm include/xenomai/rtdm $copylinks patch_link r 
> +n include/cobalt/uapi include/xenomai/cobalt/uapi $copylinks patch_link 
> +r n include/rtdm/uapi include/xenomai/rtdm/uapi $copylinks patch_link n 
> +version.h include/xenomai include/xenomai $copylinks
>  

If we add that feature, then it's probably better controlled via a global variable.

Jan

>  if test "x$output_patch" != "x"; then
>      if test x$verbose = x1; then
> --
> 2.17.1
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


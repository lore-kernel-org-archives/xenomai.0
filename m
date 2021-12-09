Subject: Re: [xenomai-images] [PATCH 1/1] Changes to support sbuild-based Isar
References: <20211209073619.17698-1-ubely@ilbers.de>
 <20211209073619.17698-2-ubely@ilbers.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <094d5cdf-0528-009b-28ba-0241116f3d86@siemens.com>
Date: Thu, 9 Dec 2021 10:35:16 +0100
MIME-Version: 1.0
In-Reply-To: <20211209073619.17698-2-ubely@ilbers.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Uladzimir Bely <ubely@ilbers.de>, xenomai@xenomai.org

On 09.12.21 08:36, Uladzimir Bely via Xenomai wrote:
> These patch is required to build Isar from 'ubely/sbuild' branch,
> e.g. refspec: 37a71e72c7b8e9ae7e9f6a402ecdc6ff66eab8c4
> 
> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> ---
>  recipes-kernel/linux/linux-xenomai.inc | 14 ++++++++------
>  recipes-xenomai/xenomai/xenomai.inc    |  4 +---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 1852bf6..d68c7a1 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -28,7 +28,7 @@ def get_commit(d):
>  
>  LINUX_COMMIT ?= "${@get_commit(d)}"
>  
> -dpkg_runbuild_prepend() {
> +dpkg_configure_kernel_append() {
>  	case ${DISTRO_ARCH} in
>  	armhf)
>  		ARCH=arm
> @@ -46,9 +46,11 @@ dpkg_runbuild_prepend() {
>  	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
>  			 ${PV} ${LINUX_COMMIT})
>  
> -	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
> -		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
> -		--outpatch=${WORKDIR}/xenomai-kernel.patch
> -	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
> -		-p1 -i ${WORKDIR}/xenomai-kernel.patch
> +    SBUILD_PREBUILD="${SBUILD_PREBUILD} &&                          \
> +        touch /home/builder/${PN}/file.touch &&                     \
> +        /usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh    \
> +            --linux=%p --arch=${ARCH}                               \
> +            --outpatch=/home/builder/${PN}/xenomai-kernel.patch &&  \
> +        patch -d %p -p1 -i /home/builder/${PN}/xenomai-kernel.patch \
> +    "

Inconsistent indention.

>  }
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index 8f13767..454dd7b 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -41,7 +41,5 @@ do_prepare_build() {
>  dpkg_runbuild_prepend() {
>      bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>                       ${PV} ${COMMIT})
> -
> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> +    SBUILD_PREBUILD="cd %p; scripts/bootstrap"

Could we rather provide an abstract interface to users, not carrying
SBUILD in its name? I'm concerned that the current will make it hard to
switch builders in the future if we may have to.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


Subject: Re: [xenomai-images][PATCH 1/1] kernel/linux: Add git commit sha to
 build
References: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
 <20191014132840.27249-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0f5758a1-abc4-1699-8e1e-71c0b4ef119e@siemens.com>
Date: Mon, 14 Oct 2019 15:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20191014132840.27249-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 14.10.19 15:28, Q. Gylstorff via Xenomai wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For debugging purposes print the commit sha used by the build.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/linux-xenomai.inc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index d93e614..bdf51f7 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -18,6 +18,7 @@ SRC_URI += "file://${KERNEL_DEFCONFIG}"
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source"
>  
> +LINUX_COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
>  dpkg_runbuild_prepend() {
>  	case ${DISTRO_ARCH} in
>  	armhf)
> @@ -33,6 +34,9 @@ dpkg_runbuild_prepend() {
>  		bberror "Unsupported architecture ${DISTRO_ARCH}"
>  		exit 1
>  	esac
> +    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
> +                     ${PV} ${LINUX_COMMIT})
> +
>  
>  	sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>  		/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
> 

In fact, I would also like to see the test target reporting its Xenomai
and I-pipe version.

For the build: Let's add such reporting to linux-xenomai_latest and
switch the other recipes to carry the I-pipe release in their version
name, linux-xenomai_4.19.55-arm64-4. Or will that collide with a recipe
version scheme that we are supposed to follow?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


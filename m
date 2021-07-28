Subject: Re: [xenomai-image 1/3] recipes-kernel/linux: control appyling of no
 debug config fragment
References: <20210728022124.23466-1-hongzhan.chen@intel.com>
 <20210728022124.23466-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8792dbe1-a638-a1a7-f1d4-2344daae5440@siemens.com>
Date: Wed, 28 Jul 2021 07:52:13 +0200
MIME-Version: 1.0
In-Reply-To: <20210728022124.23466-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 28.07.21 04:21, Hongzhan Chen via Xenomai wrote:
> By default, nodbg config fragment would not be applied.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  recipes-kernel/linux/linux-xenomai.inc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 185b60b..5f639df 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -12,8 +12,10 @@
>  require recipes-kernel/linux/linux-custom.inc
>  
>  KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
> +DISTRO_NODBG ?= "0"
>  
>  SRC_URI += "file://${KERNEL_DEFCONFIG}"
> +SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('DISTRO_NODBG') == '1' else ''}"
>  
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source"
> 

As discussed, let's flip the default to no-debug and enable debugging
via XENOMAI_DEBUG = "1", I would say.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


Subject: Re: [xenomai-image PATCH v2 4/5] recipes-kernel/linux: control
 appyling of no debug config fragment
References: <20210727004217.10892-1-hongzhan.chen@intel.com>
 <20210727004217.10892-5-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <88fd782a-8fa8-36df-33ca-d36f714a91bb@siemens.com>
Date: Tue, 27 Jul 2021 12:49:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210727004217.10892-5-hongzhan.chen@intel.com>
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

On 27.07.21 02:42, Hongzhan Chen via Xenomai wrote:
> For performance or latency testing and demonstration, debug switches
> should be off but it is on by default.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  recipes-kernel/linux/linux-xenomai.inc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 185b60b..ff54ce2 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -11,9 +11,17 @@
>  
>  require recipes-kernel/linux/linux-custom.inc
>  
> +def is_nodbg_support(d):
> +    dbg_ver = d.getVar('DISTRO_NODBG') or ''
> +    return dbg_ver.startswith('YES') or dbg_ver == 'YES'
> +
>  KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
> +KERNEL_NODBG_FRAGMENTS ?= "common_nodbg.cfg"
> +KERNEL_NODBG_FRAGMENTS_append = "${@'' if is_nodbg_support(d) else ';apply=no'}"
>  
> -SRC_URI += "file://${KERNEL_DEFCONFIG}"
> +SRC_URI += "file://${KERNEL_DEFCONFIG} \
> +    file://${KERNEL_NODBG_FRAGMENTS} \
> +"
>  
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source"
> 

How about

DISTRO_NODBG ?= "0"

SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('DISTRO_NODBG') == '1' else ''}"

?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


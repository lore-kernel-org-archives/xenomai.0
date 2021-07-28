Subject: Re: [xenomai-image 3/3] recipes-kernel: disable more debugs for
 common nodbg fragment
References: <20210728022124.23466-1-hongzhan.chen@intel.com>
 <20210728022124.23466-4-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b87a7aeb-2fd4-428f-1643-c87b90ac15b9@siemens.com>
Date: Wed, 28 Jul 2021 07:52:15 +0200
MIME-Version: 1.0
In-Reply-To: <20210728022124.23466-4-hongzhan.chen@intel.com>
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
> Disable more debugs for common nodbg fragment to improve performance
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  recipes-kernel/linux/files/common_nodbg.cfg | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> index 749799d..d7d87c5 100644
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -1 +1,2 @@
>  # CONFIG_IPIPE_DEBUG is not set
> +# CONFIG_XENO_OPT_DEBUG is not set
> 

Added this one to next already, thanks.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


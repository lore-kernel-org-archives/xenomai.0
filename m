Subject: Re: [xenomai-image PATCH v2 3/5] recipes-kernel: add common config
 fragment file to disable debug
References: <20210727004217.10892-1-hongzhan.chen@intel.com>
 <20210727004217.10892-4-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ff2fb3b2-79d4-0a0f-e7b7-d39eb630aa2c@siemens.com>
Date: Tue, 27 Jul 2021 12:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210727004217.10892-4-hongzhan.chen@intel.com>
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
> Add common config fragment file to disable debug. For performance
> or latency testing and demonstration, debug switches should be off.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  recipes-kernel/linux/files/common_nodbg.cfg | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 recipes-kernel/linux/files/common_nodbg.cfg
> 
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> new file mode 100644
> index 0000000..749799d
> --- /dev/null
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -0,0 +1 @@
> +# CONFIG_IPIPE_DEBUG is not set
> 

What about CONFIG_XENO_OPT_DEBUG* at least?

Other kernel debug switches may also be added here eventually.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


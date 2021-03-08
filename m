Subject: Re: [PATCH] rt_e1000e: Fix __bad_udelay linking error
References: <20210306221329.1112-1-vt@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b0726e7-9b5a-ec65-d789-e98e8dd29289@siemens.com>
Date: Mon, 8 Mar 2021 11:43:36 +0100
MIME-Version: 1.0
In-Reply-To: <20210306221329.1112-1-vt@altlinux.org>
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
To: Vitaly Chikunov <vt@altlinux.org>, Xenomai <xenomai@xenomai.org>

On 06.03.21 23:13, Vitaly Chikunov wrote:
> This is similar to upstream commit 9e6c3b63399dd ("e1000e: fix compiler
> warnings" by David Ertman). Fix compile error:
> 
>   ERROR: "__bad_udelay" [drivers/xenomai/net/drivers/e1000e/rt_e1000e.ko] undefined!
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  kernel/drivers/net/drivers/e1000e/phy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/e1000e/phy.c b/kernel/drivers/net/drivers/e1000e/phy.c
> index 66ae3891a..9ec7835bc 100644
> --- a/kernel/drivers/net/drivers/e1000e/phy.c
> +++ b/kernel/drivers/net/drivers/e1000e/phy.c
> @@ -1787,13 +1787,17 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
>  		 * it across the board.
>  		 */
>  		ret_val = e1e_rphy(hw, PHY_STATUS, &phy_status);
> -		if (ret_val)
> +		if (ret_val) {
>  			/*
>  			 * If the first read fails, another entity may have
>  			 * ownership of the resources, wait and try again to
>  			 * see if they have relinquished the resources yet.
>  			 */
> -			udelay(usec_interval);
> +			if (usec_interval >= 1000)
> +				mdelay(usec_interval/1000);
> +			else
> +				udelay(usec_interval);
> +		}
>  		ret_val = e1e_rphy(hw, PHY_STATUS, &phy_status);
>  		if (ret_val)
>  			break;
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


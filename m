References: <20170414130801.16915-1-romain.naour@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7cdc9995-d4bc-1733-c88a-bfe4e5480e00@xenomai.org>
Date: Sat, 15 Apr 2017 16:48:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170414130801.16915-1-romain.naour@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] arm: enable armv5tej support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@gmail.com>, xenomai@xenomai.org

On 04/14/2017 03:08 PM, Romain Naour wrote:
> armv5tej are not detected in lib/cobalt/arch/arm/include/asm/xenomai/features.h
> 
> Apply the same patch from xenomai-2.6:
> https://git.xenomai.org/xenomai-2.6.git/commit/?id=ebc2779baa222db4a5936c3d3022803355585b8c
> 
> Signed-off-by: Romain Naour <romain.naour@gmail.com>
> ---
>  lib/cobalt/arch/arm/include/asm/xenomai/features.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/features.h b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
> index 10bd0c7..e84b809 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/features.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/features.h
> @@ -34,7 +34,8 @@
>  #endif /* armv4 */
>  
>  #if defined(__ARM_ARCH_5__) || defined(__ARM_ARCH_5T__) \
> -	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__)
> +	|| defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__) \
> +	|| defined(__ARM_ARCH_5TEJ__)
>  #define __LINUX_ARM_ARCH__ 5
>  #endif /* armv5 */
>  
> 

Merged, thanks.

-- 
Philippe.


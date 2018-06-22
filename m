References: <1529653662-25891-1-git-send-email-abel.vesa@nxp.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ca011764-2396-9306-8615-844c0f2ef358@xenomai.org>
Date: Fri, 22 Jun 2018 09:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <1529653662-25891-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm: Kconfig: make LOCKDEP depend on !IPIPE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Abel Vesa <abel.vesa@nxp.com>, xenomai@xenomai.org

On 06/22/2018 09:47 AM, Abel Vesa wrote:
> LOCKDEP is not yet supported on arm. By disabling LOCKDEP when IPIPE is enabled
> we get rid of the LOCKDEP warnings.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 11ddea6..1814aab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -168,6 +168,7 @@ config HAVE_LATENCYTOP_SUPPORT
>  
>  config LOCKDEP_SUPPORT
>  	bool
> +	depends on !IPIPE
>  	default y
>  
>  config TRACE_IRQFLAGS_SUPPORT
> 

Merged, thanks.

-- 
Philippe.


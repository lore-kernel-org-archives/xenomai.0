From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DEE670.30306@domain.hid>
References: <45DEE670.30306@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 15:00:21 +0100
Message-Id: <1172239221.26738.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Adeos-main] Re: [PATCH] 2.6.20-i386: fix collateral damage of
	regparm cleanup
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2007-02-23 at 14:04 +0100, Jan Kiszka wrote:
> Index: linux-2.6.20.1/arch/i386/kernel/entry.S
> ===================================================================
> --- linux-2.6.20.1.orig/arch/i386/kernel/entry.S
> +++ linux-2.6.20.1/arch/i386/kernel/entry.S
> @@ -108,7 +108,7 @@ VM_MASK		= 0x00020000
>  # define IPIPE_TRACE_IRQ_ENTER \
>  	lea PT_EIP-4(%esp), %ebp; \
>  	movl PT_ORIG_EAX(%esp), %eax; \
> -	call ipipe_trace_begin; \
> +	call ipipe_trace_begin
>  # define IPIPE_TRACE_IRQ_EXIT \
>  	pushl %eax; \
>  	movl PT_ORIG_EAX+4(%esp), %eax; \
> 

Applied, thanks.

-- 
Philippe.




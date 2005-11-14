Message-ID: <43788F9B.4070007@domain.hid>
Date: Mon, 14 Nov 2005 14:22:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] printk
References: <OF52CB4F2C.0758DB64-ONC12570B9.0040DCB8-C12570B9.00423FCF@datacon.at>
In-Reply-To: <OF52CB4F2C.0758DB64-ONC12570B9.0040DCB8-C12570B9.00423FCF@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Philippe Gerum <rpm@xenomai.org> wrote on 14.11.2005 12:26:08:
> 
>  > >>
>  > >>Although, here is, well, a tiny race because of the fact that the virq
>  > >>handler doesn't lock a buffer-related data (like __ipipe_printk_fill)
>  > >>so a loss of data may occur under some circumstances.
>  > >>
>  >
>  > Nope. __ipipe_printk_fill and friends are manipulated under hw irq
>  > spinlocking
>  > in printk(), and under Linux domain stalling protection in
>  > __ipipe_flush_printk
>  > since it's a virq handler,
> 
> So what prevents some activity from the primary domain from preempting 
> __ipipe_flush_printk() and calling printk() when _only_ the Linux domain 
> is stalled?

This cannot happen in async mode, since the output would be buffered and 
printk() never called on behalf of the preempted handler.

> 
> let's say at the (*) point
> 
> void __ipipe_flush_printk (unsigned virq)
> {
>       char *p = __ipipe_printk_buf;
>       int out = 0, len;
> 
>       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> 
>       while (out < __ipipe_printk_fill) {
>               len = strlen(p) + 1;
>               printk("%s",p);
>               p += len;
>               out += len;
>       }
> (*) <---------------------------- preempted
>       __ipipe_printk_fill = 0;
> }
> 
> When linux gets controll back the virq continues its execution and sets 
> __ipipe_printk_fill up to 0.
> 
> This cannot happen only if virqs are manipulated with the primary domain 
> being stalled as well. But you told "and under __Linux domain___ 
> stalling protection in __ipipe_flush_printk since it's a virq handler".
> 
> 
>  > and finally, printk() cannot preempt
>  > __ipipe_flush_printk under normal operation mode (i.e. async mode). 
> AFAICS,
>  > there's no race here.
> 
> 
> ---
> Best regards,
> Dmitry
> 


-- 

Philippe.


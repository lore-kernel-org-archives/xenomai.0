Message-ID: <498226CC.1020504@domain.hid>
Date: Thu, 29 Jan 2009 22:59:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D590A7C@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D590A7C@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnpod_schedule 2.4.6.1
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Forgive me if this has been asked before.
> 
>  
> 
> In xnpod_schedule I notice there is a call to
> xnlock_get_irqsave(&nklock, s);
> 
>  
> 
> Further down, this call is made again followed by
> xnlock_put_irqrestore(&nklock, s);
> 
>  
> 
> The comments say that the lock is not held, but from what I can tell it
> previously was. I was just pointing out this observation in case it was
> a bug. It looks like this function has been changed a lot in trunk, so
> perhaps anything relating to this was fixed since 2.4.6.1.
>

There is a Xenomai to Linux context switch in between, and the nklock was indeed
released in that case. This code is correct.

>  
> 
> Steven
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.


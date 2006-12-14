Message-ID: <45810678.507@domain.hid>
Date: Thu, 14 Dec 2006 09:08:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Handling a interrupt from user space on PPC405
References: <200612132315.54899.niklaus.giger@domain.hid>
In-Reply-To: <200612132315.54899.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I tried to use the FIT (Fixed Interrupt Timer) on my PPC405GPr board, which 
> uses 0x1010 as its interrupt vector in a user space (vxworks-skin) 
> application.
> <..>
>   RT_INTR FITnterrupt;
>   res = rt_intr_create(&FITnterrupt, 0, 0x1010, I_NOAUTOENA);
> <..>
> But I got -22 EINVAL as error.
> Could somebody please tell me, what is wrong with my example.

The FIT exception is not an external interrupt and cannot be used with 
the the above function. And 0x1010 is not a valid IRQ number anyhow 
(it's actually the jump address of the FIT exception).

> I would like to have as little as possible code in the kernel and handling the 
> whole interrupt in a RT (vxworks-skin) user space task.
> 
> And how do I have to handle the case, where my interrupt handler is only 
> interested in one of external interrupts of the PPC405?
> 
> A good answer would enable me to publish afterwards a working example code.

The right thing to do is to handle the expection as VIRQ like the 
decrementer (or the PIT on the AMCC 405). Unfortunately, this requires 
various modifications to the ADEOS-IPIPE patch, but it's feasible, of 
course. Search for CONFIG_IPIPE in head_4xx.c,

Wolfgang.



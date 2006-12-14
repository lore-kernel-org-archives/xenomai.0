Message-ID: <4580F7B2.8060600@domain.hid>
Date: Thu, 14 Dec 2006 09:05:22 +0200
From: Heikki Lindholm <holindho@domain.hid>
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

Niklaus Giger kirjoitti:
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

The 0x1010 is the HW interrupt vector, but the argument should be the 
interrupt _line_. Besides, last time I checked, the ppc405 FIT isn't 
even 'wired' in the kernel; actually, there's no space for the interrupt 
prologue code, which basically results that no handler is called when 
the FIT interrupt occurs.

-- Heikki Lindholm


Message-ID: <43E1BD0E.3080602@domain.hid>
Date: Thu, 02 Feb 2006 09:04:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Dual Xeon 2.6.13 SMP config problem
References: <23fcc723d285.23d28523fcc7@domain.hid>
In-Reply-To: <23fcc723d285.23d28523fcc7@domain.hid>
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
To: Nathaniel J Villaume <Nathaniel.J.Villaume@domain.hid>
Cc: xenomai@xenomai.org

Nathaniel J Villaume wrote:
> Hi, 
> It turns out that I had to upgrade the mkinitrd package. The one that comes with FC3 doesn't build the image correctly for SMP.  That said, I now can build and boot a vanilla 2.6.15 kernel, but when I try to boot the ipipe-patched kernel, I get the following error near the end of the boot-sequence: (  I thought it was an X-server problem it comes so late, but then I booted to init level 3, and I get the same thing)
> 
> hda: dma_timer_expiry  dma_status == 0x24
> hda: dma: int recovery 
> hda: lost interrupt
> 
> Then the kernel hangs. (Num Lock key doesn't make the lights blink.)
> 
> The configs have two differences: (seriously) 
> 1) The dates are different, 
> 2) ipipe is included in the failing kernel. 
> 
> I would like to know if there are any other tests I can do to isolate the cause of this failure. 
> 
> I appreciate any comments, 
>

Please send me the .config privately.

> Nate
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.


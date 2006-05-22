Message-ID: <4471D039.8090403@domain.hid>
Date: Mon, 22 May 2006 16:52:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E04A474F@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E04A474F@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: New patch for Freescale i.MX21 (csb535fs)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

ROSSIER Daniel wrote:
> Hello,
> 
>  
> 
> Here is a new release of the Adeos patches for the Freescale i.MX21.
> 
>  
> 
> The "extra-"adeos/xenomai patch called linux-2.6.14.imx21_1.1.0.patch 
> can be used for the support of the i.MX21 board (free standard edition) 
> to linux 2.6.14
> 
>  
> 
> We found out that some changes issued from our first patch (tune_timer, 
> proper irq virtualization in do_edge/do_irq functions, ...) have been 
> integrated
> 

Indeed, I actually even said you so in my last mail, since the whole 
purpose of what we are doing right now is to move the generic ARM 
portions to the vanilla patch.

> into the last release of the official arm patch. BTW, is it possible to 
> keep our copyright notice somewhere in the arm patch ;-)) ?
> 

Fair enough. We don't usually add copyrights to the standard Linux files 
for bringing in the oneliners needed to provide the Adeos support, but I 
can put yours in arch/arm/kernel/ipipe-core.c for the change in 
ipipe_tune_timer, no problem. I can even put it in the standard Linux 
files you changed if you want, that's a no-brainer.

>  
> 
> The last release includes a way to configure the idle_mode (idle=poll) 
> in the boot command line and reduces the number of warning at the 
> compilation (not all unfortunately).

Thanks, queued. I will make my best to have this match merged before 
v2.2 final is released.

-- 

Philippe.


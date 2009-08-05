Date: Wed, 5 Aug 2009 22:37:44 +0200 (CEST)
From: "Waschk,Kolja" <xenoka09@domain.hid>
In-Reply-To: <1249473495.3809.22.camel@domain.hid>
Message-ID: <alpine.DEB.2.00.0908052231200.4877@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
	<Pine.LNX.4.62.0907291226390.20869@domain.hid>
	<1248883517.3532.7.camel@domain.hid>
	<alpine.DEB.2.00.0907292209410.5958@domain.hid>
	<1249287753.4803.10.camel@domain.hid>
	<Pine.LNX.4.62.0908031850580.29886@domain.hid>
	<1249473495.3809.22.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> Does this help?
> diff --git a/ksrc/arch/blackfin/switch.S b/ksrc/arch/blackfin/switch.S

Yes! Great - it doesn't just help to step 'next' over the small example, it
also allows me to actually use GDB with my larger app in use cases that
previously always ended with the xnshadow_relax failure. Is it a bugfix or
workaround and how did you actually find it out? - Kolja



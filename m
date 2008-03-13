Message-ID: <2ff1a98a0803131051v43dea811r67b5a81e7d32ba62@domain.hid>
Date: Thu, 13 Mar 2008 18:51:13 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803131013p152b79fah70d97ee1429e86e9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<d6c8ef150803131013p152b79fah70d97ee1429e86e9@domain.hid>
Subject: Re: [Xenomai-help] [Adeos-main] New I-pipe patch for ARM.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

On Thu, Mar 13, 2008 at 6:13 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi Gilles,
>
>  I booted similar board, but without additional Eths, only "built-in"
>  MACB Ethernet controller (part of AT91SAM9260). Networking here works
>  ok.
>
>  It seems that we have problem with GPIO interrupt handling/dispatching.

Ok. The code which does this is __ipipe_mach_demux_irq in
arch/arm/mach-at91/gpio.c. Could you check if at least it triggers ?


-- 
 Gilles Chanteperdrix


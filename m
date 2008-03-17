Message-ID: <d6c8ef150803170819m5baf5e83wef872fb7c34f24a9@domain.hid>
Date: Mon, 17 Mar 2008 16:19:08 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <47DE7FCE.4050604@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803170707l7161255an6fa1bf1f3627395f@domain.hid>
	<47DE7FCE.4050604@domain.hid>
Subject: Re: [Xenomai-help] Kernel functions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

[ I'm a little bit new to the whole Xenomai/Adeos thing, so maybe
asking bullshit :) ]

On Mon, Mar 17, 2008 at 3:27 PM, Philippe Gerum <rpm@xenomai.org> wrote:

>  I'm assuming you mean "real-time mode". __raw_write routines should always be
>  ok, but dma_map_single() has an arch-dependent implementation. I would be ok to
>  call it on Blackfin from a real-time (i.e. non plain Linux) context, but this
>  would break on ARM.

Is there any "proposed" method of communication with hw directly from
real-time mode (native skin, meaning as a kernel module)? I've
modified macb eth driver for the 'special purpose use', I don't need
it as an Linux Ethernet device. That is the reason why asking for
dma_map_single (I need the "real" memory address to put in tx_ring).

If there is some document covering my problem, please send me link to it.

Thanks,
Bosko


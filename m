Message-ID: <bc4264770703091004w11473ea2w608c0e8482eadd29@domain.hid>
Date: Fri, 9 Mar 2007 18:04:56 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01BB3EB3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
	<200703091538.54236.paul_c@domain.hid>
	<bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01BB3EB3@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Hi,

Thanks.

>
> Real-Time does mean the system reacts in time. There is nothing a
> software can do if the hardware is not meeting your requirements of
> beeing in time. Having reliable 0.5 ms real-time is e.g. for us
You have my attention here. What exactly do you mean? That you have
consistent 0.5ms cycle (period) times and your platform maintains this
to within a few (<10) micro seconds?
Or are you saying that latencies of 0.5ms are still acceptable for
your application and with regard to the time-scales of your physical
process latencies of 0.5ms are still regarded to be real-time?


> absolutely real-time and we chose carefully our hardware components that
> this will never be exceeded. For us Xenomai and RTCAN on a MPC5200B
> platform do a good job.
What CAN adaptor are you using? Not the dongle I suppose?

>  I cannot imagine that the developers of
> > rt-can overlooked this. I doubt that it will be possible to run a
> > discrete state-space controller successfully on a platform that
> > juggles around its period-times as badly as I am experiencing. And I
> > still need to read discrete IO and write DIO and AIO to another CAN
> > node which is not yet even connected.
>

> Choose your hardware carefully.
Thanks for the advice:)

> Parallel port CANS are certainly much
> slower than e.g. PCI adapters.
Can anyone quantify this?

>On a Laptop you have the possibility to
> add e.g. PCCARD CAN. But before purchasing I would check how these are
> supported and which typical access times you can expect.
AFAIK rtcan only supports Peak PCI and PEAK dongle devices. Hardware
vendors don't generally provide xenomai device drivers. This kind of
limits my options.
Besides CAN are there any other protocol devices supported?

> USB CAN is
> certainly even slower, so this will be no option.
And is apparently not compatible with anything real-time from what i have heard.


Roland


>
> Best regards,
>
> Daniel Schnell.
>


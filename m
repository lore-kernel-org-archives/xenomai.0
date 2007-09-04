Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Sep 2007 11:23:46 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0D00776@domain.hid>
In-Reply-To: <46DC7E8F.4000503@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>	<1188824753.6037.27.camel@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0B475ED@EINT11.einet.ad.eivd.ch>
	<46DC7E8F.4000503@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: Re: [Xenomai-core] RE : Activation of IRQ handler in the Linux
	domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan and Philippe,

I decided to move the ISR into the RT domain and everything works well.
Thanks for your suggestions.

Actually, we've our i.MX21 board with some i2c devices (namely leds and
buttons), and I wanted
to make some example of applications using the i2c in the Xenomai
domain. However, the way how the "official"
i2c driver is coded is maybe not optimal since there is this polling on
a state variable (transfer complete) which is updated
by the ISR. My wish was to touch the driver as few as possible.

Daniel

>-----Original Message-----
>From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>Sent: lundi 3 septembre 2007 23:37
>To: ROSSIER Daniel
>Cc: rpm@xenomai.org; xenomai-core
>Subject: Re: [Xenomai-core] RE : Activation of IRQ handler in the Linux
>domain
>
>Hi Daniel,
>
>[Some add-ons to what Philippe already pointed out:]
>
>ROSSIER Daniel wrote:
>> ...
>> Ok, I totally agree. I've tried to use a rtdm_event object which I've
>> declared in the Linux driver side. Then, the write function is called
>> from a RT task,
>
>That sounds error-prone: Is "write" only called from RT context? Does
it
>have to synchronise with functions running in non-RT context, and is
>this synchronisation done in a RT-safe manner (rtdm_lock_...)? You may
>check this offline - or online with CONFIG_IPIPE_DEBUG_CONTEXT.
>
>> then it calls rtdm_event_wait() at a certain point, and the i2c ISR
>> performs a rtdm_event_signal() to wake up the RT task. However, I got
>a kernel crash when rtdm_event_wait() is called.
>
>Sometimes it is helpful to analyse what the crash says precisely, e.g.
>at which line of code (during which memory access) the crash happens.
>Also, debugging options may help to catch some potential root bug
>earlier.
>
>In general, I also smell a bit too much hacking and too less designing
>here... ;)
>
>Jan



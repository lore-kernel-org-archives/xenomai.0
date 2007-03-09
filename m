Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] RTCAN and tsc
Date: Fri, 9 Mar 2007 17:42:06 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01BB3EB3@domain.hid>
In-Reply-To: <bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid><E1HPfGn-0003K5-RF@mailer.emlix.com><bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid><200703091538.54236.paul_c@domain.hid>
	<bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>, Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

roland Tollenaar wrote:
> What baffles me a bit  then is that the behavior cannot be classified
> as very "Real-Time" can it?    =20

Real-Time does mean the system reacts in time. There is nothing a
software can do if the hardware is not meeting your requirements of
beeing in time. Having reliable 0.5 ms real-time is e.g. for us
absolutely real-time and we chose carefully our hardware components that
this will never be exceeded. For us Xenomai and RTCAN on a MPC5200B
platform do a good job.

 I cannot imagine that the developers of
> rt-can overlooked this. I doubt that it will be possible to run a
> discrete state-space controller successfully on a platform that
> juggles around its period-times as badly as I am experiencing. And I
> still need to read discrete IO and write DIO and AIO to another CAN
> node which is not yet even connected.

Choose your hardware carefully. Parallel port CANS are certainly much
slower than e.g. PCI adapters. On a Laptop you have the possibility to
add e.g. PCCARD CAN. But before purchasing I would check how these are
supported and which typical access times you can expect. USB CAN is
certainly even slower, so this will be no option.

Best regards,

Daniel Schnell.


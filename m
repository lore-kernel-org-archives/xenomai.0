Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Oct 2007 18:35:24 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi everyone,

I'm taking over the original thread from Patrick concerning the port of
Xenomai on Xscale with Linux 2.6.20. Briefly summarized, the boot
process actually freezes after a while right after the nucleus has been
started.

I've investigated the issue over the last hours, and I came up with the
following conclusion: it seems that the problem is due to a endless loop
in do_gettimeofday in arch/arm/kernel/time.c. Here is the code:

"...
do {
		seq =3D read_seqbegin_irqsave(&xtime_lock, flags);
		usec =3D system_timer->offset();
		sec =3D xtime.tv_sec;
		usec +=3D xtime.tv_nsec / 1000;
	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
..."

If I remove the do { } while loop with the call to
read_seqbegin_irqsave(), then the boot process is going ahead (I got a
suspicious error like "I-pipe: Detected illicit call from domain
'Xenomai' " but it might well be normal with such a modification.

I checked with the code from a 2.6.15 kernel, and it is basically the
same structure.

Any idea about the cause of this problem?

I checked the timer IRQs and other pipeline activity, and everything
seems to be OK. By the way, if I disable the nucleus, Linux is working
properly (timer not being stolen by I-pipe).

Thanks in advance for any help.

Cheers
Daniel


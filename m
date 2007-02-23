Message-ID: <45DECD52.5010305@domain.hid>
Date: Fri, 23 Feb 2007 12:17:38 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
References: <45DEBF20.2060907@domain.hid> <45DEC477.2070901@domain.hid>
In-Reply-To: <45DEC477.2070901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Re: soft lockup detected on AT91RM9200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles,

>> When starting latency with 100=B5s period I get
>>
>> ~ # latency
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: periodic user-mode task
>> =3D=3D All results in microseconds
>> warming up...
>> BUG: soft lockup detected on CPU#0!
>> ...
>>
>> Ideas? How can I help with debugging this?
>=20
> 100us is too small, as I already told you here:
>=20
> https://mail.gna.org/public/xenomai-core/2007-02/msg00019.html

No. That's probably a different thing. I am going to write a mail soon.

> The latency process spend 100% of its time handling the timer ticks, an=
d
> the kernel detects a soft lockup.
>=20
> The difference between I-pipe patch 1.6-01 and 1.6-02 is that the retur=
n
> from exception is correctly handled. Maybe it is what allows the kernel
> to print a clean message. Maybe it is because you now have enabled the
> soft lockup detector whereas you previously did not.
Ok. Maybe.

I don't care about missing deadlines. That's fine iff I overload the syst=
em.

But I still would have expected printout on the serial console. But ok,
maybe the print in latency is done in a non-realtime task. So fair enough=
.

Steven


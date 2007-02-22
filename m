Message-ID: <45DDCC6D.6020908@domain.hid>
Date: Thu, 22 Feb 2007 18:01:33 +0100
From: =?ISO-8859-1?Q?Jan_R=FCdiger?= <ruediger@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] possible future conflict w LOCAL_APIC
References: <451C586A.7020309@domain.hid> <1159628606.5014.33.camel@domain.hid>
	<4522A377.5030503@domain.hid>
In-Reply-To: <4522A377.5030503@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hello

Few months ago there was a discussion about disabling local apic in the
kernel. The last point in this discussion was:

> update:
>=20
> Ingo Molnar has voiced strong preference that the config option remain,
> citing 60kb growth in its removal.  So its probably safe for now ;-)

Now i have the problem that i cant disable the X86_UP_APIC anymore when
building the kernel 2.6.19. Normally this isn't a problem since it is
disabled during boot (my machine doesn't have APIC). But xenomai is
build with enabled APIC and thus refuses to run on the new kernel.

Is there a way to disable APIC during kernel build? or can i build
xenomai without APIC?

thanks allot in advance

jan r=FCdiger




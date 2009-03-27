Message-ID: <49CCE84E.7060708@domain.hid>
Date: Fri, 27 Mar 2009 15:53:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200903271538.10434.pwaechtler@domain.hid>
In-Reply-To: <200903271538.10434.pwaechtler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
 <50ms	and then Linux?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: pwaechtler@domain.hid
Cc: xenomai@xenomai.org

Peter W=E4chtler wrote:
> Hi Xenomai developers,
>=20
> for automotive control units the boot time is essential. After power-up=
 the=20
> first status message has to be sent in about 50ms. This is usually achi=
eved=20
> by a RTOS with boot times far below.
>=20
> Is it possible to construct a system with Xenomai that boots the POSIX =
(or=20
> whatever) subsystem first and then start Linux. Or is there a dependenc=
y that=20
> the subsystem can't run until Linux is up?

Xenomai kernel-space support is started somewhere in the middle of the
boot process, so, you can probably start kernel-space applications at
that time. User-space only works when init has been started, which
happens a bit later during the boot process. But you can start Xenomai
applications before all the system services have been started.

If you are using an x86, the bios itself lasts for more than 50 ms. On
other architectures, boots time are lower, but there are still places in
the kernel initialization that may be optimized. I have read articles on
linuxdevices of people having worked on that, but never looked at what
they had actually done.

As a side note, I have a question for the automotive industry people.
Would there be an interest in developing an OSEK skin for Xenomai? I
have been thinking about that for some time, but still have not found
time to start the job. I have read the OSEK spec, and found the
interface pretty simple (though some part of the job has to be done
offline, and annoyingly need to read XML files). The OSEK com spec, on
the other hand, looks rather scary.

--=20
                                                 Gilles.



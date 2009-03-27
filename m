Message-ID: <49CCF701.5000306@domain.hid>
Date: Fri, 27 Mar 2009 16:55:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200903271538.10434.pwaechtler@domain.hid>
	<49CCE84E.7060708@domain.hid>
	<200903271641.09389.pwaechtler@domain.hid>
In-Reply-To: <200903271641.09389.pwaechtler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
 <50ms and then Linux?
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
> Am Friday 27 March 2009 15:53:02 schrieb Gilles Chanteperdrix:
>> Xenomai kernel-space support is started somewhere in the middle of the=

>> boot process, so, you can probably start kernel-space applications at
>> that time. User-space only works when init has been started, which
>> happens a bit later during the boot process. But you can start Xenomai=

>> applications before all the system services have been started.
>>
>=20
> I think the fundamental question is: does Adeos provide a scheduler?=20
>=20
> And I guess the answer is yes, at least "Life-with-Adeos" doc mentions
> primary and secondary execution modes/domains.
>=20
> In the use case it would be necessary that OSEK subsystem is able to sc=
hedule=20
> between a static number of preconfigured threads WITHOUT the preconditi=
on=20
> that Linux is up and running.

No, you misunderstood the document, Adeos does not provide a scheduler.
Xenomai dos.

The answer is that some part of the Linux kernel needs to be running
(hardware timer and interrupts subsystem) for Xenomai kernel-space
services to start, and it is started at about the time when it can be
started, and the first process needs to have been started if you want to
start user-space processes.

--=20
                                                 Gilles.



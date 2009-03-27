Message-ID: <49CCFD77.3010104@domain.hid>
Date: Fri, 27 Mar 2009 17:23:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200903271538.10434.pwaechtler@domain.hid>
	<200903271641.09389.pwaechtler@domain.hid>
	<49CCF4C4.2010802@domain.hid>
	<200903271717.07188.pwaechtler@domain.hid>
In-Reply-To: <200903271717.07188.pwaechtler@domain.hid>
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
> Am Friday 27 March 2009 16:46:12 schrieb Gilles Chanteperdrix:
>> Peter W=E4chtler wrote:
>>>> As a side note, I have a question for the automotive industry people=
=2E
>>>> Would there be an interest in developing an OSEK skin for Xenomai? I=

>>>> have been thinking about that for some time, but still have not foun=
d
>>>> time to start the job. I have read the OSEK spec, and found the
>>>> interface pretty simple (though some part of the job has to be done
>>>> offline, and annoyingly need to read XML files). The OSEK com spec, =
on
>>>> the other hand, looks rather scary.
>>> There are open source OSEK implementations. AFAIK, all far from
>>> completeness.
>>>
>>> You can start with
>>> http://opensek.sourceforge.net/
>>>
>>> or have a look at the list at
>>> http://en.wikipedia.org/wiki/OSEK
>> My question is: would you, people working for the automotive industry,=

>> use it. Do you need this, or is OSEK dead and people are using POSIX.
>=20
> Can't answer with yes or no.
> OSEK is in use today and will be used for several years.
> AUTOSAR is a new aproach for providing a framework for easier reuse/rel=
ocation=20
> of functionality.
> And POSIX is used whereever Linux or QNX is involved (mediaplayers,navi=
gation=20
> with file access)
>=20
> The problem with using a newly open source OSEK implementation is risk =
and=20
> trust and level of testing/validation and TOOLS and CAN stack support.
>=20
> I think it's very late - but this depends on quality of implementation.=
 OSEK=20
> is for the "smaller" control units. I guess we will have "smaller" ECUs=
 in=20
> our new cars for the next 10 years.
> But on the other hand a manufacturer like Volkswagen has chosen Vector =
osCAN=20
> as OSEK implementation. I doubt that they will change that for no good =

> reason. Royalties are rather low and the emphasize is TOOLS and CAN sup=
port.

Yes, obviously, we do not intend to run Xenomai on these very small
control units, so, it would rather be useful as a tool to test OSEK code
on desktop machines and would have to focus on debugging facilities,
such as errors when choosing tasks and resources priorities. As for CAN
support, Xenomai has CAN support, but it means that implementing OSEK
would only make sense if we implemented an OSEK com binding for CAN.

--=20
                                                 Gilles.



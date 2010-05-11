Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 May 2010 16:32:01 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C0BE@srv-dc.ona-electroerosion.com>
In-Reply-To: <4BE96428.4080104@domain.hid>
From: "Asier Tamayo" <asier.tamayo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and/or PREEMPT_RT patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hello Jan:

Thanks for your help.

> There are many factors of your scenario that influence a comparison. =
So
> you should sketch your requirements and variables first. To name a =
few:
>  - CPU architecture
>  - overview on your critical loop(s)
>  - their timing requirements
>  - portability of your applications (to decide about application
>    adaption vs. legacy OS emulation)
>=20

My new CPU has an Intel Atom N270 @1.6 GHz processor. At the moment =
(during the porting it might be optimized), I have 5 drivers requering =
hard real-time (no loop can be skipped) and being called every 2 to 10 =
ms. In fact, at the beginning I was using 1 ms, but I had some problems =
with the hard real-time and changed the timing to 2 ms. I do not =
consider using a legacy OS emulation.

Knowing my scenario, can you give some new advice?

Besides, the drivers and programs (GUI, parser, ...) in my system use =
shared memory to communicate between them. Which solution (Xenomai or =
PREEMPT_RT) allows me more easily to keep on using the shared memory =
both in real-time and not real-time proccesses?

Thanks in advance,

Asier


> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> Sent: Tuesday, May 11, 2010 4:05 PM
> To: Asier Tamayo
> Cc: xenomai@xenomai.org
> Subject: Re: Xenomai and/or PREEMPT_RT patch
>=20
>=20
> Asier Tamayo wrote:
> > Hello all:
> >=20
> > I'm just a newbie to this list, so just forgive me if my=20
> question is obvious or has been answered many times ;-)
> >=20
> > I want to do a port from an old system running a=20
> proprietary RTOS to a new one based in Linux. My system runs=20
> many applications at the same time (GUI, parsers, ...), a few=20
> of which are hard real-time.=20
> >=20
> > I've seen there are many approaches to the real-time issue=20
> in Linux; finally, it seems to me that the only solutions=20
> that will last are Xenomai and the PREEMPT_RT patches=20
> (OSADL). Am I wrong?
>=20
> These are surely the primary candidates. More approaches exists, but I
> wouldn't start considering them until you reach the limits of the
> mentioned ones (which is quite hard these days).
>=20
> >=20
> > Can anybody give me some advice about which system to use?=20
> Any good comparison I can read? Everything I find comparing=20
> real-time Linux approaches seems to be quite out of date.
>=20
> There are many factors of your scenario that influence a=20
> comparison. So
> you should sketch your requirements and variables first. To=20
> name a few:
>  - CPU architecture
>  - overview on your critical loop(s)
>  - their timing requirements
>  - portability of your applications (to decide about application
>    adaption vs. legacy OS emulation)
>=20
> As we are on the Xenomai list, the major strengths (personal=20
> opinion) of
> this approach should already be mentioned:
>  - well extensible to emulate legacy RTOS APIs
>  - strict separation between RT and Linux domain - nevertheless, both
>    contexts are smoothly usable from within the very same user space
>    application
>=20
> > Should I use Xenomai on its own? Or maybe Xenomai and Linux=20
> with the preempt patches applied? Running the GUI, which=20
> demands a lot of CPU and RAM, can have any effect on the=20
> real-time behaviour?
>=20
> Independent of the software approach, hardware can always=20
> ruin your day,
> specifically on x86 (SMI, contentions on I/O buses, shared caches,
> etc.). Weather this matters to you, depends on your timing=20
> requirements
> and how "hard" your real-time has to be.
>=20
> >=20
> > Any hint will be really helpful,
> >=20
> > Best regards,
> >=20
> > Asier
>=20
> HTH,
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux
>=20


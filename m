Message-ID: <5164826E.2000808@xenomai.org>
Date: Tue, 09 Apr 2013 23:04:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
In-Reply-To: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] SMI handling on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: xenomai@xenomai.org

On 03/13/2013 08:43 PM, Jeroen Van den Keybus wrote:

> Hi,
>=20
>=20
> We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboa=
rd
> with a Core 2 Duo CPU.
>=20
> This configuration suffers from excessive worst-case latencies during t=
he
> 'latency' test (on average: 2.6 =C2=B5s, worst-case around 1900 =C2=B5s=
, around 10
> overruns per second). I believe these overruns are due to the CPUs ente=
ring
> SM mode (SMI). As soon as the ACPI BIOS SMI is disabled (when
> xeno_nucleus/native are loaded as a module), the computer shuts down in=
 5
> secs. or so. Presumably some power supply watchdog on the mainboard isn=
't
> triggered.
>=20
> - Has someone also observed this behaviour and maybe solved it in some =
way ?
> - I looked around in the Intel manuals and I don't think it's possible =
to
> have only 1 CPU handle these SMIs. Is that correct ? If it were possibl=
e,
> we could run RT tasks on the other one, obviously, but currently latenc=
y
> shows overruns on both CPUs.
> - Would it somehow be possible/sensible to leave the SMI disabled and
> generically call the SMI handler directly from within (a task in) the O=
S ?
> There's probably going to be issues, the least of which would be proper=

> handling of the RSM instruction outside SM mode. But still...


Hi,

I see this post has not received an answer after a long time. What can
be done for sure is only disabling some sources of SMI, the SMI
workaround module tries to do that, but probably has not a knob for
every possible SMI source. So, what you should do is get the datasheet
for the precise Intel ICH you own, and try and find all the SMI sources.
Then try and find which one causes the latency issues, with the hope
that it is not also the one needed to avoid the reboot.

Regards.

--=20
                                                                Gilles.



MIME-Version: 1.0
In-Reply-To: <5164826E.2000808@xenomai.org>
References: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
	<5164826E.2000808@xenomai.org>
Date: Wed, 17 Apr 2013 13:44:47 +0200
Message-ID: <CAPRPZsD-FhrVrKW7Kqhqaaac4rxcq+vKL_37PZBD2Ay5BRZ50w@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

Thanks for responding. I had also checked what you describe. Unfortunately
it is the ACPI interrupt that causes the delay and is also responsible for
keeping the motherboard powered.

It's not the first time I hit the SMI induced latency problem, but it is
the first board that goes as far as to actually reset itself.

Jeroen.



2013/4/9 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 03/13/2013 08:43 PM, Jeroen Van den Keybus wrote:
>
> > Hi,
> >
> >
> > We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboa=
rd
> > with a Core 2 Duo CPU.
> >
> > This configuration suffers from excessive worst-case latencies during t=
he
> > 'latency' test (on average: 2.6 =B5s, worst-case around 1900 =B5s, arou=
nd 10
> > overruns per second). I believe these overruns are due to the CPUs
> entering
> > SM mode (SMI). As soon as the ACPI BIOS SMI is disabled (when
> > xeno_nucleus/native are loaded as a module), the computer shuts down in=
 5
> > secs. or so. Presumably some power supply watchdog on the mainboard isn=
't
> > triggered.
> >
> > - Has someone also observed this behaviour and maybe solved it in some
> way ?
> > - I looked around in the Intel manuals and I don't think it's possible =
to
> > have only 1 CPU handle these SMIs. Is that correct ? If it were possibl=
e,
> > we could run RT tasks on the other one, obviously, but currently latenc=
y
> > shows overruns on both CPUs.
> > - Would it somehow be possible/sensible to leave the SMI disabled and
> > generically call the SMI handler directly from within (a task in) the O=
S
> ?
> > There's probably going to be issues, the least of which would be proper
> > handling of the RSM instruction outside SM mode. But still...
>
>
> Hi,
>
> I see this post has not received an answer after a long time. What can
> be done for sure is only disabling some sources of SMI, the SMI
> workaround module tries to do that, but probably has not a knob for
> every possible SMI source. So, what you should do is get the datasheet
> for the precise Intel ICH you own, and try and find all the SMI sources.
> Then try and find which one causes the latency issues, with the hope
> that it is not also the one needed to avoid the reboot.
>
> Regards.
>
> --
>                                                                 Gilles.
>
>

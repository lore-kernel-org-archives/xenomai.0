Date: Tue, 20 Mar 2018 15:36:53 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180320153653.556215f6@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7C09E2@DEMUC-SMX001.data-modul.local>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7C0839@DEMUC-SMX001.data-modul.local>
 <57765855-6a4c-4651-70c8-528cc33607dc@xenomai.org>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7C09E2@DEMUC-SMX001.data-modul.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Latency Peaks with Skylake vs. Haswell
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Wed, 14 Mar 2018 15:23:11 +0000
schrieb "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>:

> To be honest, I don't know how exactly tracking this.
>=20
> What I am doing:
> Open 1 terminal window which runs latency test.
> With second terminal window I watch -n1 cat /proc/interrupts
>=20
> During idle (beside latency test and watching interrupts), there are
> about 20 MSI / sec. If another window (e.g. File Manger) is moved
> around fast, I see about 500 MSI / sec.
>
> With Haswell, there are no i915 MSI

Might be normal that the two generations work a little different.

You should ftrace your kernel to see what is going on. It might be that
the 500 interrupts per second are a problem, then you can investigate
how to reduce them. (dig into the driver and compare with more recent
kernels)
I would not be surprised if you end up at a "wbinvd_on_all_cpus".

After you have a better understanding what is going on you might want
to get in touch with the i915 authors, or live with the peaks.

Henning

=20
> Thanks for the hint about autotune.  I will check with next
> measurements.
>=20
> --
> Martin.
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Mittwoch, 14. M=C3=A4rz 2018 15:31
> An: Schrenkhammer, Martin; xenomai@xenomai.org
> Betreff: Re: [Xenomai] Latency Peaks with Skylake vs. Haswell
>=20
> On 03/13/2018 12:33 PM, Schrenkhammer, Martin wrote:
> > I am currently porting a project from Haswell to Skylake
> > (i5-6440EQ). When in desktop, I observe latency peaks when windows
> > are moved around or zoomed. With Haswell CPUs, there is not impact
> > of graphic workload. Unfortunately everything above 10us  is an
> > issue in our real time system application. Currently I am using
> > Xubuntu 16.04 + Kernel 4.9.51 + Xenomai 3.0.6 I already disabled
> > all power- and performance features like Hyper-Threading,
> > SpeedStep, Turbo Mode, C-States in BIOS and also by kernel
> > parameters. Also disabled i915 power savings like
> > i915.enable_dc=3D0,  i915.enable_rc6=3D0, i915.enable_execlists=3D0...
> > and disabled grafik turbo gt_max_freq_mhz =3D 350  gt_boost_freq_mhz
> > =3D 350
> >
> > One difference we see between Haswell and Skylake: i915 raises a
> > lot of MSI when moving windows around where there are almost zero
> > at Haswell.
> >
> > Any ideas for bringing the peaks down? =20
>=20
> Did you track which specific event the i915 driver was handling with
> those MSIs?
>=20
> >
> > =3D=3D Sampling period: 100 us
> > =3D=3D Test mode: periodic user-mode task
> > =3D=3D All results in microseconds
> > warming up...
> > RTT|  00:00:01  (periodic user-mode task, 100 us period, priority
> > 99) RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> > RTH|best|--lat worst
> > RTD|     -0.368|     -0.210|      0.259|       0|     0|
> > -0.368|      0.259 RTD|     -0.259|     -0.161|      1.601|
> > 0|     0|     -0.368|      1.601 RTD|     -0.290|     -0.174|
> > 1.367|       0|     0|     -0.368|      1.601 =20
>=20
> This is unrelated to the issue at stake, but the core timer looks
> slightly early (negative mins), which means that the expected
> intrinsic latency value is too pessimistic/high. Running autotune may
> help in picking better gravity values for this timer.
>=20
> --
> Philippe.
>=20
> Vertrauliche E-Mail von / Confidential e-mail from: DATA MODUL AG
> Vorstand / CEO: Dr. Florian Pesahl
> Vorsitzende des Aufsichtsrates / Chairwoman of the Supervisory Board:
> Kristin D. Russell Sitz der Gesellschaft / Registered Office: M=C3=BCnchen
> Registergericht / Registration Court: M=C3=BCnchen Handelsregister B 85 5=
91
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai



Message-ID: <452E9ACD.20800@domain.hid>
Date: Thu, 12 Oct 2006 21:43:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig922A2615126E4B1508E71465"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig922A2615126E4B1508E71465
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here we go: after quite some hacking and refactoring, Dmitry and I are
happy to provide a patch set that reworks and enhances the statistics
subsystem of Xenomai.

The original goal of these patches was to improve the accuracy of the
/proc/xenomai/stat CPU load output. So far it only accounted thread
switches. The time of potential preceding IRQ handling and scheduling
decision was added to the preempted thread. The new approach avoids
this. More about it later.

While discussing the first implementation, Dmitry had the idea to
refactor even more code that depends on XENO_OPT_STATS, means event
counting parts under the upcoming generic runtime stats. So this series
starts with a patch to introduce a generic subsystem for collecting
statistics on countable events as well as the runtime of entities.

It continues with the second patch that applies xnstat on the IRQ
subsystem, both for counting hits as well as for measuring the execution
time. The accounting model applied in this patch is as simple as this:
measure the time some driver- or application-supplied ISR executes and
accumulate it per-CPU. The rescheduling is still accounted to the
preempted thread.

In my endless quest for perfection, I applied an -as I feel- enhanced
model on top of this (already working!) set, that's the third patch.
This model adds the scheduler path to the IRQ account. And it only
accounts to an IRQ if its ISR reported XN_ISR_HANDLED. This is relevant
for shared IRQs when only one source fired (the typical case). Also, it
reduces churning by avoiding account switches in the average case. But,
the downside, it may be less convenient to understand and increases the
code a bit (only for the shared IRQ case). Dmitry and I were not yet
able to agree on THE model, so I'm simply posting both for public
feedback. :)

Here are some numbers I collected today on a P-III 700 MHz, running our
3D laser range scanner + some post-processing steps (sensor fusion and
2D mapping) and forwarding those data via TCP/IP. That box makes use of
the xeno_16550A driver, collecting serial streams at 115k2 and 500k over
a shared IRQ (you may guess which one belongs to what IRQ :)).

ISR accounting (patch 2/3):
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          11160      0     01400080   73.0  ROOT
>   0  0      0          853        0     00000082    0.0  timsPipeReceiv=
er
>   0  876    0          61         0     00d00082    0.0  LadarSickLms20=
02C
>   0  878    0          6666       0     00d00086    0.4  LadarSickLms20=
02D
>   0  879    0          59         0     00d00082    0.0  Scan2dVirtual3=
C
>   0  880    0          1207       0     00d00084    0.0  Scan2dVirtual3=
D
>   0  881    0          167        0     00d00082    0.0  Scan3DScanDriv=
eSick0C
>   0  882    0          2935       0     00d00086   10.4  Scan3DScanDriv=
eSick0D
>   0  887    0          140        0     00d00082    0.0  ServoDriveScan=
Drive0C
>   0  888    0          2509       0     00d00086    0.1  ServoDriveScan=
Drive0D
>   0  0      0          41913      0     00000000    0.1  IRQ0: [timer]
>   0  0      0          176870     0     00000000   13.5  IRQ5: rtser5
>   0  0      0          11121      0     00000000    2.4  IRQ5: rtser4

Enhanced accounting (patch 3/3):
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          11384      0     01400080   72.4  ROOT
>   0  0      0          745        0     00000082    0.0  timsPipeReceiv=
er
>   0  884    0          56         0     00d00082    0.0  LadarSickLms20=
02C
>   0  887    0          7282       0     00d00082    0.4  LadarSickLms20=
02D
>   0  885    0          140        0     00d00082    0.0  Scan3DScanDriv=
eSick0C
>   0  889    0          3066       0     00d00086   10.4  Scan3DScanDriv=
eSick0D
>   0  888    0          54         0     00d00082    0.0  Scan2dVirtual3=
C
>   0  890    0          1069       0     00d00084    0.0  Scan2dVirtual3=
D
>   0  897    0          76         0     00d00082    0.0  ServoDriveScan=
Drive0C
>   0  898    0          2271       0     00d00086    0.1  ServoDriveScan=
Drive0D
>   0  0      0          50700      0     00000000    0.1  IRQ0: [timer]
>   0  0      0          201357     0     00000000   14.1  IRQ5: rtser5
>   0  0      0          5811       0     00000000    2.4  IRQ5: rtser4

So the difference between both accounting models is not dramatic, but
noticeable. Clearly, the variation increases with every high rate IRQ
source you add (rtser5 was about 7 KHz) and with every step down the CPU
performance ladder.

Ok, enough talk, we are looking forward to feedback now! What
specifically needs testing is SMP, I only once ran the patches under a
2-way qemu.

Jan


--------------enig922A2615126E4B1508E71465
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFLprNniDOoMHTA+kRArGDAJ470JUo+hkYFglcBwII//On3mbmoACfcVMC
iaTEl5FXIc5EkMaX7agjbFg=
=h5dL
-----END PGP SIGNATURE-----

--------------enig922A2615126E4B1508E71465--


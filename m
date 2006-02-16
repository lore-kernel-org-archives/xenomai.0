From: "Russell Johnson" <rjohnson@domain.hid>
Subject: RE: [Xenomai-core] Handling PCI MSI interrupts
Date: Thu, 16 Feb 2006 07:23:39 -0700
Message-ID: <000a01c63304$94ee5190$1e01a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43F447AF.4020604@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: 'xenomai-core' <xenomai@xenomai.org>

> The latest patch was incomplete; you might be luckier with=20
> this one. I've merged Jeroen's last observations on this issue and =
mine.

I tried this patch and it doesn't solve the issue I'm facing. With and
without this patch, my symptoms are the same.

I'm running a Dell 2850, dual CPU machine.  When I build a kernel =
without
Adeos then things are fine.  When I build with Adeos and MSI enabled the
following occurs:

1) If BIOS has USB disabled then the system will hang without even a
num-lock respose (i.e. tapping the num-lock key doesn't toggle the =
light).
The hang occurs just about the time the E1000 driver would load and =
enable
an MSI interrupt.

2) If BIOS has USB enabled then the system will run much longer but may =
hang
during heavy interrupt load on the E1000 driver.

My assumption based on past experience is that no num-lock response =
means an
infinite interrupt loop.

When I build a kernel with Adeos but disable MSI then the system works =
fine
for the most part.  There is one scenario where the system will still =
hang
doing disk and network accesses under a moderate load of I/O.

Both of these tests are just to get a stable kernel before I really =
start
using Adeos.  So Adeos is in its default configuration and I haven't =
loaded
Xenomai modules when these hangs occur.

I'm currently running the 2.6.14.4 kernel with the 2.6.14-1.0-12 patch =
of
adeos and then I included your msi.c patch from the previous e-mail.  If =
you
have any further hints or suggestions I'll try them.  Meanwhile I'm =
trying
different versions of various drivers (e1000 and scsi) as well as =
updating
the patch level of the kernel itself.

Russ




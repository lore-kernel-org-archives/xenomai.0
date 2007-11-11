MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-ID: <18231.25399.331189.714344@domain.hid>
Date: Sun, 11 Nov 2007 21:16:55 +0100
In-Reply-To: <47373CB9.2010104@domain.hid>
References: <47373B12.7020808@domain.hid>
	<47373CB9.2010104@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] x86_64: problems with syscall tracing?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Jan Kiszka wrote:
 > > Philippe,
 > >=20
 > > you recently said there is a bug in the x86=5F64 support when sysc=
all
 > > tracing is enabled. Now I think I stepped on it as well: In order =
to
 > > validate my APIC frequency patches for that arch, I wanted to use =
LTTng
 > > there. But as soon as I start the trace, the latency test fails to=
 run,
 > > prematurely exiting due to a segfault.
 >=20
 > Exactly what Gilles sees on his box too, latency segfaulting at star=
tup.
 > On mine, the kernel does not even boot.
 >=20
 >  Gdb and the kernel say that user
 > > land jumped to address 0, I just yet failed to find out where they=
 come
 > > from. I strongly assume LTTng enables syscall tracing, because its=

 > > entry/exit instrumentations are inside the hook function
 > > (syscall=5Ftrace=5Fentry/leave).
 > >=20
 > > Do you have any further details on your tracing issue=3F Does may
 > > observation correlates with yours=3F
 >=20
 > Quite frankly, I did not dig the issue that far yet, but yes, my fir=
st
 > impression is that something is broken in the syscall return path (o=
r
 > entry=3F), and it shows when the return path to user-space is divert=
ed in
 > some way, either for security auditing, or likely for tracing like
 > you've just reported.

=46rom what I have read in some comments, the syscall auditing function
kmallocs some memory that is kfreed on syscall return. Obviously, this
can not work with Xenomai.

--=20


=09=09=09=09=09    Gilles Chanteperdrix.


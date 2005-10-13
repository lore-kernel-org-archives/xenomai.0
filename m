From: Paul <bdi-emc@domain.hid>
Subject: Re: [Xenomai-core] Future of fusion
Date: Thu, 13 Oct 2005 11:46:03 +0100
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
In-Reply-To: <434E19AD.4030500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200510131146.04013.bdi-emc@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi Philippe

On Thursday 13 October 2005 09:24, Philippe Gerum wrote:
> - Regular automated benchmarking: What is Xenomai currently capable of, h=
ow
> stable is it, do we progress or regress over time and releases, arch by
> arch?

Have a couple of x86 development boxes running 24/7 - Could set one up as a=
=20
compile farm for running automated builds. Also have a PowerPC thin client=
=20
that I would like to utilise, but could really do with some help in setting=
=20
up the tools for cross-compiling the base system under Debian.

> - Configuration, building and packaging issues: Could we make this easier?

Anything that involves patching/compiling kernels is bound to cause trouble=
=20
for new users. Perhaps some tests for kernel options known to cause trouble=
=20
(such as APM & REGPARM) that print out large warnings during the config sta=
ge=20
might help..

Gilles already has a tarball of the Debian rules I used for packaging fusio=
n.=20
With minor changes, these could be used for a Xenomai package. One=20
possibility is to use the rules and the compile farm to produce "ready to=20
run" kernel/Xenomai Debian packages.


Regards, Paul.



=2D-=20
=46rom the Klingon book of C:
Klingon function calls do not have 'parameters' - they have 'arguments' - a=
nd
they ALWAYS WIN THEM.


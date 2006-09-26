Date: Tue, 26 Sep 2006 16:56:56 +0200
Message-Id: <J67G6W$AFC4CDFDA31A148D03B70B64BA5713E3@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

---------- Debut du message initial -----------

De     : xenomai-core-bounces@domain.hid
A      : niklaus.giger@domain.hid
Copies : xenomai@xenomai.org
Date   : Tue, 26 Sep 2006 16:21:18 +0200
Objet  : Re: [Xenomai-core] Problem with periodic timer on
PPC40x solved

> > On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> > > > Am Montag, 25. September 2006 17:57 schrieb Philippe
Gerum:
> > > > > On Sun, 2006-09-24 at 23:07 +0200, Wolfgang
Grandegger wrote:
> > > > > > Niklaus Giger wrote:
> > <..>
> > > > Is the output of lines like "Xenomai: Switching
display-3238 to secondary
> > > > mode after exception #1025 from user-space at
0x100033c4 (pid 3240)"
> > > > harmless or the result of a activated
CONFIG_XENO_OPT_DEBUG<..> option?
> 
> A known hw issue seems to exist with the 405GP (revD), which
causes the
> ESR to be incorrectly set upon FPU emulation trap, which
would in turn
> cause the spurious exception to be relayed to the nucleus by
Adeos. The
> patch below is _not_ the final fix, but rather a way to
check if this
> message is indeed related to the FPU emulation on your
board. Does it
> silence the exception without breaking the box?

The FPU fault may be the result of the latency display thread
using the
FPU: on systems with emulated FPU, this looks normal.

-- 
                 Gilles Chanteperdrix=0A=0AAcc=E9dez au courrier =E9lectr=
onique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A



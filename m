From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
In-Reply-To: <742b47b4-5a36-c9eb-6446-f7f74584109d@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 22 Mar 2022 23:19:25 +0100
MIME-Version: 1.0
Message-ID: <d01-623a4b80-2b-400dfa00@254398969>
Subject: =?utf-8?q?Re=3A?= Bug in xenomai =?utf-8?q?3=2E2=2Ex?= on ARM
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

Le Mardi, Mars 22, 2022 19:57 CET, Jan Kiszka <jan.kiszka@siemens.com> =
a =C3=A9crit: 
 
> On 22.03.22 18:31, Greg Gallagher via Xenomai wrote:
> > On Tue, Mar 22, 2022 at 12:49 PM Fran=C3=A7ois Legal via Xenomai <
> > xenomai@xenomai.org> wrote:
> > 
> >> Hello,
> >>
> >> trying to port a running Xenomai 3.1.x/Linux 4.4.x system to Xenom=
ai
> >> 3.2.x/Linux 4.4.x running on Zynq7000, I found a (maybe) bug in in=
tr.c
> >>
> >> In xnintr=5Fattach, the call to ipipe=5Fset=5Firq=5Faffinity (when=
 in SMP) expects
> >> a 0 return code. However, on my platform, I end up in irq=5Fgic.c =
in
> >> gic=5Fset=5Faffinity() which returns IRQ=5FSET=5FMASK=5FOK=5FDONE =
(2) when everything
> >> is fine.
> >>
> >> This IRQ=5FSET=5FMASK=5FOK=5FDONE does not seem very common in the=
 kernel (I could
> >> find a few occurences, on Gic v3 so maybe AARCH64 has the same pro=
blem,
> >> plus some PCI devices).
> >>
> >> I was wondering if this was something to fix in ipipe or xenomai ?=

> >>
> >> Fran=C3=A7ois
> > 
> > 
> > Do the newer kernels have the same return value? Do we test 3.2.x o=
n the
> > older kernels? Maybe just cip ?
> > 
> 
> We limited testing to 4.4-cip with 3.0.x. Newer kernels require newer=

> Xenomai, and vice versa.
> 
> But let's first understand if the issue if 4.4-specific.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux
 
 In 4.4, gic=5Fset=5Faffinity returns IRQ=5FSET=5FMASK=5FOK (aka 0). In=
 4.19 is already returns IRQ=5FSET=5FMASK=5FOK=5FDONE , but in Xenomai =
3.1.x, there were no call to ipipe=5Fset=5Firq=5Faffinity AFAIK.

Fran=C3=A7ois



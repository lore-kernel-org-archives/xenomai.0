Date: Thu, 4 Apr 2019 12:47:10 +0200
From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: Re: Xenomai kernel for BBB
Message-ID: <20190404104710.zw3mkhiobnbhy75h@jholzmayr.localdomain>
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
 <4a8a6ec5-cc87-19b5-3ebe-8d0d6da6027b@xenomai.org>
 <072ec5f2-7bee-9cca-cdb6-040bb3afa59d@xenomai.org>
 <21a9ee2c-90e7-b6f3-f0cd-f57277f20a57@siemens.com>
 <20190404092408.rjfg5oxqpro6kn6q@jholzmayr.localdomain>
 <8dfef1e6-e2b0-dddb-755b-c994726419c4@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dfef1e6-e2b0-dddb-755b-c994726419c4@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@xenomai.org

On Thu, Apr 04, 2019 at 12:12:10PM +0200, Jan Kiszka wrote:
> On 04.04.19 11:24, Josef Holzmayr wrote:
> > On Thu, Apr 04, 2019 at 10:40:13AM +0200, Jan Kiszka via Xenomai wrote:
> > > On 04.04.19 10:31, Philippe Gerum via Xenomai wrote:
> > > > On 4/3/19 7:16 PM, Philippe Gerum wrote:
> > > > > On 4/3/19 9:55 AM, Pierre FICHEUX via Xenomai wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Xenomai kernel (-xenomai branches) is available for BBB (AM335x) from
> > > > > > https://github.com/beagleboard/linux for some kernel releases (4.4, 4.9,
> > > > > > 4.14). I've tried 4.9 and 4.14 but jitter is very bad with latency tool (>
> > > > > > 200 µs).
> > > > > > 
> > > > > > According to Xenomai wiki, AM335x SoC is supported for "vendor branch",
> > > > > > hope this is the same thing (?)
> > > > > > 
> > > > > > Dos anybody use AM335x with success? I did it a long time ago with Xenomai
> > > > > > 2 and 3.8.13 kernel.
> > > > > > 
> > > > > 
> > > > > CONFIG_ARM_CPUIDLE hurts badly on this platform, disabling it restores
> > > > > proper latency figures.
> > > > > 
> > > > > A quick port of the latest I-pipe code ported to the bbb kernel 4.14 can
> > > > > be pulled from this URL (lightly tested):
> > > > > https://lab.xenomai.org/ipipe-rpm.git/log/?h=arm/4.14.110-bbb
> > > > > 
> > > > 
> > > > too much haste: clone from [1], branch arm/4.14.108-bbb, which is based
> > > > on the 4.14 branch of the Beagleboard tree (as of yesterday).
> > > > 
> > > > [1] git://lab.xenomai.org/ipipe-rpm.git
> > > > 
> > > 
> > > Does the BBB really still need a vendor kernel? Definitely not for booting
> > > and core functionality.
> > > 
> > > Jan
> > 
> > It should already do pretty fine with 4.4-cip, as thats what I'm doing
> > my tests on.
> 
> Thanks, good to know.
> 
> BTW, if you have time to test the current ipipe-4.4.y[-cip] branches, I
> would also tag ARM stable releases for them.
> 
> Jan
> 

Sure, will do. Hopefully done by the end of next week, given the needed
~3 days for long term runs and I can't start until Monday.

Greetz
-- 
———————————————
Josef Holzmayr
Software Developer Embedded Systems

Tel: +49 8444 9204-48
Fax: +49 8444 9204-50

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
———————————————
Amtsgericht Ingolstadt – GmbH: HRB 191328 – KG: HRA 170393
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
Ust-IdNr: DE 128592548 

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548



Resent-Message-ID: <15669.29298.445006.354250@domain.hid>
Resent-To: adeos-main@gna.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15669.28279.21927.822316@domain.hid>
In-Reply-To: <OFCD857115.70858C2E-ONC1256BF9.004147F0@domain.hid>
References: <OFCD857115.70858C2E-ONC1256BF9.004147F0@domain.hid>
From: Philippe Gerum <rpm@xenomai.org>
Subject: [Adeos-main] Re: porting adeos to MIPS architecture
Date: Wed, 17 Jul 2002 15:17:43 +0200
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: toon.diels@domain.hid

Hi Toon,

toon.diels@domain.hid writes:
 > 
 > I am porting adeos-1.0 to a MIPS processor.

Bright and shinny day indeed ! :o)

 > Before I start rewriting the interrupt (and exception) pipe mechanism to MIPS architecture, I would like to ask the
 > ADEOS originators what they expect to be reused when doing an architecture port: eg is it just reusing the API or
 > do you also want to reuse the sources (and which ones).
 > 

The bottom line is of course keeping the API identical across
ports. Btw, please don't hesitate to suggest changes/extensions to
this API since everyone is welcome to participate in any part of this
project. The only thing that we must take care of is preventing Adeos
from bloating :o>

Now back to your question. The code layout for x86 was designed as
follows:

- kernel/adeos.c and include/linux/adeos.h contain
arch-independent stuff, so I guess that it should be possible to
port these files nearly as is, kernel header specifics kept apart.

- arch/i386/kernel/adeos.c, arch/i386/kernel/ipipe.c and
include/asm-i386/adeos.h are the arch-dependent parts of Adeos. If the
interrupt handling is that different on MIPS, I suspect that most of
ipipe.c has to be rewritten then, but this should be rather
straightforward since the code is (hopefully) simple.

Basically, the work done in ipipe.c comes down to:
	   - provide the interrupt and exception redirection/hooking
code (grabbing the IDT).
	   - implement the generic IRQ and exception handlers
	   - implement the IRQ and exception synchronization loop
called when the pipeline stage is unstalled.

arch/i386/kernel/adeos.c provides the domain switching code (rather
simple, just a lightweight stack switch) and a few other
arch-dependent implementations of services called from the generic part
in kernel/adeos.c. So I guess that this file is also candidate for
heavy changes across archs.

Other changes in the Linux tree are only aimed at trapping Linux
activity at the proper places to yield control to
Adeos when needed. include/asm-i386/system.h is pivotal since it
allows to control the interrupt pipeline. arch/i386/kernel/entry.S is
important too.

In any case, great care was taken to bracket _all_ the needed changes
to a vanilla Linux kernel between conditional blocks testing for the
CONFIG_ADEOS def/undef, just track them in C and assembly files. This
might not be very aesthetic, but this should be quite practical for
people doing ports.

 > I have added some visio drawings with respect to the MIPS interrupt/exception handling to indicate how this takes
 > place on a MIPS.
 > 
 > (See attached file: viper_irq_pipeline.vsd)(See attached file:
 > viper_irq.vsd)

I'll take a look at it since I'm an ignorant member of the peanut
gallery as far as the MIPS arch is concerned (along with a few
billions other things too ;o)

PS: I strongly suggest that you start working from Adeos milestone 2
(adeos-m2.tar.gz) which is now published on savannah. This milestone
is the stable one, M1 (1.0) was more like a proof-of-concept.
Incidentally, I've just finished the preliminary port of Adeos to
Linux/x86 2.5.25 in less than two days using this release, so I guess
it will be simpler for you too.

Cheers,

Philippe.


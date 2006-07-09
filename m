Subject: Re: [Xenomai-help] PB to patch a 2.6.16 kernel with
	an	adeos-ipipe-2.6.14-ppc
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44B13AC9.3050307@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290C8BBB60@domain.hid>
	<44B13AC9.3050307@domain.hid>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 19:32:33 +0200
Message-Id: <1152466354.5027.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-07-09 at 19:20 +0200, Jan Kiszka wrote:
> Thomas, Brieuc (GE Healthcare) wrote:
> > Hi everybody ! 
> > 
> > I've got a PPC-MPC8540 target with a 2.6.16 patch from the provider. I
> > would like to patch my 2.6.16 kernel with an adeos-ipipe-2.6.14-ppc. Has
> > somebody already done this?  
> > Up to now, I've done the patch manually and the compilation with
> > xenomai-2.1.2...
> 
> Migrating some version steps upward in 2.6.x can be problematic. Also
> the patches you got from the board vendor may collide with ipipe. What
> conflicts did you have to resolve? Were you able to verify if those were
> not related to relevant functional changes in the kernel?
> 
> > When I launch my target, the boot run without errors. But when I launch
> > an Xenomai application (like latency) I've got a "kernel oops" message
> > (during the task creation).
> 
> What does the oops precisely say, what's the backtrace about?
> 
> > can somebody help me to patch correctly my kernel?
> 
> Is your kernel patch publicly available? What parts does it touch
> (critical for ipipe are IRQ and timer management).
> 
> Maybe someone from the PPC fraction on this list can comment on the
> status of vanilla 2.6.16 vs. 2.6.14, also wrt ipipe/xenomai.

It's more an I-pipe issue than a Xenomai one. For the time being, 2.6.14
from kernel.org is the current version Adeos/ppc supports, until the
refactoring between arch/ppc and arch/powerpc the kernel folks are
currently having fun with, has been completed, especially for the
embedded side of the universe. The current Adeos 2.6.14/ppc patch also
applies cleanly against Denx's latest snapshot:
ftp://ftp.denx.de/pub/linux/linux-2.6.14.tar.bz2

-- 
Philippe.




From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1286981521.1759.83.camel@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid> <20101008070148.GB2255@domain.hid>
	<1286530884.13186.109.camel@domain.hid>
	<20101013090353.GA6902@domain.hid>
	<1286961375.1759.71.camel@domain.hid>
	<20101013092617.GB6902@domain.hid>
	<1286981521.1759.83.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Oct 2010 18:48:49 +0200
Message-ID: <1288025329.26618.132.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Machek <pma@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2010-10-13 at 16:52 +0200, Philippe Gerum wrote: 
> > 
> > Should we test IPIPE_STALL_FLAG on all but current CPUs?
> 
> That would solve this particular issue, but we should drain the pipeline
> out of any Xenomai critical section. The way it is done now may induce a
> deadlock (e.g. CPU0 waiting for CPU1 to acknowledge critical entry in
> ipipe_enter_critical when getting some IPI, and CPU1 waiting hw IRQs off
> for CPU0 to release the Xenomai lock that annoys us right now).
> 
> I'll come up with something hopefully better and tested in the next
> days.
> 

Sorry for the lag. In case that helps, here is another approach, based
on telling the pipeline to ignore the irq about to be detached, so that
it passes all further occurrences down to the next domain, without
handling any on the target domain anymore. Once this operation is done,
we are safe, and no handler for this interrupt could run in parallel on
other CPUs for the given domain, while we attempt to clear it in the
domain's IRQ descriptor. Said differently, the inserted code tells the
pipeline to skip the target domain when handling the interrupt.

For this to work, we have to ignore the irq before we enter the irqs off
section which disables the interrupt descriptor in Xenomai (breaking the
section across the IRQ unregistration call - i.e. xnarch_release_irq() -
would introduce a race). Patches against 2.6.35.7 and Xenomai 2.5.5.2,
but the backport should be reasonably straightforward.

HTH,

Cherry-pick these commits for the I-pipe part:
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=b786b2c5963d5884d60f265a6efc40276d8487e2
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=ca5f69024fec66c7b25d9b5b6507501c4a47c3a9


And the rest is on top of Xenomai 2.5.5.2:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=737e3bb09e2364658cfc59a0037f5e39a81fb799
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=5ee600768743906342a350ecbca51a01ca5689b4

-- 
Philippe.





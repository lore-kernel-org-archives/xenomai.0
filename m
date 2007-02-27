Subject: RE: [Xenomai-help] Kernel-OOps
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 15:38:14 +0100
Message-Id: <1172587094.27967.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-02-27 at 13:53 +0000, Daniel Schnell wrote:
> Daniel Schnell wrote:
> > Hi,
> > 
> > I have a bad Kernel-Ooops on my MPC5200B based PPC target.
> > Unfortunately not reproducable with a small application again.
> > I used a 2.4.25 based Denx Kernel (latest and greatest version) and
> > Xenomai - trunk with revision 2256.
> > 
> 
> 
> If I increase MAX_DELAYED_MM in linux/kernel/sched.c from 32 to 64 the
> OOPS disappears ....
> 

Which is normal, since this is the BUG_ON() statement in sched.c:558
that triggers.

> As we have quite a number of concurrent threads running (>50) could
> MAX_DELAYED_MM be depending on the number of threads in the system ?

Some usage patterns involving permanent mode switches inside a large set
of real-time threads that only rarely relinquish the CPU to other
regular Linux tasks may cause this. This is specific to 2.4 kernels. I
will raise this value in the next patch update. Thanks,

-- 
Philippe.




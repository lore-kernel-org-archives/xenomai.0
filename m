Message-ID: <4D93A416.2030800@domain.hid>
Date: Wed, 30 Mar 2011 23:43:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>	<1301041270.2079.8.camel@domain.hid>	<AANLkTikkkj0GTbpG2m8ozy8TjTJ1Yz0CHoU4FEP8dqsS@mail.gmail.com>	<1301083171.3221.93.camel@domain.hid>	<AANLkTinANQJYmAi942WcvnGWL4FZFJBo4S6-WxG2obKH@mail.gmail.com>	<1301086366.3221.105.camel@domain.hid>	<AANLkTin6ooP_SZpNoTW3+Wb_0GA2U7SotV6LTeH_qOnY@mail.gmail.com>	<1301460841.2092.10.camel@domain.hid>
	<AANLkTi=BQfeyZ-SRP8=+QX-ufwQVd=bjMw_d6bQp3KM0@domain.hid>
In-Reply-To: <AANLkTi=BQfeyZ-SRP8=+QX-ufwQVd=bjMw_d6bQp3KM0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling questions...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

Eric Eric wrote:
> Thanks Philippe.  I was thinking of avoiding POSIX only because some
> of my colleagues have noticed severe performance hits using non-native
> skins in commercial RTOSs, particularly Integrity.  Would you expect
> POSIX performance to be roughly the same as native?

Hi Eric,

posix and native are both skins implemented using the same internal
services, so, their performances should be comparable. If you find some
posix service much slower than its native counterpart, we would consider
it a bug.

> TP is interesting, and may work for my applications since we are likely to
> do much of our real-time work in-kernel to get the absolute minimum
> latency possible.

On what hardware? On a typical x86 machine, the user-space performances
 are sufficient for a large majority of applications. Besides, there are
other points to consider than performance in order to choose between
kernel-space and user-space:
- kernel-space code is harder to debug, this results in longer time to
complete your project;
- kernel-space code is covered by the GPL license;
- imitating what you do with the Linux kernel, you can split the code
between application and driver, the driver going to kernel-space and
being implemented on top of the RTDM skin;
- Xenomai kernel-space APIs will be discontinued in Xenomai 3.x branch
(except, obviously, the RTDM skin).

I would go the other way: first try user-space, if performances are not
sufficient, they try and find other ways, maybe changing hardware for
instance, move time critical parts in an RTDM driver, and move the
application to kernel-space only as the last resort.

> 
> On a related note, I noticed on page 14 of
> http://retis.sssup.it/~lipari/courses/str09/12.xeno-handout.pdf that
> when Xenomai is in secondary mode, all Linux interrupts are stalled.
> This would seem to imply that doing something like select in a Xenomai
> user-task would be problematic, as we would have wait until Linux goes
> into background mode to unstall Linux interrupts.  Is there any way
> around this?  The slide suggests that this behavior is "to reduce
> latency" although I suspect there may be other motivations.

The irq shield is not available in recent versions of Xenomai. But when
it was still there, obvious cases such as a thread suspending after
entering secondary mode were handled by disabling the shield in that
case: the shield was only enabled when a Xenomai thread was running in
secondary mode, not when it was suspended.

Regards.

-- 
                                                                Gilles.


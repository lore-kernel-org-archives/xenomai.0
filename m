Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <452E9ACD.20800@domain.hid>
References: <452E9ACD.20800@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:00:23 +0200
Message-Id: <1161964824.4983.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-10-12 at 21:43 +0200, Jan Kiszka wrote:
> Hi,
> 
> here we go: after quite some hacking and refactoring, Dmitry and I are
> happy to provide a patch set that reworks and enhances the statistics
> subsystem of Xenomai.
> 
> The original goal of these patches was to improve the accuracy of the
> /proc/xenomai/stat CPU load output. So far it only accounted thread
> switches. The time of potential preceding IRQ handling and scheduling
> decision was added to the preempted thread. The new approach avoids
> this. More about it later.
> 
> While discussing the first implementation, Dmitry had the idea to
> refactor even more code that depends on XENO_OPT_STATS, means event
> counting parts under the upcoming generic runtime stats. So this series
> starts with a patch to introduce a generic subsystem for collecting
> statistics on countable events as well as the runtime of entities.
> 
> It continues with the second patch that applies xnstat on the IRQ
> subsystem, both for counting hits as well as for measuring the execution
> time. The accounting model applied in this patch is as simple as this:
> measure the time some driver- or application-supplied ISR executes and
> accumulate it per-CPU. The rescheduling is still accounted to the
> preempted thread.
> 
> In my endless quest for perfection, I applied an -as I feel- enhanced
> model on top of this (already working!) set, that's the third patch.
> This model adds the scheduler path to the IRQ account. And it only
> accounts to an IRQ if its ISR reported XN_ISR_HANDLED. This is relevant
> for shared IRQs when only one source fired (the typical case). Also, it
> reduces churning by avoiding account switches in the average case. But,
> the downside, it may be less convenient to understand and increases the
> code a bit (only for the shared IRQ case). Dmitry and I were not yet
> able to agree on THE model, so I'm simply posting both for public
> feedback. :)

All merged, thanks.

-- 
Philippe.




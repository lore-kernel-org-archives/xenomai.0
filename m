Message-ID: <5215F23E.3030102@xenomai.org>
Date: Thu, 22 Aug 2013 13:13:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5215C4FE.707@inmess.de>
In-Reply-To: <5215C4FE.707@inmess.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] two dd processes: soft lockup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benedikt Boeck <benedikt.boeck@inmess.de>
Cc: xenomai@xenomai.org

On 08/22/2013 09:59 AM, Benedikt Boeck wrote:
> Hello,
> 
> I got a problem. After starting two dd processes (if=/dev/zero 
> of=/dev/null), I get first a few messages about soft lockup:
> kernel:[...] BUG: soft lockup - CPU#. stuck for ..s! [dd:...]
> and little later a
> Kernel panic - not syncing: Fatal exception in interrupt
> 
> But if I had running xeno-test before and then starting two dd processes 
> I don't get a soft lockup. Strange?
> 
> Also there is no soft lockup with a kernel identical till a deactivated 
> CONFIG_XENOMAI.
> A deactivated CONFIG_SMP also prevent the error. But I like to have both 
> cores. Trying all four variants of CONFIG_SCHED_SMT=y/n and 
> CONFIG_SCHED_MC=y/n didn't effect the error.
> 
> Tested with different kernel versions (3.4.6, 3.5.7, 3.8) always with 
> matching ipipe patch.  I think with 3.8 I didn't get a kernel panic but 
> still soft lockups.
> Using Xenomai 2.6.2.1 and haven't tried other versions yet. The 
> processor is a Celeron Dual-Core T3100.
> 
> Does somebody have a idea? Maybe I just made a simple (but effective) 
> mistake.

What does:
cat /proc/xenomai/timer
cat /proc/timer_list
say? before you start anything?

Do you have the problem if you disable CONFIG_NO_HZ?

-- 
                                                                Gilles.


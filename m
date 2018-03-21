References: <20111223173309.GM27742@domain.hid> <4F045578.7090405@domain.hid>
 <414a96f6-a471-c0d0-4199-f7eacf6ef1da@frank-benkert.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <53afdf9c-33a4-bc60-d3f9-291477aa3f24@xenomai.org>
Date: Wed, 21 Mar 2018 17:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <414a96f6-a471-c0d0-4199-f7eacf6ef1da@frank-benkert.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y
 causes random process corruption in xenomai 2.6.0 on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frank Benkert <xenomai@frank-benkert.de>, xenomai@xenomai.org

On 03/21/2018 04:40 PM, Frank Benkert wrote:
> Sorry for pumping this old topic, but it needs some clarification:
> 
> For all of you who find this thread via search engines because you are
> looking for sporadic crashes on Xenomai PowerPC in relation to task
> switches:
> This patch does not fix the problem - at least not in our case. After
> several years, the problem suddenly appeared with us, as we are now
> increasingly using the Ethernet interface on our old product. Maybe the
> new interrupt load triggers this old bug.
> 
> There is a patch in Xenomai 3 which removes the buggy feature because of
> problems with the MMU.

No, the commit you are referring to reads as this:

commit 323824258692a6d175881d18a644b276858b353d
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Sat Nov 14 16:41:13 2015 +0100

    cobalt/powerpc: drop support for unlocked context switch

    This feature never actually brought any measurable gain on powerpc
    platforms, compared to the complexity of its implementation in the
    pipeline. It was primarily aimed at reducing latency for interrupt
    handlers when costly cache and TLB flushes are required to switch
    context, at the expense of increasing the scheduling latency.  It
    turned out to be counter-productive on common powerpc platforms, with
    efficient MMUs.

    This feature has been default off for a while now, and 4.1+ pipelines
    won't provide support for it anymore. Time to drop support from
    Xenomai too.

This was a decision based on the unfavorable performance vs complexity
ratio, not because of any pending bug that could not be fixed.

> The only way to fix these sporadic crashes is to disable the switch
> (CONFIG_XENO_HW_UNLOCKED_SWITCH=n).
> 

Possibly not, because your reasoning assumes that only the IRQ pipeline
might be involved in dealing with unlocked switching, which is wrong.
The Xenomai core is involved too, as hinted by the commit log above. If
you are actually running the stock 2.6.0 release, another attempt at
addressing the random crash issue would be to merge this commit:

commit ffc58d175a4e6f335c0e42946fa45ca984a93ce4
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Jan 4 14:14:11 2012 +0100

    hal/powerpc: plug race in thread context switch

    Since rthal_thread_switch() is entered with hw IRQs enabled when
    CONFIG_XENO_HW_UNLOCKED_SWITCH is in effect, we ought to mask them
    around the register swap. This is in essence an overdue fix for the
    issue spotted and solved quite some time ago by Jesper Christensen,
    see: https://mail.gna.org/public/xenomai-core/2011-04/msg00095.html.

    Configurations with CONFIG_XENO_HW_UNLOCKED_SWITCH disabled are immune
    to this issue.

-- 
Philippe.


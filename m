From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
 <44d11e1akp.fsf@be-well.ilk.org>
Date: Fri, 09 Feb 2018 10:00:26 -0500
In-Reply-To: <44d11e1akp.fsf@be-well.ilk.org> (Lowell Gilbert's message of
 "Fri, 09 Feb 2018 09:50:30 -0500")
Message-ID: <448tc21a45.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

Lowell Gilbert <kludge@be-well.ilk.org> writes:

> To put it another way, I'm trying to figure out what am I doing wrong in:
> 		ret = rtdm_timer_start(&pstate.collect.timer, rtdm_clock_read() + 1,
> 				       pstate.collect.period,
> 				       RTDM_TIMERMODE_RELATIVE);

On second thought, and application of more coffee, that's clearly
wrong. My putting a zero in for the second parameter (as I did
originally) seems like what I would expect to work.


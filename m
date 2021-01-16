References: <20210115011639.15390-1-hongzhan.chen@intel.com>
 <20210115011639.15390-6-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 6/8] cobalt/timer: pipeline: abstract signal test of
 XNTSTOP
In-reply-to: <20210115011639.15390-6-hongzhan.chen@intel.com>
Date: Sat, 16 Jan 2021 16:11:51 +0100
Message-ID: <87eeiksyq0.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


hongzha1 via Xenomai <xenomai@xenomai.org> writes:

> The I-pipe kind of internally "emulates" a shutdown+restart sequence
> automatically upon resuming a timer after the ONESHOT_STOPPED state, so
> we actually do not need XNTSTOP in this case. We should
> specifically abstract the single test of XNTSTOP when arming a
> timer, so that the Dovetail version does the right thing.
> We can leave XNTSTOP in the set/clear mask bits operations in either
> the I-pipe and Dovetail cases, this has zero overhead since other bits
> are being set/cleared in these operations anyway.
>

This change log is confusing: citing one of my past remarks it seems, it
explains how we should be abstracting XNTSTOP, but the patch actually
introduces it. Therefore we should explain _why_ we are introducing
XNTSTOP in the first place, then maybe retain the last paragraph only to
justify some details of the implementation.

The patch actually adds a way to force the timer management code to
reprogram the hardware on option, to make the real device controlled by
the proxy tick again as it leaves the ONESHOT_STOPPED mode. We should go
on saying that the I-pipe does not require any further action in this
case, leading to a nop (for this patch). Patch 7/10 would then implement
the Dovetail side, which does require the next tick to be force
programmed in the hardware as a result of leaving the ONESHOT_STOPPED
mode.

-- 
Philippe.


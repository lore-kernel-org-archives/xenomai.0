References: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: "rtdm/nrtsig: move inband work description off the stack"
Message-ID: <87lf83cj7k.fsf@xenomai.org>
In-reply-to: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
Date: Tue, 25 May 2021 10:46:19 +0200
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> [1] makes rtdm_schedule_nrt_work a rather heavyweight service, compared
> to what it was (and even over I-pipe). xnmalloc is nothing you would
> expect from a "send a signal" service, specifically from
> rtdm_nrtsig_pend which does not even make use of the sending extra payload.
>
> Can we do better? Also for xnthread_signal (fd and udd usecases are not
> time-sensitive anyway).
>

Nope, I cannot see any significantly better option which would still
allow a common implementation we can map on top of Dovetail / I-pipe.

-- 
Philippe.


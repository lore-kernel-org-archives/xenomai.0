References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org>
 <f369db49a43257fc7e7ae3f800dc1dbaed79f624.camel@siemens.com>
 <878s731csg.fsf@xenomai.org>
 <3867420a5cd0e2fd37a8036865f53a0881aef236.camel@siemens.com>
 <8735xb1bvl.fsf@xenomai.org> <87v9a7z0xh.fsf@xenomai.org>
 <8aeab853e8ff206dda95e115d2e97e787378168f.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
In-reply-to: <8aeab853e8ff206dda95e115d2e97e787378168f.camel@siemens.com>
Date: Wed, 10 Mar 2021 19:14:08 +0100
Message-ID: <87y2euho5r.fsf@xenomai.org>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@kylinos.cn" <chensong@kylinos.cn>


florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:

> On Thu, 2021-03-04 at 11:08 +0100, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>> > florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:
>> > 
>> > > On Thu, 2021-03-04 at 10:35 +0100, Philippe Gerum wrote:
>> > > > florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:
>> > > > 
>> > > > > On Sat, 2021-02-20 at 16:18 +0100, Philippe Gerum via Xenomai wrote:
>> > > > > [snip]
>> > > Adding the full code:
>> > > 
>> > > static inline int sem_fetch_timeout(struct timespec64 *ts,
>> > > 				    const void __user *u_ts)
>> > > {
>> > > 	return u_ts == NULL ? -EFAULT :
>> > > 		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
>> > > }
>> > > 
>> > > Copying sizeof(*ts) is to much if the application provided
>> > > "__old_time_t" (sizeof(time_t) =4) only. Isn't it? I would expect the
>> > > result (in ts) to be garbage. Due to different padding the "sec" field
>> > > (in ts) would now contain the nsec value from u_ts as well.
>> > > 
>> > 
>> > Ah, I was looking at the wrong path (32emu). Yes, this is broken for
>> > mere 32bit now (i.e. natively 32bit platform).
>> 
>> We could simply use cobalt_get_u_timespec() instead of open coding the
>> call to cobalt_copy_from_user(). Condvars have this right already,
>> mutex, mq and sema4s have their fetch_timeout() helper broken
>> indeed. Good spot.
>> 
>
> I had a look at the affected mutex syscalls today.
> pthread_mutex_timedlock() has the well known "The validity of the
> abs_timeout parameter need not be checked if the mutex can be locked
> immediately." as well.
>
> Could someone please confirm that Xenomai is already validating the
> supplied timeout even if the mutex could be taken immediately? Maybe
> I'm missing something.
>

Yes it does, and probably should not for consistency with other calls.

> Should we fix that as well? Any advice how to do so?
>
> Starting point: 
> __cobalt_mutex_timedlock_break()
> 	__cobalt_mutex_timedlock_break(): Validation before calling
> 		__cobalt_mutex_acquire_unchecked()
>
> If I'm right, the problem was once fixed with:
> 860ea449a298 ("cobalt/posix/mutex: fix timeout handling in pthread_mutex_timedlock()")
>
> but broken again in:
> c53a9dd3ebc7 ("cobalt/posix/mutex: prepare for 32bit syscall emulation")
>
>
> 		

The less intrusive way would be to try lock first calling
xnsynch_try_acquire(), then fallback to xnsynch_acquire() if
failed. This is likely to become the hot path for this code, assuming a
mutex is most often unlocked on entry.

We are all locked under the big ugly nklock at this point, so there
should be nothing to care about preemption-wise.

-- 
Philippe.


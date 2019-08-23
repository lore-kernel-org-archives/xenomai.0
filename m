Subject: Re: A potential Xenomai Mutex issue
References: <DM6PR07MB596162CF3DD4EB4071336D26E7A50@DM6PR07MB5961.namprd07.prod.outlook.com>
 <43f9470f-ed47-0a2a-71f5-ca9bca08879a@siemens.com>
 <DM6PR07MB59614BFAE90AE8DA6B49769EE7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2f51ad42-4be3-606d-dbdf-ee036bd562de@siemens.com>
Date: Fri, 23 Aug 2019 16:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB59614BFAE90AE8DA6B49769EE7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "DIAO, Hanson (DI PA CI RC R&D SW2)" <hanson.diao@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.08.19 16:02, DIAO, Hanson (DI PA CI RC R&D SW2) wrote:
> Hi Jan,
> 
> Thank you for your reply. I will answer the questions one by one.
> 
> Q: This is on a ARMv7 multicore target, rightIs?
> HD: This is PowerPC target.
> 
> Q: Are you already able to reproduce the issue reliably, possibly in a synthetic environment?
> HD: It reproduces every time for the first issue and second issue(recursive lock lock count should be more than 1).
> 

Your dump was talking about "count = 1", but the counter variable is called 
"lockcnt".

> Q:  Or does your whole stack have to run on the target for a long time to trigger this?
> HD: I got this issue when the system was in initialized stage. It is easy to trigger this and every time it happens.

Can you extract a simple (and, thus, shareable) test case from that?

> 
> Q: the mutex shared between multiple process or just between threads of the same process?
> HD: The mutex shared only in one process with multi-tasks.
> 
> Q:Maybe something analogously was needed for native as well. And then you could look at what happened in 3.x mutex-wise to check if you are not missing a conceptual fix in 2.6.
> HD: I will check the commit message. I compared 2.6.4 version with 2.6.5 version. It seems that the code are same in mutex(User space mutex).

Yes, the mutex patch in 2.6.5 was targeting only the posix skin. I didn't look 
into detail, but maybe that fix should have been applied to the native 
implementation as well. The problem is that at this point development moved on 
to 3.x, and there is only one implementation (which received such a fix as well).

> 
> Q:You seem to look at the wrong data structure. You need to examine RT_MUTEX_PLACEHOLDER fields.
> HD: The data structure which I got is RT_MUTEX_PLACEHOLDER fields. I attached the code as below.
> 
> typedef struct rt_mutex_placeholder {
> 
>          xnhandle_t opaque;
> 
> #ifdef CONFIG_XENO_FASTSYNCH
>          xnarch_atomic_t *fastlock;
> 
>          int lockcnt;
> #endif /* CONFIG_XENO_FASTSYNCH */
> 
> } RT_MUTEX_PLACEHOLDER;

See my remark above in lockcnt.

Jan

> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Friday, August 23, 2019 2:48 AM
> To: DIAO, Hanson (DI PA CI RC R&D SW2) <hanson.diao@siemens.com>; xenomai@xenomai.org
> Subject: Re: A potential Xenomai Mutex issue
> 
> On 22.08.19 20:42, DIAO, Hanson via Xenomai wrote:
>> Hi all,
>>
>>
>>
>> I hope you are doing well. Currently I was working on a critical deadlock issue with Xenomail Library(version 2.6.4). I found that for the Xenomai lock count is not reliable after we called rt_mutex_release. I print the following message to you. I hope some developer can help me fix this issue. I know that this version is EOL, but we still use this old version. Thank you so much.
>>
> 
> This is on a ARMv7 multicore target, right? Are you already able to reproduce the issue reliably, possibly in a synthetic environment? Or does your whole stack have to run on the target for a long time to trigger this? Is the mutex shared between multiple process or just between threads of the same process?
> 
> Next point: You are on 2.6.4 while the last release was 2.6.5. It contained e.g.
> 8047147aff9d (posix/mutex: handle recursion count completely in user-space).
> 
>>
>>
>> Issue 1:
>>
>> Before Mutex Lock Mutext addr = 0xb7c059e8,count = 0, owner = 0     This message show the status before rt_mutex_acquire.
>>
>> After Mutex Lock Mutext addr = 0xb7c059e8,count = 1, owner = 2bd   This message show the status after calling rt_mutex_acquire.     Everything is right for the rt_mutex_acquire in this scenario.
>>
>>
>>
>> Before Mutex unLock Mutext addr = 0xb7c059e8,count = 1, owner = 2bd   This message show the status before rt_mutex_release.
>>
>> After Mutex unLock Mutext addr = 0xb7c059e8,count = 1, owner = 0          This message show the status after rt_mutex_release. It seems that the lock count is not correct after call rt_mutex_release.
>>
> 
> 
>>
>>
>> Issue 2:
>>
>> When our task is call recursive lock. The mutex lock count should more than 1, but the lock count is still 1.
>>
>>
>>
>> For the issue 1, I guess that there are something wrong in the release function. I highlighted the code. I am not sure if it is the root cause.
>>
> 
> Don't use HTML emails on public lists. They often get filtered, at latest on receiver side.
> 
> Jan
> 
>>
>>
>> int rt_mutex_release(RT_MUTEX *mutex)
>>
>> {
>>
>> #ifdef CONFIG_XENO_FASTSYNCH
>>
>>           unsigned long status;
>>
>>           xnhandle_t cur;
>>
>>
>>
>>           cur = xeno_get_current();
>>
>>           if (cur == XN_NO_HANDLE)
>>
>>                   return -EPERM;
>>
>>
>>
>>           status = xeno_get_current_mode();
>>
>>           if (unlikely(status & XNOTHER))
>>
>>                   /* See rt_mutex_acquire_inner() */
>>
>>                   goto do_syscall;
>>
>>
>>
>>           if (unlikely(xnsynch_fast_owner_check(mutex->fastlock, cur)
>> != 0))
>>
>>                   return -EPERM;
>>
>>
>>
>>           if (mutex->lockcnt > 1) {
>>
>>                   mutex->lockcnt--;
>>
>>                   return 0;
>>
>>           }
>>
>>
>>
>>           if (likely(xnsynch_fast_release(mutex->fastlock, cur)))
>>
>>           {
>>
>>                   return 0;
>>
>>           }
>>
>> do_syscall:
>>
>> #endif /* CONFIG_XENO_FASTSYNCH */
>>
>>
>>
>>           return XENOMAI_SKINCALL1(__native_muxid,
>> __native_mutex_release, mutex);
>>
>> }
>>
>>
>>
>>
>>
>>
>>
>> For the Mutex lock function, I am so confused with the following comments which I highlighted as below. I am not sure if it supports the recursive lock.
>>
>> static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout,
>> xntmode_t mode)
>>
>> {
>>
>>           int err;
>>
>> #ifdef CONFIG_XENO_FASTSYNCH
>>
>>           unsigned long status;
>>
>>           xnhandle_t cur;
>>
>>
>>
>>           cur = xeno_get_current();
>>
>>           if (cur == XN_NO_HANDLE)
>>
>>                   return -EPERM;
>>
>>
>>
>>           /*
>>
>>            * We track resource ownership for non real-time shadows in
>>
>>            * order to handle the auto-relax feature, so we must always
>>
>>            * obtain them via a syscall.
>>
>>            */
>>
>>           status = xeno_get_current_mode();
>>
>>           if (unlikely(status & XNOTHER))
>>
>>                   goto do_syscall;
>>
>>
>>
>>           if (likely(!(status & XNRELAX))) {
>>
>>                   err = xnsynch_fast_acquire(mutex->fastlock, cur);
>>
>>                   if (likely(!err)) {
>>
>>                           mutex->lockcnt = 1;
>>
>>                           return 0;
>>
>>                   }
>>
>>
>>
>>                   if (err == -EBUSY) {
>>
>>                           if (mutex->lockcnt == UINT_MAX)
>>
>>                                   return -EAGAIN;
>>
>>
>>
>>                           mutex->lockcnt++;
>>
>>                           return 0;
>>
>>                   }
>>
>>
>>
>>                   if (timeout == TM_NONBLOCK && mode == XN_RELATIVE)
>>
>>                           return -EWOULDBLOCK;
>>
>>           } else if (xnsynch_fast_owner_check(mutex->fastlock, cur) ==
>> 0) {
>>
>>                   /*
>>
>>                    * The application is buggy as it jumped to secondary
>> mode
>>
>>                    * while holding the mutex. Nevertheless, we have to
>> keep the
>>
>>                    * mutex state consistent.
>>
>>                    *
>>
>>                    * We make no efforts to migrate or warn here. There
>> is
>>
>>                    * XENO_DEBUG(SYNCH_RELAX) to catch such bugs.
>>
>>                    */
>>
>>                   if (mutex->lockcnt == UINT_MAX)
>>
>>                           return -EAGAIN;
>>
>>
>>
>>                   mutex->lockcnt++;
>>
>>                   return 0;
>>
>>           }
>>
>> do_syscall:
>>
>> #endif /* CONFIG_XENO_FASTSYNCH */
>>
>>
>>
>>           err = XENOMAI_SKINCALL3(__native_muxid,
>>
>>                                   __native_mutex_acquire, mutex, mode,
>> &timeout);
>>
>>
>>
>> #ifdef CONFIG_XENO_FASTSYNCH
>>
>>           if (!err)
>>
>>                   mutex->lockcnt = 1;
>>
>> #endif /* CONFIG_XENO_FASTSYNCH */
>>
>>
>>
>>           return err;
>>
>> }
>>
>>
>>
>>
>>
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


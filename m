References: <55A7CF2E.40508@xenomai.org>
 <1320019080.4249709.1438096751088.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B8A722.5070405@xenomai.org>
Date: Wed, 29 Jul 2015 12:12:50 +0200
MIME-Version: 1.0
In-Reply-To: <1320019080.4249709.1438096751088.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/28/2015 05:19 PM, Frederik Bayart wrote:
>>> ./stest --session=foo 1
>>>
>>> The first process binds to the named semaphore which is not yet created. According to the description of rt_sem_bind,  if the object does not exist on entry, the caller may block until a semaphore of the given name is created.
>>>
>>> So based on this description, I would I expect that if the second process is started, the first process would bind and continue and blocks in the p operation. The same for the 2nd process. Is this correct ? At the moment, if I start the 2nd process, I get a segfault in rt_sem_create :
>>>
>>> [ 9758.887921] [Xenomai] switching main to secondary mode after exception #14 from user-space at 0x7f6ad8c4a43e (pid 9256)
>>> [ 9758.887930] main[9256]: segfault at 7f903bf6e038 ip 00007f6ad8c4a43e sp 00007fffbd2c2eb8 error 6 in libcobalt.so.2.0.0[7f6ad8c3d000+1e000]
>>>
>>
>> Looking at the copperplate code, yep, this definitely can't work. Ok,
>> queued.
> 
> I noticed also :
> 
>  ./stest --session=foo 1
>  ./stest --session=foo 0
> 
> Both processes are waiting in rt_sem_p . The first process catches SIGINT, the second doesn't. If you press CTRL+C on the second process it stops but also the first process is falling through the rt_sem_p although no rt_sem_v is raised.


Spurious wake up in the Cobalt kernel when aborting a sem wait operation
due to a signal/unblock event, that is the reason why I could not see
this from a Mercury setup. This is fixed in the -next branch.

> At that moment no process is pending on rt_sem_p anymore. But if you do then a rt_sem_inquire, nwaiters is still 1.

I don't observe this one. Assuming you enabled the registry, what does
/var/run/xenomai/.../alchemy/semaphores/semtestsem tell you about the
sema4 value?

-- 
Philippe.


Message-ID: <4399B6B8.8030209@domain.hid>
Date: Fri, 09 Dec 2005 17:54:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] user memory leakage on rt_task_delete
References: <43986AFA.6060908@domain.hid>
In-Reply-To: <43986AFA.6060908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi all,
> 
> during my ongoing search for the init/cleanup issue of shadow threads, I
> stumbled over another problem: Deleting a userspace native thread that
> is blocked in primary mode does not let the NPTL clean up all resources
> allocated in userspace. If you plan to do some rt_task_create/delete in
> a loop, you will soon run out of memory (and Mr. oom-killer will show
> up...).
> 
> I haven't found a solution for this beyond letting a rt-task always
> terminate itself (or terminate the whole program after forced
> deletions). If there is no solution, we should at least document this
> fact somewhere.
> 
> Again, it's not a common use case, but it's also not an expectable
> behaviour of the native skin.
> 

I see no possible workaround to allow a shadow thread deletion from 
kernel space while still leaving the opportunity for the NPTL thread to 
perform some user-space cleanups; recycling a previous Xenomai context 
to unwind a Linux context would lead to some terminally broken 
situation, so the nucleus must reap the terminated shadow at kernel 
level asap. However, the rt_task_delete() wrapper from the user-space 
support library might preferably pthread_kill() the thread, instead of 
asking the nucleus for that purpose.

-- 

Philippe.


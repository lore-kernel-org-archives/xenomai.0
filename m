Message-ID: <4461C5D9.3060705@domain.hid>
Date: Wed, 10 May 2006 12:52:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid>
In-Reply-To: <4461BB5A.3010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> 
> Indeed, this solves the issue more gracefully.
>
> Looking at this again from a different perspective and running the test
> case with your patch in a slightly different way, I think I
> misinterpreted the crash. If I modify task2 like this
> 
> void task2_fnc(void *arg)
> {
>         printf("started task2\n");
>         if (rt_mutex_lock(&mtx, 0) < 0) {
>                 printf("lock failed in task2\n");
>                 return;
>         }
> //        rt_mutex_unlock(&mtx);
> 
>         printf("done task2\n");
> }
> 
> I'm also getting a crash. So the problem seems to be releasing a mutex
> ownership on task termination. Well, this needs further examination.
>

The native skin does not implement robust mutex, indeed.

> Looks like the issue is limited to cleanup problems and is not that
> widespread to other skins as I thought. RTDM is not involved as it does
> not know EINTR for rtdm_mutex_lock. The POSIX skins runs in a loop on
> interruption and should recover from this.
>

I can confirm with the help of the simulator that there's no issue 
regarding the way the ownership is transferred back and forth between 
both tasks, this works. However, I agree that this should not preclude 
us from improving the priority inversion guard, by allowing the lock to 
be stolen if the new owner has not resumed execution yet, after it has 
been granted the mutex ownership.

> Besides this, we then may want to consider if introducing a pending
> ownership of synch objects is worthwhile to improve efficiency of PIP
> users. Not critical, but if it comes at a reasonable price... Will try
> to draft something.
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.


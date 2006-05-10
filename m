Message-ID: <4462172C.7090503@domain.hid>
Date: Wed, 10 May 2006 18:39:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <4461C5D9.3060705@domain.hid>
	<4461D331.8040906@domain.hid>
In-Reply-To: <4461D331.8040906@domain.hid>
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
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Dmitry Adamushko wrote:
>>>
>>>Indeed, this solves the issue more gracefully.
>>>
>>>Looking at this again from a different perspective and running the test
>>>case with your patch in a slightly different way, I think I
>>>misinterpreted the crash. If I modify task2 like this
>>>
>>>void task2_fnc(void *arg)
>>>{
>>>        printf("started task2\n");
>>>        if (rt_mutex_lock(&mtx, 0) < 0) {
>>>                printf("lock failed in task2\n");
>>>                return;
>>>        }
>>>//        rt_mutex_unlock(&mtx);
>>>
>>>        printf("done task2\n");
>>>}
>>>
>>>I'm also getting a crash. So the problem seems to be releasing a mutex
>>>ownership on task termination. Well, this needs further examination.
>>>
>>
>>The native skin does not implement robust mutex, indeed.
> 
> 
> Yeah, lunch opened my eyes: the skin data structure (RT_MUTEX) is not
> updated appropriately on task cleanup. What about some callback hook in
> xnsynch_t to invoke a per-skin cleanup handler when running
> xnsynch_release_all_ownerships?
> 

Yep, we need this. Added by commit #1067 (i.e. 
xnsynch_register_cleanup()) and also backported to the maintenance 
branch, so that new code may happily rely on it without too much 
portability burden.

-- 

Philippe.


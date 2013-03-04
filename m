Date: Mon, 04 Mar 2013 16:25:27 +0100
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
References: <20130228094644.5CCB8C91@centrum.cz>,
	<512FB7B0.1040003@xenomai.org>,
	<20130301095437.EB654F58@centrum.cz> <51309A54.7090101@xenomai.org>
In-Reply-To: <51309A54.7090101@xenomai.org>
MIME-Version: 1.0
Message-Id: <20130304162527.FF8FFE8D@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] =?utf-8?q?mutex_problem?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Now I can confirm, that the problem didn't disappeared. It just moved els=
ewhere.
Another mutex stays locked  and another thread is endlessly waiting for i=
ts release. But this time, its less critical combination of mutex / threa=
d (and less frequently used).
Is there anything I can check or try?

Petr

PS: When I'm thinking about it, the mutex is again one of the first mutex=
es (if not completely first) created in the application. Even before rt_t=
ask_shadow(...).


>
>> SOLVED (perhaps)
>>=20
>>>=20
>>>> Hello.
>>>>=20
>>>> I have a problem with a mutex shared by 3 real-time user tasks.
>>>> Once in a while (~hours) the mutex get locked with the first task
>>>> as owner and the other two tasks are fronzen on rt_mutex_aquire
>>>> calls. But I have double checked, that every "acquire" of that
>>>> mutex is followed by "release".
>>>>=20
>>>> Typical example: Lets call those tasks REG, SEND, RECEIVE
>>>>=20
>>>> RECV: acquire RECV: release
>>>>=20
>>>> RECV: acquire RECV: release
>>>>=20
>>>> RECV: acquire - FREEZE
>>>>=20
>>>> REG: acquire REG: release
>>>>=20
>>>> REG: acquire REG: release
>>>>=20
>>>> REG: acquire REG: release
>>>>=20
>>>> SEND: acquire - FREEZE
>>>>=20
>>>> There are also other threads, sync. objects, network sockets, ...
>>>> in the system, but the threads are frozen by this particular
>>>> mutex. rt_task_unblock call unblocks the tasks, return value of
>>>> rt_mutex_acquire is -4 (-EINTR), as expected. Used version of
>>>> Xenomai 2.5.6, skin native. Was there any known issue similar to
>>>> that behavior? Also it seems that rt_mutex_create is called
>>>> before mlockall call? Could it be a problem?
>>>=20
>>>=20
>>> It is a bit old to recall. Could you try and reproduce the problem
>>> with 2.6.2.1 ?
>>>=20
>>=20
>> I tried to use new version of everything (kernel 3.5.7, xenomai
>> 2.6.2.1, ...) and I got some exception to the kernel log in
>> rt_mutex_create. So I suppose that the problem was caused by calling
>> of rt_mutex_create before mlockall. I already fixed it and now I'm
>> waiting for some longer term results. I for now it seems to be
>> SOLVED. If not, I will let you know. Thank you for your support.
>
>
>It is not expected to get a crash, though, will try and see if I can
>reproduce the problem.
>


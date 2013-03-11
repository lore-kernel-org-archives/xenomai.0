Date: Mon, 11 Mar 2013 11:35:13 +0100
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
References: <20130228094644.5CCB8C91@centrum.cz>,
	<512FB7B0.1040003@xenomai.org>,
	<20130301095437.EB654F58@centrum.cz> <51309A54.7090101@xenomai.org>
In-Reply-To: <51309A54.7090101@xenomai.org>
MIME-Version: 1.0
Message-Id: <20130311113513.D17FAEF8@centrum.cz>
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
To: Xenomai <xenomai@xenomai.org>

The problem with mutexes is still present. I'm really desperate now. Does=
 anyone know, how the mutex could "stay locked" when every "acquire" is s=
ooner or later followed by "release" and both functions always return 0 (=
success) code?
Every advice is appreciated.

Petr

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
>--=20
>                                                                Gilles.
>


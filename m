Message-ID: <5871.81.252.86.91.1211789666.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<5481.62.39.72.60.1211293804.squirrel@domain.hid> 
	<18483.10408.141546.420660@domain.hid> 
	<2336.81.252.86.91.1211379896.squirrel@domain.hid> 
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid> 
	<15059.81.252.86.91.1211386718.squirrel@domain.hid> 
	<18484.28025.505865.374746@domain.hid> 
	<12142.81.252.86.91.1211467896.squirrel@domain.hid> 
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid> 
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
Date: Mon, 26 May 2008 10:14:26 +0200 (CEST)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>> However, When I executed my big application, the system crashed when a
>> thread seemed to call pthread_cond_wait. I m not sure, in this
>> application, there are a lot of threads. The kernel trace when the
>> system
>> crashed is : Xenomai: fatal: Relaxing a kicked thread(thread=3DDialogu=
e
>> serie 1, mask=3D200)?!
>> That is what you planned. What does this message mean ?
>
> It means that the way the Posix skin passes real-time signals to
> secondary mode is currently broken. Because they cause the target
> threads to switch to secondary mode, I guess nobody use them, so I
> advise you to stop using them as well until they get fixed (but even
> if we fix them, they will always cause the target thread to switch to
> secondary mode). Note that most posix services have "timed" variants
> which allow setting a timeout, such as pthread_mutex_timedlock,
> sem_timedwait, pthread_cond_timedwait, etc... so, you really do not
> need timers to set up a timeout.
>

Yes, but currently, in my big application, when a thread sets up a
timeout, it happens that the thread continues to execute code. In fact,
when the timeout end signal arrives, the handler is executed and a
semaphore is posted to a timeout thread. This timeout thread analyzes
which timeouts are finished and indicates it to pertained threads thanks
to a condvar or a flag variable.
So if I use pthread_mutex_timedlock, sem_timedwait or
pthread_cond_timedwait, I can't have this behaviour. A thread is
inevitably in waiting if it calls these functions.

>> I tried to reproduce this issue with a small test program but I didn't
>> succeed.
>>
>> I ve got a test program with this issue, but it's the one in which I v=
e
>> got a lock in the time-out end routine. (pthread_cond_broadcast) I
>> posted
>> it in the mailing list and you corrected it.
>> I replaced the mutex use by a semaphore.
>
> You mean you replaced a condvar by a semaphore ?
>

Yes

>>
>> Otherwise, I ve got an other test program in which there are 3 real-ti=
me
>> threads. Time-outs are created dynamically and have the same duration.
>> (5ms)
>> I ve a display function, to display traces on the console. (use write
>> function)
>> The threads :
>>        threadTimeOut : creates and deletes time-outs
>>        threadTimeOutEnd :  waits the end of a time-out (sem_wait) and
>> indicates
>> it to threadTimeOut
>>        threadDisplay : calls display function in a loop.
>>
>> When I execute this program, there is a system crash. the kernel trace
>> is
>> : Xenomai: fatal: inserting element twice, holder=3Dc7761c78,
>> qslot=3Dc7761160
>> at include/xenomai/nucleus/queue.h:321
>> I don't execute it without your patch.
>
> Ok. To know exactly what happens we should put a call to
> show_stack(NULL, NULL) in the queue debugging code. But I will do this
> myself, I will try your test program.
>

Ok , I corrected all your remarks. Do you have results with my test
program?  do you have a system crash with the same error message ?

Thanks a lot for your help.



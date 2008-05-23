Message-ID: <2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
Date: Fri, 23 May 2008 15:55:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2405.81.252.86.91.1211549465.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Fri, May 23, 2008 at 3:31 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> On Thu, May 22, 2008 at 4:51 PM, Fabien MAHOT
> <fabien.mahot@domain.hid> wrote:
>>> Hello,
>>>
>>> Thanks to a serial console, I obtained the kernel traces before the cra=
sh
>>> when I executed Cyclictest.
>>> However, I could not have the same error : kernel panic - not syncing:
>>> Aiee, killing interrupt handler. The system crashed like before, withou=
t
>>> error message.
>
>> I do not understand what you mean. You tell us that you get no traces,
>> but then shows some traces.
>
>> Anyway, could you enable the Xenomai nucleus debugging ? In
>> particular, I would be interested to know if you get the fatal "Error
>> relaxing a kicked thread".
>
>
> sorry, my english is bad. I would like to say that I had not the explicit
> error message kernel panic - not syncing: Aiee, killing interrupt handler
>
>
>> On Thu, May 22, 2008 at 4:51 PM, Fabien MAHOT
>> <fabien.mahot@domain.hid> wrote:
>>> I also tried without your patch, and when I stopped Cyclictest, there
>>> was
>>> no problem !
>>
>> Ah! You put interesting information in the middle of I-pipe tracer
>> traces, how do you want me to discover them ? So, this is a bug caused
>> by my patch. In my patch, do you get better results if you do not set
> the XNKICKED bit ?
>>
>> --
>>  Gilles
>>
>
> yes, I cancelled XNKICKED in xnthread_set_info call. And, it's better,
> there is no problem when I stop Cyclictest.
> With my sem_wait test program, sem_wait returns an error when a signal of
> time-out end unlocks it, so that's good.
> And , I no longer have system crash after the sem_wait call.
>
> However, When I executed my big application, the system crashed when a
> thread seemed to call pthread_cond_wait. I m not sure, in this
> application, there are a lot of threads. The kernel trace when the system
> crashed is : Xenomai: fatal: Relaxing a kicked thread(thread=3DDialogue
> serie 1, mask=3D200)?!
> That is what you planned. What does this message mean ?

It means that the way the Posix skin passes real-time signals to
secondary mode is currently broken. Because they cause the target
threads to switch to secondary mode, I guess nobody use them, so I
advise you to stop using them as well until they get fixed (but even
if we fix them, they will always cause the target thread to switch to
secondary mode). Note that most posix services have "timed" variants
which allow setting a timeout, such as pthread_mutex_timedlock,
sem_timedwait, pthread_cond_timedwait, etc... so, you really do not
need timers to set up a timeout.

> I tried to reproduce this issue with a small test program but I didn't
> succeed.
>
> I ve got a test program with this issue, but it's the one in which I ve
> got a lock in the time-out end routine. (pthread_cond_broadcast) I posted
> it in the mailing list and you corrected it.
> I replaced the mutex use by a semaphore.

You mean you replaced a condvar by a semaphore ?

>
> Otherwise, I ve got an other test program in which there are 3 real-time
> threads. Time-outs are created dynamically and have the same duration.
> (5ms)
> I ve a display function, to display traces on the console. (use write
> function)
> The threads :
>        threadTimeOut : creates and deletes time-outs
>        threadTimeOutEnd :  waits the end of a time-out (sem_wait) and ind=
icates
> it to threadTimeOut
>        threadDisplay : calls display function in a loop.
>
> When I execute this program, there is a system crash. the kernel trace is
> : Xenomai: fatal: inserting element twice, holder=3Dc7761c78, qslot=3Dc77=
61160
> at include/xenomai/nucleus/queue.h:321
> I don't execute it without your patch.

Ok. To know exactly what happens we should put a call to
show_stack(NULL, NULL) in the queue debugging code. But I will do this
myself, I will try your test program.

>    display("TimeOutCreation thread\n");
>        pthread_mutex_lock(&main_start_lock);
>        while (!bMainStart)
>        {
>       pthread_cond_wait(&start_signal, &main_start_lock);
>    }

This is bad, if pthread_cond_wait fails for one reason or another, you
end up with a system lock up. Better test its return value, and call
exit if it fails for any reason.

>    pthread_mutex_unlock(&main_start_lock);
>    display("TimeOutCreation thread\n");
>
>    while (1)
>    {
>          do
>          {
>             bSemWaitError =3D false;
>             if ((sem_wait(&TimeOutWait_sem)) < 0)
>             {
>                 display("sem_wait error - errno : %d  -> %s\n",errno,
> strerror(errno));
>                 if (errno =3D=3D EINTR) // la tache appelant sem_wait a =
=E9t=E9
> d=E9bloqu=E9e de son attente par un signal d'interruption
>                             {
>                      bSemWaitError =3D true;
>                 }
>             }
>          }while (bSemWaitError);
>
>          pthread_mutex_lock(&timeOutEnd_lock);
>          if((pthread_cond_broadcast(&TimeOutEnd_signal)) < 0)
>          {
>              display("pthread_cond_broadcast error - errno : %d  ->
> %s\n",errno, strerror(errno));
>              exit(0);
>          }
>          bTimeOutEnd =3D true;
>          pthread_mutex_unlock(&timeOutEnd_lock);
>    }
> }
>
> void* threadTimeOut(void * arg) {
>    int i=3D1;
>    int j, k, NbTimeOut, numTimeOut;
>
>    timeOut0_ptr =3D timeOut1_ptr =3D timeOut2_ptr =3D timeOut3_ptr =3D
> timeOut4_ptr =3D NULL;
>
>        display("TimeOut thread\n");
>        pthread_mutex_lock(&main_start_lock);
>        while (!bMainStart)
>        {
>       pthread_cond_wait(&start_signal, &main_start_lock);
>    }

Ditto.

>    pthread_mutex_unlock(&main_start_lock);
>    display("TimeOut thread\n");
>
>    while (i < 100)
>    {
>          // Malloc and start of time out
>          for (j=3D0 ; j < NB_PTR_TEMPO; j++)
>          {
>              switch(j)
>              {
>              case 0 : if (timeOut0_ptr =3D=3D NULL)
>                       {
>                          timeOut0_ptr=3D(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                          if (timeOut0_ptr =3D=3D NULL) exit(1);
>                          timeOut0_ptr->number =3D i;
>                          i++;
>                          display("Start of time out %d - 5ms\n",
> timeOut0_ptr->number);
>                          StartTimeOut(0,500000000,timeOut0_ptr);
>                       }
>                       break;
>              case 1 : if (timeOut1_ptr =3D=3D NULL)
>                       {
>                          timeOut1_ptr=3D(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                          if (timeOut1_ptr =3D=3D NULL) exit(1);
>                          timeOut1_ptr->number =3D i;
>                          i++;
>                          display("Start of time out %d - 5ms\n",
> timeOut1_ptr->number);
>                          StartTimeOut(0,500000000,timeOut1_ptr);
>                       }
>                       break;
>              case 2 : if (timeOut2_ptr =3D=3D NULL)
>                       {
>                          timeOut2_ptr=3D(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                          if (timeOut2_ptr =3D=3D NULL) exit(1);
>                          timeOut2_ptr->number =3D i;
>                          i++;
>                          display("Start of time out %d - 5ms\n",
> timeOut2_ptr->number);
>                          StartTimeOut(0,500000000,timeOut2_ptr);
>                       }
>                       break;
>              case 3 : if (timeOut3_ptr =3D=3D NULL)
>                       {
>                          timeOut3_ptr=3D(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                          if (timeOut3_ptr =3D=3D NULL) exit(1);
>                          timeOut3_ptr->number =3D i;
>                          i++;
>                          display("Start of time out %d - 5ms\n",
> timeOut3_ptr->number);
>                          StartTimeOut(0,500000000,timeOut3_ptr);
>                       }
>                       break;
>              case 4 : if (timeOut4_ptr =3D=3D NULL)
>                       {
>                          timeOut4_ptr=3D(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                          if (timeOut4_ptr =3D=3D NULL) exit(1);
>                          timeOut4_ptr->number =3D i;
>                          i++;
>                          display("Start of time out %d - 5ms\n",
> timeOut4_ptr->number);
>                          StartTimeOut(0,500000000,timeOut4_ptr);
>                       }
>                       break;
>              }
>          }
>
>          pthread_mutex_lock(&timeOutEnd_lock);
>          while (!bTimeOutEnd)
>          {
>                if
> ((pthread_cond_wait(&TimeOutEnd_signal,&timeOutEnd_lock))
> < 0)
>                {
>                   display("pthread_cond_wait error - errno : %d  ->
> %s\n",errno, strerror(errno));
>                   exit(0);

pthread_cond_wait never returns a negative error and does not set
errno, it returns the error directly.

--=20
 Gilles


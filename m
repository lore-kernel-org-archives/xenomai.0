Message-ID: <55DB7455.1000902@laposte.net>
Date: Mon, 24 Aug 2015 21:45:25 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
References: <55D773A6.8060107@laposte.net>
 <20150821212238.GF12742@hermes.click-hack.org>
In-Reply-To: <20150821212238.GF12742@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] Demo example of a simple periodic thread for Xenomai
 (Posix API)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Le 21/08/2015 23:22, Gilles Chanteperdrix a =E9crit :
> On Fri, Aug 21, 2015 at 08:53:26PM +0200, Marc Le Douarain wrote:
>> Hello eveybody,
>>
>> As I haven't found a little example of a periodic thread written in Posi=
x,
>> I've tried to do it.
>>
>> Here you will find joined the demo files example.
>> It can be (cross-)compiled for :
>> - Standard Linux
>> - Xenomai 2
>> - Xenomai 3
>> In the Makefile, comment 2 lines MY_CFLAGS & MY_LDFLAGS to compile for
>> standard Linux.
>>
>> Hope it can be helpfull for other people,
>> and many thanks for any comments or mistakes reports on it !
>> OUPPSS, JUST SEEN that XENOMAI version 3 is doing 'modes switches'... so
>> there is something bad! Any idea ?
>>
>> Perhaps to include a basic example like this one in the "demo" directory=
 of
>> Xenomai would be interesting!?
>>
>> Best regards.
>>
>> PS: I have beed disapointed at the start to discover no more
>> pthread_make_periodic_np() & pthread_wait_np() functions with
>> Xenomai 3.
> These functions were there to help porting legacy code from RTLinux,
> they were not really meant to be used in new code.
Started with it to have real-time under Linux a long time ago now ! ;-)
(but as many people I suppose, except too youngs...)
>> But
>> finally now with a timerfd we can have the same sourcecode with standard
>> Linux, so not too bad ! ;-)
>> And also no more the "__XENO__" define, but also usefull for conditional
>> compilation, with the new "__COBALT__" !
>>
>>
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: demo_periodic_thread_posix.c
>>
>> (...)
>>
>> int CreatePosixTask( char * TaskName, int Priority, int StackSizeInKo, u=
nsigned int PeriodMicroSecs, void * (*pTaskFunction)(void *) )
>> {
>> 	pthread_attr_t ThreadAttributes;
>> 	pthread_attr_init(&ThreadAttributes);
>> 	pthread_attr_setdetachstate(&ThreadAttributes, PTHREAD_CREATE_DETACHED =
/*PTHREAD_CREATE_JOINABLE*/);
>> #if defined(__XENO__) || defined(__COBALT__)
>> 	pthread_attr_setschedpolicy(&ThreadAttributes, SCHED_FIFO);
>> 	struct sched_param paramA =3D { .sched_priority =3D Priority };
>> 	pthread_attr_setschedparam(&ThreadAttributes, &paramA);
> A call to pthread_attr_setinheritsched is missing here. The default
> for inheritsched is PTHREAD_INHERIT_SCHED, which means the new
> thread inherits the main thread scheduling policy and priority,
> which is usually SCHED_OTHER and 0 (unless you run the program with
> chrt), in which case the newly created thread switches back to
> secondary mode after every primary mode switch.
>
Thanks for the tip,
modified my example (and also added some errors messages, seen stack =

asked too little!), and now no more Modes SWitches under Xenomai 3, nice !
See files included.
Now, if time, I will be able to continue to test with an application a =

little bigger on Xenomai 3 (ClassicLadder)...

Best regards.
Marc.

-------------- next part --------------
# MakeFile for demo of a simple periodic thread using Posix
# under 'standard' Linux
# and under Xenomai versions 2 and 3 using posix skin
# Marc Le Douarain, august 2015

#CROSS :=3D arm-linux-gnueabi-


# For a 'standard' application...
MY_LDFLAGS =3D -lpthread
# Comment theses 2 lines for a 'standard' application...
MY_CFLAGS =3D `xeno-config --skin posix --cflags`
MY_LDFLAGS =3D `xeno-config --skin posix --ldflags`

CC :=3D ${CROSS}gcc

all: demo_periodic_thread_posix

OBJS :=3D demo_periodic_thread_posix.o

demo_periodic_thread_posix: ${OBJS}
	${CC} -o $@ ${OBJS} $(MY_LDFLAGS)

clean:
	-rm -f core ${OBJS} demo_periodic_thread_posix

demo_periodic_thread_posix.o: demo_periodic_thread_posix.c
	${CC} -c $< -o $@ $(MY_CFLAGS)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: demo_periodic_thread_posix.c
Type: text/x-csrc
Size: 5597 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150824/cefcf519/at=
tachment.c>

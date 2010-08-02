From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C562838.8050000@domain.hid>
References: <4C562838.8050000@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 07:42:58 +0200
Message-ID: <1280727778.6700.70.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared memory between a Xenomai user task and a
 standard Linux process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-08-01 at 19:06 -0700, Bob Feretich wrote:
> I understand that a RT_PIPE is the preferred way to move data between 
> a rt user task and a standard Linux process, but I have a large amount 
> of data to move per second and I would like to minimize the number of 
> times that the data is copied.

Yes, RT_PIPEs are specifically aimed at this.

To be precise, RT_PIPE used to be the preferred way, but since 2.5-rc4
and the introduction of the RTDM-based rtipc driver, it is recommended
to rely on the XDDP protocol from that driver.

XDDP stands for "cross-domain datagram protocol"; it is semantically
100% compatible with RT_PIPE, but exports a posixish socket interface
for sending/receiving messages. Since this is RTDM-based, you can use
the rt_dev_* API from user-space instead, if you want to link against
the Xenomai native API only (and not the POSIX one).

The reason to deprecate RT_PIPEs at some point in favor of XDDP is that
Xenomai 3.x will not support the kernel-based programming model for apps
anymore, so the RT_PIPE calls in kernel space will disappear. On the
other hand, the driver-to-driver RTDM interface will remain, so that any
RTDM driver can send/receive data to/from some XDDP socket by calling
the appropriate rtipc driver routine. Besides, such a datagram-based
protocol maps nicely on the socket semantics.

This said, RT_PIPEs will remain available to the 2.5.x series.

> 
> My rt user task performs several tasks that need to be time 
> deterministic. I also want to store a history of its activity in a 
> standard Linux file. Adequate buffering is available so that the file 
> writing and management does not need to be done in real time.
> 
> Ideally, I would like to share a block of memory (~128KB) between the rt 
> user task and a standard Linux process which performs the file activities.
> 
> The documentation indicates that many API calls are available to "user 
> tasks", but I assume that unless "Linux process" is explicitly mentioned 
> (as in the case of "pipe") these references apply only to rt user tasks. 
> Am I correct?

Actually, you have two kinds of Xenomai threads in userland which may
access any Xenomai service, including blocking ones, and generally
speaking, any service which requires the caller to be known from the
Xenomai core:

- common rt threads. Those are assigned a runtime priority > 0 when you
create them via rt_task_create/rt_task_shadow using the native API
(1-99); they are mapped on the SCHED_FIFO policy when operating in
secondary mode.

- non-rt threads, but still Xenomai threads. Those are assigned a zero
priority value. They are mapped on the SCHED_NORMAL/OTHER policy when
operating in secondary mode, but still have access to primary mode, just
like any rt threads does. In primary mode, they do not compete for the
CPU with Xenomai rt threads though, they are scheduled when no rt
activity remains. However, because they may enter primary mode, they may
do whatever a rt Xenomai thread does, like pending on a Xenomai
synchronization object (RT_SEM, RT_QUEUE, ...), because they are known
from the Xenomai core (in short: they have a thread control block and a
scheduling slot there). The only difference is their lower (Xenomai)
priority.

> 
> Is there a shared memory mechanism that works between a rt user task and 
> a standard Linux process?
> 

RT_HEAP would do. Synchronization could be done between the rt and
non-rt domains based on RT_SEM/RT_MUTEX, provided the Linux process is
actually a non-rt Xenomai thread. This said, this would introduce a
potential for priority inversion, since your non-rt thread could hold
the critical section for an unbounded amount of time, while the rt
thread attempts to enter it. Using RT_QUEUEs would avoid this.

> Is there a way to operate a RT_PIPE in a zero copy mode? That is, the rt 
> user task constructs the message in the in the same buffer that is made 
> accessible a standard Linux process to perform a fwrite() from it.
> 

No, zero-copy is not possible with RT_PIPE, but you can do that with
RT_QUEUE (see rt_queue_alloc/send - rt_queue_receive/free), provided the
Linux process is actually a non-rt Xenomai thread, so that it can
receive from the queue in blocking mode. In fact, RT_QUEUE objects are
underlaid by a shared memory area between kernel and user-space.

> Also, what what exactly does the poolsize parameter of pipe_create 
> module do?
> I assume that it is specified in units of bytes.

Yes.

>  My message size is 16KB 
> and a message will be sent about every 140 milliseconds. I expect that 
> no more than 2 or 3 messages will queue up before the "standard Linux 
> process" can consume them, but for safety I want to allow for 8 (128KB). 
> Will a poolsize of 128KB sufice or is the pool also consumed by other 
> invisible things too?

A non-zero poolsize causes a dedicated, channel-specific pool (of that
size) to be created for your new data path, so nothing else may tap into
it. If CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ is non-zero, a buffer of that
size (in bytes) will be reserved from the pool, for managing the
streaming mode for the new channel though.

> 
> Regards,
> Bob Feretich
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.




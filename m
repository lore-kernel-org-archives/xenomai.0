Message-ID: <4F27A52E.2070608@domain.hid>
Date: Tue, 31 Jan 2012 09:24:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1327992003.514524717@domain.hid>
In-Reply-To: <1327992003.514524717@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Sharing of access to RT_MUTEX, RT_QUEUE,
	and RT_TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Doug Brunner <dbrunner@domain.hid>
Cc: Xenomai-help@domain.hid

On 01/31/2012 07:40 AM, Doug Brunner wrote:
> I'm working on an application where it would be convenient for several tasks within the same process to share access to single descriptors for mutexes, queues, and tasks, rather than each task having to separately bind to each one and keep its own RT_MUTEX/RT_QUEUE/RT_TASK.
>
> The documentation doesn't seem to speak to this issue, and I haven't been able to find a definitive answer through searches. Can anyone clarify whether or not this will lead to problems, e.g. task A is in the midst of locking a mutex when task B starts trying to obtain a lock itself, and bad results occur?

Descriptors in user-space only contain handles to kernel objects, they 
carry no object properties; on the contrary, their kernel space 
counterparts do carry object information.

So, from user-space, you can share descriptors between threads which 
belong to the same process freely. The same way, cloning a descriptor in 
user-space using bitwise-copy does produce a valid descriptor to the 
original object.

Binding is meant to be used in two cases:
- when the original object descriptor is not in the same address space 
(i.e. created by a different process, or created in kernel space)
- when the caller wants to wait for some object to be created, in which 
case the binding operation provides the required synchronization 
mechanism as a bonus.

In the case you describe, there is no problem in considering object 
descriptors as globally shared variables.

>
> Thanks,
>      Doug Brunner
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.


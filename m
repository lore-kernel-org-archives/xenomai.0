Date: Wed, 12 Oct 2005 07:47:36 -0700
Subject: Re: [Xenomai-help] remove_proc_entry problem semi-tracked down
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF727018.17FB%steve@domain.hid>
In-Reply-To: <434D21A7.8040905@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


EIP is at remove_proc_entry+0x20/0x120

__registry_proc_callback
__registry_proc_callback
__registry_proc_callback
worker_thread
default_wake_function
worker_thread
kthread
kthread
kernel_thread_helper


On 10/12/05 7:45 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
>> The kernel panic in remove_proc_entry happens when a userspace fusion app
>> calls a xenomai function that deletes something from the register in atexit.
>> For example, I have a set of c++ classes that wrap mutexes, queues, etc. If
>> I have a global instance, it sometimes causes a kernel panic in the
>> destructor where the rt_mutex_delete, rt_queue_delete, etc, is called. This
>> seems to always happen with rt_queue_delete, but not always with
>> rt_mutex_delete. (A couple of starts/stops seem to create the problem.)
>> 
>> This is when exiting with a call to exit(0), not with a control-c.
>> 
> 
> Please (re)send the panic stack dump you get.



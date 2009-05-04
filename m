Date: Mon, 04 May 2009 10:24:49 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200905041024.27896@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<1241103352.26544.177.camel@domain.hid> <49F9C374.1040209@domain.hid>
In-Reply-To: <49F9C374.1040209@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


Gilles Chanteperdrix wrote:
>Philippe Gerum wrote:
>> On Thu, 2009-04-30 at 07:09 -0700, Thomas Lockhart wrote:
>>>> Hello, I have a problem with rtdm_event_timedwait() function. It
>>>> sometimes ends prematurely with -EINTR error code. It depends on
>>>> special circumstances (CPU load, resizing console window in X, ...).

>> 
>> Just to clarify a few points more:
>> 
>> Xenomai always tells the kernel that blocking (Xenomai) syscalls
>> _should_ be restarted when interrupted by a Linux signal (i.e.
>> -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
>> case), and the kernel will actually restart that (Xenomai) syscall if no
>> handler was installed for such signal, or if SA_RESTART is set in the
>> sigaction() flags for the signal.
>> 

>> 
>> Additionally, syscalls may be forcibly unblocked via rt_task_unblock(),
>> which will cause -EINTR to be returned to the caller as well. This is
>> totally unrelated to Linux signal management though.
 the case, it means that we have quite a few syscalls to fix...
>

It seems that rt_task_unblock is not called, because the rt_event_wait is restarted.

>Also, from your mail, it is not clear to me, what is Petr problem,
>rtdm_event_timedwait ? or rt_event_wait.
>

I have ported a device driver fragment to rtdm. I have a problem with rtdm_event_timedwait() function that sometimes returns -EINTR.
In that driver (in IOCTL handling), when a signal is received the -ERESTARTSYS is returned. So the syscall is restarted and takes more time.
Similar situation is in reading from device (using DMA). But when the signal is received there (instead of waiting for interrupt), error happens.
So I wanted to find the source of the -EINTR return values. I created a simple example with alternative function (rt_event_wait()) to examine it's behavior.

I can perhaps fix it by calling rtdm_event_timedwait() again when a signal is received. But do you have any advice how to prevent the signals to happen or what is causing them?

Petr



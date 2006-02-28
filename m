Date: Tue, 28 Feb 2006 08:27:32 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029B9F4.258E%steve@domain.hid>
In-Reply-To: <440473CA.6000205@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Actually the player would never miss a job, because the call to resume was
only made if the task is suspended. As with any /dev/dsp device, data in the
buffer has to be a certain size before it starts playing, so every call to
the driver's write command would check the state of the task and resume it
if necessary. :) It's crude but it works. I wrote that driver when I was
very inexperienced with RTOSs and was just using it as an example. I think
that code is over 4 years old.

Steven

On 2/28/06 8:01 AM, "Jan Kiszka" <jan.kiszka@domain.hid> wrote:

> Steven Seeger wrote:
>> Well, the thread suspends when it's done playing, and when new data arrives
>> in the buffer via /dev/dsp, the thread is then resumed. I just wonder what
>> the point of suspend/resume is, then, if we're supposed to just use
>> rt_task_set_periodic to create a new timeline. Right now I am doing this,
>> and then suspending, and then before I resume, I make another timeline.
>> 
> 
> Well, and this is racy in case the resume - for what reason ever - takes
> place before the suspend. It will get lost then, and your player will
> miss a job. One should better model this via an event (don't count
> multiple wakeups) or a semaphore (each wakeup counts and is paired with
> a wait in the player task).
> 
> Jan
> 



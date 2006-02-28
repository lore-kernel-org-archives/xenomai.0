Date: Tue, 28 Feb 2006 07:46:20 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029B04C.2587%steve@domain.hid>
In-Reply-To: <44046F8E.9010309@domain.hid>
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

Well, the thread suspends when it's done playing, and when new data arrives
in the buffer via /dev/dsp, the thread is then resumed. I just wonder what
the point of suspend/resume is, then, if we're supposed to just use
rt_task_set_periodic to create a new timeline. Right now I am doing this,
and then suspending, and then before I resume, I make another timeline.

Steven

On 2/28/06 7:43 AM, "Jan Kiszka" <jan.kiszka@domain.hid> wrote:
> 
> Simply stop the related timer when the job is done
> (rt_task_setperiodic...). What should be the reason to keep *this*
> particular timeline for the next output job? Does the DAC has its own
> timer? Then you would have to synchronise on that one anyway. Otherwise,
> you should better restart the periodic output as soon as the next job
> arrives - with a new timeline. And it might be cleaner to use a real
> synchronisation mechanism for the wakeup, something like an event or a
> semaphore (suspend/resume is evil - mostly).
> 
> Jan
> 
> 



Message-ID: <4B9B8020.1080605@domain.hid>
Date: Sat, 13 Mar 2010 13:08:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CB@MAIL02.ug.kth.se>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CB@MAIL02.ug.kth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM rtdm_task_sleep in kernel not always wakes
 up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Huan Fang <huanf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Huan Fang wrote:
> Hello. I am writing a driver using RTDM. Just for testing, I have a
> rt kernel thread waiting for event signal sent from nrt_ioctl. After
> the thread is activated, it calls rtdm_task_busy_sleep(100000); then 
> rtdm_task_sleep(100000); When the RT thread is really sleeping, the
> nrt_ioctl resumes and sleeps via wait_event_interruptible_timeout(2
> jiffiles).
> 
> Normally, RT thread wakes up after 100us. But the thread seems to
> hang after 20-30 such loops and never wake up. When I kill the
> process. I saw that wait_event_interruptible_timeout returns a -512.
>  The worse thing is I saw kernel panic sometimes during such context
> switches.

Hi,

If you are using wait_event_interruptible_timeout from the context of a
xenomai thread running in primary mode, it is normal to get kernel
oopses. If you do not do that, then I did not get your explanation, and
I think the best thing to do is to send us a self contained example,
including driver code and user-space code. Something that we can compile
and run to see what you are observing.

Regards.

-- 
					    Gilles.


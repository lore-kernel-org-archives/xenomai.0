From: Jeff Koftinoff <jeffk@domain.hid>
In-Reply-To: <4648D7AF.7080409@domain.hid>
References: <4648C077.2050003@domain.hid> <4648C26F.1020002@domain.hid>
	<4648CA4E.70904@domain.hid>  <4648D7AF.7080409@domain.hid>
Content-Type: text/plain
Date: Mon, 14 May 2007 17:33:05 -0700
Message-Id: <1179189185.30085.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_set_periodic and different time base
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
Cc: xenomai@xenomai.org

On Mon, 2007-05-14 at 23:42 +0200, Jan Kiszka wrote:
> Jeff Koftinoff wrote:
> > Because I have many layers of audio processing procedures that need to
> > be scheduled at different periodic intervals, with different priorities.
> > lower level audio processing procedures run every 166 microseconds and
> > have highest priority, and interrupt higher level lower rate (5.3
> > ms,10.66 ms and 32 ms) control processing procedures.
> 
> So they are all multiples of the base period? Why not let the high-rate
> tasks wake the low-rate ones when time has come, e.g. via semaphores?
> 

Thanks for the info. I'll try it out like this - one thread which waits
on the interrupt, and then have it selectively wake up lower priority
tasks after it finishes the most important ones based on the count. I
just thought it would be nicer to do all timing in terms of the audio
samples - as all processing that we do is directly related to the audio
rate.


Regards,

Jeff Koftinoff
www.jdkoftinoff.com




From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <352932.35036.qm@domain.hid>
References: <352932.35036.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Dec 2009 15:52:20 +0100
Message-ID: <1262011940.19080.334.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] signaling to a thread waiting on an event in the
 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-12-28 at 01:59 -0800, Yigal Goldberger wrote:
> Hi,
> 
> I want to have the ability to restart a process at all times.
> I have a situation where a thread is waiting on an event in the kernel with : 
> rtdm_event_timedwait(&args,0,NULL)

>   - infinite wait (I need this infinite wait ...) 
> 
> and I cannot restart it with  :
> 
> kill(Pid,SIGTERM) .
> 
> from a different process .
> 
> Suggestions are most welcome.
> 

Please be more specific:

- what happens when SIGTERM is sent, exactly? does your app hang on the
RTDM syscall invoking rtdm_event_timedwait() from your driver, or does
the entire system lock up badly?
- did you check whether rtdm_event_timedwait() returned with an error
code, such as -EINTR?
- which platform, whick kernel release, which Xenomai release are you
running?

Btw, rtdm_event_wait(&event) is a shorthand for
rtdm_event_timedwait(&event,0,NULL).

> Yigal Goldberger.
> 
> 
> 
> 
>       
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.




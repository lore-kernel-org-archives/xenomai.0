Message-ID: <49B8F602.9090808@domain.hid>
Date: Thu, 12 Mar 2009 12:46:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>	<49B8EE0A.3050708@domain.hid>
	<E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
In-Reply-To: <E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm timer questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I will ask Mark to run the klatency -t 2 test. I do not have a system  
> or even a piece of a system right now so I can't run anything. Sorry. :(
> 
> What happens if I call start on a timer that is already running? Will  

Not explicitly specified, but the existing timer will be stopped first
and then newly started.

> it change the timing at all or ignore the start?
> 
> Is this correct:
> 
> rtdm_timer_start(&timer, 2000000, 125000, RTDM_TIMERMODE_ABSOLUTE);
> 
> The behavior I want is to start my timer in 2ms and have it fire every  

"...start ... in 2 ms" sounds a bit like TIMERMODE_RELATIVE, no? :)

> 125us. The timer itself will use rtdm_timer_stop_in_handler() to stop  
> itself.
> 
> Am I making any mistakes here?
> 
> Steven
> 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


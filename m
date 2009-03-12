Message-Id: <E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B8EE0A.3050708@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 12 Mar 2009 07:29:46 -0400
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>
	<49B8EE0A.3050708@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I will ask Mark to run the klatency -t 2 test. I do not have a system  
or even a piece of a system right now so I can't run anything. Sorry. :(

What happens if I call start on a timer that is already running? Will  
it change the timing at all or ignore the start?

Is this correct:

rtdm_timer_start(&timer, 2000000, 125000, RTDM_TIMERMODE_ABSOLUTE);

The behavior I want is to start my timer in 2ms and have it fire every  
125us. The timer itself will use rtdm_timer_stop_in_handler() to stop  
itself.

Am I making any mistakes here?

Steven

On Mar 12, 2009, at 7:12 AM, Gilles Chanteperdrix wrote:

> Steven Seeger wrote:
>> Is an RTDM timer going to run at a priority higher than any scheduled
>> realtime thread?
>>
>> How accurate is the timing?
>>
>> We are seeing the timer running at 125us periodic rate being called
>> much too quickly. At least, I think we are. I can't personally use
>> anything for a little over a week.
>
> Yes a timer runs in interrupt context. This is the same design as  
> Linux,
> VxWorks, RTLinux, RTAI and most known OSes.
>
> I do not understand what you mean by "too quickly", but do you get the
> same phenomenon with the klatency -t 2 test?
>
> -- 
>                                                 Gilles.



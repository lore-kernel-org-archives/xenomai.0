Message-ID: <498FF2C4.4040905@domain.hid>
Date: Mon, 09 Feb 2009 10:09:24 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>	
	<498C01C0.8010607@domain.hid>	
	<57e813c90902060235l61d188c8g8990f71e35da1963@domain.hid>	
	<498C21A4.3010102@domain.hid>	
	<57e813c90902060422h24e052cbv5c0361b4824e821@domain.hid>	
	<498C2EEE.20708@domain.hid>
	<57e813c90902060815m1d6a6642re65481fc47874ae6@domain.hid>
In-Reply-To: <57e813c90902060815m1d6a6642re65481fc47874ae6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] timed looping task in device driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zara Tustra <zarawesome@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Zara Tustra wrote:
>> Where do you call rtdm_task_wait_period()? Inside the RT task function?
> 
> Yes. rtdm_task_sleep_abs works, aggravatingly enough.
> 
>> Have a look at examples/rtdm/driver-api/heartbeat.c. Compare it to your
> code and try it out. Does it work?
> 
> heartbeat doesn't seem to work either. I'm starting to think it's either a
> issue of how the kernel was compiled or how the driver is being compiled.

Which versions of the Linux kernel, I-pipe and Xenomai do you use? And 
which CPU? Could you send us your .config?

Please do not drop the Xenomai ML in your replies.

-- 
Sebastian


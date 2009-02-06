Message-ID: <498C2EEE.20708@domain.hid>
Date: Fri, 06 Feb 2009 13:37:02 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>	
	<498C01C0.8010607@domain.hid>	
	<57e813c90902060235l61d188c8g8990f71e35da1963@domain.hid>	
	<498C21A4.3010102@domain.hid>
	<57e813c90902060422h24e052cbv5c0361b4824e821@domain.hid>
In-Reply-To: <57e813c90902060422h24e052cbv5c0361b4824e821@domain.hid>
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
Cc: xenomai@xenomai.org

Zara Tustra wrote:
> ret=rtdm_task_init (&toggle_led_task, "toggling_led", &toggling_led_proc,
> NULL, 10, 1000000000);
> 
>   if (ret) {
>     printk(KERN_DEBUG "error while setting periodic, code %d\n", ret);
>     return;
>   }
>     else printk(KERN_DEBUG "task set periodic successfully\n");
> 

Where do you call rtdm_task_wait_period()? Inside the RT task function?

Have a look at examples/rtdm/driver-api/heartbeat.c. Compare it to your 
code and try it out. Does it work?

-- 
Sebastian


Message-ID: <4F954ABE.20508@domain.hid>
Date: Mon, 23 Apr 2012 14:27:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
In-Reply-To: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Jitter while generating PWMs with GPIO from RTDM
 driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 04/23/2012 01:56 PM, Andrey Nechypurenko wrote:
> Hi Folks,
> 
> Following my tests with PWM generation using GPIO in user space [1],
> I've made the RTDM module [2] to further reduce the jitter. As a
> result, jitter was improved, but still under heavy system load the
> servo motor I am trying to control starts shaking. Now, I fill stuck
> and hope to get some help here.
> 
> At one hand, I can not imaging that 800MHz ARM (BeagleBoard xM) could
> not manage to generate 20mS PWMs from RTDM driver precise enough to
> avoid sporadic servo movements. So probably I am doing something
> wrong. On the other hand, I do not see where the possible mistake can
> happen and hope that someone experienced in with Xenomai could help.
> 
> There is an article about observed behavior [3] with more details, but
> the core problem, I guess, boils down to the following code fragment:
> 
> void pwm_task_proc(void *arg) {
>   const int which = (int)arg;
> 
>   // Toggling GPIO pin
>   for(;;) {
>       //set_data_out has offset 0x94 . Set gpio pin to 1 (up)
>       iowrite32(0x40000000, gpio + 0x6094);
> 
>       // wait requested pulse width time (duty)
>       if(0 != rtdm_task_sleep(up_period[which]))
>         rtdm_printk("PWM: rtdm_task_sleep() returns error\n");
> 
>       //clear_data_out has offset 0x90 . Set gpio pin to 0 (down)
>       iowrite32(0x40000000, gpio + 0x6090);
> 
>       // wait until the next pulse should start (20mS interval)
>       if(0 != rtdm_task_wait_period())
>         rtdm_printk("PWM: rtdm_task_wait_period() returns error\n");
>   }
> 
> This is the function running as a periodic task started with the following call:
> 
> retval = rtdm_task_init(&pwm_task[i], // there is currently only one
> element in this array
> 			"pwm-task",
> 			pwm_task_proc,
> 			0,
> 			RTDM_TASK_HIGHEST_PRIORITY,
> 			20000000); // 20ms period

Do not use a thread, use a timer.

-- 
					    Gilles.


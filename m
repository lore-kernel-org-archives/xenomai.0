MIME-Version: 1.0
Date: Mon, 23 Apr 2012 13:56:47 +0200
Message-ID: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Jitter while generating PWMs with GPIO from RTDM
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
To: Xenomai help <xenomai@xenomai.org>

Hi Folks,

Following my tests with PWM generation using GPIO in user space [1],
I've made the RTDM module [2] to further reduce the jitter. As a
result, jitter was improved, but still under heavy system load the
servo motor I am trying to control starts shaking. Now, I fill stuck
and hope to get some help here.

At one hand, I can not imaging that 800MHz ARM (BeagleBoard xM) could
not manage to generate 20mS PWMs from RTDM driver precise enough to
avoid sporadic servo movements. So probably I am doing something
wrong. On the other hand, I do not see where the possible mistake can
happen and hope that someone experienced in with Xenomai could help.

There is an article about observed behavior [3] with more details, but
the core problem, I guess, boils down to the following code fragment:

void pwm_task_proc(void *arg) {
  const int which = (int)arg;

  // Toggling GPIO pin
  for(;;) {
      //set_data_out has offset 0x94 . Set gpio pin to 1 (up)
      iowrite32(0x40000000, gpio + 0x6094);

      // wait requested pulse width time (duty)
      if(0 != rtdm_task_sleep(up_period[which]))
        rtdm_printk("PWM: rtdm_task_sleep() returns error\n");

      //clear_data_out has offset 0x90 . Set gpio pin to 0 (down)
      iowrite32(0x40000000, gpio + 0x6090);

      // wait until the next pulse should start (20mS interval)
      if(0 != rtdm_task_wait_period())
        rtdm_printk("PWM: rtdm_task_wait_period() returns error\n");
  }

This is the function running as a periodic task started with the following call:

retval = rtdm_task_init(&pwm_task[i], // there is currently only one
element in this array
			"pwm-task",
			pwm_task_proc,
			0,
			RTDM_TASK_HIGHEST_PRIORITY,
			20000000); // 20ms period

It works fine until I put the system under about 95% load (just by
running tar jcf f.tbz2 /usr/lib). After that, the jitter of the
generated PWMs increasing to the level where it is not only observable
on the scope (as presented in [3]) but also servo motor starts
shaking, so it is clearly visible even without any measurements.

Honesly, I am failing to see any ways to improve this code. It is
already running in the kernel space and there are only memory writes
and RTDM wati functions involved. So I am wondering whether I hit the
limit of what is possible with Xenomai+Linux? I hope I am not and
would highly appreciate any hints or suggestions.

Thank you,
Andrey.

[1] http://veter-project.blogspot.com/2011/09/real-time-enough-about-pwms-and-shaky.html
[2] https://github.com/andreynech/rtdm-pwm
[3] http://veter-project.blogspot.com/2012/04/precise-pwms-with-gpio-using-xenomai.html


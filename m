MIME-Version: 1.0
Reply-To: mophong@gmail.com
From: Ho Tam <mophong@gmail.com>
Date: Wed, 8 Aug 2018 19:44:51 +0900
Message-ID: <CAK+-5=KE5pa1NUE4VY0uEVLH1+2P3dtbGWOBk9YxWLmAa16Juw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Xenomai on Raspberry pi 2,
 3 - Userspace task is interrupted?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,
I make a simple code to measure process time on Raspberry pi 0,1,2,3 like:

* previous = rt_timer_read();*
* for (i=0; i<500; ++i)*
* {*
* bcm2835_gpio_write(TEST_PIN, HIGH);*
* bcm2835_gpio_write(TEST_PIN, LOW);*
* }*
* now = rt_timer_read();*
* process_time = (long) (now - previous);*
* if (process_time>worst_time)*
* worst_time=process_time;*

And I result after several hours running:
rpi           process_time (us)             worst_time (us)
0,1           ~100                                     115
2,3           ~90                                        373

It is clear that process time on rpi2,3 is shorter than that on rpi0,1 due
to higher speed CPU. However, I don't understand why worst case on rpi2,3
is much larger than that on rpi0,1. I have repeated this test on both
xenomai 2 and 3, kernel  4.1 and 4.9 (only xenomai 3 in this case) and with
different task priority, the result is quite consistent.
Does anyone have explanation and solution?
Thanks and regards,

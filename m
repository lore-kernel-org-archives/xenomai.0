From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <46850988-a862-b747-f11d-1191f7e13458@cs.ru.nl>
Date: Tue, 30 May 2017 18:38:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi 2
	(or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

note: all resources referred to  in this email can be found in the 
public repository at https://github.com/harcokuppens/xenomai3_rpi2_gpio/

At the  Radboud University Nijmegen we are already succesfully using 
xenomai 2 for several years in a course about embedded systems.
Currently we are using old intel pc's which need to be replaced. The 
idea is to replace them with the raspberry pi2 or pi3. We already 
managed to get xenomai2 to work on the raspberry pi1 but installing 
xenomai3 seems problematic and is becoming replace with the pi2 and pi3, 
so we deciced to  go for the pi2 or pi3.

We found on the internet several descriptions pages which describe how 
to install xenomai on a raspberry pi2/3.
An overview of these links can  be found at :
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/overview_xenomai3_installations_found_online.txt

note: some instructions are in japanese or french but with the help of 
google translate they are easy to read.

I managed to install xenomai3 on the rpi2, you can find mine 
installation instructions at :

https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/install_xenomai-3-3.0.5_on_rpi2.txt

Everything seems fine except for the interrupt handling!

In 
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/button_toggles_led.png 
is displayed the electronic
circuit I build to do my tests. It consists of two simple circuits :

 1.   led circuit :
    https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/led.png
 2. pullup circuit with a switch to trigger an interrupt :
    https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/circuit/pullup.png

I tried both a xenomai program in user space and kernel space 
(gpiotest).  In user space the pi just hangs, and I need a hard reboot.
In kernel space no interrupt happens at all. Maybe I do something wrong 
in kernel space.

At some point I was afraid that maybe my pi was broke, so I installed 
the standard raspbian image, which is just linux, and runned some 
interrupt test program within linux in userspace using the wiringpi 
library. These programs just worked fine. My pi2 wasn't broken :)
You can find the programs at : 
https://github.com/harcokuppens/xenomai3_rpi2_gpio/tree/master/examples/wiringpi_examples/

So I decided to also  test these wiringpi test programs on mine build 
xenomai 3 image for the rpi2. Unfortunately the isr.c wiringpi program
didn't work anymore on mine build image. So even without using xenomai3, 
but just using linux the pi2 just hangs and a hard reset was needed.

Thus I guess there is still something wrong with mine image?
Does anybody know what I'm doing wrong?
Or is this still a bug in the gpio library or in the patches applied?

Hope someone can help me, so that we can switch to xenomai3 on the 
rpi2/3  in the course next semester.

Best regards,
Harco Kuppens

ps. there is a newer version of the rpi2 called v1.2  which has the same 
cpu as the rpi3. But if the problem can be solved for the pi3 I'm also 
very happy. I tried the same procedure for the pi3 based on the 
instructions linked in 
https://github.com/harcokuppens/xenomai3_rpi2_gpio/blob/master/install/overview_xenomai3_installations_found_online.txt





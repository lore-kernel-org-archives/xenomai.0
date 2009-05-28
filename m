From: Andreas Glatz <andreasglatz@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2009 11:59:18 -0400
Message-Id: <1243526358.898.21.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

We have to start 40+ Xenomai tasks in kernel space.
We want to allocate at least 4kbyte of stack memory
for each of them. So we need the stack heap size 
to be more than 160kbyte. 

In the documentation it says that the total 
stack heap size cannot be more than 128kbyte
(the limit of kmalloc).

Now my idea is to modify the Xenomai code to have 
more than one stack heaps. So when I'm running out
of space in one heap I can switch to the next heap...

Is there an easier way to increase the max. stack heap size?

Best regards, 
Andreas 



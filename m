Message-ID: <44906584.60503@domain.hid>
Date: Wed, 14 Jun 2006 13:37:40 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] GPIO and RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>


hi Jan, everyone,

Ive worked up a patchset to add a GPIO driver for the chip on my mobo.
I adapted an existing one, drivers/char/scx200_gpio,
and created drivers/char/pc8736x_gpio

When doing this, I _oversimplified_ my problem by disregarding RTDM,
and Im hoping I can just _retrofit_ as needed.

the chip is on an ISA bus, a user-space C program can read the pins at 
(this) rate:

Wed Jun 14 13:24:13 MDT 2006
Linux soekris 2.6.17-rc6-gpio-sk #4 Sun Jun 11 20:43:10 MDT 2006 i586 
GNU/Linux
opened /dev/gpio-17, for 1 loops, 1000000 samples
read 1000000 samples in 7.8434 sec, rate: 127494.9460 samples/sec
opened /dev/led, for 1 loops, 1000000 samples
read 1000000 samples in 5.4116 sec, rate: 184788.5056 samples/sec

(obviously speed isnt latency, but theres some correlation ..)

I dont actually have a Real Question, to I'll throw out a placeholder -

What are the top 3-5 things to do or look at
in order to check the compatibility of my patches with RTDM ?




Separately..

In this GPIO work, I concluded that I needed to add a sysfs interface
to my driver, in order to better fit with LKML expectations.

What I did so far works, and seems to hang together coherently, but 
insofar as it
is the 1st time (to my knowledge) that a uniform treatment has been tried,
I might have painted myself / all-of-us into a corner.

Hopefully not, but you folks have a keener perception of these things.
Ill send shortly.

tia
jimc


MIME-Version: 1.0
Date: Sat, 23 Apr 2011 19:10:31 -0500
Message-ID: <BANLkTimm_1HqM0tg9YL=y7ZKQBNH1=YgxA@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] apt-get mmap() error after upgrading to Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi.

I patched a 2.6.35 kernel with Xenomai 2.5.6.

I was able to do a first update and even install a few packages on my
Atmel board.
However, when I tried to install some more on the board, I got his
error message:
-----------------------------------------------------------------------------------------------------------------
Reading package lists... Error!
E: Couldn't make mmap of 25165824 bytes - mmap (12: Cannot allocate memory)
W: Unable to close mmap - mmap (22: Invalid argument)
E: The package lists or status file could not be parsed or opened.
-----------------------------------------------------------------------------------------------------------------

What's interesting about this situation is that apt-get works great
after a fresh rootfs install.
As soon as I issue apt-get update/upgrade/install for a
second/third/... time, I get the above error message.

The filesystem resides on a ext4 formatted uSD, so this error cannot
be jffs2-related.
Also, increasing the cache size in apt configuration files doesn't work.

Here are some alternative configurations that didn't mess with apt-get:

(1) kernel 2.6.33, no Xenomai
(2) kernel  2.6.33, Xenomai 2.5.5
(3) kernel 2.6.35, no Xenomai

and here are the ones that made me think that 2.5.6 might interfere
with apt-get:

(1) kernel 2.6.33, Xenomai 2.5.6
(2) kernel 2.6.35, Xenomai 2.5.6


System configuration:

rootfs:       Debian Squeeze
proc:        AT91SAM9G20
kernel:      2.6.35.9
Xenomai:  2.5.6

Thank you,
R.


Message-ID: <4B990EF1.1000400@domain.hid>
Date: Thu, 11 Mar 2010 16:40:33 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Experimenting with Analogy. Bugs found?
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

Hello. I'm testing Analogy on my x86 system with a NI 6251 ADC board (I
can test with other NI ADCs if it useful to someone).

The lack of overview documentation is making my progress slow, but I
have a couple of acquisition routines working quite well.

So far I have discovered that the TRI_WAKE_EOS flags works quite ok on
my hardware, despite being indicates as unsupported in the
documentation. Messing with the drivers I also discovered that
a4l_mmap() is also working. There is just a bug to iron out (I can
provide more details on my hacking if someone is interested in helping
my track down the issue).

At the moment I'm facing two problems:

1. I setup an asynchronous acquisition. I then use a loop to
a4l_sys_read() the acquired data. When the acquisition command is over,
as configured with the .stop_src and .stop_arg in the command data
structure, the a4l_sys_read() returns an ENOENT error. The comedi way of
signaling the acquisition command end is to return 0, as is done for
files to signal the end of file. I think this is an API deficiency but I
haven't looked at how much work is to fix it.

2. Looks like it is not possible to setup an endless acquisition. If I
set .stop_src = TRIG_NONE and .stop_arg = 0, the command submission goes
fine, but I obtain an ENOENT error at the first a4l_sys_read(). I have
no idea on where to look to track down this issue.

Thanks. Cheers,
-- 
Daniele


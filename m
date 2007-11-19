Message-ID: <47415786.6040208@domain.hid>
Date: Mon, 19 Nov 2007 10:29:42 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] accuracy of system clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi all,

I'm using clock_gettime(REALTIME,&t) in a kernel module (posix skin) to
timestamp something. I know accessing this clock from user space yields
values different from those returned by the xenomai posix skin due to
ntpdate. But my concern is that the difference in pace is too much.
On one system it is about 90us/s wrong on another it is 160us/s.

I assume the speed of the ntp corrected clock is more or less correct.
Is there some calibration procedure I can run to tweak xenomai to make
sure in xenomai I get 1e9 ticks per *true* second?
I have enabled CONFIG_X86_UP_APIC.

Theo




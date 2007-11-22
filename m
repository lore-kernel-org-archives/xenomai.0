Message-ID: <474540B2.9050208@domain.hid>
Date: Thu, 22 Nov 2007 09:41:22 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] CLOCK_REALTIME initialization
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

Hi,

I understand in the Xenomai posix skin CLOCK_REALTIME gets initialized
on startup of the system and then left alone. There is a problem if the
system's hwclock is storing local time as opposed to UTC. In this case
the Xenomai clock gets initialized with local time instead of UTC.
I use local time in the hwclock because my systems are dual-boot with
MS Windows XP and XP aparently still can't properly deal with hwclock
set to UTC.

What I would like to do is tell Xenomai to reinitialize CLOCK_REALTIME
at some point *after* Linux has initialized its own clock from the
hwclock. As clock_settime() isn't yet supported (in 2.3) I can't do
this now. Will it be in 2.5, or is there at present another way of
reinitializing CLOCK_REALTIME?

Regards,
Theo



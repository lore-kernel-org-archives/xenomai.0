Message-ID: <4AFF363D.6020206@domain.hid>
Date: Sat, 14 Nov 2009 23:59:09 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid> <4AFE90A8.7090403@domain.hid>
In-Reply-To: <4AFE90A8.7090403@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Again thanks!<br>
<br>
I will look into the RTnet isolation. How would you suggest I obtain
knowledge about multicore box etc?<br>
<br>
Just to explain the use of two NICs, if I can. The reason is that our
goal is to measure travel times on any Ethernet, without altering this
Ethernet. To do this we plug in two transparent y-splitters the two
places we want to measure at ravel time between (e.g. on either side of
a switch). These two y-splitter outputs are fed to two NICs on each PC.
They cannot be plugged into the same NIC as the TDMA is on, then it
would be through a switch, which would increase further delay as I see
it...<br>
<br>
Ben<br>
<br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid:4AFE90A8.7090403@domain.hid" type="cite">
  <pre wrap="">Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks Jan

We use this setup: Two computers are RTnet-slaves synchronized to provide them common time. These two computers also have a second NIC which tap a target Ethernet network using RTcap. In this way we can measure Ethernet travel times on the target network.

This works well. The only problem is that we don't know exactly how to handle if a TDMA sync arrives at the same time as RTcap captures a frame on the target network.

We ran a test where we only read the system time from kernel space using rt_timer_read(). This reading and saving to a file takes approximately 1 us. However this time increases to approx 16 us when the reading is made when a synchronization TDMA packet is being handled.

We would like to detect when this happens so we can discard the frame travel times that collide with the TDMA sync.

I hope this makes sense
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Note that the synchronization accuracy via TDMA is not in the order of a
few microseconds, rather a few 10 us. That's because no clever approach
to compensate jitters of the reception interrupt is applied. So your
worrying about the jitter caused by the second NIC actually has to be
extended by worries about jitter of other host interrupts. They might be
smaller as I-pipe will suppress non-RT IRQs far more quickly, but they
are more and can line up and cause larger jitters as well.

If you want to get rid of most of them: use a multicore box and isolate
the RTnet NIC IRQ on a dedicated core. All Linux IRQs except for the
timer IRQ can then be avoided.

And I still see no point in using a second NIC if the first one is only
_receiving_ TDMA sync frames. It's true that timestamps taken by RTcap
on outgoing frames will naturally slightly differ from those taken by a
listen-only observer - but to my understanding this scenarios does not
apply to you case. So RTcap will work just fine when attached already to
the first NIC.

Jan

  </pre>
</blockquote>
<br>
</body>
</html>


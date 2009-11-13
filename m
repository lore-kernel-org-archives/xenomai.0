Message-ID: <4AFD6013.9020608@domain.hid>
Date: Fri, 13 Nov 2009 14:33:07 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
In-Reply-To: <4AFD4C7F.1000106@domain.hid>
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
Cc: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks Jan<br>
<br>
We use this setup: Two computers are RTnet-slaves synchronized to
provide them common time. These two computers also have a second NIC
which tap a target Ethernet network using RTcap. In this way we can
measure Ethernet travel times on the target network.<br>
<br>
This works well. The only problem is that we don't know exactly how to
handle if a TDMA sync arrives at the same time as RTcap captures a
frame on the target network. <br>
<br>
We ran a test where we only read the system time from kernel space
using rt_timer_read(). This reading and saving to a file takes
approximately 1 us. However this time increases to approx 16 us when
the reading is made when a synchronization TDMA packet is being
handled. <br>
<br>
We would like to detect when this happens so we can discard the frame
travel times that collide with the TDMA sync. <br>
<br>
I hope this makes sense<br>
<br>
Benjamin<br>
<br>
&nbsp;Kiszka wrote:
<blockquote cite="mid:4AFD4C7F.1000106@domain.hid" type="cite">
  <pre wrap="">Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">What has highest priority RTcap or TDMA-synchronization reception?

We have a PC with two NICs, so one has TDMA, and one other captures with 
RTcap. If two frames arrive at the same time on both NICS, which is 
handled? Is it the first one, or does one have higher priority than the 
other?

Any help directly or where to look is appreciated.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Timestamping and packet queuing of both sources work at exactly the same
priority and even go through a common path, the Stack Manager task. So
the ordering is more or less random. But the final delivery happens at
different level: TDMA is handled at high RT prio, RTcap captured frames
are forwarded to Linux, thus are then saved at the according low prio.

But why are you running two NICs instead of attaching RTcap to the
TDMA-managed interface? Or are they connected to different Ethernets?

Jan

  </pre>
</blockquote>
<br>
</body>
</html>


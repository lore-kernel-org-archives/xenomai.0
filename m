Message-ID: <4AEF0E04.3070902@domain.hid>
Date: Mon, 02 Nov 2009 17:51:16 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AED83C0.8050002@domain.hid> <4AEE9067.5050904@domain.hid>
In-Reply-To: <4AEE9067.5050904@domain.hid>
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Two real time NICs in same PC? (RTnet)
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
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks!<br>
<br>
I can see in the source that the capture stamping uses the
rtdm_clock_read(). <br>
<br>
When several PCs are on the same RTnet, they get synchronized due to
the TDMA. But what clock is it that is synchronized on the PCs? How do
I read and use this clock? What file can i see this in?<br>
<br>
Would it be possible to stamp received frames through this synchronized
clock instead of the system clock?<br>
<br>
Thanks a lot :)<br>
<br>
Benjamin<br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid:4AEE9067.5050904@domain.hid" type="cite">
  <pre wrap="">Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have only found documentation about the possibility to run a 
non-RT-NIC and a RT-NIC at the same time, which is possible.

But is it possible on the same PC to have:
- One NIC being master or slave in an RTnet network
- One other NIC capturing frames with RTcap
?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, this is possible. It is even the default if you use RTnet's startup
script and config (only one NIC is configured, and if there are two NICs
of the same type, only the first one is claimed by RTnet).

  </pre>
  <blockquote type="cite">
    <pre wrap="">(The whole point is to have a network of PCs running RTnet, so that 
their clocks are synchronized. Then have these same PCs capture frames 
via RTcap. In this way the captured timestamps can be compared and  
Ethernet  frame travel times can be calculated.)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Note that the measurement jitter /may/ still be in the same order of
your travel delays.

Jan

  </pre>
</blockquote>
<br>
</body>
</html>


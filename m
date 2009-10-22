Message-ID: <4AE0D75C.40205@domain.hid>
Date: Fri, 23 Oct 2009 00:06:20 +0200
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD3878D@rennsmail04.eu.thmulti.com>	<4AE07632.7070404@domain.hid>
	<4AE086A0.1050703@domain.hid> <4AE08F32.80800@domain.hid>
In-Reply-To: <4AE08F32.80800@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Libpcap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
First of all, thanks for all your inputs, this is of great help!<br>
<br>
I think I have misunderstood RTnet, so I'm now reading up on it now.<br>
<br>
I thought RTnet had it's own mac-layer, such that a real time network
is established <i>but only between real time machines.</i> But what I
need is to sniff on a standard UDP/IP Ethernet network (tapping the
Ethernet network). But I have to make precise/deterministic time
stamping (using the clock of the NIC or the clock of the CPU - doesn't
matter). <br>
<br>
But you say that this is possible via RT net by the use of <i>rtcap</i>?<br>
<br>
Again thanks for your suggestions and help!<br>
<br>
I will look into the RTnet again and not forget the factor drifting.<br>
<br>
- Benjamin<br>
<br>
<br>
Gilles Chanteperdrix wrote:
<blockquote cite="mid:4AE08F32.80800@domain.hid" type="cite">
  <pre wrap="">Jan Kiszka wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Gilles Chanteperdrix wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">As far as I remember, however, the timestamping of each packet is done
in the Linux domain, so, if you want to get the real timestamp, you have
to modify rtnet to get the timestamp done in the Xenomai domain.
      </pre>
    </blockquote>
    <pre wrap="">No, time stamping is actually done in the RTnet driver (it is a
by-product of RTmac/TDMA).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ok, right, bad memory.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Unfortunately, that is not all, because if you get Xenomai's timestamp,
they drift when compared to Linux timestamps. But if you look only at
relative timestamps over short period of times, that is Ok.

      </pre>
    </blockquote>
    <pre wrap="">Yes, timestamps will drift compared to a precise reference clock or even
the Linux host clock. But I'm optimistic we can fix this in the neat future.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ok. Now I remember why I touched this: in secondary domain, while
copying the packet for the rtcap driver, I read Xenomai's real-time
clock and Linux' real-time clock, and subtracted to Linux' timestamp the
difference between Xenomai's timestamp and the packet timestamp. This
compensates for the drift.

However, I far as I understood, Benjamin wants to get timestamps using
the NIC's clock. So, the solution would be a bit different.

  </pre>
</blockquote>
<br>
</body>
</html>


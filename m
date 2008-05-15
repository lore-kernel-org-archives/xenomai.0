Message-ID: <482BD329.7020704@domain.hid>
Date: Thu, 15 May 2008 08:07:37 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <200805112104.56166.karl-trampe@domain.hid> <48276703.2020005@domain.hid>
	<20080514144900.216230@domain.hid>
In-Reply-To: <20080514144900.216230@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Ideas how to measure delays with
 RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Karl Reichert a &eacute;crit&nbsp;:
<blockquote cite="mid:20080514144900.216230@domain.hid" type="cite">
  <pre wrap="">Jan Kiszka wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Karl Reichert wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hello,

I have two stations running RTnet, one as a master and one as a slave. I
      </pre>
    </blockquote>
    <pre wrap="">want 
    </pre>
    <blockquote type="cite">
      <pre wrap="">to measure the time, which a message, sent from master to slave, takes.
      </pre>
    </blockquote>
    <pre wrap="">But, 
    </pre>
    <blockquote type="cite">
      <pre wrap="">I don't want the time of the transmission only, but the complete time of
      </pre>
    </blockquote>
    <pre wrap="">all 
    </pre>
    <blockquote type="cite">
      <pre wrap="">software layers this data is processed through.

_______________	_______________
|		A		  |	|		D		  |
|______________|	|______________|
|		B		  |	|		C		  |
|______________|	|______________|
|   RTnet (Master)	  |	|    RTnet (Slave)	  |
|______________|	|______________|
		|				  |
		|______________|

So, I create the data, that should be send, in Layer A (Master) and send
      </pre>
    </blockquote>
    <pre wrap="">it 
    </pre>
    <blockquote type="cite">
      <pre wrap="">over RTnet to Layer D (Slave).

I want to take the time when the data leaves A and when it arrives D
      </pre>
    </blockquote>
    <pre wrap="">with 
    </pre>
    <blockquote type="cite">
      <pre wrap="">rtdm_clock_read(). If I have the offset between master and slave, I can 
calculate the time it took to pass A, B, both RTnet stacks, C and D.

As RTnet keeps track of the offset in it's stack, I want to use this
      </pre>
    </blockquote>
    <pre wrap="">value. Is 
    </pre>
    <blockquote type="cite">
      <pre wrap="">it possible via the API? I didn't found anything. Or do I have to
      </pre>
    </blockquote>
    <pre wrap="">manipulate 
    </pre>
    <blockquote type="cite">
      <pre wrap="">the stack to pass the offset to the higher layers (C and D)?
      </pre>
    </blockquote>
    <pre wrap="">If RTmac/TDMA is in use, you can obtain the clock offset via
RTMAC_RTIOC_TIMEOFFSET from the RTDM device "TDMA&lt;x&gt;" (where "&lt;x&gt;"
corresponds to "rteth&lt;x&gt;").

Jan

    </pre>
  </blockquote>
  <pre wrap=""><!---->
When I try to compile my application (xenomai native skin, user task), I get an error, saying rtdm_driver.h (which contains the prototype for rtdm_clock_read()) is for kernel mode tasks only.

How can I get a timestamp in a xenomai native user task? Is there sth equivalent to rtdm_clock_read()? Or do I have to write a kernel task?

Thanks
Karl
  </pre>
</blockquote>
Hi,<br>
A good scopemeter can help. you have to activate com or lpt pins in
your program before after receive/send funcs and watch the output
status of it in scopemeter.<br>
Best Regards<br>
Steph <br>
<br>
<br>
</body>
</html>


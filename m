Message-ID: <484E8FB1.5060003@domain.hid>
Date: Tue, 10 Jun 2008 07:29:05 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <3d3b73870806050759q607e6648p2eeb6568f4fde97c@domain.hid>	
	<484813B8.9040307@domain.hid>
	<3d3b73870806100431y1cb49a3ch1cc2922dc8b1b94c@domain.hid>
In-Reply-To: <3d3b73870806100431y1cb49a3ch1cc2922dc8b1b94c@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020308010908050204050106"
Subject: Re: [Xenomai-help] C++ and Xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hugo Braga <hugovaz@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020308010908050204050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> > Is there any problem to use C++ and Xenomai 2.4.0 ?
>  Don't we need to worry about object instantiation ? Thanks

Worry as much as you want. But you may want to save that for when 
something doesn't work ;)

We use Xenomai for a C++ userland application with a mix of real-time 
and non-real-time threads. We do not see any issues introduced by 
Xenomai wrt object instantiation. Of course, instantiating objects while 
you are in a real-time thread may affect performance so you may want 
most of those already allocated and ready to go when you need real-time 
behaviors.

hth

                                  - Tom

-- 
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


--------------020308010908050204050106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<span style="white-space: pre;">&gt;&gt; Is there any problem to use
C++ and Xenomai 2.4.0 ?<br>
&gt; Don't we need to worry about object instantiation ? Thanks<br>
</span><br>
Worry as much as you want. But you may want to save that for when
something doesn't work ;)<br>
<br>
We use Xenomai for a C++ userland application with a mix of real-time
and non-real-time threads. We do not see any issues introduced by
Xenomai wrt object instantiation. Of course, instantiating objects
while you are in a real-time thread may affect performance so you may
want most of those already allocated and ready to go when you need
real-time behaviors.<br>
<br>
hth<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Tom<br>
<br>
-- <br>
Thomas Lockhart<br>
Supervisor, Distributed and Real-time Group<br>
Instrument Software and Science Data Systems<br>
Caltech/JPL<br>
<br>
</body>
</html>

--------------020308010908050204050106--


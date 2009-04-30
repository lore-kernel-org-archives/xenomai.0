Message-ID: <49F9B123.7080203@domain.hid>
Date: Thu, 30 Apr 2009 07:09:39 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <200904301508.29432@domain.hid>
	<200904301509.13094@domain.hid>	<200904301510.8382@domain.hid>
	<200904301511.15875@domain.hid>	<200904301512.9035@domain.hid>
	<200904301513.12716@domain.hid>	<200904301514.6099@domain.hid>
	<200904301515.16182@domain.hid> <200904301516.696@domain.hid>
In-Reply-To: <200904301516.696@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------030704070500090903080008"
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030704070500090903080008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>  Hello, I have a problem with rtdm_event_timedwait() function. It
>  sometimes ends prematurely with -EINTR error code. It depends on
>  special circumstances (CPU load, resizing console window in X, ...).

In other areas of Xenomai when one sees a EINTR return one should 
reenter the original call. Like this (?):

do {
  err = rt_task_wait_period(...)
} while (err != -EINTR);

hth

                               - Tom

-- 
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


--------------030704070500090903080008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<span style="white-space: pre;">&gt; Hello, I have a problem with
rtdm_event_timedwait() function. It<br>
&gt; sometimes ends prematurely with -EINTR error code. It depends on<br>
&gt; special circumstances (CPU load, resizing console window in X,
...).</span><br>
<br>
In other areas of Xenomai when one sees a EINTR return one should
reenter the original call. Like this (?):<br>
<br>
do {<br>
&nbsp; err = rt_task_wait_period(...)<br>
} while (err != -EINTR);<br>
<br>
hth<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Tom<br>
<br>
-- <br>
Thomas Lockhart<br>
Supervisor, Distributed and Real-time Group<br>
Instrument Software and Science Data Systems<br>
Caltech/JPL<br>
<br>
</body>
</html>

--------------030704070500090903080008--


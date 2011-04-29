Message-ID: <4DBA8655.9050400@domain.hid>
Date: Fri, 29 Apr 2011 11:35:17 +0200
From: Thierry Bultel <thierry.bultel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------070606030900080203050009"
Subject: [Xenomai-help] How to interpret /proc/xenomai/stat CPU time of
 threads with priority 0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@domain.hid>, Nicolas Mabire <nicolas.mabire@domain.hid>

This is a multi-part message in MIME format.
--------------070606030900080203050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I was wondering if the displayed CPU time was, for these particular 
threads,
the only time spent in primary mode, of the total amount of time spent 
on the CPU.

I am namely currently debugging an application which has such kind of 
thread,
with a period of 50ms, and that takes up to 23% of the CPU.
That is bad, but not a real issue if that time is spent only in 
secondary mode,
but I do not know how to figure it out.
The mode switches frequency is equal to the period of my thread, since 
it uses rt_task_wait_period

I am a little bit concerned, my fear is that secondary mode time would 
be counted in the ROOT task ...
BTW, I am using version 2.5.2 (I know, it's old ;-) ).

Any help would be appreciated.

Thanks
Thierry

--------------070606030900080203050009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <font size="-1">Hi all,<br>
      <br>
      I was wondering if the displayed CPU time was, for these
      particular threads, <br>
      the only time spent in primary mode, of the total amount of time
      spent on the CPU.<br>
      <br>
      I am namely currently debugging an application which has such kind
      of thread,<br>
      with a period of 50ms, and that takes up to 23% of the CPU.<br>
      That is bad, but not a real issue if that time is spent only in
      secondary mode,<br>
      but I do not know how to figure it out. <br>
      The mode switches frequency is equal to the period&nbsp;of my thread,
      since it uses rt_task_wait_period<br>
      <br>
      I am a little bit concerned, my fear is that secondary mode time
      would be counted in the ROOT task ...<br>
      BTW, I am using version 2.5.2 (I know, it's old <span
        class="moz-smiley-s3"><span> ;-) </span></span>).<br>
      <br>
      Any help would be appreciated.<br>
      <br>
      Thanks<br>
      Thierry<br>
    </font>
  </body>
</html>

--------------070606030900080203050009--


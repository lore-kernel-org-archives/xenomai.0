Message-ID: <4F68BDBF.2030002@domain.hid>
Date: Tue, 20 Mar 2012 18:26:23 +0100
From: Thierry Bultel <thierry.bultel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------040008030205030602020205"
Subject: [Xenomai-help] CAN: Locked in rtdm_sem_timeddown of tx_sem;
	Lost TX IRQ ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@domain.hid>

This is a multi-part message in MIME format.
--------------040008030205030602020205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the issue I am describing here happens on a dual-core Atom (without 
hyperthreading)

It is easy to reproduce with 2.6.32.7+xenomai 2.5.2, which was my 
initial configuration until
I remembered that Philippe told us that SMP was correctly supported from 
2.6.38.8

The fact is that I have been able to reproduce it with 
2.6.38.8+xenomai-2.6 as well. Only once, but I did.

I am using CAN with a IXXAT PCI-04 board .
There is a single thread per bus.

With the old kernel, after about 400-500 seconds, and heavy load the 
communication stops, and after some
analysis, I found out that my process was stuck at :

rtcan_raw.c

   /* Try to pass the guard in order to access the controller */
*  ret = rtdm_sem_timeddown(&dev->tx_sem, timeout, NULL);*


The Refcount shown in /proc/rtcan/rtcan0/info is 1.

The workaround I found was to set the timeout to a non-zero value with 
the appropriate ioctl,
and when a timeout issues, to stop and restart the bus, with the effect 
to destroy and re-recreate the semaphore and
thus to communicate again.

By reading the code, the only reason I can see is that a TX interrupt is 
lost.

I do not have much more ways to analyze deeper, so any advice would be 
greatly appreciated

Cheers,
Thierry

--------------040008030205030602020205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <font size="-1">Hello, <br>
      <br>
      the issue I am describing here happens on a dual-core Atom
      (without hyperthreading)<br>
      <br>
      It is easy to reproduce with 2.6.32.7+xenomai 2.5.2, which was my
      initial configuration until<br>
      I remembered that Philippe told us that SMP was correctly
      supported from 2.6.38.8<br>
      <br>
      The fact is that I have been able to reproduce it with
      2.6.38.8+xenomai-2.6 as well. Only once, but I did.<br>
      <br>
      I am using CAN with a IXXAT PCI-04 board .<br>
      There is a single thread per bus.<br>
      <br>
      With the old kernel, after about 400-500 seconds, and heavy load
      the communication stops, and after some<br>
      analysis, I found out that my process was stuck at :<br>
      <br>
      <small>rtcan_raw.c<br>
        <br>
        &nbsp; /* Try to pass the guard in order to access the controller */<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp; ret = rtdm_sem_timeddown(&amp;dev-&gt;tx_sem,
          timeout, NULL);</b><br>
        <br>
      </small><br>
      The Refcount shown in /proc/rtcan/rtcan0/info is 1.<br>
      <br>
      The workaround I found was to set the timeout to a non-zero value
      with the appropriate ioctl,<br>
      and when a timeout issues, to stop and restart the bus, with the
      effect to destroy and re-recreate the semaphore and <br>
      thus to communicate again.<br>
      <br>
      By reading the code, the only reason I can see is that a TX
      interrupt is lost.<br>
      <br>
      I do not have much more ways to analyze deeper, so any advice
      would be greatly appreciated<br>
      <br>
      Cheers,<br>
      Thierry<br>
    </font>
  </body>
</html>

--------------040008030205030602020205--


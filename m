Message-ID: <OFBA487F20.21A14F15-ONC12573F7.00329129-C12573F7.00329C76@domain.hid>
From: "G.P.M. Haagh" <g.p.m.haagh@domain.hid>
Date: Fri, 22 Feb 2008 10:13:31 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF964DFA117B98f9e8a93df938690918c4EBBF964DFA117B9"
Content-Disposition: inline
Subject: [Xenomai-help] Advice needed: Xenomai / USB access from kernel task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0__=4EBBF964DFA117B98f9e8a93df938690918c4EBBF964DFA117B9
Content-type: text/plain; charset=US-ASCII


One of our trainees has written a LKM that accesses the standard Linux
kernel's usb_core facilities from a Xenomai real-time thread running in
kernel space.
I am doing some follow up on his work and run into problems.
I would appreciate some help/advise.

1)
The main question to start with: is it Ok to submit urbs to usb_core
(usb_submit_urb)  from a Xenomai kernel task (task created in a LKM) ?

2) If Ok (Xenomai 2.3.4 / kernel 2.6.20.1)

- A task, created with rt_task_created in the LKM, reads a rt_pipe and
submits a (bulk-) URB.
Most times, the  URB submits works OK.
However occasionally (once every 10-15 minutes at 6 submits/s) the kernel
runs into problems --
the ata driver starts complaining about timeouts and cannot recover,
ethernet stops working, the USB mouse and keyboard stop working
or the system becomes completely silent and unresponsive.

- When using Xenomai 2.4.2 kernel 2.6.23.x, the USB submit always fails in
the sense that an exception (6) occurs in the xenomai thread when calling
usb_submit_urb; so the submit urb call never returns.
(saw this logged in /var/log/messages).

- The same USB related code does not cause problems when used as part of a
'normal' Linux character driver. The submit URB calls are then made from
the file write context.


Can anyone give me some advise/hints on how I can approach this problem?


thanks in advance,
Gerard

G.P.M. Haagh
Philips Applied Technologies
Eindhoven, The Netherlands
--0__=4EBBF964DFA117B98f9e8a93df938690918c4EBBF964DFA117B9
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>One of our trainees has written a LKM that accesses the standard Linux kernel's usb_core facilities from a Xenomai real-time thread running in kernel space.<br>
I am doing some follow up on his work and run into problems.<br>
I would appreciate some help/advise. <br>
<br>
1)<br>
The main question to start with: is it Ok to submit urbs to usb_core (usb_submit_urb)  from a Xenomai kernel task (task created in a LKM) ?<br>
<br>
2) If Ok (Xenomai 2.3.4 / kernel 2.6.20.1)<br>
<br>
- A task, created with rt_task_created in the LKM, reads a rt_pipe and submits a (bulk-) URB.<br>
Most times, the  URB submits works OK.<br>
However occasionally (once every 10-15 minutes at 6 submits/s) the kernel runs into problems --<br>
the ata driver starts complaining about timeouts and cannot recover, ethernet stops working, the USB mouse and keyboard stop working<br>
or the system becomes completely silent and unresponsive.<br>
<br>
- When using Xenomai 2.4.2 kernel 2.6.23.x, the USB submit always fails in the sense that an exception (6) occurs in the xenomai thread when calling usb_submit_urb; so the submit urb call never returns.<br>
(saw this logged in /var/log/messages).<br>
<br>
- The same USB related code does not cause problems when used as part of a 'normal' Linux character driver. The submit URB calls are then made from the file write context.<br>
<br>
<br>
Can anyone give me some advise/hints on how I can approach this problem?<br>
<br>
<br>
thanks in advance,<br>
Gerard <br>
<br>
G.P.M. Haagh<br>
Philips Applied Technologies<br>
Eindhoven, The Netherlands</body></html>
--0__=4EBBF964DFA117B98f9e8a93df938690918c4EBBF964DFA117B9--



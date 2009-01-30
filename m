MIME-Version: 1.0
Date: Fri, 30 Jan 2009 14:28:10 +0900
Message-ID: <ba9b368a0901292128x57de0b4dj4cb701db49bb2059@domain.hid>
From: Daniel Adams <dadams81@domain.hid>
Content-Type: multipart/alternative; boundary=0016e652f6427a59c00461ac78e0
Subject: [Xenomai-help] Watchdog process
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

--0016e652f6427a59c00461ac78e0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I've written a watchdog process which expects a token (semaphore) to be
touch every Nms by waiting on the semaphore with a timeout. If the task
timeouts out on the semaphore I need it to cause a hardware reset. Previous
RTOSes I've used have had direct access to the COP/Watchdog timer hardware
where the process would tickle the COP or just spin wait for reset once an
deadline had been missed. I understand that I can get similar behaviour by
essentially starving the Linux kernel of processor time which causes the NMI
watchdog to not be tickled, but this timeout is in the order of seconds. The
application I'm working on is safety critical and needs to cause a system
reset in < 1 sec.

Is this possible with Xenomai? If so, can some one point me the direction of
how to achieve it.

Thanks

Dan Adams

--0016e652f6427a59c00461ac78e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;ve written a watchdog process which expects a token (semap=
hore) to be touch every Nms by waiting on the semaphore with a timeout. If =
the task timeouts out on the semaphore I need it to cause a hardware reset.=
 Previous RTOSes I&#39;ve used have had direct access to the COP/Watchdog t=
imer hardware where the process would tickle the COP or just spin wait for =
reset once an deadline had been missed. I understand that I can get similar=
 behaviour by essentially starving the Linux kernel of processor time which=
 causes the NMI watchdog to not be tickled, but this timeout is in the orde=
r of seconds. The application I&#39;m working on is safety critical and nee=
ds to cause a system reset in &lt; 1 sec. <br>
<br>Is this possible with Xenomai? If so, can some one point me the directi=
on of how to achieve it.<br><br>Thanks<br><br>Dan Adams<br>

--0016e652f6427a59c00461ac78e0--


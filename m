Message-ID: <1311085450.21897.YahooMailClassic@domain.hid>
Date: Tue, 19 Jul 2011 07:24:10 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1192505103-1311085450=:21897"
Subject: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-1192505103-1311085450=:21897
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,

I am running a serial port test in xenomai (xenomai-2.5.5.2) using 16550A d=
river.
In my program, I am calling

rt_dev_ioctl(dev_id, RTSER_RTIOC_WAIT_EVENT, & rx_event);

when an event happens, I use clock_gettime(CLOCK_MONOTONIC, & curr_time)
to get the current time. The program runs continuosly in a while loop. In t=
his way, I=20
measure the elapsed time between the previous and current events.


For this test, I find something that I still cannot figure out. They are as=
 follows:

1st session running the program, elapsed time between events - 40 us=A0 (re=
boot system)
2nd session=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 - 80 us=A0 (reboot system)
3rd session=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 - 150 us (reboot system)
4th session=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 - 100 us (reboot system)

and so on.

And I use clock_getres to see the resolution of the clock, tv_sec =3D 0, tv=
_nsec =3D 1.

My question is - why everytime I reboot the system, I get different elapsed=
 time=20
measurement for the same program?

Can someone please help ?


Regards,

Ph293
--0-1192505103-1311085450=:21897
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Dear all,<br><br>I am running a serial port t=
est in xenomai (xenomai-2.5.5.2) using 16550A driver.<br>In my program, I a=
m calling<br><br>rt_dev_ioctl(dev_id, RTSER_RTIOC_WAIT_EVENT, &amp; rx_even=
t);<br><br>when an event happens, I use clock_gettime(CLOCK_MONOTONIC, &amp=
; curr_time)<br>to get the current time. The program runs continuosly in a =
while loop. In this way, I <br>measure the elapsed time between the previou=
s and current events.<br><br><br>For this test, I find something that I sti=
ll cannot figure out. They are as follows:<br><br>1st session running the p=
rogram, elapsed time between events - 40 us&nbsp; (reboot system)<br>2nd
 session&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; - 80 us&nbsp; (reboot system)<br>3rd session&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - 150 us (reboot system)<br>4th
 session&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; - 100 us (reboot system)<br><br>and so on.<br><br>And I use clock_getres=
 to see the resolution of the clock, tv_sec =3D 0, tv_nsec =3D 1.<br><br>My=
 question is - why everytime I reboot the system, I get different elapsed t=
ime <br>measurement for the same program?<br><br>Can someone please help ?<=
br><br><br>Regards,<br><br>Ph293</td></tr></table>
--0-1192505103-1311085450=:21897--


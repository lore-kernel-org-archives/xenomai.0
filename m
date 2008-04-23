Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A58F.5A2D5486"
Date: Wed, 23 Apr 2008 18:14:09 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><18446.32522.986935.299094@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid><2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid><2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid><18447.31623.723753.421351@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] serial port overrun problem RT TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A58F.5A2D5486
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles, (and anyone else who has had overrun errors or has experience =
with the Xenomai serial port driver)

It seems that even though I turned off fprintf and even though I stopped =
logging to disk, I still get the same number of overrun errors.  I broke =
the loop down to the bare basics.

my task now consists of the following

Task was launched as follows:rt_task_create(&read_task, "read_task", 0, =
51, 0);


void sensor::mainloop()
{


	//set up serial read
	struct rtser_event rx_event;
	rtser_status_t serstatus;
	int numread,err;

		 while(1)
		 {
			if(exitprogram)		//
				 break;

			err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);

			if (err)
			{
				printf(RTASK_PREFIX
					       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
				  strerror(-err));
				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);
				printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);

			}

			else
			{
				numread =3D rt_dev_read(read_fd, buf, 1);
				{
					printf(RTASK_PREFIX "error on rt_dev_read, code %d %s\n",numread,
					       strerror(-numread));
					err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);
					printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
					continue;
				}
			else
			{
				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);  =
//if data received normally, make sure 96 was received, 98 =3D overrun
				if(!serstatus.line_status=3D=3D96)
				printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
			}
		}
}

Thank you,

Joshua Karch


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 4/23/2008 5:28 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem
=20
Karch, Joshua wrote:
 >=20
 > Gilles,
 >=20
 > I decided to eliminate the pthread and create a task that handles the =
entire packet process, from reading the serial port, to decoding data, =
to disk io (saving the data to disk)  The only thing that's serviced =
occasionally is the main loop, which looks every half second for a =
keypress to quit.
 >=20
 > Now, I get overrun errors once every 10 seconds to 30 seconds.  The =
machine is a PC/104 and I'm using fprintf to print the data received =
from the sensor to file-- should I use perhaps an RT version?.

No, as I already explained, you can not use fprintf and hope remaining
deterministic.

There is no function writing data to disk while remaining
deterministic. That would mean have disk drivers and so on written for
xenomai.

You have to design your application with an rt-task doing the rt work,
and a non rt-task doing the non rt work. This non rt-task can be a
classical pthread, in which case you will have to use an rt_pipe for
communications between the two tasks. Or the non rt-task can be a
xenomai thread with priority 0, in which case you can use any other
IPC.

For assistance in the daunting task of keeping deterministic, see the
bit T_WARNSW of the rt_task_set_mode service, or the bit PTHREAD_WARNSW
of the pthread_set_mode_np service.

--=20


					    Gilles.


------_=_NextPart_001_01C8A58F.5A2D5486
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>serial port overrun problem RT TASK</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gilles, (and anyone else who has had overrun errors or =
has experience with the Xenomai serial port driver)<BR>
<BR>
It seems that even though I turned off fprintf and even though I stopped =
logging to disk, I still get the same number of overrun errors.&nbsp; I =
broke the loop down to the bare basics.<BR>
<BR>
my task now consists of the following<BR>
<BR>
Task was launched as follows:rt_task_create(&amp;read_task, =
&quot;read_task&quot;, 0, 51, 0);<BR>
<BR>
<BR>
void sensor::mainloop()<BR>
{<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //set up serial read<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rtser_event =
rx_event;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtser_status_t serstatus;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int numread,err;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_WAIT_EVENT, &amp;rx_event);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;error on =
RTSER_RTIOC_WAIT_EVENT, %s\n&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; strerror(-err));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; numread =3D =
rt_dev_read(read_fd, buf, 1);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;error on rt_dev_read, code %d %s\n&quot;,numread,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(-numread));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);&nbsp; //if data received =
normally, make sure 96 was received, 98 =3D overrun<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(!serstatus.line_status=3D=3D96)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
}<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Wed 4/23/2008 5:28 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Gilles,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; I decided to eliminate the pthread and create a task that =
handles the entire packet process, from reading the serial port, to =
decoding data, to disk io (saving the data to disk)&nbsp; The only thing =
that's serviced occasionally is the main loop, which looks every half =
second for a keypress to quit.<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Now, I get overrun errors once every 10 seconds to 30 =
seconds.&nbsp; The machine is a PC/104 and I'm using fprintf to print =
the data received from the sensor to file-- should I use perhaps an RT =
version?.<BR>
<BR>
No, as I already explained, you can not use fprintf and hope =
remaining<BR>
deterministic.<BR>
<BR>
There is no function writing data to disk while remaining<BR>
deterministic. That would mean have disk drivers and so on written =
for<BR>
xenomai.<BR>
<BR>
You have to design your application with an rt-task doing the rt =
work,<BR>
and a non rt-task doing the non rt work. This non rt-task can be a<BR>
classical pthread, in which case you will have to use an rt_pipe for<BR>
communications between the two tasks. Or the non rt-task can be a<BR>
xenomai thread with priority 0, in which case you can use any other<BR>
IPC.<BR>
<BR>
For assistance in the daunting task of keeping deterministic, see =
the<BR>
bit T_WARNSW of the rt_task_set_mode service, or the bit =
PTHREAD_WARNSW<BR>
of the pthread_set_mode_np service.<BR>
<BR>
--<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
Gilles.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A58F.5A2D5486--


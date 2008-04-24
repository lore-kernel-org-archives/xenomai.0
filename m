Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A615.C0B69ED1"
Date: Thu, 24 Apr 2008 10:16:13 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>	<18446.32522.986935.299094@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>	<18447.31623.723753.421351@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>	<18447.43488.713144.166771@domain.hid>	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A615.C0B69ED1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Jan,  I'm running a Geode GX2 processor with a CS5536 chipset.  It's a =
Versalogic Puma board with a 16550A 16 byte buffer fifo.  I really need =
to have the interrupt trigger on byte at a time.  I usually receive 45 =
bytes at 50 Hz at a data rate of 115200.  Occasionally I receive larger =
or smaller packets, which is why I need byte at a time.  I'm using this =
to drive a control system.  I actually need to control 3 serial ports =
like this.

Here is /proc/xenomai/stat in idle mode
=20
:~# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          18270412   0     00500080   99.5  ROOT
  0  0      0          40165525   0     00000000    0.4  IRQ0: [timer]


Latency did not work with -t1 or -t2  couldn't find benchmark device, =
error code -19.  I think the benchmark drivers have to be installed.


monkeyant:/usr/xenomai/bin# ./latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|     -62.020|     -39.391|    1656.075|     138|     -62.020|    =
1656.075
RTD|     -56.991|     -38.553|    1965.333|     272|     -62.020|    =
1965.333
RTD|     -56.153|     -38.553|    1682.056|     405|     -62.020|    =
1965.333
RTD|     -56.991|     -37.715|    1695.466|     540|     -62.020|    =
1965.333
RTD|     -56.991|     -38.553|    1962.818|     674|     -62.020|    =
1965.333
RTD|     -56.153|     -38.553|    1675.352|     810|     -62.020|    =
1965.333
RTD|     -56.991|     -38.553|    1661.942|     946|     -62.020|    =
1965.333
RTD|     -56.991|     -38.553|    2055.847|    1083|     -62.020|    =
2055.847
RTD|     -56.991|     -38.553|    1682.056|    1227|     -62.020|    =
2055.847
RTD|     -56.153|     -38.553|    1652.723|    1360|     -62.020|    =
2055.847
RTD|     -56.153|     -38.553|    1961.142|    1498|     -62.020|    =
2055.847
RTD|     -56.991|     -38.553|    1702.171|    1632|     -62.020|    =
2055.847
RTD|     -56.991|     -38.553|    1660.266|    1771|     -62.020|    =
2055.847
RTD|     -56.153|     -38.553|    1967.009|    1904|     -62.020|    =
2055.847
RTD|     -56.991|     -38.553|    1681.218|    2049|     -62.020|    =
2055.847
RTD|     -56.991|     -38.553|    1669.485|    2189|     -62.020|    =
2055.847
RTD|     -56.153|     -38.553|    1951.085|    2319|     -62.020|    =
2055.847

Any ideas?

Thank you,

Joshua Karch










-----Original Message-----
From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
Sent: Thu 4/24/2008 3:04 AM
To: Gilles Chanteperdrix; Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
=20
Gilles Chanteperdrix wrote:
> Karch, Joshua wrote:
>  > Gilles, (and anyone else who has had overrun errors or has =
experience with the Xenomai serial port driver)
>  >=20
>  > It seems that even though I turned off fprintf and even though I =
stopped logging to disk, I still get the same number of overrun errors.  =
I broke the loop down to the bare basics.
>  >=20
>  > my task now consists of the following
>  >=20
>  > Task was launched as follows:rt_task_create(&read_task, =
"read_task", 0, 51, 0);
>  >=20
>  >=20
>  > void sensor::mainloop()
>  > {
>  >=20
>  >=20
>  > 	//set up serial read
>  > 	struct rtser_event rx_event;
>  > 	rtser_status_t serstatus;
>  > 	int numread,err;
>  >=20
>  > 		 while(1)
>  > 		 {
>  > 			if(exitprogram)		//
>  > 				 break;
>  >=20
>  > 			err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, =
&rx_event);
>  >=20
>=20
> As I already said, using read with timeout directly without first
> calling ioctl leads to a better latency because of the fewer system
> calls.
>=20
>  > 			if (err)
>  > 			{
>  > 				printf(RTASK_PREFIX
>  > 					       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
>  > 				  strerror(-err));
>  > 				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, =
&serstatus);
>  > 				printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
>  >=20
>  > 			}
>  >=20
>  > 			else
>  > 			{
>  > 				numread =3D rt_dev_read(read_fd, buf, 1);
>  > 				{
>  > 					printf(RTASK_PREFIX "error on rt_dev_read, code %d =
%s\n",numread,
>  > 					       strerror(-numread));
>  > 					err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, =
&serstatus);
>  > 					printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
>  > 					continue;
>  > 				}
>  > 			else
>  > 			{
>  > 				err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, =
&serstatus);  //if data received normally, make sure 96 was received, 98 =
=3D overrun
>  > 				if(!serstatus.line_status=3D=3D96)
>  > 				printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);
>  > 			}
>=20
> On compilers I know if () { } else { } else {} does not even
> compile. Are you sure you are showing us the code you are really =
running
> ? Have you tried T_WARNSW as I suggested in a previous mail ?
>=20
> At what frequency do characters arrive on the serial line ? Did you =
try
> to run the latency test with the same frequency to see if Xenomai on
> your hardware is able to support this frequency ? Try latency -t 1 or =
-t
> 2 to see if switching to kernel-space would improve situation. Do you
> observe unexpected peaks (such as those caused by SMIs) when running
> latency ?
>=20
> Is not it possible to enable hardware buffering so as to receive more
> than one character at a time when overflow occurs ?
>=20
> If you need ultra-high frequencies, you should probably write some =
part
> of your application (at least the real-time control loop) in
> kernel-space.

The 16650A driver architecture is know to be able to handle multiple
500kBit/s serial streams on a Pentium III 700 box (granted, with 128
byte RX fifos then).

But if you are at the limits of your system can be analyzed via
/proc/xenomai/stat (see also the Wiki, IIRC). If you aren't, you should
check of you box suffers from hardware-related latency peaks. What do
standard Xenomai latency tools tell you about this (like 'latency')?

Jan



------_=_NextPart_001_01C8A615.C0B69ED1
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
<TITLE>RE: [Xenomai-help] serial port overrun problem RT TASK</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Jan,&nbsp; I'm running a Geode GX2 processor with a =
CS5536 chipset.&nbsp; It's a Versalogic Puma board with a 16550A 16 byte =
buffer fifo.&nbsp; I really need to have the interrupt trigger on byte =
at a time.&nbsp; I usually receive 45 bytes at 50 Hz at a data rate of =
115200.&nbsp; Occasionally I receive larger or smaller packets, which is =
why I need byte at a time.&nbsp; I'm using this to drive a control =
system.&nbsp; I actually need to control 3 serial ports like this.<BR>
<BR>
Here is /proc/xenomai/stat in idle mode<BR>
<BR>
:~# cat /proc/xenomai/stat<BR>
CPU&nbsp; PID&nbsp;&nbsp;&nbsp; =
MSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PF&nbsp;&nbsp;&nbsp; =
STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp; NAME<BR>
&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
18270412&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00500080&nbsp;&nbsp; =
99.5&nbsp; ROOT<BR>
&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
40165525&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
00000000&nbsp;&nbsp;&nbsp; 0.4&nbsp; IRQ0: [timer]<BR>
<BR>
<BR>
Latency did not work with -t1 or -t2&nbsp; couldn't find benchmark =
device, error code -19.&nbsp; I think the benchmark drivers have to be =
installed.<BR>
<BR>
<BR>
monkeyant:/usr/xenomai/bin# ./latency<BR>
=3D=3D Sampling period: 100 us<BR>
=3D=3D Test mode: periodic user-mode task<BR>
=3D=3D All results in microseconds<BR>
warming up...<BR>
RTT|&nbsp; 00:00:01&nbsp; (periodic user-mode task, 100 us period, =
priority 99)<BR>
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp;&nbsp; =
-39.391|&nbsp;&nbsp;&nbsp; 1656.075|&nbsp;&nbsp;&nbsp;&nbsp; =
138|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1656.075<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1965.333|&nbsp;&nbsp;&nbsp;&nbsp; =
272|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1682.056|&nbsp;&nbsp;&nbsp;&nbsp; =
405|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-37.715|&nbsp;&nbsp;&nbsp; 1695.466|&nbsp;&nbsp;&nbsp;&nbsp; =
540|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1962.818|&nbsp;&nbsp;&nbsp;&nbsp; =
674|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1675.352|&nbsp;&nbsp;&nbsp;&nbsp; =
810|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1661.942|&nbsp;&nbsp;&nbsp;&nbsp; =
946|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 1965.333<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 2055.847|&nbsp;&nbsp;&nbsp; =
1083|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1682.056|&nbsp;&nbsp;&nbsp; =
1227|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1652.723|&nbsp;&nbsp;&nbsp; =
1360|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1961.142|&nbsp;&nbsp;&nbsp; =
1498|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1702.171|&nbsp;&nbsp;&nbsp; =
1632|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1660.266|&nbsp;&nbsp;&nbsp; =
1771|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1967.009|&nbsp;&nbsp;&nbsp; =
1904|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1681.218|&nbsp;&nbsp;&nbsp; =
2049|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.991|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1669.485|&nbsp;&nbsp;&nbsp; =
2189|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp; -56.153|&nbsp;&nbsp;&nbsp;&nbsp; =
-38.553|&nbsp;&nbsp;&nbsp; 1951.085|&nbsp;&nbsp;&nbsp; =
2319|&nbsp;&nbsp;&nbsp;&nbsp; -62.020|&nbsp;&nbsp;&nbsp; 2055.847<BR>
<BR>
Any ideas?<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Jan Kiszka [<A =
HREF=3D"mailto:jan.kiszka@domain.hid">mailto:jan.kiszka@domain.hid</A>]<BR>
Sent: Thu 4/24/2008 3:04 AM<BR>
To: Gilles Chanteperdrix; Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK<BR>
<BR>
Gilles Chanteperdrix wrote:<BR>
&gt; Karch, Joshua wrote:<BR>
&gt;&nbsp; &gt; Gilles, (and anyone else who has had overrun errors or =
has experience with the Xenomai serial port driver)<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; It seems that even though I turned off fprintf and even =
though I stopped logging to disk, I still get the same number of overrun =
errors.&nbsp; I broke the loop down to the bare basics.<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; my task now consists of the following<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; Task was launched as =
follows:rt_task_create(&amp;read_task, &quot;read_task&quot;, 0, 51, =
0);<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; void sensor::mainloop()<BR>
&gt;&nbsp; &gt; {<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; //set up serial read<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; struct rtser_event rx_event;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; rtser_status_t serstatus;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; int numread,err;<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_WAIT_EVENT, &amp;rx_event);<BR>
&gt;&nbsp; &gt;<BR>
&gt;<BR>
&gt; As I already said, using read with timeout directly without =
first<BR>
&gt; calling ioctl leads to a better latency because of the fewer =
system<BR>
&gt; calls.<BR>
&gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;error on =
RTSER_RTIOC_WAIT_EVENT, %s\n&quot;,<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; strerror(-err));<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; numread =3D =
rt_dev_read(read_fd, buf, 1);<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;error on rt_dev_read, code %d %s\n&quot;,numread,<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(-numread));<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_GET_STATUS, &amp;serstatus);&nbsp; //if data received =
normally, make sure 96 was received, 98 =3D overrun<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(!serstatus.line_status=3D=3D96)<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(RTASK_PREFIX =
&quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
&gt;&nbsp; &gt; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;<BR>
&gt; On compilers I know if () { } else { } else {} does not even<BR>
&gt; compile. Are you sure you are showing us the code you are really =
running<BR>
&gt; ? Have you tried T_WARNSW as I suggested in a previous mail ?<BR>
&gt;<BR>
&gt; At what frequency do characters arrive on the serial line ? Did you =
try<BR>
&gt; to run the latency test with the same frequency to see if Xenomai =
on<BR>
&gt; your hardware is able to support this frequency ? Try latency -t 1 =
or -t<BR>
&gt; 2 to see if switching to kernel-space would improve situation. Do =
you<BR>
&gt; observe unexpected peaks (such as those caused by SMIs) when =
running<BR>
&gt; latency ?<BR>
&gt;<BR>
&gt; Is not it possible to enable hardware buffering so as to receive =
more<BR>
&gt; than one character at a time when overflow occurs ?<BR>
&gt;<BR>
&gt; If you need ultra-high frequencies, you should probably write some =
part<BR>
&gt; of your application (at least the real-time control loop) in<BR>
&gt; kernel-space.<BR>
<BR>
The 16650A driver architecture is know to be able to handle multiple<BR>
500kBit/s serial streams on a Pentium III 700 box (granted, with 128<BR>
byte RX fifos then).<BR>
<BR>
But if you are at the limits of your system can be analyzed via<BR>
/proc/xenomai/stat (see also the Wiki, IIRC). If you aren't, you =
should<BR>
check of you box suffers from hardware-related latency peaks. What =
do<BR>
standard Xenomai latency tools tell you about this (like 'latency')?<BR>
<BR>
Jan<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A615.C0B69ED1--


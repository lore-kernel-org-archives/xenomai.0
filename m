Date: Fri, 28 Jan 2011 09:34:29 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <22672536.41296203668390.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <29582899.21296203622078.JavaMail.SYSTEM@PC-MRINALDI>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3_26402479.1296203668390"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
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

------=_Part_3_26402479.1296203668390
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

>Posted by Gilles Chanteperdrix on January 27, 2011 - 14:36: 

>Strange, here, the LTP test takes only around 2 hours. Just to be sure: 
>you also generated disk and network activity in parallel to LTP and 
>latency? If yes, then this system has no issue with Xenomai, and the 
>problem you have with your application is in the application itself. 

I launch runltp command with -t flag (which specifies test duration) to run LTP tests for one day. 
I cannot run nettests and disk I/O tests from ltp battery because they require additional features (former requires another linux PC with ltp installed, latter requires floppy and CD player which aren't present 
on my pc). 
So, I create a script that downloads via network a larger (100Mb) file, and create, copy and delete some files on hard disk, all in a while loop, to generate network and disk I/O traffic. 
I re-run ltp and latency test running for 15 hours in parallel with this script also. 
I obtain: 

RTD| 1.081| 8.000| 47.249| 0| 0| 14:58:34/14:58:34 

Now I can assert that my xenomai works grat, I think. 
And then, problems are in my application. 

The only thing that looks me strange is this: with ltp+my_I/O_stress_script+latency tests, I obtain a minimum latency value (1.081) that is more less than ltp+latency only tests (6.182). 
So, lower latency was obtained with higher system load. 
Maybe there's some CPU frequency reductions in act during ltp+latency that isn't active during ltp+latency+my_I/O_stress_script, also if in my kernel configuration CPU frequency stepping was disabled? 
Or what could be happened? 

Thank you very much for your helpfullness, Gilles. 


------=_Part_3_26402479.1296203668390
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>&gt;Posted by Gilles Chanteperdrix on January 27, 2011 - 14:36:<br><br>&gt=
;Strange, here, the LTP test takes only around 2 hours. Just to be sure:<br=
>&gt;you also generated disk and network activity in parallel to LTP and<br=
>&gt;latency? If yes, then this system has no issue with Xenomai, and the<b=
r>&gt;problem you have with your application is in the application itself.<=
br><br>I launch runltp command with -t flag (which specifies test duration)=
 to run LTP tests for one day.<br>I cannot run nettests and disk I/O tests =
from ltp battery because they require additional features (former requires =
another linux PC with ltp installed, latter requires floppy and CD player w=
hich aren't present<br>on my pc).<br>So, I create a script that downloads v=
ia network a larger (100Mb) file, and create, copy and delete some files on=
 hard disk, all in a while loop, to generate network and disk I/O traffic.<=
br>I re-run ltp and latency test running for 15 hours in parallel with this=
 script also.<br>I obtain:<br><br>RTD| 1.081| 8.000| 47.249| 0| 0| 14:58:34=
/14:58:34<br><br>Now I can assert that my xenomai works grat, I think.<br>A=
nd then, problems are in my application.<br><br>The only thing that looks m=
e strange is this: with ltp+my_I/O_stress_script+latency tests, I obtain a =
minimum latency value (1.081) that is more less than ltp+latency only tests=
 (6.182).<br>So, lower latency was obtained with higher system load.<br>May=
be there's some CPU frequency reductions in act during ltp+latency that isn=
't active during ltp+latency+my_I/O_stress_script, also if in my kernel con=
figuration CPU frequency stepping was disabled?<br>Or what could be happene=
d?<br><br>Thank you very much for your helpfullness, Gilles.<br><br></div><=
/body></html>
------=_Part_3_26402479.1296203668390--


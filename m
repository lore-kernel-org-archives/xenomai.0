Message-ID: <12d5cebd852.gprizzi@domain.hid>
Date: Thu, 6 Jan 2011 21:01:56 +0100 (CET)
From: "gprizzi@domain.hid" <gprizzi@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_193331_14025014.1294344116309"
Subject: [Xenomai-help] R: Re: R: Re:  error in executing xenomai tests
Reply-To: "gprizzi@domain.hid" <gprizzi@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_193331_14025014.1294344116309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Sir,

I find your considerations very useful, unfortunately I am not  expert in tuning conventional 
operating system with real time patch.

If you can help me I will greatly appreciate your advices.

I run latency test and got the following results:

root@domain.hid# ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -1.786|      2.224|     19.821|       0|     0|     -1.786|     19.821
RTD|     -1.796|      2.330|     19.490|       0|     0|     -1.796|     19.821
RTD|     -1.831|      2.231|     19.495|       0|     0|     -1.831|     19.821
RTD|     -1.772|      2.291|     19.743|       0|     0|     -1.831|     19.821
RTD|     -1.473|      2.460|     19.708|       0|     0|     -1.831|     19.821
RTD|     -1.524|      2.381|     19.717|       0|     0|     -1.831|     19.821
RTD|     -1.752|      2.338|     19.807|       0|     0|     -1.831|     19.821
RTD|     -1.893|      2.297|     19.520|       0|     0|     -1.893|     19.821
RTD|     -2.192|      2.284|     19.549|       0|     0|     -2.192|     19.821
RTD|     -1.635|      2.327|     19.530|       0|     0|     -2.192|     19.821
RTD|     -1.416|      2.406|     19.580|       0|     0|     -2.192|     19.821
RTD|     -1.305|      2.471|     14.930|       0|     0|     -2.192|     19.821
RTD|     -1.782|      2.409|     14.999|       0|     0|     -2.192|     19.821
RTD|     -1.774|      2.364|     18.456|       0|     0|     -2.192|     19.821
RTD|     -1.784|      2.328|     19.914|       0|     0|     -2.192|     19.914
RTD|     -1.768|      2.293|     19.639|       0|     0|     -2.192|     19.914
RTD|     -1.777|      2.263|     19.463|       0|     0|     -2.192|     19.914
RTD|     -1.228|      2.389|     19.923|       0|     0|     -2.192|     19.923
RTD|     -1.223|      2.405|     19.579|       0|     0|     -2.192|     19.923
RTD|     -1.778|      2.431|     14.499|       0|     0|     -2.192|     19.923
RTD|     -1.983|      2.493|     15.335|       0|     0|     -2.192|     19.923


Looking at the worst case of a latency of about 20 us with a task at 2 KHz
I can estimate 2*10^-3 * 20 * 10 ^-6 = 40 * 10^-3 sec lost for latency in 1 sec..
In the average case I will have 5*10^-3 sec. lost for latency in 1 sec. 

I think that these percentage can be accepted in a robotic position control,
what do you think about these assumption?

Can you suggest me a better way to evaluate the latency with respect of robotic 
position control system or can you suggest me some useful articles to read about this topic?

My kernel has the following configuration

CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set

CONFIG_HIGH_RES_TIMERS=y 

and I had a look at 

https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions

Do you think that setting CONFIG_PREEMT=y instead of 
CONFIG_PREEMPT_VOLUNTARY=y
will significantly reduce latency?

Thank you for your kind support.


Gianpaolo Rizzi



----Messaggio originale----
Da: gilles.chanteperdrix@xenomai.org
Data: 5-gen-2011 8.06 PM
A: "gprizzi@domain.hid"<gprizzi@domain.hid>
Cc: <xenomai@xenomai.org>
Ogg: Re: R: Re: [Xenomai-help] error in executing xenomai tests

gprizzi@domain.hid wrote:
> Tank you for your quick and clear replay.
> 
> I am going to use xenomai to run OROCOS based control applications.
> The faster frequency of periodic tasks is estimated between 1KHz to 2 KHz.

Well, that is not enough information. If you seriously want to meet some
deadlines, you have to make a few calculations, then see if your system
has sufficient latency, using the "latency" test. But this really is the
job you should be doing.

Note that for 1kHz or 2kHz on x86 platform, preempt_rt latencies may be
worth checking.

-- 
					    Gilles.



 
------=_Part_193331_14025014.1294344116309
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sir,<br><br>I find your considerations very useful, unfortunately I am=
 not&nbsp; expert in tuning conventional <br>operating system with real tim=
e patch.<br><br>If you can help me I will greatly appreciate your advices.<=
br><br>I run latency test and got the following results:<br><br>root@domain.hid=
1010:/usr/lib/xenomai# ./latency<br>=3D=3D Sampling period: 100 us<br>=3D=
=3D Test mode: periodic user-mode task<br>=3D=3D All results in microsecond=
s<br>warming up...<br>RTT|&nbsp; 00:00:01&nbsp; (periodic user-mode task, 1=
00 us period, priority 99)<br>RTH|----lat min|----lat avg|----lat max|-over=
run|---msw|---lat best|--lat worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.786|&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.224|&nbsp;&nbsp;&nbsp;&nbsp; 19.821|&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbs=
p;&nbsp; -1.786|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&n=
bsp; -1.796|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.330|&nbsp;&nbsp;&nbsp;&nbsp; 1=
9.490|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nb=
sp;&nbsp;&nbsp;&nbsp; -1.796|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&=
nbsp;&nbsp;&nbsp; -1.831|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.231|&nbsp;&nbsp;&=
nbsp;&nbsp; 19.495|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp=
;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -1.831|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<b=
r>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.772|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.291|=
&nbsp;&nbsp;&nbsp;&nbsp; 19.743|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbs=
p;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -1.831|&nbsp;&nbsp;&nbsp;&n=
bsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.473|&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 2.460|&nbsp;&nbsp;&nbsp;&nbsp; 19.708|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -1.831|&nbsp;&=
nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.524|&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2.381|&nbsp;&nbsp;&nbsp;&nbsp; 19.717|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -=
1.831|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.75=
2|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.338|&nbsp;&nbsp;&nbsp;&nbsp; 19.807|&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&=
nbsp;&nbsp; -1.831|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp=
;&nbsp; -1.893|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.297|&nbsp;&nbsp;&nbsp;&nbsp=
; 19.520|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|=
&nbsp;&nbsp;&nbsp;&nbsp; -1.893|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbs=
p;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.284|&nbsp;&nbs=
p;&nbsp;&nbsp; 19.549|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&n=
bsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.82=
1<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.635|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.3=
27|&nbsp;&nbsp;&nbsp;&nbsp; 19.530|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&=
nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp=
;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.416|&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 2.406|&nbsp;&nbsp;&nbsp;&nbsp; 19.580|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbs=
p;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.305|&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 2.471|&nbsp;&nbsp;&nbsp;&nbsp; 14.930|&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp=
; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1=
.782|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.409|&nbsp;&nbsp;&nbsp;&nbsp; 14.999|&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbs=
p;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&nbsp;&nbsp;&n=
bsp;&nbsp; -1.774|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.364|&nbsp;&nbsp;&nbsp;&n=
bsp; 18.456|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;=
 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.821<br>RTD|&=
nbsp;&nbsp;&nbsp;&nbsp; -1.784|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.328|&nbsp;&=
nbsp;&nbsp;&nbsp; 19.914|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp=
;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19=
.914<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.768|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.293|&nbsp;&nbsp;&nbsp;&nbsp; 19.639|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&n=
bsp;&nbsp; 19.914<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.777|&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 2.263|&nbsp;&nbsp;&nbsp;&nbsp; 19.463|&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&=
nbsp;&nbsp;&nbsp;&nbsp; 19.914<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp; -1.228|&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 2.389|&nbsp;&nbsp;&nbsp;&nbsp; 19.923|&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&n=
bsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.923<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;=
 -1.223|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.405|&nbsp;&nbsp;&nbsp;&nbsp; 19.57=
9|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&=
nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.923<br>RTD|&nbsp;&nbsp=
;&nbsp;&nbsp; -1.778|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.431|&nbsp;&nbsp;&nbsp=
;&nbsp; 14.499|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nb=
sp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp; 19.923<br>RT=
D|&nbsp;&nbsp;&nbsp;&nbsp; -1.983|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.493|&nbs=
p;&nbsp;&nbsp;&nbsp; 15.335|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&n=
bsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; -2.192|&nbsp;&nbsp;&nbsp;&nbsp;=
 19.923<br><br><br>Looking at the worst case of a latency of about 20 us wi=
th a task at 2 KHz<br>I can estimate 2*10^-3 * 20 * 10 ^-6 =3D 40 * 10^-3 s=
ec lost for latency in 1 sec..<br>In the average case I will have 5*10^-3 s=
ec. lost for latency in 1 sec. <br><br>I think that these percentage can be=
 accepted in a robotic position control,<br>what do you think about these a=
ssumption?<br><br>Can you suggest me a better way to evaluate the latency w=
ith respect of robotic <br>position control system or can you suggest me so=
me useful articles to read about this topic?<br><br>My kernel has the follo=
wing configuration<br><br>CONFIG_PREEMPT_VOLUNTARY=3Dy<br># CONFIG_PREEMPT =
is not set<br><br>CONFIG_HIGH_RES_TIMERS=3Dy <br><br>and I had a look at <b=
r><br>https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions<br><b=
r>Do you think that setting CONFIG_PREEMT=3Dy instead of <br>CONFIG_PREEMPT=
_VOLUNTARY=3Dy<br>will significantly reduce latency?<br><br>Thank you for y=
our kind support.<br><br><br>Gianpaolo Rizzi<br>
<br>
----Messaggio originale----<br>Da: gilles.chanteperdrix@xenomai.org<br>Data=
: 5-gen-2011 8.06 PM<br>A: "gprizzi@domain.hid"&lt;gprizzi@domain.hid&gt;<br>Cc: &l=
t;xenomai@xenomai.org&gt;<br>Ogg: Re: R: Re: [Xenomai-help] error in execu=
ting xenomai tests<br><br>gprizzi@domain.hid wrote:<br>&gt; Tank you for your q=
uick and clear replay.<br>&gt; <br>&gt; I am going to use xenomai to run OR=
OCOS based control applications.<br>&gt; The faster frequency of periodic t=
asks is estimated between 1KHz to 2 KHz.<br><br>Well, that is not enough in=
formation. If you seriously want to meet some<br>deadlines, you have to mak=
e a few calculations, then see if your system<br>has sufficient latency, us=
ing the "latency" test. But this really is the<br>job you should be doing.<=
br><br>Note that for 1kHz or 2kHz on x86 platform, preempt_rt latencies may=
 be<br>worth checking.<br><br>-- <br>=09=09=09=09=09&nbsp;&nbsp;&nbsp; Gill=
es.<br><br><br>

------=_Part_193331_14025014.1294344116309--



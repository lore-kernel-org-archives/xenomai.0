MIME-Version: 1.0
Date: Wed, 22 Jun 2011 09:03:45 +0800
Message-ID: <BANLkTinbGMWsynYiAm4+-jOyCHxeOf=N4Q@mail.gmail.com>
From: Fang Qiang <fq0237@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071c6f8589c7104a6428a09
Subject: [Xenomai-help] ask help for xenomai-2.5.5.1
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

--20cf3071c6f8589c7104a6428a09
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

       I installed xenomai-2.5.5.1 on x86 with kernel 2.6.35.7 by following
the instruction of Readme.Install.

      After that, I ran the latency test, and got the following results. I
have no idea about whether results are correct or not?

      Is there anybody help me with this? Thanks in advance.

./latency

== Sampling period: 100 us

== Test mode: periodic user-mode task

== All results in microseconds

warming up...

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst

RTD|-480610.017|  19128.256| 518866.530|       0|     0|-480610.017|
518866.530

RTD|-759691.778| 114838.028| 759750.825|       0|     0|-759691.778|
759750.825

RTD|-759705.421|-155661.956| 759737.182|       0|     0|-759705.421|
759750.825

RTD|-440254.413|  59483.861| 559222.137|       0|     0|-759705.421|
759750.825

RTD|-759719.064|  93804.113| 759723.538|       0|     0|-759719.064|
759750.825

RTD|-759732.707|-176695.871| 759709.895|       0|     0|-759732.707|
759750.825

RTD|-399898.808|  99839.465| 599577.739|       0|     0|-759732.707|
759750.825

RTD|-759746.350|  72770.199| 759696.252|       0|     0|-759746.350|
759750.825

RTD|-759759.994|-197729.786| 759682.609|       0|     0|-759759.994|
759750.825

RTD|-359543.203| 140195.070| 639933.344|       0|     0|-759759.994|
759750.825

RTD|-759673.679|  51888.238| 759768.924|       0|     0|-759759.994|
759768.924

RTD|-759687.322|-218611.747| 759755.281|       0|     0|-759759.994|
759768.924

RTD|-319187.599| 180550.675| 680288.950|       0|     0|-759759.994|
759768.924

RTD|-759700.965|  30854.323| 759741.637|       0|     0|-759759.994|
759768.924

RTD|-759714.608|-239645.661| 759727.994|       0|     0|-759759.994|
759768.924

RTD|-278831.995| 220906.279| 720644.553|       0|     0|-759759.994|
759768.924

RTD|-759728.251|   9820.408| 759714.352|       0|     0|-759759.994|
759768.924

RTD|-758442.444|-258704.171| 241034.105|       0|     0|-759759.994|
759768.924

RTD|-759741.894| 259286.479| 759700.709|       0|     0|-759759.994|
759768.924

RTD|-759755.537| -11213.506| 759687.065|       0|     0|-759759.994|
759768.924

RTD|-718086.840|-218348.566| 281389.708|       0|     0|-759759.994|
759768.924





./latency -t1

== Sampling period: 100 us

== Test mode: in-kernel periodic task

== All results in microseconds

warming up...

RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst

RTD|     12.739|     21.652|     40.195|       0|     0|     12.739|
40.195

RTD|     12.677|     21.462|     40.133|       0|     0|     12.677|
40.195

RTD|     13.835|     21.497|     40.225|       0|     0|     12.677|
40.225

RTD|     13.100|     21.572|     40.193|       0|     0|     12.677|
40.225

RTD|     12.976|     21.526|     40.197|       0|     0|     12.677|
40.225

RTD|     12.914|     21.491|     40.227|       0|     0|     12.677|
40.227

RTD|     13.400|     21.563|     40.172|       0|     0|     12.677|
40.227

RTD|     13.947|     21.590|     40.195|       0|     0|     12.677|
40.227

RTD|     12.603|     21.472|     40.133|       0|     0|     12.603|
40.227

RTD|     13.151|     21.428|     40.162|       0|     0|     12.603|
40.227

RTD|     13.026|     21.471|     40.174|       0|     0|     12.603|
40.227

RTD|     12.964|     21.640|     40.204|       0|     0|     12.603|
40.227

RTD|     12.902|     21.501|     40.068|       0|     0|     12.603|
40.227

RTD|     13.097|     21.535|     40.381|       0|     0|     12.603|
40.381

RTD|     12.715|     21.444|     40.109|       0|     0|     12.603|
40.381

RTD|     13.201|     21.520|     40.201|       0|     0|     12.603|
40.381

RTD|     13.077|     21.488|     40.224|       0|     0|     12.603|
40.381

RTD|     12.786|     21.461|     40.180|       0|     0|     12.603|
40.381

RTD|     12.890|     21.516|     40.192|       0|     0|     12.603|
40.381

RTD|     12.828|     21.525|     40.222|       0|     0|     12.603|
40.381

RTD|     12.703|     21.528|     39.858|       0|     0|     12.603|
40.381

--20cf3071c6f8589c7104a6428a09
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all, <br><br>=A0=A0=A0=A0=A0=A0 I installed xenomai-2.5.5.1 on x86 wit=
h kernel 2.6.35.7 by following the instruction of Readme.Install.<br><br>=
=A0=A0=A0=A0=A0 After that, I ran the latency test, and got the following r=
esults. I have no idea about whether results are correct or not?<br>
<br>=A0=A0=A0=A0=A0 Is there anybody help me with this? Thanks in advance.<=
br><br>

<p class=3D"MsoNormal"><span lang=3D"EN-US">./latency</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Sampling period: 100 us<=
/span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Test mode: periodic user=
-mode task</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D All results in microseco=
nds</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">warming up...</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTT|<span style=3D"mso-spacerun=
:yes">=A0
</span>00:00:01<span style=3D"mso-spacerun:yes">=A0 </span>(periodic user-m=
ode
task, 100 us period, priority 99)</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTH|----lat min|----lat avg|---=
-lat
max|-overrun|---msw|---lat best|--lat worst</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-480610.017|<span style=3D"=
mso-spacerun:yes">=A0 </span>19128.256| 518866.530|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-480610.017| 518866.530</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759691.778| 114838.028|
759750.825|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759691.778| 759750.825=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759705.421|-155661.956|
759737.182|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759705.421| 759750.825=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-440254.413|<span style=3D"=
mso-spacerun:yes">=A0 </span>59483.861| 559222.137|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759705.421| 759750.825</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759719.064|<span style=3D"=
mso-spacerun:yes">=A0 </span>93804.113| 759723.538|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759719.064| 759750.825</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759732.707|-176695.871|
759709.895|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759732.707| 759750.825=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-399898.808|<span style=3D"=
mso-spacerun:yes">=A0 </span>99839.465| 599577.739|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759732.707| 759750.825</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759746.350|<span style=3D"=
mso-spacerun:yes">=A0 </span>72770.199| 759696.252|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759746.350| 759750.825</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759759.994|-197729.786|
759682.609|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759750.825=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-359543.203| 140195.070|
639933.344|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759750.825=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759673.679|<span style=3D"=
mso-spacerun:yes">=A0 </span>51888.238| 759768.924|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759759.994| 759768.924</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759687.322|-218611.747|
759755.281|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-319187.599| 180550.675| 68=
0288.950|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span=
 style=3D"mso-spacerun:yes">=A0=A0=A0=A0
</span>0|-759759.994| 759768.924</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759700.965|<span style=3D"=
mso-spacerun:yes">=A0 </span>30854.323| 759741.637|<span style=3D"mso-space=
run:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759759.994| 759768.924</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759714.608|-239645.661|
759727.994|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-278831.995| 220906.279|
720644.553|<span style=3D"mso-spacerun:yes">=A0=A0=A0 </span><span style=3D=
"mso-spacerun:yes">=A0=A0=A0</span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759759.994| 759768.924</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759728.251|<span style=3D"=
mso-spacerun:yes">=A0=A0 </span>9820.408| 759714.352|<span style=3D"mso-spa=
cerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=A0=
=A0=A0=A0
</span>0|-759759.994| 759768.924</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-758442.444|-258704.171|
241034.105|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759741.894| 259286.479|
759700.709|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-759755.537| -11213.506|
759687.065|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|-718086.840|-218348.566|
281389.708|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<sp=
an style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|-759759.994| 759768.924=
</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">./latency -t1</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Sampling period: 100 us<=
/span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Test mode: in-kernel per=
iodic task</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D All results in microseco=
nds</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">warming up...</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTT|<span style=3D"mso-spacerun=
:yes">=A0
</span>00:00:01<span style=3D"mso-spacerun:yes">=A0 </span>(in-kernel perio=
dic
task, 100 us period, priority 99)</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTH|----lat min|----lat avg|---=
-lat
max|-overrun|---msw|---lat best|--lat worst</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.739|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.652|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.195|<span style=3D"m=
so-spacerun:yes">=A0=A0
</span><span style=3D"mso-spacerun:yes">=A0=A0=A0=A0</span>0|<span style=3D=
"mso-spacerun:yes">=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:yes">=
=A0=A0=A0=A0
</span>12.739|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.195</=
span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.677|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.462|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.133|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.195</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.835|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.497|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.225|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.225</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.100|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.572|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.193|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.225</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.976|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.526|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.197|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.225</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.914|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.491|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.400|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.563|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.172|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677| <span=
 style=3D"mso-spacerun:yes">=A0=A0=A0=A0</span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.947|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.590|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.195|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.677|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.603|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.472|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.133|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.151|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.428|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.162|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.026|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.471|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.174|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.964|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.640|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.204|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.902|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.501|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.068|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.227</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.097|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.535|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.715|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.444|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.109|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.201|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.520|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.201|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>13.077|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.488|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.224|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.786|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.461|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.180|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.890|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.516|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.192|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.828|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.525|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.222|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<p class=3D"MsoNormal"><span lang=3D"EN-US">RTD|<span style=3D"mso-spacerun=
:yes">=A0=A0=A0=A0
</span>12.703|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>21.528|<=
span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>39.858|<span style=3D"m=
so-spacerun:yes">=A0=A0=A0=A0=A0=A0 </span>0|<span style=3D"mso-spacerun:ye=
s">=A0=A0=A0=A0
</span>0|<span style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>12.603|<span =
style=3D"mso-spacerun:yes">=A0=A0=A0=A0 </span>40.381</span></p>



<br clear=3D"all"><br><br>

--20cf3071c6f8589c7104a6428a09--


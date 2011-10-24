Message-ID: <1319494779.40265.YahooMailNeo@domain.hid>
Date: Mon, 24 Oct 2011 15:19:39 -0700 (PDT)
From: makarand pradhan <makarand_u_pradhan@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-916455410-1222723818-1319494779=:40265"
Subject: [Xenomai-core] CPU utilization question
Reply-To: makarand pradhan <makarand_u_pradhan@domain.hid>
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

---916455410-1222723818-1319494779=:40265
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Greetings all,=0A=0AI am working on a real time power pc embedded system wh=
ich uses xenomai. I am presently noticing a CPU utilization which I am not =
able to explain. Will highly appreciate your opinion on the problem describ=
ed below.=0A=0AI'm summarizing my understanding. Pl feel free to correct me=
.=0AI'm using /proc/xenomai/stat to get the CPU util. I'm assuming that the=
 ROOT thread captures the %CPU spent in Linux/secnodary and each xenomai th=
read listed, captures the %CPU in primary domain. If a thread transitions t=
o the secondary, then I'm assuming that the %util in secondary domain will =
get accounted against ROOT and the actual % usage in primary will get accou=
nted against the thread.=0A=0AProblem:=0AI'm starting a xenomai thread usin=
g rt_task_spawn.=A0=0A=A0 =A0 =A0 =A0 rt_task_spawn(&task2, "Task 2 ", STAC=
K_SIZE, 11, 0, task2_func, NULL);=0A=0AThe thread invoking rt_task_spawn, s=
leeps for a long long time without doing anything, or I can pause it.=0Asle=
ep(5000000);=0A=0AThe xenomai task does rt_printfs periodically.=0A=0AWith =
this setup, I was hoping to see 0% CPU util for the linux task in top.=0A=
=0AContrary to this expectation, I notice CPU util as high as 3.1% when I t=
op the linux process:=0A=0A=A0 PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =
=A0SHR S %CPU %MEM =A0 =A0TIME+ =A0COMMAND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=A0=0A=A07988 root =A0 =A0 =A020 =A0 0 =A04940 4376 3688 S =A03.1 =A00.=
8 =A0 0:01.65 a.out =A0 =A0 =A0=0A=0AThe CPU % varies based on the activity=
 I do in the primary domain. i.e. more rt_printfs more %CPU in both primary=
 and secondary.=0A=0A=0AQuestion:=0A=0AIf the linux process is sleeping, wh=
y do I see a CPU util against the process?=A0=0AWhy is the CPU % util vary =
based on the activity I do in the primary domain?=0A=0AThanks for taking th=
e time to look at the question.=0A=0AWould highly appreciate your inputs.=
=0A=0AWarm Rgds,=0AMakarand.
---916455410-1222723818-1319494779=:40265
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt; ">Greet=
ings all,</div><div style=3D"font-family: 'times new roman', 'new york', ti=
mes, serif; font-size: 12pt; "><br></div><div style=3D"font-family: 'times =
new roman', 'new york', times, serif; font-size: 12pt; ">I am working on a =
real time power pc embedded system which uses xenomai. I am presently notic=
ing a CPU utilization which I am not able to explain. Will highly appreciat=
e your opinion on the problem described below.</div><div style=3D"font-fami=
ly: 'times new roman', 'new york', times, serif; font-size: 12pt; "><br></d=
iv><div style=3D"font-family: 'times new roman', 'new york', times, serif; =
font-size: 12pt; ">I'm summarizing my understanding. Pl feel free to correc=
t me.</div><div style=3D"font-family: 'times new roman', 'new york', times,=
 serif;
 font-size: 12pt; ">I'm using /proc/xenomai/stat to get the CPU util. I'm a=
ssuming that the ROOT thread captures the %CPU spent in Linux/secnodary and=
 each xenomai thread listed, captures the %CPU in primary domain. If a thre=
ad transitions to the secondary, then I'm assuming that the %util in second=
ary domain will get accounted against ROOT and the actual % usage in primar=
y will get accounted against the thread.</div><div style=3D"font-family: 't=
imes new roman', 'new york', times, serif; font-size: 12pt; "><br></div><di=
v style=3D"font-family: 'times new roman', 'new york', times, serif; font-s=
ize: 12pt; ">Problem:</div><div style=3D"font-family: 'times new roman', 'n=
ew york', times, serif; font-size: 12pt; ">I'm starting a xenomai thread us=
ing rt_task_spawn.&nbsp;</div><div><div><font face=3D"'times new roman', 'n=
ew york', times, serif">&nbsp; &nbsp; &nbsp; &nbsp; rt_task_spawn(&amp;task=
2, "Task 2 ", STACK_SIZE, 11, 0, task2_func, NULL);</font></div><div
 style=3D"font-family: 'times new roman', 'new york', times, serif; font-si=
ze: 12pt; "><br></div></div><div style=3D"font-family: 'times new roman', '=
new york', times, serif; font-size: 12pt; ">The thread invoking rt_task_spa=
wn, sleeps for a long long time without doing anything, or I can pause it.<=
/div><div><font face=3D"'times new roman', 'new york', times, serif"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>sleep(5000000)=
;</font><br></div><div style=3D"font-family: 'times new roman', 'new york',=
 times, serif; font-size: 12pt; ">The xenomai task does rt_printfs periodic=
ally.</div><div style=3D"font-family: 'times new roman', 'new york', times,=
 serif; font-size: 12pt; "><br></div><div style=3D"font-family: 'times new =
roman', 'new york', times, serif; font-size: 12pt; ">With this setup, I was=
 hoping to see 0% CPU util for the linux task in top.</div><div style=3D"fo=
nt-family: 'times new roman', 'new york', times, serif; font-size: 12pt;
 "><br></div><div style=3D"font-family: 'times new roman', 'new york', time=
s, serif; font-size: 12pt; ">Contrary to this expectation, I notice CPU uti=
l as high as 3.1% when I top the linux process:</div><div style=3D"font-fam=
ily: 'times new roman', 'new york', times, serif; font-size: 12pt; "><br></=
div><div><div><font face=3D"'times new roman', 'new york', times, serif">&n=
bsp; PID USER &nbsp; &nbsp; &nbsp;PR &nbsp;NI &nbsp;VIRT &nbsp;RES &nbsp;SH=
R S %CPU %MEM &nbsp; &nbsp;TIME+ &nbsp;COMMAND &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;&nbsp;</font></div><div><font face=3D"'times new roman', '=
new york', times, serif">&nbsp;7988 root &nbsp; &nbsp; &nbsp;20 &nbsp; 0 &n=
bsp;4940 4376 3688 S &nbsp;<b>3.1</b> &nbsp;0.8 &nbsp; 0:01.65 a.out &nbsp;=
 &nbsp; &nbsp;</font></div><div><span style=3D"font-family: 'times new roma=
n',
 'new york', times, serif; "><br></span></div><div><span style=3D"font-fami=
ly: 'times new roman', 'new york', times, serif; ">The CPU % varies based o=
n the activity I do in the primary domain. i.e. more rt_printfs more %CPU i=
n both primary and secondary.</span><br></div><div style=3D"font-family: 't=
imes new roman', 'new york', times, serif; font-size: 12pt; "><br></div><di=
v style=3D"font-family: 'times new roman', 'new york', times, serif; font-s=
ize: 12pt; ">Question:<br></div><div><div style=3D"font-family: 'times new =
roman', 'new york', times, serif; font-size: 12pt; ">If the linux process i=
s sleeping, why do I see a CPU util against the process?&nbsp;</div><div st=
yle=3D"font-family: 'times new roman', 'new york', times, serif; font-size:=
 12pt; ">Why is the CPU % util vary based on the activity I do in the prima=
ry domain?</div><div style=3D"font-family: 'times new roman', 'new york', t=
imes, serif; font-size: 12pt; "><br></div><div style=3D"font-family: 'times=
 new
 roman', 'new york', times, serif; font-size: 12pt; ">Thanks for taking the=
 time to look at the question.</div><div style=3D"font-family: 'times new r=
oman', 'new york', times, serif; font-size: 12pt; "><br></div><div style=3D=
"font-family: 'times new roman', 'new york', times, serif; font-size: 12pt;=
 ">Would highly appreciate your inputs.</div><div style=3D"font-family: 'ti=
mes new roman', 'new york', times, serif; font-size: 12pt; "><br></div><div=
 style=3D"font-family: 'times new roman', 'new york', times, serif; font-si=
ze: 12pt; ">Warm Rgds,</div><div style=3D"font-family: 'times new roman', '=
new york', times, serif; font-size: 12pt; ">Makarand.</div><div style=3D"fo=
nt-family: 'times new roman', 'new york', times, serif; font-size: 12pt; ">=
<br></div><div style=3D"font-family: 'times new roman', 'new york', times, =
serif; font-size: 12pt; "><br></div></div><div style=3D"font-family: 'times=
 new roman', 'new york', times, serif; font-size: 12pt;
 "><br></div></div></div></body></html>
---916455410-1222723818-1319494779=:40265--


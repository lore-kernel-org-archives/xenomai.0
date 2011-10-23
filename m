Message-ID: <1319401552.9644.YahooMailNeo@domain.hid>
Date: Sun, 23 Oct 2011 13:25:52 -0700 (PDT)
From: "haitaozhumail-disc@domain.hid" <haitaozhumail-disc@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-1062241449-536289358-1319401552=:9644"
Subject: [Xenomai-help] address spaces of real-time task and standard linux
	process
Reply-To: "haitaozhumail-disc@domain.hid" <haitaozhumail-disc@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

---1062241449-536289358-1319401552=:9644
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,=0A=0ADo a standard Linux process and a real-time task (spawned by t=
he standard Linux process with rt_task_create and rt_task_start ) share the=
 same address space? More specifically, I have a C++ program like this:=0A=
=0AClass A{ =0A=0A//Definition of a class A=0A};=0A=0ART_TASK demo_task;=0A=
=0A=A0void demo(void *arg){=0AA * pA =3D (A *)arg;=0A//Access the passed ob=
ject via pA, e.g., pA->a...=0A=0A}=0A=0Aint main(){=0A...=0A=0A=A0 A *pA =
=3D new A;=0A=A0 rt_task_create(&demo_task, "realtime_task", 0, 50, 0);=0A=
=A0 rt_task_start(&demo_task, &demo, (void *)pA);=0A=0A=0A=A0 pause();=0A=
=0A}=0A=0ACan the function demo() correctly access the object created in ma=
in()? What if pA is a smart pointer defined in Boost library?=0A=0A=0AWith =
Many Thanks,=0ATom=0A
---1062241449-536289358-1319401552=:9644
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi All,</div><di=
v><br></div><div>Do a standard Linux process and a real-time task (spawned =
by the standard Linux process with rt_task_create and rt_task_start ) share=
 the same address space? More specifically, I have a C++ program like this:=
</div><div><br></div><div>Class A{ <br></div><div>//Definition of a class A=
</div><div>};</div><div><br></div><div>RT_TASK demo_task;<br><br>&nbsp;void=
 demo(void *arg){</div><div>A * pA =3D (A *)arg;</div><div>//Access the pas=
sed object via pA, e.g., pA-&gt;a...<br></div><div>}</div><div><br></div><d=
iv>int main(){</div><div>...<br></div><div>&nbsp; A *pA =3D new A;</div><di=
v>&nbsp; rt_task_create(&amp;demo_task, "realtime_task", 0, 50, 0);<br>&nbs=
p; rt_task_start(&amp;demo_task, &amp;demo, (void *)pA);<br></div><div><br>=
</div><div><span class=3D"tab">&nbsp;
 pause();<br></span></div><div>}</div><div><br></div><div>Can the function =
demo() correctly access the object created in main()? What if pA is a smart=
 pointer defined in Boost library?</div><div><br></div><div><br></div><div>=
With Many Thanks,</div><div>Tom<br></div></div></body></html>
---1062241449-536289358-1319401552=:9644--


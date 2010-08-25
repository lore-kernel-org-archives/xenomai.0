MIME-Version: 1.0
Date: Wed, 25 Aug 2010 11:12:09 +0200
Message-ID: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
From: Bharath Achuta Bhat <baambekar@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd485acc05885048ea246ea
Subject: [Xenomai-help] Page-fault, switch to secondary mode
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

--000e0cd485acc05885048ea246ea
Content-Type: text/plain; charset=ISO-8859-1

Hello Xenomai experts,

I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3) with ipipe
version 2.7-06.
The target is powerpc (MPC8533E).
My application is switching to the secondary mode (I guess because of a
page-fault) when ntohl() is called.
This is a libc function and I am wondering why only this function (ntohl())
is causing a page-fault.

Here is how the application looks like

main ()
{
...
...
/* Avoids memory swapping for this program */
mlockall(MCL_CURRENT | MCL_FUTURE);

......
......
/* signal handlers */
.....
.....
/* create communication pipes */
rt_pipe_create(&tPipe1, .....
rt_pipe_create(&tPipe2,.......

/* create RT tasks */
rt_task_create(&tTask1,.....
rt_task_create(&tTask2,......
...........
..........

/* start the RT tasks */
rt_task_start(&tTask1,.....
..............
..............

/* turn the current thread into RT function */
ret = rt_task_shadow(NULL, "RT main function", 1, T_SUSP);

....
....

}

One of the rt tasks created calls ntohl() and switches to secondary mode.
Is there a way to avoid it ?

-- 
Thanks and regards
Bharath

--000e0cd485acc05885048ea246ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; border-collapse: collapse; "><div><span class=3D"Apple-styl=
e-span" style=3D"font-family: arial, sans-serif; font-size: 13px; border-co=
llapse: collapse; ">Hello Xenomai experts,</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><br></span></div>I am run=
ning a=A0xenomai-2.5.1 patched kernel (v=A02.6.30.3) with ipipe version=A02=
.7-06.<div>
The target is powerpc (MPC8533E).</div><div>My application is switching to =
the secondary mode (I guess because of a page-fault) when ntohl() is called=
.</div><div>This is a libc function and I am wondering why only this functi=
on (ntohl()) is causing a page-fault.</div>
<div><br></div><div>Here is how the application looks like</div><div><br></=
div><div>main ()</div><div>{</div><div>...</div><div>...</div><div><div>/* =
Avoids memory swapping for this program */</div><div>mlockall(MCL_CURRENT |=
 MCL_FUTURE);</div>
</div><div><br></div><div>......</div><div>......</div><div>/* signal handl=
ers */</div><div>.....</div><div>.....</div><div>/* create communication pi=
pes */</div><div>rt_pipe_create(&amp;tPipe1, .....</div><div>rt_pipe_create=
(&amp;tPipe2,.......</div>
<div><br></div><div>/* create RT tasks */</div><div>rt_task_create(&amp;tTa=
sk1,.....</div><div>rt_task_create(&amp;tTask2,......</div><div>...........=
</div><div>..........</div><div><br></div><div>/* start the RT tasks */</di=
v>
<div>rt_task_start(&amp;tTask1,.....</div><div>..............</div><div>...=
...........</div><div><br></div><div>/* turn the current thread into RT fun=
ction */</div><div>ret =3D rt_task_shadow(NULL, &quot;RT main function&quot=
;, 1, T_SUSP);</div>
<div><br></div><div>....</div><div>....</div><div><br></div><div>}</div><di=
v><br></div><div>One of the rt tasks created calls ntohl() and switches to =
secondary mode.</div><div>Is there a way to avoid it ?=A0</div><div><span c=
lass=3D"Apple-style-span" style=3D"border-collapse: separate; font-size: sm=
all;"><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;"=
><br>
</span></span></div></span>-- <br>Thanks and regards<br>Bharath<br><br>

--000e0cd485acc05885048ea246ea--


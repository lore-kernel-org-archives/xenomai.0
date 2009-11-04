MIME-Version: 1.0
Date: Wed, 4 Nov 2009 18:02:37 +0900
Message-ID: <1f3e02580911040102r1dead1d3lbc66d9a4d9d26d33@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=00504502b00d534b1d047787dfec
Subject: [Xenomai-help] [ARM_MV 88F6290] Task limit, msg receive error
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

--00504502b00d534b1d047787dfec
Content-Type: text/plain; charset=UTF-8

Dear Experts

we are facing 2 problems now:

1) in our test application (very simple one) we can create maximum 50 tasks,
next task is failed to create with error *12*
*- Is there any task number limit?*
*- what does 12 mean?*

2) in our project (originally developed for VxWorks), msgQReceive
function returns
-1 and sets errno to 4
*We think that it might be related to XNBREAK thread's flag.*
Current settings are:
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
- we did verify that total stack size of created VxWorks's tasks is about 60
KB
- we did verify that message queue's ID and task's ID were valid.

*- any idea why function msgQReceive fails ?*

Sergey

--00504502b00d534b1d047787dfec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Experts<div><br></div><div>we are facing 2 problems now:</div><div><br=
></div><div>1) in our test application (very simple one) we can create maxi=
mum 50 tasks, next task is failed to create with error <b>12</b></div><div>
<b>- Is there any task number limit?</b></div><div><b>- what does 12 mean?<=
/b></div><div><br></div><div>2) in our project (originally developed for Vx=
Works), <span class=3D"Apple-style-span" style=3D"font-weight: bold; ">msgQ=
Receive <span class=3D"Apple-style-span" style=3D"font-weight: normal; ">fu=
nction=C2=A0</span>returns -1<span class=3D"Apple-style-span" style=3D"font=
-weight: normal; "> and </span>sets=C2=A0errno=C2=A0to 4</span></div>
<div><b><span class=3D"Apple-style-span" style=3D"font-weight: normal;">We =
think that it might be related to XNBREAK thread&#39;s flag.</span></b></di=
v><div>Current settings are:</div><div><div><span class=3D"Apple-style-span=
" style=3D"font-family: arial, sans-serif; border-collapse: collapse; font-=
size: 17px; white-space: pre; -webkit-border-horizontal-spacing: 2px; -webk=
it-border-vertical-spacing: 2px; ">CONFIG_XENO_OPT_SYS_HEAPSZ=3D256</span><=
/div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif" size=3D"5"=
><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-=
size: 17px; white-space: pre; -webkit-border-horizontal-spacing: 2px; -webk=
it-border-vertical-spacing: 2px; ">CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128</s=
pan></font></div>
- we did verify that total stack size of created VxWorks&#39;s tasks is abo=
ut 60 KB</div><div>- we did verify that message queue&#39;s ID and task&#39=
;s ID were valid.<br><div><font class=3D"Apple-style-span" face=3D"arial, s=
ans-serif" size=3D"5"><span class=3D"Apple-style-span" style=3D"border-coll=
apse: collapse; font-size: 17px; white-space: pre; -webkit-border-horizonta=
l-spacing: 2px; -webkit-border-vertical-spacing: 2px; "><br>
</span></font></div></div><div><b><span class=3D"Apple-style-span" style=3D=
"font-weight: normal;">- any idea why function=C2=A0<span class=3D"Apple-st=
yle-span" style=3D"font-weight: bold; ">msgQReceive <span class=3D"Apple-st=
yle-span" style=3D"font-weight: normal;">fails</span><span class=3D"Apple-s=
tyle-span" style=3D"font-weight: normal; ">=C2=A0?</span></span></span></b>=
</div>
<div><br></div><div>Sergey</div><div><div><div><br></div><div><font class=
=3D"Apple-style-span" face=3D"arial, sans-serif" size=3D"5"><span class=3D"=
Apple-style-span" style=3D"border-collapse: collapse; font-size: 17px; whit=
e-space: pre; -webkit-border-horizontal-spacing: 2px; -webkit-border-vertic=
al-spacing: 2px;"><br>
</span></font></div></div></div>

--00504502b00d534b1d047787dfec--


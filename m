MIME-Version: 1.0
Date: Mon, 11 Jul 2011 11:50:56 +0200
Message-ID: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/mixed; boundary=90e6ba5bc25db30d7b04a7c81edb
Subject: [Xenomai-help] Problems with gdb and rt_task_delete
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

--90e6ba5bc25db30d7b04a7c81edb
Content-Type: multipart/alternative; boundary=90e6ba5bc25db30d7704a7c81ed9

--90e6ba5bc25db30d7704a7c81ed9
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I have two problems. Just before explain my problems i would like to clarify
the context. This exercice is for student. In this exercice, they program a
WorkingTask (infini loop) and they pilot this task with an other (go task).

The first problem is when i used rt_task_delete for stop and delete
WorkingTask, the Xenomai program doesn't finish.
But if i use rt_task_suspend before use rt_task_delete, the program stop
correctly.
Why i must use rt_task_suspend before? what is problem with rt_task_delete?


The second problem: I would like to debug a Xenomai program. But in some
situation, i have problems. Xenomai take all ressource, the simulateur
doesn't respond and gdb is blocked in waiting.
The code of this program is join in this email.

I launched gdb and I used these gdb's commands :

b main
b WorkingTask
b 34
start
continue
next
continue


And after the simulateur doesn't respond and gdb is blocked.

What is problem? do you have other problem with gdb?
A solution of how can i used gdb for debug?


The configuration :

- Linux kernel : 2.6.37
- Adeos patch : adeos-ipipe-2.6.37-x86-2.9-00.patch
- Xenomai : 2.5.6
- Host Linux distribution : Ubuntu 10.04
- Compiler : gcc-4.4.3
- GDB : 7.1

Configuration of kernel:

I used the default configuration of Ubunut 10.04 and i change this:
In "Processor type and features":

- change the processor familly : Ahtlon64

- deactivate Enable -fstack-protector buffer overflow detection
(EXPERIMENTAL)

--90e6ba5bc25db30d7704a7c81ed9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; "><div><span class=3D"Apple-styl=
e-span" style=3D"border-collapse: collapse; font-family: arial, sans-serif;=
 font-size: 13px; ">Hello,</span></div>
<div><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; f=
ont-family: arial, sans-serif; font-size: 13px; "><br></span></div><div>I h=
ave two problems. Just before explain my problems i would like to clarify t=
he context. This exercice is for student. In this exercice, they program a =
WorkingTask (infini loop) and they pilot this task with an other (go task).=
=A0</div>
<div><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; f=
ont-family: arial, sans-serif; font-size: 13px; "><br></span></div><div><di=
v>The first problem is when i used rt_task_delete for stop and delete Worki=
ngTask, the Xenomai program doesn&#39;t finish.</div>
<div>But if i use rt_task_suspend before use rt_task_delete, the program st=
op correctly.</div><div>Why i must use rt_task_suspend before? what is prob=
lem with rt_task_delete?</div></div><div><br></div><div><br></div><div>
<div>The second problem: I would like to debug a Xenomai program. But in so=
me situation, i have problems. Xenomai take all ressource, the simulateur d=
oesn&#39;t respond and gdb is blocked in waiting.</div><div>The code of thi=
s program is join in this email.=A0</div>
</div><div><br></div><div>I launched gdb and I used these gdb&#39;s command=
s :</div></span><blockquote class=3D"webkit-indent-blockquote" style=3D"mar=
gin: 0 0 0 40px; border: none; padding: 0px;"><span class=3D"Apple-style-sp=
an" style=3D"border-collapse: collapse; font-family: arial, sans-serif; fon=
t-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">b main</span></div></span><spa=
n class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-famil=
y: arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">b WorkingTask</span></div></sp=
an><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; fon=
t-family: arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">b 34</span></div></span><span =
class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family:=
 arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">start</span></div></span><span=
 class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family=
: arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">continue</span></div></span><s=
pan class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-fam=
ily: arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">next</span></div></span><span =
class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family:=
 arial, sans-serif; font-size: 13px; "><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; ">continue</span></div></span></=
blockquote><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><spa=
n class=3D"Apple-style-span" style=3D"border-collapse: collapse;"><br>
</span></font><span class=3D"Apple-style-span" style=3D"border-collapse: co=
llapse; font-family: arial, sans-serif; font-size: 13px; "><div><span class=
=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family: aria=
l, sans-serif; font-size: 13px; ">And after the simulateur doesn&#39;t resp=
ond and gdb is blocked.</span></div>
<div><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; f=
ont-family: arial, sans-serif; font-size: 13px; "><br></span></div><div><sp=
an class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-fami=
ly: arial, sans-serif; font-size: 13px; ">What is problem? do you have othe=
r problem with gdb?</span></div>
<div>A solution of how can i used gdb for debug?</div><div><span class=3D"A=
pple-style-span" style=3D"border-collapse: collapse; font-family: arial, sa=
ns-serif; font-size: 13px; "><br></span></div><div><br></div>The configurat=
ion=A0:<br>
<br><div style=3D"margin-left: 40px; ">- Linux kernel : 2.6.37<br>- Adeos p=
atch : adeos-ipipe-2.6.37-x86-2.9-00.patch<br>- Xenomai : 2.5.6<br>- Host L=
inux distribution : Ubuntu 10.04<br>- Compiler : gcc-4.4.3<br></div><div st=
yle=3D"margin-left: 40px; ">
- GDB : 7.1</div><br>Configuration of kernel:<br><br>I used the default con=
figuration of Ubunut 10.04 and i change this:<div style=3D"margin-left: 40p=
x; "><span lang=3D"en"><span title=3D"Cliquer ici pour voir d&#39;autres tr=
aductions">In &quot;Processor type and features&quot;:</span></span></div>
</span><blockquote class=3D"webkit-indent-blockquote" style=3D"margin: 0 0 =
0 40px; border: none; padding: 0px;"><span class=3D"Apple-style-span" style=
=3D"border-collapse: collapse; font-family: arial, sans-serif; font-size: 1=
3px; "><div style=3D"margin-left: 40px; ">
- change the processor familly : Ahtlon64</div></span></blockquote><span cl=
ass=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family: a=
rial, sans-serif; font-size: 13px; "><div style=3D"margin-left: 40px; "><di=
v style=3D"margin-left: 40px; ">
<span lang=3D"en"><span title=3D"Cliquer ici pour voir d&#39;autres traduct=
ions">-=A0</span></span><span lang=3D"en"><span title=3D"Cliquer ici pour v=
oir d&#39;autres traductions">deactivate Enable -fstack-protector buffer ov=
erflow detection (EXPERIMENTAL)</span></span></div>
</div></span>

--90e6ba5bc25db30d7704a7c81ed9--

--90e6ba5bc25db30d7b04a7c81edb
Content-Type: text/x-csrc; charset=US-ASCII; name="projet_vierge.c"
Content-Disposition: attachment; filename="projet_vierge.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpz7u00i0

I2luY2x1ZGUgPG5hdGl2ZS90YXNrLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8
YXNzZXJ0Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSAidXRpbHMuaCIKCgpSVF9UQVNL
IFJ0X3dvcmtpbmdfdGFzazsKCmludCBjb21wdGV1cjsKCgp2b2lkIFdvcmtpbmdUYXNrICgpewoJ
Cgljb21wdGV1cj0wOwoJCgl3aGlsZSAoMSl7CgkJY29tcHRldXIrKzsKCQlydF90YXNrX3NsZWVw
ICgxMDApOwoJfQp9CgoKdm9pZCBnbyAoKXsKCQoJaW50IGNvZGVFcnJldXI7CgkKCWNvZGVFcnJl
dXIgPSBydF90YXNrX3N0YXJ0ICgmUnRfd29ya2luZ190YXNrLCAmV29ya2luZ1Rhc2ssIE5VTEwp
OwoJYXNzZXJ0IChjb2RlRXJyZXVyID09IDApOwoJCgljb2RlRXJyZXVyID0gcnRfdGFza19zbGVl
cCAoVElNRShNU18yX05TKDEwMCkpKTsKCWFzc2VydCAoY29kZUVycmV1ciA9PSAwKTsKCQoJY29k
ZUVycmV1ciA9IHJ0X3Rhc2tfc3VzcGVuZCAoJlJ0X3dvcmtpbmdfdGFzayk7IC8vIGlmIHlvdSBk
ZWxldGUgdGhpcyBsaWduZSwgdGhlIHByb2dyYW0gZG9lc24ndCBzdG9wCglhc3NlcnQgKGNvZGVF
cnJldXIgPT0gMCk7CgkKCWNvZGVFcnJldXIgPSBydF90YXNrX2RlbGV0ZSAoJlJ0X3dvcmtpbmdf
dGFzayk7Cglhc3NlcnQgKGNvZGVFcnJldXIgPT0gMCk7Cn0KCgppbnQgbWFpbiAodm9pZCl7CglS
VF9UQVNLIFJ0X2dvX3Rhc2s7CglpbnQgY29kZUVycmV1cjsKCQoJY29kZUVycmV1ciA9IG1sb2Nr
YWxsKCBNQ0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUgKTsKCWFzc2VydCAoY29kZUVycmV1ciA9PSAw
KTsKCQoJY29kZUVycmV1ciA9IHJ0X3Rhc2tfY3JlYXRlICgmUnRfZ29fdGFzaywgImdvIiwgREVG
QVVMVF9TVEFDS19TSVpFLCA1MCwgVF9GUFUgfCBUX0pPSU5BQkxFKTsKCWFzc2VydCAoY29kZUVy
cmV1ciA9PSAwKTsKCQoJY29kZUVycmV1ciA9IHJ0X3Rhc2tfY3JlYXRlICgmUnRfd29ya2luZ190
YXNrLCAid29ya2luZyIsIERFRkFVTFRfU1RBQ0tfU0laRSwgMzAsIFRfRlBVIHwgVF9KT0lOQUJM
RSk7Cglhc3NlcnQgKGNvZGVFcnJldXIgPT0gMCk7CgkKCWNvZGVFcnJldXIgPSBydF90YXNrX3N0
YXJ0ICgmUnRfZ29fdGFzaywgJmdvLCBOVUxMKTsKCWFzc2VydCAoY29kZUVycmV1ciA9PSAwKTsK
CQoJY29kZUVycmV1ciA9IHJ0X3Rhc2tfam9pbigmUnRfZ29fdGFzayk7Cglhc3NlcnQgKGNvZGVF
cnJldXIgPT0gMCk7CgkKCXByaW50ZigiRW5kIG9mIHByb2dyYW1cclxuIik7CgkKCXJldHVybiAw
Owp9Cgo=
--90e6ba5bc25db30d7b04a7c81edb--


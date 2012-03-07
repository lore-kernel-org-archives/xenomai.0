MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
Date: Wed, 7 Mar 2012 10:45:19 +0100
Message-ID: <CA+eKTkacCZwnKRE6kyAVY=a89mwsFO7Qjaeyq5eqDop+ZngiyA@mail.gmail.com>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/mixed; boundary=20cf30363cd17c503b04baa404c6
Subject: [Xenomai-help] a4l_sync_dio information
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

--20cf30363cd17c503b04baa404c6
Content-Type: multipart/alternative; boundary=20cf30363cd17c503704baa404c4

--20cf30363cd17c503704baa404c4
Content-Type: text/plain; charset=ISO-8859-1

Hello to all, I am using xenomai-2.6.0 on an ubuntu 10.10 with linux
kernel 2.6.38.8 on a x86 platform.
I am trying to make the digital input/output work but can't manage to do so.
To do this, I use the
a4l_sync_dio<group__sync2__lib.html#gada79039a312c5cab36653c9edda98a3c>
function,
but I am not sure I understand well
what it's arguments should be (attached is an example program).

My program is supposed to change the value of the DO channels to 1
and then set it back to 0, but when I launch my program, it returns without
any error
but doesn't change anything on the channels (I check them with an
oscilloscope)

Could someone give me an advice ?

Thanks in advance !

Hadrien

--20cf30363cd17c503704baa404c4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello to all, I am using xenomai-2.6.0 on an ubuntu 10.10 with linux kernel=
=A02.6.38.8 on a x86 platform.<div>I am trying to make the digital input/ou=
tput work but can&#39;t manage to do so.</div><div>To do this, I use the=A0=
<span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande&#3=
9;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><a class=3D"el" href=3D"=
group__sync2__lib.html#gada79039a312c5cab36653c9edda98a3c" style=3D"color:r=
gb(70,101,162);font-weight:bold;text-decoration:none">a4l_sync_dio</a>=A0fu=
nction, but I am not sure I understand well</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">what it&#39;s argum=
ents should be (attached is an example program).</span></div><div><span cla=
ss=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande&#39;,Verdan=
a,Geneva,Arial,sans-serif;font-size:12px"><br>
</span></div><div><span class=3D"Apple-style-span" style=3D"font-family:&#3=
9;Lucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">My pro=
gram is supposed to change the value of the DO channels to 1</span></div><d=
iv>
<span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande&#3=
9;,Verdana,Geneva,Arial,sans-serif;font-size:12px">and then set it back to =
0, but w</span><span class=3D"Apple-style-span" style=3D"font-family:&#39;L=
ucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">hen I lau=
nch my program, it returns without any error</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">but doesn&#39;t cha=
nge anything on the channels (I check them with an oscilloscope)</span></di=
v>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><br></span></div><d=
iv><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande=
&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">Could someone give me=
 an advice ?</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><br></span></div><d=
iv><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande=
&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">Thanks in advance !</=
span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><br></span></div><d=
iv><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Grande=
&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px">Hadrien</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family:&#39;Lucida Gran=
de&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px"><br></span></div>

--20cf30363cd17c503704baa404c4--

--20cf30363cd17c503b04baa404c6
Content-Type: application/octet-stream; name="main.cc"
Content-Disposition: attachment; filename="main.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzi6kt710

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8aW9zdHJlYW0+CiNpbmNsdWRlIDxzc3RyZWFtPgojaW5jbHVkZSA8Z2V0b3B0
Lmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgoKZXh0ZXJuICJDIiB7CiNpbmNsdWRlIDxuYXRpdmUv
dGFzay5oPgojaW5jbHVkZSA8bnVjbGV1cy9zY2hlZC5oPgojaW5jbHVkZSA8YW5hbG9neS9hbmFs
b2d5Lmg+CiNpbmNsdWRlIDxhbmFsb2d5L2Rlc2NyaXB0b3IuaD4KI2luY2x1ZGUgPGFuYWxvZ3kv
c3ViZGV2aWNlLmg+Cn0KCiNkZWZpbmUgRklMRU5BTUUgImFuYWxvZ3kwIgojZGVmaW5lIE5CX0NI
QU5ORUxTIDE2CiNpbmNsdWRlIDxpb3N0cmVhbT4KCgppbnQgbWFpbiAoKQp7CiAgYTRsX2Rlc2Nf
dCAqZGVzY3JpcHRvcjsKICBkZXNjcmlwdG9yID0gbmV3IGE0bF9kZXNjX3QoKTsKICBkZXNjcmlw
dG9yLT5zYmRhdGEgPSBOVUxMOwoKICBhNGxfb3BlbihkZXNjcmlwdG9yLCBGSUxFTkFNRSk7CiAg
YTRsX3NiaW5mb190ICpzYmluZm8gPSBOVUxMOwoKICB1aW50OF90IHdyaXRpbmdCdWZmZXJbTkJf
Q0hBTk5FTFNdOwogIHVpbnQ4X3QgbWFza0J1ZmZlcltOQl9DSEFOTkVMU107CgoKICBkZXNjcmlw
dG9yLT5zYmRhdGEgPSBtYWxsb2MoZGVzY3JpcHRvci0+c2JzaXplKTsKICBhNGxfZmlsbF9kZXNj
KGRlc2NyaXB0b3IpOwoKICBmb3IgKGludCBpPTA7IGk8ZGVzY3JpcHRvci0+bmJfc3ViZDsgaSsr
KQogICAgewogICAgICBhNGxfZ2V0X3N1YmRpbmZvKGRlc2NyaXB0b3IsIGkgLCAmc2JpbmZvKTsK
ICAgICAgaWYgKChzYmluZm8tPmZsYWdzICYgQTRMX1NVQkRfVFlQRVMpID09IEE0TF9TVUJEX0RJ
TykgCgl7CgkgIHN0ZDo6Y291dCA8PCAiRm91bmQgRElPIiA8PCBzdGQ6OmVuZGw7CgkgIGRlc2Ny
aXB0b3ItPmlkeF93cml0ZV9zdWJkID0gaTsKCSAgYnJlYWs7Cgl9CiAgICAgIGlmIChpID09IGRl
c2NyaXB0b3ItPm5iX3N1YmQgLTEpIAoJc3RkOjpjb3V0IDw8ICJObyBEaWdpdGFsIE91dHB1dCBm
b3VuZCIgPDwgc3RkOjplbmRsOwogICAgfQoKICBmb3IgKGludCBpPTA7IGkgPCBOQl9DSEFOTkVM
UypOQl9EQVRBKjI7ICsraSkKICAgIHsKICAgICAgd3JpdGluZ0J1ZmZlcltpXSA9IDB4ZmZmZmZm
ZmY7CiAgICAgIG1hc2tCdWZmZXJbaV0gPSAweGZmZmZmZmZmOwogICAgfQoKICBpbnQgcmUgPSBh
NGxfc3luY19kaW8oZGVzY3JpcHRvciwgCgkJCWRlc2NyaXB0b3ItPmlkeF93cml0ZV9zdWJkLAoJ
CQltYXNrQnVmZmVyLAoJCQl3cml0aW5nQnVmZmVyKTsKCiAgc2xlZXAoMyk7CgogIGZvciAoaW50
IGk9MDsgaSA8IE5CX0NIQU5ORUxTKk5CX0RBVEEqMjsgKytpKQogICAgewogICAgICB3cml0aW5n
QnVmZmVyW2ldID0gMHgwMDAwMDAwMDsKICAgIH0KCiAgcmUgPSBhNGxfc3luY19kaW8oZGVzY3Jp
cHRvciwgCgkJCWRlc2NyaXB0b3ItPmlkeF93cml0ZV9zdWJkLAoJCQltYXNrQnVmZmVyLAoJCQl3
cml0aW5nQnVmZmVyKTsKCgogIHJldHVybihyZSk7Cgp9Cg==
--20cf30363cd17c503b04baa404c6--


MIME-Version: 1.0
Date: Mon, 8 Aug 2011 14:55:36 +0200
Message-ID: <CAL+uwv-ccr22BOBTkVUstxxbi7qZjhUQ5062EKYaVVV3yqxkQQ@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec548a05ba621b804a9fdf6d8
Subject: [Xenomai-help] Regarding timer services.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec548a05ba621b804a9fdf6d8
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

Iam using native skin of xenomai . Iam trying to test some of the services
of xenomai native skin with my Hardware (pandaboard).

i have two threads namely t1 and t2 .

1. t1 sends a message to t2 using messeage que

2. t2 receives message and runs it executions .

3. t2 executing is completed it sends a message to t1 that iam completed.

4. t1 receives message .

i would like know the time taken between t1 sends and t1 receives message.

For this test do i need to synchronise the xenomai timer with my hardware
timer

or is it otherway around?

--bcaec548a05ba621b804a9fdf6d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear all,<div><br></div><div>Iam using native skin of xeno=
mai . Iam trying to test some of the services of xenomai native skin with m=
y Hardware (pandaboard).</div><div><br></div><div>i have two threads namely=
 t1 and t2 .=A0</div>
<div><br></div><div>1. t1 sends a message to t2 using messeage que=A0</div>=
<div><br></div><div>2. t2 receives message and runs it executions .</div><d=
iv><br></div><div>3. t2 executing is completed it sends a message to t1 tha=
t iam completed.</div>
<div><br></div><div>4. t1 receives message .</div><div><br></div><div>i wou=
ld like know the time taken between t1 sends and t1 receives message.</div>=
<div><br></div><div>For this test do i need to synchronise the xenomai time=
r with my hardware timer =A0</div>
<div><br></div><div>or is it otherway around?</div><div><font class=3D"Appl=
e-style-span" color=3D"#333333"><span class=3D"Apple-style-span" style=3D"f=
ont-family: Geneva, Arial, Helvetica, sans-serif; font-size: 13px; "><br></=
span></font></div>
<div><font class=3D"Apple-style-span" color=3D"#333333"><span class=3D"Appl=
e-style-span" style=3D"font-family: Geneva, Arial, Helvetica, sans-serif; f=
ont-size: 13px; "><br></span></font></div><div><br><br>
</div></div>

--bcaec548a05ba621b804a9fdf6d8--


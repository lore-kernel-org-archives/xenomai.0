MIME-Version: 1.0
Date: Wed, 25 Jan 2012 09:42:52 -0600
Message-ID: <CAL0cVRD26O9Z+afvp0NGQp3qHaAKk-2Cz+dwygZXcD_30HVyDQ@mail.gmail.com>
From: Christopher Roberts <adrath@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0401fc57dfe54804b75c1d36
Subject: [Xenomai-help] Xenomai and Pandaboard
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

--f46d0401fc57dfe54804b75c1d36
Content-Type: text/plain; charset=ISO-8859-1

I've been trying to build a working kernel with Xenomai librarys for the
last couple of days, and keep running into snags. Its the first time I've
ever tried to build a kernel before, though I do have some experience with
Linux and embedded systems.

So far, I've tried using a cross toolchchain built using Buildroot 2011.8,
which I used to make x-loader and u-loader, both of which appear to work,
then the 2.6.38.8 kernel with xenomai 2.6.0, which seems to compile
correctly, but on boot up the board halts after unpacking the kernel (both
front lights stay on and it never tries to actually start up the hardware).
So next I tried building it on a working Ubunutu 11.10 image running on the
pandaboard, but I was never able to successfully build the kernel that way.

Any advice I could get on what I'm doing wrong would be
greatly appreciated.

Thanks,
Chris

--f46d0401fc57dfe54804b75c1d36
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I&#39;ve been trying to build a working=A0kernel=A0with Xenomai librar=
ys for the last couple of days, and keep running into snags. Its the first =
time I&#39;ve ever tried to build a kernel before, though I do have some ex=
perience with Linux and=A0embedded=A0systems.=A0</div>
<div><br></div><div>So far,=A0I&#39;ve=A0tried using a cross toolchchain=A0=
built=A0using Buildroot 2011.8, which I used to make x-loader and u-loader,=
 both of which appear to work, then the 2.6.38.8 kernel with xenomai 2.6.0,=
 which seems to compile correctly, but on boot up the board halts after unp=
acking the kernel (both front lights stay on and it never tries to actually=
 start up the hardware). So next I tried building it on a working Ubunutu 1=
1.10 image running on the pandaboard, but I was never able to=A0successfull=
y=A0build the kernel that way.</div>
<div><br></div><div>Any advice I could get on what I&#39;m doing wrong woul=
d be greatly=A0appreciated.=A0</div><div><br></div><div>Thanks,</div><div>C=
hris</div>

--f46d0401fc57dfe54804b75c1d36--


MIME-Version: 1.0
Date: Fri, 1 Jul 2011 10:46:17 +0200
Message-ID: <BANLkTikhZA6YGb95ryC1mO6m_RQgAe-PtA@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec517a9ba0ce50804a6fe0d1b
Subject: [Xenomai-help] regd booting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--bcaec517a9ba0ce50804a6fe0d1b
Content-Type: text/plain; charset=ISO-8859-1

Dear Giles,

sorry for repeated questions on boot procees but i want to make sure where
my boot process going wrong.

Now my uImage was correctly builded and modules were in right place
(/lib/modules/2.6.37.6) .

i have used the MLO and Uboot.bin files from ubuntu package  which during
1st step of  booting process generating a initramfs or initrd and this seems
to be broken with my custom kernel and fails to recognise the 2nd partion  .
I mean the ext partion of sd card is not mounting (in this partion modules
were placed) .

Did you builded MLO and Uboot.bin for this kernel or you just used already
 builded ones of ubuntu or minimal fs .




Thanks
Suresh balijepalli
Rosenehim,Baveria.

--bcaec517a9ba0ce50804a6fe0d1b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Giles,<div><br></div><div>sorry for repeated question=
s on boot procees but i want to make sure where my boot process going wrong=
.</div><div><br></div><div>Now my uImage was correctly builded and modules =
were in right place (/lib/modules/<a href=3D"http://2.6.37.6" target=3D"_bl=
ank">2.6.37.6</a>) .=A0</div>
<div><br></div><div>i have used the MLO and Uboot.bin files from ubuntu pac=
kage =A0which during 1st step of =A0booting process generating a initramfs =
or initrd and this seems to be broken with my custom kernel and fails to re=
cognise the 2nd partion =A0. I mean the ext partion of sd card is not mount=
ing (in this partion modules were placed) .</div>
<div><br></div><div>Did you builded MLO and Uboot.bin for this kernel or yo=
u just used already =A0builded ones of ubuntu or minimal fs .</div><div><br=
></div><div><br clear=3D"all"><br><br>Thanks<br>Suresh balijepalli<br>Rosen=
ehim,Baveria.<br>

</div></div>

--bcaec517a9ba0ce50804a6fe0d1b--


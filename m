MIME-Version: 1.0
Date: Tue, 21 Jun 2011 10:05:25 +0200
Message-ID: <BANLkTi=xprfSAwzV6g=GmC7q1sEUz4_t_g@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec501673f78116204a63450e8
Subject: [Xenomai-help] unsupported arm machine
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

--bcaec501673f78116204a63450e8
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

Iam compiling the patched kernel that i got from the xenomai git repository.

during configuration i did not done any changes. Removing all other boards
from TI except Pandaboard .

during building uImage iam getting error as below

In file included from
/home/balijepalli/omap4/ipipe-gch/kernel/xenomai/arch/generic/hal.c:47:
/home/balijepalli/omap4/ipipe-gch/arch/arm/include/asm/xenomai/hal.h:77:
error: #error "Unsupported ARM machine"
make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[4]: *** [kernel/xenomai/arch/generic] Error 2
make[3]: *** [kernel/xenomai/arch] Error 2
make[2]: *** [kernel/xenomai] Error 2
make[1]: *** [kernel] Error 2
make: *** [sub-make] Error 2


There is an hal file from xenomai git ,  Last time i replaced the errored
hal file with the file from git . Is it the way i should follow for this
kernel?

-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec501673f78116204a63450e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear all,<div><br></div><div>Iam compiling the patched ker=
nel that i got from the xenomai git repository.</div><div><br></div><div>du=
ring configuration i did not done any changes. Removing all other boards fr=
om TI except Pandaboard .</div>
<div><br></div><div>during building uImage iam getting error as below</div>=
<div><br></div><div>In file included from /home/balijepalli/omap4/ipipe-gch=
/kernel/xenomai/arch/generic/hal.c:47:</div><div>/home/balijepalli/omap4/ip=
ipe-gch/arch/arm/include/asm/xenomai/hal.h:77: error: #error &quot;Unsuppor=
ted ARM machine&quot;</div>
<div>make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1</div><div>mak=
e[4]: *** [kernel/xenomai/arch/generic] Error 2</div><div>make[3]: *** [ker=
nel/xenomai/arch] Error 2</div><div>make[2]: *** [kernel/xenomai] Error 2</=
div>
<div>make[1]: *** [kernel] Error 2</div><div>make: *** [sub-make] Error 2</=
div><div><br></div><div><br></div><div>There is an hal file from xenomai gi=
t , =A0Last time i replaced the errored hal file with the file from git . I=
s it the way i should follow for this kernel? =A0</div>
<div><br>-- <br><br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec501673f78116204a63450e8--


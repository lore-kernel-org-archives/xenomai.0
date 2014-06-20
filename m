From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Fri, 20 Jun 2014 09:02:46 +0000
Message-ID: <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
In-Reply-To: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
Content-Language: de-DE
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Some Information About compilation Xenomai and RT
 Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Jean,=0A=
=0A=
I have merged successfully I-Pipe/Xenomai and Preempt RT patch for Kernel V=
3.10.18. From my point of view it is working very well. The only part which=
 was a bit of tricky to solve was the kernel's spinlock implementation. Thi=
s is since I-Pipe as well as Preempt-RT are patching this part of code each=
 with own implementations. As result it is required to replace Preempt RT's=
 default spinlock calls with new wrappers. Within the wrappers you have to =
decide if Preempt RT's spinlock or I-Pipe's spinlock have to be used at thi=
s place.=0A=
=0A=
My pending problem which I hope to solve soon is the fast context switch ex=
tension (FCSE) that allows better latency times on ARM9. In "guaranteed" mo=
de it crashs when using addresses above 32MB.=0A=
=0A=
If you are interested in more details feel free to ask.=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
Von: Xenomai <xenomai-bounces@xenomai.org> im Auftrag von Jean Rodriguez <j=
.rodriguez@caustier.com>=0A=
Gesendet: Dienstag, 17. Juni 2014 17:00=0A=
An: xenomai@xenomai.org=0A=
Betreff: [Xenomai] Some Information About compilation Xenomai and RT Patche=
s=0A=
=0A=
Hi guys,=0A=
=0A=
I=92m trying to compile kernel 3.8 with the last xenomai source.=0A=
=0A=
I want to know some precisions about preempt option.=0A=
=0A=
Is it useless to patch the kernel with with Xenomai and also with RT patch=
=0A=
from kernel.org?=0A=
=0A=
Because With RT patch I can choose on menuconfig  Preemption Model 5 choice=
s=0A=
(No preempt, Voluntary and low latency , preemptible kernel or fully=0A=
preemptivekernel)=0A=
=0A=
But if I patch only with xenomai I have just 3 choices of preemptive (No=0A=
preempt, Voluntary and low latency)=0A=
=0A=
If patch first with RT and after xenomai I have a lot of Hunk message=0A=
(warning and error) but if  I Patch first with xenomai and after RT -> no=
=0A=
problem=0A=
=0A=
=0A=
=0A=
So my question are they compatible together? Or perhaps choosing fully=0A=
preemptive will turn my system unstable.=0A=
=0A=
=0A=
=0A=
My goal is to catch Interruption with a small latency (50-10 =B5s) with a l=
ow=0A=
processor charge=0A=
=0A=
Board  Arbor card=0A=
<http://www.arbor.com.tw/product/product.aspx?Product_Name=3DEmETX-i2900&os=
_id=0A=
=3D1&version=3D+Default> EmETX-i2900  with ATOM N450=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Thanks for your future response=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
=0A=
=0A=
Jean Rodriguez=0A=
=0A=
Ing=E9nieur R&D Informatique=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
---=0A=
Ce courrier =E9lectronique ne contient aucun virus ou logiciel malveillant =
parce que la protection avast! Antivirus est active.=0A=
http://www.avast.com=0A=
_______________________________________________=0A=
Xenomai mailing list=0A=
Xenomai@xenomai.org=0A=
http://www.xenomai.org/mailman/listinfo/xenomai=0A=


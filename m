From: "Jean Rodriguez" <j.rodriguez@caustier.com>
Date: Tue, 17 Jun 2014 17:00:19 +0200
Message-ID: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Some Information About compilation Xenomai and RT Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi guys,

I=92m trying to compile kernel 3.8 with the last xenomai source.

I want to know some precisions about preempt option. 

Is it useless to patch the kernel with with Xenomai and also with RT patch
from kernel.org?

Because With RT patch I can choose on menuconfig  Preemption Model 5 choice=
s
(No preempt, Voluntary and low latency , preemptible kernel or fully
preemptivekernel)

But if I patch only with xenomai I have just 3 choices of preemptive (No
preempt, Voluntary and low latency)

If patch first with RT and after xenomai I have a lot of Hunk message
(warning and error) but if  I Patch first with xenomai and after RT -> no
problem

 

So my question are they compatible together? Or perhaps choosing fully
preemptive will turn my system unstable.

 

My goal is to catch Interruption with a small latency (50-10 =B5s) with a l=
ow
processor charge

Board  Arbor card
<http://www.arbor.com.tw/product/product.aspx?Product_Name=3DEmETX-i2900&os=
_id
=3D1&version=3D+Default> EmETX-i2900  with ATOM N450

 

 

Thanks for your future response

 

 

Kind regards,

 

Jean Rodriguez

Ing=E9nieur R&D Informatique

 

 

 

 

 



---
Ce courrier =E9lectronique ne contient aucun virus ou logiciel malveillant =
parce que la protection avast! Antivirus est active.
http://www.avast.com

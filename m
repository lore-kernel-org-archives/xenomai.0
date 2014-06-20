Message-ID: <53A3F82D.5090401@xenomai.org>
Date: Fri, 20 Jun 2014 11:00:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
In-Reply-To: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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
To: Jean Rodriguez <j.rodriguez@caustier.com>, xenomai@xenomai.org

On 06/17/2014 05:00 PM, Jean Rodriguez wrote:
> Hi guys,
>
> I=92m trying to compile kernel 3.8 with the last xenomai source.
>
> I want to know some precisions about preempt option.
>
> Is it useless to patch the kernel with with Xenomai and also with RT patch
> from kernel.org?

Combining both makes sense only if your use case involves response time=20
requirements when running regular linux activities, in addition to the=20
real-time duties offloaded to the Xenomai co-kernel. In most cases where=20
a dual kernel solution applies, there is no requirement for full=20
preemption (-rt) on the regular linux side though.

>
> Because With RT patch I can choose on menuconfig  Preemption Model 5 choi=
ces
> (No preempt, Voluntary and low latency , preemptible kernel or fully
> preemptivekernel)
>
> But if I patch only with xenomai I have just 3 choices of preemptive (No
> preempt, Voluntary and low latency)
>

Those choices affect the regular linux kernel behavior only, not=20
Xenomai. When the Xenomai co-kernel is present, there is no need for=20
additional preemption models, the linux kernel is inherently preemptible=20
by Xenomai activities at any time.

> If patch first with RT and after xenomai I have a lot of Hunk message
> (warning and error) but if  I Patch first with xenomai and after RT -> no
> problem
>
>
>
> So my question are they compatible together? Or perhaps choosing fully
> preemptive will turn my system unstable.
>

Combining both is possible, and such configuration is actually used by=20
some projects. However, a combo patch merging preempt-rt and the I-pipe=20
has to be specifically crafted for the target kernel.

>
>
> My goal is to catch Interruption with a small latency (50-10 =B5s) with a=
 low
> processor charge

Since there is no one-fits-it-all solution, I would suggest to benchmark=20
each configuration separately for your use case, and see which one best=20
fits the bill, taking into account the pros and cons of each approach in=20
the long run for your project.

>
> Board  Arbor card
> <http://www.arbor.com.tw/product/product.aspx?Product_Name=3DEmETX-i2900&=
os_id
> =3D1&version=3D+Default> EmETX-i2900  with ATOM N450
>
>
>
>
>
> Thanks for your future response
>
>
>
>
>
> Kind regards,
>
>
>
> Jean Rodriguez
>
> Ing=E9nieur R&D Informatique
>
>
>
>
>
>
>
>
>
>
>
>
>
> ---
> Ce courrier =E9lectronique ne contient aucun virus ou logiciel malveillan=
t parce que la protection avast! Antivirus est active.
> http://www.avast.com
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


--=20
Philippe.


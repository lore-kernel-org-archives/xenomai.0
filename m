Date: Sun, 9 Jun 2013 10:28:53 +0800 (CST)
From: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
In-Reply-To: <51B368EF.3060301@xenomai.org>
References: <44b485fd.1ee68.13f24728cbf.Coremail.ericvic@163.com>
	<51B368EF.3060301@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1920c252.310b.13f26c3cd2d.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] Set gpio irq priority with tzic_set_irq_prio(int irq, int hi)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Then what should change the priority please=EF=BC=9F
=E5=9C=A8 2013-06-09 01:25:03=EF=BC=8C"Gilles Chanteperdrix" <gilles.chante=
perdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>On 06/08/2013 05:40 PM, =E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=E7=A8=8B=E5=
=B8=88 wrote:
>
>> Now I use Imx53 gpio2-14 to be a interrupt source ,but I found its prior=
ity so lower .=20
>
>
>How is that? All the gpio irqs have the same priority.
>
>> So I use tzic_set_irq_prio(int irq, int hi)=20
>> .................................
>> .............................
>>=20
>>=20
>>=20
>>=20
>>  MY_GPIO2_14=3D(1*32+14)+128;
>>  irq=3Dirq_ to_gpio( MY_GPIO2_14);
>>  mxc_tzic_init_irq(IMX53_TZIC_BASE_ADDR);
>>  tzic_set_irq_prio(irq,20);//chang the priority to #30
>> .................................
>> ......................................
>>=20
>>=20
>> Is it right=EF=BC=9F
>
>
>No. tzic_set_irq_prio is an internal function to be used by Xenomai. You
>do not need to use it.
>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>
>
>
>--=20
>                                                                Gilles.



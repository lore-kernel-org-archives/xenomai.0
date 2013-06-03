Date: Mon, 3 Jun 2013 09:47:50 +0800 (CST)
From: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
In-Reply-To: <37d33293.2abd.13f07ada45c.Coremail.ericvic@163.com>
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
	<27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
	<51A9C9EF.2040702@xenomai.org>
	<37d33293.2abd.13f07ada45c.Coremail.ericvic@163.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <48fce07c.3077.13f07b80e33.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

sorry =EF=BC=8Cbefore I did not say clearly=E3=80=82It is Every 500Millisec=
ond gpio send an interrupt
=E5=9C=A8 2013-06-03 09:36:27=EF=BC=8C"=E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=
=E7=A8=8B=E5=B8=88" <ericvic@163.com> =E5=86=99=E9=81=93=EF=BC=9A
>To prevent re-entry
>=E5=9C=A8 2013-06-01 18:16:15=EF=BC=8C"Gilles Chanteperdrix" <gilles.chant=
eperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>>On 06/01/2013 10:41 AM, =E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=E7=A8=8B=E5=
=B8=88 wrote:
>>
>>> I have try the kernal-3.4.6 with ipipe-core-3.4.6-arm-4.patch=20
>>> when I set three same Priority tasks I found untill the tasks stop ,the=
 interrut founction will not run.
>>> It same like before version kernal-2.6.35.9 with  ipipe-core-2.6.35.9-a=
rm-4.patch
>>>=20
>>>=20
>>> static int test_thread(void *data)
>>> {
>>> =09//phase=3Dctrl_mnm1221_m();
>>> =09while(1)
>>> =09{
>>> =09if(flag)
>>> =09{
>>> =09=09printk("runting %lld\n",tt3);
>>> =09=09flag=3D0;
>>> =09=09}
>>> =09SLEEP_MILLI_SEC(50);
>>>=20
>>> =09}
>>> =09return 0;
>>> }
>>>=20
>>> int irq_handle_function(int irq, void *device_id)
>>> {
>>> =09//if(phase=3D=3DPH_RUNNING)
>>> =09//ctrl_mnm1221_m();
>>> =09rt_intr_disable(&amp;intr_desc);
>>> =09tt1=3Drt_timer_read();
>>> =09tt3=3Dtt1-tt2;
>>> =09if(tt3&gt;300000)
>>> =09flag=3D1;
>>> =09tt2=3Dtt1;
>>> =09rt_intr_enable(&amp;intr_desc);
>>> =09return RT_INTR_HANDLED;;
>>> }
>>
>>
>>Why do you disable/enable the irq during the irq handler?
>>
>>
>>--=20
>>                                                                Gilles.



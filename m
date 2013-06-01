Date: Sat, 1 Jun 2013 16:41:48 +0800 (CST)
From: =?utf-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
In-Reply-To: <700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Message-ID: <27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

I have try the kernal-3.4.6 with ipipe-core-3.4.6-arm-4.patch=20
when I set three same Priority tasks I found untill the tasks stop ,the int=
errut founction will not run.
It same like before version kernal-2.6.35.9 with  ipipe-core-2.6.35.9-arm-4=
.patch


static int test_thread(void *data)
{
=09//phase=3Dctrl_mnm1221_m();
=09while(1)
=09{
=09if(flag)
=09{
=09=09printk("runting %lld\n",tt3);
=09=09flag=3D0;
=09=09}
=09SLEEP_MILLI_SEC(50);

=09}
=09return 0;
}

int irq_handle_function(int irq, void *device_id)
{
=09//if(phase=3D=3DPH_RUNNING)
=09//ctrl_mnm1221_m();
=09rt_intr_disable(&amp;intr_desc);
=09tt1=3Drt_timer_read();
=09tt3=3Dtt1-tt2;
=09if(tt3&gt;300000)
=09flag=3D1;
=09tt2=3Dtt1;
=09rt_intr_enable(&amp;intr_desc);
=09return RT_INTR_HANDLED;;
}


void taskOne(void*arg)
{
=09int i;
=09for (i=3D0; i &lt; 0xffff; i++)
=09{=09
=09=09printk("Iam taskOneand global =3D %d................\n", tt3);
=09}
}
void taskTwo(void*arg)
{
=09int i;
=09for (i=3D0; i &lt; 0xffff; i++)
=09{=09
=09=09printk("Iam taskTwo global =3D %d................\n", tt3);
=09}
}
void taskThree(void*arg)
{
=09int i;
=09for (i=3D0; i &lt; 0xffff; i++)
=09{=09
=09=09printk("Iam taskThree global =3D %d................\n", tt3);
=09}
}


static int __init rtex_init(void){
=09irq=3D gpio_to_irq(MY_GPIO2_14);
=09
=09/*err=3Drequest_irq(irq, irq_handle_function, 0, "rtex", (void *)&amp;ir=
q);
=09if(err)
=09{
=09=09printk("regist irq failure...\n");
=09=09return -EIO;
=09}*/
=09err =3D rt_intr_create(&amp;intr_desc,"MyIrq",irq,irq_handle_function,NU=
LL,I_SHARED|I_EDGE);
=09/* ... */
=09
=09rt_intr_enable(&amp;intr_desc);



=09rt_task_create(&amp;t1, "task1", 0, 1, 0);
=09rt_task_create(&amp;t2, "task2", 0, 1, 0);/* start the two tasks */
=09rt_task_create(&amp;t3, "task2", 0, 1, 0);/* start the two tasks */
=09rt_task_start(&amp;t1, &amp;taskOne, 0);
=09rt_task_start(&amp;t2, &amp;taskTwo, 0);
=09rt_task_start(&amp;t2, &amp;taskThree, 0);
}




 Every 500m gpio send an interrupt.
 The result like blow:
tt1=3Drt_timer_read();

global =3D =09tt3=3Dtt1-tt2;

Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................    =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755.                           =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Iam taskTwo global =3D 1610612755................                          =
      =20
Irunting 502230                                                            =
    =20
root@freescale /opt$ runting 499995                                        =
    =20
runting 500025                                                             =
    =20
runting 500115                                                             =
    =20
runting 500055                                                             =
    =20
runting 500025                                                             =
    =20
runting 500025                                                             =
    =20
runting 500010       =20
runting 500085                                                             =
    =20
runting 500010                                                             =
    =20
runting 500025                                                             =
    =20
runting 500055                                                             =
    =20
runting 500010                                                             =
    =20
runting 500055                                                             =
    =20
runting 499905                                                             =
    =20
runting 500460                                                             =
    =20
runting 500085                                                             =
    =20
runting 500070                                                             =
    =20
runting 500070                                                             =
    =20
runting 500010                                                             =
    =20
runting 500010                                                             =
    =20
runting 500085                                                             =
    =20
runting 500025                                                             =
    =20
runting 499980                                                             =
    =20
runting 500070                                                             =
    =20
runting 500040                                                             =
    =20
runting 500025                                                             =
    =20
runting 498735                                                             =
    =20
runting 500040                                                             =
    =20
runting 500025                                                             =
    =20
runting 500025                                                             =
    =20
runting 500220                                                             =
    =20
runting 499995                                                             =
    =20
runting 500010                                                             =
    =20
runting 500055                                                             =
    =20
runting 500010                                                             =
    =20
runting 500055                                                             =
    =20
runting 500025                                                             =
    =20
runting 500085                                                             =
    =20
runting 500025                                                             =
    =20
runting 500055                                                             =
    =20
runting 500025                                                             =
    =20
runting 500010                                                             =
    =20
runting 500100                                                             =
    =20
runting 500085                                                             =
    =20
runting 500010   =20

Then I do not know what should i do next?
=E5=9C=A8 2013-05-31 13:54:49=EF=BC=8C"=E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=
=E7=A8=8B=E5=B8=88" <ericvic@163.com> =E5=86=99=E9=81=93=EF=BC=9A
>ok =EF=BC=8Cthanks=EF=BC=8Ci have a try
>=E5=9C=A8 2013-05-31 13:32:14=EF=BC=8C"Gilles Chanteperdrix" <gilles.chant=
eperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>>On 05/31/2013 03:36 AM, =E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=E7=A8=8B=E5=
=B8=88 wrote:
>>
>>> The I-pipe path version is adeos-ipipe-2.6.35.9-arm-1.18-01.patch ,
>>> the kernal version is 2.6.35.9 ,i am so sorry for he details do not spe=
ak clearly
>>
>>
>>Hi,
>>
>>there is no need to send your answer three times either. GPIO irqs are
>>broken with this version of the I-pipe kernel. Please try updating to
>>the I-pipe core patch for Linux 3.4 or 3.5.
>>
>>Regards.
>>
>>--=20
>>                                                                Gilles.
>
>
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai



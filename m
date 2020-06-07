Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rtdm_task_init does not work with Xenomai 3
From: ayaida marwane <ayaida_marwane@yahoo.fr>
In-Reply-To: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
Date: Sun, 7 Jun 2020 22:33:29 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5BA411F-973C-4EDA-B87D-F323D28D3DEF@yahoo.fr>
References: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27.ref@yahoo.fr>
 <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marwane Ayaida <ayaida_marwane@yahoo.fr>
Cc: xenomai@xenomai.org

Hi,

Any suggestion about the request below?

Thanks!

BR,
Marwane.

> Le 2 juin 2020 =C3=A0 20:34, ayaida marwane via Xenomai =
<xenomai@xenomai.org> a =C3=A9crit :
>=20
> Dear all,
>=20
> I tried to have an example using rtdm_task_init with Xenomai 3.0.7. =
The example is tis one:
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>=20
> #include <rtdm/driver.h>
> static int periode_us =3D 1000;
> static int a, ret;
> module_param(periode_us, int, 0644);
>=20
> rtdm_task_t task;
>=20
> void task_ultrason(void *arg){
>   a=3D1;
>   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
> }
>=20
> int __init ultrason_init(void) {
>   a=3D0;
>   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
>   ret =3D rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 99, =
periode_us*1000);
>   if (ret) {
>        rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello =3D =
%d\n", THIS_MODULE->name, __FUNCTION__,a);
>   }
>   else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, hello =
=3D %d\n", THIS_MODULE->name, __FUNCTION__,a);
>   return 0;
> }
> void __exit ultrason_exit(void) {
>   a=3D2;
>   rtdm_task_destroy(&task);
>   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
>   }
>=20
> module_init(ultrason_init);
> module_exit(ultrason_exit);
> MODULE_LICENSE("GPL =C2=BB);
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>=20
> When I insert the module and remove it, I found in dmesg:
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>=20
> [ 5045.187448] test.ultrason_init() : hello =3D 0
> [ 5045.189495] test.ultrason_init() : success rtdm_task_init, hello =3D =
0
> [ 5049.631665] test.ultrason_exit() : hello =3D 2
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>=20
> The task_ultrason is never called.
>=20
> I read from =
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To=
_3 =
<https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_T=
o_3>, that rtdm_task_init() shall be called from secondary mode.
>=20
> Since Xenomai 3, rtdm_task_init() involves creating a regular kernel =
thread, which will be given real-time capabilities, such as running =
under the control of the Cobalt kernel. In order to invoke standard =
kernel services, rtdm_task_init() must be called from a regular Linux =
kernel context.
>=20
> So, how to adapt my example to call rtdm_task_init() from  from a =
regular Linux kernel context to make this example working?
>=20
> Thank you for your help.
>=20
> BR,
> Marwane.
>=20
>=20
>=20
>=20
>=20
>=20
>=20



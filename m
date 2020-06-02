From: ayaida marwane <ayaida_marwane@yahoo.fr>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: rtdm_task_init does not work with Xenomai 3
Message-Id: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
Date: Tue, 2 Jun 2020 20:34:35 +0200
References: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27.ref@yahoo.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I tried to have an example using rtdm_task_init with Xenomai 3.0.7. The =
example is tis one:

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=20

#include <rtdm/driver.h>
static int periode_us =3D 1000;
static int a, ret;
module_param(periode_us, int, 0644);

rtdm_task_t task;

void task_ultrason(void *arg){
   a=3D1;
   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
}

int __init ultrason_init(void) {
   a=3D0;
   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
   ret =3D rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 99, =
periode_us*1000);
   if (ret) {
        rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello =3D =
%d\n", THIS_MODULE->name, __FUNCTION__,a);
   }
   else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, hello =
=3D %d\n", THIS_MODULE->name, __FUNCTION__,a);
   return 0;
}
void __exit ultrason_exit(void) {
   a=3D2;
   rtdm_task_destroy(&task);
   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
   }

module_init(ultrason_init);
module_exit(ultrason_exit);
MODULE_LICENSE("GPL =C2=BB);

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=20

When I insert the module and remove it, I found in dmesg:

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=20

[ 5045.187448] test.ultrason_init() : hello =3D 0
[ 5045.189495] test.ultrason_init() : success rtdm_task_init, hello =3D =
0
[ 5049.631665] test.ultrason_exit() : hello =3D 2

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=20

The task_ultrason is never called.

I read from =
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To=
_3 =
<https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_T=
o_3>, that rtdm_task_init() shall be called from secondary mode.

Since Xenomai 3, rtdm_task_init() involves creating a regular kernel =
thread, which will be given real-time capabilities, such as running =
under the control of the Cobalt kernel. In order to invoke standard =
kernel services, rtdm_task_init() must be called from a regular Linux =
kernel context.

So, how to adapt my example to call rtdm_task_init() from  from a =
regular Linux kernel context to make this example working?

Thank you for your help.

BR,
Marwane.








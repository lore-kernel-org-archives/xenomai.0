From: ayaida marwane <ayaida_marwane@yahoo.fr>
Message-Id: <6CF6D216-15CD-4ABE-B85C-590975DE822D@yahoo.fr>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rtdm_task_init does not work with Xenomai 3
Date: Tue, 9 Jun 2020 11:25:18 +0200
In-Reply-To: <68aba520-be16-e25e-61ad-32a7061e43e1@xenomai.org>
References: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27.ref@yahoo.fr>
 <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
 <B5BA411F-973C-4EDA-B87D-F323D28D3DEF@yahoo.fr>
 <68aba520-be16-e25e-61ad-32a7061e43e1@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

> Le 8 juin 2020 =C3=A0 09:36, Philippe Gerum <rpm@xenomai.org> a =C3=A9cr=
it :
>=20
> On 6/7/20 10:33 PM, ayaida marwane via Xenomai wrote:
>> Hi,
>>=20
>> Any suggestion about the request below?
>>=20
>> Thanks!
>>=20
>> BR,
>> Marwane.
>>=20
>>> Le 2 juin 2020 =C3=A0 20:34, ayaida marwane via Xenomai =
<xenomai@xenomai.org> a =C3=A9crit :
>>>=20
>>> Dear all,
>>>=20
>>> I tried to have an example using rtdm_task_init with Xenomai 3.0.7. =
The example is tis one:
>>>=20
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>>>=20
>>> #include <rtdm/driver.h>
>>> static int periode_us =3D 1000;
>>> static int a, ret;
>>> module_param(periode_us, int, 0644);
>>>=20
>>> rtdm_task_t task;
>>>=20
>>> void task_ultrason(void *arg){
>>>  a=3D1;
>>>  rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", =
THIS_MODULE->name, __FUNCTION__,a);
>>> }
>>>=20
>>> int __init ultrason_init(void) {
>>>  a=3D0;
>>>  rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", =
THIS_MODULE->name, __FUNCTION__,a);
>>>  ret =3D rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 99, =
periode_us*1000);
>>>  if (ret) {
>>>       rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello =3D=
 %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>>  }
>>>  else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, =
hello =3D %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>>  return 0;
>>> }
>>> void __exit ultrason_exit(void) {
>>>  a=3D2;
>>>  rtdm_task_destroy(&task);
>>>  rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", =
THIS_MODULE->name, __FUNCTION__,a);
>>>  }
>>>=20
>>> module_init(ultrason_init);
>>> module_exit(ultrason_exit);
>>> MODULE_LICENSE("GPL =C2=BB);
>>>=20
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>>>=20
>>> When I insert the module and remove it, I found in dmesg:
>>>=20
>>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=20
>>>=20
>>> [ 5045.187448] test.ultrason_init() : hello =3D 0
>>> [ 5045.189495] test.ultrason_init() : success rtdm_task_init, hello =
=3D 0
>>> [ 5049.631665] test.ultrason_exit() : hello =3D 2
>=20
> This looks like a I bug fixed many moons ago in the printk support =
code for
> the pipeline. This issue caused printk() output sent from the head =
stage not
> to appear in the kernel log, a regression due to upstream changes =
which went
> unnoticed.
>=20
> You may want to update your I-pipe patch to the latest available in =
your
> kernel series to make sure the fix is there. If not, your rt task =
would indeed
> run shortly as requested by rtdm_task_init(), but the feedback would =
be
> spuriously elided.
>=20
> A trivial way to check this without ftracing: have task_ultrason() =
call
> rtdm_task_sleep(10000000000ULL) before exiting, then you would have 10 =
secs to
> manually check it was actually spawned by reading =
/proc/xenomai/sched/threads.
>=20
> --=20
> Philippe.

T tried your suggestion. I added rtdm_task_sleep(10000000000ULL) in =
task_ultrason():

#include <rtdm/driver.h>
static int periode_us =3D 1000;
static int a, ret;
module_param(periode_us, int, 0644);

rtdm_task_t task;

void task_ultrason(void *arg){
   a=3D1;
   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
   rtdm_task_sleep(10000000000ULL);
   }

int __init ultrason_init(void) {
   a=3D0;
   rtdm_printk(KERN_INFO "%s.%s() : hello =3D %d\n", THIS_MODULE->name, =
__FUNCTION__,a);
   ret =3D rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 30, =
periode_us*1000);
   if (ret) {
        rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello =3D =
%d\n", THIS_MODULE->name, __FUNCTION__,a);
   }
   else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, hello =
=3D %d\n", THIS_MODULE->name, __FUNCTION__,a);
  rtdm_task_set_period(&task, 0, periode_us*1000);
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
MODULE_LICENSE("GPL");

When, I load the module after its compilation, I obtained:

root@raspberrypi:/home/pi/tests# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
root@raspberrypi:/home/pi/tests# insmod test.ko
root@raspberrypi:/home/pi/tests# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
root@raspberrypi:/home/pi/tests# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
root@raspberrypi:/home/pi/tests# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
root@raspberrypi:/home/pi/tests# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  3  0      idle   core       -1   -             R          [ROOT/3]
root@raspberrypi:/home/pi/tests# rmmod test


So, the task_ultrason() is never scheduled. It seems very strange=E2=80=A6=


Do I something wrong?

I will try also to update my patch, but it will take some time. I prefer =
to make it working with this version of Xenomai (3.0.7).

BR,
Marwane.=20






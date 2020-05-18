From: ayaida marwane <ayaida_marwane@yahoo.fr>
Message-Id: <021AD4AA-F3B2-4B07-B237-B037C2C389D0@yahoo.fr>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: RTDM Printk do not work on rtdm_timer_handler_t
Date: Mon, 18 May 2020 12:58:24 +0200
In-Reply-To: <bbcae94e-9dbe-e95c-13f4-b67abee77cc6@siemens.com>
References: <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1.ref@yahoo.fr>
 <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1@yahoo.fr>
 <bbcae94e-9dbe-e95c-13f4-b67abee77cc6@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hi Jan,

> Le 18 mai 2020 =C3=A0 12:47, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>=20
> On 18.05.20 11:27, ayaida marwane via Xenomai wrote:
>> Dear all,
>> I have tried this code :
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94
>> #include <rtdm/driver.h>
>> static int periode_us =3D 1000;
>> module_param(periode_us, int, 0644);
>> static void timer_task(rtdm_timer_t *);
>> static rtdm_timer_t rtimer;
>> static int __init init_oscillateur (void)
>> {
>>         int err;
>>         rtdm_printk(KERN_INFO "%s.%s() : Initialisation\n", =
THIS_MODULE->name, __FUNCTION__);
>>         if ((err =3D rtdm_timer_init(& rtimer, timer_task, =
"Timer_Task")) !=3D 0) {
>>                 return err;
>>         }
>>         if ((err =3D rtdm_timer_start(& rtimer, periode_us*1000, =
periode_us*1000, RTDM_TIMERMODE_RELATIVE)) !=3D 0) {
>>                 rtdm_timer_destroy(& rtimer);
>>                 return err;
>>         }
>>         return 0;
>> }
>> static void __exit exit_oscillateur (void)
>> {
>>         rtdm_timer_stop(& rtimer);
>>         rtdm_timer_destroy(& rtimer);
>>         rtdm_printk(KERN_INFO "%s.%s() : Exit\n", THIS_MODULE->name, =
__FUNCTION__);
>> }
>> static void timer_task(rtdm_timer_t * unused)
>> {
>>         rtdm_printk(KERN_INFO "%s.%s() : Appel Timer\n", =
THIS_MODULE->name, __FUNCTION__);
>> }
>> module_init(init_oscillateur);
>> module_exit(exit_oscillateur);
>> MODULE_LICENSE("GPL");
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94
>> However, when I execute the code, we have only :
>> [ 6696.615556] oscillateur_gpio_rtdm.init_oscillateur() : =
Initialisation
>> [ 6705.148129] oscillateur_gpio_rtdm.exit_oscillateur() : Exit
>> So, why the rtdm_printk in the timer_task is never called?
>> Thanks for your help.
>> BR,
>> Marwane.
>=20
> No obvious reason why is should print or run. You can start analyzing =
by looking at stats in /proc/xenomai/timer, if yours is ticking.

Here are the print, it is well ticking:

root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    4994886/166104        39ms482us   -           [host-timer/0]
1    563735/95608          579ms478us  -           [host-timer/1]
2    2089494/195494        9ms477us    -           [host-timer/2]
3    459336/80299          9ms474us    -           [host-timer/3]
0    39549/39548           817us       1ms         Timer_Task
root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5000069/166391        28ms552us   -           [host-timer/0]
1    563799/95628          608ms547us  -           [host-timer/1]
2    2089896/195551        18ms546us   -           [host-timer/2]
3    459375/80325          8ms544us    -           [host-timer/3]
0    49840/49839           836us       1ms         Timer_Task
root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5004901/166688        33ms17us    -           [host-timer/0]
1    563851/95643          133ms9us    -           [host-timer/1]
2    2090205/195607        13ms12us    -           [host-timer/2]
3    459405/80342          3ms9us      -           [host-timer/3]
0    59755/59754           253us       1ms         Timer_Task
root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5008137/166872        13ms948us   -           [host-timer/0]
1    563895/95655          3ms945us    -           [host-timer/1]
2    2090576/195658        13ms942us   -           [host-timer/2]
3    459441/80356          4s293ms13u  -           [host-timer/3]
0    66294/66293           153us       1ms         Timer_Task
root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5010223/167216        2ms315us    -           [host-timer/0]
1    563982/95686          282ms308us  -           [host-timer/1]
2    2091762/195739        12ms309us   -           [host-timer/2]
3    463114/80415          3s692ms24u  -           [host-timer/3]
0    78326/78325           462us       1ms         Timer_Task

When I remove the module, it becomes:

root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5016232/168735        5ms353us    -           [host-timer/0]
1    564360/95814          5ms349us    -           [host-timer/1]
2    2096430/196245        15ms347us   -           [host-timer/2]
3    476687/80559          104ms93us   -           [host-timer/3]
root@raspberrypi:/tmp# cat /proc/xenomai/timer/coreclk=20
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    5016716/168863        22ms398us   -           [host-timer/0]
1    564402/95829          2ms394us    -           [host-timer/1]
2    2096700/196275        12ms391us   -           [host-timer/2]
3    477826/80569          4s289ms909  -           [host-timer/3]

So, I do not understand why it is not printing?

Thanks for your help Jan!

>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


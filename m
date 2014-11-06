From: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Date: Thu, 6 Nov 2014 15:24:08 +0000
Message-ID: <545B9297.2090003@cgglobal.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_task_sleep_until() miss release point?
Reply-To: alberto.ozalla@cgglobal.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

enclosed you will find two examples:

  *   rt_task_sleep_until() missing release point, and
  *   rt_task_sleep_until() working fine.

In the first example:

Current time: t1=3D4205571 ms - Calculated next release point: t2=3D 420557=
2 ms
Real release: t3=3D4205574 ms

Many Thanks
Alberto Ozalla

Simplest example that shows the issue:
________________________________
static RT_TASK Test_Task_descriptor;

static void Test_Task(void *arg)
{
    RTIME t1, t2;
    rt_task_set_mode(0, 0, NULL);

    while(1) {

        t1 =3D rt_timer_tsc();
        t2 =3D t1 + 24000;        // 24000 tsc =3D 1 ms

        cu_log(CU_LOG_ERR, "t1(%lld)-t2(%lld)", rt_timer_tsc2ns(t1), rt_tim=
er_tsc2ns(t2));
        rt_task_sleep_until(rt_timer_tsc2ns(t2));
        cu_log(CU_LOG_ERR, "t3(%lld)", rt_timer_tsc2ns(rt_timer_tsc()));
    }
}

void main(void)
{
    ...
    // Real-time function creation.
       if (int err =3D rt_task_create(&Test_Task_descriptor, "Test_Task", 0=
, 79, 0)) {
             cu_log(CU_LOG_ERR, "Error creating Test_Task (%d)", err);
         }

     // Real-time function started.
       if(rt_task_start(&Test_Task_descriptor, &Test_Task, NULL)) {
             cu_log(CU_LOG_ERR, "Error starting Test_Task");
       }
     ...
}

Log traces:

t1(4205571256580)-t2(4205572256580) ns
t3(4205574861288)
t1(4205575085163)-t2(4205576 085163)
t3(4205578686872)
t1(4205578899038)-t2(4205579 899038)
t3(4205582499538)
t1(4205582839455)-t2(4205583 839455)
t3(4205586444497)
t1(4205586669455)-t2(4205587 669455)
t3(4205590273872)
________________________________
Additional data:

Xenomai 2.6.4
Linux version 3.14.17 (gcc version 4.7.3 (GCC) )
#1 SMP 20<6>kernel: [    0.000000] CPU: ARMv7 Processor [413fc082] revision=
 2 (ARMv7), cr=3D10c5387d
2000/01/03,02:42:00  kern.info kernel: [    0.000000] CPU: PIPT / VIPT nona=
liasing data cache, VIPT aliasing instruction cache
2000/01/03,02:42:00  kern.info kernel: [    0.000000] Machine model: TI AM3=
35x BeagleBone
2000/01/03,02:42:00  kern.info kernel: [    0.000000] CPU: All CPU(s) start=
ed in SVC mode.
2000/01/03,02:42:00  kern.info kernel: [    0.000000] AM335X ES2.1 (sgx neo=
n )
________________________________
In the other hand, this example works fine:

static void Test_Task(void *arg)
{
    rt_task_set_mode(0, 0, NULL);

    RTIME t1, t2;

    while(1) {
        t1 =3D rt_timer_read();
        t2 =3D t1 + 1000000;        //  1 ms

        cu_log(CU_LOG_ERR, "t1(%lld)-t2(%lld)", t1, t2);
        rt_task_sleep_until(t2);
        cu_log(CU_LOG_ERR, "t3(%lld)", rt_timer_read());
    }
}

t1(564272 373824)-t2(564273 373824)
t3(564273 387783)
________________________________
Many Thanks
Alberto Ozalla

CG DISCLAIMER: This email contains confidential information. It is intended=
 exclusively for the addressees. If you are not an addressee, you must not =
store, transmit or disclose its contents. Instead please notify the sender =
immediately; and permanently delete this e-mail from your computer systems.=
 We have taken reasonable precautions to ensure that no viruses are present=
. However, you must check this email and the attachments, for viruses. We a=
ccept no liability whatsoever, for any detriment caused by any transmitted =
virus.

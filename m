From: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Date: Thu, 6 Nov 2014 16:46:08 +0000
Message-ID: <545BA5D0.7010907@cgglobal.com>
References: <545B9297.2090003@cgglobal.com> 
 <20141106153738.GC30908@sisyphus.hd.free.fr> 
 <545B994D.1080008@cgglobal.com> 
 <20141106155503.GD30908@sisyphus.hd.free.fr>
In-Reply-To: <20141106155503.GD30908@sisyphus.hd.free.fr>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
Reply-To: alberto.ozalla@cgglobal.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

These are the simplest examples:
There are no MSW for Test_Task.
The goal is to increment counter_ms each millisecond.

Given that:
1000000 nanoseconds =3D 24000 tsc.
1 tsc =3D 41 ns

RT_TASK Test_Task_descriptor;
volatile unsigned long long counter_ms;

void Test_Task(void *arg)
{
    rt_task_set_mode(0, 0, NULL);

    RTIME t1, t2;
    counter_ms =3D 0;

    while(1) {
        t1 =3D rt_timer_tsc();
        t2 =3D t1 + 24000;        // 24000 tsc =3D 1 ms
        rt_task_sleep_until(rt_timer_tsc2ns(t2));
        counter_ms++;
    }
}

void main ()
{
    // Real-time function creation.
    if (int err =3D rt_task_create(&Test_Task_descriptor, "Test_Task", 0, 7=
9, 0)) {
        cu_log(CU_LOG_ERR, "Error creating Test_Task (%d)", err);
    }

    // Real-time function started.
    if(rt_task_start(&Test_Task_descriptor, &Test_Task, NULL)) {
        cu_log(CU_LOG_ERR, "Error starting Test_Task");
    }

    while (1) {

            unsigned long long before =3D counter_ms;
            usleep(1000000);    // 1 second.
            printf( "Miliseconds =3D %llu", (counter_ms - before));
    }
}

Output of printf:

Miliseconds =3D 264>>>Fail . It should be 1000 ms.
Miliseconds =3D 263
...
________________________________
This example works fine:

void Test_Task(void *arg)
{
    rt_task_set_mode(0, 0, NULL);
    RTIME t1, t2;
    counter_ms =3D 0;

    while(1) {
         t1 =3D rt_timer_read();
         t2 =3D t1 + 1000000;        //  1 ms
        rt_task_sleep_until(t2);
        counter_ms++;
    }
}

Output of printf:

Miliseconds =3D 989
Miliseconds =3D 991
...
Many thanks.
Alberto

On 06/11/14 16:55, Gilles Chanteperdrix wrote:

On Thu, Nov 06, 2014 at 03:52:45PM +0000, ZIV-Alberto Ozalla Cantabrana wro=
te:


Hi all,

Sorry about missing references to function cu_log().
You can omit cu_log calls (It is like printf).



The problem is that printf will cause a switch to secondary mode,
which you do not want to happen. So, please rewrite your example
using functions from xenomai libraries, test it again, and see if
printf is not the problem.




--
Saludos,
Alberto Ozalla

CG DISCLAIMER: This email contains confidential information. It is intended=
 exclusively for the addressees. If you are not an addressee, you must not =
store, transmit or disclose its contents. Instead please notify the sender =
immediately; and permanently delete this e-mail from your computer systems.=
 We have taken reasonable precautions to ensure that no viruses are present=
. However, you must check this email and the attachments, for viruses. We a=
ccept no liability whatsoever, for any detriment caused by any transmitted =
virus.

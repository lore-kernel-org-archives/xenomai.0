Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Alexander Herzog <aherzog@tuebingen.mpg.de>
In-Reply-To: <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
Date: Thu, 7 Aug 2014 09:57:15 -0700
Message-Id: <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

I haven't replied to your email for a few months. I am sorry for that, =
we didn't have time to dig further into this problem. However, now we =
went back to the issue and installed Xenomai 2.6.3 with Linux kernel =
3.8.13 . Now, if we do not run 'watch -n .1 cat /proc/xeno/stat', the =
latency test is running just fine without significant latencies. =
However, the moment we run the watch command in parallel, things break =
down and the latency goes up. Is this an issue that other people see as =
well and is there a fix for it? Thanks for your help.

best,
Alex=20




> On 03/04/2014 08:55 PM, Alexander Herzog wrote:
> > Hi,
> >=20
> > We have some real-time issues with our xenomai machine running =
Ubuntu
> > 12.04 with kernel version 3.5.7 patched with Xenomai 2.6.2.1 .
>=20
> Hi,
>=20
> do you get the same issues with the "latency" test and with Xenomai
> 2.6.3? On what hardware do you observe this?
>=20
> Regards.
>=20
> --=20
>                                                                 =
Gilles.
>=20
>> Hi,
>>=20
>> We have some real-time issues with our xenomai machine running Ubuntu =
12.04 with kernel version 3.5.7 patched with Xenomai 2.6.2.1 . We run a =
simple program (see end of this email), where we shadow the main thread, =
then switch it into periodic mode and obtain the timestamp each time the =
process is released. One would expect that the time between two cycles =
should remain constant. This is roughly true, if we run the program. =
However, if we run the program and in parallel execute 'watch -n .1 cat =
/proc/xeno/stat' we see pretty high spikes. The same code runs on an =
older kernel+xenomai version (kernel 2.6.35.9 with xenomai 2.5.6 on =
Ubuntu 10.04) without spikes. I attached 3 plots. All of them show the =
duration between two consecutive cycles in blue. After the process is =
woken up it sleeps for a while and records the time it spent sleeping. =
This duration is plotted in green. You will also see spikes in sleep =
duration. The 3 plots are:
>>=20
>> 2_5_with_watch.png shows the execution on an older xenomai system =
while we ran 'watch -n .1 cat /proc/xeno/stat'=20
>> min cycle duration 989184.0 ns
>> max cycle duration 1010688.0 ns
>>=20
>> 2_6_with_watch.png shows the execution on our xenomai system while we =
ran 'watch -n .1 cat /proc/xeno/stat'=20
>> min cycle duration 400640.0 ns
>> max cycle duration 1911552.0 ns
>>=20
>> 2_6_no_watch.png shows the execution on our xenomai without running =
the watch command in parallel.=20
>> min cycle duration 989696.0 ns
>> max cycle duration 1010432.0 ns
>>=20
>> We appreciate any hint on what might be the cause for this or how we =
could further diagnose the problem.
>>=20
>> Thanks in advance,
>> Alex
>>=20
>> PS: Here is the test program:
>>=20
>> #include <native/task.h>
>> #include <native/timer.h>
>> #include <sys/mman.h>
>> #include <cstdio>
>>=20
>> #define LOG_SIZE 100000
>>=20
>> int main(int argc, char* argv[])
>> {
>>        long system_time[LOG_SIZE];
>>        long work_duration[LOG_SIZE];
>>        unsigned long overruns[LOG_SIZE];
>>=20
>>        mlockall(MCL_CURRENT | MCL_FUTURE);
>>=20
>>        rt_task_shadow(NULL, "periodic_thread", 50, 0);
>>        if(0 !=3D rt_task_set_periodic(NULL, TM_NOW, 0.001 * 1e9))
>>        {
>>                printf ("Could not make task periodic\n");
>>            return -1;
>>        }
>>        rt_task_wait_period(NULL);
>>=20
>>        for(int it=3D0; it<LOG_SIZE; ++it)
>>        {
>>          rt_task_wait_period(&(overruns[it]));
>>          system_time[it] =3D =
long(rt_timer_ticks2ns(rt_timer_read()));
>>=20
>>          // do something
>>          long work_start =3D =
long(rt_timer_ticks2ns(rt_timer_read()));
>>          rt_task_sleep(400000);
>>          work_duration[it] =3D =
long(rt_timer_ticks2ns(rt_timer_read())) - work_start;
>>        }
>>=20
>>        printf("writing log...\n");
>>        FILE *slog_file =3D fopen("periodic_task.log","w");
>>        for(int i=3D0; i<LOG_SIZE; ++i)
>>        {
>>          printf("writing log %d\n", i);
>>          fprintf(slog_file, "%ld ", system_time[i]);
>>          fprintf(slog_file, "%ld\n", work_duration[i]);
>>          fprintf(slog_file, "%lu\n", overruns[i]);
>>        }
>>        fclose(slog_file);
>>=20
>>        return 0;
>> }
>>=20
>=20


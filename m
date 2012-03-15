MIME-Version: 1.0
In-Reply-To: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
References: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
Date: Thu, 15 Mar 2012 20:49:37 +0100
Message-ID: <CAMJ=MEe1VkOMqUyAZ=X9ZHYweSAkjuBXnfVBR=sn-UD9sN_PYA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai-forge: round-robin scheduling in pSOS
	skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

On Thu, Mar 8, 2012 at 3:30 PM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
> Hello
>
> I'm are using the xenomai-forge pSOS skin (Mercury).
> My application is running on a P4040 (Freescale PPC with 4 cores).
> Some code snippets are put in this mail but the complete testcode is
> also attached.
>
> I have a test task that just consumes the CPU:
>
> int run_test =3D 1;
> static void perform_work(u_long counter,u_long b,u_long c,u_long d)
> {
> =A0int i;
> =A0while (run_test) {
> =A0 =A0for (i=3D0;i<100000;i++);
> =A0 =A0(*(unsigned long*)counter)++;
> =A0}
> =A0while (1) tm_wkafter(1000);
> }
>
> If I create 2 instances of this task with the T_SLICE option set:
>
> =A0 =A0t_create("WORK",10,0,0,0,&tid);
> =A0 =A0t_start(tid,T_TSLICE, perform_work, args);
>
>
> I see that only 1 task is consuming CPU.
>
> # taskset 1 ./roundrobin.exe &
> # =A0 =A00"000.543| [main] SCHED_RT priorities =3D> [1 .. 99]
> =A0 0"000.656| [main] SCHED_RT.99 reserved for IRQ emulation
> =A0 0"000.692| [main] SCHED_RT.98 reserved for scheduler-lock emulation
> 0 -> 6602
> 1 -> 0
>
> If I adapt the code so that I call in my init the threadobj_start_rr
> function, I see that the load is equally distributed over the 2
> threads:
>
> # taskset 1 ./roundrobin.exe &
> # =A0 =A00"000.557| [main] SCHED_RT priorities =3D> [1 .. 99]
> =A0 0"000.672| [main] SCHED_RT.99 reserved for IRQ emulation
> =A0 0"000.708| [main] SCHED_RT.98 reserved for scheduler-lock emulation
> 0 -> 3290
> 1 -> 3291
>
> Here are the questions:
> - why is the threadobj_start_rr function not called from the context
> of the init of the psos layer.
> - why is the roundrobin implemented in this way? If the tasks would be
> mapped on the SCHED_RR instead of the SCHED_FF the Linux scheduler
> would take care of this.
> On the other hand, once the threadobj_start_rr function is called from
> my init, and I create the tasks in T_NOTSLICE mode, the time-slicing
> is still done.
>
> Thanks.
>
> ---
> Ronny

Any comments on this?

---
Ronny


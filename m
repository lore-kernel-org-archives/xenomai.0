MIME-Version: 1.0
In-Reply-To: <4B460269.5050905@domain.hid>
References: <b88603c31001040212m7b20037fre7668fd46587881d@domain.hid>
	<1262617295.2220.30.camel@domain.hid>
	<1262618363.2220.33.camel@domain.hid>
	<b88603c31001040725v15b517c9rafd80a78298b5880@domain.hid>
	<4B460269.5050905@domain.hid>
Date: Thu, 7 Jan 2010 17:46:09 +0100
Message-ID: <b88603c31001070846q5794d09fyc1e7b7934a32f912@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Deadlock with test apps in 2.5.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Yes, this patch seems to solve the issue. It was reproducable within a
few seconds, but now I haven't seen the lock-up anymore after running
for half an hour.

Great job!

Thanks,
Henri.

On Thu, Jan 7, 2010 at 4:48 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Correct, that is the same behavior I get. When I then kill the latency
>> app, the other process is released and can go on.
>
> Ok. I may have found an issue. Here is a patch, could you try it?
>
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index 22bac6f..5de5227 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -174,6 +174,29 @@ static inline void set_switch_lock_owner(struct task=
_struct *p)
>
> =A0#define rpi_p(t) =A0 =A0 =A0 ((t)->rpi !=3D NULL)
>
> +static inline struct xnthread *rpi_next(struct xnsched *sched)
> +{
> + =A0 =A0 =A0 struct xnthread *thread;
> + =A0 =A0 =A0 spl_t s;
> +
> + =A0 =A0 =A0 thread =3D xnsched_peek_rpi(sched);
> + =A0 =A0 =A0 while (thread &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0xnthread_user_task(thread)->state !=3D TASK_=
RUNNING &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0!xnthread_test_info(thread, XNATOMIC)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnsched_pop_rpi(thread);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thread->rpi =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnlock_put_irqrestore(&sched->rpilock, s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do NOT nest the rpilock and nklock locks=
. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnlock_get_irqsave(&nklock, s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnsched_suspend_rpi(thread);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnlock_put_irqrestore(&nklock, s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnlock_get_irqsave(&sched->rpilock, s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thread =3D xnsched_peek_rpi(sched);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return thread;
> +}
> +
> =A0static void rpi_push(struct xnsched *sched, struct xnthread *thread)
> =A0{
> =A0 =A0 =A0 =A0struct xnsched_class *sched_class;
> @@ -236,7 +259,7 @@ static void rpi_pop(struct xnthread *thread)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 top =3D xnsched_peek_rpi(sched);
> + =A0 =A0 =A0 top =3D rpi_next(sched);
> =A0 =A0 =A0 =A0if (likely(top =3D=3D NULL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prio =3D XNSCHED_IDLE_PRIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sched_class =3D &xnsched_class_idle;
> @@ -310,7 +333,7 @@ static void rpi_clear_remote(struct xnthread *thread)
> =A0 =A0 =A0 =A0xnsched_pop_rpi(thread);
> =A0 =A0 =A0 =A0thread->rpi =3D NULL;
>
> - =A0 =A0 =A0 if (xnsched_peek_rpi(rpi) =3D=3D NULL)
> + =A0 =A0 =A0 if (rpi_next(rpi) =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rcpu =3D xnsched_cpu(rpi);
>
> =A0 =A0 =A0 =A0xnlock_put_irqrestore(&rpi->rpilock, s);
> @@ -407,7 +430,7 @@ static inline void rpi_switch(struct task_struct *nex=
t_task)
> =A0 =A0 =A0 =A0 =A0 =A0xnthread_test_state(next, XNRPIOFF)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xnlock_get_irqsave(&sched->rpilock, s);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 top =3D xnsched_peek_rpi(sched);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 top =3D rpi_next(sched);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (top) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newprio =3D top->cprio;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newclass =3D top->sched_cl=
ass;
> @@ -495,7 +518,7 @@ void xnshadow_rpi_check(void)
> =A0 =A0 =A0 =A0struct xnthread *top;
>
> =A0 =A0 =A0 =A0xnlock_get(&sched->rpilock);
> - =A0 =A0 =A0 top =3D xnsched_peek_rpi(sched);
> + =A0 =A0 =A0 top =3D rpi_next(sched);
> =A0 =A0 =A0 =A0xnlock_put(&sched->rpilock);
>
> =A0 =A0 =A0 =A0if (top =3D=3D NULL && xnsched_root_class(sched) !=3D &xns=
ched_class_idle)
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>


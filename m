Date: Tue, 10 Dec 2019 20:31:05 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <316849456.112635.1576006265616.JavaMail.zimbra@nod.at>
In-Reply-To: <4298ac73-340f-5699-7176-ef48b5ab2294@xenomai.org>
References: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
 <CAFLxGvz9X3qtz-tK6egDLuNn2OB6iYuy__-th=61mAbHynV+qg@mail.gmail.com>
 <6858a3b5-adbc-c65f-c11c-92297d4dd8f7@siemens.com>
 <2008645939.112092.1575975265668.JavaMail.zimbra@nod.at>
 <45cda878-fa53-c1b2-881b-06d52e66a32a@siemens.com>
 <4298ac73-340f-5699-7176-ef48b5ab2294@xenomai.org>
Subject: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
> An: "Jan Kiszka" <jan.kiszka@siemens.com>, "richard" <richard@nod.at>
> CC: "Richard Weinberger" <richard.weinberger@gmail.com>, "Michael Nazzare=
no Trimarchi" <michael@amarulasolutions.com>,
> "xenomai" <xenomai@xenomai.org>
> Gesendet: Dienstag, 10. Dezember 2019 19:03:22
> Betreff: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xen=
omai)

> On 12/10/19 2:08 PM, Jan Kiszka wrote:
>> On 10.12.19 11:54, Richard Weinberger wrote:
>>> ----- Urspr=C3=BCngliche Mail -----
>>>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>>> Do you see the same issue with ipipe-core-4.19.82-arm-6 (and Xenomai 3=
.1)?
>>>
>>> Since my board does not boot with 4.19, I cannot tell. Still had no tim=
e
>>> to figure what is going on.
>>>
>>> Is this a known issue with a fix in newer ipipe releases?
>>=20
>> Can't tell for ARM - Philippe?
>>=20
>=20
> I-pipe 4.14 was the first version to officially support PROVE_LOCKING
> for arm and arm64. I did a quick check with 4.14.110 over i.MX6QP, and
> got no issue running switchtest.
>=20
> On the other hand, kprobe support has not been considered so far (not
> even checked here). Since kprobing affects fault and IRQ handling, this
> may have something to do with such splat.

It definitely only triggers when a kprobe is attached.
Just managed to boot ipipe-core-4.19.82-arm-6 plus Xenomai 3.1, here lockde=
p
does *not* complain.

Since I cannot immediately upgrade to 4.19, is the lockdep warning a false =
positive?
If kprobes don't work on 4.14 I have kind of a problem...

If you want to try yourself, the following simple module triggers the issue=
 instantly
on 4.14.

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/tracepoint.h>
#include <trace/events/sched.h>

static void sched_switch_probe(void *data, bool preempt,
                               struct task_struct *prev,
                               struct task_struct *next)
{
        /* nop */
}

static void cobalt_switch_context_probe(void *data, struct xnthread *prev,
                                        struct xnthread *next)
{
        /* nop */
}

#define PROBE_TARGET(name) {__stringify(name), name##_probe, NULL, 0}
static struct tp_events {
        const char *name;
        void (*probe_fn);
        struct tracepoint *tp;
        int probed;
} tp_events[] =3D {
        PROBE_TARGET(sched_switch),
        PROBE_TARGET(cobalt_switch_context),
};

static void tracepoint_add(struct tracepoint *tp, void *priv)
{
        int i, err;

        for (i =3D 0; i < ARRAY_SIZE(tp_events); i++) {
                if (strcmp(tp->name, tp_events[i].name) =3D=3D 0) {
                        err =3D tracepoint_probe_register(tp, tp_events[i].=
probe_fn, NULL);
                        if (err) {
                                pr_err("Unable to register probe %s: %i\n",=
 tp->name, err);
                        } else {
                                tp_events[i].tp =3D tp;
                                tp_events[i].probed =3D 1;
                                pr_info("Probed %s\n", tp->name);
                        }
                }
        }
}

static int __init probemod_init(void)
{
        for_each_kernel_tracepoint(tracepoint_add, NULL);

        return 0;
}

static void __exit probemod_exit(void)
{
        int i;

        for (i =3D 0; i < ARRAY_SIZE(tp_events); i++)
                if (tp_events[i].probed)
                        tracepoint_probe_unregister(tp_events[i].tp, tp_eve=
nts[i].probe_fn, NULL);
}

module_init(probemod_init);
module_exit(probemod_exit);
MODULE_LICENSE("GPL");

Thanks,
//richard


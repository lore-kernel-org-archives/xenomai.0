Message-ID: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
Date: Wed, 12 Apr 2006 11:38:55 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-core] [REQUEST] eliminate the rthal_critical_enter/exit()
	from rthal_irq_request()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

Hi,

the following question/suggestion :

it could be good to eliminate the use of rthal_critical_enter/exit()
from rthal_irq_request() if it's not
strictly necessary.


the proposal :

int rthal_irq_request (unsigned irq,
=09=09       rthal_irq_handler_t handler,
=09=09       rthal_irq_ackfn_t ackfn,
=09=09       void *cookie)
{
-    unsigned long flags;
    int err =3D 0;

    if (handler =3D=3D NULL || irq >=3D IPIPE_NR_IRQS)
=09return -EINVAL;

-    flags =3D rthal_critical_enter(NULL);
-
-    if (rthal_irq_handler(&rthal_domain, irq) !=3D NULL)
-=09{
-=09err =3D -EBUSY;
-=09goto unlock_and_exit;
-=09}
-
    err =3D rthal_virtualize_irq(&rthal_domain,
=09=09=09       irq,
=09=09=09       handler,
=09=09=09       cookie,
=09=09=09       ackfn,
-=09=09=09       IPIPE_DYNAMIC_MASK);
+=09=09=09=09IPIPE_DYNAMIC_MASK|IPIPE_EXCLUSIVE_MASK);

- unlock_and_exit:
-
-    rthal_critical_exit(flags);
-
    return err;
}

IPIPE_EXCLUSIVE_MASK causes a -EBUZY error to be returned by
ipipe_virtualize_irq() when
handler !=3D NULL and the current ipd->irqs[irq].handler !=3D NULL.

(IPIPE_EXCLUSIVE_MASK is actually not used at the moment anywere,
though ipipe_catch_event() is mentioned in comments).

Another variant :

ipipe_virtualize_irq() should always return -EBUZY when handler !=3D
NULL and the current ipd->irqs[irq].handler !=3D NULL,
not taking into account the IPIPE_EXCLUSIVE_FLAG.

should work if :

o  all the ipipe_domain structs are "zeroed" upon initialization (ok,
in case of static or global);

o  ipipe_virtualize_irq(..., handler=3DNULL,...) is always called
between possible consecutive ipipe_virtualize_irq(..., handler!=3DNULL,
...) calls.

But, yep, this way we enforce a policy for ipipe_virtualize_irq() so
that the use of IPIPE_EXCLUSIVE_FLAG is likely better.
esp. for the nucleus where every rthal_irq_request() has a conforming
rthal_irq_release() call.


Why do I want to eliminate it?

o  any function that make use of critical_enter/exit() must not be
called when a lock (e.g. "nklock") is held.

    ok, xnintr_attach() was always the case and it's used properly
e.g. in native::rt_intr_create().

    but xnintr_detach() is now the case too (heh.. I have overlooked
it in the first instance) because
    xnintr_shirq_detach() is synchronized wrt xnintr_shirq_attach()
using critical_enter/exit(). This is
    only because xnintr_shirq_attach() make use of rthal_irq_request()
---> rthal_critical_enter/exit(), hence
    the nklock can't be used in xnintr_shirq_*.

    Yep, another approach is to enforce the policy that both
xnintr_attach() and xnintr_detach() must never be
    called when the nklock is held (say, rt_intr_delete() should be
rewritten)...

    but I guess, the better solution is to eliminate the
critical_enter/exit() from rthal_irq_request().

o  there is no need to use cirtical_enter/exit() in xnintr_shirq_*
anymore, the nklock can be used instead.


this would solve one synch. problem in xnintr_* code, though there is
yet another and more complex one I'm banging my head on now :o)

--
Best regards,
Dmitry Adamushko


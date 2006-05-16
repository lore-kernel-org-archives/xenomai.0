Message-ID: <4469E8C7.6060909@domain.hid>
Date: Tue, 16 May 2006 16:59:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait non-realtime alternative
References: 200605161221.11119@domain.hid>
	<200605161221.11119@domain.hid>	<4469B31E.60506@domain.hid>
	<200605161633.15928@domain.hid>
In-Reply-To: <200605161633.15928@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB04B05555BACD818D268F62"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB04B05555BACD818D268F62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> I sense, that there could be a problem. the rtdm_nrtsig_handler_t handl=
er have only one argument (rtdm_nrtsig_t *). But I need to get a pointer =
to the device and/or the event which has happended and needs to be forwar=
ded to tha waiter.

Yes, the nrtsig interface is a bit unhandy in this regard.

Recent restructuring of the Ipipe patch enabled cookie support also for
rtdm_nrtsig_t, but I refrained from extending the signal handler so far
as this would break existing drivers. Well, as the whole rtdm_nrtsig
interface is inline anyway, adding rtdm_nrtsig_init_ex and
rtdm_nrtsig_handler_ex_t might be a cheap option. You could try this
(untested!):

typedef void (*rtdm_nrtsig_handler_ex_t)(rtdm_nrtsig_t nrt_sig,
                                         void *arg);

static inline int rtdm_nrtsig_init_ex(rtdm_nrtsig_t *nrt_sig,
                                      rtdm_nrtsig_handler_ex_t handler,
                                      void *arg)
{
    *nrt_sig =3D rthal_alloc_virq();

    if (*nrt_sig =3D=3D 0)
        return -EAGAIN;

    rthal_virtualize_irq(rthal_root_domain, *nrt_sig,
                         (rthal_irq_handler_t)handler, arg, NULL,
                         IPIPE_HANDLE_MASK);
    return 0;
}

Hmm, really simple, I should commit this...

> I hope there is a possibility to search all my devices (usualy one :-))=
 if the argument belongs to it, and then clear all pending "events" and c=
all wake_up for appropriate wait queues.
> But it's not as simple as I wanted :-(, I hoped that I can avoid the wa=
iting queues etc..
> Anyway thanks for help. I didn't know, that I can't use wake_up from RT=
 interrupt handler.

You may want to wait a bit, I'm currently cooking something as I noticed
that we could also gain some benefit from such "dual-use" rtdm_event.
Our middleware's communication service (RTDM-based) currently requires
RT-receivers, but non-RT is on our which list for quite some time as well=
=2E

Jan


--------------enigCB04B05555BACD818D268F62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaejHniDOoMHTA+kRAs0tAJ0a9Yi2eYBnXzpY+4SwmhKx18NgUwCfYc0i
8BunHuOg7kTQ3rL9NRbqTsM=
=/cMu
-----END PGP SIGNATURE-----

--------------enigCB04B05555BACD818D268F62--


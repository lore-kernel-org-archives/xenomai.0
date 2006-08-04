Message-ID: <44D36389.3030706@domain.hid>
Date: Fri, 04 Aug 2006 17:11:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44CF6EB1.1010808@domain.hid>
In-Reply-To: <44CF6EB1.1010808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D129375CF306F7E1A5C06A9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D129375CF306F7E1A5C06A9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

Wolfgang Grandegger wrote:
> Hello,
>=20
> at "ftp://ftp.denx.de/pub/xenomai/rtcan" you can find a first version o=
f
> RTCAN, an Open Source hard real-time protocol stack for CAN devices
> based on BSD sockets. It is based on the SJA1000 socket-based CAN drive=
r
> for RTDM by Sebastian Smolorz (see CREDITS file).

I started a review of the patch, and here are some first results. A
deeper look into critical paths is pending. But given that your
driver(s) already proved to work fine for us here and for your own
scenarios, only very sneaking issues can persist - if at all. :)

- AF_CAN is still set to 30 which meanwhile became TIPC. The Socket-CAN
project moved to 29 now. However, this could become a nice race until
Socket-CAN is upstream and reserved a final ID. How to cope with this?
We just had some fun here after moving our AF_TIMS from 0 to 27,
breaking many installation on our robots due to the ABI change. Should
we better move the ID beyond AF_MAX for now? Also a question for the
socketcan-core list...

- Out-commented debug messages: If they can be useful for driver
development / hardware testing, I would say make them selectable via
some CONFIG-switch. The rest should be removed.

- rtcan_mscan_mode_stop() contains some #if 1-#else-#endif block. What
are the alternatives here? Is it an open issue or just a pending cleanup?=


- rtcan_mscan_init_one() contains a #ifdef FIXME. What needs to be
fixed? Comments for non-obvious pending issues would be helpful.

- Can rtcan_mscan_exit() be tagged with __exit?

- Is rtcan_mscan_proc_regs() a kind of debug option or useful for normal
operation as well? If it's the former, we may bundle it with the debug
print CONFIG-switch.

- Private data alignment in rtcan_dev_alloc(): you tapped on something
that looks ugly in RTnet as well. We copied this from Linux which still
does magic 32-byte alignment (encapsulated by NETDEV_ALIGN today). But
it also uses a smarter priv lookup now:

#define NETDEV_ALIGN            32
#define NETDEV_ALIGN_CONST      (NETDEV_ALIGN - 1)

static inline void *netdev_priv(struct net_device *dev)
{
        return (char *)dev + ((sizeof(struct net_device)
                                        + NETDEV_ALIGN_CONST)
                                & ~NETDEV_ALIGN_CONST);
}

Maybe something that should be adopted as well (for both stacks).
Nothing critical though.

- rtcan_dev_unregister() looks racy: down(&rtcan_devices_nrt_lock) comes
after the device state check. Is this ok?

- EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL: For me this makes no practical
difference anymore (kernel modules, specifically drivers must be GPL, no
matter what kind of symbols they use). Anyway, shouldn't we better go
the kernel path and introduce new APIs under _GPL? Just takes a wrapper
for 2.4 I guess.

- struct rtcan_device: what the heck are max_brp and max_sjw
(comments...)? This isn't something generic, right? That's why "FIXME" I
guess.

- LIST_POISON1 and some other stuff in rtcan_internal.h should
definitely be moved to the nucleus's wrapper. Nothing critical, just a
to-do. Likely the whole header will be obsolete in the end.

- [This is a note for me] RTCAN_ASSERT: Looks like we should introduce
RTDM_ASSERT() for this, maybe accepting some driver subsystem ID to
control this separately from the rest of Xenomai.

- RTCAN_PROC_... requires some thoughts: Generalise it? Some users
(haven't checked RTCAN for this, but RTnet has some) should better be
converted to seq_operations. And the rest could benefit from a generic
interface here. Uncritical for now.

- rtcan_dev_get_state_name(): Mm, having some array lookup for the name
here may shorten things.

- rtcan_read_proc_info: Should be done as in rtcan_mscan_proc_regs. Even
better: By increasing the buffer block in RTCAN_PROC_PRINT_VARS() you
could combine several PROC_PRINTs to a single one.

- rtcan_raw_remove_filter(): "if (sock->flistlen < 0)", a real check or
rather an internal ASSERT?

- struct rtcan_rb_frame differs from struct can_frame in the type of
can_dlc. The VW guys find __u8 for this nicer than a natural unsigned
int, but I stopped arguing on this. If we follow or not, it should be
consistent.

- rtcan_socket_context(): container_of?

- [Another note for me] module_param_array vs. MODULE_PARM-array: there
is some not that bad wrapper in RTnet now. I should push it to Xenomai
to simplify such blocks.

- Well known issue: the RTCAN name. This should definitely get resolved
before we merge. Any feedback already?

- Low prio (as long as my own code doesn't follow this ;)): Linux coding
style.


No guarantee that I found every critical point (most of the stuff above
is nitpicking anyway). I will try to repeat this more in details when
time permits. Hope my comments help nevertheless.

Jan


--------------enig2D129375CF306F7E1A5C06A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE02OJniDOoMHTA+kRAo+OAJ0UutoQFjxGM2sDn5TqvCXtT5xPJgCfSuxU
W0x5fZuLXJspoEaVoZUjChA=
=o15G
-----END PGP SIGNATURE-----

--------------enig2D129375CF306F7E1A5C06A9--


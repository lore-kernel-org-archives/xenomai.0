Message-ID: <43D527AA.8020105@domain.hid>
Date: Mon, 23 Jan 2006 19:59:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0601180617v38c990f0w@domain.hid>	
	<43D41364.6000300@domain.hid>
	<b647ffbd0601230841o51fbc5d2o@domain.hid>
In-Reply-To: <b647ffbd0601230841o51fbc5d2o@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig387FB402A73C83FF85097C52"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] Shared irqs v.5
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig387FB402A73C83FF85097C52
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 23/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>>> Hello Jan,
>>>
>>> as I promised earlier today, here is the patch.
>> I finally had a look at your patch (not yet a try), and it looks reall=
y
>> nice and light-weight.
>=20
>=20
> I have another version here at hand. The only difference is that
> xnintr_irq_handler() handles all interrupts and destinguished the timer=

> interrupt via "irq =3D=3D XNARCH_TIMER_IRQ" to handle it appropriately.=
 This
> way, the i-cache is, hopefully, used a bit more effectively. But it doe=
sn't
> make a big difference in other parts of code so you may start testing w=
ith
> the one I posted earlier.
>=20

I see: hunting the microsecond. ;)

>=20
> Now I only have two topics on my wish list:
> o Handling of edge-triggered IRQs (ISA-cards...). As I tried to explain=
,
>>   in this case we have to run the IRQ handler list as long as the full=

>>   list completed without any handler reporting XN_ISR_ENABLE back. The=
n
>>   and only then we are safe to not stall the IRQ line. See e.g.
>>   serial8250_interrupt() in linux/drivers/serial/8250.c for a per-driv=
er
>>   solution and [1] for some discussion on sharing IRQs (be warned, it'=
s
>>   from the evil side ;) ).
>=20
>=20
> Ok. e.g. we may introduce another flag to handle such a special case.
> Something along XN_ISR_EDGETIRQ and maybe a separate
> xnintr_etshirq_handler() (xnintr_attach() will set it up properly) so t=
o
> avoid interfering with another code. No big overhead I guess.
> serial8250_interrupt() defines a maximum number of iterations so we sho=
uld
> do the same (?) to avoid brain-damaged cases.

Might be useful for post-mortem analysis - most real-time system will
likely already have caused more or less severe damage after an IRQ
handler looped for 256 times or so. Anyway, if you are able to read some
information about this later on your console, it is better than not
knowing at all why your drilling machine just created an extra-deep hole.=


>=20
>   On our systems we already have two of those use-cases: the xeno_16550=
A
>>   handling up to 4 devices on the same IRQ on an ISA card (I don't wan=
t
>>   to know what worst-case latency can be caused here...) and our
>>   SJA-1000 CAN driver for PC/104 ISA card with 2 controllers on the sa=
me
>>   interrupt line. So a common solution would reduce the code size and
>>   potential bug sources.
>>
>> o Store and display (/proc) the driver name(s) registered on an IRQ li=
ne
>>   somewhere (ipipe?). This is just a nice-to-have. I introduced the RT=
DM
>>   API with the required argument in place, would be great if we can us=
e
>>   this some day.
>=20
>=20
> Yes, the proper /proc extension should be avalable. Actually, the "nati=
ve"
> skin can't be extended to support the shared interrupts only by adding =
a new
> flag. The "problem" is the way the /proc/xenomai/registry/interrupts is=

> implemented there (and I assume any other skin follows the same way). T=
he
> rt_registry object is created per each RT_INTR structure and, hence, pe=
r
> each xnintr_t.
>=20
> I'd see the following scheme :
>=20
> either
>=20
> /proc/xenomai/interrupts lists all interrupts objects registered on the=

> nucleus layer (xnintr_t should have a "name" field).
>=20
> IRQN      drivers
>=20
> 3              driver1
> ...
> 5              driver2, driver3
>=20
> and the skin presents per-object information as
>=20
> ll /proc/xenomai/registry/interrupts
>=20
> driver1
> driver2
> driver3
>=20
> each of those files contains the same information as now.
>=20
> To achieve this,
>=20
> 1) xnintr_t should be extended with a "name" field;
>=20
> 2) rt_intr_create() should contain a "name" argument and not use
> auto-generation (as "irqN") any more.
>=20
> or
>=20
> ll /proc/xenomai/registry/interrupts
>=20
> 3
> 5
>=20
> Those are directories and e.g.
>=20
> ll /proc/xenomai/registry/interrupts/5
>=20
> driver2
> driver3
>=20
> Those are "files" and contain the same information as now.
>=20
> This is harder to implement since the registry interface should be exte=
nded
> (for each skin).

Isn't just the native skin using this registry? Anyway, as the preferred
way of registering IRQ handlers should be via RTDM, and RTDM does not
use the registry, go for the simplest solution. /proc/xenomai/interrupts
is more important in my eyes.

>=20
>=20
>> ...
>=20
>> Jan
>>
>>
>> PS: Still at home?
>=20
>=20
> Yes. This week I'm going to Belgium to attend a few meeting with some
> customers of my potential employer. So my next step for the nearest fut=
ure
> will be finally determined there :)

Best wishes! Just avoid too much extra work, here is already enough to
do. ;)

>=20
>=20
> How many degrees Centigrade? I guess our current -9=1B$B!k=1B(BC
>> here in Hannover must appear ridiculous, almost subtropical warm to yo=
u.
>> ;)
>=20
>=20
> Hey, I'm not from Syberia :o) This is a kind of common delusion I guess=
 as
> the whole former USSR is assotiated with cold winters, bears, eak.. KGB=
 etc.
> :o)

"Former"? Did I missed something? :)

>=20
> from wikipedia.com (about Belarus) :
>=20
> "The climate <http://en.wikipedia.org/wiki/Climate> ranges from harsh
> winters <http://en.wikipedia.org/wiki/Winter> (average January temperat=
ures
> are in the range =1B$B!]=1B(B8 =1B$B!k=1B(BC to =1B$B!]=1B(B2 =1B$B!k=1B=
(BC) to cool and moist
> summers<http://en.wikipedia.org/wiki/Summer>(average temperature 15 =1B=
$B!k=1B(BC
> to 20 =1B$B!k=1B(BC)."
>=20
> Actually, last days it was very cooooold - even about -30C. This happen=
s
> from time to time but very rare (once in a few years or so) and it's no=
t
> considered as something normal here. e.g. schools were closed a few las=
t
> days when the temperature was below -25. Actually, the weather is getti=
ng
> crazy last years and not only here :)
>=20
> [1] http://www.microsoft.com/whdc/system/sysperf/apic.mspx
>>
>>
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20

Jan


--------------enig387FB402A73C83FF85097C52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1SeqniDOoMHTA+kRAn8XAJ98PTEK14ztQj4P8grH3O++oZ11MwCfW7kg
IRAumWcopbR8FE0PslQguEU=
=NU/L
-----END PGP SIGNATURE-----

--------------enig387FB402A73C83FF85097C52--


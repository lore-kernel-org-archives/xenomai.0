Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <516A4497.9010801@xenomai.org>
Date: Sun, 14 Apr 2013 10:42:14 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <304F7A7E-67B1-4499-9DF3-5BA061FB127B@mah.priv.at>
References: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
	<516A4497.9010801@xenomai.org>
Subject: Re: [Xenomai] kconfig CONFIG_XENO_OPT_TIMING_PERIODIC=y/n
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

sorry I should have mentioned I fixed this by removing the code - =
problematic behaviour vanished.=20

this was a mystification and I think a programming error on my behalf - =
that ticket can be closed as 'user error'

thanks!

Michael

Am 14.04.2013 um 07:54 schrieb Gilles Chanteperdrix:

> On 01/29/2013 01:54 PM, Michael Haberler wrote:
>=20
>> I'm testing linuxcnc with John's 3.5.7 - 2.6.2.1 kernel and found an
>> issue with the deprecated linuxcnc xenomai-kernel threads version
>> (the userland threads version is fine; both using native skin). I
>> traced that back to rt_timer_ticks2ns(30000) returning zero.
>=20
>=20
> Hi Michael,
>=20
> I am unable to reproduce this issue. I have written the following=20
> kernel code:
>=20
> #include <native/timer.h>
>=20
> int init(void)
> {
> 	rt_timer_set_mode(0);
> 	xnprintf("mode aperiodic, ticks2ns: %Lu\n", =
rt_timer_ticks2ns(30000));
> 	rt_timer_set_mode(1000000);
> 	xnprintf("mode periodic, ticks2ns: %Lu\n", =
rt_timer_ticks2ns(30000));
> 		=09
> 	return 0;
> }
>=20
> module_init(init);
> MODULE_LICENSE("GPL");
>=20
> And I get:
> [   17.366373] Xenomai: mode 0, ticks2ns: 30000                        =
           =20
> [   17.370918] Xenomai: mode periodic, ticks2ns: 30000000000           =
           =20
>=20
> Which is the expected behaviour.
>=20
> Could you send us a test case allowing to reproduce the issue you=20
> encountered ?
>=20
>=20
> --=20
>                                                                Gilles.



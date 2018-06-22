From: Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 22 Jun 2018 07:21:25 +0000
Message-ID: <20180622072124.k3t6hw3myeijdvv2@fsr-ub1664-175>
References: <20180622071440.2of2edqeswqbomqa@fsr-ub1664-175>
 <fa6473c8-5762-ecf7-2f4a-9443694cd1d5@xenomai.org>
In-Reply-To: <fa6473c8-5762-ecf7-2f4a-9443694cd1d5@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A311133B7971154B8DFC968BC869B8A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] LOCKDEP warning due to ipipe generic implementation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Jun 22, 2018 at 09:16:15AM +0200, Philippe Gerum wrote:
> On 06/22/2018 09:14 AM, Abel Vesa wrote:
> > I'm just curious if anyone has seen this LOCKDEP warning before.
> >=20
> >>From a quick look it seems to be something that has to do with the gene=
ric ipipe.
> > More exactly the fact that handle_IRQ gets called outside the hardirq c=
ontext and
> > LOCKDEP doens't understand the fact that this is how ipipe works. I wou=
ld guess either
> > the LOCKDEP config should depend on !IPIPE or the ipipe should have a s=
pecific case
> > the in LOCKDEP implementation so that this warning doesn't shown since =
it will never
> > happen when IPIPE is enabled.
> >=20
> > I haven't looked too far into this and I might be missing stuff.
>=20
> LOCKDEP is not support on I-pipe/arm.

Right. But it seems LOCKDEP_SUPPORT is default y in the arch/arm/Kconfig.

I think it should be something like this then:

config LOCKDEP_SUPPORT
        bool
+	depends on !IPIPE
        default y

>=20
> --=20
> Philippe.

-- =


From: Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 22 Jun 2018 07:34:40 +0000
Message-ID: <20180622073439.ei634o7a6jcvnmmd@fsr-ub1664-175>
References: <20180622071440.2of2edqeswqbomqa@fsr-ub1664-175>
 <fa6473c8-5762-ecf7-2f4a-9443694cd1d5@xenomai.org>
 <20180622072124.k3t6hw3myeijdvv2@fsr-ub1664-175>
 <2a55befc-4659-8831-10ef-5161d2cf3459@xenomai.org>
In-Reply-To: <2a55befc-4659-8831-10ef-5161d2cf3459@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2971610B09108D4E9FEE1D46BC0ACCDB@eurprd04.prod.outlook.com>
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

On Fri, Jun 22, 2018 at 09:32:41AM +0200, Philippe Gerum wrote:
> On 06/22/2018 09:21 AM, Abel Vesa wrote:
> > On Fri, Jun 22, 2018 at 09:16:15AM +0200, Philippe Gerum wrote:
> >> On 06/22/2018 09:14 AM, Abel Vesa wrote:
> >>> I'm just curious if anyone has seen this LOCKDEP warning before.
> >>>
> >>> >From a quick look it seems to be something that has to do with the g=
eneric ipipe.
> >>> More exactly the fact that handle_IRQ gets called outside the hardirq=
 context and
> >>> LOCKDEP doens't understand the fact that this is how ipipe works. I w=
ould guess either
> >>> the LOCKDEP config should depend on !IPIPE or the ipipe should have a=
 specific case
> >>> the in LOCKDEP implementation so that this warning doesn't shown sinc=
e it will never
> >>> happen when IPIPE is enabled.
> >>>
> >>> I haven't looked too far into this and I might be missing stuff.
> >>
> >> LOCKDEP is not support on I-pipe/arm.
> >=20
> > Right. But it seems LOCKDEP_SUPPORT is default y in the arch/arm/Kconfi=
g.
> >=20
> > I think it should be something like this then:
> >=20
> > config LOCKDEP_SUPPORT
> >         bool
> > +	depends on !IPIPE
> >         default y
>=20
> Right. But LOCKDEP is supported on I-pipe/x86 though.

Yes. That's why this change needs to be done in arch/arm/Kconfig only, as I=
 said before. :-)

>=20
> --=20
> Philippe.

-- =


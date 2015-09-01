Date: Tue, 1 Sep 2015 12:20:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150901102001.GB26674@hermes.click-hack.org>
References: <55E45EE2.1090307@free.fr>
 <20150831183003.GA5696@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20150831183003.GA5696@hermes.click-hack.org>
Subject: Re: [Xenomai] rt_e1000e driver issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Aug 31, 2015 at 08:30:03PM +0200, Gilles Chanteperdrix wrote:
> On Mon, Aug 31, 2015 at 04:04:18PM +0200, St=E9phane ANCELOT wrote:
> > Hi,
> >=20
> > I am checking timing issues of realtime rtnet frames in my application.
> > Timing to send a frame is  convenient.
> > but I have some issues with the time to receive the frames.
> >=20
> > Although the RxDelays are cleared, the frame is received almost 175us l=
ater
> > than it should in comparison with a rt8169 driver (v2.6 version) and the
> > same application.
> >=20
> > Any idea where to look at first ?
>=20
> modinfo rt_e1000e

Actually, the module parameters are the same as the Linux driver,
so, they are documented in Documentation/networking/e1000e.txt in
the Linux kernel sources, here for instance:
https://git.xenomai.org/ipipe.git/tree/Documentation/networking/e1000e.txt?=
id=3Dv4.2-rc1
(beware that the driver versions are not the same, so, there may be
some differences, like default values, or even some options, but
modinfo will tell you that).

Your problem is probably that you should disable interrupt
throttling passing InterruptThrottleRate=3D0.

--=20
					    Gilles.
https://click-hack.org


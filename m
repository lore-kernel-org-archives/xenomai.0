Date: Mon, 31 Aug 2015 20:30:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150831183003.GA5696@hermes.click-hack.org>
References: <55E45EE2.1090307@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55E45EE2.1090307@free.fr>
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

On Mon, Aug 31, 2015 at 04:04:18PM +0200, St=E9phane ANCELOT wrote:
> Hi,
>=20
> I am checking timing issues of realtime rtnet frames in my application.
> Timing to send a frame is  convenient.
> but I have some issues with the time to receive the frames.
>=20
> Although the RxDelays are cleared, the frame is received almost 175us lat=
er
> than it should in comparison with a rt8169 driver (v2.6 version) and the
> same application.
>=20
> Any idea where to look at first ?

modinfo rt_e1000e

--=20
					    Gilles.
https://click-hack.org


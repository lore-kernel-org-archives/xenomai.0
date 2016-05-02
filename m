From: Umair Ali <ali.umair@tut.fi>
Date: Mon, 2 May 2016 10:19:39 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A7320AF@mb2010-3.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A732092@mb2010-3.intra.tut.fi>
 <20160502100534.GA22013@hermes.click-hack.org>
In-Reply-To: <20160502100534.GA22013@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

To be clear: From real time thread you mean the thread in userspace. And fr=
om the sources you mean the configuration options of the Rtnet when install=
ing the Xenmai or do u mean that if the UDP module of the Rtnet is loaded o=
r not. Please guide me.


Thanks
-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: May-02-16 1:06 PM
To: Umair Ali
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packe=
ts

On Mon, May 02, 2016 at 10:01:16AM +0000, Umair Ali wrote:
>=20
>=20
> Hello Gilles,
>=20
> Thanks for the reply.
>=20
>=20
> ** may work from the init module, but not from a real-time thread or vice=
 versa I am calling rtdm_socket() in init module of the kernel app.

Then maybe you should call it from a real-time thread.

>=20
> Can you tell me what kind of portocls are supported by rtdm_socket()

This depends on the options you selected in RTnet configuration. If you sel=
ected the protocol you want, but rtdm_socket fails in kernel-space, again, =
looking at the sources will be your best help.

Regards.

--=20
					    Gilles.
https://click-hack.org


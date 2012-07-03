Date: Tue, 3 Jul 2012 21:27:54 +0200 (CEST)
From: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Message-ID: <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30>
In-Reply-To: <4FEDF65A.50401@grandegger.com>
References: <4FED4948.8080906@basystemes.fr> <4FED4B42.6000808@wanadoo.fr>
	<4FEDF65A.50401@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
Reply-To: Thierry BULTEL <thierry.bultel@wanadoo.fr>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, xenomai@xenomai.org

Hi Wolfgang,

=C2=A0

Thanks for your feedback.

=C2=A0

The issue is that I did not realize that the patch would not have been acce=
pted as such, so I will have to invest more time on than expected ...

so I will not be able to do so immediately.

=C2=A0

Several comments, to your comments


- I agree for the multiple devices, theoretically supported by the original=
 Linux driver. I intentionnally removed them, since I do not have the appro=
priate hardware to test.

- Linux code style. I really thought I had respected it, furthermore I took=
 another (ixxat) RTDM driver as a model. Ok, I can doublecheck ...

- patch high-check vs plx. I do no see what you mean. If I made something w=
rong it is not intentional. Can you be more specific please ?

- Avantech specific ... not much but the classical vendor ID, and also, PCI=
 banks mapping. Again, it is just like the ixxat one, all the driver intell=
igence is in the generic sja1000 code
- patches inline ... Really ??? In the mail content ? But that makes huge m=
ails. I can do so of course, but I do not see the point.

=C2=A0

Cheers

Thierry



> Message du 29/06/12 20:39
> De : "Wolfgang Grandegger"=20
> A : "Thierry Bultel"=20
> Copie =C3=A0 : xenomai@xenomai.org, "Linux-CAN"=20
> Objet : Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
>=20
> Hi Thierry,
>=20
> On 06/29/2012 08:29 AM, Thierry Bultel wrote:
> > Hi,
> >=20
> > I have ported the adv_pci driver from
> > http://git.toiit.sgu.ru/people/samarkinpa/public/?p=3Dadv_pci.git;a=3Dt=
ree;h=3Da57c5d22415f8dbf92eeae0e05ff482839d8c2f3;hb=3Da57c5d22415f8dbf92eea=
e0e05ff482839d8c2f3
>=20
> Thanks for your contribution. This driver is not yet mainline and it's
> the first time that I see it. I added the Linux-CAN ML to the CC as it
> might be of general interest.
>=20
> > I has been quite intensively been tested and cycled for several days in
> > real industrial conditions.
> >=20
> > The patch for 2.6.38-8 is attached to this mail.
> >=20
> > Is it of interest and does is have a chance to be integrated in the
> > xenomai mainline ?
>=20
> There is interest, of course. But we need a proper patch against the git
> head of xenomai-2.6. At a first glance I realized the following issues:
>=20
> - The patch does high-check and remove the plx_pci driver, please fix.
>=20
> - What is Advantech specific in that driver? It looks pretty generic to
> me and it could easily support other similar devices.
>=20
> - The Linux driver mentioned above does support much more Advantech
> devices. Any chance to support them in your driver as well.
>=20
> - Please send patches *inline*.
>=20
> - Please respect the Linux coding style (check CodingStyle and use
> checkpatch.pl).
>=20
> Thanks in advance.
>=20
> Wolfgang.
>

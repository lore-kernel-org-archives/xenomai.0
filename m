Date: Mon, 4 May 2015 11:54:11 +0200 (CEST)
From: Damien Lagneux <damien.lagneux@openwide.fr>
Message-ID: <161457050.3957521.1430733251745.JavaMail.root@openwide.fr>
In-Reply-To: <20150504094745.GL1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problem with the promiscuous mode of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,=20

Thank you for your quick reply.

Here is the script I'm using to set RTnet:
#!/bin/sh

modprobe rtnet
modprobe rt_fec
modprobe rtpacket
modprobe rtudp
modprobe rtcap

rtifconfig rteth0 up 10.5.18.161 netmask 255.255.0.0 promisc
ifconfig rteth0 up

Damien

----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "Damien Lagneux" <damien.lagneux@openwide.fr>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Lundi 4 Mai 2015 11:47:45
> Objet: Re: [Xenomai] Problem with the promiscuous mode of RTnet
>=20
> On Mon, May 04, 2015 at 11:44:06AM +0200, Damien Lagneux wrote:
> > Hi all,
> >=20
> > I'm trying to adapt openPOWERLINK to RTnet. I'm using Xenomai
> > 3.0-rc4,
> > linux kernel 3.16.7, and the board I'm working with is an Armadeus
> > apf6.
> >=20
> > I have a problem with the promiscuous mode of the fec driver. It
> > seems I
> > can only receive packets which are addressed to the board.
> >=20
> > I'm using the raw-ethernet and eth_p_all programs to test the
> > promiscuous
> > mode. If the destination MAC address used in the raw-ethernet
> > program
> > is the the broadcast address or the board's address, the eth_p_all
> > program
> > prints the messages. Otherwise, it doesn't print them.
> >=20
> > I did set the interface rteth0 in promiscuous mode.
> >=20
> > Does anyone have an idea what could the problem?
>=20
> How did you set the promiscuous mode ?
>=20
> --
> =09=09=09=09=09    Gilles.
>=20


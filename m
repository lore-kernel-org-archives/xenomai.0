Date: Mon, 29 Feb 2016 22:04:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160229210425.GC26312@hermes.click-hack.org>
References: <56d4b0f131fc36.79352149@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56d4b0f131fc36.79352149@wp.pl>
Subject: Re: [Xenomai] RTnet -- receive broadcast frame at the local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Feb 29, 2016 at 09:58:25PM +0100, Mariusz Janiak wrote:
> Dnia Poniedzia=B3ek, 29 Lutego 2016 21:29 Gilles Chanteperdrix <gilles.ch=
anteperdrix@xenomai.org> napisa=B3(a)=20
> > On Mon, Feb 29, 2016 at 09:24:11PM +0100, Mariusz Janiak wrote:
> > > Dear Xenomai users,
> > >=20
> > > Since RTnet has been integrated with Xenomai I address this question =
to you. The question is, how to receive a broadcast frame at the local mach=
ine without using the localhost? The issue is following, we have two proces=
s with separate rtsockets at the single machine (of course we have differen=
t machines in the network but this is not a case). One process send a broad=
cast UDP frame to the specified UDP port -- we have one rteth device on the=
 machine. The second process listen on that port=20
> > > (receivefrom) and does not receive the broadcast frame sent by first =
process. I have found the following thread on the RTnet mailing list=20
> > >=20
> > > https://sourceforge.net/p/rtnet/mailman/message/6787561/
> > >=20
> > > Could you please point me the place which should be hacked to duplica=
te outgoing packets if there are multiple
> > > matching routes?
> >=20
> > I ma not sure I understand what you are looking for, but to receive
> > on a host the frames sent by that host, you need to enable and load
> > the loopback module. When you do that, no hack should be needed.
> >=20
> > --=20
> > 					    Gilles.
> > https://click-hack.org
>=20
> Hi Gilles,
>=20
> I am pretty sure that loopback module has been loaded, this is standard R=
Tnet configuration that has not been changed by me. Beside that, there is r=
tlo (127.0.0.1) device which is created when RT_LOOPBACK=3D"yes" in rtnet.c=
onf.=20
>=20
> Below you will find simple testcase. Compile this using Xenomai posix ski=
n.=20

Ok, one step at a time, could you check that if you send an unicast
packet to the local rteth0 address , you receive it ?

--=20
					    Gilles.
https://click-hack.org


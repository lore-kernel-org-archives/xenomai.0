Date: Wed, 30 Sep 2015 16:41:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150930144152.GA17245@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150927213236.GA23716@hermes.click-hack.org>
 <20150929215950.GE18188@hermes.click-hack.org>
 <5758277.0p9CmTfBj9@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5758277.0p9CmTfBj9@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] rtnet locking/socket SKBs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?iso-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Cc: xenomai@xenomai.org

On Wed, Sep 30, 2015 at 04:33:29PM +0200, Marc Str=E4mke wrote:
> Hello Gilles,
> Am Dienstag, 29. September 2015, 23:59:50 schrieb Gilles Chanteperdrix:
> > > What may be missing is that creating sockets should lock the
> > > corresponding kernel module.
> >=20
> > The issue should now be fixed in the xenomai-gch git, branch for-forge.
>=20
> Thank you for your work.
>=20
> I will try the branch in the next days. I have been running for a few mon=
th=20
> now with disabled locking (as in my old patch) in AF_PACKET without any i=
ssues=20
> so it should be fine.

Well, the issue is not specific to AF_PACKET. And if you do not get
socket creations to lock the rtpacket module, you can trigger leaks
and faults by removing the rtpacket module while an application has
an AF_PACKET socket open.

--=20
					    Gilles.
https://click-hack.org


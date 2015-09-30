From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Wed, 30 Sep 2015 16:44:18 +0200
Message-ID: <22921459.mGcCIXvUCO@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150930144152.GA17245@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <5758277.0p9CmTfBj9@eltrolinux48.eltroad.eltropuls>
 <20150930144152.GA17245@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet locking/socket SKBs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Mittwoch, 30. September 2015, 16:41:52 schrieb Gilles Chanteperdrix:
> On Wed, Sep 30, 2015 at 04:33:29PM +0200, Marc Str=E4mke wrote:
> > Hello Gilles,
> > =

> > Am Dienstag, 29. September 2015, 23:59:50 schrieb Gilles Chanteperdrix:
> > > > What may be missing is that creating sockets should lock the
> > > > corresponding kernel module.
> > > =

> > > The issue should now be fixed in the xenomai-gch git, branch for-forg=
e.
> > =

> > Thank you for your work.
> > =

> > I will try the branch in the next days. I have been running for a few
> > month
> > now with disabled locking (as in my old patch) in AF_PACKET without any
> > issues so it should be fine.
> =

> Well, the issue is not specific to AF_PACKET. And if you do not get
> socket creations to lock the rtpacket module, you can trigger leaks
> and faults by removing the rtpacket module while an application has
> an AF_PACKET socket open.
Yes, I was aware of that. This simply does not happen in my application so =
it =

did not bother me...

Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
Arnold-Sommerfeld-Ring 3
52499 Baesweiler
Germany

Tel: +49 2401 - 80970
Fax: +49 2401 - 809715


Gesch=E4ftsf=FChrer: Dr.-Ing. S. Str=E4mke, Dipl.-Ing. Marc Str=E4mke
USt.-IdNr. 291 812 490 / Steuer-Nr. 202/5739/1186
Amtsgericht Aachen HRB 18539
www.eltropuls.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150930/1f9018fa/at=
tachment.sig>

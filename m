From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Wed, 30 Sep 2015 16:33:29 +0200
Message-ID: <5758277.0p9CmTfBj9@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150929215950.GE18188@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150927213236.GA23716@hermes.click-hack.org>
 <20150929215950.GE18188@hermes.click-hack.org>
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

Hello Gilles,
Am Dienstag, 29. September 2015, 23:59:50 schrieb Gilles Chanteperdrix:
> > What may be missing is that creating sockets should lock the
> > corresponding kernel module.
> =

> The issue should now be fixed in the xenomai-gch git, branch for-forge.

Thank you for your work.

I will try the branch in the next days. I have been running for a few month =

now with disabled locking (as in my old patch) in AF_PACKET without any iss=
ues =

so it should be fine.

Best Regards,

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
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150930/72db7596/at=
tachment.sig>

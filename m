From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 18 Mar 2015 13:06:14 +0000
Message-ID: <5294e012d14d4d79856ea5a6ee023e26@MUC-S-EX13B.advaoptical.com>
References: <87992833e1e7483097a81f9a55c800a6@MUC-S-EX13B.advaoptical.com>
 <20150318072126.GH16113@hermes.click-hack.org>
 <a21b188fec9c4279af4f1067d0ac9614@MUC-S-EX13B.advaoptical.com>
 <20150318130225.GA24525@hermes.click-hack.org>
In-Reply-To: <20150318130225.GA24525@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] version connection between xenomai, ipipe and kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Wednesday, March 18, 2015 15:02
To: Sagi Maimon
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] version connection between xenomai, ipipe and kernel

On Wed, Mar 18, 2015 at 11:43:50AM +0000, Sagi Maimon wrote:
> Hi
> One thing is not yet clear to me, and I will appreciate is you clear it u=
p for me:
>=20
> The  "xenomai-2.6.4\ksrc\arch\x86\patches" directory contains:
> ipipe-core-3.8.13-arm.patch
> ipipe-core-3.10.32-arm.patch
> ipipe-core-3.14.17-arm.patch
> So if I understand your answer correctly, the xenomai 2.6.4 supports=20
> only these three ipipe patches, and since ipipe patch is per Linux kernel=
 version, so xenomai 2.6.4 Only fits Linux versions: 3.8.13,  3.10.32 and 3=
.14.17.

No.

>=20
> But you wrote : "It supports all kernel versions up to the latest ones=20
> for which it contains a patch. For instance xenomai 2.6.4 contains=20
> I-pipe patches for version 3.14, so it supports all kernel versions up=20
> to 3.14."

Yes, I said that, and it means just what I said. Xenomai 2.6.4 even support=
s patches for Linux 3.14 that were published after its release (and that yo=
u are encouraged to use instead of the patches it contains by ksrc/arch/x86=
/patches/README). The thing is, however that, as stated by the README, we g=
enerally do not test all past versions, we do not have the resources to do =
that, so, it may happen that some of them do not work, but if you have this=
 issue and report it, we will try and fix it. It may also happen that some =
past version has some bug that was fixed in later patches and that we did n=
ot backport (again, this is a resource problem).

All in all, 3.14 is probably a good choice, since it is a long term support=
 version.

--=20
					    Gilles.


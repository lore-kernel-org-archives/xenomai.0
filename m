From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 18 Mar 2015 11:43:50 +0000
Message-ID: <a21b188fec9c4279af4f1067d0ac9614@MUC-S-EX13B.advaoptical.com>
References: <87992833e1e7483097a81f9a55c800a6@MUC-S-EX13B.advaoptical.com>
 <20150318072126.GH16113@hermes.click-hack.org>
In-Reply-To: <20150318072126.GH16113@hermes.click-hack.org>
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

Hi
One thing is not yet clear to me, and I will appreciate is you clear it up =
for me:

The  "xenomai-2.6.4\ksrc\arch\x86\patches" directory contains:
ipipe-core-3.8.13-arm.patch
ipipe-core-3.10.32-arm.patch
ipipe-core-3.14.17-arm.patch
So if I understand your answer correctly, the xenomai 2.6.4 supports only t=
hese three ipipe patches, and since ipipe patch is per Linux kernel version=
, so xenomai 2.6.4=20
Only fits Linux versions: 3.8.13,  3.10.32 and 3.14.17.

But you wrote : "It supports all kernel versions up to the latest ones for =
which it contains a patch. For instance xenomai 2.6.4 contains I-pipe patch=
es for version 3.14, so it supports all kernel versions up to 3.14."

I guess what I really want to ask, those xenomai (2.6.4) only supports ipip=
e patches that are in "xenomai-2.6.4\ksrc\arch\x86\patches" ?

Thanks,
Sagi




-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Wednesday, March 18, 2015 09:21
To: Sagi Maimon
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] version connection between xenomai, ipipe and kernel

On Wed, Mar 18, 2015 at 06:08:30AM +0000, Sagi Maimon wrote:
> Hi, I have read all xenomai documents, but I still can't understand=20
> the version connection between xenomai, ipipe and kernel.
>=20
> 1) Does the latest xenomai version (2.6.4), supports all the kernel=20
> vanilla versions?

It supports all kernel versions up to the latest ones for which it contains=
 a patch. For instance xenomai 2.6.4 contains I-pipe patches for version 3.=
14, so it supports all kernel versions up to 3.14.

>=20
> 2) When I choose a xenomai version, How can I find the kernel versions=20
> it supports?

Look at the latest I-pipe patch it contains.

>=20
> 3) If there is no Ipipe version that fits my Linux kernel version (I=20
> am using Linux version 3.12.21) , what is the ipipe version I can use?=20
> Thanks, Sagi

None. You would have to port the I-pipe patch to that version.

--=20
					    Gilles.


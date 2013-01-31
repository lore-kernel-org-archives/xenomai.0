Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
Date: Thu, 31 Jan 2013 19:52:04 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBC83491-8FC6-49AD-B4A5-A723477C171C@mah.priv.at>
References: <mailman.0.1359630001.19052.xenomai@xenomai.org>
	<9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
Subject: Re: [Xenomai] Ipipe pre and post patch for AM335x beagleBone/
	koenkooi branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

folks working on Xenomai for the Beaglebone might want to read this:

http://sourceforge.net/mailarchive/message.php?msg_id=3D30426770

- Michael


Am 31.01.2013 um 15:17 schrieb Stephan Kappertz:

>=20
>>> Hi All,
>>>=20
>>> sorry for the long delay. As Gilles suggested I have prepared a pre =
and post patch for ipipe-core-3.2.21-arm-4 and the git repository =
supporting BeagleBone here: =
https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr7=
20e07b4c1f687b61b147b31c698cb6816d72f01 . Should I send the patches to =
the list?
>>>=20
>>> - Stephan
>>=20
>> I think that you should.
>>=20
>> Goran
>>=20
>=20
> Here they are.
> Usage:
>=20
> * clone git repository =
https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr7=
20e07b4c1f687b61b147b31c698cb6816d72f01
>=20
> * checkout linux-ti33x-psp-3.2.21-r13g
>=20
> * apply pre.patch
>=20
> * run xenomai (tested with 2.6.2.1) prepare-kernel.sh
>=20
> * apply post.patch
>=20
> * Configure & compile kernel
>=20
> - Stephan
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: beagleBone_pre_post_patches.tar.bz2
> Type: application/x-bzip2
> Size: 5820 bytes
> Desc: not available
> URL: =
<http://www.xenomai.org/pipermail/xenomai/attachments/20130131/e6446062/at=
tachment.bin>
> -------------- next part --------------
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai



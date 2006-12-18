Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2006 14:06:42 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A6F928A@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] prepare kernel fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

When I try to prepare the kernel with xenomai-2.3-rc2 I get the
following error :
"find: xenomai-2.3-rc2/sim: file or directory not found"

The Prepare command I use :
scripts/prepare-kernel.sh --linux=3D/home/user/linuxppc  --arch=3Dppc

Does anybody know what this means ?
I Could not find a sim directory or file in older versions too, but they
prepared the kernel correctly.

Roderik


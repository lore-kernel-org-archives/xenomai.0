Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2008 14:01:24 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38250@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] [1/9] Support for non cached memory mappings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> This patch adds architecture independent support for non cached memory
> mappings. This is necessary on ARM architecture with VIVT cache to
share a
>mapping between kernel and user-space, but may be used in other
situations=20
> (who knows).

So, the difference between H_DMA and H_NONCACHED would be that
H_NONCACHED
may not be physically contiguous, while H_DMA (that is physically
contiguous)
may still be cached on cache coherent systems. Is that correct?

--=20
Stephane

PS: any plan on a H_HUGETLB one of those days?


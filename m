Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2008 15:47:28 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38251@domain.hid>
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
>>  PS: any plan on a H_HUGETLB one of those days?
>
>What would this do ?

Some embedded platforms have small TLB compared to the vm hungriness of
certain real-time tasks. H_HUGETLB would reply on HugeTLB[1] backing for
allocation. Scattered accesses to this memory would benefit in the lower
pressure of minor page-faults/TLB refills, which is a good thing(tm) for
real-time.

[1] linux/Documentation/vm/hugetlbpage.txt

--=20
Stephane


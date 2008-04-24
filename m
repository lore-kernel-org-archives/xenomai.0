Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2008 19:13:34 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38252@domain.hid>
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
>>  Some embedded platforms have small TLB compared to the vm hungriness
of
>>  certain real-time tasks. H_HUGETLB would reply on HugeTLB[1] backing
for
>>  allocation. Scattered accesses to this memory would benefit in the
lower
>>  pressure of minor page-faults/TLB refills, which is a good thing(tm)
for
>>  real-time.
>
>I do not understand the need for a kernel option and a special
>filesystem, why does not the kernel use these hugetlb pages upon large
>allocations ?

You must be speaking of an ideal world, with almighty smart OS ;-)

I do not have the answer to your question. I guess we could find=20
some lengthy discussion over lkml about the virtue and side effects=20
of automagically using hugetlb upon large allocations. Maybe the kernel
hackers were not confident enough about hugetlb, and just tolerated an
optional subsystem requested by evil big iron application. Rem: not all=20
MMU(hardware) and/or Linux arch(software) have HugeTLB available.
Maybe they thought that it was not worth it wasting hard to find=20
contiguous memory, while lazy allocation has so much reward when=20
a process allocates more memory than it's really using.

As far as I understand, HugeTLB is only an opt-in feature, when
performance=20
or predictability is expected. To put it another way in Xenomai world,=20
HugeTLB can reclaim part of the performance loss when going from kernel=20
space to user space. In kernel space, RAM is generally covered with a
BAT=20
or similar. This is not the case in user space with 4K page allocation.
Off course, the issue appears only with big working sets.

--=20
Stephane


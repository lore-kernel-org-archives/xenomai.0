Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B61171F
	for <xenomai@lists.linux.dev>; Tue, 16 Jan 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 02F27641041F;
	Tue, 16 Jan 2024 09:22:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bzPJNvuVfZLk; Tue, 16 Jan 2024 09:22:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7C86B626FB01;
	Tue, 16 Jan 2024 09:22:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LmQBsSYFyHUS; Tue, 16 Jan 2024 09:22:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 59A8F641041F;
	Tue, 16 Jan 2024 09:22:03 +0100 (CET)
Date: Tue, 16 Jan 2024 09:22:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	wg@denx.de
Message-ID: <404252638.239962.1705393323222.JavaMail.zimbra@nod.at>
In-Reply-To: <c1aa91be-a8c3-4d36-83fc-1dcce598dcef@siemens.com>
References: <20231205202210.25477-1-richard@nod.at> <c1aa91be-a8c3-4d36-83fc-1dcce598dcef@siemens.com>
Subject: Re: [PATCH] cobalt/drvlib: Prefault io memory again
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: cobalt/drvlib: Prefault io memory again
Thread-Index: nGnhGhNxZlFTglxEVKMyXwU8pInZuA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>, "Phi=
lippe Gerum" <rpm@xenomai.org>
> CC: wg@denx.de
> Gesendet: Donnerstag, 7. Dezember 2023 10:12:27
> Betreff: Re: [PATCH] cobalt/drvlib: Prefault io memory again

> On 06.12.23 04:22, Richard Weinberger wrote:
>> This issue was fixed a long time ago by
>> 03d5b0b0083c ("cobalt/rtdm: fix caching and page fault issues with
>> rtdm_iomap_to_user()"),
>> later with commit c8e9e166b ("cobalt/rtdm: introduce mmap() support")
>> iomap code lost again the call to cobalt_machine.prefault().
>>=20
>> I have no idea why this took so longer to come up again.
>> Last week, while upgrading an aarch32 setup from Xenomai 2 to Xenomai 3,=
 the
>> application
>> failed due to massive latencies caused by page faults after writing to i=
o
>> memory.
>>=20
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  kernel/cobalt/rtdm/drvlib.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>> index 30455c3d7..620be27fa 100644
>> --- a/kernel/cobalt/rtdm/drvlib.c
>> +++ b/kernel/cobalt/rtdm/drvlib.c
>> @@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct=
 *vma,
>> phys_addr_t pa)
>>  {
>>  =09pgprot_t prot =3D PAGE_SHARED;
>>  =09unsigned long len;
>> +=09int ret;
>> =20
>>  =09len =3D vma->vm_end - vma->vm_start;
>>  #ifndef CONFIG_MMU
>> @@ -1774,8 +1775,17 @@ static int mmap_iomem_helper(struct vm_area_struc=
t *vma,
>> phys_addr_t pa)
>>  #endif
>>  =09vma->vm_page_prot =3D pgprot_noncached(prot);
>> =20
>> -=09return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>> -=09=09=09       len, vma->vm_page_prot);
>> +=09ret =3D remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>> +=09=09=09      len, vma->vm_page_prot);
>> +=09if (ret)
>> +=09=09return ret;
>> +
>> +#ifdef CONFIG_MMU
>> +=09if (cobalt_machine.prefault)
>> +=09=09cobalt_machine.prefault(vma);
>> +#endif
>> +
>> +=09return 0;
>>  }
>> =20
>>  static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct=
 *vma)
>=20
> This makes sense to me, specifically as c8e9e166bce43 didn't provide any
> reason nor even mentioned the fact that it didn't add prefault to the
> iomem_helper. Philippe, was there a reason? Are we side-effect-free /wrt
> actual IO memory accesses when pre-faulting?

*friendly ping*

Thanks,
//richard

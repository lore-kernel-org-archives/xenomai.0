Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AC216396
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736372; cv=none; b=TZBR+3BTuQaKiKluwf/ZxnirHIAkwOO/5VDkTc8AEKXUHx/mOaBHn52OvE6zj2OdisxiU8Cmv4aO/JBCq9i9zeWiOkxDzQLmUzZx4rKDmxhRW4JYr7VrNl0g9/V4XDksi0caMVbI+hcFdnXezFJZy4XUgGEu7ptt0jOr5teu2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736372; c=relaxed/simple;
	bh=1z1LYXdMhCjeoKeNGn2EQx9W0HBop9Ru87OM3MAjck4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6gKQNLkRp0sx+d3cFL423bUj51tS6P2CcLNqhMcEWQmjDln0LW+6ui7YHAj41k3ELXwL1RbCs4Kzb+J2Gzla0INXW01EYuXlHTz0AfGQ/KCpfGlhday2shcn/5bMa2DFqTAHTxx9mR+Dpgd5yWp37ofosvGH9hnDY7dli6IAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=N5fEgpwg; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="N5fEgpwg"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241209092558019378d98ec8451dfe
        for <xenomai@lists.linux.dev>;
        Mon, 09 Dec 2024 10:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=A6AyD7FvyRHp9GYK/hooUCSynNwB4NJkUVjhRh7HuTQ=;
 b=N5fEgpwgNtu9eOvmL8rVJR8r0e2AAfwspkFWNwSFaWRceGb9yRvo1wieuyGD50CgNE4Kn+
 xplZ298Cmb7X2J3W19kwaVt/mOO661p9WdkM3rtXXKV2Zi9y945f278NKT8HrUNIYpU3DYBQ
 L1q0BdxWoa/rnNX4H+S4ZB6cWUII7NyI3SKXAiz6oTBoWC76wJ5h2QLDGVSo1tbFWgI5fSRC
 3arRVDNkaQwzJKtfnKMU9n+QQwNn7f95gMzJsRlUR9JzGY0mg6hulf3qEJ/h/gn52CX9Ty5r
 ydn04jE4DgE6obkIdvxeFgf5RqeYnQw9pxtaGyoCydbfuf3bzJ09GsRg==;
Message-ID: <1a1ba081bad39a548d0ca0b1bce44b7c9643d9ce.camel@siemens.com>
Subject: Re: [PATCH] evl: fix the gdb accessing control buffer issue.
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Qichen Qiu <ruiqurm@gmail.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
Date: Mon, 09 Dec 2024 10:25:57 +0100
In-Reply-To: <20241209083746.672587-1-ruiqurm@gmail.com>
References: <20241209083746.672587-1-ruiqurm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2024-12-09 at 08:37 +0000, Qichen Qiu wrote:
> Currently, EVL maps the control buffer using remap_pfn_range, tagging=20
> the memory with VM_IO. However, this prevents access by gdb.
>=20
> This patch introduces the control_mmap_access function for the control=
=20
> VMA, enabling gdb access when CONFIG_HAVE_IOREMAP_PROT is supported on=
=20
> the target architecture.

@Philippe: I haven't checked the details yet, but the memory mapping is
different for Xenomai 3? Just wondering why this is necessary at all.

Does that mean that gdb did not work? On which platforms/architectures?
Is there no test for gdb like the gdb test in smokey?

>=20
> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  kernel/evl/control.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/evl/control.c b/kernel/evl/control.c
> index 2d1b44f3b0dc..33ec47745740 100644
> --- a/kernel/evl/control.c
> +++ b/kernel/evl/control.c
> @@ -8,6 +8,7 @@
>  #include <linux/mm.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/bitmap.h>
> +#include <linux/highmem.h>
>  #include <evl/memory.h>
>  #include <evl/factory.h>
>  #include <evl/tick.h>
> @@ -335,8 +336,52 @@ static long control_ioctl(struct file *filp, unsigne=
d int cmd,
>  	return ret;
>  }
> =20
> +static int control_mmap_access(struct vm_area_struct *vma, unsigned long=
 addr,
> +			       void *buf, int len, int write)
> +{
> +	resource_size_t phys_addr;
> +	pte_t *ptep, pte;
> +	void *virt_addr;
> +	spinlock_t *ptl;
> +	struct page *page;
> +	int offset =3D offset_in_page(addr);
> +	int ret =3D -EINVAL;

^^ Code style: "Reverse Christmas tree" ;-) Applies to the second hunk
as well.

DOS line endings everywhere...

> +
> +	if (follow_pte(vma, addr, &ptep, &ptl))
> +		return -EINVAL;
> +
> +	pte =3D ptep_get(ptep);
> +	pte_unmap_unlock(ptep, ptl);
> +
> +	phys_addr =3D (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
> +	page =3D pfn_to_page(PFN_DOWN(phys_addr));
> +
> +	virt_addr =3D kmap(page) + offset;

kmap() as well as kunmap() below are deprecated (according to
checkpatch). kmap_local_page() and kunmap_local() should be preferred.


> +	if (!virt_addr) {
> +		ret =3D -ENOMEM;
> +		goto unmap;
> +	}
> +
> +	if (write) {
> +		memcpy(virt_addr, buf, len);
> +	} else {
> +		memcpy(buf, virt_addr, len);
> +	}

Mixed code style. See checkpatch output.

> +	ret =3D len;
> +
> +unmap:
> +	kunmap(page);
> +
> +	return ret;
> +}
> +
> +static const struct vm_operations_struct control_mmap_ops =3D {
> +	.access =3D control_mmap_access
> +};
> +
>  static int control_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
> +	int err;
>  	void *p =3D evl_get_heap_base(&evl_shared_heap);
>  	unsigned long pfn =3D __pa(p) >> PAGE_SHIFT;
>  	size_t len =3D vma->vm_end - vma->vm_start;
> @@ -344,7 +389,13 @@ static int control_mmap(struct file *filp, struct vm=
_area_struct *vma)
>  	if (len !=3D evl_shm_size)
>  		return -EINVAL;
> =20
> -	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
> +	err =3D remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
> +	if (err < 0){

if (err)

> +		return err;
> +	}
> +
> +	vma->vm_ops =3D &control_mmap_ops;
> +	return 0;
>  }
> =20
>  static const struct file_operations control_fops =3D {
> --=20
> 2.34.1


Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939223126AD
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945591; cv=none; b=DJSfmi/bbzmIPyDn5YPoDiTUqXltgh0T1rxv/PdvKlGOKNIEgqvxs7icpNN0TEHw8Q4cy77HoLHH87mzU8x3bRf/r0MpYT8+S4Dkz7KO8S+VJwpwoLNhVSYdzkcEP7Bh4MyztnVNgy+D7BOK0XN7t4W7QBDK7l84gYoWiozO7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945591; c=relaxed/simple;
	bh=orLhwJTdL/H0SrLgZr8LGKzz33C8h/wDfJCAPLfWHkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdAR4pRO0+bL00k3aahNYNQwsTOXvyAjpAhip40FSYVptvlq4C7F7GP2ucL5KrISoZVzqwrgsfOtn3D4Z4e9UbVmq20jlo3hsCsezeoOcY3G+kzLmJEn4Z4VVJm3XaV1Bi3UOnNS7zLWI/KxRVKFNewTFKPuz5RyWiaJqsF8YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OJvpiBAd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OJvpiBAd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97E283ECE8;
	Mon, 13 Jul 2026 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783945581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pke9nHffI9+DgJhK6/WG9C8KkkRWgxYGjUgjGFBdGng=;
	b=OJvpiBAdLZKi9fIECY9LJxDUiC1VwatlQplsTaGHOpx6W9wL6AbJZS5nVp+2VdWACw5OE+
	aLpKtr+tq8Se17EL9hC72MrraDCszZXcwCTkjaeZveH7h8T+CouWFM2qK+KxtyUqomGyfW
	ESzYmbz2Wmo6nTXnq8pK5S+oAxKrt6kuWZxmYdy2nyuTte1O1rCUl+j3fDdhiuoyak+KWt
	BTtOI+iF3V4uJw276GLIdeayoWSuF8CazNQ4LnotOQcjpp8Sd89Wf9OJQAr+j+jRlUmT1k
	2UOcHvrXutW1dxbK9c7R/Z1Qg7adlJJrqDeqNj9MnJUBHvP8zmHVKDKll6T2XQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl v3] build: add initial RISC-V support
In-Reply-To: <2336fe07-fdea-4875-96fd-46c4aa5d13a7@siemens.com> (Tobias
	Schaffner's message of "Mon, 13 Jul 2026 12:37:01 +0200")
References: <20260713103445.34208-1-tobias.schaffner@siemens.com>
	<2336fe07-fdea-4875-96fd-46c4aa5d13a7@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Jul 2026 14:26:20 +0200
Message-ID: <87mrvv5b4j.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFDzTHkKqS59RDPv6fO3HB1/rSr3IUradc6L+zCTc2XTLQL7/prreCmKSwrICxMj3vEM985b9AxL3b205uFGm3n6mYG9/0eEPQiAIcGaN827ChVwVy31G2DZANf0wuOPiMtwoHzvtynHf+qCH5IVq8OGajUBPW03RkNeo4Zx2yrDDx1z0BW7vGjuZ1WsuQAwVt8ILOt+73b8iXWAP4odt3jb4ju2QeTYE0EAKntxM95UrcWzRAlgeFP7jI7iQa2df1pkCVcsBtMw+zQz0VYgm/qYoIgp+uTaatIZA72gfRcyu8Hun2dS+pzEonsiO/sP1mqMyOLx8lO9j4nd653f0QZgUi4aYvz7CriJkjwrrSjfXNE5XsUAB943X3UcgBhF5y/o0rFGqzb+Pe24pVL5HnGZbNUCaYf/tsm1xmTfu7yM54Zd86rZqaVqddweHGxfxeMPUhoNp4T2nmf6pZeSjucJJ+he4Z5dX0YEkv2wTSzQMSJr8k31bTkBirdW3/wiE96p7e5ap8QwIrzGtb/+SKg5IulmuEhfU7d+a/BFhGkjCJI3JWWQW8Imx6iLWZ8dq4Xu60MhmVkGpQn2Sm+5mLtOh8AMtfQyhDK/giwEnroeEYn9NsUzGW+iOgrh6ldyzBULibr12mKdAJ64pg3qms1A5kSLHDrVUwKly3O4X0gHw

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi Philippe,
>
> On 7/13/26 12:34, Tobias Schaffner wrote:
>> Provide the basic build infrastructure required to build libevl on RISC-V.
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   meson.build             |  4 ++++
>>   meson/riscv64-linux-gnu | 17 +++++++++++++++++
>>   2 files changed, 21 insertions(+)
>>   create mode 100644 meson/riscv64-linux-gnu
>
> I removed the vDSO-related definitions from this patch to allow you to
> integrate it together with the patch you send today.
>

Thanks, done.

-- 
Philippe.

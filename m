Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6B37C0E4
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599651; cv=none; b=bNDq7ukRjhaeVpoW6MNHFMxfagtdiB23fN7K2wCUJd0kEWMNrw7MB16wFW2XkiJXkf/pGohHCdlagqxZ6tMgVN6g5vK1+k+JYPrpNAaWe4oay7+fTN90vYh9wRsPzMs5Z4KyNNu9RhoRLormhC5uptm+U3IIgcL0R1o6ebbDIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599651; c=relaxed/simple;
	bh=5qjzSzmCpuWcLsrYAvJqhjbcqGAwszbVXU+JaF+RHzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r21OLEK0fWdQK/vUm3ZVeVFHm7y6+yjQsdVRGem3UsiYQR1nGeiXoPBYJtq5qcl2KA0eTbCu4771Hx07gTml2gNvULuT5lJKq9bGYXlE4DbXuebVo6WYo9gRhRiT3RnNeSXzPo5LoJWlGNznDF833/zQPawj+7+9YLezhzFQ918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=adO4dICg; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="adO4dICg"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260512152717f1f0f2dbad0002070e
        for <xenomai@lists.linux.dev>;
        Tue, 12 May 2026 17:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fJX9nj7UkCq8RUao4Dmlu69icutNlSyuPdUdT1xifcA=;
 b=adO4dICgiMc9pTsDOVI1yVAIBOdl4DsOaBdIo70PaVByZ5jkXTAIYQvuNYC648AE90zZ1u
 bSfsgZ3qw2Y1wx7WqQLpwSf5NRfI31eOIIT5fvQzAbSial9D/D8cDCFUy6lld1pTUgp9IO/i
 yNzjuWNmFf4Tsi8YFC78YBCUP26Yiyo5S026A2kjhMsvAvPpVPZSnK7/tiPX6zGZVjeiK3xQ
 IetAmlIglKwHlYh8md3pZYAgNttZ7jMxjzDZRv4hs/A1mkD3cBWJVTmBk+S5qWhaJ/cV8+XW
 Q0qUx1NoMUJB8d1jJAw8f7/SFvRbW6M++NUToFyniOAqrzt8tDhURYnQ==;
Message-ID: <b104a6f27a623f6f991aa2efd249abad397e9e45.camel@siemens.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger
 <richard@nod.at>,  xenomai <xenomai@lists.linux.dev>
Date: Tue, 12 May 2026 17:27:16 +0200
In-Reply-To: <CAFLxGvxqNJ9L527vVdHWc2M4JPM2+hNcid-NKupAyAvrTCmhyQ@mail.gmail.com>
References: <20260507122357.2463483-1-richard@nod.at>
	 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
	 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
	 <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
	 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
	 <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
	 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
	 <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
	 <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
	 <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com>
	 <CAFLxGvw+Bnb_OFaBD8KnPqpY769VMnMeCK-tLxLoUyiE_eSyiA@mail.gmail.com>
	 <2211f3a8bcca094721e7537dc2854e27806da237.camel@siemens.com>
	 <CAFLxGvxqNJ9L527vVdHWc2M4JPM2+hNcid-NKupAyAvrTCmhyQ@mail.gmail.com>
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

On Tue, 2026-05-12 at 17:04 +0200, Richard Weinberger wrote:
> On Tue, May 12, 2026 at 4:26=E2=80=AFPM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > __RT() might be the problem here. You will end up in __cobalt_mmap()
> > unconditionally, right? Does migrating to mmap() with all the wrapping
> > magic help here?
>=20
> When not using __RT(), the unresolved symbol is  __wrap_mmap64().

I'm still confused about the missing __wrap symbol, but to repair __RT()
for mmap() we have to do something similar as glibc does:

#ifndef __USE_FILE_OFFSET64
extern void *mmap (void *__addr, size_t __len, int __prot,
		   int __flags, int __fd, __off_t __offset) __THROW;
#else
# ifdef __REDIRECT_NTH
extern void * __REDIRECT_NTH (mmap,
			      (void *__addr, size_t __len, int __prot,
			       int __flags, int __fd, __off64_t
__offset),
			      mmap64);
# else
#  define mmap mmap64
# endif
#endif

The redirect part is most likely missing in Xenomai. Redirect mmap() to
mmap64() in case 64bit offsets are in use.

>=20
> > Probably the same question as we had for the time_t related services: D=
o
> > we want one libcobalt build to support both worlds at the same time?
>=20
> At least the application on my desk uses __RT() a lot.
> Sorting all this out would make some pople rather unhappy, I guess.
>=20
> --=20
> Thanks,
> //richard

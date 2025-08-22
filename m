Received: from cczrelay02.in2p3.fr (cczrelay02.in2p3.fr [134.158.66.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587132FB993
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869370; cv=none; b=AC3QBBOK7lD38syXVPaoEb3JogmqbkUMrbfIZjEWBNGqTKKRW15hdOX6+G6N0891l/GQHYXvZ6SxJmKKTnszMNd8mQE5Ttvb6OqkkuJirUPEwCnHLVkapNdfMJ7ZJ8l01RHscGDn6eMhMwoAe8vNGC7uN54GfVqvchX5wp9ktUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869370; c=relaxed/simple;
	bh=5K8Tr4x1VaMKX0ASix5HzZqZ7KltcmAIzyJaMMVGLwE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7XCGQWdf/dAMJViUtgflXJH/vMdbK0h2pvHfGN5+t7jDBRhO2yukGnJSWNYC66tLz2l6u8BwcfdNect0soVDwOJcS9HUmCFIVZBW6Jej/8batCSQD3Hd4C8ZBJk1YXkN2nX92CkbFU7UVp7F27zlqPO2IL5ThObyOOx3qJc0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay02.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57MDTNKt017270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 15:29:23 +0200
Message-ID: <120fe6031963eed74f04c365c7b780a86af579c0.camel@lapp.in2p3.fr>
Subject: Re: Simple Xenomai 4 API use examples and a question
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: xenomai <xenomai@lists.linux.dev>
Date: Fri, 22 Aug 2025 15:29:23 +0200
In-Reply-To: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Le vendredi 22 ao=C3=BBt 2025 =C3=A0 09:13 +0200, Emmanuel Pacaud a =C3=A9c=
rit=C2=A0:
> I have started to work on a repository which is intended as a collection =
of very simple (dumb) examples of Xenomai 4 API use. Each example is an app=
lication, sometimes coupled with a kernel module, with the strict minimum a=
round the actual API use. Applications and kernel modules are built using m=
eson. The meson files are also kept the their simplest form. That was easy =
for the application building, not so for the kernel modules.

In my quest of the simplest example, there is this line in <https://gitlab.=
com/emmanuelpacaud/xenomai-c-examples/-/blob/8253729aa3eb669576e387bba80085=
c91199f3cf/meson.build>:

```
exe =3D executable (e, e + '.c',
                  dependencies: evl_dep,
                  c_args:   ['-I' + evl_dep.get_pkgconfig_variable('include=
dir') 'uapi'],
                  install: true)
```

In my setup, I, don't install kernel user space API headers, as it is a dis=
kless one, where I want to be able to switch between different kernels. So =
I let install-uapi enabled, which means *-abi.h files are installed in $pre=
fix/include/uapi. Which means I have to add this path to the include path m=
anually, as it is not present in the pkg config file, using c_args paramete=
r.

Is it intended ? I would have expected them to be installed along the other=
 libevl headers. If so, I think the C flags in pkg config file should inclu=
de $includedir/uapi, when install-uapi option is enabled.

Emmanuel.

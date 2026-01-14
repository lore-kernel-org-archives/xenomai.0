Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C639C64C
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404687; cv=none; b=jcUCELfYqxkPAfBi/y1NE4TTNgtKR5VytK8867lH86ulUIxQ40OcozJR3nOtVD4zAwvZ728tiqa/o9K/vEJzH5lXAvinYfuuplowAhYfW4tjzfV10JPSZkevw0OWcPh4t2awLHZ5DB8kJPGfHbl7oPZnV8hEN9YZgqy9FpSbKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404687; c=relaxed/simple;
	bh=t+VQUEdFw1k8XlCZZUfzQ+UzCexQ7o2kjRND42QG4Ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdDZruQC7sggnIlmEuR3lgCIqfA9DZpTzjUun0gJVkkrWzwt5Ns0X5boWO5qiB/wiNQoyoWoiKNfBxD8xadVFEP71KovjXKK3i+yQbaacpPZw4Nmlh8hDllLNy0rS+ZCf5cv3D6OiIwowhkjIEAvoN/KVT44ElmZrmPoOLHWQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YFni+TwW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YFni+TwW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 294A8443F1;
	Wed, 14 Jan 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768404678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0o0CkQXQY0QL/Ny119n77M/Kx2wp5PLtuyAhaVBnKo=;
	b=YFni+TwWzi3ne2y9r6bP1t2d1qROixTzb04FSt4go19brhC7EgDvmH7hrvN202cr8NVYAs
	mh9JIdtYRiWH8tRbmUPwdalPSq2PhItJikEeBMAYEKf472km5Wi39qahc29iBE4MYx038e
	fqZ2bBGjWVAZBd3VUgnQsuvmcSfUZ1dbC1qX1yHK1kj4kWAsMFDW4QC/ETPQrpw30vK1Ws
	PYT82bUg7sE4qhoxmxQsBNTRoqOVQyiJqmkAAav8aDZiWObe4ZotV7ayEJ5rjSjyjUoSjT
	n0FjH7zPnUkL6mtVj+dSDuWBF6+spGEb6jCgaXt0HVXnt+4DVNFJ8AbPSYuNFA==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH] evl/net: export sock_oob_bind symbol
In-Reply-To: <20260114092711.3204218-1-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Wed, 14 Jan 2026 17:27:11 +0800")
References: <20260113094852.2806192-2-junxiao.chang@intel.com>
	<20260114092711.3204218-1-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 14 Jan 2026 16:31:15 +0100
Message-ID: <87v7h41a9o.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdelgeetkeeggeefhfdupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh
X-GND-State: clean

Junxiao Chang <junxiao.chang@intel.com> writes:

> API sock_oob_bind symbol should be exported because it might be
> used in other kernel modules.
>
> Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
>  kernel/evl/net/socket.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c
> index 4c61a1c1f6d0..69593470d62b 100644
> --- a/kernel/evl/net/socket.c
> +++ b/kernel/evl/net/socket.c
> @@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
>  
>  	return esk->proto->bind(esk, addr, len);
>  }
> +EXPORT_SYMBOL_GPL(sock_oob_bind);
>  
>  /*
>   * In-band call from the common network stack to shutdown the

Merged, thanks.

-- 
Philippe.

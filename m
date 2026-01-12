Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424335CBA6
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226637; cv=none; b=Ezf+NsfQVc7vyajaV8tjuFAVc+rO7v0S6Lx/uDEvwER82sYqnXNDUyluzidPNh9ktcy/7uNBl3PmZwmJzHTRrbnE5MUUreZI8ggCL139wNQq7FyuDK4ZbwHUm2yBAh91aDLkLrGBZ4fzgrN9H2zjDyjeGEwsCuuHEl/1KebZUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226637; c=relaxed/simple;
	bh=zwg8WdMbUHJftsuti4NL0dezkyBwanFwEJ1DeRULPMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iyO1D2XVlhLyj7fTaCLSzhIlXLZCFMzucmcjgsPHyP45TnuzgKa7EqDT3v9PuWWsqirjzoGwRWLep1f41mRSg7D3J/3NS/Ha9L3ADlIJsIu7MdsjHkPQsDOAAFdptD5hKgfiOtkf1hUXrEzpP1QEePAuNxteHb6BcFNhf5WIJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=f54LxFhv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="f54LxFhv"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAC7C43A32;
	Mon, 12 Jan 2026 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768226624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bo2CT6JLwXXmJVShPmfS2ZsnoeuitLanhywOF6Y75EM=;
	b=f54LxFhvWE0a1ie3Xax2LQNuaADXRYWW7GJg4/d+eamvOojhORUu2S4i7TCXohP5KLP/Pu
	1OnCCM7dUZgtKemtroxPg09ctsT3WhRA3GV5u2UP07VkqPeDx3D8/83C38LJrgApIdolMU
	Ce2K8pHpBjsbC5DeYnAxVs5cnxEPtzlk2vcK6lCS11Sd9PGkwrfhQ88rgX6q1iWkvAFxj3
	S76vk1G5hZz+Wu4LxTD2oS+lteKVYqteK3sqh/SE7VCjaAKnGolaA3HjvsCl1LOjrLuM51
	gehvvjlAh49Wm0GAQcGPu3sm4YwU+QJ1DTGsYz1lPBiM51PsT7Fs+1ywyVmUvA==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH evl 6.18 2/2] evl/net: export sock_oob_bind symbol
In-Reply-To: <20260113094852.2806192-2-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Tue, 13 Jan 2026 17:48:52 +0800")
References: <20260113094852.2806192-1-junxiao.chang@intel.com>
	<20260113094852.2806192-2-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Jan 2026 15:03:39 +0100
Message-ID: <87bjizorlw.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfetveejveegfeetfedvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh

Junxiao Chang <junxiao.chang@intel.com> writes:

> API sock_oob_bind symbol should be exported because it might be
> used in other kernel modules.
>

The routine you are exporting is the implementation of a weak symbol
called by the regular network stack in order to allow any real-time core
which may be interested to extend the logic of a common networking
operation, in this case socket binding as extended by evl. If you were
to add some evl-managed protocol, then you would declare it to its
network stack, so that sock_oob_bind() could automatically route any
relevant request to some handler in your protocol implementation.

Therefore, I'm unsure to understand what could be the use case here, why
would and evl-based module need to call this routine?

> Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
>  kernel/evl/net/socket.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c
> index 4c61a1c1f6d0..b87f3fa9863d 100644
> --- a/kernel/evl/net/socket.c
> +++ b/kernel/evl/net/socket.c
> @@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
>  
>  	return esk->proto->bind(esk, addr, len);
>  }
> +EXPORT_SYMBOL(sock_oob_bind);
>  
>  /*
>   * In-band call from the common network stack to shutdown the

-- 
Philippe.

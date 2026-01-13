Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BB2D4816
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315986; cv=none; b=mVmnXDdHJxCCV5hbNq07UqznNqIH7mD8/XR7Ez/dX8K4agedcdkF60JMp2XPr+kEdbx4p9SNg8I4xankFahWa9zN0qJW9cY3YVgm1yRVrjPFysYOCOBDGZuwYMVkK5qKAMjuR5j/Dz821qd0maneqD6VM94xGkP4LXxMcOKCGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315986; c=relaxed/simple;
	bh=IhSxhGzN/5RTe7DmfvrX+pzhUqakcRyTCU32xRX5+0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFqciqDAofxq/U01A4hgzM3y0CJkvoWpHyYTOe7UZQw2zaKzLy87ZSuEL4WJp6+/FeAlJ/YOywaawlCJsL3JUyDFoeu/BqlcWU+WLtPQNYtTtGngtHhcnJFSLEkiJFVylABCLUmiAkISnCr8y/3252X3znJSsdSw6beegcmiizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Co9jnMD/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Co9jnMD/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A7184431A;
	Tue, 13 Jan 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768315981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLiX55grVr3q6RrJLHgD4lQrmdiI8tbAr9E9HmxWU7I=;
	b=Co9jnMD/HE9aYpB+8XlYc8mKHX/qgjvYz/0moZSMahl3YPm72VuUDNcboOhUtrbSIQcCKY
	kSYu9kecfvREPczt6EsyASgytgFQlo4PBMRy630lMggDpvBn+8R0xG/ZIbPkiDvAo4P4sY
	Y5Jz3p2mvAu7IrqwQoqo3xZUBhP8tGgwWbMyjFeyrDiPcOdyvFNcVnXexYWNld9fH/hWtj
	qKdZptVHgIysDPtSwiS69bvkeY7smMnhkbNcnaZg9+t4/5gIdvTqzgHXLcXxPsLcv9vIga
	ipmUi6CqfNHiBtz3ivVczZn/fJaz+YNQqCVfVVZBFktvaKb5AjCmeZJCbhbpUA==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH] evl/net: export sock_oob_bind symbol
In-Reply-To: <20260114092711.3204218-1-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Wed, 14 Jan 2026 17:27:11 +0800")
References: <20260113094852.2806192-2-junxiao.chang@intel.com>
	<20260114092711.3204218-1-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 13 Jan 2026 15:53:00 +0100
Message-ID: <874iop36pf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgeetjedukeeggeefudetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh
X-GND-State: clean
X-GND-Score: -100

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

Almost there, I just figured out that there is an even better option
though, so that we can keep this hunk in the code which actually defines
the interface. This patch would sit on the dovetail side (not evl):

diff --git a/net/socket.c b/net/socket.c
index 1ecf67b656c51..ba00e99b042cf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -167,6 +167,7 @@ int __weak sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sock_oob_bind);
 
 int __weak sock_oob_shutdown(struct sock *sk, int how)
 {

-- 
Philippe.

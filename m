Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BC46444
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959222; cv=none; b=ar/5FRKKloREmNFF8quCflMJGNPU9WETV6eLdBIKHx8KIljxhU260lkvo4gMp9NkZmP1rwPkqbgxXCGUzkJg7MIAdZN7Fden5bozYVEnO3nMgpFeaVsOErh1Gif/KTmYZY70iNIxwgVxNhXo9Vo5kqEd5RrL8PvGHdiG13RaNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959222; c=relaxed/simple;
	bh=EUeshYGK3QBaPY9cwTM+rB5D1VN+nCQV7nqYMzYJJQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DrRx+v3YjKFGqfuYCeXTl1qaC9J8QlC8VOaBI4bJGlCPjTXb3P90wfvUcSqdbKsIhFL5Ca05X4iACo9pcRbHsZniLipHhN/4PBXLnxQ+UZ8n4itHvzPafD0kMJh3GeMmxVoMMuBtyaKeuJGPXxgWxc7mZL2nw1ub8QjqSxujWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so27400095e9.0
        for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 02:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959219; x=1726564019;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXPWnHlRrfH96uuNOAo2jWOeDft2JJ4J40+tSsbLPkI=;
        b=koU5431otNavXu0yG8MPdO6NqdJX2GlAZT3rRyH6c5t68qipwr55YFiJbIopL2rVhV
         vlzs860IPLeb7Y4j9NGFGwKph54CQX76l1hzhqyzfgP8zy1fIYwZsjx1R7Qeb5oPwThP
         WhQ58qkm8pAR0GNvpXG9dZ25jajv+0dcnkPUAnGC541PQY0urXbGUhKe3p83ILTOx1aM
         uJkhgw56pI0Jq5ufQdO+k/rmJDmqIgW9g3o/sHS+nnsVCQcXHiBpzNuM4LdiuXnc19OL
         xForIKNVMklPUjzMnvb40MJqVlBKh6r9q8cyuZU0HXa3bY0E8qMHxA6C7KtXoZcVIZxl
         +a8A==
X-Gm-Message-State: AOJu0Yzv94RxZbYpGblikQgd4NGyJA/gbUN8HrYrfq3U/yYyCOLzaITQ
	ACz1c433BT+KGhnqOVeG6wiyQzNb1wpjYJbToYlkUKPTJzyrL4Dv
X-Google-Smtp-Source: AGHT+IE9vpBQca9U8Tg+OKs8L+SwZp5xBfm4mkFCHOsSECv2DlO5YV6Kdwjl3gP2nUdj/GMSmeYvoQ==
X-Received: by 2002:a05:600c:3b9a:b0:42c:aef3:4388 with SMTP id 5b1f17b1804b1-42caef34492mr77666085e9.6.1725959218990;
        Tue, 10 Sep 2024 02:06:58 -0700 (PDT)
Received: from bogeyman ([90.121.115.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21cdfsm103951285e9.10.2024.09.10.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:06:58 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail 6.10] x86: dovetail: Allow multiple HV guest
 extensions to be enabled
In-Reply-To: <05df8b68c3896b4fc8fcfef5a2cf8953e453d05b.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 09 Sep 2024 16:51:21 +0200")
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
	<87jzfqxez9.fsf@xenomai.org>
	<05df8b68c3896b4fc8fcfef5a2cf8953e453d05b.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 10 Sep 2024 11:06:53 +0200
Message-ID: <87ldzzkhci.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

>> 
>> 6.1.y, 6.6.y and 6.10 series merged, thanks.
>
> Thanks. Might I ask why it was not applied to 6.11? Any problems
> detected or just forgotten? 6.11 did not (yet) exist at the time of the
> series but the patch for 6.10 version should apply cleanly.
>
> 6.11 currently still has the problem that only one HV guest code can be
> active at build time.
>

This patch is already queued locally for 6.11. It will appear when this
tree is rebased on -rc7 (soon).

-- 
Philippe.

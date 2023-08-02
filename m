Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A5567F
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 09:01:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF498C0004;
	Wed,  2 Aug 2023 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690966874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKUeIl8oged4sbp3bfngbd6sURv80RPaUXDA6DPyDv8=;
	b=LVwaXKxTDIaj6C7eDjrHCp8lBSrI6sZPcL1dRIa63tCun25yT0L2UO4Q3ZqgFDPmva7GB7
	4pLgDExCsrV4Bybr1ayZTvYZqvo4YzbLSxRHwtN2qCx/zzmcoJ+PLNh7U8I8r45aqIZtQn
	/g/60oHHTXReYjwQciCnt8BHMIB/spK8Ck9uDXpc7u7J/KTp9t7w7D3u24W83ckhdbrEeU
	neREh2/8z7MhnpOb5t8x5nnSPuUHNcnE4l4RjCkvouBshNr9fZ/wrkmTEhx61WrQx7u7Ey
	BcOpn2rHmmhTC3+5mLNx9cB85s7ZQDccrSLVZSQZRIk5nD+A2/y5Kvry0SSwwg==
References: <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87fs51evhn.fsf@xenomai.org>
 <DM6PR14MB3871735C1528F455A73383ABA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: yo sang <stlfatboy@hotmail.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: data modified by second NRT write with same memory location
Date: Wed, 02 Aug 2023 10:56:43 +0200
In-reply-to: <DM6PR14MB3871735C1528F455A73383ABA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
Message-ID: <87bkfpes2u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


yo sang <stlfatboy@hotmail.com> writes:

> Thanks for the reply.
>
> I still have several doubts:
> 1. it's very common to delete data right after calling write(). Data should be completely copied to ensure a successful write() call. 
>

Except that your code is simply not doing that. Please read it
again. Hint: this implementation introduces sharing by mean of a
pointer.

> 2. The fd opened for nrt is blocking by default. If I'm using un-blocking way of write(), it's reasonable to maintain several distinct RTMem instances at write end.
>

This is not the point in discussion. The issue is with the broken
indirection the pointer adds.

> 3. If I modify the RTMem class as below, the result is correct then:
>
> class RTMem
> {
>  public:
>  	RTMem() {}
>
>  	RTMem(const char* data, int size, RTMemType type) {
>  		//Data = Buf;
>  		memcpy(Data, data, size);
>  		Size = size;
>  		Type = type;
>  	}
>
>  	int			Size{};
>  	RTMemType	Type{};
>  	//char*		Data{};	
>  	char		Data[256]{};
>
>  };

Obviously it is, indeed.

-- 
Philippe.

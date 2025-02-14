Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10B155756
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523663; cv=none; b=i0vcrtzzhb78v3hA+17YkJX/GLB1TBUik+yQ1rD5h10F46R66DA2oQjQ7Gc3Rqwewrh5pWiuN9osZpmAk08Dlhxvz82c6q5TNM+skj0fP/FUM3IOUVg2xm5MDBcqnzTmNHU36r0O5najWM0F6v4x571nz+qt7xFqiFNMcMbeK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523663; c=relaxed/simple;
	bh=W4P5toMSr6oZB+U6/+4Zo6zmOfY64PqE55SbSdYrebo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ipVCMt34TuYx2KEcpk4DoWp/UmlhKc/O0xneWCPusOIuAXenWgKSQa3vTAw5Ejwxr3cAoYy6szMwjoizfsJ+K78bW0gHzrgk/U/xDaKLGfa11Wxuxwx0KlMpTRgMyOsLP+UM/JlslP3UQvClAiVvhrQEZXa6OqLCw8ceGXiabcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esiee.fr; spf=pass smtp.mailfrom=esiee.fr; dkim=pass (1024-bit key) header.d=esiee.fr header.i=@esiee.fr header.b=B9hqYUBM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esiee.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esiee.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esiee.fr header.i=@esiee.fr header.b="B9hqYUBM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so12712975e9.1
        for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esiee.fr; s=google; t=1739523657; x=1740128457; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi6BA+6sse46rPllGtwjfp+PTu1hh/wwg6h392jsp4Q=;
        b=B9hqYUBMaSsJoflxip+Sp3IW3INUAa90XqdnwsNYXkbvbc6SdI3ZgO/ZYCOqA/c439
         O8m8Cm9E/n6Q9XRBH4O0BtQrgwnAMfzs8JjMq2ohHyKy+OvflWhBiswkWO/xeaaxLYPq
         M5FLoGV2A2duUAPoof6gvc35GUPC88zWCJ6Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523657; x=1740128457;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6BA+6sse46rPllGtwjfp+PTu1hh/wwg6h392jsp4Q=;
        b=nofG/6u+HMVYpM2tFLzdoG68+Om0L+BXRMH4yngCPxZVI7i0vUAwS362IQEQh05Mez
         vpdEW0NsvCvBY6RS8NfVndDj3m6r5Jbv5aQ7q6B+A0zxWTShcbBqyL4JWDPcZZY2PrNh
         c2NZ21k+S+QYE+UiTVhErhGXnUt/vzbb+QpOyEpSZiPePoQ3nPuS86V/IvEB7rcbVgiu
         tGCq4FNStSmwoJuLjux2JHVHTOILsITjQh4TWXS4i1wGO/dELGB9r81qbXGYyKLh8q1H
         CRn9PTXn6PqvMlZh61PO/P+JwWAtnareZH9gEIrAVjEp/zU/GAT+/LzYDKVqco0kEIQf
         7FyA==
X-Forwarded-Encrypted: i=1; AJvYcCXWoQY971ueMo9O25uQSV4kQ5egBcsxcsRp6ce+tEY+8lcBfBoAP2vk4UbJuDFCkcChM6wd2X2g@lists.linux.dev
X-Gm-Message-State: AOJu0YxCICU1FU/3+f9rfsrFvgnKATkCkkeZLAOAMwSmKHONHlZBkEPx
	JFFs8GpbIx+DlCB8eMBfEL6zl5xkLx6I1wAxwe/BUvHf6o9ekYuTB2ml9rBjhxwQ2djmvyKNDB5
	i
X-Gm-Gg: ASbGncsA9Ghnj7fTlSpuUWCugVXrqnW8q859bD6dFabf8hcX8JgIKVl+vrvtsc+kCXs
	ZM9qtA0NJusSPzE090sZ/PXrQnOQaUvu5oJQwKlAqi4jxuL+Yeiy3EQU8Ij9cGxGM7KTadtmCv0
	31CchP5u0NDB0fC4aqx8bIajEx9HfJvyzkokfOR2eG/S8+k0oXfr4golpXX7dEvQ1J8vxZ5WgX9
	FVG7ns0H5qeuRcZzRcHuo715Kg4Cd7VBd+g70aLX+iV6yRZRn+oq2K+VXegAH7E3kLn4zaJtAMb
	h17cEBst9fhfXRla3+E=
X-Google-Smtp-Source: AGHT+IH9qhkhC04K+KeM5yc0J1NuNzu3gn6Jm6Ad1tlGv6t94xxOjl0UCjPkeKaqzqOYot4+eaXcNg==
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr11228611f8f.42.1739523657262;
        Fri, 14 Feb 2025 01:00:57 -0800 (PST)
Received: from [147.215.40.84] ([147.215.40.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm4044331f8f.70.2025.02.14.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 01:00:56 -0800 (PST)
Message-ID: <672f66c8-fd31-4620-8b0c-867f85a57d6e@esiee.fr>
Date: Fri, 14 Feb 2025 10:00:56 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rpm@xenomai.org
Cc: remy.kocik@esiee.fr, xenomai@lists.linux.dev
References: <87frkh0vvo.fsf@xenomai.org>
Subject: Re: [Xenomai 4] Compilation issue
Content-Language: en-US, fr
From: =?UTF-8?Q?KOCIK_R=C3=A9my?= <remy.kocik@esiee.fr>
In-Reply-To: <87frkh0vvo.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Do you mean that there is an installation issue ?

Do I have to manually copy the .h files from 
$KERNEL_TREE/include/uapi/evl in my /opt/evl/include/evl repertory where 
they should be found ?

Rémy


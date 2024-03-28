Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50715C0
	for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711593089; cv=none; b=HGUNDL3ICeHqW2lX3ey5uF16LduZYUU0NRpGFCzxzSXLrwA5o3pskRXx8FJ/3KM8k58PZew4pJtMLHJyjZk7XP0SzccgYVldL37+Vm70ypljf/ahu+5wxmdRU0ADWb3cp6imuOPFqz9p9KuWI9KEPlQV9Ip4MkO0cqaarK4ksi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711593089; c=relaxed/simple;
	bh=E/5bnw/jJgoH38qgb0sDsVS83oWw7Vh/qrFmBDjPpEs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DrcwcLmJIHEUc6Fvsk71CPSQ//hJGZa7F+JJHTPZidWx5OWp4u5vqnR6wIGGMUHBiwhqNsY5NdB9dleJ/dv2ubWnyujQYfuE7t5YluDN0Mm4NqE9xXot8nH3rvybP1hG9jePPdEtYzQgPzV5MTfWcyCu9MjAvStKin7vPjWSUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doWIEjmy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doWIEjmy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ea838bf357so480046b3a.0
        for <xenomai@lists.linux.dev>; Wed, 27 Mar 2024 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711593087; x=1712197887; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/5bnw/jJgoH38qgb0sDsVS83oWw7Vh/qrFmBDjPpEs=;
        b=doWIEjmyyZGD0BJ79TsSgujdf+311p+JW6BUBVwsgAnb0yWutsN2xz8XVHoGBZHBT+
         M1gWb1wN7ApLDdor8J4yjRyk2V16uTs7chCM2OHQEfYt/gXRwQ9UyJnImEeDi698XX+s
         EYHWaSZET3XtT0udwPTm+Y/VWjwJ4033OZyBMtS0AV0c5n1Ok5jqACV8jvJdfHZb2gvm
         FFYUWIAeH4Fr2fXqtqIu14x1jA34icoM00cK5WGeUXgykPWwxH2OHmD55ZQHF/AIyWjK
         a7ygahWEhD1c1iLYLq1wj+LLrj6JS+x+a4YtWobiWaNvoDLxRGsrqAStw9eOaNDVZCJ5
         DQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711593087; x=1712197887;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/5bnw/jJgoH38qgb0sDsVS83oWw7Vh/qrFmBDjPpEs=;
        b=ISAPF+vCp+0+qt9nYLk69U/rWPqfKDCk97JIKdqZMq0y9ZB0dfHCTm3NjViTUt8rH3
         vJnb5t4Ao2DJiC9VOMrGq4HDHqSLQ6W/XuCIK/D+9HDhSn537JxcoOCGXNXdtoOS6zKK
         dbL+VjTL/PP/SyCxzHv3upqE/mo4RilxRtDwGwtt+5+qSD2cdcmVE7nUNd5AKOCNhF/9
         KQnkBUqJ2Ne/xvlfV6J3otnXqDisX7LaOfongDSLPrlO49trPuclMijT3Snmd3yhnedU
         b4EumvDXvjghJOb9Faf2gdcBgJFb0irlz2B0hujFp7bvMsRxYOmVryJY0iZVQRMO3Qu3
         0bMw==
X-Forwarded-Encrypted: i=1; AJvYcCWIDu2xmBH0oBtJESaIv+86eDuyD0cDCc8XubRUoed5fnyFYN0QC9GJ79H1QxT4lVt/SDgt2O6mlWFHf1mF5eLG4zC4s1gmGA==
X-Gm-Message-State: AOJu0Yx1qU9WLkeRK911jIRteM0zxzyANEQwfjFyV2X649qQDnJ0Ry5J
	atvMGROayb+LIs93sAsV2oOeVtLj8yrM9BF0LRHqHWIHuymgSA3V
X-Google-Smtp-Source: AGHT+IEkcf4fiUpJYVUGzo2BkJqIMYXR5G+Ex9FJmaqiMb8PBeENJUAOD+kIf1+2dOO/MoCGdjIp3g==
X-Received: by 2002:a05:6a00:3d47:b0:6ea:7f6e:f451 with SMTP id lp7-20020a056a003d4700b006ea7f6ef451mr1995369pfb.1.1711593086993;
        Wed, 27 Mar 2024 19:31:26 -0700 (PDT)
Received: from TYZPR04MB6425.apcprd04.prod.outlook.com ([2603:1046:c09:198f::5])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b006ea98271e43sm245756pfa.144.2024.03.27.19.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:31:26 -0700 (PDT)
From: Sam Chiu <ruiqurm@gmail.com>
To: "julien.blanc@sprinte.eu" <julien.blanc@sprinte.eu>
CC: "ruiqurm@gmail.com" <ruiqurm@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Topic: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Index: AQHagLb+vHNTJeMCykieOw9YuxCNQA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 28 Mar 2024 02:31:24 +0000
Message-ID:
	<TYZPR04MB6425188BB84FE4C65883656BAA3B2@TYZPR04MB6425.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

ClRoYW5rIHlvdSwgSnVsaWVuLiBJIHdpbGwgZ2l2ZSBpdCBhIHRyeS4KCkFkZGl0aW9uYWxseSwg
SSdtIGN1cmlvdXMgaWYsIGJlc2lkZXMgdGhlIGlzc3VlIHdpdGggdGhlIG11dGV4LCB5b3UndmUg
ZW5jb3VudGVyZWQgYW55IHNpZ25pZmljYW50IGNoYWxsZW5nZXMgZHVyaW5nIHRoZSBwcm9jZXNz
IG9mIHBvcnRpbmcgeW91ciBQT1NJWCBwcm9ncmFtLiAKCk9mIGNvdXJzZSwgSSB1bmRlcnN0YW5k
IGlmIHRoZXJlIGFyZSBkZXRhaWxzIHlvdSdkIHByZWZlciBub3QgdG8gZGlzY2xvc2UuCgoKQmVz
dCByZWdhcmRzLApTYW0=

Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD621DA5E
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568874; cv=none; b=cv6CDR+aXx6L3hwOME7mPDynUx9K+GpIID8zKrv0c6B5ZOQJKCdO+JkdZQrczzTsZvR6mxe1sDVZKwA6ooRHehSbvYXyk8zEj32Fb0/MZEg7PwYwi+lQETU8q6VX+v1lGaJ7IsHP19YdXLWofq3bU2CQPHdFDFlwrFt0AoTPK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568874; c=relaxed/simple;
	bh=nG/WQiS4lYcy7d3p8AGh8+Vf8q14moIYTbsEQm/iOP8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i/zUX58kda5Pf4p9hdpnWX3U3pgZp7dfkFE+Whr3u4KNy8b5IubGVueFOniZEDv5qq79cyDQSjuBQzrvswe74qhucBmNpPjIQurnRWF3zgJ6L1zuJfsatTihnEVfIM/DTQ1pWxdjL//vGDtLNp+Kyr7WCBUu4gE9BRoKmWloRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX9dZn9F; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX9dZn9F"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 89E70100002
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 14:01:03 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 889E1740040
	for <xenomai@xenomai.org>; Thu, 10 Oct 2024 14:01:02 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20b78ee6298so5415905ad.2
        for <xenomai@xenomai.org>; Thu, 10 Oct 2024 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568861; x=1729173661; darn=xenomai.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nG/WQiS4lYcy7d3p8AGh8+Vf8q14moIYTbsEQm/iOP8=;
        b=DX9dZn9FVlTIqKZvLDz0/ahYpNIP97LnrHW2r+Gc2rBtFJBspxoe6lzQt8yhyoTZ2d
         cRbvpurezydHBayLtV14exfxodfsnwAPquztkBdZD+y3DrV/9mf0J1JfoQZ/V2+9u4BV
         BuyNoXdgQ+E3I3jcxhr8HHGGNPv7CB8zX+FbqZwn2UrFEexivsmKJ/JO1303/JDnxJn9
         ZypiQS2nDz4kBmm7m9nKZ/IoC57KnGG9SiB/RpVtL2zqpjOEvK2Qn1KqwAVqqotklnRF
         WW4HWUDQWenYVooUeCts4hBDfMuBsFXwxQO5hHMAwyuEiEmIUi17pS73DqbHbCu5Pjtg
         AI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568861; x=1729173661;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG/WQiS4lYcy7d3p8AGh8+Vf8q14moIYTbsEQm/iOP8=;
        b=KrbNjkad8lpoJOTBdxUMJMk5/wamxuIJ4j/bhQQ3w/j5ad/Awlz+nDRtzHLFI+PKTf
         zBie8MPoKhAodVJvUVZowJpOIm+i2N0nc//opGuioP6nl9FHAJMy/iGogcyLKLbLeUBJ
         mzkGHN/8o7Zj+HslvHSdPd5zFg00otz1OiZ98sQArnxeEZEy/I45XR27lVwDn1AII56t
         WQRzyNRJDHlY+IZGm+pRfipveqftGgi1eRMrrF56fisaxyKy6pdNCDEfF6l9AeZiPY4X
         SzHFA0iV1BHhBF/D8oiRIqjku5KhMi/Dcl5E4Lz75PZ+IplWbAGVqLM2JNkg26jv1nsa
         RTgg==
X-Gm-Message-State: AOJu0YxfZu2ryUuKjUXQF79sclH+dbDYjhk+hTVVnh2FIFeo/wPkiqy6
	c1Ec24wMsr76GIYh/2ZDbfITHqOSesjKPERQyeMDi3E0JF+V0yg9bAtn1p/Y/og=
X-Google-Smtp-Source: AGHT+IHu0/FG4+H8m/ycYIciBepQHBIDjm5B+pyl89w8CkZw2kwO4IDcMx2T2dSrhhMlQfCq3RT81A==
X-Received: by 2002:a17:903:32c7:b0:20b:6f04:486a with SMTP id d9443c01a7336-20c63747072mr86589785ad.35.1728568859942;
        Thu, 10 Oct 2024 07:00:59 -0700 (PDT)
Received: from TYZPR04MB6425.apcprd04.prod.outlook.com ([2603:1046:c09:198f::5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e75f0sm9805545ad.180.2024.10.10.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:00:59 -0700 (PDT)
From: Sam Chiu <ruiqurm@gmail.com>
To: "pierre.ficheux@smile.fr" <pierre.ficheux@smile.fr>
CC: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: POSIX API for EVL
Thread-Topic: POSIX API for EVL
Thread-Index: AQHbGxpBTqu5yAsLaUmrMg/HUd/roA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 10 Oct 2024 14:00:52 +0000
Message-ID:
	<TYZPR04MB64250B7A13A16179B0044F4DAA782@TYZPR04MB6425.apcprd04.prod.outlook.com>
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
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of ruiqurm@gmail.com designates 2607:f8b0:4864:20::62d as permitted sender) smtp.mailfrom=ruiqurm@gmail.com

SGkuIEmhr20gYWxzbyBpbnRlcmVzdGVkIGluIHRoZSBQT1NJWCB3cmFwcGVyIGZvciB0aGUgRVZM
IEFQSS4gQSBmZXcgbW9udGhzIGFnbywgSSB3b3JrZWQgb24gYSByZWxhdGVkIHByb2plY3QgYW5k
IGRldmVsb3BlZCBhIHNpbXBsZSBkZW1vIHByb2dyYW0uIFlvdSBjYW4gZmluZCBpdCBoZXJlOiBo
dHRwczovL2dpdGh1Yi5jb20vQlVQVC1PUy9saWJldmwvdHJlZS9wb3NpeC4gSG93ZXZlciwgaXSh
r3Mgc3RpbGwganVzdCBhIHRveSBwcm9qZWN0LCBvbmx5IGluY2x1ZGluZyB0aHJlYWQgY3JlYXRp
b24gYW5kIGxvY2tpbmcgZnVuY3Rpb25hbGl0eSwgYW5kIGl0IGhhc26hr3QgdW5kZXJnb25lIHJp
Z29yb3VzIHRlc3RpbmcuIEmhr20gZ2xhZCB0byBzZWUgdGhhdCBzb21lb25lIGZpbmRzIHRoZSBm
ZWF0dXJlcyB1c2VmdWwsIGFuZCBJoa9sbCBjb250aW51ZSB3b3JraW5nIG9uIHRoaXMgcHJvamVj
dCBtb3ZpbmcgZm9yd2FyZC4=

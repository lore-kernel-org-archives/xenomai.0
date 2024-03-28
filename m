Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618D54656
	for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615342; cv=none; b=EDOhyXg3w9VgL2XUFBcjgDrZvT/l5CJIOHYN2F5RNnIo3q3qFr0vUXsN3EKgAffMgupDp8TJ9HUmeu9EWiNFYiW8DQalskodbbEYLyWSGBtBeD+fm8i4eiE7ZomSjjE4lZ5WS+gHZ83h6Q09wEvXsDKRzKuh8CI5ABVXIhcDWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615342; c=relaxed/simple;
	bh=ieWjQrx++RyA5FP5y2gdnNQwXsxkS51pMHEOA7998t0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JmcWqsKt+YIJiv+oaC0jfbsMD4MN4NPgTNP/ELF8YgkNB+Jo3d/cG+SkJXT9QSWemj13lkBJCUbsDfvSU0UYjy1l7KezdiNYsheVV00uX6lWSAh6U16T1ka59h2wo8jOdg+JTqtW09cIXT3ffpD1lOa8qWfkkPEDTaWkQA2qgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU0pydDy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU0pydDy"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a128e202b6so215575eaf.2
        for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615340; x=1712220140; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieWjQrx++RyA5FP5y2gdnNQwXsxkS51pMHEOA7998t0=;
        b=gU0pydDybD5b2lULc9LMJsSeIxqhrcHSMSS2YjyAR9CM0KSL+dbk56NUnn6fqwdvjF
         K6aLASxtBQHYJ62awjDoHBy/9Pi/1K07icKu0ldq5aOvza+6B4YalLGP58pIz5QWsX4y
         G9vpOspSju6P7eyW6SU2VceL3Xd2zbPupZK8XTQKIOt8PmKolR87cEp23Cxw1leJKOSO
         9krYGraL3xBozOfhmZkCylsj5F5+7raDP5mXZRVFQmTO1ItC5V351/DbEEVLsUcHYvhs
         TxduB1m+kjkL422qS3eo9d1MYhJG6xCpcfkj+qka3s3EU8KSaCPjek+mgA6PHnZkIq1U
         BEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615340; x=1712220140;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieWjQrx++RyA5FP5y2gdnNQwXsxkS51pMHEOA7998t0=;
        b=EGTKlKpIwnfzuQ+VXQJW3wimxpDPLTPIrhkl054Ny2lRKQE/+ZfmB1DyWWreD/YrGN
         zOQjA9c62JCBGaE97+1emiHakztEwOlzBu1iPVVjJGbTN2yDdbyAa4snZORuKvean0F4
         fhMY4mJGB8LkkrpjzOVX0XBB905Us3UjgJMQGgRk6rgpK0gCfwfQa886B4ys3hdBnEH7
         h19yo363mlEYjKGa84hbAST/nlGStdW8hmolIrprEnqoPN99QM8HjhM1vjtOYdhkPRDX
         hsEOUcGZMYceVRqjqqwrlRLH+qk3E8+359s0kjgJaGMi8184pTlzDEqjw/XwAUWvNajh
         IxBw==
X-Forwarded-Encrypted: i=1; AJvYcCUDIygc7hflxRMgmIogVSVTP3i+QjNdmXBA6b5434hUHQqkFWiBhWGJsQe0AtL5gQftJZMpQQ9eVJoAPZF5iRK7cumbuqi2kQ==
X-Gm-Message-State: AOJu0YyunELUw1nZndhUP8ml2lvpkXizTwdc1N+A+cGee0S9hm05KOGr
	0z1qtUgHqxhUzuc8hs8lHDAhexMMRdtqg/ff6Dv5vm6Chj2Ck9N3
X-Google-Smtp-Source: AGHT+IFb9bojVDtPTKxzXFRt5BgrPb6fAVJuCxZw0mU1qL6QG1GzNMFudGcItrPElWjUPppvz2Cgtw==
X-Received: by 2002:a05:6359:5fa8:b0:17e:9c8c:2c00 with SMTP id lh40-20020a0563595fa800b0017e9c8c2c00mr2221774rwc.10.1711615339314;
        Thu, 28 Mar 2024 01:42:19 -0700 (PDT)
Received: from TYZPR04MB6425.apcprd04.prod.outlook.com ([2603:1046:c09:198f::5])
        by smtp.gmail.com with ESMTPSA id q20-20020a635054000000b005dc120fa3b2sm792937pgl.18.2024.03.28.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 01:42:18 -0700 (PDT)
From: Sam Chiu <ruiqurm@gmail.com>
To: "julien.blanc@sprinte.eu" <julien.blanc@sprinte.eu>
CC: "ruiqurm@gmail.com" <ruiqurm@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Topic: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Index: AQHagOsYga2Phqf+DUOn5aHfynxKTg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 28 Mar 2024 08:42:14 +0000
Message-ID:
	<TYZPR04MB64253BA0360E2A94A377B68CAA3B2@TYZPR04MB6425.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Dear=A0Julien,=0A=
=0A=
Yes. Maybe we should first isolate the real-time aspects of the program. Th=
ank you.=0A=
=0A=
Best regards,=0A=
Sam=

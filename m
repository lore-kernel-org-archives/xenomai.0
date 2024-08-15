Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF97DA78
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728636; cv=fail; b=Ev0aeUqa4x3MGRFGJ1OcIdIjprAx9MgBKg7tmWAAKB/QDgssc1QJCWJxOHriOYzKGFfDwHil1NIoJvN/LxPN/9b57EwlMdqyKMpj6dUDO+8Gg6jD1+cpuk+eSQPRLYEATMH9vOww8tkZHIi2Owq9w8pl0vjCFyzDYdnUpSATwAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728636; c=relaxed/simple;
	bh=UYsuuqJA16WWjwzamAyU3w/5cb4SBGmoxsSiD+fachM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQBc0owQ2meuPGjej9iv2F9PyC8ah0PKG8uaUJUFja8uTRkOzic8LSeJJq/eXnL6slMazKosbnvPkPjLZmKds/ubj4AvvK+Yjq5ZaqCu2NYgjrLL5z93AR+dwXkUPTV+zRrzx7IRxI0mXB90rQjl+6r7Mmk2PE6f7OaG4bm3fvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Hpa7uL3r; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Hpa7uL3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8LsuZivDDMe/SmMV2Mlv994i/ENg62JmyP1ikeOkd3LuImNanBQs2Lc8S6Lm058zoW++Rs0DjjKZ/20NuLk6iAvc7l7bCrRse6F8IK+Qa0Kg1QgADdH//BkVXEMb3TuHjmIhqjqX4qI539rConrDvw4SNwcZWxowiGE2qjPze+IlmiGYlPRbw2iG7JfLCd8Z96BhKxJhpg2avyKo69T9oE5OVW0JvpiB4UKPx7pOaEQlIrVufm8InelpPYn6Fl082sxaj8zJjGeRuN8MYqIMFUAOszwttQctUfDNZanJEOOU9ESn6HieUIQmCXoAqQDtvegvzaEJv5CbevBnw/gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KoVcT5Lv0+HJGx9UJa9YlT6I5VbOVXPbFbr6zxNYuQ=;
 b=JmivpBiYEVlRE6zo/A6ld+ozQLCRI128rV+o4j8+lo0nsqK6wQEgez1WAUJbkBPYFLvJXZZ8c/mvgkP89rQtKnr4MSqn4byaI63CN6SKGJ1SR5wWrc3ZO4EfBISE3GP4n28Y6Og9koQ6LI6bKw5deJ39v6gZjOg6d8DfpJtplnkWA8lAjuYSNs3CRKLHj30nsYM2YJW8/iGQRG1gYqJ+ZoMdH8bNadp74Slc4UvF6Rhnmtyh7E7MX/YRKstDdMEd6yrKdX5qzZh4uIld4U+0s9y1Uts/N8i/IIl29i/5pvkl7qmLZgmET1y0SNiAhq+T1cqIeo/Ew1iHsWhshqWsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KoVcT5Lv0+HJGx9UJa9YlT6I5VbOVXPbFbr6zxNYuQ=;
 b=Hpa7uL3rR1ViFY7wHIOEVecKC6I6FKzBYaDNEJBXGHg8Ss6x4hEyCruQJKbJ/R+yF9MqllHNdIvN9VSzM2mNepSeYm5nl0p8VftJxeeePYvgcN9b1Ib0kdcomjuLhCESUljai4AXdkER4Yt8CoifZRv1HNI/2rA7TXautOROGQz7UrI1BstPkY+RQkGVnX+l0KEva/cdISxFNjHbjlWPD1WnKDPeqGU2hyMr3O942h+UvoN2ogkWlsiqdk6S234meYDzpM+HCC1DYS4h3/0zJ2W3nB1WvHwWiGS78+ZyQAHLO9Tlnw6NEf+r9RYgTVuLD1xYz7z3h0g8HABdVBg8Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 13:30:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 13:30:28 +0000
Message-ID: <351a2c7d-4fe2-43a4-ae87-045b194f1919@siemens.com>
Date: Thu, 15 Aug 2024 15:30:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread stuck in IDDP sendto()
To: Richard Weinberger <richard.weinberger@gmail.com>,
 C Smith <csmithquestions@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
 <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com>
 <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
 <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com>
 <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
 <CA+K1mPF9w=QuXFpAsgZQqRj8OjyHNzw9znmpUGNSAcRFgs9hgQ@mail.gmail.com>
 <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3543:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a220382-2e4f-4c10-c026-08dcbd2e6dc0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmduTGc3dzUvRElpaWZTWmJiMGVod25URjV0R3dPUWdZMVB0a1NNbXB6Z1Ji?=
 =?utf-8?B?cStjRmNPTklDeGlpV2xPdDFaRzNKb3J0bjRHamdhTFV3bDJXL0JzcGM1U3Zp?=
 =?utf-8?B?TVhTQmRsWU5EZVFtWWlLVm5sMmlEWisrVUJhbE1uUCt2YVRqVW5pVmJZZG9M?=
 =?utf-8?B?dnVmNDA4SXQyUG4rOTcrZ29YMFdJTU15bzNYSjZiN2hDeGNKZGhnRmNOVHlW?=
 =?utf-8?B?a1VzbWpLQWlWWEdwZVQ0SENyYm5ta1RUUS9oZHVXN3FPblFSdzkrQXZ3MzNL?=
 =?utf-8?B?VzdtaTNsWUJrQjBwNVVSRTEzMys0M3h1bTIyb25OaExQWUlCU1g2ZEkvcmN5?=
 =?utf-8?B?VnJ0MlphWUszWlBCbUluVVRJQm4xd3M3K3JyaDkzaTVHN1NZVStJK05qa0RH?=
 =?utf-8?B?NjEvdStLczJ3a0pSaHZiY3M0L3Z6eGJmRGFZL3pWZkM0bzdaazdEZHhLcmJw?=
 =?utf-8?B?RFJsMjFzT3VrbEVqTzZKaklWeWs0RkhsbC9wVkQ4QnJFRkErN3pSTmpKQ0Jo?=
 =?utf-8?B?OTVwVW95SDR4eG16SGFETS91VWtUOEhNUEJJVXdYSzdCVVpyNm12STR6cHh5?=
 =?utf-8?B?Q3lyVHEzUDJDc0ttMXdZaGhrV1pVNUhmM0hFK2dNdjZ0QmJ4aXk1ak9XY1k0?=
 =?utf-8?B?VWhhYTVKYmtHVitKcm9jNVg2MktOZjNqUmE2VzBNV0JrTHVIaHVRb3BzZDBM?=
 =?utf-8?B?WW41eEEveFpYRnNsVlhOOWpZdEJzVzQ4V1FCNktnRmMvMEprUUFOZ0JUZnZq?=
 =?utf-8?B?RWZsVE5kdjJiZkVoaGIweG93ejUzS3ZJRllQNFVMa1FCY3d0djRrYU1NUFAv?=
 =?utf-8?B?YUtEZTVXSStvWXFsc01LNWFrR1orNmw0bmM0djVWZjlwY2k3alpnL05GQVlY?=
 =?utf-8?B?SXJMZ2RKUEdrbGJqUjNZRCtaOXVHZHpFeDk0cHhWV1VzMmNJSE5WZHJsQUY4?=
 =?utf-8?B?WG4xNXZ2MjNaYlNWdXNkbHJTbEltWVk3NHpwMTlNbzkxQXNUM2UrVEhRU2tL?=
 =?utf-8?B?UjN5eW04dVl0VXdLM0t2enM4NncwVEdNYm81aG9URUFTdXROOE0rbG5aZDhQ?=
 =?utf-8?B?Q1ZkRE0yUi8wOWplSVI2TktaZWNNZUMzMmhiQ3ZxR2MrNGxhT0tTUjNaVWxB?=
 =?utf-8?B?bjNXdGtYZGc2elhzcHZCTDNBa1AwWUh6MU5RTStBUXdiaXI0U3FFM0ZZTnY5?=
 =?utf-8?B?MEJvZitNbnNUMHFWY3JXMXlaZmVIQjdLT3UzMExIaE5nQTYvNEZ1K1dCem9P?=
 =?utf-8?B?SitFeEJPay9tMCtlamtlSkdiVDhWaWVURTgrYS9ralVud3VDMENOQkpKcHQy?=
 =?utf-8?B?eGxocmM0TmR1RDA4ZTE5SFZyd1R0SFhOK29ybFhuUnQ1VjNmaUY4OGE3RFhH?=
 =?utf-8?B?bld4NWxwY0FvLzQxZ09rc1JUbjQ1TWdla1JvOENXY09KakdUQkd4bEdZamha?=
 =?utf-8?B?UWxCTHJnc3AxcUNzWkxOdWZ6RkprQThIajE2VXo1QlRWOFU3cGZNZWdQSkgy?=
 =?utf-8?B?bURDS1NKK0Z3QldaSEl6M0J1eTBLc1NDaWx4U3hVUGFUZllnYnRyTlpXVk9s?=
 =?utf-8?B?TnFZNkFuTEFTOW5GbjQzVzZ2eWswNW1neHVWYndjUjByblEzczB5cW5EWUI3?=
 =?utf-8?B?Y01Gbk9RQmZiUm16dVcwUit0UG9qakdhTzIzYi9rVGhaT21nTjlBUndtV29s?=
 =?utf-8?B?Q1RrNHZzU2srZDVBZ1FjSzBBck9VdUhzcnpLcGF5aDc4T29hOTN1ZWJvNDlC?=
 =?utf-8?B?MU9yZVBSTkJYRDFvVlF2SWo5cjFiNmpqeW5RZDlCbUNzbmFXaG9OaXpIWFpT?=
 =?utf-8?B?YXJFYnJjaXhMcGw0RGE5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXFkMFJqRHBmWUZOcnRJc0c0U253T3dkWEV2ZThOUTJmdU8vUmNnaGJvNzd3?=
 =?utf-8?B?THZkMXdWM0VCMDMyNmJQbkNybFNhMXN5ZXl0TjNvTTNVL3JrSjNwZEhicUpy?=
 =?utf-8?B?eEdYMGdKYzJYNmJHUHBEWUh2aHNmT3AzaGZJMWJUb3MzeEFqdXNlWHhuQXhr?=
 =?utf-8?B?bVdKdmlsSVdpTmh3aUFEUkFwaURYclpNTWFxQ0kvT1FmWEZtcjdEZjc5STNZ?=
 =?utf-8?B?cTdOaXE2bGFWSVR5QmRseFRuK1dRSUp4Z2k3VlBLRllDL0NiR2crTHJuNnJC?=
 =?utf-8?B?NklxSHBjKzhsRW5UT21nbU1yRHFvbWFWYml3SlZ2dVpWb29pZHFPY2VjeWJT?=
 =?utf-8?B?QlZIZGhRcG5PZmJvNjg3MjBNVEcrT3loSjRFNnlkZUJIcmt2OWREMml3K0xR?=
 =?utf-8?B?NE5wbVdwUU9lQllYY0hNb3J6ZGROZ2VSVWp0RlRCMFA1THYxVVNXUVNpaEFa?=
 =?utf-8?B?UDNvdThWQ1hMbTkvNm53QnpwOEs3TlRBbGlNL2VGZm0zUjdjazZJZEFTVStu?=
 =?utf-8?B?eERxczFhbEVETmk1S0wzZWtTVmxhTjA5UkliK3YxYVFmRkxJMW5oZkRNVEVh?=
 =?utf-8?B?Q0lMOEc1eHE0cm01WVJIVVpzVm0zWlJrN3hhTG5BOHlyOW84VGlHTCtScmZ2?=
 =?utf-8?B?aW5mazI4SXNTcVpKSjhtT3FjWVluUEJnM1RFM0hqWjBmYyt0WDVqa0l6dk42?=
 =?utf-8?B?aGRxKzYyR2VXNEFaNHhENDFPYmpoYmgvdjZkcUw5ZFl3V2JxYmg5TURhRTJ6?=
 =?utf-8?B?UmJ2eC9WUU1vUk5qcmdCckFrNmUrQkJubjFTQ1lYRkVjTURZOHM1cHZlOXkv?=
 =?utf-8?B?U29lSk1LM05JK3p5NGFaaFpoMGU3U0RHY2dEVnZKakRlSHAyVzJ3U3BCOEF4?=
 =?utf-8?B?aDcrRTZJWGRxbFdtN1h1bk5EaDdPU0RoeGRiSllMTlMvenlTaFhld1pZRXMz?=
 =?utf-8?B?QUtLYWFheFZWVDkvUzYvNXRqV3dnUVVCRlUvcXNVS0k3WjBiWkdLN0FFcU5v?=
 =?utf-8?B?bkFRUXJtd01pQWFkQXBPTmpaa2FFS3VERjFCMW0zcDE5M3Z5a09yZTExTW94?=
 =?utf-8?B?TnVGS1pIZmNTNnpDTDNQK1lzYm9BUUx0Z2s4NmdseGVmV25RM0R5b0xkcXgz?=
 =?utf-8?B?Y2NKUndsZkczais2azJwTjlMVWZzeUlwT0VjN3k2K20vMVVOYlQ1RDVJdUJW?=
 =?utf-8?B?UnE0dTlFMHVscjA5R25TdVNUTG9icnQvS1ZldFpaVHM0YSt3dWhhd3VFNFpT?=
 =?utf-8?B?ZS9qazNjRUF4R21RSmhGZGNFQ3FHOExvcEpwWHdTNzJLcEQrZ0NrcGNUU2Fa?=
 =?utf-8?B?YzBkRHRBajZEUzRVdDRBK3pEOFlIUTU4aElnakpIZG1TSzdkRDFNcXNsN3kz?=
 =?utf-8?B?TERETFVpNUpPNUtSRnFHRlVGVkZrakdrWnhYb25HQTJsY29uZjVZZDAzaUFk?=
 =?utf-8?B?UnREU2R2OHVoa2NmbkgwZnJxZjJDL3dMMFgrdHM4WlhlVUk5RmJlaDRXYjZO?=
 =?utf-8?B?Wm8yRnNrMmlqV3hFdFVNeHVhTlRVNWMrZTdnY2ZpU3ErUDhZd2tqdEJrVWVh?=
 =?utf-8?B?Vll6SWVmWUdtT0JTN1RnMDdlcmpCc1ZPcW45MTJhTzRNS2NOd3BxYXRDQUJX?=
 =?utf-8?B?bGNVYUV6Mk9TWlZyN01TRTFNbFpUbExSZytUWFc1NmZ1Ynhqa3BITFhITmI4?=
 =?utf-8?B?L0ZpeG9UQkswNzRUYXJhd1l6TllLM3psMFpHa3NvOVVSTzNIeklrUUZkb1NV?=
 =?utf-8?B?ZHVVWHZXOEZJVnpXMTVocy9Zdlo4c3NnU21zSTZLODZYa0Y3elE0YWh4VS8x?=
 =?utf-8?B?VnVWdXhLLzZGL3ZGMmVQdW9xaHVWOHZNRlB2d0R2Rnhub2JYbS9jQjdkOFM3?=
 =?utf-8?B?R3I0ZW1yTmtIQkVNRDdKN25hc2N1eXI1bHc4ZUdqTHB3THNKa21QNENOQVlS?=
 =?utf-8?B?SDRvVGZsZXR2TDZoSGNabW91WHpNQzVTQy9UMGw5ZGJmSGdLYnh2QmNQZjdM?=
 =?utf-8?B?ZWZnVk45cE9qUW0vUmg4N0xHYU0yT3BZb0dGWWZScFZObTRPU09maXZ5Q09D?=
 =?utf-8?B?emdXaU0wc0o3WTdPSk5nT254K2FJSHFqSHFyZU91bVkvWW1QSTdaWXZ6RXZm?=
 =?utf-8?Q?//97Qg+tJnF2bCH7oxJQmSyb/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a220382-2e4f-4c10-c026-08dcbd2e6dc0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 13:30:28.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++xAoxRXgbbKHgQdH5b3fvDp64FKNr6k3yyIY7kE2IDBViPwIwdZhTd1brGMLzBQis/Pb3w+9DmEtLXp9QMvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3543

On 15.08.24 10:56, Richard Weinberger wrote:
> On Thu, Aug 15, 2024 at 1:02 AM C Smith <csmithquestions@gmail.com> wrote:
>> I have a test machine which is exhibiting this behavior. Indeed in
>> this application the sender thread continuously tries to send to a
>> killed receiving thread over IDDP.
> 
> What exactly do you mean by killed?
> Did you hard kill it using something like tkill(2) or rather pthread_cancel(3)?
> 
>> So you're saying that all Xeno threads are the same process? So
>> killing a Xeno thread with an open socket doesn't do the "right
>> thing"?
> 
> Yes. Killing individual threads is always a challenge.
> Ideally, you just signal a thread and let it terminate at its own will.
> 
>> Some possible next steps:
>> A) What sort of a timeout can I set up? Jan you suggested a timeout,
>> but I don't see "timeout" on the sendto() manpage.

You would need to use setsockopt and SO_SNDTIMEO.

>> OR
>> B) Can you give me a hack to the Xeno code to implement a return with
>> -ENOBUFS when this happens, like Richard suggested.
> 

This still seems like a valid option to me. No idea if that wasn't done
by intention so far or just to make it simpler for the implementer.

> There are two more options:
> C) Use the socket on non-blocking mode, needs rework of the whole
> socket processing, though.
> D) Make sure that upon thread termination the socket is properly
> closed, depends on how you're killing the thread.

Thread termination has nothing to do with socket closing. It is still
the process that owns an file descriptor, not a thread.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EB15380D
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767647; cv=fail; b=BCpbM4XDt8Pa1aH1qqFwP8+rT7OWF6Jj0U+8LDwbWlx0ZjdOpgpgGTDDhE5rgGQhU/IhyJZI71Ey0ToMnHL9pk1zwRmHSqtZJECmQA02F/TIR0u2HZU1Fxk7YzD1LR5iNoFgQxYv+Mm2oQ5rRshKLm8SJJRMBwYq8nRTpEwalv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767647; c=relaxed/simple;
	bh=U/7yGNE7oYUX2SUQMfw2qbNvGqcOWK+iHOsM7exWZ2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNWhJD1ylXKiVNY29khzk5HWbMGDAITEwmUw9YsLQnOxUuof4IbcOjlpuTVqH/M7IQkkvBNZxbmW/ljkTujdYMFdteITwFYgQRTb/3LUhsy1kd9Zu2Ri9KQjxs6f33EHD6/gAygW2WuqC31jomNSDvU7MX8UlDNyOzwDBDoRAs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xyIhUbEb; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xyIhUbEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTRcZZkiQFr3NR9J6tgJA/jipwFncw6nI0oj2DZmfAHBmOh9lkX4Q5ueL9eyv1WSrwV/Cvdy2GXHNtGiG6qVxR48IOvB26WkJ9Z6EAS/D/LKSd1mUECVr1YKp+8LNv0iaqzmv+FqZMNcRqrWw6CM6P5jmnwr6UCwTXtYH2MSsls2u7iPsrxJ2iTJAS9wWj5QXHErGpMa6gP6Nv6EgNa+bYL0aivsuQEDULg386f08vwpK2xoTNaQyc1swhHvZHXpQj0PH44FJtBgdncTYCiw2EKZ9yZKQl8IPUB6XiAZTDuVdSmo1vXny4ujQYR1uIKsRBUN68GJLnTuVj/k8QxPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/7yGNE7oYUX2SUQMfw2qbNvGqcOWK+iHOsM7exWZ2s=;
 b=g4nccT/lV/5725CD4QS8Srr39HxcW3iRI0Wbw2Pory3sTx5Q8AxdCxtSdGEYEOcMvahU/OmcqypFkbOW0v6mNXOagmpfw1eRIUHeeK61A/Y/h5FEhWM/oRGCm142oQjD32OZK4d7lvIPm5t9cGM9FokjE3QFjys1FuEyzrPRkHvKKJY43IErxina88z5Kka4AWYCAnaHlHVjuohF0yNEQg6mxT3UiSAET2X9rFi4uqVM7aKnSh/vb4ujfchHEiJ3zrLS27oihIF6BWeDc8IC1P9hVbgIdYhNv3KkODo4dUKMkbh/Wv6sqw2ue0nMaIfORLe3bABoBEn39CWjJBSUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/7yGNE7oYUX2SUQMfw2qbNvGqcOWK+iHOsM7exWZ2s=;
 b=xyIhUbEb9fHZQmga+p5pEm91304LUfMtZOXtbtFC0lwRmbJb/Htddw5W7vnL7bk5CG0UhHLdbOPGwb7ZwL0Y7SyHZmIPo9npvFITuwc9m/h7y9mOWu2ilE/VqIzXTsHvuyQNFYTLKjKhkpqQ4g2fKVFzr0qjeTj6ufuK4KYkrNE66yuA0P6oGi5wHUJE5++l7f+1i5yHV2Iqnm0WQiZcZzs0EBJH0AMdl05PZ7s2hcBNeiiBeXOvefpxJBu7sKP2R7mtPq6i0VNQPCtJL11w6o5U5Dfza4gUeTj+avtrVT+moJ6q5Y2kKKN48TApAjZLPMtX12K/VQitDEsGGYlJ7Q==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 13:40:40 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:40:40 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: RE: [PATCH 2/5] testsuite/gpiobench: Toggle output pin in react mode
Thread-Topic: [PATCH 2/5] testsuite/gpiobench: Toggle output pin in react mode
Thread-Index: AQHaj9x/SfIKvoumC0yDJwVBCukhlbGiHayAgBp/d/A=
Date: Fri, 7 Jun 2024 13:40:40 +0000
Message-ID:
 <AS5PR10MB8173C97F715DEC0352BBE73193FB2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-3-clara.kowalsky@siemens.com>
 <01878c51-a76c-4170-bc18-51f631d0c938@siemens.com>
In-Reply-To: <01878c51-a76c-4170-bc18-51f631d0c938@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2763aa85-e1ab-44a2-80b3-eda0cb5a3587;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-06-07T13:27:23Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|DU0PR10MB5266:EE_
x-ms-office365-filtering-correlation-id: dbd52d71-bf63-434a-32d4-08dc86f76be7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTd4cGNpZkRmNEFPZjlQanAxWGZBemQ0dzVHdzFJcVJpZFZxaFV6dmVzaDlT?=
 =?utf-8?B?b3NsaWNEbFRHWjJrQmFyZTBGRkgwc29RT3QwVlhveThJOURxYk5RK0JCR25s?=
 =?utf-8?B?cUhCazE2SU1pdUU1Vllmdk14R1NPS0VZOXZ6M2FpeFZFS3Nsd3J2YVJPeVJo?=
 =?utf-8?B?M01yL1Z0OTBCd3ZXRTd1UGVOR3lsRXZCelFEeE9UYmdVQkZGdHprYnFnT1hx?=
 =?utf-8?B?OFh4NUk3U1RvUG9pZnp5d2RQaHhOeEJ0N0wwL3BaUTViVjBydHcxSkFYMEN1?=
 =?utf-8?B?VkN0VkdubUt2SURNemFFclFoK3l6d2ErK0F3RzMzYzU2SVBoanpmWTd3M0dr?=
 =?utf-8?B?bWFQc045azRDNTdxZ1VaRHIrNFBELzkzQmx2Zjh3c1UwUjBRYVlKbTdYWldH?=
 =?utf-8?B?bkZIZDFyK1lkck0yNEQ0VXhWSXhGT0hvRzB5aEsyYVFHM3RaUmVNdXY1WW5j?=
 =?utf-8?B?Nk5CQTIyTHVvdCtua0hmdUR2WTlGcEt6MW9nN0loQXh6dnF0dnY4aVRvV29o?=
 =?utf-8?B?VnZNNldQdUt0OXJQUHJVTStsbmtUUFRiaTZWYkJlQWEyQmJJY0VhRXNpYzBG?=
 =?utf-8?B?UmFwb0FRaEpMSjBMTDBkNXovbC9XYSs1NFI1MHR3MkRzZ3FsVkx0T2VYaTdB?=
 =?utf-8?B?OGQvbnh5WkJoK093OThXZzYyQmxkOG5TWlBucUpnYUNtZkxqdktHQTR2SnFv?=
 =?utf-8?B?VGU5RUV4bXFYUlVtaTBuMkkvYnh4eUdrS3ZRMjFRVVdHL1ZtcnhaRmhmVStk?=
 =?utf-8?B?RFAydTJmcURtRlMwQ2hWMERrMGl0cUhPUGlNYTc4d0JubXFZWXhJUXVJZVVu?=
 =?utf-8?B?VnpIRkFubG4yRDlzMUVYUzhURk1LYllyMVltZHF3UVM4ZEdiTWROSkpHSWtq?=
 =?utf-8?B?ZmMyLzVxNCtTSmY1TDNKTHNjMlBLQjZBZmR4S3FVNm5tbEg2MUdqc3FKUVdz?=
 =?utf-8?B?NStGckptMzluL3NuR1lROUFoNFZiWjJiOFJvYUtLK2kxY1QycWgwYkk3eWlx?=
 =?utf-8?B?WmkrZDNQWWE1RzhLeU5JbW85N0RndWN0bHB1UkxHRm5ZeXFZUXd3dnp4Y0FG?=
 =?utf-8?B?Q3NmRHpCLzN1VHlmYWlzRTN4L3B3aUQ5WFhnTEpra1RzT05iTGN1UnJOc0pn?=
 =?utf-8?B?Q21EcWlYMGs4WEk1OUc1NzJEQ1BJWWtkekcrS1VmdU82bW1BRUl3UjF4cnRH?=
 =?utf-8?B?cWxwU0VvMm9xb2c4S2EySlRtRmtJNVpRek9qcmY0NjlIQXB1ZGZhYnBlQWRh?=
 =?utf-8?B?a2phUzV4NHpJRmx0MEdYWUhYSlMxUWxBR29GUjQ5czZLcGl3Z2ZVTU5wWmhp?=
 =?utf-8?B?eUNZR3QrQ1NrMEpSYzBJdTJLUmN5MmJmK2EwVGRPbGlYWFQ4cEZLZ3IxdlhX?=
 =?utf-8?B?NW5NNitwTG4wMGJaQjhoNFlrWEh6YVV6N3ZkR2pGbERvVTRYdUhPSlZQTHF6?=
 =?utf-8?B?ZW1pNHZLeXczVTMxdWRzSmJsek5QUUpQcWwvSTRxQXprMFdoLzYxOVM4Ullw?=
 =?utf-8?B?UlYyNmlwNXRtVlNIay9ERkpjanhQSG00a0pyaTM4M0o4MUhmaXM5eEFteCt1?=
 =?utf-8?B?L3dubUtMaUhJanE5RkZ2M3ZsM0hjUms2ZWJKWHpKT054ekxReG8zUm9MQXhi?=
 =?utf-8?B?MWVCY09xbU9VZVI0U3dZU1Z6ZHVFQ1VWNHVhdkVZc0h3QS8xdm54VTNYWDIx?=
 =?utf-8?B?K3VlY01wM1NWeHMySTJ5dXhidXJDeTBmWFljMkEyc3dEbmEyU2FSZ2hLRVBE?=
 =?utf-8?B?Wnl2QUhiSEJQblRING1ScXQvVmpINDI1UUtPTU1ueEg4L2xUWE5uWHB5NUN5?=
 =?utf-8?Q?FHenJDkTI15O47dVn6jT4qWlFxQSucPSeyYm0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVlVOW1kcCtKVG5mekJpelFPQ3Z5QXlIMGRRelE4dUpjcFl5WVFoSzZDcjI3?=
 =?utf-8?B?U3JMQ2I1UjMrck9ubVY5MXpzbFI4NWZUaVU5VlhCUCtBbHBSZk0wb3NYL0Fh?=
 =?utf-8?B?Uk85eVZ6eGFvRFlkM0dyck5ucTMvL0VWb3hZQmtGT3phTVBlSWdwWnZLVWhm?=
 =?utf-8?B?MUVFR20raFpydyt5UGVLZy9nQ1lvOGorSWpKNzZTdWxJZmFCUnZ6ZWdkOWVu?=
 =?utf-8?B?Z2FITGpocThWNDFNMm54YTdLWW1LY3pua2FuaFd0MnpnUkk4aHV5U09PaGo3?=
 =?utf-8?B?VDVmT2JUMWpXUndFOXVLRzdTeUd2Vy9JRzV2OW5QbExVendrU2FsMjNuczhX?=
 =?utf-8?B?Vk1PdzdpdDlEZ2FXTWdBTGo2VXZYYWJCbXlKZ1ErM2IzNVFLZndZTHhiNkYz?=
 =?utf-8?B?bWFuWmFjeUtSam16ZTVFdVFPbjU2UjYzVTdicHE0YzhvbFR0czRFL0lYU1RM?=
 =?utf-8?B?OU51VUNTdzlPWlRsMWwyRFFQb3c4aVZ5VXJPVENsNTRHVHZDTjFjOGdZSGxp?=
 =?utf-8?B?N1RINDNCOGZVN2NIWXJmQmhwK2NBSmhUQm5LamhCaUJmSHVKYnFmS0svNWRF?=
 =?utf-8?B?OGZndGs0WGlWYXUrSGxuL1J2ZXMybWN6NEZ2aGJGUGlMb1R0VC9HZ1RIVHBZ?=
 =?utf-8?B?QmtqVFF3TWRza05Hajh2UVlIekVuUlhNUzBKV2ROdnovZ040SW44ZXdmWmdj?=
 =?utf-8?B?YXppWHNDMkd1cDhyR0luR2Z5LzNFdEl3b2tBY3pyQlNycEdXYXVqcHhrL1Iv?=
 =?utf-8?B?WUpYRDh1cEwzZTBnN1ljNjZkSjlCbUxuZFdsZ0lBdUt0bWtPamVOT1VJSDVw?=
 =?utf-8?B?cDdRa3ZBbHBXZzRpOFJEZWN2WTZEMUVjc0QxSmdPNXJQT3ZXN2hkemF6akVx?=
 =?utf-8?B?WmZ0TElRdzl4MDFWYmRRYjhveUlFTXJrcXZpUFlmenVIYmI5L1BaYjhnSWpI?=
 =?utf-8?B?dW5CRzhYMTBUYnRDTTdPSEJmSmlFaVQwcWEvZWxIZXFoRUFTbWZKeUgxaU1Z?=
 =?utf-8?B?UGpSMjYwd3VOM0dkTEZOUHZ5b09FdGFUY21SK0U4dW9wRElwcHRGZGRQemkr?=
 =?utf-8?B?d3FoYm04cUF3VTlhc3lzRjBsWmYwRlFLZW5IOGtGMGtNWS92ditLeXZGbGtz?=
 =?utf-8?B?OUZ5RWlrUzFwbFF4VlQ5aWUzejMwajc1anB3dUtlazE0dnh3UEdCMVZpbHZs?=
 =?utf-8?B?Q1Y5RUZzWVk5YjFFeEhISHRjdEVUTUlaaU0yTGV0ZDQ2azN3YklUVnBuam10?=
 =?utf-8?B?SXh1UjJpTmRnVkY3cXk3OU92YmlQT3U2Y2lHSHdmUE1kRHBDMCtWVkt2Q3NH?=
 =?utf-8?B?NmIrUmVRZU03M255eXFob0FXK3ZLczJzSkx1NnJQSkVhbGo3OWVHam0xVzZx?=
 =?utf-8?B?WjU5amM2U2lkNGtHMlJqZS9kZGMyV3owQ0NVdzRLUFQyU1FhN2h4elBJcW1O?=
 =?utf-8?B?VnRaNGI1L3RocHo3QVdwSjZwL0psekZ2QS9CT1RCT1F4bWtmUDQ0Zm9ZS2tP?=
 =?utf-8?B?bFVTcWNSK29vM3VZdm9pWmo5c2VQMnlOZHF1RTdUZ3FQWHZCWS9YTit6Q08w?=
 =?utf-8?B?eUtMV2Zmbkp5SzQzemYwOWxDTVF3TE1KSGhIaC9XN1M0SnYvYzlhRFh3RlNO?=
 =?utf-8?B?YkpDVld0bUtqaUJ1bW45eEhicDdtNkJNYnI1VGUyTXJ1NENnaUR5akpLcytt?=
 =?utf-8?B?R1V3NzNzYURWL0NZMGxIVlY1Qkl1S1liRnlrUndXdW9CTHN6cTlxTVpxN2sv?=
 =?utf-8?B?NmRWTEFvdis5ZzlkS09IUG5aY0VCL0trcDQwK08ydGxad011WlBFLzYxZ0FO?=
 =?utf-8?B?d1dCeERYR28xTEYrQ21wbHdQdUNVUmNoUjBpT1NFV1BrZXh5cnVZRFlvNWVN?=
 =?utf-8?B?a0xQR0dpaWhSS1poWW5CSUFaNWRPdkhmZDlhblhtemtqQUJhZVYyUXE4eDVW?=
 =?utf-8?B?QlBvQ0hXYnFuT0tEeUlUY3R6MDVrcTVwenVqRzdoRENBcSttWUpidnBjZUhP?=
 =?utf-8?B?bDVjOVNBM3FqdlNiNXZvSXpTek9xM0p6WkNLTzZaT3NpY0pZV25aUzM0dzUw?=
 =?utf-8?B?QVZYclgvaTFVYXdXMllPMEd5WmozaUQrTFpOVEJiWDRyQld6V3lBZ29sUUhV?=
 =?utf-8?Q?5UJ5D4Fs2nw8+JJUf+PgRzoot?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd52d71-bf63-434a-32d4-08dc86f76be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 13:40:40.4685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXiefRzPgz4lLFuDmvH9eXTYXLt9l6KP6yvoTVVXXOubK1gHxfydaEnmnjBYq98NOejt3vJD4htumiI9XIRcRxxTnWQx/Py+tk78g30tsFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5266

VGhhbmsgeW91LCBKYW4sIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEtpc3prYSwgSmFuIChUIENFRCkgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+CQ0KPiBTZW50OiBEaWVuc3RhZywgMjEuIE1haSAyMDI0IDE4OjQ4DQo+IFRvOiBLb3dh
bHNreSwgQ2xhcmEgKFQgQ0VEIE9FUy1ERSkgPGNsYXJhLmtvd2Fsc2t5QHNpZW1lbnMuY29tPjsN
Cj4geGVub21haUBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IEJlemRla2EsIEZsb3JpYW4gKFQgQ0VE
IE9FUy1ERSkgPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzVdIHRlc3RzdWl0ZS9ncGlvYmVuY2g6IFRvZ2dsZSBvdXRwdXQgcGluIGluIHJlYWN0
IG1vZGUNCj4gDQo+IE9uIDE2LjA0LjI0IDEwOjU5LCBDbGFyYSBLb3dhbHNreSB3cm90ZToNCj4g
PiBUaGUgZ3Bpb2JlbmNoIHdhcyB0ZXN0ZWQgd2l0aCBvbmUgZGV2aWNlIGluIGxvb3BiYWNrIG1v
ZGUgYW5kIGFub3RoZXINCj4gPiBkZXZpY2UgaW4gcmVhY3QgbW9kZS4gVGhlIGZvcm1lciBzZW5k
cyBhbiBhc3luY2hyb25vdXMgZXZlbnQgdG8gdGhlDQo+ID4gcmVhY3QgZGV2aWNlIGJ5IHRvZ2ds
aW5nIGl0cyBvdXRwdXQgcGluLiBJbiB0aGlzIHRlc3Qgc3RhdGUsIGhvd2V2ZXIsDQo+ID4gdGhl
IHJlYWN0IGRldmljZSBhbHdheXMgcmVzcG9uZHMgd2l0aCBhIGhpZ2ggc2lnbmFsIG9uIGl0cyBv
dXRwdXQgcGluLg0KPiA+IFlldCB0aGUgaW5wdXQgcGluIG9mIHRoZSBsb29wYmFjayBkZXZpY2Ug
aXMgc2V0IHRvIGVkZ2UtdHJpZ2dlcmVkLA0KPiA+IHdoaWNoIGlzIHdoeSB0aGUgdGVzdCBoYW5n
cyBpbiByZWFkKCkgb24gYm90aCBzaWRlcyBhZnRlciBvbmUgbG9vcC4NCj4gPg0KPiA+IEZvciB0
aGUgdGVzdCB0byB3b3JrLCB0aGUgb3V0cHV0IHBpbiBvZiB0aGUgcmVhY3QgZGV2aWNlIG11c3Qg
dG9nZ2xlDQo+ID4gYmV0d2VlbiBoaWdoIGFuZCBsb3cgaW4gb3JkZXIgZm9yIHRoZSBsb29wYmFj
ayBkZXZpY2UgdG8gc3VjY2Vzc2Z1bGx5DQo+ID4gcmVhZCBhIGNoYW5nZSBvbiB0aGUgaW5wdXQg
cGluLg0KPiA+DQo+IA0KPiBTbywgdGhpcyBpcyBub3QgYSBmZWF0dXJlIGFkZGl0aW9uLCBpdCBp
cyBhY3R1YWxseSBhIGZpeCwgcmlnaHQ/DQoNCkl0IGlzIGluZGVlZCBhIGZpeDsgaXQgZGlkIG5v
dCB3b3JrIGJlZm9yZS4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDbGFyYSBLb3dhbHNreSA8
Y2xhcmEua293YWxza3lAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gIHRlc3RzdWl0ZS9ncGlv
YmVuY2gvZ3Bpb2JlbmNoLmMgfCA2ICsrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdHN1aXRl
L2dwaW9iZW5jaC9ncGlvYmVuY2guYw0KPiA+IGIvdGVzdHN1aXRlL2dwaW9iZW5jaC9ncGlvYmVu
Y2guYyBpbmRleCAwNGM2OTQ2MzkuLjcwN2YzNWFlOSAxMDA2NDQNCj4gPiAtLS0gYS90ZXN0c3Vp
dGUvZ3Bpb2JlbmNoL2dwaW9iZW5jaC5jDQo+ID4gKysrIGIvdGVzdHN1aXRlL2dwaW9iZW5jaC9n
cGlvYmVuY2guYw0KPiA+IEBAIC00MjQsNyArNDI0LDExIEBAIHN0YXRpYyB2b2lkICpydW5fZ3Bp
b2JlbmNoX3JlYWN0KHZvaWQgKmNvb2tpZSkNCj4gPiAgCQkgKiBsYXRlbmN5IGJveCB3aWxsIG1l
YXN1cmUgdGhlIHRpbWUgZWxhcHNlZA0KPiA+ICAJCSAqIGJldHdlZW4gdGhlIHR3byBldmVudHMN
Cj4gPiAgCQkgKi8NCj4gPiAtCQl2YWx1ZSA9IEdQSU9fSElHSDsNCj4gPiArCQlpZigoaSAmIDEp
ID09IDApDQo+ICAgICAgICAgICAgICAgICAgXl4NCj4gc3R5bGUgKCJpZiIgaXMgbm90IGEgZnVu
Y3Rpb24pDQoNCkFscmlnaHQsIGFkZGVkIHNwYWNlIGFuZCBjaGFuZ2VkIHRvIGNsZWFuZXIgImlm
ICghKGkgJiAxKSkiLg0KPiANCj4gPiArCQkJdmFsdWUgPSBHUElPX0hJR0g7DQo+ID4gKwkJZWxz
ZQ0KPiA+ICsJCQl2YWx1ZSA9IEdQSU9fTE9XOw0KPiA+ICsNCj4gPiAgCQlyZXQgPSB3cml0ZSh0
aS5mZF9kZXZfb3V0LCAmdmFsdWUsIHNpemVvZih2YWx1ZSkpOw0KPiA+ICAJCWlmIChyZXQgPCAw
KSB7DQo+ID4gIAkJCXByaW50ZigiUlcgR1BJTyB3cml0ZSwgZmFpbGVkXG4iKTsNCj4gDQo+IEph
bg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBMaW51eCBFeHBlcnQgQ2Vu
dGVyDQoNCg==

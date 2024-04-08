Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2139.outbound.protection.outlook.com [40.107.7.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739C28F4
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574234; cv=fail; b=txb/+PwKNWm1xbZ7duCmrTyY03ZlxYc5x9dnyzoS3mmLfQuMKw8cC9LW3NDPwXXot9xM1+sqEsKnnH6oKwPDvuA3W/PoL90czBfsDzP82GxLhoIKzQUlpsPZot+rjg7I8QA4mFCNsJpI5woM/+Fkc0DnoMdV2v3qZkXFSq/k4W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574234; c=relaxed/simple;
	bh=BwtoCGsAqQP1fAJlovSYPZCTe1uUhwIhcN3TxNFxVrQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rLro9e3aApTwBa8JSbot+4kLExVlbRQSQvgemzrKR7h6gGv+v0M3TgzeWW7ZyzBd1NaXxuPNfoE4XoXt/OOKPUJP2/l5DF4NatsDuT3LQH8QmKs/O6pvrutS4IoIm+6rLFbV+AdQjZxd7JNtI51DNYFe2pcljxAqV5t7AtDgptc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=is3aaWQ9; arc=fail smtp.client-ip=40.107.7.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="is3aaWQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZVPpkPPrpHVUngEAVDwAvZBdQm6rWqh5JYrQxVq5eK2qJtdloTwDSwZvccECZo7wRnQ9LTB2ryJnySBO8rfovMfNjf3xLYbumdTMf/j41ZHHermSIFetCiGm023dOaJzn1pzyBr592tel3WEjCzW5Pd6KWLfU0mspqpd2YeXosSKt5TEESPbutC9OB1tzBA7lSjVxlZIDZFm4px0L+AC7bLB6eeg9zKKCPUoCPPilQuEL/9zsegCmtCUUxcMv2B5zgyZuf3boLqID0//+yjTSiV1JtUReqDrZAmVYYi3YArzxPSxmlauh23/K8HAkfvpFC/QiUXXKuyZHDdX9yEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwtoCGsAqQP1fAJlovSYPZCTe1uUhwIhcN3TxNFxVrQ=;
 b=K3DJS7J3YoJpIa3SKKdRCfXEHJwfn9EtVNwzQjz4JdhDuKnbxS5v9eKS94MoXUhHwexYcDerC3Ogl7DG95QYDbJf3//Q6rJ4eeQoauljI/k92v1UyuaeayO5sRkfaMY7qenQjvaP8KBJ7KPFcdaD+PAbFFhL++/yEXMElCRqR9iKWeWGmpOrcbxiUmXSngZtWTtouamkOmkME2a5e549/6GPgjkEGqO3zDRqFFnzQ7CJlhgq3e7Qz5v1lGizybNITv2GNxaCFxZBDYMn4xHR9SRHWCRpqdQoQxtnF3tcXcuE2WuuaNH0D8B9AMmylIU6NvuCkSweHXOcO0q/+FOQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwtoCGsAqQP1fAJlovSYPZCTe1uUhwIhcN3TxNFxVrQ=;
 b=is3aaWQ92/DM3IdAVO0M0DWvABZTBWXMrmFIFdvOP3DzxYzn2MogKXhgM757PesxozorphgumsnhnKfQCscRSYapROF/UxrDi43vJIbGwnN/FIJYgqI69dti5Wfq/4EvpgkctvBknyShw5td0M7hlbRNjwQzrFHxM+xbPdJpOM+WfPysDwr50LwTqMJHUg2mPr2pLKbHKtpM2Ix0dlkyxYORuPCIqifqZm6PplezOlCx9GoxqkYYZU6JL8gwyhFxaFoKxEY54x1kMupRHu00UGIslQMoJMsx0d6xF6PV7FJFEXF6rHq7LJR636JuDAUXG7IvIksOWZKvxgDGBK5TVg==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by AS8PR10MB7182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:03:47 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f01a:deee:b867:7f2d]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f01a:deee:b867:7f2d%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 11:03:47 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Linux Plumbers conference
Thread-Topic: Linux Plumbers conference
Thread-Index: AQHaiaRSTVUid4Qe1kyq0t4feVt86A==
Date: Mon, 8 Apr 2024 11:03:47 +0000
Message-ID:
 <AS5PR10MB8173D2257B87726D7E4A9B6593002@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-08T11:03:47.360Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|AS8PR10MB7182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HPEWrJW8p7vdUroBBcXOEDv+bqbkc3yN0qkAHlr6+ZJoUBFj/jYbM+F2/Q3fqRN/G7CxS7UhNnvrt7YsYAutr8tuMLgmMNXCWas8E5Pph2yXed5Bd7rf2vUL/b45prz9X8uAH8tldkb6heF7ns644izdNeqJu5jl9/zcRpA58hnCQ5DL1LTnu5qTAbd2Un9GFXnmV8vXmIXmm2C2eP3L/yQAHNxinIEJDT/NhPKyhI2OA6dkIK6Ieuk754mKI31bZoH8bjrk4V04LjEdRdqYEnniwlB7L8Yy6Wv8OcMTvFLuH2GBZU1vA2jV3E3ojh2SF3FsMWq8yMuFVo96otNuB8rV4t8xTOhKFzCmhNfNCqE6zh2nxp7BWCZOtOx2W210Rr8CtqjkA0YgY+teK7b4LcYyDuFFG6r0lp8+7m0T9cDoSw6Q0chboANjVakAZMALuoD17qOLaAx8Nl6zMUnlVTykjtwamaw9+N0pc34t7EH+rthohVc56iqSyq3VJS+Mypf6ldMqlVT/TvE1gVyzgwAL0fSf8vT5RKOMWwpn8MyDJ3JE5dzhLUPQaXNE3uvzyOIZlqtXE3WC7H4spVKmFsgK4h73fmuSyqU/pbApcs6fD/IaBGTKSAj/8B3+7ETARLJm5bgeBdHU4xPL055U8DQw9cOGEftlj2UUkUiyEs8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8HGwQOMn+PnJn+8nCsE2jLUw9WZ3I4BJw5xovqq5dtjD1hanwKmfccaKrd?=
 =?iso-8859-1?Q?tWaJoMeLH/T6BAK7vjFlQ7+BkRaSOIjVfjowlqUdsc1ZtBB2F8aRlnwBc3?=
 =?iso-8859-1?Q?T5/L0Qpfh1zDluBS3Bpuq/+lJtJB0SPQ8SqrN0plClaljBJ8YTQGv0LoDK?=
 =?iso-8859-1?Q?q8CENhmjXaQJb6NFfXE/JoICSKrAUGAten84b2xFVuqVX7DK1Wq8n6dyLU?=
 =?iso-8859-1?Q?s9R7vvFc81iM1W5BGrFVosqHgqkU6sFNLcahuWSTQW0sIYm/7K5FLyknv1?=
 =?iso-8859-1?Q?cmgdHMUmLYdtccYDuhKf5UtTKfBjPMAD/Jz6vw1id/GKdKDsryC7eSgZnW?=
 =?iso-8859-1?Q?hFyI+GO5p1HA/W4jvUfxgVEqofy/MDmXfk3bEUpuRdUxbgu77JAIz9w4f+?=
 =?iso-8859-1?Q?zq/Eu1O1+bgZUh42rE0ZAB8tbuJqcu73H93Hjh/Gu/zN9c+1q7ySC2LaRi?=
 =?iso-8859-1?Q?QIOhbF7Jh4ZAK70lRFx72WSxwnM8r6ZcGIljjv5aGa3bBWlGwHkjoxiBkj?=
 =?iso-8859-1?Q?2NDrm/DNY4SIva1ytI/I+L2wH7xMePjIPipmkfMDN4FGvnWGHPmeW2uUAw?=
 =?iso-8859-1?Q?ObJ6qbYgYBc5ZcQHEjFuAE/SawJOn/kSLE2SErml4tGzNkGfuFJQvaOY6k?=
 =?iso-8859-1?Q?ukUUYXDw/Fiff74pK1ZaPSKYH8fZyoSJT38jDK8BZ1Vtnx+/irUL4L+YT/?=
 =?iso-8859-1?Q?Q3hkhBEVcOey8Gc0/aZOyfM01kFultKozOByrNV+AlMeTP+tLJI9M9ryTo?=
 =?iso-8859-1?Q?/9Mw5l47nOmUtedWJ4Qa8gzQO4CPNtMa3qc3MV4LX4d9MdzZJXF+X9Zcm+?=
 =?iso-8859-1?Q?w1H9XoTfs4BTreySER+uI5DGPaV+BFUQzgg1MkY4e5JsK/8i8qDQlflWr0?=
 =?iso-8859-1?Q?RijrmmRsL4A+qsGmoIoadjyXZXTrFdnb9jM+bj2qLwXw7FWt4buyOu0qsd?=
 =?iso-8859-1?Q?b5Q5LZ5C+6DekAqDntFZo1j97ZzRg/t4sepndvOdh86AjA37/0fJSTZIo1?=
 =?iso-8859-1?Q?0kWOb4KV9OAa7i9VhQpqNa3W/lO8vWcqUyKCbNR3rDmJ0+meTmNtOkQMEI?=
 =?iso-8859-1?Q?O0zjL4fczxqAyZtb761D+clv4x8uq1JKWtU4cI/9rMsmJ5dywqOJszUhDL?=
 =?iso-8859-1?Q?i5FzZewrc5ptAzAvU5q3KKbX2nTLA6ygbDPRH0uw+37VvZIreDzlGfZFi5?=
 =?iso-8859-1?Q?TpyCBbi83wsKPxHTRmn1BO5zG2g0w9bztRD9hcIpIIPW9+jbRcriG5Zrga?=
 =?iso-8859-1?Q?YYhGc3/KmARiNcb1L4jNOXogjf9yVMZa7p9hRTCMnd/RDkrYtrbSmHYdza?=
 =?iso-8859-1?Q?80J1bnh3F5IvQk5seCq/7EFj9XEMbRNw5Cz8kG+IhayhNYQpVj2O48SFPM?=
 =?iso-8859-1?Q?SrYnLLOI+irIfMhYB8ZpOO3kcvJMAvEfe6we3f9y47UQ/QnARvhW1xW0mn?=
 =?iso-8859-1?Q?TkaMn9NEN8yTAe5pYT4oxCGY8CIFbo4HGGO5w2269WP1kJZxbFrPqNUPBK?=
 =?iso-8859-1?Q?QTfAbw5l3SDqhjzguWTOJ+uVLQyCXSOOpp+sPJxUEOQfanX2/xMyfgGEbd?=
 =?iso-8859-1?Q?dlxN2+pLCA49xa7npaBwAgkbTul8SVawppKAwbxIHBmqaJU8TaLcTkeGxZ?=
 =?iso-8859-1?Q?NKCY9RoDAHRTBuPwBqpXrlHGsbGZ0bzYSV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e4f87b-a10a-4cf5-6ec6-08dc57bb908b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 11:03:47.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/VZx0l9yhxfBUuIdZOvxiXch/xux5UrEorhdC30byVX68JUmfD10oGV8Boz9ttUGfvMWlE200IIGsgjRFYxvrGPfY/Tgb1CIFceiH/2Yhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7182

Hi Richard,=0A=
=0A=
regarding the Linux Plumbers conference this year, I heard from Jan Kiszka =
that you had the idea to submit a proposal for a microconference on Xenomai=
? =0A=
Could you give a status update on this?=0A=
=0A=
Best=0A=
Clara=

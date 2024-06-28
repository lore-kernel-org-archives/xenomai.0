Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD9154433
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578328; cv=fail; b=Szcr6zHlnXDHXoH2qQmJwTRYKIbSITxZ6MSxJB8TtaTfVL5F4W1Cmd/XgA/qV1Ovlk0HmdUXEI5itrYs7Qh8m56Y+wqQYCClleBV/lzFOSwtWTXL07u3hHerSzvqndvwHzMJF/sotJ0ckoyZU6c/7oW3boPbkgUVIgVOTRJJvGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578328; c=relaxed/simple;
	bh=wG1CvlMtarHZAFRXDVqk+aVNuKVy+XVnjDIZJWcuVJk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nY7+BVN3okdQhGkATVT+76x96Ubv1vBBN29G4+bYjxQ9w9/aXhZMFkPKjfucr+xpUNRMrp0WXH1rKs3wgZgmgXR/7xDKm6391b4WSdGcvLy3bZ/WtjGt5b0eb3PRbOrLyv+b+4Src68Utgz1XBKILLb4VWfc90gGQOYaw/03cw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YcWLB2Mk; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YcWLB2Mk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmf2oElMie/Gp/8BgYnAy1FZ19ifZtpcRwFR6cDGx8pUyEm5DsGZO36rswKWiLyrLguMEH5tGEEq8cUzkn300MXQN8Ji3nq8raevlpgXyoUP1bDNKoCn65uP1FJTMIc6/hNcPbADwdJDfSiC8dZ968I+lm/Tuw1ADHaW0I2vC+hyl6eavc7MJX4IRSPYmOY9TuvNS9gr3MTr9snrQzQT90HkXljIFutSJcM8XqnYliJ75mStoPGBQq96NIkYn/IUODVt8oCV2yDJOCA/TfbvWkfcd4tvuX6cwdsuol9LqAQWFqF8JsnO9HR6BLKn09lt0y36fmbajVAPT5CHmnGp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBgN2/O/DoiKfBNHY5FyIXnLnNTjue1mZsTov10N3kg=;
 b=kdgGSoIFkEB/RrElC9SHWXKSkz+6hG/1+t2wc2qjwYAkK9AjQwKyPWXd7lnmG6w/jAiIFskMdOo8zU6CIe1mMIlm4aFUiee45DfIIFZ4EofhQcNX1b2SLdORHeEQRKWYMlhCDXkMWfC0q+P1Q+Me4vgPdafU1XZeHW71EOb0hdAxFDa84sVQPkmHc3PiOT8q/epNRtbuX57nUe5U7wpUHWUh/i0HliE3Zm0Z6ErwvyUGv7oT7pfzx4xL7llwjoGWUSJOmg3Uywro/1scnd36x2gh+3BhqbPuUOmW1XDcrdSdAUf2Yl6kBDS29HslXwlY9QV/noXjG/Wna7WOzcItmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBgN2/O/DoiKfBNHY5FyIXnLnNTjue1mZsTov10N3kg=;
 b=YcWLB2MkWqUyUuXNcIM/bm+WXoOPpcs73ws3BzltWN4yrEH4/jJp3mMApyfGQalkamGPIWuWK3MWD0gTsH0i+U3+V4FF1LEOu9tOoqhfP1pCfjfShSZhjRyu6XkyWDhT3EL/vUNkfDTR9KOpZbWETxFPZ62au8PMOceXsd18WWs6kCl9QvuLN4WlWmNOsuIpEYhoG6wpLgI9/YloOHxRfuODSp9j3qULBB0g0JRXH7QT0Zx4U1ysqmpkeB7WC+KAtV+osK3UD0EW3ES3bco6sRVm4NL3raK2Uhn4Q10Adqu6qt/i9Oukg60ifAack5Pzp8dd28EnFXuFujKSGoOCNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 12:38:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 12:38:35 +0000
Message-ID: <e6bbcc30-9746-4c4e-9f2d-13246af71df8@siemens.com>
Date: Fri, 28 Jun 2024 14:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ci: specify the dtb file for rpi4 in machine conf
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, quirin.gylstorff@siemens.com
References: <20240628122117.19059-1-yi.jiang@siemens.com>
 <20240628122117.19059-2-yi.jiang@siemens.com>
 <d1d125e9-adfb-4f6f-ac82-9dfcc04057e4@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d1d125e9-adfb-4f6f-ac82-9dfcc04057e4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 8800f76c-3d27-4ace-36d3-08dc976f3a3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJsVTBzM3ppTnUwK25yVE9ZZEUvblZsaTc1Rm1BbUEvcncyZXo4bXB0ZEt1?=
 =?utf-8?B?bGQvWmR1V1F0d0w4T2oxalFPbFlRU3FFdU1lanlSNlFyVmpYclRmM29ybndl?=
 =?utf-8?B?aDF5Q1pnelIrTmxmOTNDWXcxWkN1dkVzWlRMSVpoK1QxeFBFTEk1OE5KN0cv?=
 =?utf-8?B?WGNwVllGTFZGV3ZwVm9kN0cvMUdzZC9ld0dLU21vdzZoQllKbHBOODJodFpO?=
 =?utf-8?B?Rlg3L2h3aS9YNHE3K0ptR3FxbUg5MWVOaFJQUzlWbjR4VUF0K1hrS05ndkhL?=
 =?utf-8?B?QVF4NVlJOEhiL1hkL1cxNXJJZFMwNDNZa2lVcHJBRnlYR2ZGd3poRjM2a09l?=
 =?utf-8?B?UlgvREp0dzg2a3RVNWxoVTN6QTNIdzVTMnA3bC9zSzRNWndWQkdINUFKM1dG?=
 =?utf-8?B?VEtFQk1FTktRQlF2Sm12U21ibXNwUWpuWEs1RTRwTTdaby9xSXBRR0tRVFJm?=
 =?utf-8?B?V21EMW5OWnJ1M2pqWm5rS2xtNm1CdU9UcWlhK25rTEZmOHFvM3R1ekIzSFMv?=
 =?utf-8?B?NkdJc0hGdmlhdGxOVzB3QnpzTUpQaUFjZzlFQ0Exc2dyY2FTOTk2Qkk1Q2lv?=
 =?utf-8?B?aDZXaTQvdGMxVHl1eUVvZ3VoY0cwSFRQOXBaMUpCZFpGRkJYRzYrdFluSXJv?=
 =?utf-8?B?Z3FEUmxpMXRqWHJyR2w1b3Y0T1VsMG1BYmhQSlJRbDhNb3p0VXVRZUp6WU5J?=
 =?utf-8?B?aGM3L295WjNJTU5mVU5nUjJqUEZxQnNUVE41b1lqaFdWdHhaekpWNzdzSE9N?=
 =?utf-8?B?b0xhRjFmcVRRRzVwTEY2ckIwcXJLbDRQdWMwQjJpWlZ6SlNBS2RXbE5yNHpp?=
 =?utf-8?B?dDRZV1RCamJzWk9QNFdESCtKZEt0YnN1dEF1YXY3NER5N1Z2YkUvZkdSMit4?=
 =?utf-8?B?T1F5VFdsaHk1K25xcDQvYnVHYWJOQ1lBQXZmTVJpZWlKbTFoWU1DaTRucmha?=
 =?utf-8?B?QzI3R1lOU0JmRnB5bWJxbWxtdVA3QjN3UCttT0FKeWhmNXUxRWpxU1lLUXpu?=
 =?utf-8?B?cHI1Q2RWQUhDSWFrSzVDbVNTRHFPeDFKN01wTWhZdUpGTFMvT0o3VVpLanJH?=
 =?utf-8?B?UWVhM283Z1VldHZ5ZDIzSGdMQUVMWC9wL1htdnRzbG91STJzdnRYYlBtVXRi?=
 =?utf-8?B?bERmR1ZDczB6YXNmS09Bd1lPalA1NVNXRVRlcDlYekthMEJqSXB1Y2JRZVVk?=
 =?utf-8?B?YkVoRWhnbW9Jc2pWT2w5TXFGU3RGcWdhcS9mR2FUQVRha0VzcUhVdnhxaHYy?=
 =?utf-8?B?NzIyQmpyVHZheFFmRm8vZSt0QS8rczIzYkFVdGp2UTQvNEdlL25mMHlmbDhi?=
 =?utf-8?B?dnQ2MnllTHRENW1jdDhMV05YMG5TbnRqS1kzQ3R2SUhFcUJxd3VpOFQxZmJR?=
 =?utf-8?B?em9JcjB2dkNsV0FkYmxuK3VmNUJ5UktaYVEyQ2VFV25YcXB5VDVBM3o0dE5y?=
 =?utf-8?B?NjUvQXZkUnFWYjFqZlpZL3JrenJKR1RObzVRdmRvVjd3WHRXTUJGMnIrd0Rl?=
 =?utf-8?B?cDVNZjV2RjZtTmVsd2dSWDdJUnZJMjRIYkpiU0FQUDJmYWk4eVdYaGVIMnZs?=
 =?utf-8?B?M3V6dlo5dGthZVN6MzVDUlBuN3BlRDNmNnAvWnhBNlhRR1llTmkrQ201K0Zk?=
 =?utf-8?B?eHEwS29SbUJEMWZrVGEwSFp1SW1SWDJQdG5CWVRZK1BFOUdzdHlyT0xrdnFX?=
 =?utf-8?B?Mjh6OHJiSnUxMXMvUHkzbTF2VFYxZHlXWVFTZEZ1UUhMNkR1ZVZwQUhra1Ew?=
 =?utf-8?B?bzZidnhIRVVUOVdNTEVqOUpPS20wQXNkVi8yUS8yRThVUVNIc21Od1B5UnRF?=
 =?utf-8?B?bVJpbEZINFZJd3AzT2FMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ly9BakJzVGc0M2xmTnpIdlRrb0NrL2dqQVh0R3F5eHlQdXR5YWV1cW51RXpu?=
 =?utf-8?B?VjVhTG9QelBpMU4vOE50TFh0cDE1QWNpSnNuWjA3UERLU3phbGpMTHVqRkVv?=
 =?utf-8?B?YldHR2lyM252azRYZk5UOUFpM0p5WWw4ZHQ2QTRrcVNNNE5vbFpKRzdIeXlh?=
 =?utf-8?B?Ykw0ZU1JbXRBMk9wZjFiTk1rL0xWWDdITThrVnFrTHJYU3BDbHp3eHd3Sklj?=
 =?utf-8?B?UHJWMklMZ3p6RjBxenh4QTM0WGZGMTVaVkNzNUxENWRveUFFclpxSkhtR3Ax?=
 =?utf-8?B?QVVCUlpoQXAxRkZ0d05nTEpnQ3VQVVRUN25HdHpieHVnNEt1eFV2TlEvV2h4?=
 =?utf-8?B?TzBVdGhPK2tYaWN3RGJ2RE1QbmgwZkRia0s4MnIxZ0p0eHVKYnlKQTExV01E?=
 =?utf-8?B?b1Q4RndHRzBvWjR5djVoTHZvSXljTUF1dEFKT0JZNm8weE5DS2EvU1R1UHho?=
 =?utf-8?B?cmFiQTYzemhtUFo0MituTmFpZUVVTUorRTNwVTNoRkhjNWYzUThRZ3VjaENp?=
 =?utf-8?B?K1V6RWkyQTN3bXduak51cGxTc2hCTkxuMEZqdWwrOXFNU1ZXMjZGMCt3RFcx?=
 =?utf-8?B?bnZKcFVGQU1TV2szbk4vd29sTi9jekRYM0F4bTkvTTFZN3BZOGhLbFd1TGdr?=
 =?utf-8?B?WEQzaW95d1laTmp1b0IzN29wWVV4UVg2czQ3Z1RQQzNlUnRVQk4yRlpmRFN5?=
 =?utf-8?B?bnp4dkFzYi9acTZrYzkwOFV2bVVDbFBaVk1TM2ZQVEhmL2NKc3hkek0rajZu?=
 =?utf-8?B?UEtJZE1ERTl2ODZRSnYvWUY4TGc0NDAxWWlaRGdhUXRsK1lWbFJ5blM4WXFv?=
 =?utf-8?B?and1cERzcGErc3VUUlkyUVpYUmFqSitCNGYydi95VXQ1bkpoWU93VGJDdUhY?=
 =?utf-8?B?S2R6T09vRGdaZThxMnVhNlp0VjA3ZW9zZEROVHlTYkwrOVJFdjUyWnJ5b3FG?=
 =?utf-8?B?Sk1MT1J6UnF0cGw5RVhuSGtLRm90WGw5MmVtQ1lqV1ZlUjhzSXBZNGRjaWlN?=
 =?utf-8?B?UUlXZlMyY0wveHplWTc3TCswR1pObWtycUg5aWZLR2RsWmM1UEprckt3Z3lv?=
 =?utf-8?B?SHp5VHZjaHFuQlNUL25mdXQ3RmZGMFVhWVVwLzI3OWttbDdBSjdqUXREeWFt?=
 =?utf-8?B?ZVZpVWpKbFQrRWx2UEFuak9RY3dVenJ6ZjFqQjdCc2ZUVU5sdDZFbFJQYWNz?=
 =?utf-8?B?cDZsc2JmQ3ZObWdHUGVLa3kvTTFCRTgzaVlVZEFBdkNwQjI0azhndXpLYkZi?=
 =?utf-8?B?Q2hFZFA4T24rTDhZL1dkNk1VZ1o3RmJrdUNRMjRVREdyMjgzMWZLU1A5bS81?=
 =?utf-8?B?V3FWT0NwOVBEYmg2cFR1ZEFjcjE4RGpMZDVQNVZnZWtmOHZBY3J4TEJPNHZ1?=
 =?utf-8?B?MHZBcTdYaXBxeDgweWU3NUdhWWhlSDZVZ3g0LzJzcURCUWlaR20rV1AyNlpy?=
 =?utf-8?B?cDFZRUk4NDd4RzNsQVVyaytMcUJwNkQrWkJCUkgvdWt1cndIZ2F1bkcvVjYw?=
 =?utf-8?B?ZjIxUXNSTDlwQnRHSFA5WXM1Vm5CeENpZGg4cS9pcWJiODZjeTBSRldJZEFm?=
 =?utf-8?B?c0UrUVdtL1ZlQkhjVE1QNlB1QWh6VlptMFlXVUU1b3dLdnB1Z1Q1b2w3NlFy?=
 =?utf-8?B?VElhb3FFd0xMZTFZSkRtMVpEemluaEZuSGF5cFZZdFFtSWRuWFFkamRhRisz?=
 =?utf-8?B?NWZ5ZHZIbjF3UGI1UFFKUVBiNkpFK1RTVGZUVUNyRFZRSWZES0RPRVZQdTc3?=
 =?utf-8?B?LzJWRDgyQU91LzFyM0ZkcVlpV0owR3pwK3JXVDg1dnQ2c3ZmZUEyNjJETlho?=
 =?utf-8?B?YVRLYmdXVisxUE9lUmk5L2dTRktsZXVvcmdXbzVVWGNnYTljQ0FKOWJzenJM?=
 =?utf-8?B?TXNrV2IyZEExb3FMN1dzd2hoNHgyM0F5VUM0TG1oL0dpY25aY0tnaSs2WEc5?=
 =?utf-8?B?em9mWmt3cUg1RlJhMjc1UE13U0l2SGk2RlJQaGlUYTZnQ2M5dTdLTW85Vlpn?=
 =?utf-8?B?UW9qMUJidFhNaTMyR2JvSFl2RDMyZVg4MWNBTjZKWUdSZk1VZEQ5T2tIaTly?=
 =?utf-8?B?ejI3Y29QNnA4Mm9HY2xIamVaN3RQMXZPMjdISTlWZWp4ZFJpVHpiVFZjRXZG?=
 =?utf-8?B?ZDRIVVNURUMwQ09lNm8raUNLRjJraWtFYUM2UVR6UkVDT1dsNWtvNUZuK3Rw?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8800f76c-3d27-4ace-36d3-08dc976f3a3a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:38:35.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkCqLXk3L4vu7cJSlgKRtzp8rC6u0uSvNercOmieyNucx6BblGrUh7u+JIWnTxBTypBcXL7kHbwEVIFeines0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7970

On 28.06.24 14:30, Jan Kiszka wrote:
> Reasoning would be good here: This is needed because U-Boot on the board
> is not providing a working DTB to the kernel, and therefore we need to
> deploy one here so that patch 4 can inject that into LAVA?
> 

That said, it is likely better to deploy our own DTB here because the
one on the board is permanent it might no longer be optimal for a newer
kernel we deploy from xenomai-images. So, just clarify in the commit
message the reason for deployment.

Jan

> On 28.06.24 14:21, Yi Jiang wrote:
>> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
>> ---
>>  conf/machine/rpi4.conf | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
>> index 3c0607e..c24bc4c 100644
>> --- a/conf/machine/rpi4.conf
>> +++ b/conf/machine/rpi4.conf
>> @@ -30,3 +30,5 @@ IMAGE_BOOT_FILES = " \
>>      "
>>  
>>  IMAGE_PREINSTALL:append = " firmware-brcm80211"
>> +
>> +DTB_FILES = "bcm2711-rpi-4-b.dtb"
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center


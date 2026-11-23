Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795441366;
	b=e8Nn6rKG/yfvrMvxS8lVp40eqYzx6OkhgUqBAUPgSsHc4a7hpqMAVRuBbKdu5g2vfj4i
	 oHe7koCK7SUkmQRiaEO9qxCBfRthUgSfHBXeDw98uJvk9lUafbrALxe1+wEUOK2/G4cv3
	 qMBjKl/33e5uqf5bhCnXgQat4tRm1un2JJqJemUcrakOyyMzD4uTZqHuo+F0ry7KpwPx3
	 5USmKTsknpaWxbPHEQ9gBHSAwtZUDR0DvqvpS+5q9cfNxOu7cJEo70kbZbgdVjze23E+1
	 6+cqybZtZ2pqc0LK/JXHQmEMFt6SHuCg7s3nBTaW4HNYjZrlmNBltz9PFgCxahZ1J8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441366;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nI7KfyCOUgydBRS4ybYQ4QA3rnMHQA9phXgwZk3//+4=;
	b=sT9SgvV5hlqN+6pMp5VHhZ9LEIruMMjGBbxOp23HO3blHKX6ZAvvHnjByglAJT9HMGmg
	 44up4vxkVqheSb9IWbae0IyfoD5FBwTibOaXJURo+QPb5O5xEQJG0YttTSqSyndBVWaq+
	 GS5yYy+e2udcXUSVYZmQzJDb4hUa0MHSKutw8N1kdGsDEnHcehGXXXGMg//gO2koxi9Wj
	 Z8+L22rQxyZ5NhZnP4vGV/fs+Tvi59GOpEnEgvIVu0tyEs0L+xIQ5v/o5kVof1vnlNJIu
	 +2RFWANR1V0wQx8yZBwSm8SZLYGK+sOgnGYDbALnpI15/AV4lBzIHH0F75nGni+4JAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mK7J80bQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FA606A31E
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 770FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mK7J80bQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeNh/c80LfWK6/Pr2YMNTHHk1HfD4792wh1JdZsXJSMyDRYf/BNr4XfgRNLI7ndrkoYkZBnB/MgOyP1Eqp6L9kIQ1MzN02Q/KJV1tJtmN3i4dMwuOKqLrxTBKcCiwOjLl4Ks0Zw1pWtliudGyjypSsK70/odf/hi9Q+PHOwY12fHeUC/f1ZJohw+GTxWVGBbFoPqdlnlAyrdI0K2yF6grCiJOdpiCdhLb+CToYLSQWg4ORHXvytr6ABnrVnRj0oIWawOc9RwY+d8Au9nH/s7vdUfK94rldGoHvnlixsO6ZVthSYdK70Kn8TxBncdj8AyTUqcVNhxvI2OSEr/1sV4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI7KfyCOUgydBRS4ybYQ4QA3rnMHQA9phXgwZk3//+4=;
 b=hR4y5Yeizn1pPv7YmsRbSk+r6/0eHC+Qnzj9NgmIyD+i0WiueJ0BU1xaJq/go9CfTM3jOCy9bMPTU16Hy0xRj0LXFrtN7p7bEsXvuHb7d0Y8P2eoOxCWGJm3pyEWj7MKKVc14SFt1CHZ99sT5isyEjEsDTCdE8D2yWZ6OVcTJIcnNtQMbePZYJRZLoGI4YVJWr+BGMdOabqAOyFOT5AB2s8oR+3FViY/QLHE0jZOE4ipgdIFGgnGXR8ZV9FKTVKGyPIKvPktf6wL3UBm1PQC8Zr7RvbGaEUrSw83yTbU4Q6PJyuTbDJaJujHawWu9FkL+AZ+i0I9xQa+uoeo2cYCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI7KfyCOUgydBRS4ybYQ4QA3rnMHQA9phXgwZk3//+4=;
 b=mK7J80bQgw4uQ3Cbj086//1X5qgPRw2PB9NKyfvr/QWA2W4zelUKYTZn1exoWT0h9zoms/iX9hE3eetzxOpU2d4TR14P5MW/3uvb/qCJJjWgIAnVX3h+55Ur2//Jxb0uEreHV5KyKr2mXtFqPNWyfL23RGucpYIXr5o0xN6vg3MSFfua+xQT9/jnWs74rw3BKsSipRiX7wP3fgOn6LdzmXyz467WeU91Z1ChmCR7droLNRRWsA4AkPJlH46vb7JjozKnjCG9T/Ze0U3Ig/tPMxS5KDWBUKQMMWyn49FZgvdzcXoNZVTswn90IgnOaA93n0o32MGRwBjNYSi/T0baLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PRAPR10MB5274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Mon, 23 Nov
 2026 13:42:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 13:42:42 +0000
Message-ID: <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
Date: Mon, 23 Nov 2026 14:43:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
 <20261121165933.57310-4-tobias.schaffner@siemens.com>
 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PRAPR10MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 89809031-8f6e-4d11-66fc-08df4967a5f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|55112099003|18002099003|4143699003|11063799006|261022105027099003|56012099006|261026121527099003|261009223027099003|261021123027099003|261022075727099003|261026140227099003|261102123227099003|261021121427099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	G77Txw1LwezY5snzio4BPb8erLcYV4A4zosaomxSbH5e0FOa9liQ5WuKegejOmhWnCSDSKVyXvS78yVq6+a+ZFyuNZfBBe5t3L39COvpmoV8Gfw6AE2L8kXs25yA/CBU4IQSGzTbx6/BWDB0wVDJnSwZXeU+V/w+ROIX782m5xREJwUOn1SUhLvUTMD4zA37lZ4mbkKdnqyN6Dlmip+GZapxE6QjaH0fNMmSsW2uIkNrK7nMafI1XjQUgIOHuoFSFKtUwqJmLj0eTzafIvgdNAkZaot7DAPEkZTJCzf2q1qyd0c3s663hJkkBbTeVFojxRjsfAVc9r9OQtrTc847CkDAj6cC7F745U6lSYgsFGCRjdVjUIO/+m23Zt00w2Jx3hKvDgA69vdPLictyDNubYBxmiY8n/hg8BnZYR4vrVmf1JNOH87VZNYMSDwXhGe67EEWJTw1iFq8ObARRhPl9eTCTWk4iVAK4bwq12T2IJWDV6ylQpusZOGu2UX7jSx7TA4mX85NRtER53Mfa6hMcGJazh+WYi3tpingDyG2pg8uwJXljtZC+iPQqBJarqbmU2VyRwAgWMqbVdY0evlF7vLQvHL3P/YkR2gAkNxNG8/znw7Ms3CipB7kEP9Q+aWS/cz71nRYKXdiYeJgfb2Qr6YHtSMQ22vxX9CMgS+IWZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(55112099003)(18002099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261026121527099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261102123227099003)(261021121427099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aytYb1lRNXByZXZ1OTN4U1ZRVmxwbVAvNlBIRE1vTklDR3Q4cm43RGpwR0NL?=
 =?utf-8?B?akNlbmpLckNXbzlvVWxFQk9UeEp4VzZrWHJvY01WaEs2bDlqaVBUUm9LeDdw?=
 =?utf-8?B?SjBrVG9uQThzSFZuZEl2bmJJQjdzcENHRElEQzd6NXJSS09CU2FrSXQxZG16?=
 =?utf-8?B?bC90aXNYVldYeFI0VmdZVHpRL2kzS3R0NXlkbkh5M1BhS3Z3TmxtY1crNzVy?=
 =?utf-8?B?VjBaNFZnM1UyOHdpRzFTY1A1TVpUWTR6SDZDUFNiWmQvUlVUNzNxMUZVUEFp?=
 =?utf-8?B?RzJKeWVsTFgraS9zMHlXUmVLSHVtQkExM1RyMGpORTlVelZ4VjRlRmVPNU9F?=
 =?utf-8?B?bXdpRFJIOW50R2JMWUd0Q3N3TDdycDdvaUc0QUpNZ0ZxSk9hQllmWDVKTTBt?=
 =?utf-8?B?Y3h4TVdBaHFJU3A0Wkx6UFV1ald6bGh4SkdYRXBmMEZlN0J2dWZ3QmlDQVFK?=
 =?utf-8?B?NlArWEkrcUF4dlBSd3o1ak9oQ0NlZkZ1ZUJ5Uk04NGIva3cwemY2MFArWHhR?=
 =?utf-8?B?VXcrSzU1cjVZQUxNeHNvREF3VzVsWlBmdVl1ZGliRGtWWi90QldQWXlodWZZ?=
 =?utf-8?B?ODRaQUxmbXZFVThweVlDQ3FoNjZpVVJsU1IrdmVDenZ1MVJCaVVVSk1tR0RP?=
 =?utf-8?B?MUNwQmgwSEhrRXhmQ1Ftc2NocWMrSGM3M01iZ01CV1pyd1lLdmhZNis1WXpv?=
 =?utf-8?B?L0EyVXlxUlByejR4U1hvakdMbWVNeEpTUXpVeFl3Yml6Z2ZiMU53RXFYSURM?=
 =?utf-8?B?cGFwU0NvbDJtODdPaDlWbVhXSDNJeVBwTmJ4SWo4YXA5N2lKMzlHcVU2Rk9F?=
 =?utf-8?B?d2V5SlhSTUZKVm9uNlN1ZjF6NTBsUUlUMlhXZENKVzVxTUE4ZkJJOW5RNXNW?=
 =?utf-8?B?UXQ4WjVUaW15anRTVUlPM0hpMFpFUkJxRGRoWlU4ZDZRdnJmbmNmbE5vWVo1?=
 =?utf-8?B?Z3l3ZC84SE9uTjRVQmNDTFVNd0lWQ2pyWFZrWTR3NDZuMVFESUtZUHJiSVhW?=
 =?utf-8?B?d05qbzVwUHphVmVxcTZaU0c1c1RkT2VmVXMvUWorcTVBMFV6WmJITHJmY1d5?=
 =?utf-8?B?ckVEVVZMUXlXSy9Od1l5ZnVGeEVlZkw1eXRRb0h4a2V0a1lwNHFDQndObnZq?=
 =?utf-8?B?VkdTM3Z3aDl6c0ExR0hvYXN2WTFyK1BUUEpaUTVIa1haYTRpdjVqNExsbjdO?=
 =?utf-8?B?RGQway80MnVKaW16dWxmRkVBVTI3di9DWmpBaHAzNCtGTEtJTFpaRlpYNFV2?=
 =?utf-8?B?STFNQjl6SlpMbVBXQllTL2daMkZNemdPaWp0YnpXUGIwY211ZzZOVHBXeEdU?=
 =?utf-8?B?YVBVcm5xQXphVlBjL3pMb0ovckVOd3pDcm5mcVBpeGRWMmhseUhzWlVZb0hT?=
 =?utf-8?B?VTExT1lPYXZLUGg5RWdIZXJaWFlSZjZLanYrSzR0aDdZbUlIdURHYUFWT0du?=
 =?utf-8?B?cm9pbE1mbG8yWlZtTlo4cVh5NElhelZUbXdWeE9RcUJvS283MGo5cDNuQUdz?=
 =?utf-8?B?c2ZnRWhwWFNQSFJRRmVCWTJEKzRzRUVkd0MweXlqcHVjYmZsSWw5cll1V3U4?=
 =?utf-8?B?OU1PRERMczhzcVoxRGl2dVVTWHhQSTV5UE9OUTR6eDByVFFSZ2RsV25FL003?=
 =?utf-8?B?SXF5eTE4TGIyVEhlZUpjbDg1eHFOY3FDRFJ1TXlGMGJmKytQSjd6L01iYk9B?=
 =?utf-8?B?dnhtZU5RR0kzRHFrM2x6Y2kxSUpEa2NjZ01aWm8wRkl1Wmswa05vdnVyamFM?=
 =?utf-8?B?TDlrNmlqQWxEb2ZjNmlpUjVuYWlwenE2akt0c3JHNllLWlpTRy9QendhV01m?=
 =?utf-8?B?S21OVDk0dmhaTVIrUENBZittbm1vaEdZRzFOUmFtQ0ozVnI5ZWRqNVprc2lJ?=
 =?utf-8?B?ZHNYZjlJNmpyenM3RjRQZjlwODlmaXBMRitZbXQ1K0lsdnZBWHljUTE2Wkp3?=
 =?utf-8?B?dmp1cWVEYllsU0FDMFJ5dTFqbUpLMGt3NnRoWlRQTWxCRkladW1IL2IvR3hG?=
 =?utf-8?B?azZxR081c1V3czRNYUVLTEJvOFFpL1lkTnNMMXQ3RG02WldKdjkrcFNOazlD?=
 =?utf-8?B?ME96bDdxdzNsUnpTWlZ5SnRjMVhXTEhuYXcxcHRPZmcxNHN4WkIrZDBuYVBN?=
 =?utf-8?B?LzFOUmlXbW5ocFhmc2gvSHltZXNndExNOVBSZXl4U042Vk4zT0hqdkgyQ2Nu?=
 =?utf-8?B?cTJxMTIxV0tWc0lROEpreVIrSG53U2YrcFkvWERQSVdoTFZhbDNhK1hHd29U?=
 =?utf-8?B?ZkI0RWZSejhaRzhuMjZOMUFjc2tvc200ejlFT0xZdGFTNlNveHVhKzhOcW5Y?=
 =?utf-8?B?NXhEWHJENmlZSDZTRTJtaGNuN0RESzNDRTdmYnJHV0MvMUt5SGV6NVpsQlB0?=
 =?utf-8?Q?/fZHlar/3+UCykrz7Q07uuRt+xH9gm8OS28fxeWBkewek?=
X-MS-Exchange-AntiSpam-MessageData-1: sMrBXga883hrx65XGh4Ft0fkC6/5C9g9VJ0=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89809031-8f6e-4d11-66fc-08df4967a5f1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:42:42.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZSx1Pv2464kzbtcM0ODxkoEvEi5+mlCN8WbfKet+2c+1f4C2T+mP0wIocRv7UnX3xb4GaI2QFbU66eVrNjfxuKyKvU0OqrgYc5w0Bqf52g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5274

On 11/23/26 13:05, Florian Bezdeka wrote:
> On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
>> On 11/22/26 23:18, Florian Bezdeka wrote:
>>> On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
>>>> A page fault may hit kernel code which runs with hard irqs off, e.g. a
>>>> kprobe whose fetch argument faults within the breakpoint trap. The fault
>>>> handler still enables hard irqs for every kernel mode fault, so an
>>>> interrupt may break into that code. If the fault is handled out-of-band,
>>>> the handler also unstalls the in-band stage over the out-of-band stage.
>>>>
>>>> Enable hard irqs in handle_page_fault() only if the faulting code had
>>>> them on and we run in-band, and stall the in-band stage on exit only if
>>>> we run in-band.
>>>>
>>>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>    arch/riscv/kernel/traps.c | 11 ++++-------
>>>>    arch/riscv/mm/fault.c     |  7 +++++--
>>>>    2 files changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>>> index a8e37ec27cc2..47799f18fa7d 100644
>>>> --- a/arch/riscv/kernel/traps.c
>>>> +++ b/arch/riscv/kernel/traps.c
>>>> @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>>>    asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>>>    {
>>>>    	irqentry_state_t state = irqentry_enter(regs);
>>>> +	bool inband = mark_trap_entry(regs);
>>>>    
>>>> -	mark_trap_entry(regs);
>>>> -
>>>> -	BUG_ON(dovetail_debug() && !running_inband());
>>>> -
>>>> -	if (!user_mode(regs))
>>>> -		hard_cond_local_irq_enable();
>>>> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
>>>>    
>>>>    	handle_page_fault(regs, state);
>>>>    
>>>> -	local_irq_disable();
>>>> +	if (inband)
>>>> +		local_irq_disable();
>>>>    
>>>>    	mark_trap_exit(regs);
> 
> Below comes another hard_cond_local_irq_disable() call that is a
> duplicate as already handled by mark_trap_exit(). => More code to be
> removed.

One is for user_mode and one for !user_mode().

>>>>    
>>>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>>>> index c5709112c346..f72b49d8f15a 100644
>>>> --- a/arch/riscv/mm/fault.c
>>>> +++ b/arch/riscv/mm/fault.c
>>>> @@ -317,8 +317,11 @@ void handle_page_fault(struct pt_regs *regs, irqentry_state_t state)
>>>>    
>>>>    	/* Enable interrupts if they were enabled in the parent context. */
>>>>    #ifdef CONFIG_IRQ_PIPELINE
>>>> -	if (state.stage_info != IRQENTRY_INBAND_STALLED)
>>>> -		local_irq_enable_full();
>>>> +	if (running_inband() && !regs_irqs_disabled(regs)) {
>>>> +		hard_local_irq_enable();
>>>> +		if (state.stage_info != IRQENTRY_INBAND_STALLED)
>>>> +			local_irq_enable();
>>>> +	}
>>>
>>> Is that part aligned with any of the other architectures?
>>
>> Yes. This pattern is taken from cond_reenable_irqs_kernel() in
>> arch/x86/mm/fault.c
> 
> Let me check, but I think the entry code is a bit different on x86.
> 
> The original Linux code here is
>   
> 	if (!regs_irqs_disabled(regs))
> 		local_irq_enable();
> 
> The question now is: Why do you still play around with hard IRQs? They
> have already been enabled in mark_trap_entry(). => Remove the
> hard_local_irq_enable() call, no?

Again: mark_trap_entry/exit only enables/disables hard IRQS if inband &&
user_mode. This covers kernel mode and is therefore similar to what x86
does. Ordering should not make that much of a difference here should it?
We just want to make sure that inband can handle its interrupts while
page faulting and that EVL is able to run even if inband is handling its
interrupts.

>>
>>> I'm asking because it seems that the pattern used here has an ordering
>>> problem.
>>>
>>> Once we enabled hard IRQs with hard_local_irq_enable() hardware events
>>> might come in, hitting an stalled inband stage. Means we log all the
>>> events into the IRQ log.
>>>
>>> When we unstall the inband stage with local_irq_enable(), that will
>>> bring us a full IRQ log synchronization - over page fault handling.
>>
>> Is this really a problem? We are handling the running_inband() case here.
> 
> In case of an IRQ storm we will not make any progress here. I remember a
> discussion with Philippe, where I took the "hardware disablement first"
> pattern with me. Let me search for it...
> 
>>
>> Mainline is doing this at the same point to allow IRQ handlers to run
>> while page faulting. Why should we prevent handle this differently?
>> As long as hard IRQs have been enabled before this should be fine,
>> shouldn't it?
>>
>>> As local_irq_enable_full() does it the other way around as well, I
>>> think that the ordering is wrong.
>>>
>>> If taken / aligned from/with an other arch: we should check that as well.
>>>
>>>>    #else
>>>>    	if (!regs_irqs_disabled(regs))
>>>>    		local_irq_enable();
>>>


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628847;
	b=s5Q3PUUdMCCBUYDOZKXnaNeghhlm4fEfOoEhYg5ZGpu4LL1Xs+BNOrrptdd6AkXvzi9Y
	 UnAZL+OcEaMRPAW4pbXPNe4EkXcdGhaTloRQQLZb33ZfFZrBALjUzheaWlYiHfkxzHBFW
	 LcgORvAcrpdNDT8RGILPQoFVkb0I7tv8j5BCqeWGrjJo9sPMz7Vuf0XcH2JF+oTuhsOv/
	 tgyualMQPOEFw+DFVA5rqcPrYssN/7YaV9+zCsE2FeGGl1eaNWCUk45J46pGYM/lXdOsq
	 HaCQXSLcGo7rLfNZ5WlqZONmf5NUuYslUdCzCM/biIBPXnlEYS6OkhLwBcuVNfDxFdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628847;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dcwBR1AGuhCb4E/EhlMVnvugWrMnCsYT6pw9ITUHes4=;
	b=l4zjSJC7EXtnXM/t2Vkl4os/HKqyr6phJ6KWTWR+mOThysm4HsAF1ZsTsMaNvg4h6S54
	 /JWSDSE8d1ZC5h8JyL6i5eApauCSxBJkfUBjuhlO5dBkRv/FDAKeK2+EKORyeN8NpO3cE
	 YMLSNwLCzVohO5adrD4XX/svLlSwqCfgHdalUoYkYhh2jciHCNvvFCmL8+Py28X9+7PnP
	 00K76iyQQdspYb69kKvz1musOvQKVP8iDbGP/X66s0HRfIPBuCLhpFAXCW1s3VW+Cvg8C
	 IZiai0rc6OGb9tBGKUzV84TC+USkF7A9fXsnATWb1CboQ4L7yvdlgW8PztAA3drNhrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UfufsEES;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.43
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CF60A2612
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 14:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2CF60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UfufsEES
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ7xwplnc4k8FnbLjhNRMKW3T0gVd1K/rg8ZnL7rI/3df2j8wQJvKOrFZ79TGvWbndKWFNjfwZdlqAOLGk5Dv9EBDVEpIDrnEL8V4rGz7LdjymsK8iLaasCSTHAvY0qZtxPLGYbaPQbwm/AhfysJlGep5EMBb51oM4ntw4tfMGR8Vl2Oy3TUADIC66MQvKvbtE/4/tFN4rpg8Rs7YV2xrbMKFhpxrJl0OmcPzHlVgsB3k7x6PrmH83v7N2twWeWkxxP03211n6OAQfgnPWrAuo1mTFSJxYazEHL/fj6SgDtfsDGzYqwy8Z+9CmXzwf+tkPK5jGlUZmWSeLilH5p5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcwBR1AGuhCb4E/EhlMVnvugWrMnCsYT6pw9ITUHes4=;
 b=MJBY65flsC6kS/lz06iIhyUX+jXxpkaDRe9BvOS+DOJXEdy7/IM+fYDyK8KkGzmbXYstzZ94CoVU2oTe0qS1ZuRdb8Dm8lScPiMEShAIGTE45ZOXHxpv9cuy0AKq4yUgw+FYCYcGZok9Y+tgLaU5z9eHHrsnfEa7zxiSkERJngfZeA4cCGrWRg8hNEgz3cwla0OcTc+az1vS2JlNlNLaJHoFKxSIMPlB7Bxl2JyvViYyQGG494NpiVUKVZzZJ9sI1cGFdWykMu67FL60Jv7I7Rfkqd6drObEB8fl221EhJGCsNbyYL19dbl7DqWY00vHPwPHSessTRHKw6FBT1Y0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcwBR1AGuhCb4E/EhlMVnvugWrMnCsYT6pw9ITUHes4=;
 b=UfufsEESSFWdI8v/am2EX+9PuetJJWG5ryJlrAThgw4RYTxskrtkwNeYBZ0PXhp9YkXO19q7YLDShUKJWp+IHZy/uk/u/TV4kdj2aVAssDgRzlMkRsBjQZbSiThfiZJbGGVx2fWMw//rvYzpBZZnqpqYEITI+Ec5ANMKkUwwQ8rV7ZawtD7yF+yjPQUm26FYmCSMlpHEFpO6sQUFDFRE6rbTiXLVVxphkg+zzqq1Qp/MMJwTN77cTpZ0k09FDRTmTRN93/qxWO1yEwKVU3JQOIkyQyf2G/qPbFVdlthmGvk3pUQ5ZTueWa9sJ2yluJGep0VcXIt2n6NHuUpG2QH1dA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8329.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:450::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 14:14:04 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 14:14:03 +0000
Message-ID: <2e3b8eec-7911-4abe-8082-97296000e88d@siemens.com>
Date: Mon, 2 Nov 2026 15:14:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 7.3] ARM: dovetail: Fix inconsistencies in trap
 routing
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20261102125420.702769-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261102125420.702769-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: c09c1d70-da34-4fe5-11c0-08df38eb8c8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|55112099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261021130227099003|261022105027099003|261026121527099003|261022113327099003|261026140227099003|261022115727099003|261009223027099003|261028144727099003|261021123027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	a5HdKMZsgnTbP0u96W6jtZ9zXEyyvyaYYiYfHssXOb+aLy6dXejeAVGBW66ebaDrC6J+oJfXhDl1PBd7mdR0OsDKW5Bmz762NEVelpedjmu5PFe1u3oZDjLYA9+geG16vDiS4M7lpJ6W3/qpe92r+tYoHzl8kE+IgmB+UyDEWomlOdqPa3QQPS+IJbsNgHn+X83w2hJKrLlkwknwUW1LnqsZnuOsxw7QoQMIjyWaGMO3f9gMYGXDJ/DToUKQWx0wjdtJQ7/V5O8o4xJ0o5DH2kGouYEj+jrobhBTv2bpGeCxswu1vXB36YB3WdnsDTzaIxHY0mTlW71PQe65J7ndjEa+pErrhFAphEMN2NlTOgJETaaEB9HBEEQv65qy73PqH66V36fJ+FGzHIE5+nFZYDVND4KkENJBQtEXvDqg3aNPGX8owBkPW7i7Yuv3x3KS1D7rBPaoKVC2K+i64ycWZo8OlUj/dv/DoTAcaYpkrn7MY42+j0KrkwPbGXpGGtd4APOsDJwz0VB0rSl9jKSJ0QCJmenvhMCxqU+9DNTEaUj/FmXqItFD1ErXGqVOGwwEUhQRKHDDS5tDiyHZLrA9qoKPM1g6O6W9PMoX+jEsRvDRyWwGDm0yhBad41cybHA9ftlddqOpdlTK+dxyhVb8/QGnQ8SGZ0iMmn9pXO95Nr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261021130227099003)(261022105027099003)(261026121527099003)(261022113327099003)(261026140227099003)(261022115727099003)(261009223027099003)(261028144727099003)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zzhud2JWckoyQ3V1aG5jTmlmTW4rQ09wUUM1ekZiSEtodUh2YXo3R2t5Zm5i?=
 =?utf-8?B?TmxXRkNBM0p2ejBXYzZRTkZQNnJPMHMwaHB0TEY4Y2szcytNWFNYQUFJQjFz?=
 =?utf-8?B?NGZkMmRDU0Z4UWo3bDhFeHNZNXg4Zy9EbWk5Zjc4b29MbFpLYkRGZXFQWHpE?=
 =?utf-8?B?QXBENmdEZFF6SVptdno5dTZzZmxjb3djcHpIMmhYUUVNUzAwMmMyQnNadVBF?=
 =?utf-8?B?UUR5YVYwZ0tnRlVrRXlGQVJ1YllQU1JsRHJTSUprcDVaZ2JuNDIxeEp5cGVE?=
 =?utf-8?B?RHpqK2Z3VExzdElvdGI4ancralB3VnAxVWpuV3hWQmRBRlZzTzZISUlWZnFt?=
 =?utf-8?B?NzJwN2Njcm9QRk9tZ0x1S21yU1ZRL1dOYytxZ0Q2RDBmV3dWWHF5dHhBTE52?=
 =?utf-8?B?NVZsb3NMODBiazN2cHVWRHV2KzdiUk04TmppNnlxeGQrbmVDdy83emZjdDly?=
 =?utf-8?B?VGUxUFFyYmVEMnhTNGVhUmhydmNnR1NYSmpPMzJIanphRmlzbFM5RGl0Vjh2?=
 =?utf-8?B?UlR1Y2ExTmxMSzlhZnc3MU43VUxjVEJsbzA0Y1BETUtuVVdKWWdNSDN4clg1?=
 =?utf-8?B?ckNRd2NCREJOYzB1aUc0Y3lzZWhFQzJ2alVIR2hrZ2w2U28vU1U2N3RmQWxh?=
 =?utf-8?B?cElpd1JEcHhqaWR3bEZWc0tERzNVblhzbHdTSEgwWms0SWZlT3lVbTFjeEVT?=
 =?utf-8?B?OThXaVUxTFNoWWkvT0ZiUTZVMW9ZUWtSSWcvenFhNUcyNFZaS09mVkx5SmNZ?=
 =?utf-8?B?dHFzRzhHTnRmVVpTelppN0sxT0E0ZDBRZ0tBRHhyRkhPSzNteVhwMnFENWs3?=
 =?utf-8?B?bDBFMENiemMzSlg2RTBOaHRzRkhXWHE5UVlPQzNtOENVaDlBNE8xbDZIVXJj?=
 =?utf-8?B?WnFEVkZTeUVzckd6MERRdmlEVG1rUUFybzRaVDZlM0pMcUlVVkg1VVlZbkdm?=
 =?utf-8?B?NjU5OS93N1Axd1RaMWxyMThhYnlnM0V5Sjc3MDQxNFVTeVBSQng2Vm8vQ2N6?=
 =?utf-8?B?VUY3R0R5WkNOYXZvMkdwTFBEWVNMMWFNSENqVlBjaUNnWmtKS1M1c0FCRm1I?=
 =?utf-8?B?TUpyOE55aGQrVFVNYWFzRFplZnlzL0FWOEJYOUFFS1VKUnlkUmFXQ0JycXkw?=
 =?utf-8?B?QUc3cE5JeEtZTUpianJVQ0NEUnhDVkJMbHlKNHEzL2hHdXE1SFNuOHFBdTZw?=
 =?utf-8?B?TDBiL0hkM2YyZ3ZqcGdrTWM3NXgyTEEwY2dRQXNXcktidkRWRnl4anM2ZUpM?=
 =?utf-8?B?ZnU4dmR2UlpOQUtkZGJuTFpsWE1Lb2R2dWlQOGd5eHcvT05jYUczc3lxZXBi?=
 =?utf-8?B?VDBCeXZINnR6WFBWMWwxN1lpK0xFQU1Jb3NGNWhSWlRVeGFaVWpNTC96WWRL?=
 =?utf-8?B?dnBsazVSck9nZi8xUDR6YzVHVFJzQjlsckFZalBQQTY5dDlyR1didHIxRSsw?=
 =?utf-8?B?NW1DSUpvaS9mbG5obDAwMFhiVk1CMGNLQVBNODBvbk5rdUlYVGE0S3Rmdloy?=
 =?utf-8?B?RGhyakFMOEpSSXcyWnZtNkRlSXJ6b2ZwalFYSURyYlVkcThadTh3R2dxcXh3?=
 =?utf-8?B?d2lySTVrY2R0OUs2Q2hicWlLTllBVDAwMjNtMGRqdGpwaGtldXYvaTd0ZzF1?=
 =?utf-8?B?cE9meGhBV1Fvc01VS3d2eTcvNjFKc0hYbEdEczcvSTVFUWdQSTFURExycUJC?=
 =?utf-8?B?YUh1c1F2SFRxVFpnVGprczM1aTZ6YnI2MEN0bUFFanBMSUQzaGdyQ3dLc0t4?=
 =?utf-8?B?VTN5bmREQmVnc2cwV1RWcGlTd3FaeGU5Nno0dHQxZlNoNWdKSVBleVNOaXRH?=
 =?utf-8?B?NHhFL0o0bXB1Nks3dUpHZFlpL1lUaDFsOXd6UjR2Vm0yZ1puNTNQdFBoSXZC?=
 =?utf-8?B?VXVQRkZHMGZmQW1IL0J4WlVRcHZRVTBKcmE0eGl3Q0ZVL1NCbmdpUUU0ZDN1?=
 =?utf-8?B?MjRMMkdWd3lYQVNoeVBybUlGaGZ5UHVNV1VZeTNzdkJmbTdMMHFqQ0dFTWo3?=
 =?utf-8?B?TXhSd2pid3RKc3crWG11eDFpMkZtMXZ2Y2pMVVF4SHdCS1hpcFRNcmRPQjlM?=
 =?utf-8?B?ZktSU3JvUXZNcFd6WmI0bVpRbjVXQkVSQk5yaEkrZWh6SDZuMHYyKzFJbnZG?=
 =?utf-8?B?YS85MHpCMkd4eTdSb0NYUnN6Uk1JRlIrNDl5dkhmZkFaZ003ckptbWFzNlJi?=
 =?utf-8?B?Ry9LSnZEVW41Ym5RcDZodC9seUxsekllTXVMUVlQUnR5aWpxWU9ZWlZtVUhF?=
 =?utf-8?B?T0UwK0kyS29zNngreVh2cXV1RXl4Q2lZN2Q2Qnp3Wlh1N2l2a3UzSmNMS1VE?=
 =?utf-8?B?b1haYU10VFIyVUpqTUVVQmRGSzQ1YXp4bU1CYThYcURDVDVDQzlDUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09c1d70-da34-4fe5-11c0-08df38eb8c8b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:14:03.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eme7eQNhJ6PvTSnN7E25u+OWexQI5CsjjdzSgnsgA05zEPoJfJoNWzwnETMLP9TRxMnhoIE514vif5+vycGtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8329

On 02.11.26 13:54, Florian Bezdeka wrote:
> do_bad_area() was informing the co-kernel about an ongoing trap
> handling - but only for the trap over user mode case. Removing the
> dovetail_fault_{entry,exit}() pair removes that inconsistency - we
> never inform the co-kernel now, callers have to do so -
> and fixes yet another issue:
> 
> do_bad_area() is called by
>   - do_sect_fault(): fault.c
>   - do_alignment(): alignment.c
> 
> do_sect_fault() already informed the co-kernel about the trap, but
> with a different type: ARM_TRAP_SECTION vs. ARM_TRAP_ACCESS. This
> nesting is removed at the same time.
> 
> The second caller, do_alignment(), used mark_trap_{entry,exit}()
> instead of dovetail_fault_{entry,exit}.
> 
> In addition, leaving a comment in do_bad_area() why we do not have
> to use mark_trap_{entry,exit}() here. All other users of
> __do_{user,kernel}_fault() still have to call them.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Sending as separate patch to make review easier. In addition, I'm not
> sure if Philippe already took over my 7.3 rebase branch. Pushing again
> might create even more confusion.
> 
> A couple of tests are successful already, some more are ongoing. In case
> something comes up - which I don't expect - I will let you know.
> 
>  arch/arm/mm/alignment.c |  6 ++++--
>  arch/arm/mm/fault.c     | 12 +++++++-----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 612db267f6246..34c3b7c10be41 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -25,6 +25,7 @@
>  #include <asm/cp15.h>
>  #include <asm/system_info.h>
>  #include <asm/system_misc.h>
> +#include <asm/trap_entry.h>
>  #include <asm/opcodes.h>
>  
>  #include "fault.h"
> @@ -803,6 +804,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
>  	union offset_union offset;
>  	unsigned long instrptr;
> +	unsigned long irqflags;
>  	int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
>  	unsigned int type;
>  	u32 instr = 0;
> @@ -815,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (addr >= TASK_SIZE && user_mode(regs))
>  		harden_branch_predictor();
>  
> -	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
> +	irqflags = dovetail_fault_entry(ARM_TRAP_ALIGNMENT, regs);
>  
>  	if (!arch_kentry_test_stalled(regs))
>  		local_irq_enable();
> @@ -1007,7 +1009,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	}
>  
>  out:
> -	mark_trap_exit(ARM_TRAP_ALIGNMENT, regs);
> +	dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
>  
>  	return ret;
>  }
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 95870a96a6286..da2420534495e 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -212,17 +212,19 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->active_mm;
> -	unsigned long irqflags;
> +
> +	/*
> +	 * irq_pipeline: No dovetail_mark_trap_{entry,exit}() here. All callers

It's dovetail_fault_{entry,exit}.

> +	 * are expected to have informed the co-kernel already.
> +	 */
>  
>  	/*
>  	 * If we are in kernel mode at this point, we
>  	 * have no context to handle this fault with.
>  	 */
> -	  if (user_mode(regs)) {
> -		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
> +	  if (user_mode(regs))
>  		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
> -		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
> -	  } else
> +	  else
>  		/*
>  		 * irq_pipeline: kernel faults are either quickly
>  		 * recoverable via fixup, or lethal. In both cases, we

Spending some tokens on a pattern analysis right now, let's see..

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

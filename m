Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87C2E62F
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330428; cv=fail; b=VwBMj2/LWZMPz1RPqDmZLpE1JvyTFYQ6PGQWWOQC/hDJ2z+1Fn81hcn4KtLL3OyWmrRav4crm7CDxQO3bpQ96EW4QxkcgNFBi4Dfo8s6Qsxhr+Y/GKzf6UAnnunCm3zQz9RnqqnDgSexobprvpcfa0zyxEGLGBmFIlwfp/IXZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330428; c=relaxed/simple;
	bh=+MXqLowPwXfoKFz/+dyvlQXId4fntZwH0MMyhbow8lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxLCTMcj1QaSy/MY39X7FYlGBIQuLaweBEMcGj0JQn2C8NkBJK4CpiZqeDHc6h/eppZtNzQRzngjbsU8LkudI9Tsg3EZz4hQvfoZbBQSSnMVJJS9ooG4LQRyKQivhTkOdmdaE62niqP3/3DiEge0NknzwN5JlBMk5J27SiRXCXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NPJp5GLT; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NPJp5GLT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1WPgz9FPKP70THZZjf8fZsKuI4IKlNs32ExbARYERC1kr+ZEqXM50lld1OiPpelDf1IOCvsJzP1LswqEuwX/HUbCVRrK4IPjPLPzYlK2BVm7husqXeZiZz2TE+10bqCUR8wRme1IEtn5ZHfOvYObCA0fbSXnhDTavJ2cQhvG0FPV4xSg7jTpvUmtsb9vKIz/Aie9MTI1SH1X7mr/QyPcWZFbPmijEq6Ve4X+41NlOukqJwPL4Z7YmNsVblUIq5ZGx++0zy7hP3C2ALbYZXtHVKwgU8+LNvXZ7DR6nIWoabwCa8gXKKQEUlIiJr6MPdC4m1knoHTwcz8oXuHqLUULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A59S4k2mVKftQ7Tg+XhiUuavXW6o6YxNZ7/i2vMnhEo=;
 b=H8NVJPfFgXZLx8VuVfhgazz7Hy5Ksm/8XGvd9H2oyl+gQTPvcRqFhj5prETl5kBws+shTbbVqHxeKS5fo4sQqDxi8Pp/Fa2wZvkZztlnvkCxIpEgEBUuxUvgHPtkHoYLe56dxLbPERhPaC1MuIDmBgbymxpcIWdU9SLcYQqx5LntDubI57YIQC3aIUo1Rdct7E8gNJuYbbF2NxYB8+16B6fJuwtCOErUs6jZPxyfPVCRrNXd9PVbFGJ6xdeGM9njv9lfvPuFoE1mxI0CH/cFYaz3M7fXiOY9/N4wC2N0XGEgNNNG6yUwQ0xaJI85zRVdfaT5U02/duIKg1KmsPXH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A59S4k2mVKftQ7Tg+XhiUuavXW6o6YxNZ7/i2vMnhEo=;
 b=NPJp5GLTPfaBHtcEGCHYAyh3R3+j7HPLPgWCBgkIJGCzz+zTdFyz4TdmH5Nn5glXAFrTY8YbugGx7OZODZf2pD1YnA1PAJywre3Da/tB5IKAx7AnHgImFpNAGjrz5YrPOvcF41n5H/00Z4SOIWcEMowObt5Xp36vJ3b7a/A1RNHbJ5F9wF3+C1tsG+qy3fS5xGKZxHxbkIuA7hc15SA76kbHOUj4shXCR3a2AedpnhyRtCtENzPiyEFnDzJRnNsPGOEa3XmsAsllw1Q3fJWaf5jrwflL01foSvwGRsRlgLfjbI86s/BVWLAcksi+7GFZWijFGbrHbWfaU8TPn1yyLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 15:47:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:47:02 +0000
Message-ID: <dfd637b9-9ffd-4952-848e-5b57cde21ec3@siemens.com>
Date: Tue, 25 Jun 2024 17:46:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Assorted Cleanups For prepare-kernel.sh
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240624203341.6263-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240624203341.6263-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:610:b1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 85af0048-19da-45f1-9d85-08dc952e0e33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1ZDbHBzVkg3N2h4aGxDVkFFRVRKM2tFb0NiL2RxV3BIc1VkTnFWSHYyc1Fw?=
 =?utf-8?B?cXQ1czg2dUwveHR4VzZ0U1lnaGo1TjF3SXpqNnlDc1h0b2ljcW1KT0NRQ1Nj?=
 =?utf-8?B?MGZmTm9lY0VDRmd6MmlaVVV0MWU2RHA4Mk9ka0xIaXpEUWlGN3N0WkNnMWR1?=
 =?utf-8?B?MG96VjJvL1hNVHFoU2tjN3lDdHhmQTNtYVV3aGtReUlWQ1BpM1AwaVdCT09n?=
 =?utf-8?B?MnBSRkZFRHB0U0NoMUtqNHRrcVh4dktrWC9JZFNiSVBYQ0VHc0ppQmQ3VU5y?=
 =?utf-8?B?OWpud2xGa2ZCNUZRTWpGcE5SdGVVd0Uzdzd0K3RSRFFFUEdkVUJWdGJyTHFw?=
 =?utf-8?B?R05PRzAyNDFBRzJUbUpOWjZrUDJ4RTdPZ21kaWZrajhwVWh4blBpOXVjVmZJ?=
 =?utf-8?B?UU1oaEdwVVlYUHp3QXIyU2F2WUNYUUtaclJsWVN4UW1IZmQ3RzVBYjhwYzkw?=
 =?utf-8?B?dEVDN0NSNFJhU0NScERmdDZkWjM0bVdFRXlYdVB5NURmcXl3Snl6TWNJRUFF?=
 =?utf-8?B?eVVqSWF0amlYaXZiNGV5anM2RXdDc2V3dlNBMi9ENEplYXVDNUU3NWs1cFFH?=
 =?utf-8?B?Wk1uWkFSVlhjVEgyUFd2b2NsWGlub0ducDlJWFN1anhRNXFYaUIxbUgxbTc2?=
 =?utf-8?B?S0pUZkNpMEUvVlRUUVd4VUsrWk53aENnVXlFbWFLL1NPcU1oOTVEUEZOZDJv?=
 =?utf-8?B?K29TNEZlZDZCREZwemxRekdWV3U2SmhYaEpuN3BXb2t0Ny9mVjFOczFwMG03?=
 =?utf-8?B?aVRaV0lEMUpkaVVoM3lEb2dnRFVmakpJMzdQWXJTS0lTMTB5UXdacW96ZDht?=
 =?utf-8?B?bXdtaGJjMWpRVHlkS0RDVWl4MUh1cmIyS0toT2JSOTY0NFR6enFsRzl4ZXZO?=
 =?utf-8?B?K0hqc3dCTGh0NDFla0hEM3gzUVUwS1k4YmFOS1lVOTZoWFpFbGc3Q09yV0ZQ?=
 =?utf-8?B?eEhOcW9TVXp5YjhyMWJqTnF0dkNLcnRiSXlubVUzd3ZQQ2QzR1VDNWdDeFBi?=
 =?utf-8?B?SEtidDg2VzVsVjFTNGlvV09KcDVNZkRmU3ljV3dDdXptd0lyZzRMWWlrTlBL?=
 =?utf-8?B?V1R4UFZOWDZQTllwcGVwWUNTY0VQdFQwWFNrSldseS8vWTZYNlRNaHFBNFdH?=
 =?utf-8?B?Zi9TZGxVall5WXNabzN2OGRVcStkZ3ZFbEVzN1JoNWxTaXJzRVluZGdFamx0?=
 =?utf-8?B?Qno3bGI4T3Jidmx4bklxRzE4RmNBTW1BaW1tT2pKM3ZMd2J6UW05aDNxUmJS?=
 =?utf-8?B?SmtuenlRWlRLL1Z0U1hWcUlLc3Z1VncwajJYbHlFZXdFQVk4MDE3NEdodTU0?=
 =?utf-8?B?ZTlBNnFvMEpOUXlUUE1JOXVOcklWZTk5d1JjQXk0Q2JPTDduVVVWMU9DTi9S?=
 =?utf-8?B?bFZmeWs5THpQZkNwaGovalFvTVBsMU1EUVVOVHgzUm9tcENuaVdRUXRIQ2Rn?=
 =?utf-8?B?ZlpnT0Y0b3JSNnFCbHNEbVFoRmJmREN6aVUrcHd0OHUwWDZRZzU4T0hYZTFl?=
 =?utf-8?B?aXYvNDJDcGZ6SEtsVFk2bkpUYXNqaHBVVG1PRDRpYTk0RXdHVzEwSEVITXhq?=
 =?utf-8?B?MFpCTjE4R3NkTm1LOHU2eXp1ZXZNNldic2xoNmhHU2NwMS94L1RjWWlaY3N3?=
 =?utf-8?B?Y2tZSXQ0cTRxYldUUlp0NWpnVGhJbjZOVVZsM3dJMENEQmgrRENqeWxNeG5n?=
 =?utf-8?Q?PQg4l2k72PWwf23lnRDg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJFaC9MWGNlUHdQZC93OFVjRm4xOW9pYzNyOFg5Q1lDUFlNWTh4SnEvYm9E?=
 =?utf-8?B?NWtieFM3RXpSNk1iNHVKdE53TzRHR1lPWHplTUFsVmZHM29ZaUI2VHl2RFFG?=
 =?utf-8?B?KzVlOG9vM3NmUmc2NmhaU0NEcklnOWVjM2FZUGVySmF5cG9DVjF1NitURyt3?=
 =?utf-8?B?dk41Qk42ZlliTnRXRFVYT2JCb1A0QzFBMk1vYkNzNTlRcUtpZWxQNWMxaEFz?=
 =?utf-8?B?TkZEZXdEblY0b2xWckxjSnRFWTFVRGxkbGNad2xPaGxFcWV6Snk0QVZlM0I2?=
 =?utf-8?B?Zlg0WkYvN2lGTm44NXFNV3dwK09KaVB4cjZ6SHdkTGsvWktQTjlXblI3MHdJ?=
 =?utf-8?B?RGJCaGNnQWRZajNNVVZVTkFaaUR6a3BGMDhlUHhKRE80NkhVOXg3MWFOK3BR?=
 =?utf-8?B?dDZnMWcwSUovUDZjQ1RzempxYVhBVDZMdTdLNVYrK1pwaTFLeG5aTHJiVEls?=
 =?utf-8?B?MXRWcjNmQ0liZnY5Z0E3ajRkcDBVazhlMmdXMDhtU1dkZDFFbVplWHc2a1ph?=
 =?utf-8?B?c1FDejF2RUJtUHZ1TVd3VHlXUFJ5aUFVUjhOeFY1eW9sbGtySXphRkI0Qzht?=
 =?utf-8?B?dTg4eHRNSGkxNGJYcEFZTG1VcC84bGV5UFZXK1ZTZUh3N0N1SEhRNzllb0xB?=
 =?utf-8?B?cm5ZREoxbmY0bEtzT3l0cGNGU3dFQk4wbFBpTkQyUHdlRlhhTjhJMmdxSE5F?=
 =?utf-8?B?NXpOZXVnMFp2eW9ubENya3RIVU05aEdsRXhqSnVENEQ3QVRNK3FNWXN1cGF6?=
 =?utf-8?B?WnU1T0g5UDVBWnZrWlJYT1NmaVRWbFh3RTNHbGZnN3VuTlFTWkFQMitSSGhU?=
 =?utf-8?B?RUtxNFI2Sy9QckJjR2FCKzdzT0lrMDBPNE01ZG9DcFZqVWs4MXhMNUVRMHMz?=
 =?utf-8?B?WmVlSnd3WkFDdkdzcUlmc2ZEbE9tUkRKZ00vMFRkNGhrcW9pL0Vrd2QzMm12?=
 =?utf-8?B?T3ZieVloZytpdmx2c1V3UWdjdXJXeUlmaHV5N0lGbzZXU1J2VEM0dHNUSS9L?=
 =?utf-8?B?S3dRRWxiMVhHZTJkNUpJa1V5MDI0dkdTRXpRRldNOFUycjlDRktIS3loeEcv?=
 =?utf-8?B?T1VGdUtVa1NjL25wRlpSM3FWNUY2UHNXTG9sZHora1c2S3F3NzhzLzdTRUFz?=
 =?utf-8?B?RnlDN3ZOb1laWkM2R0liamZxTHovNzdaRjBveENWVFp0OGtzcjJQVm83N3B4?=
 =?utf-8?B?S05UaThKM1RHRmk4a3h1SWxzQlZKeEE3OGtEZWlmUURXT043dW9ycENwSDIv?=
 =?utf-8?B?NDZxTFFMUytCUUdhdlJLb2YrN2o4ZEpoQ2cxUjVBWVRuZkg3d1FXUDErSXho?=
 =?utf-8?B?b1g2K2pWS3YvR2Y5SE91bGxHVmREMkU5QUxuY0JWUCs1UElwOCtGSkF2cmt3?=
 =?utf-8?B?OHlzMENwZUNWRXNjdGlaTzFib2ZBQW1rQjF4WHdKS2Z2RStxMW9hakh3YVdG?=
 =?utf-8?B?ZU1MTnlJSzhCZDE2YjE5YVlQR2pRRy9PYXR4OWhoY25PaUhlcms2TlM5NnhT?=
 =?utf-8?B?My9sNmg4NkxFT3RKMDF4b3Q2VVRmS1VSRmNGWE1wUUhGVDVhUnIxVUh6dDht?=
 =?utf-8?B?VFlibnFFRy95elV2Y0pJUUhtcFlQU09JRUxiS2t3c1p2VWlvUC8veGVnYWxH?=
 =?utf-8?B?dVFyenV0c3VsZnhKd0hjNzJLK09Wak5pU21TcFpPaGc0MW1EWGIrSGF0MVFi?=
 =?utf-8?B?bnhMVXF2ekNwOGJaQ3FHYzlRbjlES2RjNXBGdzBqaUtGaDhBOWw3MjQwc3BK?=
 =?utf-8?B?KytOZDdsS3NDMmJ4NElPRGNRNm41MU9nNGMzRm8rTmVuR0syTEFnSXgzUzY3?=
 =?utf-8?B?VEV2ZFFoV2pFY0ZrNVgwbXdxVWVPSGtlb0NKMGh4M2VGUXFPUVZucThQd21p?=
 =?utf-8?B?bzhNQkhXUjdBUUdxQjM4aWE4dDMvcEE0ZFBKd0ZnL2JSd2dxeTFYTmt2d0Rp?=
 =?utf-8?B?L2ZGSng3cG5QSHkybTlWa2d2b3A5K2M1R1VBUTU0K3RKbXhXVC90aURsSU00?=
 =?utf-8?B?UzNnZjRBaGZtTFhoVXJOVW41QkZZNERtUVJBUVVxM0ovZUw1Vk5ReENBT25o?=
 =?utf-8?B?eHR4NlZPVEFzUlFiYkJ5OWRDNnovUFk5MmhLcG1lSGVzTmRSTjd6aUFEL2c1?=
 =?utf-8?B?ODNBSWJEWFFoZlo2bmRubVZ5ZDNWZy9OYy9ZRCtOcU0vZ2JLQlhMbFRHcWlQ?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85af0048-19da-45f1-9d85-08dc952e0e33
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:47:02.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPPyIkgWEIRiwqomAlbxx8wLycU2CrI21RZoOyWjKhnpHADMHKfZXq80Udcnv6etyRUIo0yGw6tFSnsZ4ondgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8800

On 24.06.24 22:33, Richard Weinberger wrote:
> This series contains the following improvements and cleanups.
> 
> - Implement --reverse to undo the effects of the script
> - Emit changes that work on any architecture, renders --arch= optional
> - Switch from /bin/bash to /bin/sh
> - Make shellcheck happy up to warning level, info level is still a lot of work
> - Convert the whole script to tabs
> - Remove dead and in vain code
> - Various fixes
> 
> Changes since v1[0]:
> - Rebased to current next branch
> - Reorganized patch series
> - Worked in feedback from Jan and Florian
> 
> Richard Weinberger (14):
>   prepare-kernel.sh: Convert to tabs
>   prepare-kernel.sh: Add reverse mode
>   prepare-kernel.sh: Emit architecture agnostic changes
>   prepare-kernel.sh: Improve kernel tree check
>   prepare-kernel.sh: Disable SC2115 warning around $linux_tree
>   prepare-kernel.sh: Remove --filterkvers= and --filterarch=
>   prepare-kernel.sh: Remove interactivity
>   prepare-kernel.sh: Don't depend on bash
>   prepare-kernel.sh: Remove --forcelink
>   prepare-kernel.sh: Fix dovetail check
>   prepare-kernel.sh: Define command line variables
>   prepare-kernel.sh: Remove dead code
>   prepare-kernel.sh: Don't allow uninitialized variables
>   prepare-kernel.sh: Remove kernel version check
> 
>  scripts/Kconfig.frag      |   2 +-
>  scripts/prepare-kernel.sh | 587 +++++++++++++++++---------------------
>  2 files changed, 268 insertions(+), 321 deletions(-)
> 
> [0]: https://lore.kernel.org/xenomai/20240525115806.12101-1-richard@nod.at/
> 

Thanks, series with smaller adjustments in next now. The final diff is
limited to whitespaces, though.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


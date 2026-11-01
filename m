Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793541383;
	b=WKf4NT08+DJCX7Xd7Q/FW41oIc8qdXMlJglSp347+5qGwPpmWVauNZMcTj2demVe9Wlc
	 tS4VsOvtKaxuJzTgLoVHk537k2pEKB3abmy8JlqokOZ/ocMUP78ME6tT1XNY6YVNphB/g
	 AlO/Lnhf/kjZksDmHuiyDP5VjF5vEojoD45dWOdYztgkG1WocrIgu5E2fBZeESiPH+5U3
	 fcKWljBXLHg9I5JGqvmf59FAFSTn8J3ENcQIQ1roQvn5Qvr9IsR8io5ADJE4qSEN9YDpl
	 AScNi7ghrMS9mw6bcqqCLIE2is1XIxLTM568Sq75C2GjVOGALVlUiq2yKOphMKXJK8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541383;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Content-Language:To:Subject:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=Zbq5HHlFIMilIIOGj95GdvM+KKIqsQVUlBFcOM4OkZo=;
	b=MxWsXx5UNPxKYyH/E+fDeZITwGEpCXiHtcbvgt4d1+1DkufBt43jBSvpqG9I3yNS66f8
	 BGBY3PljPnDwkrYuRcZ8RJblwG8a+Z8Kiyy/kw5iHli/UmkPDHHlUcWBMOUXxjFf7fr4T
	 A9pXC5EskZL5gezRlKSHX8o4xfEvtkbW6mKleMzNrff9vftTCxOF0hosjgOszFrNoT1tK
	 2SaIB/ZALcSoU9f9AGNZd9/CmgkUAdFnNbctPPGLZpWcUZoWCVdXvOAOG7yLtIFiIwdDe
	 490csBG9STlhdM5k1XNQQSlvrxj/RS5q1SY5vWTfcyUm8Zc2CLyk/WA+sKUZwEwSxtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=eIfdszW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.48
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758CC606A324
	for <xenomai@lists.linux.dev>; Sun,  1 Nov 2026 13:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758CC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=eIfdszW5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON+hM6QpKF8rAeLsNPQgsj7QQ9SjvDdkySeGjIAa/fAa2tceeJawlaC2mXfBOVRCyQMU6FA8h9WVGO4wtTGbD0dfGlrGHU4Dx301wjlvAZp9inEA47iycxPokNz3WcCNypBrtiT7TMQwmKbcT0IbfCbknVk32qSeIDuHvHWPYhOzs6seabAn8KJe7NTaqRrjZ3nAGTvAMqsVGNGsy7UsKtkjYVTvNRGOjl353kU7Aav+AES/PzN1ePpmgkbZUWceFM+G17wIvUh33qutscd3Sr7Ts2vjLL5kZdXxgCKJ/Cw+TqGPbrrqpQsmQqZLr7J+qXg2gWemvDvgDMdvsfChlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbq5HHlFIMilIIOGj95GdvM+KKIqsQVUlBFcOM4OkZo=;
 b=U/HWizbEsRrCCRj+vBgwiKO/YH60W2TMP6mYU+ZqkMoqchVrvPAdAuiS6rtcsUcAwZ/D0hPGdhDLZN7FnqxQcjR+udoo8l2Od0tkv3r5iYkPAPAXHTCKtlhoDP0/+emYuzwTKkdjVBlzFg5pawlsBpi5QKDnq5jFSZNcyVrr4euE+xYUwrbIhl7lfZs2c3I8qVotv7f+0ZDvgovRBIJ/jLwqVOjXAEy1KNM2f9zplKBSGWJhUCWuKFI+J1kigq7HRGk31ifVBAPWDR/+T4cDhOYm+x7DLy4KQiE4IRDLG4DSkC5o8ERBvGDo8/dGBQ+OyQviC96db8FfmAgSNterGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbq5HHlFIMilIIOGj95GdvM+KKIqsQVUlBFcOM4OkZo=;
 b=eIfdszW5k5SUOlMap0Btm12n9Os1TipKGa2CMniU8l7MniUhA+WQ/U/LwGPbRZ9NQTPQyzOnfyReWJyZ/Dgi027erudym3sVhnlVHXv7PpGeh4q9TK8pYsDufn5WfZrkmL4nfVtAAStsfvW9VqRcEYyph4YX2qosKvMuO3tefeBpAXaz09bL2y/8SVs3nT0egFGlPayzECjelpQPOfRYynhZe0iGb+ImMrZZO4cBq+kUSjI6taQv3gM39PiwLbm1hSut5n0AK7YhyUtwk80AcrUK7i3bPDMkR/kAIJlG5CQTVry56C3yb0BMBSMhAvRe/GA78CdCNCIbvBguBrvYPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5673.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:479::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.7; Sun, 1 Nov 2026
 13:56:19 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.006; Sun, 1 Nov 2026
 13:56:18 +0000
Message-ID: <8ecd3d1a-86d1-4f39-b175-b712c0be6eec@siemens.com>
Date: Sun, 1 Nov 2026 21:56:03 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Subject: Nested dovetail_fault_entry/exit and mark_trap_entry/exit on ARM
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e90a2f-1665-4b39-5120-08df381fe712
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|55112099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|261021121427099003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Cye61I45nQpxWn3wFxq9OjAMxMMhu6vhchhSePx9MVgQZJV8GP0jS1SZrr3ZsCTPyS4LReFYLL3xjwm4OITdz259OptOi3F0EQvu0eYrjw8lX1u535EUST6iMFMbDvgCxdqpfvRBASI2qNBfVdOSu4kQ0NEv0TfBpUhUkwfxQo0fE4wwiIZSUtAEXLLwkDyXToxy4uqbnImkqGjv0pAiXUNL1AzNQmbnYLNA9NWJpdFvr2ytzrRHoX+/hEs/eLhs+9oRTwL2AOEaUYYbvD8Qc2yESY4MD1fr9HC7nfymuDyPHh0zavF2cZ3dS802jMEwBZabBhuFMm4M16JqAl4PqKMXIpxaFwE0rrXxgnl6yW9N+qDyFl18bgLLYhOqVFcwEYxw/OXZne43w2Ongov/eFljnU37ExO23+syqdz4BMcnBYQqGR/5eReoGuxrbXhd3bLGFAw8Yzrz40nJAKTrUaRNyzTmwPp28QeHfXlUrnX8iczuo4yx4WEZnKZPmbhAYae3mjuww3yZoLTZl4Tgjy+m9rh3lGL5U1i9svZLLp+h0HqXsNf5miSUpN/1Kc50aT32m+GicOwU0IRZUMAcgyr7HAgo+FvxvzeoSy9kr6P2xMaN6H9tlBf7XZ0yfpFRWVx2fgv/oX0DnEmk3+YS/e1/jlXWZXSAFSPdNcQID3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(55112099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1nT2NCdnAycC9xMDRPSG1SUC9raGthN0tEeGtHTWNHdWZnSDF3YUpmdkpV?=
 =?utf-8?B?aEk3YjExck5KUmw1RkR6OXNpV3Y0ZzhYQ2lYbHY4V2JHVDlYVnRGbEFlNWZS?=
 =?utf-8?B?VWVibnVPS1RRY3UzMHZ2aWRyZmkrVHNsYXQ4WDRmMy9lUE42cWR5eE9Kd0Z3?=
 =?utf-8?B?MWJpak50dSthNitzenJ4blRtK2t3TS9Sa3Q2ZW1JRmFSL2EzMEthaWhXa3Ns?=
 =?utf-8?B?ZVJLWHBrcHc2SUdmNGxyQmJGN2JkOWtmcVd0eVhoN3VTenpKeXd4Ym9ibFB6?=
 =?utf-8?B?ckZVK3I3QjMrbm9HeUltcWdTc0xkTWk4Ym96aTNBM1BSU2NUZGNtK0xZMlhF?=
 =?utf-8?B?S21lM3I0Z2JyTWZqbXJlZ3I4elVUTlBMRWJSNlljUEo0YWNCRkxkSjJ2eTlu?=
 =?utf-8?B?Z0E1YUtDR29FSmlrU3R2dE9kdHFYL0g3ck9SbUpGVmpWN0xRNDkxdHhLR1gy?=
 =?utf-8?B?QjNCY0FnS2JXTXdzYUx4VkQxRUlyWkxURVBCaHZZTUxJbWdHM2tNUVJnRGRv?=
 =?utf-8?B?TklaNmc4WEJXSmh0bU1ScjB1d0lMUmZkRGducFMzMjRGb1htWm1Db083UW5S?=
 =?utf-8?B?QStQeW9iUzlDam5sNCsxQVdxVWkzTUtTbFZtNFo3ZVkxWHpVS3JnaDhiblA2?=
 =?utf-8?B?elhWNUpvV2pBVTA4eTFvUzJzQ1RLK2VmdFJQVWFKbTBZVXc3TytRYWhxeVVl?=
 =?utf-8?B?NDlRMGlXQzJXOWcvN052cW9wdnNkRFpjYmhvQ3Z0djBlb3RGckEyQVpTY2E5?=
 =?utf-8?B?bk1IUFV4Q0pXWFAxa2l0d1Z5ckFzZndHQS9aS1ZScUprVG92M3JrRnhCYjJF?=
 =?utf-8?B?YnVZdlpNYUpSUSt5UEV3QW9RMWtkdXdDekZmYzhDNUV6V1dxai84b3R1YTZr?=
 =?utf-8?B?Nzd2SGlhbDFxbW5oeGV1Mi94bUVqUlZEcGxoK1A4eUl2dmJjVXBleHBkcXhj?=
 =?utf-8?B?RzI1Q1RreTJMcWZUU3Bab0pEakNKQndEZzBtOHRzWDJObHpIZndRbi9iQWtM?=
 =?utf-8?B?M3l1OEJ4d29STUtYdkd5b1k5djU1RTFaQTd5NzhUSTBKd0Y0TUdjSjZVc1Jo?=
 =?utf-8?B?dFp5NWt4bWZCaGs4M1k0WFFKNmxFaWFFcm5MVXgyMjFFS0Y3a1VFOWtCU0FM?=
 =?utf-8?B?VjlJQWtHNlg2N245UTByVG4va2xxdi9oMlNtMUlRZThkd3oyT1lIQTB2N2N0?=
 =?utf-8?B?SGhiSHc4a0p6STg0Q2VFTi96MS9mWjg1RzZONHhJKzMwWVYxTVVUNDRTNVM2?=
 =?utf-8?B?aXloR1ZQVlgxYWdGWC9MVHlUMm4vT2dubUFDK0dGNUl6b2FKZ2YyYmxBTGRB?=
 =?utf-8?B?ZHY2N016Zm1Dd0g2SjA2eWFCYzdONzNMTE1NYVpSVjM0Y2kvYXl4MXNYQ1Uv?=
 =?utf-8?B?M2FrbmxPdmlNM2VmUU0wdmJDbm5mMVduODNRdWRabnpKL0F5U2ZQbUIzNSs1?=
 =?utf-8?B?ZmNKNUl1U3IwTXA3WTVjZEhoTTNxTHFBS3lnSnhzY3pVMlozK2pnVmVUbEVm?=
 =?utf-8?B?Snk5dE9mbHloTWRON0IyUnRqSmFFWEVMcnRvenEydmd2Vmw3NVlsMVVjWE1s?=
 =?utf-8?B?U0s3cjRueWpsRHA2TTQvN0R1ZEMyd2dWczVTZmgyNGRCRXg4b0VWcTVmRk5T?=
 =?utf-8?B?RUhmcllPOG8xNjUrM0NVMlhYODZ6bUhraDJ5cnpnSkJWcDZPdG1WUkphQlNt?=
 =?utf-8?B?Z0RGYnhrOUNzREFDbE1nVzRkUkxNaGpsRCtUTWtIb1I2OEpVaC9qdC9vaWk0?=
 =?utf-8?B?U09xWE1JZUxLTGtvL2g1TDRYa0NhdFU3RDdtVTM5YVkwM1dKcVpDL211RGVG?=
 =?utf-8?B?RUJSNW1CZTlESmgrUERvNHBrcG1ORWltajRhdTBkYTFOMXFxbnBPcFk4Z3ZC?=
 =?utf-8?B?ZEJmd1NDV1YrNzUzNlFpUXpuQ3ZDZUxMSTlqYnlZdDFhZ1kwMFY0UGpxR1pz?=
 =?utf-8?B?dGJmeEI1L0lMRlV4ZmlmbDZMeUJSSWJhSm9EcWhFQitpOHVqamFvMnduWDM2?=
 =?utf-8?B?QWp4bFRwa2VrVUVJZXBEajl5dkRwRU93cjd2Y1dlNzA2c2p3bEVvK2hMWVRY?=
 =?utf-8?B?UU0vZS81b0NWQkpnVytueURGdE9jWWdxTjlobi9WbFhqMG1WckJFTlAyWGUz?=
 =?utf-8?B?L1FvaW5GNnZZeVdxQWNaSUtYQWsrUXJqbkRLdFZFZUZIdmRiWTA5NndlL1Np?=
 =?utf-8?B?WTNhdXlieG8xUXVkVEhKanRWYlA0c1VHNUluVlFGSExYRk8xdVYyVHo2ZkVE?=
 =?utf-8?B?UjVOajg0TDhQTjZmamw4RklMV0lOdHZTdzdDTjlxWjMvbnM3dlZPdHpEWE5K?=
 =?utf-8?B?WE1rMzN6MkhzbzJEaGNhME5pdlRHZjBFcXRhRHI2dUFxclBjcTVvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e90a2f-1665-4b39-5120-08df381fe712
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 13:56:18.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlP1Jlumw0ekIaWJqNb9pASuRZ8NwCxf51f6mMbB8Kz+FSiBhIPNGmrscOCRnrKVY1mFR70vdWz1jIbALt6eHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5673

Hi all,

while rebasing 6.18.y over a fresh stable version, I noticed some
inconsistencies in the ARM trap handling in 7.2 / upcoming 7.3. I
vaguely recall Florian once noticed that as well, but I do not find
traces of that right now.

do_sect_fault calls dovetail_fault_entry/exit around do_bad_area,
declaring this a ARM_TRAP_SECTION. However, do_bad_area also does
dovetail_fault_entry/exit with ARM_TRAP_ACCESS for __do_user_fault. The
other caller of do_bad_area, do_alignment, performs a
mark_trap_entry/exit(ARM_TRAP_ALIGNMENT) while dovetail_fault_entry/exit
does that internally as well (but then with different ARM_TRAP).

It looks to me like the inner dovetail_fault_entry/exit should be
dropped, and do_alignment should be switched to
dovetail_fault_entry/exit. Or are there catches?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466691;
	b=QmyHxoKnF35gVJWv9iwRj6pSnkTOdVG3vsC+9nc7XfPTdR8Y6nXU2YTLyLKAguC2NBVG
	 WPj7poLbzDmeu/DuLzii7cTzzVQMf8noPl1hPiKrGes9ha54G2fV+5lh1XyE1WDTr8+QF
	 HL1rLG0ax2sRr53uC5meqNFdPhrlnJPCLHYAPxfba+1eJZDyi+PKr06LaSKBMkgPfeBBT
	 zJpoeXyOXtxrsiQsU99qfkOOlLBgEr5aqmMPKhWiUoC0ekgDQdhGcYxSe4wOUsWO8rQKQ
	 MbpR7Cf01u3WBaHd9zD6xpOWAfclZxAOD1akk+32As5ReLUDubSnmFcpRKll3CR35AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466691;
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
	bh=1j/LBWGwqeY9u0pIKPTLwRSFmYYXCjD7Kj+SFY5dq6o=;
	b=tPC+Rtd+2rCW40mlfHOE9kG9npKT/uOy4POScCh3dIyNQN0yWX2FxCRZJv19kXPMrjFU
	 2OzCYQiUXonjJKWbH1Se/L8KVA70WEX2oFNOX5Z+VviJPFzfMJ5UsTIcuHsjyV1lK9yC0
	 AYfOahwNcGJAX+7lXFD3SkVRp/ZMSbdczH7FlY53+mskmCpUP0PWgJlGFxijerEu6WUGN
	 WF2PwmiNW5dPh5XwilaE9A8DlyJJSd12ve3YUOqGRD41bPgHJ+47REwXXaceL32SdHqLX
	 KxYP1S6y5s6KM7ToshrxZyGcbwLevhz2L6xFS2tcUandTB+AYIkF6ytVnzsYJohBgqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=flA51JMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.65
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97555606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 06:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97555606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=flA51JMf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKtcmOAt0t6YrMaFyuzMh5glkPe1j9A2noAmVLxQdDfFbQBfHLvou/5rRHGSiaCHndVTGDGoDFVT3C18zZC76w4NUjtdYDpUDCFZ+7k2pJwa1FC5z2q2wnXa2ZdRNxQvNOm9aKN35ncI1miYQzLtl37FQWVJnilFKyMvqVLFc7cJdnIURb8wv2xaWmAzKQZSa273cId3GnDuXgYAofGR8tmPAdrcLZTv6wHSwV2ZvaKeidHqEb4slLDnRRZ1YiVH0KGsBQ6JMrmbVlpHsvbvnmRKdVVsG9YcUQIESAUA94gODvgJ3XJtugyH+PXtRZdtdYIDxQGEjY2FoH8suIgteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j/LBWGwqeY9u0pIKPTLwRSFmYYXCjD7Kj+SFY5dq6o=;
 b=FDK494+JVz+oQhKrgUg856XWy5ve903zMJafZP6UAgRdshLZMpsvcGSimOLFDVJdi3VV/cFn/UjnnjEv1rTZWqUS4j8PiW030f9SHBA/eYmpH3P3qWdnyuEqsA1ztKINmI3Ro2bv+zZPZsikfsMoxWPR/OAXHB2IiY5wmmYaCTRe6L8AOf+87r+gZ9sSnVlSyuq4hDERveOz1QYnICnU+MHs/nDsg550CFCcaZs35Hcf3kyn0m7qC3PGmNcOBwTP7zTFD/pRIuvIaZlIcLiKTp7Xk6f+z22jh4n7wPO2bY1/zbF93gKZ09t4pN1f3aWjWt9XnthGhuMQny+30L/fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j/LBWGwqeY9u0pIKPTLwRSFmYYXCjD7Kj+SFY5dq6o=;
 b=flA51JMf5guT/dMwFob7zgzwoQMoN8gUxMEZyrHdRs5Ed78zcS8ouksW5oh/LdITsMHlHJY23wYP6mt7EYpWLB4lAP04Z2Wv7NdPg0+LUDchOjobpoFPkHjSVlwClmYbAXPjwSXGs5XJpSw1PnWnX6yVEBZoj/x1QLUoPTIyFFmE6CpJtkNwsxsBZs9c/ee6DToNFBC9QSbnWY5NmGaELpXfh0ELV0/0raKyI3HAXn9SJRpNR6R8uGOZoGBYDPc3cJlZykaRfFIrKl96J4nyzmJ0akWtcoucxasTqFwGSpxt11rp4m+wOx6ZxvqogOZ9EHB0TUSZOJPiuvPbWKyWHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5330.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:338::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 06:58:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 06:58:05 +0000
Message-ID: <21a5d7a6-876e-4dc1-a660-bae4f75d3217@siemens.com>
Date: Thu, 12 Nov 2026 07:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: local_irq_disable_full() in x86's __bad_area_nosemaphore
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
 <968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9de72d-909f-435a-71cc-08df408a4d63
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|261022105027099003|10067099003|11063799006|261021123027099003|261022075727099003|56012099006|261026121527099003|4143699003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WL9Y7Tdoe5nNHXRUTAiYgta5BxWM6XEfM1N29SK81asiJTsN1Ltx8rA5IRrjyyJGL2RoSrAN5SM4TzZTgTV+fyHkiwDYg5L2HJtxhXpUeIeyeDtjrU9Ivs0P/HEUzkXk0bD/LsgIulS1dgKvjBgcpqcI+yfpSMdtA5v0zfEAjY9EM0RGxUvIQcY6jiODKO4Ntuz9PLZfEq/+9dvbRd68NXT4wxnaOeE1FbdtlikdjG87Z76n+wFzlRfw5R4XrGpAIR175mgK4Hdiy1Eh+3CrMLRsYDD93yqYClF545nXvKBOjquJBUfpaKsrbK4pZPQAD+R6BgM+DMxae7zRla/cYRW3dedF48hOcgBHYuUQVoRUWYeb8DZ89OfpSucsD4cN2O86yJL31Pi1+BavBPsj3DnBP1V+r8scgI6DCoZOUSnIdDRgGQQepp2gsgG+qO9oLc6EW4EmeG1/v6UZdDo32k7qhU2v1G1/5I8P2WsLxwSM5EQ49Pw5ZGrTm24ZfCOGhX+hNV3Gqt/y8/jKR4lh7lvGE/EJGyiwFPZ75xP5SLmOf/PyGMld/qZBsl/IqEC1ScAS6bDdOM6J+RfgAEiXtosD10hZ5uMx1AGjXsfcO8zyVsUI7DSrk0oZzS/dbYnFCIDAn0Dnb8z66tqgnM1pVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(261021123027099003)(261022075727099003)(56012099006)(261026121527099003)(4143699003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekN1NVJJZUQyRjByWEFTMWd4NWwza0dGZU9vNGhCNFYxUlh3NzZ4cmtjbEh3?=
 =?utf-8?B?ZTZHZDAvT2p1ektsSmJ4ZXhYQ1gveHFKWmlZazM0SzRBQlB3WlNNdStVTy9S?=
 =?utf-8?B?cmNMblBRU3NreG10WGVxRHphamNKZFNZNGc1bnlLbStvZEttb2xSMCtBSG9K?=
 =?utf-8?B?cjV5REQrc1pDUEllSk4vdllrMWswY2pMMDM4VE5FZGwrb0RDMlFkNCtHNUZx?=
 =?utf-8?B?anJiZ0RxUGc0bmdHdFVodkNUSDZxZzZxQzRsd3RmMDVJNk5DaUdiN1d2bi9Z?=
 =?utf-8?B?RHYvYmxuNjFSZUdlN0JJMnQ3aXJZNnV4bUNqVTR2K3ZMVGlDNkhLb2lkSmdp?=
 =?utf-8?B?dXFjamdkVVp2ZmF2QVB4ZStKK29LeEhTWEVLVUNyODlOQ3BUMDNzamQ3R25s?=
 =?utf-8?B?cEJNQjVzaFI0VDc2TFpZTnJRYk9abHhwM1lRMEM4NU5KblhiTEpEazJPZllt?=
 =?utf-8?B?OEw1NjRJNFBndkJMOWl3V0V0ampjeWNYTzNkUnB1R1VzTkRrQ080cTUrQy9k?=
 =?utf-8?B?WmZwYTBrUUdKMzd0TkhqbmZFOTgyNkVpMlNmWDVRU3R6YWVzcnFFcE92SUxx?=
 =?utf-8?B?UG8rTmp2VlFwYzVsUDVsS0ltMCs5MXdkb28rcm93M3ZTdSsxeHlFRWptclJy?=
 =?utf-8?B?LytZOHA2TVM5aGNMWW90TTNYOUtWYUVVR2RORUFtUzQrbEVMK3VpMTdXWXIv?=
 =?utf-8?B?Z0djaGtkVmN0dHNkdW5YSzdsRkRPb2tzbDI4dUlxZEFwWnFqL2c1UnU3cEts?=
 =?utf-8?B?MVFpeFJzUWYxYUowZ3RRZ0g2Rnc5SzFiTStrNy8yUW1XUUVzQzQzOVk4WnRl?=
 =?utf-8?B?TEx0b0E5QlBQRmtrbFlieDMvelFVWTNsYWNDRlRxdTVJVzBTQmZrTUlHNmlv?=
 =?utf-8?B?UnZVL284Z0Y1ZTJtU010bWptQVFVTmJ5SkNyWVBEM2drNGt1aW1NekhZSUl3?=
 =?utf-8?B?d0F6LzM5aURIVksrS0JKQVB6SDZBc3RmYnZodExSUUtCQSthZzNia3c2ZjM1?=
 =?utf-8?B?UlAvY3VGSTZDL3dnUFl1ZTdWbndKd1pHbFdFTXorbjdmdndMYUlmVmt6anc2?=
 =?utf-8?B?TTY1MDVXZG5DU2xLUjhRRUFjVEVZZU9TbUo3bGQwK2VGRERWNVhyWDl0NHRY?=
 =?utf-8?B?UzBQM2VPbk9nb0FLOXYxMlQzZ1NCRHJIUWhMWVJleVVvZFFHbXhwWGgrK2FS?=
 =?utf-8?B?aG54YU9QOWhCdVZEdlpQendwTFZydFJDeG84QUU2QU8ycE85K3FRNzRFYktX?=
 =?utf-8?B?NEljOFVWZnpIZW1ldmFhZkZjL2E4aFNiSkJIRmczblpXbGIvOEVEc2lmQ3Yw?=
 =?utf-8?B?TTQxeVpxRHJiU3BEc2dUbWsxMGRCQ3hIdjd3cVp5YmJqSlhRODc0R2ZISHBi?=
 =?utf-8?B?MnV4MXR1SjFaVktZaTlwaTVYdC8xalVMMGRZTFBOdWxSc0thdG1nekhKVEpy?=
 =?utf-8?B?TFZLTWNGU0VBNVB3clc5NDdsalloVlRDN0hqaEwvV0VvQTM4em01WUdpaS9x?=
 =?utf-8?B?QzRpeXI0aVhOc3pyODY3RytvZ1RKQ2N5ODNkeXRNWkY5VnZRSHIxMWJPSzJC?=
 =?utf-8?B?ZkxFa3NJRXpXY2NiV2NHckR6N2dubEpEK0NoRjdxbWgrYllVRjZCWE01czRH?=
 =?utf-8?B?dnRsMXBpNEZPVkVpa0N2b1ZyTC84aDJBQ1c2cFRhWStzSVFEbFE5NGdNcUxh?=
 =?utf-8?B?R2hXd3I4MG5HU1Y4RzFLL3ZqbElJNFFLRElGcndDeXpNK25wNHU0d1h2SWR5?=
 =?utf-8?B?SXpHTHJKRTBldXgwd0NmQ3VnZ2ZtcFMzVnlad1JwRjFTZ3drSGZZaVNIdnFn?=
 =?utf-8?B?V2dpQzc2OGl4WFBqMFpEYUtGV0RZcnFlcUNWN2VjbGFDbHdpSHMyMmpOZW5M?=
 =?utf-8?B?eXdxeUJzSDBlZzhEOWNWQUx4WGxSdFMrZ0t4TmV5QkJaM1lsM1NZck1zS0hl?=
 =?utf-8?B?aTE0VzF0TTMwdnh3QnRZKy9kSjZrWTJMcWFVdlpTUDJKUDJNZ05RT2dzcXlW?=
 =?utf-8?B?MDNET0N3clZDYXUwYm5tcWlKZnhGZ2cvYzZ4SUoyOEF3VWV2TWp1UDg0ejVk?=
 =?utf-8?B?ZUNnRGhWWFNCNEtyanYrU3dzZWZaOCtJclZuU3JBakJqWWI5VDJVcGpyVXVl?=
 =?utf-8?B?Ri9LWVV4TE5YTjQ2c0wrcnR3YUdORUVXeEZUT1dLcG1LSW15dWFYak0zNWxK?=
 =?utf-8?B?eFgxQk9OVUhmWk1jZGhJMGRkUDhpcDZOZFFJQ1JvNE1FMnA5WEpNaWV1emVO?=
 =?utf-8?B?bGV6dThSUDcxTGtXSDY3MjNnL2duendDYzFyOHhSVjA3NXU5MjdsMzBWY3VC?=
 =?utf-8?B?NCtWeHo0aEF0dzVGQTBUdnJPbEcrV0lVRFBFZjBqU012RkxZOUV1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9de72d-909f-435a-71cc-08df408a4d63
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:58:05.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igT/MED9WZxJeIVC9gvzoux2bE+yOiU4zU3EToWlWh+2BiRgsaPZo1jtiUSNXew0sgOFkTEg8oBHgKhl0aLnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5330

On 11.11.26 23:57, Florian Bezdeka wrote:
> On Wed, 2026-11-11 at 13:58 +0100, Jan Kiszka wrote:
>> Hi Philippe, hi Florian,
>>
>> I start to love pattern-matching machines:
>>
>> Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2, we have
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index b83a06739b511..024a67bd2de6a 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>  		force_sig_pkuerr((void __user *)address, pkey);
>>  	else
>>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>> +
>> +	local_irq_disable_full();
>>  }
>>  
>>  static noinline void
>>
>> The final code is
>>
>> ...
>> 	oob_trap_notify(X86_TRAP_PF, regs);
>> 	if (!running_inband())
>> 		goto out;
>>
>> 	if (likely(show_unhandled_signals))
>> 		show_signal_msg(regs, error_code, address, tsk);
>>
>> 	set_signal_archinfo(address, error_code);
>>
>> 	if (si_code == SEGV_PKUERR)
>> 		force_sig_pkuerr((void __user *)address, pkey);
>> 	else
>> 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>
>> 	local_irq_disable_full();
>> out:
>> 	oob_trap_unwind(X86_TRAP_PF, regs);
>> }
>>
>> Do you remember why? As this was folded into the forward port, this 
>> delta never made it into anything older. If it is valid, we would need 
>> some reasoning. But this rather looks like a mismerge to me.
> 
> This one needs some more cycles here. It might already start with the
> call to cond_reenable_irqs_user() earlier in this function which is
> unconditionally enabling hard IRQs, even if the oob stage might be
> stalled. The possible in-band migration happens later.
> 
> If we leave with hard IRQs enabled, we would corrupt the oob IRQ state.
> I need to check the calling context in more detail. Maybe this cannot
> happen, maybe it can...
> 

The oracle says:

"No. With a working companion core, the oob stage can't be stalled when
this code runs, and the handler never returns with hard IRQs still enabled."

The point is that the cond_reenable_irqs_user is only run for faults
triggered over userspace, and there we should never have OOB stalled /
hard IRQs off. Kernel faults are filtered early in the function
("if (!user_mode(regs))").

> Touching the inband IRQ mask (one part of disable_full()) seems strange
> to me - at this stage - especially as Linux does not do any kind of
> "restore" here.

This is why I suspect a mismerge during forward porting.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

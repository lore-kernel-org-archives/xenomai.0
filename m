Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280662;
	b=bXs1DDiGkrd4k8glW3aEeO2mX8CcbOQMbBI1U9XP39aNdwney4AEWIrmKu0C71mB3RGu
	 VTTVtT1YEZTJZkdmS9xv7MiMlfD81J0v+DJMAafpdoKwf8nRBadpjPS8ysanJF93n8i9+
	 3AJYVMrZXdFD+bC/DRxGUgQLf0uJIxTOGxLOyjH0cwzm+1Ttke5UuUyNBrZ16vavwN4fp
	 UUbSulC/bxibe7TzLjnGM21zq1H13YxGU69m5ER2w414TOU4R8xNkJ6O/LDbLyhEoeKj+
	 AnEvZIKOSUykuzQX/awsdLB+EEyqDGk4rRdEGUbjYbDBi8/7TutyIRbnAno/ZoN7INg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280662;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=xRIpxQCbAltKz8bsPi6CTakWW7p3N1+lABTClTyvJAA=;
	b=b0jEToilaYPYnGA2ocXBcbxVTwQAzohiSDNLKFCaBhvYuRH4/TB0IExb9qTkG+J5/Lp+
	 ChSV7PTfXRt707Y9Kyw4VCkkSxk7eFoq+TCf6BrZAlDz8D9yWCeuOZ5KmP8HcKMjHzLac
	 v5ZiWeFYxN3hBOg73LQcdViN5Sq0TrrdGQPVE516rE7jXFBYV637q9oSGF8i7pRCCiRXa
	 rVyAerEFLkfKKLdWnIouQ3VldDynJipktmKK6UvFQV9NSTQHVcRpuukhzG/cnT4c85CZm
	 1Y+bkVztPVjyLApAtOL29sbCdyawBCAs4F0Xkw8KdY0ASDOxTJhcFV4TCipXQR8So6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=W5gdUeBF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46292606A320
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 17:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46292606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=W5gdUeBF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8l/bCJJhuKRdYRM+UguSRKMEvPs5AlivrAlHtIV/wTQsoMINn+W8huGkMn8iOQT9Ven9xE49jcMESeGgsEfMRC/9/SseHINPVLUnKsnYvGJwqCdKN0IlrxkVCRnRF1qHWGEpNyn0mZnBn06fLGKitvoc/MraOHKJo2nYugjnt9TcxQc/2Igu787ZT9x5hQbb1fU/9CdTve0if9megvkS9KAeJlc/nNCHToiZwh720qPTRK8tM8iSQ6/ICZJoMKXvg9fnhW8/YfONvGF6c+T6f/wciSlilcrrO1p8rzlxNDvWg8Sn07OzB5SprrKd9TCrblFNCrUZjQv0TyK4xtUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRIpxQCbAltKz8bsPi6CTakWW7p3N1+lABTClTyvJAA=;
 b=TjcLbJg6EckZX5wC0HIfUfOVAVis+s/+JwtEu7sxDHz2QicC4GMKbLV5uFV0DW5Ze/tUSc+du5e0Ftd98bO5PD3BsIrmf9po9K9FD3q+VrTtRmjF7EOuC2JVtGjnfh7Vvak5wyA7SdVIO/jB6fyt80NpOkFJMknnmV+S8m0e+wOomVwnry+F5lXrS02Yp4yKQs9DoZepyMf6cuRu3/CIyt1tsMJ6aklIyK9flmrzlykKCMKXs7Lr6jXdu3qKn9LQ0djL8tokjgDuyFkN97LCCSqgdpgQuR+sGSz52j3xF7cLkXVaUT90ikdLEbugA1Rl9IbUcURRXgkAPvTGbiStKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRIpxQCbAltKz8bsPi6CTakWW7p3N1+lABTClTyvJAA=;
 b=W5gdUeBFOOQ0Q93NMDmUnDPEexAr3KlghOGYLBAlg4PrgyZEbukhlnHSKzyQT7/Euk3yx3YvpL9eisRTA8NjdEORiCnP7dNu/vu44CkYjkz6SRWHbweOtR7VJNee93OON56aW6MW+3sRUvouKPzaoYvUFGIFpMNURpDRJ2QKuflJmARfguYtsfJUJetmyAoC39xDkugxgiY6BU+JEQxJ/s7t9eNRnsi7zJP5hPfgxoP/VwlSoSAOXxaHSLTnCeFuapgrQb9c99cx/LjAUWz9HmEhlrEvnTCqdnfJqMPoMRwvtrnFeLAbQqb4pFJyd4ijeccs1gOSFzPUazyW1EfDJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Sat, 21 Nov
 2026 17:04:18 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 17:04:18 +0000
Message-ID: <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
Date: Sat, 21 Nov 2026 18:04:39 +0100
User-Agent: Mozilla Thunderbird
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
Content-Language: en-US
In-Reply-To: <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe6f785-dad3-4b15-42fb-08df47f17aa9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|261022075727099003|4143699003|56012099006|261022105027099003|261022113327099003|261022115727099003|10067099003|261026140227099003|261021121427099003|261021130227099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	X8+wwL14JJLFRK6Uno/LI6ESKIDpxsjavaa3GdMK+lYQmSJySgEWqeK3Izfz3IlC0T3+pyCP58ODmJThBV12HQiJL3B2MG/LAPA2zyt0uhTogmt7i8RHNZikaAn4n4DWEx/PUGyz8Q/c6LXsubT0NXPPfPDDdjGqZa5fcZc/PWaqu/t3YBQkw1bIhaqXTaZZWESuoOf8TvO57dmaisQxyPp79Lo5dYnoX2LjnwgmUQewVUywWcG5CYJB2uU1MHNFlsrFwhji0EiPEcvO0eHcpemTQ6ZbKl0MFpp0zI8FrfEcKe+2/bfy6uiJVMmYadMkQmC79QwAUdZOIRgLzqlWiyXKDfSEn+hz7ke5NhUeWIvUa0JYxv7oqVl4voAbg8Yec3UrtrGStt74FtHKQYNAbINJNNAq3TQrjpGSPUDsJtXryc+9df/DtTpOjB8G4rz5QkzdSDzRjff5Kz/0pOdI54ZS1Yaw3LRUINYor5IrCJImCvZd+7D9Zq2Im9vCEYQMuy21+gihx4pMe9LyW4efrWyLL4rlOp9w6kK/KhinkVPOzpnypTbI2h6pk0HYas45Oyt/WQjr8zKcF6geMiS6ui47GJUhU8K7G0U9CK3en1oC+hkU0AtxonEgFyGQNcKL0BGl2EpTnbLp/LWhIf2k8SBCJP86MOCVHIDWZdOi5cA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(261022075727099003)(4143699003)(56012099006)(261022105027099003)(261022113327099003)(261022115727099003)(10067099003)(261026140227099003)(261021121427099003)(261021130227099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHAzcUQ4U3JkeTExc0Q3b3E4ZE1IUDI1TE5jQmVBMHNXNkFkOWEzcXpIY2hy?=
 =?utf-8?B?RXhOVlM2UnIyU0I4YmxMQnVhZi9VbWtFNDZ2NzJtT3ljZGViWWI2d2hyK2Fm?=
 =?utf-8?B?MTJnWWoyWVFCSFljK3UrVDlidE8rbXRZTk9uTzIwRTNmUFFnN09xV1JhTDdJ?=
 =?utf-8?B?QXhCWEwvZ0JWY3IvdTJabWUzVm9TNitMWUlFN1ZvNGpPN00rRGVQZndLTTFZ?=
 =?utf-8?B?V2c1ZmRPY016TUlFdmowWmtvaVh1OGlhQkh0QjEwaHZRNmhoMHorVHg1Y3VB?=
 =?utf-8?B?VktjaVc4ckd0UXBGdWF1dG5FQWZqWEhnY2RJejdUTklNZG9NZkwzTHdERy9R?=
 =?utf-8?B?RmpPczl5bzZVNmFSQjJ2WnI5M0JoNENmNUJEa0JSbWRqUlBUb1M2R0RWalJQ?=
 =?utf-8?B?cmpSTk40OGFsOEd6dG4zdElwRGtrYjZXYzhLOHc0cnRoS0pvWWg3L0ZWcXYy?=
 =?utf-8?B?NXAwSUg3My9ZZHRNM0g5V1gvc2crcDlQWjMwOUlBMmc4UUEzRXBSUEc4N2ta?=
 =?utf-8?B?cnRKVUZubWRWY2tlTEljalpneXBuOHJybVV5cnU1SVllNFBuRDU5Uk55REpG?=
 =?utf-8?B?aTZTdUFZcHRJRHJPRDhPNWtJdnIvQ0N4eFF5RzU2WE5COGJxYnhGUlVYcHFV?=
 =?utf-8?B?YitNTFZGREV2TXZHMDhRV3hpUGhhNmZRT1Y5bmdrSTFTR1c1cmJrODlFTWFa?=
 =?utf-8?B?L0pTRFg0YzJJQVpRUWNLd0t4Z0VEd1g0NGZCZ0ZwMlU0ZFpkcVRXYTNYSnpi?=
 =?utf-8?B?K3dmVmpXMWFvc011TlJ4bjlKMHg4djlSWUUzazgwUnBNb3lFV1AvbzhPZmlD?=
 =?utf-8?B?MUdnclRIY2hUdzJ4a2gxaGEvajhlWEc0MEV1MG5GS0NVTkJOQkMvU20vakJp?=
 =?utf-8?B?czYxbHFQSkVJOVBzMEE0TmNPdmtnNXR2TWFPU0ZadEJ2eENkNzMwQU5yMGhW?=
 =?utf-8?B?NzVHUWpTT2N0L1lNVlRaajQwQ3h2OEs2enZWWFNkVklLMjJYRU80OTNBQ0Fz?=
 =?utf-8?B?TXNoS0NvUll3TlV5ZXpHam1abTYxUW02RzFaaVBKT3lYU2czSzh1Q3EyR2Vw?=
 =?utf-8?B?dmZkT3AvZUlBcnBqRlpsRU96QitvZ2VQSTVzV0hhYVJ6NGxkNGR0ek0zM01H?=
 =?utf-8?B?TTBoOHlWQkttL3VvY29vay8rKzBGa2VPS2VaMytNWVB5R3RTL0txV2NuZkNl?=
 =?utf-8?B?ejUwNE1Dc0FvMzJmaEZaS0U4MHR4QVNRMzlhZ0IrNXlBbUU1ZTBycm8rZVBq?=
 =?utf-8?B?R05BOFUyTUgvQTk1TDk4Mk5KcEl0S2tsdERjelh0bXJSZkJabVdmaVl3OGVi?=
 =?utf-8?B?UHlwQUMwTzFYVXgzT044SG4xSCsxaUZBbC9CMGRZeW52ZWZwUnFrT3d0K3hx?=
 =?utf-8?B?aXdqMmRCMUhSb0VFS2t3Zi83MEU2YW9RVkdOMFpMMk84MHdBQWZnMlljUmJE?=
 =?utf-8?B?OWpPTXh5dWQ1dEtiMlVwcFcxY0RRQUpkTFFObWJwUmhCRXJRRkNkS21yVEVC?=
 =?utf-8?B?UG5kOTBYeitvbnQvbEVpM3FUOHhIUGNpOHV3aEtkMmZUT01sQkxZK2VDMFEw?=
 =?utf-8?B?eHFhSSt0SVpCYVpTOTFXNEN1T0RqSGJYYkx3c0xnaVdtVU44UTB0YWdOQkQ0?=
 =?utf-8?B?dG1UUEhrZjVZejFDTWdMVGNHaXVRMUhHd2pjaHJiNnRqbWJYZmJ6NmJEc1VJ?=
 =?utf-8?B?czVkUmw0THk3SGhzNmh5STU5MG5pSzRhTkNzcmpiNEFCN05EVjhHOGVFaTVP?=
 =?utf-8?B?eS9zL3d2TXNYSWhiSEdWdFMzSDVyRkdrQzZOcWhVclAwanBoK1J5SGtVMGxl?=
 =?utf-8?B?ZHVtOE4zVkg3SUo1MWYzaWJ0RUtjcWdLK0VkTkRRTHZyNk9kVGpWSytQc29N?=
 =?utf-8?B?b051TEpHdm5PaDFTci9LS05LWUtGTEFJUXR5R2RsanV5dlk2VjNMeHVRRFBo?=
 =?utf-8?B?TXBxRkdta1NNeWRxMitqTzNtYWdOZTBMaWNVSGpKRzhWclk5eXV3NjdTQlA4?=
 =?utf-8?B?cjJXbTRENVZxWUVoWHc5Mk85aGdGSi9qcWdlRWtsTVFyTTNZM2FsSW5XdmZB?=
 =?utf-8?B?M3FHT1A5NWhjV2tZRklFV1UvdUxoOGgvZzY5QXA4UnlMN3pZSUI2eEJLaWxo?=
 =?utf-8?B?NEZFMktnblFUbXJyN1BsaGpWWi9CZ3BKbFhzeS9sTnNRajE2cUNoZ1gvMUhM?=
 =?utf-8?B?M3B0eCszcEdwcUVjeDd5UmVDMXFISlFrNTU0ZHhnc2h0dDdHbVdKVlYwRGpn?=
 =?utf-8?B?TTFmeFA2ZEFXemVveXp2bW1JY0lTREg3aVhkZi9GZENnbXR5Wm5UcjVCcHhx?=
 =?utf-8?B?RjRhSmZYZGFxWnRjOUZLWkYwNXZPNUFycWlsUE5mNTJ3U1RZL1VISFNJQ3Jz?=
 =?utf-8?Q?jZri0fKqciQGaFWpq+9UU7seoGcrASAdX+UzR49nWJpPB?=
X-MS-Exchange-AntiSpam-MessageData-1: B6KmmEAx3OQImZgIqimArKidv/ysvKLD/YY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe6f785-dad3-4b15-42fb-08df47f17aa9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 17:04:18.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCJsWDewP5YWL8lx58KFcNjjg8eu0GGxRCCfWq26RfDskzl5jcC/c0AM7XIh3hTP7i7uXnCAvVSM2DkdYtyHrFbc14er291+sAfZ1D/9Q9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

On 11/17/26 18:28, Jan Kiszka wrote:
> On 17.11.26 10:27, Tobias Schaffner wrote:
>> On 11/12/26 18:44, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> A thread running in primary mode which takes a synchronous exception must
>>> be reported to the Cobalt core by the Dovetail layer exactly once per
>>> trap, before the in-band kernel applies its fixup. Cobalt then relaxes
>>> the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT when
>>> asked for. Only the page fault flavor of this was covered so far, by
>>> the sigdebug test.
>>>
>>> Add a test which triggers one specific trap per case from a primary mode
>>> thread and checks that the expected in-band fixup happened. Most traps
>>> for x86, arm, and arm64 are covered here. Left out are those that are
>>> practically irrelevant: AC for unaligned accesses on x86 and VFP
>>> exceptions
>>> on ARM. Not yet covered is RISC-V, but it should be easy to add on
>>> top.
>>>
>>> See extensive AI generated explanation at the top of traps.c for more
>>> details.
>>>
>>> This test may become useful for checking future OBB trap reporting by
>>> extending it only slightly.
>>>
>>> Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kiszka
>>> <jan.kiszka@siemens.com> ---
>>>
>>> I know this is huge. Therefore, it is also something that we likely would
>>> not have done without LLM support - way too much effort for testing
>>> corner cases.
>>>
>>> I went through it, but not in all details. The tests fail when they
>>> are expected to on unfixed kernels, they apparently pass on fixed
>>> one, at least on our CI hardware. "Should be OK"...
>>>
>>> BTW, if we merge this, we implicitly document parts of our so far
>>> unwritten
>>> AI policy ("yes, we take generated code"). I still need to think
>>> about which of the templates out there to use best, then I will propose
>>> one.
>>
>> Hi Jan,
>>
>> Following your input, I spent some time last week on RISC-V trap
>> handling in EVL. To verify the proposed patches, I ended up with a
>> similar trap matrix test generated for EVL.
>>
>> With the number of fixes we can now produce with AI support, I think it
>> is right, and important, to put more time into test infrastructure.
>> I think it makes sense to pin down in more detail how Dovetail and the
>> co-kernels built on top are supposed to behave to make sure this is not
>> changed by AI without us noticing when these tools are trusted more and
>> more.
>>
>> I am asking myself if we want to keep some kind of human readable
>> source of truth that tells us how this is supposed to work. If we start
>> generating both sides and both sides are hard to understand (at least
>> for me, the kernel side still is) I feel like it will be hard to notice
>> if the tools start to slowly change the design.
>>
> 
> Good point. I'm currently fairly impressed how much the models
> understood about the current dovetail architecture by just reading the
> kernel patches. Maybe they consumed some documents upfront, but
> definitely not while answering prompts.
> 
> That said, we more guardrails, also for models that might be cheaper,
> more sovereign (local open-weight...), but also less smart could be
> useful. Question remains how to encode things best to have both side
> understand the same.
> 
>> In addition, I feel like most of the tests are Dovetail functionality
>> tests and not specific to cobalt/EVL. I think we should at least try to
>> find a way to tackle this with joined forces for cobalt, EVL and what
>> ever other co-kernel using the infrastructure.
> 
> Yeah, valid point. Maybe the availability of a POSIX interface for EVL
> will once allow to write more portable test cases or even share the same
> code base.
> 
>>
>> I think that RV can maybe help here. It would allow us to decouple some
>> of the checks from the triggering of the test cases. Triggering could be
>> in the co-kernel projects while most of the verification lives in
>> Dovetail.
>>
>> I created a POC of a more detailed trap monitor paired with a matrix
>> test that solely triggers the traps from the different contexts in
>> cobalt here:
>> https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-monitor-
>> rfc-proposal-nofixes/
>>
>> Asking Opus 5.5 about a comparison to your proposed RFC it tells me:
>> ```
>> Not covered:
>> - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Cobalt's
>>    notification to the application, and we don't check it.
>> - The counters in /proc/xenomai/faults: the right trap +1, all others
>>    unchanged. That's Cobalt's accounting.
>> - The exact mode-switch count (Cobalt's msw statistics).
>>
>> On top of the RFC, it covers (checks no user-space test can see):
>> - the handler level of the unwind, through the stack frame;
>> - irqs off on trap exit;
>> - demotion only from task context;
>> - no IRQ in NMI context;
>> - no sched-out during a kprobe;
>> - the time limit.
>> - more fault cases: read-null, write-ro, write-retry, exec-nx, bus-eof,
>> fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
>> ```
>>
>> The output makes sense cause the POC has no cobalt API specific checks
>> anymore while the monitor adds more kernel internal checks.
>>
>> The hole approach Monitor + Triggering matrix is smaller than your test
>> while the monitor part could be reused. A rendering of the monitor is
>> attached.
>>
>> Maybe you want to consider it or spend some tokens for further analysis
>> if this can be valuable.
>>
> 
> "Smaller" triggers me for sure! Would be worth to see the outcome in
> code. And we may still consider addressing potential gaps on top in the
> userland. Key is that the userland test orchestrator and stimulus
> generator and also read back the result of the RV monitor run.
> 
> But what might be more challenging: we would have to backport your
> infrastructure to all kernels we are maintaining. Is that realistic? At
> least down to 5.10?

Hmm... I did not have this on my radar... The RV subsystem was merged in
6.0 and the Hybrid Automata that I build on was introduced in 7.1. I
think that back porting the whole subsystem as well as all the needed
tracepoints would be a huge lift.

> Jan
> 


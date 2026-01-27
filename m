Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4D1FDE01
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494621; cv=fail; b=SAG/N86YkfTvKZ9Iu7zT8MNR/Oe/7ppuRJGt2HqllvGJ7bDs2rUA2GDUDknPQBn7+RnU17TMY6A8WqS0t8O9EuQWXOh2QbaGw56/SRlkiROunUpdjdyM4HiKwdz2ZvIwcEvsHzaWGwLI9MR+GOlOENND615h+jvJHNR0V/QE62I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494621; c=relaxed/simple;
	bh=DEGdPKvaEBokgNZaDRupPQssSvuU+lTu2JxQFcVmPuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXgeQ8Qx8KJwtdlxAkNxlOGD406j+HKoXRoVPX2vQff2ZyfEn0EtlfpYw87fJJcUG/P7HTA4DsKpAoqka3qrDn5iYGaKvIwK7DH87n3RRlamqPwsC8STbF/Hr8LULlSgG2JoYsvQV19l3S0y7/VKsI3zcK8l02DGLxWe8DNYAm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Tr2MMvj/; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tr2MMvj/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRnkphr2jyKm1qpUjcRIQVgK0OMNRAL8M1D0895CvJ4l2+51zrv4E0HWzOVhJ/jPz4UwHZZ6vDiNE+cCLGpncf6CTi2gNH3Rrz7tRcwpeEx/4Fp+vZsKqnAEt+pJY+Po8z6MdMtWDiEEJOeQtRgVM9SA7w8Y8FSmfbYQwDCSND05KKA1wmk38a1hg6EZimTD++5rbXtY6lV0FsJT/ql8QRY2pSA9mX+wE2eH9Im7WIs/3Y8yAi7L5Md8H7w4NSwmOVEngYjfb0oBUsbvNwZTy+y1hF0Jn5XhvCRq/xOQBSeG1zv+R/IYkOSBS/8LnM8PKtE+810yAS3Ghu0rMeIchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmwnLEYkzVd9baLbk+80+rrsnvA8rP+flfTRX6rzHzI=;
 b=PrJKrKqDqmQiUn15tkACGUkKyYVciqujeYlnWIz5C96oerfR0NbJOYEI8j3w5rIyF8bzrZdQmoGsnKfMWt5nNQBF8lz7sKzOyZcnbinrmS0YGc+molLeQCdNx3v/ExEAIGioHC+WRuU7wQfc1rDoeh88KL1MMePkapkC4HW/yfkOSlt3Hg9iz/IZnisd1fj9dlzXNI/1U9Bb8JiCUL8vVXGbS8e5BW+p4CFc/AmoLUOiJsMATp5+F47zxEa+/wWNRTAV9uWug5U1WuEIDrbONAYpDi2boPvBleP+RqBrBaLJhpf3LzfZdtzBnIfbIdX8+RUyjnpr/zGIbcGd5tkVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmwnLEYkzVd9baLbk+80+rrsnvA8rP+flfTRX6rzHzI=;
 b=Tr2MMvj/yRKezfqK7k+4U37EjlU6JtNagDF/d/7VDxD8O/4rEmMl+PPPig/xIm/NI6kgVyZRIB6qkVeLnkXInqOdQ1ptZI7V7XWyoo9Jx2antoZxXS/+EkVJcwTZ0bcBE+k0eDVS0utBAataAADTDp25mmQcVXus+yRLxilnZuGf43L7/kosRrm49m/F6XN45Ukdu6H8uG0EK/qsZk+mjAOFp1ZVi1D4AKaatwExlfzyNbdO2YAu0Rz7GApjlKIeWo9ZskcqwBRCoKaaE9MHuQ00NDIyws1ui/ffLOHQaSsnLiq0S0V0axUOT3j8eaoDJ9rZd7eQhWkIdnUgdLKbOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 27 Jan
 2026 06:16:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:16:50 +0000
Message-ID: <e0ae25a5-94b3-4d8b-8b92-faf40a5ed2eb@siemens.com>
Date: Tue, 27 Jan 2026 07:16:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CPU Hotplug Splat
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
 <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com>
 <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at>
 <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com>
 <724391155.14329.1769456288068.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <724391155.14329.1769456288068.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3128:EE_
X-MS-Office365-Filtering-Correlation-Id: d79b8661-73d0-4ac9-ef6d-08de5d6ba877
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2FMUGNUTDdyOFpGZ2RTZ2xRa01LeVJ2SUg1QW1yZzFJVWduaWNyeTVhbFc2?=
 =?utf-8?B?b0dlUml1UlFsUGtoSkRaV29sRDgvNE9GKzlNTTltZXAwVWNHMzZWMHhaZEQ5?=
 =?utf-8?B?c3poVXRFN0RPVVZNU1M2eHI4TmY5WGdKcmtHS1ZSOFFLT2dKRDhvZi9rTldR?=
 =?utf-8?B?dU5Udkh3TGtiOCtxcGZwd1hoRGtqZW1TbFIvbnJwc3BVUDhsQ1lSYlNMTUJG?=
 =?utf-8?B?bG8wcER2ZjVKNkMrRm5GS2oxR1puSmFieVJ4amZqRC9qd0t2cWlHeFZyejAx?=
 =?utf-8?B?V29ibkxvV1IxQlFZaGRYNUpPVjdjM091cmlJMkhrNytMUjJSTEVtdXJDTU85?=
 =?utf-8?B?UVBnNHdJdG0rbFdRNEJjZnFkZzRLZUJIS0tEZGVwUm5zWFBPUzdHKzgxSHEy?=
 =?utf-8?B?SDdncXFzTGp5Qmd2T3VRQm9DdC85STFiWkxEaWtQa1dhY29ONmdUdzJrNTVp?=
 =?utf-8?B?cnYrNTRpa25zTVYvTTg3c0ZNL1lrRUl2MDBGeVB6eUd2ZHV4VjdrS2Z0MWlW?=
 =?utf-8?B?NzBQWXZVM25xQzByaDBNYk1RVThHQ0NIRVVrT1ZQZGJReFpWTTV6OG9WTzBZ?=
 =?utf-8?B?akVRWW1WcjlpVWp1QTJvUytXOW5RRGIxTTJrSjh0OHppUE9SMHVjYWtyY2ZG?=
 =?utf-8?B?bkNGbW5JWFFwZW9PVUJZd2NqY25tdXVOT3JQVDZ1TkgxdDlNYlFRZmVnRnJz?=
 =?utf-8?B?MUxVUjl6WG5zZzFUTXVBbG0xeUNoSXp6UFpsWXpJRGd5NVFyanFtNVVxakg0?=
 =?utf-8?B?T1RINGdySFplWGFocHRTS1FjV2NpYUduVHFOOVJsdEhIendBeEx3OTlVeEpv?=
 =?utf-8?B?RVNOREpKSkVkV2VYeVpPdmJRWW4wN29nK3Y0UEtLb2RIUmJ4OXo3bFVVY0V6?=
 =?utf-8?B?TEhkU2RlZDE0enNaV3A5NElpSlFDeVJveFdLR1NySVFDYUlWQnpDVVhieGpE?=
 =?utf-8?B?VmFSTDhtcGlSMncydW8rbk5yRjYvZXhiUGEzYmZ1djRvYU9DZG40NktoaFNX?=
 =?utf-8?B?QmYyM1Q3ZkR3QTFTQ3dHaGVCM2lpMTBSQU1aL3oxM1FLVnAyVk1oSXlSM3RH?=
 =?utf-8?B?bTFMcWdGLzBFODY2S3dyeDZrdUxoczVjdUROeVFpT3JYaTFyWmlLR2taTXZ3?=
 =?utf-8?B?cHVHamdodjNRdHExMFlXcHZ6WmNwb01DNDFYU0ZwSEFIRjUrazFXTlptM2do?=
 =?utf-8?B?WXlxamJSeXp6Q0lXVGVqNzR6amhYS3BJVm1BRnZzekZUWWVhaEVSajg2aXFI?=
 =?utf-8?B?ZUUwQzVSazNoak03ajhKK0Z6V3hBRXk1NkV3ZXFlVy82RTVyakQva0xEK2Z3?=
 =?utf-8?B?eXp6aVVWNmV2YVNTNDJWUm5zRjV1UkcwSG5zNDNYZU9ldzFLVmluRWFNeWJl?=
 =?utf-8?B?Q3V4d042SWpxS0Yyd2hwQi81Ykh4MDJsSWg4YVpGSXhESGlKQ2loZUNRc1lR?=
 =?utf-8?B?R0FqMVRmaXVwVHN6Y1FFdFZCUTNOd1VzMVQ2aS8wL0MrTzArS3ozTS91OXJh?=
 =?utf-8?B?anI2d3dFQlBrdXVNL011bXlHcnZ5YlkzUVc3eU1Db2NYcHpaZTQ4UEdRcThT?=
 =?utf-8?B?TFQrVUNxQUhONGhMVWd2T20ycTdYdFhYa01JUmk4ZWRiK0ppVStHU0NOSTRq?=
 =?utf-8?B?Nzc4QmN5cGNJRElXQm9YbENtRWRHMHJ0SEpEQ1A2Rjd3U0RqK0ZEaUpoVUNs?=
 =?utf-8?B?T1pHRTVXdGZWaU1NU1VSNG5yblNrTWJhZ3lJZUdDdkxOSm5oMHRwNUVXczc0?=
 =?utf-8?B?SHZqNGJPSjRLQ2tQMEFYOElVYmJrSzU5NmFKNVovR2kyWmZVQ01VVEMrM1Nr?=
 =?utf-8?B?OHcwUkpLeGg1SHZaZzUrc1M5RmlOQ1ZkRExsU1ZldnJBb1U3Y3RZSTgzbWFn?=
 =?utf-8?B?clA0NmtxVCs2VDBydWhVemp1YVd5V29Oa2lwTDRwKzFmVDFheUNlWGc4TkpB?=
 =?utf-8?B?amZ4TEhscjlxQ3ZtQkFKK2ZQWnd5cG1Uc3Bpdmx4TzhVZWxzMThDdnRRWWw1?=
 =?utf-8?B?U0thQWJzQXl3YjNCNWREQVNFcDdRRW1ScHNxcUZJOG5YUUk3UndJRmpyakJU?=
 =?utf-8?B?dWh5a2NrOGdCS3lOU0FMUE1ueDkzbmNsdTU4UDhrKzNMS05GdlpBSmExUThy?=
 =?utf-8?Q?3+vo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTBUNlZqdFpGeGJ5NDJPc2lpUGRnRmZTQ056d2diRjRkb0c4OE1zYUpoRTFE?=
 =?utf-8?B?d1BHRzJWbkQxMUlYcnJRd2tGWWRCK0ZmRHlyeTJ0VitSbEhwbkNqNEJsMWlP?=
 =?utf-8?B?ZnQ2bEVnMTZjVHV5SUd4MjFpMytPemhkTS91bnBLcGlDMUNVcXlleTZlcUl0?=
 =?utf-8?B?UHhpNWxFT2pOSUxnd3RUcXAvWWdpKyt3UEFBc2VkcmJNQ3N0R2VwU3dPb0k2?=
 =?utf-8?B?ZXI2cCtBWWZoYVhWTHpLOHBwTzNzOGRnZWNVWnBYNzA2bjlZRENEWUZPSUFI?=
 =?utf-8?B?TjdUMWFlUEdIalAxdE1lZkYwRlgwRE1oSnhpNjlQM3lDaHlCLzBXVlhlMlk5?=
 =?utf-8?B?WFoxUVAxaFlkZk9vcUdWTHVucENwRmRtVzF4bWErNHY5WjZpTkgvaFhicTgx?=
 =?utf-8?B?cmtPOGlhcFA4ZHRvaXNHUVhPaHNLU1NQSXcwUTlydXRYTWZVd3VNTnhYa2hJ?=
 =?utf-8?B?dytXZzg0eE9DTVNaRXMxdU9kSHJqMlVYYnpONm9MOVRWNlFCVDBKdjFTWU90?=
 =?utf-8?B?dUk5Q3dYcGNYV0cyODN5b2FNei9xY08rSU9BdjdBUjJHVmJnc1pEdFpGTU5X?=
 =?utf-8?B?YitGOEZXRmI4SmRLM1JkQXo0MU5md0xiNmY5NkNoZW8yZEFuVUljTEx3Qm4w?=
 =?utf-8?B?S2NsNnhOWFFxQnc4M3Jmdk4rR0hRSDFWQ3VBbDNpeUduaVpac2h2VTVRT2Fr?=
 =?utf-8?B?TWxNMjA0a29RR05CdU1WK2ZtdkRreDF0TEV3cGFzbHBMWkVxaWFHTHczbU5M?=
 =?utf-8?B?TEYzWXA3T1ZiK0lldnZvTFlrVG0xK1UrVGRuZEpScVpGNHVZb2NMUHNmeTVB?=
 =?utf-8?B?dVV6QWRBclNNcnZLT0hrVVl0QWp5UGZNRi83WGRrQjBkNFhJNUVPdVRDMllD?=
 =?utf-8?B?NVltS1NEcisrK2tHakZ5Ym00Rk5wS1JZeHVONXRTMTlBKzZYdnpqTHFWQUdL?=
 =?utf-8?B?WkEvSWtJUkhnUHFudWY3WXRiZ1A1YTVkV0F0d3NjSmU3UlZhbHFtRmFVcEFp?=
 =?utf-8?B?VE01QmxxQ1RFM08yNy83SEQ2R3QzY21TamFlRWlkMWlFa0J2ZDlnS21zVmVp?=
 =?utf-8?B?QUo3aFhxVVJsZ3ViejlCMVJBOC9MU1ZHMTMvcTZ2bHhMQnNFNUtBbzRrK2JK?=
 =?utf-8?B?TU9NR2VJaUtwQ2RFcUZZUnJUZG8zeXR1YlpWNFM4VkcwK3VTR0hmMHFOK2dC?=
 =?utf-8?B?MFNCUFBUV280S21FVG1tZkpOSDNyQVJIQlgyODU1aWdVTzFUTFA0dERqNVk0?=
 =?utf-8?B?QWR5ZU1LWUV2TGkvMHFTanVDUmI5YkM4Y2dFeld4TEcxRWF0ODh3Sit2R21R?=
 =?utf-8?B?YnViRStrVUU4UnZ2VUlFMWxxc3ZSdGdPc2s4SWVZc2pFZVhDekF6a1dRM1By?=
 =?utf-8?B?eDNWd3M0NlNjbEQvajhmY202WS9idlpzNXUyKzk3cjg4VFcvNUgrTWpzTkI1?=
 =?utf-8?B?K0JFaktBQ3RLbjRZNXIwUWpYaVZMcUw4MXFzalBpNWd0djFVR28xOU1hVmg5?=
 =?utf-8?B?M2xVaStuTGEyQTZmd21nVWRpQUZtR21kUWpjWFlEMTJwaDJhcHRZcXE3U0Ns?=
 =?utf-8?B?RHJ4UkNpWlNXaFI1Nk51dThyTmN0eVFPOGw0dU5pblgwSTJlUU54M2wrYldw?=
 =?utf-8?B?Z0UrczZ1L0tXY3o2YmdYSzJHeFJ3ekQrSDYyYkZQcVU4ZCtVdW55OXRKN1BU?=
 =?utf-8?B?dWJ2NDZsc3JKeXNhU2kxZDJ6Q2RqMXB3alNIS2p1MXdkL0tiakdPZEpJQ1Jq?=
 =?utf-8?B?dTB5OVRlMkM4Q0JRS0JOU3JqUEV6L3dBYStCRWRId2wzMEZJanV5NS9raFlX?=
 =?utf-8?B?Q21NS3BNN2VEekM3UlBXUW9LbnNmc3ZPS0Q1dkV4aGNNUGZ0azJsRHJLcVRk?=
 =?utf-8?B?eDJ5endTZWN2NHlhTHR3ZDQ3MDFIbVc4MmVhdUhMbjlLSUNtNERWUjc3RlFn?=
 =?utf-8?B?YzAvajdveloveElwUHJlY2tud0UwdzhIaXBXY2tRMHZDY1hJbkpVMisvQ09F?=
 =?utf-8?B?YVhqazdweGc1WWJVc1BhcVBsUVJkUDkvbFVLQUFvNC9kZXRTYlFHZGhWZ3lK?=
 =?utf-8?B?bXJSNVhKNkxGYVFZN1pGcTBZNElrWVRQdzNzRTZveEZZN0hZUVYvbENqMVRh?=
 =?utf-8?B?dkYreFFiT0s5M3lWajVFMmU4NnpaN2pEZU1YckpiSlh6aXhjZ3NoU1NlVDRj?=
 =?utf-8?B?QnU3aEl0K0ljcXdUTVZGWFhGcEd2azJ0eXNNcFBRaUhDS2Q5SnVtZVlKeTZ2?=
 =?utf-8?B?aFg4QmhLNi8rc3UrdjNERk5INWlFWHdHQVBZWlBPR0Nvc3I5Z3oxbUhBd3M2?=
 =?utf-8?B?SjBodnhiNllYRzJ2eTM4bWJKRDF3OGpGbzlpVkFDRzFSSnkrcjJPZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79b8661-73d0-4ac9-ef6d-08de5d6ba877
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 06:16:50.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CucUP4uSTy4qfSeyUktYeQXLM5BZf6NEyxw9iopGIMdPls4mF6633eqNZc97EwpbTOTgkRClq2sSSup99oXeSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3128

On 26.01.26 20:38, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> I'll try a more recent branch.
>>>  
>>>> https://gitlab.com/Xenomai/linux-dovetail/-/commit/65f59eefa1043e9414b37312826de2a0fa07624e
> 
> v6.18.y-dovetail-rebase contains this fix but the crash still happens.
> 
> [ 7299.180846] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 7299.180859] #PF: supervisor read access in kernel mode
> [ 7299.180861] #PF: error_code(0x0000) - not-present page
> [ 7299.180862] PGD 0 P4D 0 
> [ 7299.180865] Oops: Oops: 0000 [#1] SMP PTI IRQ_PIPELINE
> [ 7299.180869] CPU: 6 UID: 0 PID: 46 Comm: migration/6 Not tainted 6.18.2-g768d3d5bf800-dirty #41 PREEMPT(voluntary) 
> [ 7299.180873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [ 7299.180874] IRQ stage: Linux
> [ 7299.180875] Stopper: multi_cpu_stop+0x0/0x110 <- __stop_cpus.constprop.0+0x79/0xc0
> [ 7299.180885] RIP: 0010:proxy_irq_handler+0x13/0x30
> [ 7299.180889] Code: 9d 5b e9 00 fa ed 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 ac 99 41 02 48 8b bf
> [ 7299.180891] RSP: 0018:ffffa861c01e4fd0 EFLAGS: 00010287
> [ 7299.180893] RAX: ffff8979e6006000 RBX: 0000000000000000 RCX: ffff89794023ea08
> [ 7299.180895] RDX: ffff89794023e800 RSI: ffff89797bd9dac0 RDI: 0000000000000000
> [ 7299.180896] RBP: ffff897940f0cc00 R08: ffff89794023ea00 R09: 0000000000000000
> [ 7299.180897] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8979408b0c80
> [ 7299.180898] R13: 000000000000001b R14: ffffa861c005bd00 R15: 0000000000000004
> [ 7299.180903] FS:  0000000000000000(0000) GS:ffff8979e6006000(0000) knlGS:0000000000000000
> [ 7299.180905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7299.180907] CR2: 0000000000000000 CR3: 0000000028630000 CR4: 00000000000006f0
> [ 7299.180908] Call Trace:
> [ 7299.180940]  <IRQ>
> [ 7299.180941]  handle_synthetic_irq+0x9b/0x1b0
> [ 7299.180948]  arch_do_IRQ_pipelined+0x85/0x460
> [ 7299.180952]  </IRQ>
> [ 7299.180953]  <TASK>
> [ 7299.180954]  sync_current_irq_stage+0x159/0x160
> [ 7299.180957]  inband_irq_restore+0x5d/0x80
> [ 7299.180961]  multi_cpu_stop+0xdd/0x110
> [ 7299.180964]  ? __pfx_multi_cpu_stop+0x10/0x10
> [ 7299.180966]  cpu_stopper_thread+0x85/0x130
> [ 7299.180970]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [ 7299.180974]  smpboot_thread_fn+0xee/0x220
> [ 7299.180976]  kthread+0xf9/0x1e0
> [ 7299.180980]  ? __pfx_kthread+0x10/0x10
> [ 7299.180983]  ret_from_fork+0x15e/0x1a0
> [ 7299.180988]  ? __pfx_kthread+0x10/0x10
> [ 7299.180990]  ret_from_fork_asm+0x1a/0x30
> [ 7299.180996]  </TASK>
> [ 7299.180997] Modules linked in:
> [ 7299.180999] CR2: 0000000000000000
> [ 7299.181001] ---[ end trace 0000000000000000 ]---
> [ 7299.181002] RIP: 0010:proxy_irq_handler+0x13/0x30
> [ 7299.181005] Code: 9d 5b e9 00 fa ed 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 ac 99 41 02 48 8b bf
> [ 7299.181007] RSP: 0018:ffffa861c01e4fd0 EFLAGS: 00010287
> [ 7299.181009] RAX: ffff8979e6006000 RBX: 0000000000000000 RCX: ffff89794023ea08
> [ 7299.181010] RDX: ffff89794023e800 RSI: ffff89797bd9dac0 RDI: 0000000000000000
> [ 7299.181011] RBP: ffff897940f0cc00 R08: ffff89794023ea00 R09: 0000000000000000
> [ 7299.181013] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8979408b0c80
> [ 7299.181013] R13: 000000000000001b R14: ffffa861c005bd00 R15: 0000000000000004
> [ 7299.181016] FS:  0000000000000000(0000) GS:ffff8979e6006000(0000) knlGS:0000000000000000
> [ 7299.181018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7299.181019] CR2: 0000000000000000 CR3: 0000000028630000 CR4: 00000000000006f0
> [ 7299.181020] Kernel panic - not syncing: Fatal exception in interrupt
> [ 7299.227448] Kernel Offset: 0x12600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 

Regression, i.e. was 6.12 fine? And all it takes is some "echo 0 >
/sys/devices/system/cpu/cpu1/online"?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

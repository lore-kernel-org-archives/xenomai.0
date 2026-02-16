Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38595328B52
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255489; cv=fail; b=i7uqo+OEeZnSBwvknEP9Vsdma5J4c2S+HINA+cZYB56uYVvEdaHJJ4knpeWhCpX29Tmgrxi4SCriR1sLXQWn+qLC31pNIMAAn203mygJ3JzZFLkICkv5HkBdhDWTwugywABUVZhip9aSvphBjFBGbAFkoGO8D5VsIVP0zvcdeeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255489; c=relaxed/simple;
	bh=d2M+7PqXaOKpSbqP6nPQJHEHi6NX8pexMMrhrazHfls=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDOA5ec5wm8o4rgihdJl3Vz8/o8XtjUHHS4NB41q/eNW5nHl8zeZzsl8uDWsy33xd2hspEzSUFktAw1PmRtvQBH7ha2+5Cla1Dw4jIrxIC4YutDoMpcTFq54x2h++Yvl+pTwMM2X0KPiNHOLyHYYwEurH4SKbnOvfTAbjWwdQJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=E2xuc4WD; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="E2xuc4WD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAwzc9ALZ4jg7Tdw5ACyJXBa10nuTOb30N4u2zmLISlwpYXMqRE7Vryo62BWD5we4YSMBWF1toiglXUsdzyhoRNaEibeQ0uCR2mEa9Su0fWzKhMmi00GZmCKTs/2hMHcpEBLw81fZ4jmazRqpaC3MblLcqpBJD41dr6Fa8UhN3NXvTD7qxMfb3cCRkIMqqMavKef/ECiLuZkjKyg1aCPsPzF72ZKlXyMpfqd6fTHVKGtcGctXqfhVB+PGz4RbRvWbHNA0831yh8cRvlnhoRyat4ErE0x+HEFC4itfmH5xjpiiq1LWYbZ5I/5s01nnYCPhHsHopFQvAAW32+JJG5J1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cs6pYXI/Uq1/GhPmUyT9A+huZxESaKHD1hjuZoHGdQ=;
 b=wRuYREKMqLUgqxkQnVYrc0M1VzsAr7r85rfP+wcbRDdHuxJfB4QYNzL9twNrkVL2MCV0vSH2VqTkNXJLVR/GyRGdYGdqwGVTn6dE237/Fj+BapMhHSj4KnhR+QRNR/VEEt6ZFjv8kxp/2g+o826els90OsAWeT3t5NYc/2D/8Ek0zOmv/b/zK+7S/U9dgYSIEI7h0xf8NyoR63t2gK5QOYqn4+4rue3Z+HDsVm2nsGDZrNzZkq8zpqb+10+A8jajSAUrVm9NsbHUMA/ar+63S5bhuYjdie/pbywD9IAbkbJHd6DgamC9NdZkdj6RV3zzsNp4atD4ihmZ2J2vCsM5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cs6pYXI/Uq1/GhPmUyT9A+huZxESaKHD1hjuZoHGdQ=;
 b=E2xuc4WDT5/8xd0Rzl5UyUa+CclSfegjP+tLQEIVThBYqpLCbmrFfX8Ory5s4XeC8HoMdZfxP02shzZWwIBtQHEIC12sUPH3xOLWbJhsUMdqNqCuwvbdXBAS+S539k51DqlcGg//3BC0USnvhD1UK9i6nSxQ67PIm8fWymAfZaK1FmZNZ2ZYIF+yvqxflnizz07CVd2mywPx7C4ra6jM9SiWiFhXSGZ//P8BOBG+mKGDzjBTPGnwLgDqjGM3IwdwmpCIQ3nMg2//Z9rMUiIK/pM2Sz9VyERSsYxrjQiC9zEEiVwseWBl/qc0XnANzYEuNXCH3q9GTp8DW4/eBl/LKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:24:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:24:43 +0000
Message-ID: <58a55030-6375-4c1a-befc-ce7080f31eff@siemens.com>
Date: Mon, 16 Feb 2026 16:24:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
 <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
 <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
 <22e57c125201eae8993aeaaa6fb49a5d9ccfa3c7.camel@siemens.com>
 <dd35c586-269c-40b5-b628-1c78479cfc98@siemens.com>
 <1b3f15931ae8e2d8c17437c89bcb0a355ed2c1ef.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1b3f15931ae8e2d8c17437c89bcb0a355ed2c1ef.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: a8362ea7-a1d6-4d66-ec44-08de6d6f8276
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkZqdXEwNGMvNlZ4Nkw4RmNUSlJFRW83SUlLMmNDNWpkSjd1ZVVwdEtST2pq?=
 =?utf-8?B?K3hkbGtPMU9jNWoyZGI5VFU0N0JKVTN3OWxjNDYyZ0JJbkxFSmk0aDFVVlFW?=
 =?utf-8?B?b3lxSEkvWUdWR0oyQlpBTUVmZGV3YUVTS1hSOVM4NEF0SzZvRnZXdThVQ2lT?=
 =?utf-8?B?RW5qYVc2RytQcUVZalZHdXhtQTZrdlpyN3JJK28zSVdIZWxkcmZyT0twalNt?=
 =?utf-8?B?ejRaZkg0Uk5OUmtTcEVRU21IcTY1Vy9GZmhPbjBtZ1JhTVJUOWpQOTFhU1pu?=
 =?utf-8?B?WHo3aWdTYVdjOHRWWGQ0YVhpeFRNMFkrVnNGbEhIYk95eXRkM0Zackd1MStP?=
 =?utf-8?B?WDArYi9wQVJhWlBoSmlXRXNjcG5NbHRXZ2VOK3Z5Z1dJOE9WaTJtc25NZHk0?=
 =?utf-8?B?STN1dklrVklCamk3SFhTeGFud05PV2JBMU02a1NQNnZTMWVLeWRpYVJia2I4?=
 =?utf-8?B?VjNINXlHNHFUL2cyNHVUZEVOVlRsdHVlODJMREczNTVKNVBxT1NSZGdLbERV?=
 =?utf-8?B?Vzc4OVU4UjN0ZnNsQXZUUjVmZ3dkSFFvZ2VlVUVwTkk0ejcrcUFNRHBQbFVh?=
 =?utf-8?B?THlNY0k3Y2lOYjAybmdVSUk0MWtKZWMvZ1RwSkpjM0VhellZZ2Y4Z1AwYVJ4?=
 =?utf-8?B?SnFrZWM5RkJkeXNQSmd0bUN3M09VbFNJNXcxK3JCV0o0WU1vSDhvcFRyRjdx?=
 =?utf-8?B?SC80TVdLWVJWc0FBVnh1U05pbmVkRTRidGtUTXkwZ0dUdmF5ZG5VZVdPQVFB?=
 =?utf-8?B?eVFZQXNrbnRuSnJaQlZtTlVvTUY0Rnk5K24rNWtWMTZXbTBKNEVYU0F1aGFP?=
 =?utf-8?B?dkQvWXdqNWt4RHFBSm9lbXJmMFRpemdoNjhRZVNiRjhyMkNhcGdGMk5qUkVp?=
 =?utf-8?B?L1FHaDFiSkRxSmJ0aDZzUVIvWG5QWEs3S2FVNUg3L21QcnMrdnlST1BPTy9B?=
 =?utf-8?B?WHIycURwaGozR29CaWN6TCtUVTlpcUhsSGNUUnp0aG1ZSHJ6Ny9ucEF2R2Yr?=
 =?utf-8?B?WGxPWW1ZMHA1czdTZU1hT3VUYUdqVDdJcFl1TTkwYjVrMGNiK2FZdjU0ZU5M?=
 =?utf-8?B?c0dIakZlTC9FSmlpdTdXSDZCWTVoVHBoWHpEcUNwUmI5UHhoYUNlSUphU05P?=
 =?utf-8?B?RkpHUlNScldxczNBTndabTRwUkI2OVNKZlk0QkxiRlgrMStLeXJJMXNMa0Fs?=
 =?utf-8?B?SGFOUkNMd1ZwdmYwT0gwNy90TmRCcjIvbjdkekdmUmpVVjJkT2tJdE42OHND?=
 =?utf-8?B?ckpPSUZTR1ovSTQ5QnN4T3NEYjJld3dSY0dBaExoSjk0aXdId1E4UE9Hdkp6?=
 =?utf-8?B?dUw3WjBhT3VHUkdCQjVjdTFkS1dsaCtNQVJESTdiSmJiV2ZQcFhBYmd3ZUdO?=
 =?utf-8?B?YXpHa1FaSU4rSGpBcXRyeDRSZXlNOHNKdXo2V20zZ3ArNGhKd1RWRDN2d05a?=
 =?utf-8?B?clc2eUVVZFI4QnRONHBXQWlzNjljZTh5cEZOb3FvZ0FpT0Z0NXVFMEdTY3Yx?=
 =?utf-8?B?Y2tUalNyTmJCYzZCN1ZaUDZUclpFSzZLQUJMMjNEMDhDaTBFTVVkRDdvYW4w?=
 =?utf-8?B?YjJQdW56N2xES1BJMUp0K21KTnRsaVRSd3VmV2V2emNpWXRYZHhoVVNhZWc2?=
 =?utf-8?B?UVVGOEtBNzJJMEZkejZ2RG5QNDNvdHc1dDE3V2NDTGltSkQ2VGc4TUYybmRq?=
 =?utf-8?B?Wi9RL3U0NzlwdXVLY04rd3dJZk1sNTAzUWQxckgvTW1EK0tVMlpReG1Vb2xr?=
 =?utf-8?B?Vy83dlplK0F6dVJFVDUxMU5Pd2NwQTVuUGJ6dGxCMkZtR3BFNFk4SUE4M2N1?=
 =?utf-8?B?b0dJdklYamNET1NnUllZRGVtblFBdkMxSzFEQWpzTEN3OHo2RzVaZzdMa0VB?=
 =?utf-8?B?WXhrQ2tDTmkrM09aTDVBaWVtVE5qL0FsZnlSclY4a3c4dlVEZE9YT0RpYm1r?=
 =?utf-8?B?My9MaSsxWWVJaGhDMGFYMTlKb1JsRklsSkJ3MnlRNlIyalpmaXdPZUsya2Rv?=
 =?utf-8?B?cUJqamZxWURtWnBwdUlVTmhVZjh1MnR0YndvVjdtMGw2ZEIwWnFYMkdPNWF6?=
 =?utf-8?B?ZUVaZ005NzU2RUpKWDM4eHU3K2FPclpFdi9VYTNlY2VORVowSDM1SmxsbnhG?=
 =?utf-8?Q?exFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEtRSEVLZzJ1bDlGV1pSb05JVG5CeDUzVDRWWElpTTY3MzN2Z1J2c2RqZldz?=
 =?utf-8?B?SDh1ODJFRllOYXNJV0RERFBLbnJKOU5SdU1EellQVm9kVk5wQ2RsTzRqa2VO?=
 =?utf-8?B?bWw1NkFvc1BiRmxhZW14V3ZuekpVUENReFpUczV5QmJtTU1ZZXlvbE5Ddlgx?=
 =?utf-8?B?NGFKbS94UllTbXh4a092QnltaXBIeGR2QmlBOE82UFBtV1RNT1lZaVJlQ0Jm?=
 =?utf-8?B?SWptbmtodU9NNnAxd292NDBHWlRSa2VhaGJJVkZ1MGRETmhhbW9LdnlubCt3?=
 =?utf-8?B?bWc0Y3N6cUNMbi9pMjA1NldPWU92VzlPRWtxS2YrYWQzTEVQZjlYWDd1cVZt?=
 =?utf-8?B?SXlrK2YySWZrY3A1aTlRblRCQzRWMURtRVpUVWpzUGxsZFFGK2E0cm40aFV3?=
 =?utf-8?B?bm9jQW1GckZmR0ExNlRJYXZmNk8zWGlTT1VyRllLWHQvb3lENkhENFQrN3dD?=
 =?utf-8?B?Sm41SFFQdW9mMHJjVUlTQVZhTm93WmtNbTRpcEtnamRFb1FYYjF4clFHaWhn?=
 =?utf-8?B?cXUvYkoxalAzNE1QLzRuQ3VBdlRhMnZrbmhIeGh0WDRzMW1IZEJxajFSK3ha?=
 =?utf-8?B?NlBFSzgvTXlLd0QxK3ZVSzd2QzIrZm1IbWZlUDlBai9jajdUTXJUenVub3R3?=
 =?utf-8?B?Sy80VVQ2Z0VwVVo3TVFsVGlWdjVEU0hJMUJhMUhZMFlJVncvNDFOQ0dnWXRP?=
 =?utf-8?B?MGRGQlN6VHVQOFgrY21KWkVqRFNTczBTRGROWG5NQXBjNGRXTGVRQStBeWp4?=
 =?utf-8?B?Wlc3Yk9ITEF2VU9ReEloclFWVEIzNm5iRmIwUWlFdjBQSmRUcDZYL1Fld2kx?=
 =?utf-8?B?SEpHR3V2NEV1YWc3TGVJUWpWUjA0OXpUZDc1UlFSbWxTVGgyVTJMQUVMZFpx?=
 =?utf-8?B?enpva0VFL3hBQVVjd1RHYlNmOUdIMWozYzlKTTJaTDUwVEk2YlBUVElNZGJN?=
 =?utf-8?B?WHRZa0NWUmVrOGE5aEZIT1lvZW1Cdkw0L2RxMnFpa2dDeHhNOGE0L0tWRys0?=
 =?utf-8?B?MHB1L1JXbUdZemhsb2ZlVnFlSXE1Z0NWaVVLaUtjamdQYkxZcUVJdUNaVk1T?=
 =?utf-8?B?YkN0Zk9WYTdkRWZTbUtndFpYZTd4R0pzY2h4YmNIbjZzVkdiY0lQQVBhcTVo?=
 =?utf-8?B?anR2WFJkZXFxSG5VLzFWajdaRjZWbnErRDRJRDJieEsxMlFWZ212aHQ1RG5h?=
 =?utf-8?B?dUhWeEhhdURhR09VbnZudFJIQlIvVEgveGhjYWluZ21xVStCMHRoTk9nczVT?=
 =?utf-8?B?Z3R5OTlqSFNXK3k2OGNRR2EyTGcxQVpVbkoyT2lJNG5aM0VDclpwckNsTTNr?=
 =?utf-8?B?WEd3Z1JYZUlEVG9hckxzZW5SRjJwVUl3cEFaQTNQNms2ZHREanllU0E5SFFj?=
 =?utf-8?B?eDAwNTdkVm8yKzA3N1YyTFpGUkFRd2Z4d2E2OC9PN0JTdVphVGs3Q1FOV0lq?=
 =?utf-8?B?TUx1TjlXbVAwKzFDeEQzM1ovbVowVTZSV0ZBZFpya29zdzVZd2xTdkJpOC9I?=
 =?utf-8?B?ZUg3SEJoM2dYa0ZZUWliRFB5dUVkdEZQbURoWmRRRnU2NEtRam11TWJuellV?=
 =?utf-8?B?OFl1VTY4MHltS2xsUUpJTXdDYkF3aUZ1RU5oSE9mYjlSdUJ1VGNSdVQ0alFB?=
 =?utf-8?B?RzJSZ0Z2NGJqSUNJOXg1ajJPdFdOZ3pUTlBzWFVLTHFIWTNrZXFlVVdMSWwv?=
 =?utf-8?B?eTIybmpSUkZKZS9lMkVuTzZOSDVjN0k0d0c5UjhJaXVLYWRQQUJzRWt6UmFB?=
 =?utf-8?B?NkU1eDJick0rSXpXSkJ5bE1kOFdRN2QrUGlZUmdxZ005UXZGdEMwcE13bHhN?=
 =?utf-8?B?QUlKQVVWcFBpbTdOZWRxVUJVMmpyeEMwODlldXRpSUxBTUJ0VlpBdUhuWUhr?=
 =?utf-8?B?VXNpQS9HNkNod1oyc3R2UWJlU2R1NkhUUkRmY00rN1NneHhVTlRBNy9WOU9j?=
 =?utf-8?B?Q1Vrc2d1U3VGNXNESktYQld4VGlRek5QVW01Z3VWdnhKZUJmc2Rmc1V2Y1hl?=
 =?utf-8?B?dDEwSFM5cWh4bVdReENQYUtiSFMyYXVLK0dKNkx3QW1JQW5DL2lCc3NOdzVM?=
 =?utf-8?B?dUxBa2RnZmdwODVlYnBrZ3BYcm5yMmliMjgrY2pZTFlSQmg3R3RodjhEVVhM?=
 =?utf-8?B?RHFZdUwwL3N3MGtXVDhad3luaWE0eTBSMmpWaWk1RHNuUjd6RzgxckV5dW5l?=
 =?utf-8?B?Zk1RdXdEcWhRNThiTVZ3WmdEQ0phYUkyNGtUVWM1UG9BQ281L284MkQvcCtQ?=
 =?utf-8?B?Q21lY1ZXWGtPQURsYmhrY1NRSkNIaDdMbXlHMWRDR2Y0dmFsNGhSZVowdVRP?=
 =?utf-8?B?OUVHYkwwTW9tQnI5SGxFaWpneTg3R0NIOXVQMDNqZTg5WHVFV2JiZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8362ea7-a1d6-4d66-ec44-08de6d6f8276
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:24:43.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxP/9E5QtNdCjuHoGT61FQuzsrMISQJlL7AxBMHwriIMnsk24NnoqBPpIWKpp+b4hhTUQ3cOzjB3klLy8hI+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7971

On 16.02.26 14:44, Florian Bezdeka wrote:
> On Mon, 2026-02-16 at 12:43 +0100, Jan Kiszka wrote:
>> On 16.02.26 12:22, Florian Bezdeka wrote:
>>> On Mon, 2026-02-16 at 12:16 +0100, Jan Kiszka wrote:
>>>> On 16.02.26 12:15, Florian Bezdeka wrote:
>>>>> On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
>>>>>> On 16.02.26 11:58, Florian Bezdeka wrote:
>>>>>>> Since 6.19 the signature of __request_percpu_irq() got one additional
>>>>>>> affinity parameter.
>>>>>>>
>>>>>>> A new Linux version specific wrapper cobalt_request_percpu_irq() is
>>>>>>> introduced to hide the signature change between different Linux
>>>>>>> versions.
>>>>>>>
>>>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>> ---
>>>>>>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++++++++
>>>>>>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
>>>>>>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
>>>>>>>  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
>>>>>>>  4 files changed, 32 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>>>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b5b8cb279035a5dd7b 100644
>>>>>>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>>>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>>>> @@ -5,6 +5,26 @@
>>>>>>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>>>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>>>>  
>>>>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>>>>>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>>>>>> +					    irq_handler_t handler,
>>>>>>> +					    unsigned long flags,
>>>>>>> +					    const char *devname,
>>>>>>> +					    void __percpu *dev_id)
>>>>>>> +{
>>>>>>> +	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
>>>>>>> +}
>>>>>>> +#else
>>>>>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>>>>>> +					    irq_handler_t handler,
>>>>>>> +					    unsigned long flags,
>>>>>>> +					    const char *devname,
>>>>>>> +					    void __percpu *dev_id)
>>>>>>> +{
>>>>>>> +	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_id);
>>>>>>> +}
>>>>>>> +#endif
>>>>>>
>>>>>> Please use a define for request_percpu_irq on older kernels that uses
>>>>>> the new signature and resolves to the old one via __request_percpu_irq
>>>>>> as needed. 
>>>>>> Yes, also switch to request_percpu_irq directly because
>>>>>> __request_percpu_irq is going to be removed in 7.0.
>>>>>>
>>>>>
>>>>> request_percpu_irq() doesn't allow us to specify the flags. IRQF_OOB and
>>>>> IRQF_NO_THREAD would be needed.
>>>>
>>>> Then request_percpu_irq_affinity - whatever survives 7.0 already as well.
>>>>
>>>
>>> No flags as well. 
>>>
>>> I was not aware of __request_percpu_irq() being renamed in 7.0. Will try
>>> to find something else, but that doesn't look promising at the moment.
>>>
>>
>> Ouch, indeed, trouble ahead (or extra API needed from dovetail). If this
>> becomes a blocker moving forward with 6.19, just re-#define
>> __request_percpu_irq for now.
> 
> This is what this patch does, avoiding a strange function name override.
> 

This has has reason: When the kernel requiring the workaround has been
phased out, you do not have to touch all the call sites while dropping
the special cobal_* wrapping.

Jan

> Anyhow, as this way turned out to be not future prove I might have to
> provide an additional API in dovetail. Evl should have the same problem,
> so reuse seems likely.
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

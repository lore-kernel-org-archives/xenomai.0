Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAA2EC0A7
	for <xenomai@lists.linux.dev>; Fri,  6 Feb 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360746; cv=fail; b=StQuPwnYk/+3MJwPf3gak7jHQWZZajHG7NNqm84V81aDsX71LM8kLxRO4gwalvtBXhyM8WnkG63f9DX46B4qtEILoYVNAku/D3JHBa7mtLiTIm+ID3xf5vA57NdT33nF4fAupbOMOIRbnHKsq4rL1aj09+1yLcP0sHMHtEON1fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360746; c=relaxed/simple;
	bh=T2CD9kCBeN0d+EmwioTy1aiYd1/iZRXaUnxzU/No0r0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTgnhL+nbE4l3ILxgcI4LiMBTQSvwZlA+ifADluyzXp89Av7EMDRAD3kiZxOIF9priWodlZ6mUHRMVf+2ehkOwI7UYVgj8DUGjFCUrvsJnFPjMmzRgUAhpsw5IM8Uck2X0WQMlmpxc/ujoP0qaZkiw4yjgVKbC0YXfxJL5T+AXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uTysJJOd; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uTysJJOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV3eAOVSyUleQTjUCXZZ6FkJdfJ2LNK2PvWiFhIOm0VGH1gj6992laNPDQdkLH1539AVJplLkICZ86hQXKZrquNIfj/+19b5mh/0imUja1HspquzWoAmGLZOpdM3rCKCN2DKI4N9N1TwHLBrIFII3Vsf3h53G2XbvTEhSBC9cW6HS+yuSRZyw9c1j8smkn6xOaikLp3BWv/F7jTfdJqZUFS7O7uqsO3RxG1e+vIjeh3uwM8ZwwOLL0R7CthPf1a7qv4n5rUD3br0VmkUDRi5pClNnJSyyTgM0RGsu4iWoXFyFI45n9yBPEq0AuOho0rdY18sueJ75/Pff/3kG4m8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaEPeUKyfrB4kz+zsDujn6R+UpLWmaWkPHXgzmbMaO0=;
 b=W0CDpxV9RVTnbfayrfcyTd2/XgLSVVun/fAfaKLmD5ncKaw/TawZ8iqE1p4YcvVwkxFDj651/RRkVS+4wxOtdfyE1xYfrKIAo7JzhaFeMH6sbea72x+HTvlrNnysyTM1REl0fH65IjxddizUyRx60JNEDfQqY1DPDhEJEL4soYfeQNNZ6sQZba4fS0oqoeCkyPwoEUT7xo6SwEoHSn33ljOkfNrZi3BvpwXnjdAL4GBRSVcz085vaXuu/uxsm0yiJ2/xw6q3DcN47YV3JwqNEm5ut8yYiMMSLkXj89qFTOBErApI6vUJi/Wy1FV0c1/1oCKrZIvpRk048PPjTRW9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaEPeUKyfrB4kz+zsDujn6R+UpLWmaWkPHXgzmbMaO0=;
 b=uTysJJOdREXgk2/n/krXY/txx7+s4widS1tPeC6T5miInacufyWoJ5Y/G02qTyIHMpzPUQgEwGFa2pNFiadqCT9gy8JJf94fo04JmaY1Vnw2qE1aYK5AwCG38yoML2T132BW28NTs2DrkCM1yQsAI0Uf0DhECzO241TXQqepT0u3qQc7dLcpaVCRwp+1ZdJ0KfhioMTpIWYZvPZapDUEr2jBW8762CwEYaZ4vNV0Rpc4c7+db7VEwzore7dKpH0Gnjb6iA+j385gQLpJa5y09ku+uJwMgR7XsrZ8S8nGHwAMn8dyxBX8REI8w3rVqoUl5uTIYkLkqB9vD+tjx7OTcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 06:52:22 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Fri, 6 Feb 2026
 06:52:22 +0000
Message-ID: <dcec343a-51e2-4384-93b5-bb20f33ccc81@siemens.com>
Date: Fri, 6 Feb 2026 07:52:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xnintr_enable() is a no-op on dovetail
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
References: <CAFLxGvxUmCjBJBrPFWrGDfPimmcL4=xwGGxcLwn3+1W1tUriSw@mail.gmail.com>
 <CAFLxGvxTeqkQOcKTTTSynJ=1BSCWJNmqgy086nzXPh-ZE_imVw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxTeqkQOcKTTTSynJ=1BSCWJNmqgy086nzXPh-ZE_imVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: f879eaaf-e1fa-48f9-29e2-08de654c4761
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVBaS8ydGlrK0ErMXBpQ05PRERrcm9KaHNtSFgwUzBmMXFXK003ZjNVVnc3?=
 =?utf-8?B?bzdldWU3Zm1kdTRoQUpYU1ZSM1dnNmtlVTZzQURrcU9qUFVFUDhiejA0a1ds?=
 =?utf-8?B?UDhzWE0rMzg5ZXhKMmlRWFowV3l2VnZxL0ppWlVsL0xSa0svTVBjZjF0d3FP?=
 =?utf-8?B?QXBnd2x6S3dhclNCZGxmRmNPM0xyalhZM2w3R3EyekwvVUtDT0lJNFhZUDhE?=
 =?utf-8?B?aEFkOWNDU3JJR0FJdUczZjBtZE5UZ3Y3aitPWm1TM2dwbGlaUG81YlU0Mm4r?=
 =?utf-8?B?RjdWZVNIUmFKUC9vNjhNaER3SktVd0lURXhIT2VXMDlvUXVDc09uVUM1b0RZ?=
 =?utf-8?B?SDl5dUVrQWtWM1JUMEt1eDdQclRJeUVGOE84dlFIQitHc3hHMXpkcDkvMGpl?=
 =?utf-8?B?bGZFSGpIYmdrR0xtUWVObjMweHI5OUNoc0dwNHluVU5HZlZFbjN2bkZuTzlk?=
 =?utf-8?B?NEwyNVBqNjd1UDR4a2JmZGJaQmdFQ0Q0VFJsend6bmwyaXNaMUNmQmdSVVBS?=
 =?utf-8?B?ZmVvSEs3SVluMm52UDlwVnovOW9PS05ScmtmVWRSMkRnMU8wbFIzRXpRNjVL?=
 =?utf-8?B?MDB2ZDcyRVZCTG5GSDFEZWx1K2lKUFhqendiRzNyVXZXSUp3TDdabzQrYlI0?=
 =?utf-8?B?OEw5WUZEQjNMajQ5dHJYYnVJYUVmUU9qTFppYlp3WWJkVXlIMDhnajhLVzNo?=
 =?utf-8?B?bmRxNGhBQ2lUYkdyN2ZWN0pkZ1QxN0JoNFFTUDd3eHBvOHBPSk5xeWg3bGpP?=
 =?utf-8?B?K2sxVEpDNDByalViSFd5YUFVeTFuaTVCM2tES1VMMTdxM3FlbS9rZjlvK1hQ?=
 =?utf-8?B?V0pkUkZQRFZmU1NjYWg5QTNQOHlFMWlmNWVCeXNSZ0FkQ1BXRDYremtaUjF0?=
 =?utf-8?B?c2p2NXNETVRXOGNWL2xoTFhoaHN2UzIzYVUzMGdaVEd4Nk1yTG9aSFpRb3FB?=
 =?utf-8?B?cUZDSjRrVGFGYjlqU2MvUVFHWHhqdTJBaTdWQk1NYjZLUm1SVGlqQzhhem5i?=
 =?utf-8?B?YklUVm5Nd0Q0c1MzRlJqWWJ2WWZxVnc2VDA1WHZsL2xmZnBVcjNaKzA1MmVv?=
 =?utf-8?B?MG5SdUlJTXRpYmI0ZVNWdDRFRzRFYS9QRmFSTjFLcEJrK280dnJUcUNtRlRU?=
 =?utf-8?B?Q2d6ZFNacHRvZm4xbDNtVU14UUFOYWNIY2JMSC9nZ3BCYnNLYVJ0Y05TY21S?=
 =?utf-8?B?a0lIaXh3WmFkYU1ZeDFud0k3SGVXUFE3eFNaejUyUjFRamhVVkRBK0xteUNW?=
 =?utf-8?B?L2dSenZtSzBvaUVFWmhXUkhlVmNGRk9TNFZlSEw5Q3d3SnRKTFV1NUVreE8z?=
 =?utf-8?B?WG9xc2M0YnVHd1pRMVpSUURWSDVBY2hWaHNsbVBEQ0RRd3ROWHBKbUJabXZu?=
 =?utf-8?B?ZWlvQ241N05TampkTkM4Rlo5VkwwSnRUOHdUU2UzM0F2YW1SUnVNL0hQdmFH?=
 =?utf-8?B?UDNad1FVN0lkM2Rha2pHM05VMzBwVW9wWlBFNkkrM2FRM3Z0My9oNElUVVlT?=
 =?utf-8?B?bGlvcUlGSmJVSHoveDVFcDhHUjY1R2R5Z05EaHNsNFVBWnQrRXlvOGhaeWcv?=
 =?utf-8?B?QkVscWQxZmJWN2lHL3orRlhmRlBNWXFRckdvQ0xCbDNWcDlEVS9mVmFYWlV1?=
 =?utf-8?B?bHFyT2I3WVZtbnppZXdPZXdOd09ScUpYT0UxWDJRRlM3Z2x0K0FDVzBnOUd0?=
 =?utf-8?B?aExaZFZ5M1ZTUVNmU2dEV1UzZGZZYUV2endQNUgycFNxR0g1K05uVUVPOUF4?=
 =?utf-8?B?aTlxQ0QrOWlrdnpxTWdJQ2lTTE0vRnlmenVpb2YydndFa3lsM0pyazljZ1FC?=
 =?utf-8?B?OWxDWlFMaU93RzF4aWdBUlM5ZkRSRU9Ob3pNTUpXVks2RG1ub1k2Z012eXVx?=
 =?utf-8?B?eGduZzdMeUVITzZxamtuWWtxaWpDdWFjaHVwRkR1eFA5L3BHUFJnb0tpTldp?=
 =?utf-8?B?TWt0clZGa1RhVlZXaFdvUk5qc05tNG9obWRGcHBtMGFLcGZXZ0RFazNCaFRZ?=
 =?utf-8?B?Rk5oUGJQeWo3c3B6dzJVWUZzQ0xoVXlSakhibnhud0tCTG9TYkdlVHk5cDh2?=
 =?utf-8?B?SFRnaVMyZVI4VWxXRTdWcE00UWNRaFpiQ3Znc2ErOTRzN0xMaGtucjFpMHZy?=
 =?utf-8?Q?0jWbYAhDoZf02bGs6+RaifAK/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRZNzVvSjFpVHhESWNJNW5qY0JLUVpVVktSbDNWSnp2Ni9obTJ5L3dHUWk2?=
 =?utf-8?B?TWdVMTg1UzZhOENZNzVvREQ2VG9SaUhvQ2lwcjAwRGxZVlFrR2MwdjUybWdB?=
 =?utf-8?B?Zm83RndraHZFTnNIVXM0RU5TVUQ2UzJXaGk3bG1XZVE1RTQzQXRYU3c0RzQw?=
 =?utf-8?B?VUMySmY5YW5sckxtMVBNeUpoU01rSktpYm5NK1kvOTBNUXJlY0NNUjFLVG1B?=
 =?utf-8?B?V1lzUmF2Q0U4RFlsN3NsVjNsUDNSSzFBOUk5dkpRZzFNd1ZjUVVUOVd3TEs3?=
 =?utf-8?B?Q3dQZlpuSGxjNVRORFM0TDdzbFgrWEVPRzVIbFVFbGNLL1I1aDRCTGJjMXgz?=
 =?utf-8?B?YldEYlhNbk9vcWNaV1dobU5oUnRCUEhkV2JDVG1jK2ZocTB6UUxVckYxT016?=
 =?utf-8?B?WlZXOElPVTJSSlZ5cHlPVGh6czIyUjZySVZBZXM2Z3U1VzhXc2t2NTh3VUxs?=
 =?utf-8?B?bEFNclg5SFdnZ0JLekJnY3JZd2NJU3BjdEUyMDNpMEd4WDNzeklsKzJDZnJh?=
 =?utf-8?B?YUdIMDF5VmpWRHVWOEl5VWhDdWZ3VXNCTGcwVXZMUXV3OS9ETHZQQmVNbS9q?=
 =?utf-8?B?UEZ5MlMweHhMdkE3K2Nnck1yaEY1ZmRBL0ZyajdIOTlKamlRM0o4NW1WNWxm?=
 =?utf-8?B?c2RxZ0VVVWEzd0NUTm1GZ2ZwaWtDajZUUDRKZUxTbVY0Ris0bm1kLzVFWml6?=
 =?utf-8?B?WExVNm9yNzhyd0IwdE56VzFoUUpFdlBjWXpTeEhKRWRaL0ZhUFp0NWY4ejRi?=
 =?utf-8?B?TnNnNS9YMzJxZkw2M3laL1JCWStUWUlRd1FKL3R3SEM0S0JmREFINXlsaVNJ?=
 =?utf-8?B?Yy9vNGVpNVZaQ2ZYYWdUekp6QmNwbmVkbDN0NFR2WUxDVkIrTmVid2VKWEl4?=
 =?utf-8?B?dDdaNU14Y0EvdFVpZHd2bFpuODJxNlF3Mndzbm1VUGNGQkJ3ZXZ4RTMrK0tn?=
 =?utf-8?B?dCtXNjRRVXJGUVkwOE1TL0xsaEdaNVppbnYxclI4Z3YxdUEyYUxlSnY5a1lP?=
 =?utf-8?B?UGVVbExZTVk2ODVVcUFnL2NHcHB0VitlRkN6c2F3OVpLeUp2cDZjYzhHeElq?=
 =?utf-8?B?Ni9VN3BFR0VsL25QWUxOeHlkMjk1UERMemFUeGtRbEdOZ2xib2h0d0hoc29v?=
 =?utf-8?B?bW5BVlRVM0RIdTBkcFY5OXFCbmxaNHllcGVZb0RqdVFYNkhaU3RZWUZEMGFY?=
 =?utf-8?B?U3pRY3FncHA2VTBFREVRbkN2TjFMNlFsZXFLOXZIdWpCaENLWGdVK21oTGJj?=
 =?utf-8?B?TEJENEpmVjU0VDdXN1J6THhMbEIraTUvOExGY1dlT1RFUCtxcHAvckxEUXlH?=
 =?utf-8?B?ek1HVU5lS0ZjYXFLOGN0SitXK2JyZDk5NDhGbnJsMHVVekxiQVJtWlpvZlZz?=
 =?utf-8?B?ZkJlb0RaV2pQcmk0MS9BVXdOWTFKY2F2RmJBWFRRdjZiV1NrNHhDditxZHcv?=
 =?utf-8?B?UGRtQVp3eUhUVDgzY3lYcm5OMTNCK3FPdHFIMCs2czRPUExLSHZpTkM5UjBF?=
 =?utf-8?B?TS9WV2ZRUDZkejZLSVpraHlCWEpEOTJ1WEtaU3FrdGJyR29qMm5GVzJ0OUtX?=
 =?utf-8?B?bVRMYkpiNnpLdEpiYkNEYU5uVFFzSktWZkhCY20xQWlFOExpOG5VUzArbEs1?=
 =?utf-8?B?M21PSTV0SHRiNkM2c3JuNGdIb0VUNTlwSWdnNmg5eFNpQ2VMYjU0ZW9heUJm?=
 =?utf-8?B?M0kzL2RscGZ2Q0w0UUtlZk9IaXcxS2cxYmExTDRGS1FJb2hnRUoyMmhtR2V3?=
 =?utf-8?B?WmxlYzNWcDdaOEdlRGJaakFGdGpnV3ptTEhqUjJuQkRlTjFnQ3hNTytDZjkw?=
 =?utf-8?B?TXJHU2picVR5Yk5TNmVWZTRKbGVmZUh0STFCeGVRTTAwM1hyVjFBRCtVbWRO?=
 =?utf-8?B?azI0dDdxWGpaUWJpWEhTZWlLS2U5ZXVlMEYwbGpjMEp1UjhFTTdIb1NJNkxM?=
 =?utf-8?B?dGp1TldqMGV0aGxiSkJILzA5OXFUYkNvTllacDFwS1puSFNJOU1TRWRvem42?=
 =?utf-8?B?cWRRY3JyN3l5YXF0Y0pnVFNHOWN3UXY5OHpkcExObkdTeHpYN3BiTmhVUi9W?=
 =?utf-8?B?cXlGaUl4US9PYmNqWE5HUENNbVVDS1R4SjExalpjR2xkTmNBdmw5V0pmdExQ?=
 =?utf-8?B?VklXaVVkU1dkZXNPT2ZOMHFmVXZld3RRQjVwYWRpRkUzNk1BSHNBZXRhczFU?=
 =?utf-8?B?MnhpYm15TVVUcDI1NksxdTNMNjVnTWNISFBVNEtDNlZMbVpwa2JyNit5WjdQ?=
 =?utf-8?B?Y0ZjUDZSN0Jwb0tIRmphcFhYZjlxRUM3SGRjQmpJc1pKS0Y5NUlCK2U0a1NZ?=
 =?utf-8?B?U0FSVTF2UzZnanZsb1V4OGtVZ2l6ZWJvYzBlSkVueUdLWFNBWjN1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f879eaaf-e1fa-48f9-29e2-08de654c4761
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:52:22.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGHojS34ocRFwPDnkalGt8TpF9dl/tiGem8pJnTNZ1H/4n41nepZpaOhpWYdudwafZBANBiuhIRVMMUGekUTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093

On 05.02.26 23:42, Richard Weinberger wrote:
> On Thu, Feb 5, 2026 at 11:41 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>
>> Hi!
>>
>> I noticed that with dovetail xnintr_enable() is a no-op. Is this on purpose?
>> How to mask an interrupt line then?
>> Various drivers in Xenomai use the function via rtdm_irq_disable().
> 
> s/xnintr_enable/xnintr_disable
> 
> But xnintr_enable is a no-op too...
> 

See
https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/b1daf55bdfefee4fa2e10448595abc90eac77eea

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

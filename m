Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600A2D0C9C
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240315; cv=fail; b=myETtXqi6K2wCFQm1Sbj5y3NFRkWugOQexEGgeXdsALIhWr+4443rMU9egRDIJk1nF1Xgrn0w9mfsqnbLug5P0wl4f26TEWja9TL9V1efoCsPRo2AgDaBRaR8Hg6GWRkvTnYL0oIicqqQ0l4JUIFvNkPgaRq112N4nx7kv5UmlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240315; c=relaxed/simple;
	bh=wprFZ1YNmA55xZa55CzzGixQXxCbRwQbxx0/VBEjtN8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSp5MPuTMRx6q+HqRz57mSUnus8Lsg3Al2oxyAuDz88Ew5IAQy2Pj28OR1W882soSWQkCuSOotiOvvHlfRp02207j1eqvkDSFPsQsClb/cOAxpWyQQ3UlMnF6QpGLXeF16w6OT4Eui7vlP7rZX4xxK4MxHWTE4Uw3bv9GPqWZMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sYzMqI4i; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sYzMqI4i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUFQhMNnmZ5DGJs9qzWpiUIiHnrWGJDuSvEB2uhzGIAolRxv+EMVu/rEF5l9ojF+WuizNDipBB3WIMWO5NwnNtBS2VaqRksxO3nG30ZdM8p1Hd7i3tmfkf3KjE2cCy5DVlztz/qkTbkU096o9q7D962lJ+nAxyAirb4rUJ/oyhjYQgZDEMKoaKQVOt0nwb0pTNLnJxlvsM9O29gD3drVNbcn4tICaOHs/84ZFsJg/AUk6nNMUDgEG58ov012f8wBc60HlUecl/EDrPmOzVDeRfDKMmwU10e+t9sYS1wgSzkVbd99iAQpMAFMSxEqSUHm2+l9WMoMZiO7TIyKYuQqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJqhrPXfbezvNPgyA9g2T3Mhyp0TInsGy7JItKGwePk=;
 b=f0h+DA5CFWQGztS4DKipY4EzmggNRWZI9IVVXseGxR4snDrcYASC3LQJXFAUb+aAE5d5yIba0P2w8j+7Oyqe1SJWWjvFDwwMZ45gu8dNVodicuJKA8G874gpOckY9cJf+VPfd6mzAPsNTMVzfPrps1VnyZbPav4R1EqcGLRjGzW9Kj6gLHTsABdg+F4BSNeBKbkZ5awULjnoSQhmBQaRvhDfs5UAoQe3dtwJZ/oLbfj45ZJwgTUOH+S/OJHGYciUmj9rxu8LHNSWGN86kgzgHbepwouZLaxMAmPuX4JJXBrEzDZRmmW5bPfr4tUGX6u7e2soDc7qIRUgD+SXygNhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJqhrPXfbezvNPgyA9g2T3Mhyp0TInsGy7JItKGwePk=;
 b=sYzMqI4itxdzX9An9rMICGFBgnwWhAWojcPV9nv2pf187R8lxp57BgennHTnPfSkgOZXikeezc+vj7Loz3f8Pv5WsmcMT15Dt70B8JcK/mAmuP+Gghy3xRjpNjnuIekDVsDM+HQoJ3++EKLjXGnPyFXqie57oA5kW7C8gX2IUXxPIKmlvPb3dBgTx9rxWJ3eNp9BQCIhxIv81QHgNDSilXMkk7+axC9M8Uang+EUwsYOC9VfbWzXXBHCYH84RO9vT7nzJ8dJiSdK9KGm71DNmomThRR7r/jgCYC9ARBsLZqhoUXnmDVqltU8COGxwu8OkZkEDad4rgIJoThJOLI/CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 11:11:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:11:48 +0000
Message-ID: <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
Date: Mon, 16 Feb 2026 12:11:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 068fcccd-674c-44ae-772f-08de6d4c2d6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZElSd3RpdFE2eXV6eEI2Wm9vc2FHMGkvMXRQcFdMdDhlM2hRNXAwTnYvL1F0?=
 =?utf-8?B?VXM1NUhvcHlQK0Q2cGhueXRWUURhK09XNkNBdUpMWHNNY2lDdWxXTFhWb0tq?=
 =?utf-8?B?UTVoRDlSZzRDclRRRWdSZCtvZU5nRkxLbGtJNnA5djJqbzVyWVNKMys3ZndT?=
 =?utf-8?B?VVFscXBCUll1Q25lQmFNZThaeVBVa3BYYXBOSlJYVjlITUMvb2ZSOHBTdVBW?=
 =?utf-8?B?ZG1CMmhjUk9vMUpNV3JHb1VKMEpFc3Zrck1NeDZiN1hJQVRrNDlGc1c3dm9N?=
 =?utf-8?B?Nnhzb0hzdHB3bFFmK2lKVk56eHdmMDgvQ2N1TWJLWVNzNUlza084c1lvaTRW?=
 =?utf-8?B?QTNaNlVyVFdJWmlKdVpXV0NuM0tuSnpxZVYvRGJvckhON0F1Y3ZTTTNqSFF2?=
 =?utf-8?B?UkxzeEprZUNFdU5LUVdXZkxpTXEyYVMxU0ZZZFp6Q004ejBwSStNdjRzUkhK?=
 =?utf-8?B?RTdsUzlmWFNkUEo4cVZEeHAvTVZmNjcxcldDRUJrdktFVzlKOWxRMEJtekdY?=
 =?utf-8?B?RlJUblhFbmNHMVFQb0ppOWlKV2JNd1pBcXdhMkdBMmFuZG5xOCtvS1ZMSzRZ?=
 =?utf-8?B?NDQvQnRYU20zTWFIUHpmYnJYUWlxdW5JQVJETTc2Ync1MGVOME1NY1JVbTJB?=
 =?utf-8?B?clJ2TGFGdWFnWGkxV1htRjNrTkhnSFZZR2dzSUNXekx2bnY0dGdtSC93Zmk5?=
 =?utf-8?B?Z3dYOUgzcWFuUVRIelBWSmttVzZDVGxuTWp1K3lXanR4RVdxZXpnYVhDTkd4?=
 =?utf-8?B?d2tEQk1PVXlLU0c2SmFXQnRicjY1REE5RnJTVWZKVjNlK0w1NHkraXZuV2Ew?=
 =?utf-8?B?YnFMSm43WXU4OUFzRnBXbERFOUlmNHVkOTF3ZERERlZwQXpHcHI5QmNCK3JH?=
 =?utf-8?B?ZnlxcVVZYkltTC9iekJKendzY0tsVE1kMXp1T29MTElWL0d3aTBjSmhIUllj?=
 =?utf-8?B?d25TdzFVeUtvY1hxZThKQ241UEphRytoSi9ldUZMa3ZDVDJXWnY4c3FmK3Br?=
 =?utf-8?B?SlB5YVlONGF0UXdHQkFkdTB1cm5odkxzdTRLWTJVendpeUlTaUt0azRjTjNN?=
 =?utf-8?B?U2dkUjVuMTlUZjQxNHo1ZlhISEpPTW5Jc2h4TDljdFdCYURzS01BU1FrNWlZ?=
 =?utf-8?B?Uk5jUWQxc2hjeFJpZjhzZk1GV3JFMllsZEJJUWtuUDdJWVNueDBUaEJ5bWJt?=
 =?utf-8?B?K3ExdmpTQW4rM0NVZVMwUXRFMlc4RnRCY05uZG1DNFdJUWUwYVNva29yUHlo?=
 =?utf-8?B?NGM1c3F4QVVxaEdrclhzQVl6bDNSOTZXOUpPSzFBd0YyYk5KK3J0aXFTcTdm?=
 =?utf-8?B?LzhyMCtWWVQvdkZRcXpCS1orM2lIK0pUbFVMaTNTV203eXlYakdJRHNBTkYx?=
 =?utf-8?B?TEMwS0JFNHl2REZ1aTE0RnlSaFpPWlNlNUo1QnQvczRSc0Uza2lLT3NxSE05?=
 =?utf-8?B?MzZGNGhXNWRSdTFsdytRNysvZ0VzNm1sNUVvNzE3Sm42eXh2WkVVOUFyVEVz?=
 =?utf-8?B?bVh0YUlyb2VJakNzRnl0TlNkc2pFdTdzV2hvMkJYV1VsRlNCUUZGamlYN20z?=
 =?utf-8?B?cFR5Szk1N0R2bUtwbWRhOHFodjQ4enlTL2JXb29ZWnRqTXU0aHRUSnp2a28w?=
 =?utf-8?B?Kyt1NWw0a2tZdXFWRzE4RVpnSjNzdTYrWEtmVnV0eWdteHBkMVZkdzhJbk01?=
 =?utf-8?B?QXFsYnJicjF1cmM3UUZFZGlNTThlNTB0c3A2Z21VZzJOM0Y1Sk1uUWtSK1Qy?=
 =?utf-8?B?di9hTWplRHFGYmhUNDdGcW9TNzQ5MUdpZHZPUDhZc09yVjFJOHJ2bDhJZlNT?=
 =?utf-8?B?dWY2NEFFZkg4aVJJZnJ6bTJMdzBIYlY4aVJ3RkJMYldpb2RiMkhZNmlkdnpv?=
 =?utf-8?B?bzFFbXQxbTFxcWY0a0hJQVRnK0Nnb3pGR3ZqQmVNQVVOcVQ5NUl6eTVrYWl3?=
 =?utf-8?B?ZGUvbmpOdHBFZzRTZ2wrWkttOHVaVjR4ZE5kY1lWS3NNL0V5b1FRc2xnL2Qr?=
 =?utf-8?B?cHloY0YyS3U4TDZkRHhTMDhOdXlnSUN2eTBzamlwMmpVQ2tXYU9LMXNmTzRT?=
 =?utf-8?B?cHFPamNwb0w1NnQyNUFta2hHZ3JzUDhHMFk0OVJsT0R0S0pmbzl1NFUrbXFW?=
 =?utf-8?Q?Z4qI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExkN051ZWtFQzZqL2xqVHlPVk8xOFZ6dzFIcTFGUldJbUhRU3ZuaFRIUEs3?=
 =?utf-8?B?SUFZOW5seXgybjdhNkVyTGRLRnZIVHBQYWJzZDZVdmVsc2NUQzNOQnFzbzNW?=
 =?utf-8?B?VW1jTm81ck5HeFA5YVVudHMyVGFDcHJaVUtSeFN5M2p3K2FrVmgyNFVkWm1z?=
 =?utf-8?B?WDcreVlHQVdaZmVVN2JieUdhcWFCdExoVHFyWHVoaklRSExQT2syaWxiRkFi?=
 =?utf-8?B?RlZRbzVramROTkVBZGFKLzJ4amdBendKdWt1Z1hJNnY3MUl5VDdOUXNtTTk1?=
 =?utf-8?B?dWU5dnRCMmpWdFRqSXNyUzFkM1E3Zi9oOVAvNmRpcElJQ1plZC94TGtuaDBO?=
 =?utf-8?B?M2h3Vzh6UU5NRUFXcUdWUEVhQXZZRnlsbld3d0lQcFFCQURSNytiOGlBMVpn?=
 =?utf-8?B?dTc4dzE1M3dWaHkrZzdGNFljaURyeFJxNnM4cVZndkVUTHVId0dyZGtmZ2pp?=
 =?utf-8?B?VS9yQkJMRXhRaXFObFU1SXhLUXNwUmx4d29ERk5yS2VUQXBXT1ZhdmRPbkRU?=
 =?utf-8?B?eFQwYzE4bDhLSXgzRkp2TVRVQytmKzlFWWxCNWRwQkxheWl1ZDQvM0h4WGNX?=
 =?utf-8?B?a3R4S2J3L2JHRG4rb2FHRmhGQ3lGVFQrNnVsQXdUTmxPN1pZRlRlNnBhcm5J?=
 =?utf-8?B?U0dUd1o0V01STmpWRFlTZGduL3pjQWpMQktKMkh2UHZJT3JDemk4NENlSTBh?=
 =?utf-8?B?alA4UENuUmZhMlZsSXdxeFB5YkRZQTJaYlBzMXBYN2xUYWIra2VFUk5JRThj?=
 =?utf-8?B?QSsrazg5M2JNNmxBY09yNHNmSVB3NjFEOTVHeDR1ZE1hY1p3Skk2Mzlwd0x1?=
 =?utf-8?B?NkJIYWRhRnlIaDlXQUxHZEl3Q2VVcGYrYndRbVlPbTBGM1p3aVlCcW9HdVUv?=
 =?utf-8?B?RGFMcGZyWW40VjFIZHdJZVZkYXprd21XK0sranpEalVNTDdsSmlkVUIwSFE4?=
 =?utf-8?B?NUZKTWJyYW5VRzZ0T3hvOUVXbkVKenVpNFlxMXdtYS9nZlZrcStqNkRVbFMv?=
 =?utf-8?B?QkczS1dlMzNMcnZZSzhyaThWcDc0SFk3WnlCY1V2SEo2KzdrNEN0eGxGenQ0?=
 =?utf-8?B?R1FsT0lOKys4VlR2c25RZnlTQWZxcHhLTkZjOWQ0Um5IaVZ2dTNGalZhcGRl?=
 =?utf-8?B?Y05aZXhndFNDanRTdGJEaksxdW9rbitEdU9BWldPWlRHdmE1aGtaVWp3SkhW?=
 =?utf-8?B?ZjQxeU14QWZYRzJHa05Ya0hqNlNydFJ4S0dXWHhCeTU0ZWIzakdEUjBmUmVt?=
 =?utf-8?B?K0tVdmpLRmxhdTRNd1FvZkNKUUhSRWZ0OW4vR1lCOXNIcHowdHRkT0lkcTg3?=
 =?utf-8?B?Z3Zsa0hoSFdpcGp3RGZKVUowbDA4WnEwWWVLYWlXYXdneGRlWVhXUmh1TnFr?=
 =?utf-8?B?T2Z6YkpLWkFHN1dCbDZnVHpTWXNOZmlacU5sUVdMekJEdHFCcENrTTJNUHcv?=
 =?utf-8?B?SHVOeW10VDlNWkZ4OHF0NkMxeGptNFpHM1YvWDJRMTd1OTR6am8zZ2ZPZG5v?=
 =?utf-8?B?ZkV5cjR6UHdFZEl2ZUtaSGdCbjVoM2dmc2ZNZ01XbmQ4Mms0dm9tT3hVUDRk?=
 =?utf-8?B?VnNIdjJwUTZrRGxwSmFKZUVlWGpnQnUxc0Mvdisvb210bUIrb2YrdkVTeTdn?=
 =?utf-8?B?VTJ1QndsNEMzc0c1dnJDSm5jaEdKZ1BjeEpsRVlCditoTmtzWDVHeFhGRTFU?=
 =?utf-8?B?dDl1aVlKVFQ4dUVyVDFhVWZHVTQ2YXhKSzlCSEMzUG50SDVncjBOeGN5RUVv?=
 =?utf-8?B?elN5cXhsMFNvRjBsN25NU2drN1RieWdVYmgrS01ZckpjNmZYUHQ2ZnhtOER3?=
 =?utf-8?B?S2crcVFSMHVkZ3FwS0w1ZGJINzlMMTJtS24rMEx2bW9HOTZneG1BaTVsN2NN?=
 =?utf-8?B?NUxPMGp2Mzg2SW41aGJxbExYaVpOOFlXZXhOSW42SWtBNkJxaE9IZDJXM0Z2?=
 =?utf-8?B?NDZPaDlCeWJaa1o5UTJveGpOOTFUdGF6YUNRdGQ0WDBrbFJRTzM2Z2NqTGt2?=
 =?utf-8?B?Mm5IZVdkUzJSUjdPVGJXdEJQM3BUUzViZE1tQmoyWTdTT1RaZ2xpWk5lZGEw?=
 =?utf-8?B?N3FaeXJuRm1nOWNGd1RreTNuK1I3aVRFUXpBV0k4czE3TmNnQm9acXVlVm5H?=
 =?utf-8?B?Q3NBTWM0YjhZenV3bE8rMjVBeUNBckN0U3lyRE8rd3VwK05FaGd3eXFQLzds?=
 =?utf-8?B?dCtLenU3aHdsMUxpZWU4RWhSdWM2RjR4dm5EUUxLK2ludmJQaGhGcnJhWThz?=
 =?utf-8?B?TUNldE1pUHVncGw2TU9xVjk5NlRZM2lZZ2lOU2JIcU4wTlJoOWdkRlRSNFY4?=
 =?utf-8?B?SmtORXlraVgxb2VtYmZxTVdVMDRKZk1BTWR2RmF4OEQ5bEFDVVdPQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068fcccd-674c-44ae-772f-08de6d4c2d6a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:11:48.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuboQbhGeTlEB2FZfMKa8f9mvybXM9phGwGR90Al3WOMtB7EfOGLQ2q+GbcNI/dnwc6YuFVSuyQMRztW6F5LYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7026

On 16.02.26 11:58, Florian Bezdeka wrote:
> Since 6.19 the signature of __request_percpu_irq() got one additional
> affinity parameter.
> 
> A new Linux version specific wrapper cobalt_request_percpu_irq() is
> introduced to hide the signature change between different Linux
> versions.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++++++++
>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
>  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
>  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
>  4 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b5b8cb279035a5dd7b 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> @@ -5,6 +5,26 @@
>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> +static inline int cobalt_request_percpu_irq(unsigned int irq,
> +					    irq_handler_t handler,
> +					    unsigned long flags,
> +					    const char *devname,
> +					    void __percpu *dev_id)
> +{
> +	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
> +}
> +#else
> +static inline int cobalt_request_percpu_irq(unsigned int irq,
> +					    irq_handler_t handler,
> +					    unsigned long flags,
> +					    const char *devname,
> +					    void __percpu *dev_id)
> +{
> +	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_id);
> +}
> +#endif

Please use a define for request_percpu_irq on older kernels that uses
the new signature and resolves to the old one via __request_percpu_irq
as needed. Yes, also switch to request_percpu_irq directly because
__request_percpu_irq is going to be removed in 7.0.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

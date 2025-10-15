Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3A145B3F
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507302; cv=fail; b=eyeTEChlFfiLI7vfyOnasBSHU0qf2W1BHS4fJGYsYDKZV3Erk7l7Xi/sIBItep512gS0oP6Y7X7fllTGCEZXPacDqIrN0fAiS1/RPi+u8QN3aAO0zRYH07oVl5nYDsS6+Di+6VSbO8rvDazCBmIA/kAYevH0Ar2dfB+8WOWg9fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507302; c=relaxed/simple;
	bh=h6eGxVtUeEER4qvajv2Z+qxLHF+odWUPy+B6RStciYA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A/dyd0BZMHub4+nm5R0juHr+KDx7fytwiel3w6fvfdkWTsWQWodmxksLqa5dJjDqvmoM07CdkajNWIuWue508688ztalONNTlqfi4L0iOpKuojUwbqLp8zql6FRVV4m3HrudNH8jLLEkuBgKxrPrdgo+WIWVjMXKlT3CflqtsGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nzBxMKoG; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nzBxMKoG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEZftTtdZ/BoN4TZGBYKHmyNUp6kAGICdZZ66dXO6c/dQ0j6pMZcyCHZ/njy45EXzSNK4XfYLoBI0yDfYoxxhZ7IZcOZt4iCEcw6GN1XUzrnHnuqTVsJpY1pmL6qXixDp1+43neDmbhAxdZxBr1ixKv+FH3RKXBN0qnPBiVgiNsFzOxBjIqhTZ5jcluc05dglg25gMB58yc1EGK7JGFMjkp40Msh8XvJmQOTIESnF00KOTYTFFs9GuG2VT4/AbMjc+o4NAgJP/1fQ9ePtRjfZ3IFnAmksuEplgDxzmZguj1XTsqEpLSF9ou2yj8V8n6yBFlncqaYZps6AUrSDjbOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39BJaVfxy/DvTuUXz/wT+3UnmuWLqkRKqaYhpcPFKFk=;
 b=lauDWkmZLmVu7aZm9wJwogHUm0Z/psolFlMtAgJluyZ/W78XyX7zKO5bgKTY8iqNVrDbbGJrzaoxZhBz+8ubfk6akhUDdyy7tt5VCe8L/5mn/HWvVRx/55vEgZQ3lBkOmjAvC/8gW7ew8daU8plUPi3cSikBIhNdkwzJIXcnI32GcFAbQhMsepydVpmisOMMu93bQjl0VyKd7lzchelgFo0BR84KjBtATOYa3EeBvImxyNNQKNXKa7Wng0JyquAySsxM9ykNmNlFVlhETpdrVWh9Cmli135L6D9+Vu+4tlmJfsK0Pag70f3ANPdHkANK8Gilh7S8cOviTWhJKAm0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39BJaVfxy/DvTuUXz/wT+3UnmuWLqkRKqaYhpcPFKFk=;
 b=nzBxMKoGDQpSz4hFd2dXceCpqwDKVowCzQ3dNHPVRre60AZF0mHEMz4nHCaNLeXWB+Lyy54wt2xh+3YOJ4Rp1U9FDXUpHtOt4AG2Bvr2blsP5dw+VvbPvvXCKf11Nf2SkCNwXaCOBA6Xj0+xnFahx/9GSsSbKvAm1788g9+NUpTJc/5O6CRijmCBUYp6wTasG8WSYvb9ZbeqQPshgKQrn2whaX4DqEIGhENr0/onH6veAiz6d7xdrYxMG2RhuuBiwwO/UsJkFKhFotWDktbR510AQzGqPBNkyM6Wb3eectnudU0MvuRYXNO8OSjAi3D//riEMYp/5oyDxenLd4fPnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:48:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 05:48:14 +0000
Message-ID: <acb4e917-bde9-4211-97e7-b13532c2a06e@siemens.com>
Date: Wed, 15 Oct 2025 07:48:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-xenomai: Consolidate debug-configurations
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
 <20251009111228.3504354-3-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251009111228.3504354-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: beba36e6-33b0-424a-69a9-08de0bae6ecb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkV5a1VaL0RveHZBbDl2eDdrSzVOWis3dG9qZ3QzRGkzYjFqU21TZnBnc01Y?=
 =?utf-8?B?RjdHbllKOHZONHp1WnFJdlBsdVpPNlB6UjlwTlZvNFhJcCtmdVhlc2E0OXIx?=
 =?utf-8?B?RFZFTmZxbXM1ai9WN0txU29tQTlZR0dJb0NTQldDbDN2QzJmQ2xWdHNQUmkz?=
 =?utf-8?B?T0JXSlBiOW1pSTVxQnpiQ2lFTWhUQlpXRE1hOTdDdkJZdFdJU0FsdUFOTm9h?=
 =?utf-8?B?MHRkOUhNYllFbGdsYk9HQnFYUlNhbUlQUFNmNG9GNUxVckNkNHp0QjBSampB?=
 =?utf-8?B?WjE3dGRLT2t5ZWRaUFFUb3hGVXNSZzMzMjR4QUlVQTBqOHNpTjlyM05yNkda?=
 =?utf-8?B?eG9KR0dmN3U3ZHl5cmwrNmVVRzNjb2lSMWltTGdUQk81L0NueHp2dTlzRVUy?=
 =?utf-8?B?c1NJSzJtR3ZYTzdHcDhLN05jaGJGNVlCY2psb2laZVFFNlI2Rnh2cWMwdHQ0?=
 =?utf-8?B?dTFpTjlsajdlQzhjUFkxMGpKVnhsNDE1aTFteWRQeFJVZDZkdGxQWnM0MkZ6?=
 =?utf-8?B?dDczTTROMzdBRU5FQ2dGN1puOVFoc0pDWnc4dXRHeHpaTlJRc09VZnhkRkNi?=
 =?utf-8?B?emMzTjdXMGhrQTVyN0JiZ0Z6WmhNL2VXZzNsdEdKQUxLQVRqK1cyd3ZMbmhY?=
 =?utf-8?B?ZEQzWUZsK253V0ttRVU2L0lWREEzQWgzdHlqNitWNXQzcndqYWNJdGFpS0JR?=
 =?utf-8?B?R0xLTS9saXNRM3dHR3R5b2tvRit3SkkvVllBV3duODNKVUVGUVhXclJxV3RU?=
 =?utf-8?B?dXJVbS92bFZZaW9SZUFiUCt6YjNmY1hFbG1KNmxpVW8xaW9UZlB5WnNIVlBk?=
 =?utf-8?B?aGo3TUlpU0JkTUpTSzNpQStPTVMvSXBPT0cyaUVjTzZ5L3N4UEZlZWp3WmVK?=
 =?utf-8?B?WG0yS1QrL3luWHQ4d0ovZXhNenBFU2MvQmJjdnUzd2FQc0swT2NScGlkMXdw?=
 =?utf-8?B?QVBqNFEvMWlvS2dWanlPUWt5QjVQTU5tR1RtOTF0M2RGWmJqSFFQb0xmVVgr?=
 =?utf-8?B?SzRRK3RMVDZIRVI5TDhuNzlOem8xWmVjSHVEMjhmbWJRb0FGUUxaSmpLdDk0?=
 =?utf-8?B?QmNTUW9YYWVOZGYweTdOWFFnVGMxaWxKbTVhaHR3RkUyOUs1eCtmWUNYYlo0?=
 =?utf-8?B?cEE5VjhrTC84RlpHcU9qRTVYQTcyNEUrUExjcXhZWURDZVQzQ2c4MURUbHd2?=
 =?utf-8?B?S2VXNkE2cVA3bEcrbHZJZXlZSFIvMUhvRUFYOWhKR1dOVkhGSk9QTGpyVCtG?=
 =?utf-8?B?bEExMUhCaEpuVlRiUkRDMXcrZE1GbmpDUVQ0ejFiSDRRSUM2RzdlTGwwVGl2?=
 =?utf-8?B?Rnh4NnFGU0VJbEpabEpLdFlNenI4dHBMZDZBSlEwVU5OSldmc0huU1lJUjJI?=
 =?utf-8?B?TVVDVFhiSTNDNld3NW9rVmlBMkozRVMwT0pCZGw5RVNZa0tPVzkxd05yVXUz?=
 =?utf-8?B?MER6VEJlUlEvOGJFaWdkL2lCUlUvUks1bW1KSW9weEx4VlY5ZnFDSGs0aFRq?=
 =?utf-8?B?NXEvY2V4bTJPamJjdWE4Ri84V3FSQUhYbEIzSkF3c2plRFVLZk5EWURpWXY1?=
 =?utf-8?B?cnMraG9ndEhCbmdwbmNhWlplV2V3Tk9EbzViOWxpZEVNT2NWZlNPVkR1UXpr?=
 =?utf-8?B?TlpSaGRnaExGREdQNDFvbHhJNkFTYU5WMEdLSFZMVjRkdXJ2RHdhMU1HU1Vi?=
 =?utf-8?B?b3BibWtoV2tCYzF1TEg2WTA1UjZlSEU2N2dEdXNDN0xwMjVyMEY3eENsTkxU?=
 =?utf-8?B?TjV5dEc1c1dmek9FL3FXRTJEeFc0VEtvdEhqQ1FnSFdzVGRsUUhGV1crbm5X?=
 =?utf-8?B?UVlRRGQ2eTFBVVphb3JDWVlJRUtQdTRlWnlLaGxlNHp6cUdmTHpNTWZpbmRu?=
 =?utf-8?B?QTJDVC8wSWs1KzdRN2F5dDZObE4zTGZUSi8yTGw4V1kraG5oMnpCUlNLcFBZ?=
 =?utf-8?Q?MJYv5g33OaCde9WSfK1tTLcE8UzfGsHY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9OQ3k2enRoTUdXN2s4dWtOZWVQM3BHbjhjcFZXR1Q5QzBleFh1SWxxbkRK?=
 =?utf-8?B?WGkvWUhpdDdjYTJVd2gwUmd1cC96bGh4djdvYzZhYzAzRllDQTNFRklVaUIr?=
 =?utf-8?B?ZlZ6VVowUVdJdkQ5Y204eVlIZ3dqbGRmMERobVBuUG9kMjVON0s3WnBIc2U4?=
 =?utf-8?B?Qk50L0xGTllmaHJ4ZGtOMzhTMXZQYm9WMW4rTVU2bENsRHJMSkJYTnRNOE1R?=
 =?utf-8?B?VGtCTFdsNFJkcjhuWU8ySkpaaE9pSk5naUZ0WHpOUTlGV0VESEJjOTdNVk1n?=
 =?utf-8?B?bGc5TndkeFdJQ2lRbno5ZzlvMk9hRThXcDZaaUhURDJSZHZwQXVJOGdKbnp0?=
 =?utf-8?B?K1NiSDFFc2pja1pVdk53a3JZTCt6QmNGUTZGMWpSeTVKT1VBYnZ6NUhIUzA2?=
 =?utf-8?B?bXE2MDkweDc2b011UjI4SFFEWGNFTldINWRQRXRtNFV1THBsWXFWMXU3WWVY?=
 =?utf-8?B?MnNsNWRsd3pUTm1NMVNtb1FHRXpud1pvNFErTVg2NmRLT0p2WllDSTlmcEJF?=
 =?utf-8?B?M1NkbDZnb0lab3kwOFpvRzFiWk9iSERkT0NJcWNJdXYvOHgrMUVWTlppTXJl?=
 =?utf-8?B?M0g3aDVYYU14ZHVBbDQwYU03ZFJWZU93TmhtWHBJU05Tdk9WMHlqdUtKN2xH?=
 =?utf-8?B?QTNrdHdFTVl0dFN6dHV5S1h4SGN0V0VIN0RxSUJZTEtZakRKNUNheWExOG15?=
 =?utf-8?B?ZlRNTUFlV1B4amwxV1J3WHpyNzdiZWxNVHNTRlUwTlJmeG1zK2ZJYlFLcXJZ?=
 =?utf-8?B?YXRHZW5ycDhWdFlpYllMUlBwSHBCbHBUTFBCYzFwbkplelkwS3dvYW02cGJt?=
 =?utf-8?B?SDBXMnNxV3VQYUx4WENvUWxwa3VlOWlMbGpRRXBWUVJGV01sYTk3TVRBV1Z3?=
 =?utf-8?B?VzY5NkZPUytYbzVpQmU1bUR5bTZTMmhDcFJNTVo0c3pPQ1lmbVVSUCtZVUpr?=
 =?utf-8?B?UFBiWTZTVmZkZkNZem9tdmNaL0dzOVYyTG53L1lqM1RTTWFpcEcwNFozVGhH?=
 =?utf-8?B?VFh5NS9kaWFEQTJoTStTSVlzamZYNzZmR0xjMlpIOXJIdDJEWXFBWXBRb0ky?=
 =?utf-8?B?RWV6cFlHbVNyWUtQOUYreGlGOEY2TjJkK2tLNFVHUGZ5bitpWUdOdGw5VHhI?=
 =?utf-8?B?bGEwNkF6Y0tkQ0dDVktTOWRUZUx6Nnp3b3dnTmFrZ2ZWcXlpUWNVckZXMzh5?=
 =?utf-8?B?dUZXM1MyZXdLZEhBNDZnZ0oyOVRpWFRQTkpLVHRGVkpzbmFUblVQb0NCMnIv?=
 =?utf-8?B?SVF6dWtnc2NjWlQrbkNaQWJrR3VoMWpMMmdURXV0MjIwa2QvamVXeHNIWFZx?=
 =?utf-8?B?OEUzTFBjTDhHVHdPSTVGM2QrUkoySjlRbnVCNllUZmxldXJWODNHRENHckRa?=
 =?utf-8?B?ZWtqZ0Y5MWhRUU9XV3VkaS9kV0ozSkhYdFBqNnBlMldvRmhYNjdHRG9Ja05t?=
 =?utf-8?B?TnAySmNBeW9Dd3VLeE4rVDB6Y1VwTXAyWjBmbWd6UTV1UGV6Q01iUGVLUEJj?=
 =?utf-8?B?QVo5V2ltSnF3VzJzSXQxN0pNdGJGRGxiSnVmT3RuS3p6L0NRZGVsckpodUhi?=
 =?utf-8?B?aDNERDB2U3Z2akE5UVBTb2FTWVgwenFQbll6cGdTdmFKMTZlUWhocW1MT05T?=
 =?utf-8?B?Y0ZaK1JnZkJDRUdNSjdnREdNcjhXdkdIRGhIcm1zdEJTOFY0QWZ4RnJQcnIx?=
 =?utf-8?B?RzZJS3o0WGlxbVkxemNGTjkxemhIenBQZlZ5REpIbktLN3BFTFdrWFBZeG1p?=
 =?utf-8?B?VVJjdng5ZFpTaWtrQWp5SmdTQWJhWldvVFQzTU1KMTVvYm5lYWhvNUsyeWlJ?=
 =?utf-8?B?TW5PZFMrcHA5cFlEWlJlVkFVN3Q1dlA5TVB3S2UwQ215WWVJNlFRbmxxMHZ6?=
 =?utf-8?B?ZDM1WU9wYmQwM3J6a2tiWkVPVXhpRjRnMGNCejErVXNtd1AzRkU5SVBvTitZ?=
 =?utf-8?B?NmJ1TGhWNGRZSXFkYlBLVGxCRTJZU3BPcWZDSFlyZkNMUUdyRmZwOEtGN0V0?=
 =?utf-8?B?K0hGOXdFM1ZqRENzQ0RRUWlLdFVGOHlYL0hZZTdCT0RQMndQWjVsOG0zWlN6?=
 =?utf-8?B?cElvTUlFRXRaRFI3K0tOMDE4NWVTUnBIQlZySWtaR2Jsa2pFRmtob3luWFBy?=
 =?utf-8?Q?/+I+c9bWKdM05RWxbafivZBEl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba36e6-33b0-424a-69a9-08de0bae6ecb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:48:14.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/9tk0SZKTi8U1d8p1Fk+Eqf9XR9EQVeaHDf/++24K+ChgzZ/pZDWwAaQXtPoBLeIScSkZjbCjHdG/tUeMQUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9403

On 09.10.25 13:12, Tobias Schaffner wrote:
> Remove the per-architecture debug configuration snippets that were
> previously introduced to collect common kernel debugging features.
> 
> All enabled debugging options have been merged into a unified
> configuration, eliminating duplication across architectures.
> 
> This results in more debugging features enabled for the individual
> archtectures.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/files/arm64_debugconfig  | 404 ---------------
>  recipes-kernel/linux/files/armhf_debugconfig  | 438 ----------------
>  .../{amd64_debugconfig => common_debug.cfg}   | 474 ++++++++++++------

Ok, this is answering some of my questions on patch 1. But then at least
the .cfg thing already needs to done over there, or you are breaking
bisectability.

Jan

>  recipes-kernel/linux/linux-xenomai.inc        |   3 +-
>  4 files changed, 323 insertions(+), 996 deletions(-)
>  delete mode 100644 recipes-kernel/linux/files/arm64_debugconfig
>  delete mode 100644 recipes-kernel/linux/files/armhf_debugconfig
>  rename recipes-kernel/linux/files/{amd64_debugconfig => common_debug.cfg} (70%)
> 
> diff --git a/recipes-kernel/linux/files/arm64_debugconfig b/recipes-kernel/linux/files/arm64_debugconfig
> deleted file mode 100644
> index df45c04..0000000
> --- a/recipes-kernel/linux/files/arm64_debugconfig
> +++ /dev/null
> @@ -1,404 +0,0 @@
> -#
> -# Debug Kernel Configuration
> -#
> -CONFIG_STACKTRACE_SUPPORT=y
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> -CONFIG_ARCH_SUPPORTS_UPROBES=y
> -
> -#
> -# IRQ subsystem
> -#
> -CONFIG_GENERIC_IRQ_PROBE=y
> -# CONFIG_IRQ_DOMAIN_DEBUG is not set
> -# CONFIG_GENERIC_IRQ_DEBUGFS is not set
> -
> -#
> -# RCU Subsystem
> -#
> -# CONFIG_DEBUG_BLK_CGROUP is not set
> -CONFIG_CGROUP_PERF=y
> -# CONFIG_CGROUP_DEBUG is not set
> -CONFIG_SYSCTL_EXCEPTION_TRACE=y
> -CONFIG_KALLSYMS=y
> -CONFIG_KALLSYMS_ALL=y
> -# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> -CONFIG_KALLSYMS_BASE_RELATIVE=y
> -CONFIG_HAVE_PERF_EVENTS=y
> -
> -#
> -# Kernel Performance Events And Counters
> -#
> -CONFIG_PERF_EVENTS=y
> -# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> -CONFIG_SLUB_DEBUG=y
> -# CONFIG_KPROBES is not set
> -# CONFIG_UPROBES is not set
> -CONFIG_HAVE_KPROBES=y
> -CONFIG_HAVE_KRETPROBES=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
> -CONFIG_HAVE_PERF_REGS=y
> -CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> -
> -#
> -# GCOV-based kernel profiling
> -#
> -CONFIG_BLK_DEBUG_FS=y
> -
> -#
> -# Sizes and static limits
> -#
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> -
> -#
> -# Latency settings
> -#
> -CONFIG_XENO_OPT_DEBUG=y
> -CONFIG_XENO_OPT_DEBUG_COBALT=y
> -CONFIG_XENO_OPT_DEBUG_MEMORY=y
> -CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> -CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
> -CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> -
> -#
> -# Testing drivers
> -#
> -CONFIG_XENO_DRIVERS_HEAPCHECK=y
> -
> -#
> -# CAN drivers
> -#
> -CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> -
> -#
> -# Protocols
> -#
> -CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
> -CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> -
> -#
> -#
> -
> -
> -#
> -# Bus support
> -#
> -# CONFIG_PCIEASPM_DEBUG is not set
> -# CONFIG_PCI_DEBUG is not set
> -
> -#
> -# ARM errata workarounds via the alternatives framework
> -#
> -CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> -CONFIG_HW_PERF_EVENTS=y
> -# CONFIG_CMA_DEBUG is not set
> -# CONFIG_CMA_DEBUGFS is not set
> -
> -#
> -# ARMv8.2 architectural features
> -#
> -# CONFIG_RANDOMIZE_BASE is not set
> -
> -#
> -# Power management options
> -#
> -# CONFIG_PM_DEBUG is not set
> -
> -#
> -# CPU frequency scaling drivers
> -#
> -# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG is not set
> -
> -#
> -# Network testing
> -#
> -# CONFIG_BT_DEBUGFS is not set
> -
> -#
> -# Bluetooth device drivers
> -#
> -# CONFIG_CFG80211_DEBUGFS is not set
> -# CONFIG_CFG80211_INTERNAL_REGDB is not set
> -# CONFIG_MAC80211_DEBUGFS is not set
> -# CONFIG_MAC80211_MESSAGE_TRACING is not set
> -# CONFIG_MAC80211_DEBUG_MENU is not set
> -# CONFIG_NET_9P_DEBUG is not set
> -
> -#
> -# Generic Driver Options
> -#
> -# CONFIG_DEBUG_DRIVER is not set
> -# CONFIG_DEBUG_DEVRES is not set
> -# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> -# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> -CONFIG_GENERIC_CPU_AUTOPROBE=y
> -# CONFIG_DMA_FENCE_TRACE is not set
> -
> -#
> -# RAM/ROM/Flash chip drivers
> -#
> -# CONFIG_MTD_JEDECPROBE is not set
> -
> -#
> -# LPDDR & LPDDR2 PCM memory drivers
> -#
> -CONFIG_PNP_DEBUG_MESSAGES=y
> -
> -#
> -# SCSI Transports
> -#
> -# CONFIG_SCSI_DEBUG is not set
> -
> -#
> -# Distributed Switch Architecture drivers
> -#
> -# CONFIG_SKY2_DEBUG is not set
> -
> -#
> -# MII PHY device drivers
> -#
> -# CONFIG_ATH_DEBUG is not set
> -# CONFIG_BRCM_TRACING is not set
> -
> -#
> -# Character devices
> -#
> -# CONFIG_TRACE_SINK is not set
> -
> -#
> -# Other I2C/SMBus bus drivers
> -#
> -# CONFIG_I2C_DEBUG_CORE is not set
> -# CONFIG_I2C_DEBUG_ALGO is not set
> -# CONFIG_I2C_DEBUG_BUS is not set
> -# CONFIG_SPI_DEBUG is not set
> -
> -#
> -# SPI Protocol Masters
> -#
> -# CONFIG_PPS_DEBUG is not set
> -
> -#
> -# Pin controllers
> -#
> -# CONFIG_DEBUG_PINCTRL is not set
> -# CONFIG_DEBUG_GPIO is not set
> -
> -#
> -# USB GPIO expanders
> -#
> -# CONFIG_POWER_SUPPLY_DEBUG is not set
> -# CONFIG_HWMON_DEBUG_CHIP is not set
> -
> -#
> -# Multifunction device drivers
> -#
> -# CONFIG_REGULATOR_DEBUG is not set
> -
> -#
> -# Multimedia core support
> -#
> -# CONFIG_VIDEO_ADV_DEBUG is not set
> -
> -#
> -# Graphics support
> -#
> -# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> -
> -#
> -# ACP (Audio CoProcessor) Configuration
> -#
> -CONFIG_NOUVEAU_DEBUG=5
> -CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> -
> -#
> -# Sub-drivers
> -#
> -# CONFIG_DRM_TEGRA_DEBUG is not set
> -
> -#
> -# Console display driver support
> -#
> -# CONFIG_SND_DEBUG is not set
> -
> -#
> -# also be needed; see USB_STORAGE Help for more info
> -#
> -# CONFIG_USB_STORAGE_DEBUG is not set
> -
> -#
> -# Gadget/Dual-role mode requires USB Gadget support to be enabled
> -#
> -# CONFIG_USB_DWC2_DEBUG is not set
> -
> -#
> -# USB Physical Layer drivers
> -#
> -# CONFIG_USB_GADGET_DEBUG is not set
> -# CONFIG_USB_GADGET_DEBUG_FILES is not set
> -# CONFIG_USB_GADGET_DEBUG_FS is not set
> -
> -#
> -# MMC/SD/SDIO Host Controller Drivers
> -#
> -# CONFIG_MMC_DEBUG is not set
> -
> -#
> -# iptables trigger is under Netfilter config (LED target)
> -#
> -# CONFIG_EDAC_DEBUG is not set
> -# CONFIG_RTC_DEBUG is not set
> -
> -#
> -# HID Sensor RTC drivers
> -#
> -# CONFIG_DMADEVICES_DEBUG is not set
> -
> -#
> -# Clock Source drivers
> -#
> -CONFIG_TIMER_PROBE=y
> -
> -#
> -# Tegra firmware driver
> -#
> -# CONFIG_ACPI_DEBUGGER is not set
> -# CONFIG_ACPI_EC_DEBUGFS is not set
> -# CONFIG_ACPI_DEBUG is not set
> -# CONFIG_ACPI_APEI_ERST_DEBUG is not set
> -
> -#
> -# File systems
> -#
> -# CONFIG_EXT4_DEBUG is not set
> -# CONFIG_JBD2_DEBUG is not set
> -# CONFIG_BTRFS_DEBUG is not set
> -# CONFIG_QUOTA_DEBUG is not set
> -
> -#
> -# Pseudo filesystems
> -#
> -# CONFIG_SUNRPC_DEBUG is not set
> -
> -#
> -# printk and dmesg options
> -#
> -# CONFIG_DYNAMIC_DEBUG is not set
> -
> -#
> -# Compile-time checks and compiler options
> -#
> -CONFIG_DEBUG_INFO=y
> -# CONFIG_DEBUG_INFO_REDUCED is not set
> -# CONFIG_DEBUG_INFO_SPLIT is not set
> -# CONFIG_DEBUG_INFO_DWARF4 is not set
> -# CONFIG_GDB_SCRIPTS is not set
> -CONFIG_DEBUG_FS=y
> -# CONFIG_DEBUG_SECTION_MISMATCH is not set
> -CONFIG_ARCH_WANT_FRAME_POINTERS=y
> -CONFIG_FRAME_POINTER=y
> -# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> -CONFIG_IPIPE_DEBUG=y
> -CONFIG_IPIPE_DEBUG_CONTEXT=y
> -CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> -# CONFIG_IPIPE_TRACE is not set
> -CONFIG_DEBUG_KERNEL=y
> -
> -#
> -# Memory Debugging
> -#
> -# CONFIG_PAGE_EXTENSION is not set
> -# CONFIG_DEBUG_PAGEALLOC is not set
> -# CONFIG_DEBUG_RODATA_TEST is not set
> -# CONFIG_DEBUG_OBJECTS is not set
> -# CONFIG_SLUB_DEBUG_ON is not set
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> -# CONFIG_DEBUG_KMEMLEAK is not set
> -# CONFIG_DEBUG_STACK_USAGE is not set
> -# CONFIG_DEBUG_VM is not set
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> -# CONFIG_DEBUG_VIRTUAL is not set
> -CONFIG_DEBUG_MEMORY_INIT=y
> -# CONFIG_DEBUG_PER_CPU_MAPS is not set
> -CONFIG_HAVE_ARCH_KASAN=y
> -# CONFIG_KASAN is not set
> -CONFIG_ARCH_HAS_KCOV=y
> -# CONFIG_KCOV is not set
> -# CONFIG_DEBUG_SHIRQ is not set
> -
> -#
> -# Debug Lockups and Hangs
> -#
> -# CONFIG_SCHED_DEBUG is not set
> -CONFIG_SCHED_INFO=y
> -# CONFIG_DEBUG_TIMEKEEPING is not set
> -# CONFIG_DEBUG_PREEMPT is not set
> -
> -#
> -# Lock Debugging (spinlocks, mutexes, etc...)
> -#
> -# CONFIG_DEBUG_RT_MUTEXES is not set
> -# CONFIG_DEBUG_SPINLOCK is not set
> -# CONFIG_DEBUG_MUTEXES is not set
> -# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> -# CONFIG_DEBUG_LOCK_ALLOC is not set
> -# CONFIG_PROVE_LOCKING is not set
> -# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> -# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> -# CONFIG_STACKTRACE is not set
> -# CONFIG_DEBUG_KOBJECT is not set
> -CONFIG_HAVE_DEBUG_BUGVERBOSE=y
> -CONFIG_DEBUG_BUGVERBOSE=y
> -# CONFIG_DEBUG_LIST is not set
> -# CONFIG_DEBUG_PI_LIST is not set
> -# CONFIG_DEBUG_SG is not set
> -# CONFIG_DEBUG_NOTIFIERS is not set
> -# CONFIG_DEBUG_CREDENTIALS is not set
> -
> -#
> -# RCU Debugging
> -#
> -# CONFIG_PROVE_RCU is not set
> -# CONFIG_RCU_PERF_TEST is not set
> -# CONFIG_RCU_TRACE is not set
> -# CONFIG_RCU_EQS_DEBUG is not set
> -# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> -# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> -CONFIG_HAVE_DYNAMIC_FTRACE=y
> -CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> -CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_TRACING=y
> -CONFIG_FTRACE=y
> -# CONFIG_DMA_API_DEBUG is not set
> -
> -#
> -# Runtime Testing
> -#
> -# CONFIG_BACKTRACE_SELF_TEST is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> -# CONFIG_KGDB is not set
> -CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> -# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> -# CONFIG_UBSAN is not set
> -# CONFIG_ARM64_PTDUMP_DEBUGFS is not set
> -# CONFIG_DEBUG_WX is not set
> -# CONFIG_DEBUG_ALIGN_RODATA is not set
> -# CONFIG_DEBUG_EFI is not set
> -
> -#
> -# Library routines
> -#
> diff --git a/recipes-kernel/linux/files/armhf_debugconfig b/recipes-kernel/linux/files/armhf_debugconfig
> deleted file mode 100644
> index 68f525d..0000000
> --- a/recipes-kernel/linux/files/armhf_debugconfig
> +++ /dev/null
> @@ -1,438 +0,0 @@
> -#
> -# Debug Kernel Configuration
> -#
> -CONFIG_STACKTRACE_SUPPORT=y
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> -CONFIG_ARCH_SUPPORTS_UPROBES=y
> -
> -#
> -# IRQ subsystem
> -#
> -CONFIG_GENERIC_IRQ_PROBE=y
> -CONFIG_IRQ_DOMAIN_DEBUG=y
> -# CONFIG_GENERIC_IRQ_DEBUGFS is not set
> -
> -#
> -# RCU Subsystem
> -#
> -# CONFIG_CGROUP_PERF is not set
> -# CONFIG_CGROUP_DEBUG is not set
> -CONFIG_KALLSYMS=y
> -# CONFIG_KALLSYMS_ALL is not set
> -# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> -CONFIG_KALLSYMS_BASE_RELATIVE=y
> -CONFIG_HAVE_PERF_EVENTS=y
> -CONFIG_PERF_USE_VMALLOC=y
> -
> -#
> -# Kernel Performance Events And Counters
> -#
> -CONFIG_PERF_EVENTS=y
> -# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> -CONFIG_SLUB_DEBUG=y
> -CONFIG_TRACEPOINTS=y
> -# CONFIG_KPROBES is not set
> -CONFIG_UPROBES=y
> -CONFIG_HAVE_KPROBES=y
> -CONFIG_HAVE_KRETPROBES=y
> -CONFIG_HAVE_OPTPROBES=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
> -CONFIG_HAVE_PERF_REGS=y
> -CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> -
> -#
> -# GCOV-based kernel profiling
> -#
> -CONFIG_BLK_DEBUG_FS=y
> -
> -#
> -# Sizes and static limits
> -#
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> -
> -#
> -# Latency settings
> -#
> -CONFIG_XENO_OPT_DEBUG=y
> -CONFIG_XENO_OPT_DEBUG_COBALT=y
> -CONFIG_XENO_OPT_DEBUG_MEMORY=y
> -CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> -CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
> -CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> -
> -#
> -# Testing drivers
> -#
> -CONFIG_XENO_DRIVERS_HEAPCHECK=y
> -
> -#
> -# CAN drivers
> -#
> -CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> -
> -#
> -# Protocols
> -#
> -# CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG is not set
> -# CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG is not set
> -
> -#
> -# ANALOGY drivers
> -#
> -# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is not set
> -
> -#
> -# Real-time GPIO drivers
> -#
> -# CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
> -
> -#
> -# Real-time SPI master drivers
> -#
> -# CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
> -
> -#
> -# CSR SiRF atlas6/primaII/Atlas7 Specific Features
> -#
> -CONFIG_UX500_DEBUG_UART=2
> -
> -#
> -# Processor Features
> -#
> -CONFIG_DEBUG_ALIGN_RODATA=y
> -
> -#
> -# Bus support
> -#
> -# CONFIG_PCIEASPM_DEBUG is not set
> -# CONFIG_PCI_DEBUG is not set
> -
> -#
> -# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
> -#
> -CONFIG_HW_PERF_EVENTS=y
> -
> -#
> -# Power management options
> -#
> -# CONFIG_PM_DEBUG is not set
> -
> -#
> -# CAN USB interfaces
> -#
> -# CONFIG_CAN_DEBUG_DEVICES is not set
> -CONFIG_BT_DEBUGFS=y
> -
> -#
> -# Bluetooth device drivers
> -#
> -# CONFIG_CFG80211_DEBUGFS is not set
> -# CONFIG_CFG80211_INTERNAL_REGDB is not set
> -# CONFIG_MAC80211_DEBUGFS is not set
> -# CONFIG_MAC80211_MESSAGE_TRACING is not set
> -# CONFIG_MAC80211_DEBUG_MENU is not set
> -
> -#
> -# Generic Driver Options
> -#
> -# CONFIG_DEBUG_DRIVER is not set
> -# CONFIG_DEBUG_DEVRES is not set
> -# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> -# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> -CONFIG_GENERIC_CPU_AUTOPROBE=y
> -# CONFIG_DMA_FENCE_TRACE is not set
> -
> -#
> -# RAM/ROM/Flash chip drivers
> -#
> -# CONFIG_MTD_JEDECPROBE is not set
> -
> -#
> -# SCSI Transports
> -#
> -# CONFIG_SCSI_DEBUG is not set
> -
> -#
> -# MII PHY device drivers
> -#
> -# CONFIG_ATH_DEBUG is not set
> -# CONFIG_BRCM_TRACING is not set
> -# CONFIG_RT2X00_DEBUG is not set
> -
> -#
> -# Character devices
> -#
> -# CONFIG_TRACE_SINK is not set
> -
> -#
> -# Other I2C/SMBus bus drivers
> -#
> -# CONFIG_I2C_DEBUG_CORE is not set
> -# CONFIG_I2C_DEBUG_ALGO is not set
> -# CONFIG_I2C_DEBUG_BUS is not set
> -# CONFIG_SPI_DEBUG is not set
> -
> -#
> -# SPI Protocol Masters
> -#
> -# CONFIG_PPS_DEBUG is not set
> -
> -#
> -# Pin controllers
> -#
> -# CONFIG_DEBUG_PINCTRL is not set
> -# CONFIG_DEBUG_GPIO is not set
> -
> -#
> -# USB GPIO expanders
> -#
> -# CONFIG_POWER_SUPPLY_DEBUG is not set
> -# CONFIG_HWMON_DEBUG_CHIP is not set
> -
> -#
> -# Watchdog Device Drivers
> -#
> -# CONFIG_BCM_KONA_WDT_DEBUG is not set
> -
> -#
> -# Sonics Silicon Backplane
> -#
> -# CONFIG_BCMA_DEBUG is not set
> -
> -#
> -# Multifunction device drivers
> -#
> -CONFIG_AB8500_DEBUG=y
> -
> -#
> -# STMicroelectronics STMPE Interface Drivers
> -#
> -# CONFIG_REGULATOR_DEBUG is not set
> -
> -#
> -# Multimedia core support
> -#
> -# CONFIG_VIDEO_ADV_DEBUG is not set
> -
> -#
> -# Webcam, TV (analog/digital) USB devices
> -#
> -# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
> -
> -#
> -# Graphics support
> -#
> -# CONFIG_DRM_DEBUG_MM is not set
> -# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> -
> -#
> -# ACP (Audio CoProcessor) Configuration
> -#
> -CONFIG_NOUVEAU_DEBUG=5
> -CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> -
> -#
> -# Sub-drivers
> -#
> -# CONFIG_DRM_TEGRA_DEBUG is not set
> -
> -#
> -# Console display driver support
> -#
> -# CONFIG_SND_DEBUG is not set
> -
> -#
> -# also be needed; see USB_STORAGE Help for more info
> -#
> -# CONFIG_USB_STORAGE_DEBUG is not set
> -
> -#
> -# Gadget/Dual-role mode requires USB Gadget support to be enabled
> -#
> -# CONFIG_USB_DWC2_DEBUG is not set
> -
> -#
> -# USB Physical Layer drivers
> -#
> -# CONFIG_USB_GADGET_DEBUG is not set
> -# CONFIG_USB_GADGET_DEBUG_FILES is not set
> -# CONFIG_USB_GADGET_DEBUG_FS is not set
> -
> -#
> -# MMC/SD/SDIO Host Controller Drivers
> -#
> -# CONFIG_MMC_DEBUG is not set
> -
> -#
> -# iptables trigger is under Netfilter config (LED target)
> -#
> -# CONFIG_EDAC_DEBUG is not set
> -# CONFIG_RTC_DEBUG is not set
> -
> -#
> -# HID Sensor RTC drivers
> -#
> -# CONFIG_DMADEVICES_DEBUG is not set
> -
> -#
> -# Clock Source drivers
> -#
> -CONFIG_TIMER_PROBE=y
> -
> -#
> -# Extcon Device Drivers
> -#
> -# CONFIG_OMAP_GPMC_DEBUG is not set
> -
> -#
> -# File systems
> -#
> -# CONFIG_EXT4_DEBUG is not set
> -# CONFIG_JBD2_DEBUG is not set
> -
> -#
> -# DOS/FAT/NT Filesystems
> -#
> -# CONFIG_NTFS_DEBUG is not set
> -
> -#
> -# Pseudo filesystems
> -#
> -# CONFIG_SUNRPC_DEBUG is not set
> -
> -#
> -# printk and dmesg options
> -#
> -# CONFIG_DYNAMIC_DEBUG is not set
> -
> -#
> -# Compile-time checks and compiler options
> -#
> -# CONFIG_DEBUG_INFO is not set
> -CONFIG_DEBUG_FS=y
> -# CONFIG_DEBUG_SECTION_MISMATCH is not set
> -# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> -CONFIG_IPIPE_DEBUG=y
> -CONFIG_IPIPE_DEBUG_CONTEXT=y
> -CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> -# CONFIG_IPIPE_TRACE is not set
> -CONFIG_DEBUG_KERNEL=y
> -
> -#
> -# Memory Debugging
> -#
> -# CONFIG_PAGE_EXTENSION is not set
> -# CONFIG_DEBUG_PAGEALLOC is not set
> -# CONFIG_DEBUG_PAGE_REF is not set
> -# CONFIG_DEBUG_RODATA_TEST is not set
> -# CONFIG_DEBUG_OBJECTS is not set
> -# CONFIG_SLUB_DEBUG_ON is not set
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> -# CONFIG_DEBUG_KMEMLEAK is not set
> -# CONFIG_DEBUG_STACK_USAGE is not set
> -# CONFIG_DEBUG_VM is not set
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> -# CONFIG_DEBUG_VIRTUAL is not set
> -# CONFIG_DEBUG_MEMORY_INIT is not set
> -# CONFIG_DEBUG_PER_CPU_MAPS is not set
> -# CONFIG_DEBUG_HIGHMEM is not set
> -# CONFIG_DEBUG_SHIRQ is not set
> -
> -#
> -# Debug Lockups and Hangs
> -#
> -CONFIG_SCHED_DEBUG=y
> -# CONFIG_SCHED_INFO is not set
> -# CONFIG_DEBUG_TIMEKEEPING is not set
> -
> -#
> -# Lock Debugging (spinlocks, mutexes, etc...)
> -#
> -# CONFIG_DEBUG_RT_MUTEXES is not set
> -# CONFIG_DEBUG_SPINLOCK is not set
> -# CONFIG_DEBUG_MUTEXES is not set
> -# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> -# CONFIG_DEBUG_LOCK_ALLOC is not set
> -# CONFIG_PROVE_LOCKING is not set
> -# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> -# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> -CONFIG_STACKTRACE=y
> -# CONFIG_DEBUG_KOBJECT is not set
> -CONFIG_DEBUG_BUGVERBOSE=y
> -# CONFIG_DEBUG_LIST is not set
> -# CONFIG_DEBUG_PI_LIST is not set
> -# CONFIG_DEBUG_SG is not set
> -# CONFIG_DEBUG_NOTIFIERS is not set
> -# CONFIG_DEBUG_CREDENTIALS is not set
> -
> -#
> -# RCU Debugging
> -#
> -# CONFIG_PROVE_RCU is not set
> -# CONFIG_RCU_PERF_TEST is not set
> -CONFIG_RCU_TRACE=y
> -# CONFIG_RCU_EQS_DEBUG is not set
> -# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> -# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> -CONFIG_NOP_TRACER=y
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> -CONFIG_HAVE_DYNAMIC_FTRACE=y
> -CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> -CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> -CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> -CONFIG_TRACE_CLOCK=y
> -CONFIG_RING_BUFFER=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_TRACING=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_FTRACE=y
> -# CONFIG_FUNCTION_TRACER is not set
> -# CONFIG_IRQSOFF_TRACER is not set
> -# CONFIG_SCHED_TRACER is not set
> -# CONFIG_HWLAT_TRACER is not set
> -# CONFIG_ENABLE_DEFAULT_TRACERS is not set
> -# CONFIG_FTRACE_SYSCALLS is not set
> -# CONFIG_TRACER_SNAPSHOT is not set
> -CONFIG_BRANCH_PROFILE_NONE=y
> -# CONFIG_STACK_TRACER is not set
> -# CONFIG_BLK_DEV_IO_TRACE is not set
> -CONFIG_UPROBE_EVENTS=y
> -CONFIG_PROBE_EVENTS=y
> -# CONFIG_TRACEPOINT_BENCHMARK is not set
> -# CONFIG_RING_BUFFER_BENCHMARK is not set
> -# CONFIG_RING_BUFFER_STARTUP_TEST is not set
> -# CONFIG_TRACE_EVAL_MAP_FILE is not set
> -CONFIG_TRACING_EVENTS_GPIO=y
> -# CONFIG_DMA_API_DEBUG is not set
> -
> -#
> -# Runtime Testing
> -#
> -# CONFIG_BACKTRACE_SELF_TEST is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> -# CONFIG_KGDB is not set
> -# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> -# CONFIG_UBSAN is not set
> -CONFIG_ARM_UNWIND=y
> -# CONFIG_DEBUG_USER is not set
> -# CONFIG_DEBUG_LL is not set
> -CONFIG_DEBUG_IMX_UART_PORT=1
> -CONFIG_DEBUG_VF_UART_PORT=1
> -CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
> -# CONFIG_DEBUG_UART_8250 is not set
> -
> -#
> -# Library routines
> -#
> diff --git a/recipes-kernel/linux/files/amd64_debugconfig b/recipes-kernel/linux/files/common_debug.cfg
> similarity index 70%
> rename from recipes-kernel/linux/files/amd64_debugconfig
> rename to recipes-kernel/linux/files/common_debug.cfg
> index a07ec9d..16b5f78 100644
> --- a/recipes-kernel/linux/files/amd64_debugconfig
> +++ b/recipes-kernel/linux/files/common_debug.cfg
> @@ -1,51 +1,55 @@
> +
>  #
>  # Debug Kernel Configuration
>  #
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_STACKTRACE_SUPPORT=y
>  CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>  CONFIG_ARCH_SUPPORTS_UPROBES=y
> +CONFIG_LOCKDEP_SUPPORT=y
> +CONFIG_STACKTRACE_SUPPORT=y
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>  
>  #
>  # IRQ subsystem
>  #
> -CONFIG_GENERIC_IRQ_PROBE=y
> -# CONFIG_IRQ_DOMAIN_DEBUG is not set
>  # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> +CONFIG_GENERIC_IRQ_PROBE=y
> +CONFIG_IRQ_DOMAIN_DEBUG=y
>  
>  #
>  # RCU Subsystem
>  #
> -# CONFIG_CGROUP_PERF is not set
>  # CONFIG_CGROUP_DEBUG is not set
> -CONFIG_SYSCTL_EXCEPTION_TRACE=y
> +CONFIG_CGROUP_PERF=y
> +# CONFIG_DEBUG_BLK_CGROUP is not set
> +CONFIG_HAVE_PERF_EVENTS=y
>  CONFIG_KALLSYMS=y
> -CONFIG_KALLSYMS_ALL=y
>  CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> +CONFIG_KALLSYMS_ALL=y
>  CONFIG_KALLSYMS_BASE_RELATIVE=y
> -CONFIG_HAVE_PERF_EVENTS=y
> +CONFIG_PERF_USE_VMALLOC=y
> +CONFIG_SYSCTL_EXCEPTION_TRACE=y
>  
>  #
>  # Kernel Performance Events And Counters
>  #
> -CONFIG_PERF_EVENTS=y
>  # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> -CONFIG_SLUB_DEBUG=y
> -CONFIG_TRACEPOINTS=y
> -CONFIG_KPROBES=y
> -CONFIG_OPTPROBES=y
> -CONFIG_UPROBES=y
> -CONFIG_KRETPROBES=y
> +CONFIG_HAVE_ARCH_TRACEHOOK=y
> +CONFIG_HAVE_DMA_API_DEBUG=y
> +CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>  CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KPROBES_ON_FTRACE=y
>  CONFIG_HAVE_KRETPROBES=y
>  CONFIG_HAVE_OPTPROBES=y
> -CONFIG_HAVE_KPROBES_ON_FTRACE=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
>  CONFIG_HAVE_PERF_EVENTS_NMI=y
> -CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>  CONFIG_HAVE_PERF_REGS=y
>  CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +CONFIG_KPROBES=y
> +CONFIG_KRETPROBES=y
> +CONFIG_OPTPROBES=y
> +CONFIG_PERF_EVENTS=y
> +CONFIG_SLUB_DEBUG=y
> +CONFIG_TRACEPOINTS=y
> +CONFIG_UPROBES=y
>  
>  #
>  # GCOV-based kernel profiling
> @@ -60,22 +64,22 @@ CONFIG_BLK_DEBUG_FS=y
>  #
>  # Sizes and static limits
>  #
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +# CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ is not set
>  
>  #
>  # Latency settings
>  #
>  CONFIG_XENO_OPT_DEBUG=y
>  CONFIG_XENO_OPT_DEBUG_COBALT=y
> -# CONFIG_XENO_OPT_DEBUG_MEMORY is not set
>  CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> +CONFIG_XENO_OPT_DEBUG_LEGACY=y
>  CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> +CONFIG_XENO_OPT_DEBUG_MEMORY=y
>  CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
>  CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
>  CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
>  CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +CONFIG_XENO_OPT_DEBUG_USER=y
>  
>  #
>  # Testing drivers
> @@ -90,16 +94,16 @@ CONFIG_XENO_DRIVERS_CAN_DEBUG=y
>  #
>  # Protocols
>  #
> -CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
>  CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> +CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
>  
>  #
>  # ANALOGY drivers
>  #
>  CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
>  # CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE is not set
> -CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
> -CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
> +# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL is not set
> +# CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL is not set
>  
>  #
>  # Real-time GPIO drivers
> @@ -115,30 +119,30 @@ CONFIG_X86_DEBUGCTLMSR=y
>  #
>  # Performance monitoring
>  #
> -CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> -CONFIG_PERF_EVENTS_INTEL_RAPL=y
> -CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> -# CONFIG_PERF_EVENTS_AMD_POWER is not set
>  CONFIG_ARCH_MEMORY_PROBE=y
> +# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>  CONFIG_MTRR_SANITIZER=y
> -CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> -CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> +# CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT is not set
> +# CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT is not set
> +# CONFIG_PERF_EVENTS_AMD_POWER is not set
> +CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> +CONFIG_PERF_EVENTS_INTEL_RAPL=y
> +CONFIG_PERF_EVENTS_INTEL_UNCORE=y
>  # CONFIG_RANDOMIZE_BASE is not set
> -# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>  
>  #
>  # Power management and ACPI options
>  #
> -CONFIG_PM_DEBUG=y
> +# CONFIG_ACPI_APEI_ERST_DEBUG is not set
> +# CONFIG_ACPI_DEBUG is not set
> +# CONFIG_ACPI_DEBUGGER is not set
> +# CONFIG_ACPI_EC_DEBUGFS is not set
>  # CONFIG_PM_ADVANCED_DEBUG is not set
> -CONFIG_PM_TEST_SUSPEND=y
> +CONFIG_PM_DEBUG=y
>  CONFIG_PM_SLEEP_DEBUG=y
> +CONFIG_PM_TEST_SUSPEND=y
>  CONFIG_PM_TRACE=y
>  CONFIG_PM_TRACE_RTC=y
> -# CONFIG_ACPI_DEBUGGER is not set
> -# CONFIG_ACPI_EC_DEBUGFS is not set
> -# CONFIG_ACPI_DEBUG is not set
> -# CONFIG_ACPI_APEI_ERST_DEBUG is not set
>  
>  #
>  # Bus options (PCI etc.)
> @@ -164,11 +168,12 @@ CONFIG_PM_TRACE_RTC=y
>  #
>  # Generic Driver Options
>  #
> -# CONFIG_DEBUG_DRIVER is not set
>  # CONFIG_DEBUG_DEVRES is not set
> +# CONFIG_DEBUG_DRIVER is not set
>  # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> -# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> +# CONFIG_DMA_FENCE_TRACE is not set
>  CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>  
>  #
>  # Bus devices
> @@ -194,10 +199,11 @@ CONFIG_PNP_DEBUG_MESSAGES=y
>  #
>  # Other I2C/SMBus bus drivers
>  #
> -# CONFIG_I2C_DEBUG_CORE is not set
>  # CONFIG_I2C_DEBUG_ALGO is not set
>  # CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
>  # CONFIG_PPS_DEBUG is not set
> +# CONFIG_SPI_DEBUG is not set
>  
>  #
>  # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> @@ -207,12 +213,13 @@ CONFIG_PNP_DEBUG_MESSAGES=y
>  #
>  # USB GPIO expanders
>  #
> -# CONFIG_POWER_SUPPLY_DEBUG is not set
>  # CONFIG_HWMON_DEBUG_CHIP is not set
> +# CONFIG_POWER_SUPPLY_DEBUG is not set
>  
>  #
>  # Multifunction device drivers
>  #
> +CONFIG_AB8500_DEBUG=y
>  # CONFIG_REGULATOR_DEBUG is not set
>  
>  #
> @@ -230,6 +237,7 @@ CONFIG_DMADEVICES_DEBUG=y
>  #
>  # File systems
>  #
> +# CONFIG_BTRFS_DEBUG is not set
>  # CONFIG_EXT4_DEBUG is not set
>  # CONFIG_JBD2_DEBUG is not set
>  # CONFIG_QUOTA_DEBUG is not set
> @@ -243,11 +251,7 @@ CONFIG_DMADEVICES_DEBUG=y
>  # Pseudo filesystems
>  #
>  # CONFIG_PSTORE_FTRACE is not set
> -
> -#
> -# Kernel hacking
> -#
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +# CONFIG_SUNRPC_DEBUG is not set
>  
>  #
>  # printk and dmesg options
> @@ -257,180 +261,346 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>  #
>  # Compile-time checks and compiler options
>  #
> +CONFIG_ARCH_WANT_FRAME_POINTERS=y
> +# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> +CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_INFO=y
> +# CONFIG_DEBUG_INFO_DWARF4 is not set
>  # CONFIG_DEBUG_INFO_REDUCED is not set
>  # CONFIG_DEBUG_INFO_SPLIT is not set
> -# CONFIG_DEBUG_INFO_DWARF4 is not set
> -CONFIG_GDB_SCRIPTS=y
> -CONFIG_DEBUG_FS=y
> +CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_SECTION_MISMATCH=y
> -# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> +CONFIG_FRAME_POINTER=y
> +CONFIG_GDB_SCRIPTS=y
> +CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
>  CONFIG_IPIPE_DEBUG=y
>  CONFIG_IPIPE_DEBUG_CONTEXT=y
>  CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
>  CONFIG_IPIPE_TRACE=y
>  # CONFIG_IPIPE_TRACE_ENABLE is not set
> -CONFIG_IPIPE_TRACE_MCOUNT=y
>  CONFIG_IPIPE_TRACE_IRQSOFF=y
> -CONFIG_IPIPE_TRACE_SHIFT=14
> -# CONFIG_IPIPE_TRACE_VMALLOC is not set
> +CONFIG_IPIPE_TRACE_MCOUNT=y
>  CONFIG_IPIPE_TRACE_PANIC=y
> -CONFIG_DEBUG_KERNEL=y
> +# CONFIG_IPIPE_TRACE_SHIFT is not set
> +# CONFIG_IPIPE_TRACE_VMALLOC is not set
> +CONFIG_MAGIC_SYSRQ=y
> +# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE is not set
> +CONFIG_MAGIC_SYSRQ_SERIAL=y
>  
>  #
>  # Memory Debugging
>  #
> -CONFIG_PAGE_EXTENSION=y
> +CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +CONFIG_ARCH_HAS_KCOV=y
> +# CONFIG_DEBUG_HIGHMEM is not set
> +# CONFIG_DEBUG_KMEMLEAK is not set
> +CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_OBJECTS is not set
>  CONFIG_DEBUG_PAGEALLOC=y
>  # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
>  # CONFIG_DEBUG_PAGE_REF is not set
> +# CONFIG_DEBUG_PER_CPU_MAPS is not set
>  CONFIG_DEBUG_RODATA_TEST=y
> -# CONFIG_DEBUG_OBJECTS is not set
> -CONFIG_SLUB_DEBUG_ON=y
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> -# CONFIG_DEBUG_KMEMLEAK is not set
> +CONFIG_DEBUG_SHIRQ=y
> +# CONFIG_DEBUG_STACKOVERFLOW is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
> +CONFIG_DEBUG_VIRTUAL=y
>  CONFIG_DEBUG_VM=y
> -# CONFIG_DEBUG_VM_VMACACHE is not set
> -# CONFIG_DEBUG_VM_RB is not set
>  # CONFIG_DEBUG_VM_PGFLAGS is not set
>  CONFIG_DEBUG_VM_PGTABLE=y
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> -CONFIG_DEBUG_VIRTUAL=y
> -CONFIG_DEBUG_MEMORY_INIT=y
> -# CONFIG_DEBUG_PER_CPU_MAPS is not set
> -CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> -# CONFIG_DEBUG_STACKOVERFLOW is not set
> +# CONFIG_DEBUG_VM_RB is not set
> +# CONFIG_DEBUG_VM_VMACACHE is not set
>  CONFIG_HAVE_ARCH_KASAN=y
> +CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>  # CONFIG_KASAN is not set
> -CONFIG_ARCH_HAS_KCOV=y
>  # CONFIG_KCOV is not set
> -CONFIG_DEBUG_SHIRQ=y
> +CONFIG_PAGE_EXTENSION=y
> +CONFIG_SLUB_DEBUG_ON=y
>  
>  #
>  # Debug Lockups and Hangs
>  #
> +CONFIG_DEBUG_PREEMPT=y
> +# CONFIG_DEBUG_TIMEKEEPING is not set
>  CONFIG_SCHED_DEBUG=y
>  CONFIG_SCHED_INFO=y
> -# CONFIG_DEBUG_TIMEKEEPING is not set
> -CONFIG_DEBUG_PREEMPT=y
>  
>  #
>  # Lock Debugging (spinlocks, mutexes, etc...)
>  #
> -CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_MUTEXES=y
> -# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> -CONFIG_DEBUG_LOCK_ALLOC=y
> -CONFIG_PROVE_LOCKING=y
> -CONFIG_LOCKDEP=y
> -# CONFIG_DEBUG_LOCKDEP is not set
>  CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> -CONFIG_TRACE_IRQFLAGS=y
> -CONFIG_STACKTRACE=y
> -# CONFIG_DEBUG_KOBJECT is not set
>  CONFIG_DEBUG_BUGVERBOSE=y
> +# CONFIG_DEBUG_CREDENTIALS is not set
> +# CONFIG_DEBUG_KOBJECT is not set
>  CONFIG_DEBUG_LIST=y
> +# CONFIG_DEBUG_LOCKDEP is not set
> +CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_DEBUG_MUTEXES=y
> +# CONFIG_DEBUG_NOTIFIERS is not set
>  CONFIG_DEBUG_PI_LIST=y
> +CONFIG_DEBUG_RT_MUTEXES=y
>  # CONFIG_DEBUG_SG is not set
> -# CONFIG_DEBUG_NOTIFIERS is not set
> -# CONFIG_DEBUG_CREDENTIALS is not set
> +CONFIG_DEBUG_SPINLOCK=y
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> +CONFIG_HAVE_DEBUG_BUGVERBOSE=y
> +CONFIG_LOCKDEP=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_STACKTRACE=y
> +CONFIG_TRACE_IRQFLAGS=y
>  
>  #
>  # RCU Debugging
>  #
> -# CONFIG_PROVE_RCU is not set
> -# CONFIG_RCU_PERF_TEST is not set
> -# CONFIG_RCU_TRACE is not set
> -# CONFIG_RCU_EQS_DEBUG is not set
> -# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> +# CONFIG_BLK_DEV_IO_TRACE is not set
> +CONFIG_BRANCH_PROFILE_NONE=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
>  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> -CONFIG_USER_STACKTRACE_SUPPORT=y
> -CONFIG_NOP_TRACER=y
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> +# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> +# CONFIG_DMA_API_DEBUG is not set
> +# CONFIG_ENABLE_DEFAULT_TRACERS is not set
> +CONFIG_EVENT_TRACING=y
> +CONFIG_FTRACE=y
> +# CONFIG_FTRACE_STARTUP_TEST is not set
> +CONFIG_FTRACE_SYSCALLS=y
> +CONFIG_FUNCTION_GRAPH_TRACER=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_GENERIC_TRACER=y
>  CONFIG_HAVE_DYNAMIC_FTRACE=y
>  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>  CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> +CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> +CONFIG_HAVE_FUNCTION_TRACER=y
>  CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> -CONFIG_TRACER_MAX_TRACE=y
> -CONFIG_TRACE_CLOCK=y
> -CONFIG_RING_BUFFER=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_RING_BUFFER_ALLOW_SWAP=y
> -CONFIG_TRACING=y
> -CONFIG_GENERIC_TRACER=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_FTRACE=y
> -CONFIG_FUNCTION_TRACER=y
> -CONFIG_FUNCTION_GRAPH_TRACER=y
> -CONFIG_IRQSOFF_TRACER=y
> -# CONFIG_PREEMPT_TRACER is not set
> -CONFIG_SCHED_TRACER=y
>  # CONFIG_HWLAT_TRACER is not set
> -CONFIG_FTRACE_SYSCALLS=y
> -CONFIG_TRACER_SNAPSHOT=y
> -CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> -CONFIG_BRANCH_PROFILE_NONE=y
> -# CONFIG_STACK_TRACER is not set
> -# CONFIG_BLK_DEV_IO_TRACE is not set
> +CONFIG_IRQSOFF_TRACER=y
>  CONFIG_KPROBE_EVENTS=y
> -CONFIG_UPROBE_EVENTS=y
> -CONFIG_PROBE_EVENTS=y
> -# CONFIG_FTRACE_STARTUP_TEST is not set
>  # CONFIG_MMIOTRACE is not set
> -# CONFIG_TRACEPOINT_BENCHMARK is not set
> +CONFIG_NOP_TRACER=y
> +# CONFIG_PREEMPT_TRACER is not set
> +CONFIG_PROBE_EVENTS=y
> +# CONFIG_PROVE_RCU is not set
> +# CONFIG_RCU_EQS_DEBUG is not set
> +# CONFIG_RCU_PERF_TEST is not set
> +CONFIG_RCU_TRACE=y
> +CONFIG_RING_BUFFER=y
> +CONFIG_RING_BUFFER_ALLOW_SWAP=y
>  # CONFIG_RING_BUFFER_BENCHMARK is not set
>  # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> +CONFIG_SCHED_TRACER=y
> +# CONFIG_STACK_TRACER is not set
> +# CONFIG_TRACEPOINT_BENCHMARK is not set
> +CONFIG_TRACER_MAX_TRACE=y
> +CONFIG_TRACER_SNAPSHOT=y
> +CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> +CONFIG_TRACE_CLOCK=y
>  # CONFIG_TRACE_EVAL_MAP_FILE is not set
> +CONFIG_TRACING=y
>  CONFIG_TRACING_EVENTS_GPIO=y
> -# CONFIG_DMA_API_DEBUG is not set
> +CONFIG_TRACING_SUPPORT=y
> +CONFIG_UPROBE_EVENTS=y
> +CONFIG_USER_STACKTRACE_SUPPORT=y
>  
>  #
>  # Runtime Testing
>  #
> -# CONFIG_KPROBES_SANITY_TEST is not set
> -# CONFIG_BACKTRACE_SELF_TEST is not set
> -# CONFIG_TEST_DEBUG_VIRTUAL is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> -CONFIG_KGDB=y
> -CONFIG_KGDB_SERIAL_CONSOLE=y
> -CONFIG_KGDB_TESTS=y
> -# CONFIG_KGDB_TESTS_ON_BOOT is not set
> -# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
> -# CONFIG_KGDB_KDB is not set
>  CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>  # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> -# CONFIG_UBSAN is not set
> -# CONFIG_DEBUG_WX is not set
> +# CONFIG_ARM64_PTDUMP_DEBUGFS is not set
> +CONFIG_ARM_UNWIND=y
> +# CONFIG_BACKTRACE_SELF_TEST is not set
> +# CONFIG_CPA_DEBUG is not set
> +# CONFIG_DEBUG_BOOT_PARAMS is not set
> +# CONFIG_DEBUG_EFI is not set
> +# CONFIG_DEBUG_ENTRY is not set
> +# CONFIG_DEBUG_IMX_UART_PORT is not set
> +# CONFIG_DEBUG_LL is not set
> +# CONFIG_DEBUG_LL_INCLUDE is not set
> +# CONFIG_DEBUG_NMI_SELFTEST is not set
>  # CONFIG_DEBUG_TLBFLUSH is not set
> -# CONFIG_IOMMU_DEBUG is not set
> +# CONFIG_DEBUG_UART_8250 is not set
> +# CONFIG_DEBUG_USER is not set
> +# CONFIG_DEBUG_VF_UART_PORT is not set
> +# CONFIG_DEBUG_WX is not set
> +# CONFIG_DEFAULT_IO_DELAY_TYPE is not set
> +CONFIG_HAVE_ARCH_KGDB=y
>  CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> -CONFIG_IO_DELAY_TYPE_0X80=0
> -CONFIG_IO_DELAY_TYPE_0XED=1
> -CONFIG_IO_DELAY_TYPE_UDELAY=2
> -CONFIG_IO_DELAY_TYPE_NONE=3
> +# CONFIG_IOMMU_DEBUG is not set
>  CONFIG_IO_DELAY_0X80=y
>  # CONFIG_IO_DELAY_0XED is not set
> -# CONFIG_IO_DELAY_UDELAY is not set
>  # CONFIG_IO_DELAY_NONE is not set
> -CONFIG_DEFAULT_IO_DELAY_TYPE=0
> -# CONFIG_DEBUG_BOOT_PARAMS is not set
> -# CONFIG_CPA_DEBUG is not set
> -# CONFIG_DEBUG_ENTRY is not set
> -# CONFIG_DEBUG_NMI_SELFTEST is not set
> -CONFIG_X86_DEBUG_FPU=y
> +# CONFIG_IO_DELAY_TYPE_0X80 is not set
> +# CONFIG_IO_DELAY_TYPE_0XED is not set
> +# CONFIG_IO_DELAY_TYPE_NONE is not set
> +# CONFIG_IO_DELAY_TYPE_UDELAY is not set
> +# CONFIG_IO_DELAY_UDELAY is not set
> +CONFIG_KGDB=y
> +# CONFIG_KGDB_KDB is not set
> +# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
> +CONFIG_KGDB_SERIAL_CONSOLE=y
> +CONFIG_KGDB_TESTS=y
> +# CONFIG_KGDB_TESTS_ON_BOOT is not set
> +# CONFIG_KPROBES_SANITY_TEST is not set
>  # CONFIG_PUNIT_ATOM_DEBUG is not set
> -CONFIG_UNWINDER_ORC=y
> +# CONFIG_TEST_DEBUG_VIRTUAL is not set
> +# CONFIG_UBSAN is not set
>  # CONFIG_UNWINDER_FRAME_POINTER is not set
> +CONFIG_UNWINDER_ORC=y
> +CONFIG_X86_DEBUG_FPU=y
> +
> +#
> +# Real-time SPI master drivers
> +#
> +# CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
> +
> +#
> +# CSR SiRF atlas6/primaII/Atlas7 Specific Features
> +#
> +# CONFIG_UX500_DEBUG_UART is not set
> +
> +#
> +# Processor Features
> +#
> +CONFIG_DEBUG_ALIGN_RODATA=y
> +
> +#
> +# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
> +#
> +CONFIG_HW_PERF_EVENTS=y
> +
> +#
> +# CAN USB interfaces
> +#
> +CONFIG_BT_DEBUGFS=y
> +# CONFIG_CAN_DEBUG_DEVICES is not set
> +
> +#
> +# Bluetooth device drivers
> +#
> +# CONFIG_CFG80211_DEBUGFS is not set
> +# CONFIG_CFG80211_INTERNAL_REGDB is not set
> +# CONFIG_MAC80211_DEBUGFS is not set
> +# CONFIG_MAC80211_DEBUG_MENU is not set
> +# CONFIG_MAC80211_MESSAGE_TRACING is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +# CONFIG_MTD_JEDECPROBE is not set
> +
> +#
> +# SCSI Transports
> +#
> +# CONFIG_SCSI_DEBUG is not set
> +
> +#
> +# MII PHY device drivers
> +#
> +# CONFIG_ATH_DEBUG is not set
> +# CONFIG_BRCM_TRACING is not set
> +# CONFIG_RT2X00_DEBUG is not set
> +
> +#
> +# Pin controllers
> +#
> +# CONFIG_DEBUG_PINCTRL is not set
> +
> +#
> +# Watchdog Device Drivers
> +#
> +# CONFIG_BCM_KONA_WDT_DEBUG is not set
> +
> +#
> +# Sonics Silicon Backplane
> +#
> +# CONFIG_BCMA_DEBUG is not set
> +
> +#
> +# Multimedia core support
> +#
> +# CONFIG_VIDEO_ADV_DEBUG is not set
> +
> +#
> +# Webcam, TV (analog/digital) USB devices
> +#
> +# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_DRM_DEBUG_MM is not set
> +# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> +
> +#
> +# ACP (Audio CoProcessor) Configuration
> +#
> +# CONFIG_NOUVEAU_DEBUG is not set
> +# CONFIG_NOUVEAU_DEBUG_DEFAULT is not set
> +
> +#
> +# Sub-drivers
> +#
> +# CONFIG_DRM_TEGRA_DEBUG is not set
> +
> +#
> +# Console display driver support
> +#
> +# CONFIG_SND_DEBUG is not set
> +
> +#
> +# also be needed; see USB_STORAGE Help for more info
> +#
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +
> +#
> +# Gadget/Dual-role mode requires USB Gadget support to be enabled
> +#
> +# CONFIG_USB_DWC2_DEBUG is not set
> +
> +#
> +# USB Physical Layer drivers
> +#
> +# CONFIG_USB_GADGET_DEBUG is not set
> +# CONFIG_USB_GADGET_DEBUG_FILES is not set
> +# CONFIG_USB_GADGET_DEBUG_FS is not set
> +
> +#
> +# MMC/SD/SDIO Host Controller Drivers
> +#
> +# CONFIG_MMC_DEBUG is not set
> +
> +#
> +# Clock Source drivers
> +#
> +CONFIG_TIMER_PROBE=y
> +
> +#
> +# Extcon Device Drivers
> +#
> +# CONFIG_OMAP_GPMC_DEBUG is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +# CONFIG_NTFS_DEBUG is not set
> +
> +#
> +# ARM errata workarounds via the alternatives framework
> +#
> +# CONFIG_CMA_DEBUG is not set
> +# CONFIG_CMA_DEBUGFS is not set
> +
> +#
> +# CPU frequency scaling drivers
> +#
> +# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG is not set
> +
> +#
> +# Distributed Switch Architecture drivers
> +#
> +# CONFIG_SKY2_DEBUG is not set
>  
>  #
> -# Library routines
> +# Tegra firmware driver
>  #
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 501c212..f90de9b 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -16,10 +16,9 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
>  
>  XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
>  KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
> -KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debugconfig"
>  XENOMAI_DEBUG ?= "0"
>  
>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
> -SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
> +SRC_URI += "${@'file://common_debug.cfg' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
>  
>  S = "${WORKDIR}/git"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

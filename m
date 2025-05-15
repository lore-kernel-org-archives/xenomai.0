Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D4202C2A
	for <xenomai@lists.linux.dev>; Thu, 15 May 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294669; cv=fail; b=eTreasEDihitejEzs3PG5ntl1hJwSNJRTvvYiLz4gKIrEv6AeGuKN1VN14ML9enyko2RBwEJGpaV24DTBmE+1uaatAv2qnBk7tPDpt1j0duBKb0dWpCPXntmASU0f0EQe7VjIKKBLNM2bxP/EfyYy9r5UqAlj5q5N2SOIY2nwLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294669; c=relaxed/simple;
	bh=RgnpCSQUwijWIUOhm8lt/0xsd9r1Psjop+m83RVy/cY=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=FtUTLK+CRhxu1md9JowfRDZafLzbbd8v+GKE/nnyPO8ttc4BpYSZBJWJtmYhqg93w6NCR+tMIrqdyqAuolTSGAAt2cMaZRq/V4xbea2z84e75TjorldX2DjdOZI/iyksJrdRFEVre4DYAlqqSK0OGPmaHQepdtuDBZlmkA8UUWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ia9st6eh; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ia9st6eh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYGlBTZWmFkLO5KrWkskdV5fhPeAcuSCk3EnxOlhWGFOaXA9CZa9Gl9ZAMp3WGAsIEr3/1spXcjvz9wdVx7qpe2E88LzSTwxe+5NjhLf3WwLG1cInI+l5nbswkDcTFutqFV0/rSnha0VVTuxdaGbKgtLcvH2OjAcWW9Cwcw7JVZcUgLQTxLkfcgdnpHJiR58Xy5GaOaePr3CQn7NYUyS2wxiFsdAXXbq+S/xVf/BzH4DZy8Vmaw0edJmCjfD7Rs61cG1oyQUErnc10OdbgA8vnlJsZKmuheaAYFkG6lEfOzOnxwr3COXRKc7w0jY3UBNPtY9rxGaQjWxRgd8gJNIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2y2AOJioXz4OXiTngphBld6DogvdikGRRSG9JRtzZI=;
 b=NmrtlxLAkHeb9PvUaBRJfOau1+Z2Ey8xUFcPx+tsjDSfhfEhRfKTJXHIkv+SgyNd3P+19jaJ0wrNtLlmL0PPnoSHf8lP5yeE7D3i6IS3lc+z3sXtbSO2kGTw3UiUI/sp0OFQ1NrcSRW6FbFfXINcPBVXWnApPnoFmNkBKM0amG4dziW+cnuYw8KiY3RpG0W4/8D/wZuIyNqi1BE0sPBEKBFb4Kz/1NtaQf7CNKa+xXON9yIHx9jctClMHBx8lBqteb5F/kFDZr4MyWpWg5VMKXbxNdfAawKdGpTjq1iUGariK05gQ53+gZ/DN82sMgw6UuOjyqDuZex4/wXC1LOigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2y2AOJioXz4OXiTngphBld6DogvdikGRRSG9JRtzZI=;
 b=ia9st6ehJxtjs4LcfnCHsqD3ilQt7xB3Dx0DqoIpOVcjInHIvMJ1igRH/PwYEcu31tUPlDSiDYXPoqfeyxjU0lf+RnP8ROAVkDel8IvzkU9HxuEhA+QtkSGrAvRJ3d8dZSOkYVHjX3naeqBSn/3yIwTuE5/x32eLNp+HeZgXDbfhlKE4a8gdOkupsQh6bi6EMO2VWNBKnScfLvMzuzORYVf5BGIC8TIiNxUWLr2ULwp82SWtnQh+UpjX1mhJ7DSmottXA8ziXqxHpW3A0IIX1wBgJ29o3xb8gXxVxFZVqYhbw8wVnXWN5vBQeVn+nv8ZDwczZJ3TwDtjGOOloPoTlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:612::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 07:37:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:37:42 +0000
Message-ID: <ef69ad94-0fc6-42a2-9e00-48b3c25b6887@siemens.com>
Date: Thu, 15 May 2025 09:37:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Lift kernel builds to cip-based branches
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5086eecb-aeee-4ddf-bd31-08dd93836085
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFhWeDBmU1RrWWYvUzZkWUJvZkRqL012QVJYZmpyTnRwbTZtaUVFTU56MjBU?=
 =?utf-8?B?bVJNaHA0dEltK1BoMXR3Nm9Dbk9sMGFoWWpJYnRLSUdSWjJ2VHlUangyNUtt?=
 =?utf-8?B?OW5QaHp5UDNBVDdyNzgxeHZUR0IzTnROZFRxdWRuYkFXSHpxTkFvOXhWQTFM?=
 =?utf-8?B?QVoxRTArdWhUaGo0amtmSTJMWWdMcWoxWkd2SE5vL3ZYamwwWXlmNkFOSUhS?=
 =?utf-8?B?ZEJEcUsrY1JXUFhvYnVyTFhGVEZBWDR5dHlkUlFEWm9WeDRHemg2UWxOUkhz?=
 =?utf-8?B?ZVc3Z3RwbVliTkg0QWpiU3JxMjRGNThWdUhFYU54TExZc3BRcjFkTXQyV2JB?=
 =?utf-8?B?UnA3YXlNRVdoRVlwMUZSY0ZvU1V1UHJIanExN3p2ODJBbGNGdVNxelpuOWZO?=
 =?utf-8?B?NnA2L3BEMGFTVFFXNHN5a25LcUwvMG55eCszb20zNG9NdXR6Q0xZTjJSK3FK?=
 =?utf-8?B?S0xDbnIrdUh1UHhMYTg0bVZPeWJZLzM4SndvWlVZYUp5TFlVT0ZxTU4rdkhR?=
 =?utf-8?B?ckduYXlDeHYwNjVCUys5YzBuYlFKRWFFOEYvYUZRUTRvdEwxZk1jSkNxeW55?=
 =?utf-8?B?Y0QzT2dyV3FjSFFONk1FOUlwYmVJVmgzd243VStqdWlNUzAxRWNRUDg0ZDls?=
 =?utf-8?B?cUl2MzVkdGpYeU9FZnYwam4rcyszNEljS1l3OE1kWmdFcXRZcHdOQWtLdkUz?=
 =?utf-8?B?NTlEcEx1OVlSTXZ4NE0zVUtZbEdsSi9mMDJwM1BadU95aExwRk0wYktyZjZi?=
 =?utf-8?B?Y2d1K09TZkJIMzdpSXZuRG55SC9SRnVvTGE3aWdJWFhvNEhwSWprOGwyU3F1?=
 =?utf-8?B?cmpSbHZWazRaNFBZcXlQMmJUZzROdGxCVzY3d1MreERDNVlPTnRxWXkrZjZC?=
 =?utf-8?B?QlBid2VNamNwQTY0RG5IMWFEL2wvNy80WC8xOXdJTXVodDVyVm1aaXZxbG8w?=
 =?utf-8?B?MExKNVZ0Y0dITWN1RjRBL0NLTzZubHVONzU1ZlZHVmp0ZHJsdkEvVVdMOTd4?=
 =?utf-8?B?dTZ5SmpZQlh4OXRCMFlRN2NMSjdoWFVsUHhnOU95Z05WR1JsNzNaZHZPamZl?=
 =?utf-8?B?L3ppUCtxUkpvYmJPaG9OOWVIZmdkc3dkV0k5eituU2NLMDlrZGVpczFPcFNI?=
 =?utf-8?B?anp2bmd0L1BkVitJVEQ4ZU1WK0ZCK0RObkZjT0d6bUt4SXFzNFMzc2tjMFVD?=
 =?utf-8?B?TUF2R2xHOHZJb2pzakxxREo4VXFiT0hDVzJDU1dWeFlGN3JZREdraXRQZXg1?=
 =?utf-8?B?U2pxMVBhQm1XRWxmWktmS1k2cW1KbU5uM3F6SWRvZFI2M1pSeHR0MnpDWlV3?=
 =?utf-8?B?MU1vZEs5ZzVrSFhlWW9DOVMyMitwdWVQblFlZ0ZZRm9BZ0pVTVIwNm1oZ2xm?=
 =?utf-8?B?OXFCcnJRRXYwazJ3bSsyTTJILzU2QTRPTVJ5ZEQvMzFGU2tmeVN5anhIUFF5?=
 =?utf-8?B?S2pmcFByK1N1U0E4bzF6NHhIdExFMTdvNHFmMWtHT0RMYkdjSkplWWMwVjYz?=
 =?utf-8?B?QTFUTVZZQlJzY1hBbHQvWFc5ZHBCZWF3Qll6VW4xVGp4SC9NcmJXdUdQczkv?=
 =?utf-8?B?NW5CRUFiL3AwN2RRaVIzK3I5TUM5NXdXUXFla1pXR1lzK2NXeFVIZ1l4RWwr?=
 =?utf-8?B?c1E1RGpQRGVuUHVZMFMzU1BCTGdBRkROclRyQmRGU1RIbEFUcHFMalhGU3VE?=
 =?utf-8?B?KzZHZXpCNDdyVFBhRWhTUVdsQktTbUEwdlpwdWVPUnRJVEp4L0RxcE5jSDlW?=
 =?utf-8?B?aUNzY3l6V1hkMEdOYjhDYUxTTlRKM1lPZ1pHM1c3RHNNT1dDeVpleU9GS2pi?=
 =?utf-8?B?cGxtK1ZGMDBmYnl0Wi9peXRxblBYU0xHQ0lSQWRHeXQ3cFJMaXJxTEVnRTRj?=
 =?utf-8?B?YnNBR0x2UjJtYmlWTVJEMitaeDVoZHd2dWg3bEFubzg3UkZlTksvK0xHK3pt?=
 =?utf-8?Q?0yrhF3o6/oI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NoUDUzeTZ6U0s1U3F0TWZLcFFpNlJldDU5eEhram5Yd0NyT3QybFlzY21P?=
 =?utf-8?B?eEFZMjd3TU93czVrU256TXNveDJBbm9DVzYwZHNJeDRsUlhpWnpqb0F6a21l?=
 =?utf-8?B?eFhoK2tkcit5VmdpOTZ2Ujdja2lUVXJjUFUwQjdZc1NldXVrbWRqYWVJQ2tP?=
 =?utf-8?B?ZUtGRkh5TEtzd0wxMmpwZmxOUStzeTNjUk1McktkVmhTcDNFdTVEWUYzN1d6?=
 =?utf-8?B?dkxsR2g2M0tFT3k0OUNId2xyck90M2t2K2szRW45aitmbWVCcmRXQ2FZblVq?=
 =?utf-8?B?SHBsZDdpdHZ1eW5aelFCd0RMc2x2cEk3Q2lrWCtnVnVtR0N2WmtET1JrWGI3?=
 =?utf-8?B?YU1OTVdZOElEZ3hNNTlZVE9QaTRjVGxqTUI4S0dveU1SVitmdzc4elpHUXlv?=
 =?utf-8?B?Z0lDMXZ6M3VpMnBaTzBOR1VWS2VJZnF4RzM3NEtxMHlmbWRYclJYaHg4TzVF?=
 =?utf-8?B?Smx5enRtR1EzM29MQ3RJQWlpRkQ4cXNEcU5yQlRMVk5EMEtkUlNQSUxJcmg0?=
 =?utf-8?B?YWRkZFlzajU3a2xnZ2Q5SXVaRXdUMEZIdFMzUGxoMXhkcTR1WW1heENwclpi?=
 =?utf-8?B?djdGYms0cXVsVkJEQzcyNkREd1pIS3p3R28vSEEvVFhDam42MElGR3AvLzhs?=
 =?utf-8?B?bmh4WEpyOGRzNFhmMnZmVUpXNUZYRUFHUWJBMmRSaWtxQ2hyaWJteGRVUVJL?=
 =?utf-8?B?M0xXc2h2cHVKUkN3ZWNML1E5bmVjemNNVjF3MHlEYW9JbGU1OEcvaFRpYis3?=
 =?utf-8?B?SUwvdkJHU1FCclJZV3hVcG5JVnJwcXVsbldnZ25MdklYT3g5Y1kyS0pnSHhM?=
 =?utf-8?B?TnpaL2xEK1lVM1hwK2hFTUZWR3JaQ3Z2b01pbUhzR2l1RkFNYTZtWVd4Ui9x?=
 =?utf-8?B?ZThWSVZnb0pEeHp2Q1ErZnRDTFZ4NExHUE1QbFJSVlJwT2xXYmErUFlBcDF1?=
 =?utf-8?B?SVlLRW5PZElvM0VEQTBCSDREcVBGRVBpYXlPSUJmMUlDQ0I1U1Fjak1KY1J2?=
 =?utf-8?B?akNzVW9jRVZkNkExSnFqT3R6WWNoOEUzRXJweDhqK0xFcDdSMWVKR0tKUE83?=
 =?utf-8?B?YnBxSCtLN0h4K2JMbE0vK0xNNGRSUVJwZkJ3SWZCU1NGMGNVV3ZmRkFKRHRI?=
 =?utf-8?B?U0NCYWg5QktTY2JEN3gvWWRsSVRiT0tFNW1VTFg2TXFWRHJYNllUT2puTkVQ?=
 =?utf-8?B?T3c2TloyWjJDcVZ0dE04c0FFYnhkWE5td2VvNWdNV0hRSHVaVmgvb00vd2cv?=
 =?utf-8?B?UThhQ252Mkc5Q0wwbVlZNXdYUkhKdXhXcDlTbm5hWElSbzdqdENnQ3haNFFE?=
 =?utf-8?B?RklPa3NTZ3gzL2IreVVKdnpKZlQydlV3MUNPRnRiUVA2eHU1dFJqcU02eTFW?=
 =?utf-8?B?TzlRTkdBY3ZZNmh5bldpQnpOR2ZOSFhWK2JBWlFDQmtPUnIrd2FqK0w1TFd2?=
 =?utf-8?B?cTI5T2IwRW1TcDJIc2tqV1VZSmJPUkdCbkRKOHFTb3MydzBiYllscjBFak1v?=
 =?utf-8?B?N2MxTHhUSytUWW1MeFZVdGpjVWVOL01MUmRQWXFSTmZzZkNxZ2dQcWNNZDNx?=
 =?utf-8?B?dzF2MmRJSTdXVk5UZXVndWJxdkpKcVYreXE2c1U0NUFTQ1U0UDlSbitvZk1z?=
 =?utf-8?B?U2pNK2YyVFA5NWpPd0hNRVhEUmVmVHliMHdZVDA3dnFMbk8yTWJocUlJbm1S?=
 =?utf-8?B?SklCeExnVWxJOVFDYUtCVjhRdVNJbUJjb0IvYW1oNzVkcWZyd3RyOFVVMldu?=
 =?utf-8?B?UExFYTlIdXV1UlEwNXhZTDB5ZDV4NEVIc255OVM0bzF1RTBxZ21tMzZCK3kv?=
 =?utf-8?B?RTFUbzNNZzZkL3dSd3poWW9ZU3JiTnp0MUpDWXFmZStPSjJMZi96MlpMazRQ?=
 =?utf-8?B?amNHMnhWU0lnUHAxNTE2YW92Sm1yRXJpVGRhdlJHM2RuR1ZXTEU0clVlM3JD?=
 =?utf-8?B?bkFXSFQ5TFBEQ2Vod1d3MTlNUzZtU25udGFLbjlJVG5EVXk1UVVLQW00OG5n?=
 =?utf-8?B?aUtnSUJvd29wZUdRbjFCNmdjRVdSRTdEaGNiVDJ1aFdPOURyTzFkMHlMeU0w?=
 =?utf-8?B?SkQyblJkcEcyRWkweDhpd2hWTUFXbHFjbzFnN2wrZnRpcGVhak10Uys1TmE4?=
 =?utf-8?B?K1Q0U2N4d2ZEOW54c0VuczlXNzVFWUJFSXZoSThmSUVaT0J2dVEvWjIxc0V0?=
 =?utf-8?Q?XSUoOKtdVLgUok/gmmHmvMdeT03zS/YN2kldvJvrcV+l?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5086eecb-aeee-4ddf-bd31-08dd93836085
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:37:42.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBREfxzErRKFLsCeT+N6dmS2d21ogVjukTkH2wadKfcAlf2Joc2/8GzKSIjSLzoGoe7C7j+LXkNexasc52mzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7133

From: Jan Kiszka <jan.kiszka@siemens.com>

The regular ones have be retired in favor of CIP kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 82dcb437de..7f15abcfbe 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -197,14 +197,14 @@ arm-6.1-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: v6.1.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-5.10-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm64-6.xx-latest:
@@ -218,14 +218,14 @@ arm64-6.1-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: v6.1.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
 arm64-5.10-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
 x86-6.xx-latest:
@@ -239,14 +239,14 @@ x86-6.1-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: v6.1.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-5.10-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 i386-userland:
-- 
2.43.0

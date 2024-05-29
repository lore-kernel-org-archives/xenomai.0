Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FBE576
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999364; cv=fail; b=LNubBb3nCzVnpb7fJCgknVHRoH0xqiwNHJWPiCB3PC7zikL+s0IABYomMAH2N7DlQRf0t0Pm8ybxoGh/jydAwc1dKi/faG/0+/xzkvbvthBFnZ4q9B1Kqpbau6vyKbI9JlXWwPqF7NejrN4CttNOEmZLcHA9WihyUFf56lMbf7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999364; c=relaxed/simple;
	bh=ouRdk/h97H/Pw+AMpfWJ7yRGah1p4+INvHy4pNl0PkA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQ4k8L7dyGxzKZ+n29/cte5zCQ6zgZMbMg18fqY2S2lxsYVCMPpUkIlZ56zMx7qEfZsQ6+yslFEhb2xvGKDFVvPsbZW7A0NNlz7C5gqo2JjirRzXYEO0gM+yk/+mrmTrEpSNRUd2mv+FS1MyleNi0gaw8Sx1FPnN1z28meTgUBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gaM9d6Kj; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gaM9d6Kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBGWzsLy2Ut6rKmAJ1Cy82g9f7umjJ3lW5CuvUHnspW7KtLcApCCC8qZlQiF9QBU/BvJVhGt9eN5rbfhZJn17ZEfaApe9vhh8NpZPhcc5dgmv+otFo3PVutnb39srvKBllzS1iqwNn9tEN1mfzYNSZMGUx05eJY2Llx1GNDxUftojiokPbHY6OHgtSK0hWNUCsAMRSSf94rxPC2yVkSBynk9VNE8aLcZbJWj7qrZYEgVthEm43SAH0oyqigpcHaZ6+wWyUCZfUuHvWwzSwQNEtWaFsCa4ZEHSavOGypRHBY1cHeycnYlfHzasdvB84MEpHD29j7QTrobhJn5iDctag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xroM0cxctImI19hG/zK5niroHjPEztjQ3bPpWzyXDiE=;
 b=hxCDvnt2d5aL8IQVw2Co3tLtbkUKPGpJmPX46kHpm9TLJOKDrnfnl7bXin76+t1+MKNbL8ITGcJgJxRPXRPhzCQcUFLYZaxQICGHNPJ8PLCffSnd7WmE0TaM9W6oPVx1pIyojF8QsGEWNwNqHDSdeC9Ev/1xB5+sPTQ3I6qV/+asGGTO4+APoBv3UhS0UCj86NXIRoT1JCccio261x/VQ1XrmffJtBQw+FLupJlGbIVaXYMXNB+j1gPtJrPOfahG4pNgmQIU46wueqXRJiIYyLeYucgcmX2s8Pf4usueTEX2kcPZNjoKJqffCrO3yfLWdVDSx/Bc6UOrtlREo/896g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xroM0cxctImI19hG/zK5niroHjPEztjQ3bPpWzyXDiE=;
 b=gaM9d6Kjo4kqSIJct8AwyAKyyrl/AMIGZE3G7wFM0dhG5W7kerx15JAVG1cA+FnaWc5yAx9N/Z4/AJ2gzhirKz5kJRFecSjYspJ4vPoVaEdZqfvwZIFTNMFEmSgRZOdSb//muM2bpJk5exfWEqtewdCLJWbweNaJufBLBmUvD6qyvqUUh5bXkpNw+viF3e8Sb5uh6I/uqbMN7fxH38rUnjKuL8r1kMkv01YHByfmv6qpJzihMxKzOw08oLVI3c+hhvFiWWjN5/37IMtUA344VpOQ6+2oJsmwnYOiKKfTm7xYIqBzcPS2a2zmj3gXowLK0HVhAwd3Wxv28G6jrckvGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:15:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 16:15:59 +0000
Message-ID: <c8d10088-1ec3-4f1d-a44f-ae0481dbe6be@siemens.com>
Date: Wed, 29 May 2024 18:15:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers:igc: fail to init phy
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@lists.linux.dev
References: <20240529015742.603110-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240529015742.603110-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5158fa-b865-45a5-1cc1-08dc7ffaa095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzRMTjU4eGhsU1dqVFhXMENTZGR2MWRBNXN5OVVLbk4rcGtBa1BKekdNdFhE?=
 =?utf-8?B?MjNobzZocENRSlpOV3p6WW5VU1N4MnlxcEJGeUVvbHZTb1huL3lnU1Y4ZGZt?=
 =?utf-8?B?UE10VHRDSld1T001M0g5QmdjWkdLTkNUMHdTdDJ6TnFZUkxzY084RnJtTWQy?=
 =?utf-8?B?ZnkwZFAwN0NDd2RDZjF1QW9EODRBR2FselVlajk2MWs4Zm9QZ25nM1VLWHM5?=
 =?utf-8?B?bnZ0S0RORlBnVzBiaHE3NjIzUE4zVGNDWVFzOU1RMjlZK1hxWEhTcjN5Zk11?=
 =?utf-8?B?eUFQOUdiNXhYWWZQem9zYnB4dlZnb29INHZZc1dxbUQ3U1pxdC9ZK01FeHRS?=
 =?utf-8?B?bk92dC8yeWV2NloxeUVsVVpZN2wySUxCNG5aSEhzS09XNk8rOUhXeGpVZUpG?=
 =?utf-8?B?amtWRkhQQ0QzUGFuL1pWK3k4THdYUGNqNzhIVGJsOW5xSmp5WVZuV2RMVnpU?=
 =?utf-8?B?aStEK3B3WDZEN0trbWVvMU1rWk96eUdoUHErNS96cDliWkR6NzEzc1pLUk13?=
 =?utf-8?B?dmEyV0hTSi9BYmc0dU0vZlJwWUtwbmFYWFlNRVdxcXFFVFA4V1c2OG5BRXBX?=
 =?utf-8?B?ZjZTZ3NualA0K3JacmhQTm9HZ1RlWC9iSnRDaXB3MnpUM2FFSXFVY3l3QWs2?=
 =?utf-8?B?Y3lxRWs3enpubUJaS3BrbnIwZ3B5WE44NmFVYThkVWN6ci9qQnBPaEd2UWFk?=
 =?utf-8?B?ZVQwd1BhVTloelNyNTdUbWJtN2ljNkpHcTlaa05kNmV6dTg3dWdvYWJWRGF2?=
 =?utf-8?B?OWZDcUdWS1BjTHd2UUkwVkwvMGhFN0x2KzhEYUsrQmhwdmlZTWxZUTErOWNn?=
 =?utf-8?B?L2t3cUFScCt6ZEFzQjRMTmtEbS81SzNybHp1TjRUWkVIVFdqRFlsYVZieE42?=
 =?utf-8?B?Smo2RVFoT1Bld3FkVlI3T0dhZ3ZYcTczRkYzaElYTVhOdlhndUdGdnZPN3Zu?=
 =?utf-8?B?Y0NxZS96d3J3S2hUZlAzUEgrdUdpS1YyU3NKSWFKQXpxc0FJNlF1VTNkRXRa?=
 =?utf-8?B?ZWdCRDRXYnBOblJGS2FndTczQy8ySHFyRkxiSGhucGJKZFpBMEM1SmVkdkVC?=
 =?utf-8?B?UmdXcm4vT010M1VteUMybnROeXZJNThKNGZqQlNqdkNwWXZMSFhvRm8yOUVn?=
 =?utf-8?B?SE9VYmdPUmM1b1QyUlM3V1A5ZGVjdXNzbTVzQk5WUUFkeDN3SmdUTnpycllS?=
 =?utf-8?B?dW9kSWZJMXFnRnpNWGdLSitTMzN4dTMvUytrQzE5UDJFb3JPRDJGYXNkN05S?=
 =?utf-8?B?ZDNiZXp1Sy96V1NsNjJMbklIZCtFYll3YTg2NHJXd3ZoQUVFMDFZWDAxM0ty?=
 =?utf-8?B?YTYwcnJLQjlTQ0Ria0lnSTlWRXBBcE11ZFdsbnhYUFFQVmNFb05VQ3VEZTBF?=
 =?utf-8?B?dnhtY2pTN0p5SmhvNzA2V2o3OEUwb3crN205WTU4ajVBcTFHKzRGbGJzRXlS?=
 =?utf-8?B?TmFNcnlRWkx3UU1relkrTGsyeWwyczJIUGFQamptMGhxRnBmTDdtSGdYK1Rk?=
 =?utf-8?B?aWNIY3JDQ1ZZQ1hpVXRRQlcyL2hRU0NIbHYyMU5wMGhGV0tCUEtBRGpmWTVl?=
 =?utf-8?B?OXMzRWdPQmptS2ZURzIzR2lkWVpVU1BVZFdERFlPV01IR2ltcjgxL2VGNUhs?=
 =?utf-8?B?cHhodWoweUdPRUpNU0NzNVVOVlNrUUNhNDRBVUFQTjFlZDlXWU5JSjdjeVdT?=
 =?utf-8?B?bU1rWU8wblRnNmtZRTJhRWJQczVIR0syY09PYi83THNQcEZnSGNqa21RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpDdW9MOEI4NkdYd0h1Yjk1K3VPZDRnSkU1YjZXNFJsQUVLaWt0TFZMdTNJ?=
 =?utf-8?B?WmI2Y2pUdWNTUnEvbjdQMDJrRHorU2ZDQnVDSWVKelBPN0RoK3JjeEVJWEVo?=
 =?utf-8?B?Z09vQURTclJzNEtRa1NFQVhzanR5dmFOa2phMWFpeVlUQ0FGSTBHcDlUNmd6?=
 =?utf-8?B?V1pwZ0NuNi9zSHJZeFBGeXhPaXJ0OTVTTzJkZEhQekN0QkFZLzM0eWd0V09m?=
 =?utf-8?B?VnF2dWUrMlhjVDVWUi8vd2JPdVJwQ1lsaklWdnR2bGxZa2o2NWR4TE4vQnM1?=
 =?utf-8?B?VnVsM1BwRVBVaVVpV0dzVUxkR3MzZmlQMWp4MXFwUWRncmpRVDAzcTd0WTl6?=
 =?utf-8?B?WkNUbnFWbVh2RXkzbm4zTDZEWDVHSTlwaGdJalNLYzZrWDVhNU0rQUVjVnlD?=
 =?utf-8?B?UDZybTRYRWVaY0p1K2VqVHppRWxHMWdoTDl6b1k5d1llcFZhdHdKWUR4dWky?=
 =?utf-8?B?SURzTllpamNOS3czeUczTnpFN2J0aDVJQ0xmdXR6OEdXWW1ab1d5WFU5VmVL?=
 =?utf-8?B?U1dzcDJqamVoL002YVJxVmNkRHJEaEVIaVlUMUY1RXNiTEp4Zm13bGRwSTkv?=
 =?utf-8?B?dEx5NjYyOVQ5NS9DaWNNQkI2Y1BsOW8vSlVVTlUwQm5BSHFqaDJXT2ZrMExM?=
 =?utf-8?B?WTJJRjVCMUpPbnpmNUVma2tQNU9NMnpGR0s2bEQzb3BIQVBjQ2I2WmZGd09E?=
 =?utf-8?B?bktnZVhGc04yRmxSNFE4b1UyeTRMSVlXeUd4YjBFUmRHTzN1VnNCMjB2VjND?=
 =?utf-8?B?YTFVR05zbmdOajN5MFQzL0FaZnlRNlA3aFBxaElWZk8xSDRxb2U4L1BQdEEz?=
 =?utf-8?B?SHFoeVZsME1QRncyeUlPeE0vZUp5c3pVS0dCSTFlSkVpY3pCWFBzTmc1anVE?=
 =?utf-8?B?TzI2NVliQlpELzV0K0lML1J4cGhiaDJlMXFGMEhWbGxvNFpVdzNFQVhWN0h6?=
 =?utf-8?B?QmduRlpVYktoR2xMTUN6ZThXTmFXVUlQN2RzSGFJeTF6OVNNRmJQYWwxblFQ?=
 =?utf-8?B?ZzRuYnJ1UDhlRkNBRjVqZEhHWlB2ZGlHbWxlUFRBZXJTVVJsOGlnL0RZRk5q?=
 =?utf-8?B?MjJTMTR4RUF6cUFBblJhdC82bG52UUZmNzRiZU9sTjNONllsMk1uK29vYWNj?=
 =?utf-8?B?T0pWSWdBUk9JSjBOR0V2WnVtWUQ3L2ZzdmdUTW5SVnhEbnZWdEVuekljNjB2?=
 =?utf-8?B?UGtXNklLb29xWTBXWS9pVUlldlUwNjMrMGJwUzFvU0FYV2xLL09tdTdIMy9U?=
 =?utf-8?B?UVZWSEJvSzBTZUgvS1p6eTBZN0VPLzhoU0ZjcHdtWnE1YlJzdU4wRDRsQ3dw?=
 =?utf-8?B?UVBOUWd0ZWRTNC9jWldVaTlGRHhla2h6MGo4WWFycGoyeHpnN3NtUTRZTjRo?=
 =?utf-8?B?TmtuWXFLY1JzZlFzS0hsV2FuQmxiQ3Nqd2lQaXE3UDRYYk5XNEtPWSt4cTJI?=
 =?utf-8?B?S0x4cVJCYThsOVZNMk50M2RYazgzUjVxY0E3L21PZHN4UEd6djZiUlhTR1lj?=
 =?utf-8?B?aGx0Q3NiVjdUQnZ0UytPTENvM1Y4NlNCcktucEg4SEJJRXNFWGVBdkhzeEwx?=
 =?utf-8?B?dmFONEdYZEc5SmhCcVZmRkg5MDJaWFJFSGZXTm81T3hnbjQ2MHNsUUErdmJH?=
 =?utf-8?B?RHg0bUcrK3A2M1FoNlJxTk9YVGEyNmt4eU9SVis5dWRRN1pXbHFZc245VUpF?=
 =?utf-8?B?Wm9wdW9BWWZOMGVPeHlFS3lER1NJbHo0VlMzM3NJRXIxeXY5eCtxaSt6K1JH?=
 =?utf-8?B?MU5FaGRIa3didTh1NnJ2amtHeHdOOFRXK09YaUVwbHFKOEFDOXNrWmRWWjU0?=
 =?utf-8?B?Z0oxdGdWb04vRHVFcHBaN09PODVsR1lPSkt0dW1paEVySmNhYm1vYnovUW0r?=
 =?utf-8?B?cW9yYW4yanJKd3lJdGZjN3hldXBPZyt3Q2JUdnoyMERtaEtSVkp2czIxU3Iw?=
 =?utf-8?B?NG5TZ1owdFpLUUZHSVdySWZybUlVL2paMEtsOWZ2R1lYbXhoeFRTTEJ6Z3lN?=
 =?utf-8?B?eWJNQjhaS3ZWcU91ZFpnOWtSdDBqMUtLYnhhcS84UmtYUTIxQzBIa3NjRC9z?=
 =?utf-8?B?RzJCelQ4Nlp5enN6ZGFSMFdHSVlzVWdEbmRyTGYyTWhuQzR0SUJUMTErK0JU?=
 =?utf-8?Q?R9mrY1hfj1DCU3wtMXWVv09wp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5158fa-b865-45a5-1cc1-08dc7ffaa095
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:15:59.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFPt4b+rccVZZU8KuVfqPGnwLpp42VAyVw/UXet3Qr9lKJIO8phWsq2CA9SL6tFvWx4QQ2K6mJMseXFbyoW83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6654

On 29.05.24 03:57, Hongzhan Chen wrote:
> merge commit 170110adbecc1c603baa57246c15d38ef1faa0fa:
> Author: Sasha Neftin <sasha.neftin@intel.com>
> igc: Remove _I_PHY_ID checking
> i225 devices have only one PHY vendor. There is no point checking
> I_PHY_ID during the link establishment and auto-negotiation process.
> This patch comes to clean up these pointless checkings.
> 
> and commit fc7116a79a86500e15520658f279b6536ff9f700:
> Author: Sasha Neftin <sasha.neftin@intel.com>
> igc: Fix BUG: scheduling while atomic
> Replace usleep_range() method with udelay() method to allow atomic contexts
> in low-level MDIO access functions
> 
> and commit c9cfcdd111d7f82831ec9f205f4370427739b9d5
> Author: Corinna Vinschen <vinschen@redhat.com>
> igc: igc_read_phy_reg_gpy: drop premature return
> igc_read_phy_reg_gpy checks the return value from igc_read_phy_reg_mdic
> and if it's not 0, returns immediately. By doing this, it leaves the HW
> semaphore in the acquired state.
> 
> and commit d4706de93cf7c766df288501b141bcb9fd9b3ee4
> Author: Corinna Vinschen <vinschen@redhat.com>
> igc: igc_write_phy_reg_gpy: drop premature return
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/drivers/net/drivers/igc/igc_base.c b/kernel/drivers/net/drivers/igc/igc_base.c
> index fd37d2c20..7f3523f0d 100644
> --- a/kernel/drivers/net/drivers/igc/igc_base.c
> +++ b/kernel/drivers/net/drivers/igc/igc_base.c
> @@ -187,15 +187,7 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
>  
>  	igc_check_for_copper_link(hw);
>  
> -	/* Verify phy id and set remaining function pointers */
> -	switch (phy->id) {
> -	case I225_I_PHY_ID:
> -		phy->type	= igc_phy_i225;
> -		break;
> -	default:
> -		ret_val = -IGC_ERR_PHY;
> -		goto out;
> -	}
> +	phy->type = igc_phy_i225;
>  
>  out:
>  	return ret_val;
> diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
> index fcd08335f..60c59d991 100644
> --- a/kernel/drivers/net/drivers/igc/igc_main.c
> +++ b/kernel/drivers/net/drivers/igc/igc_main.c
> @@ -2880,8 +2880,7 @@ bool igc_has_link(struct igc_adapter *adapter)
>  		break;
>  	}
>  
> -	if (hw->mac.type == igc_i225 &&
> -	    hw->phy.id == I225_I_PHY_ID) {
> +	if (hw->mac.type == igc_i225) {
>  		if (!rtnetif_carrier_ok(adapter->netdev)) {
>  			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
>  		} else if (!(adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)) {
> diff --git a/kernel/drivers/net/drivers/igc/igc_phy.c b/kernel/drivers/net/drivers/igc/igc_phy.c
> index 8e1799508..3a103406e 100644
> --- a/kernel/drivers/net/drivers/igc/igc_phy.c
> +++ b/kernel/drivers/net/drivers/igc/igc_phy.c
> @@ -249,8 +249,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
>  			return ret_val;
>  	}
>  
> -	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
> -	    hw->phy.id == I225_I_PHY_ID) {
> +	if (phy->autoneg_mask & ADVERTISE_2500_FULL) {
>  		/* Read the MULTI GBT AN Control Register - reg 7.32 */
>  		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
>  					    MMD_DEVADDR_SHIFT) |
> @@ -390,8 +389,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
>  		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
>  					     mii_1000t_ctrl_reg);
>  
> -	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
> -	    hw->phy.id == I225_I_PHY_ID)
> +	if (phy->autoneg_mask & ADVERTISE_2500_FULL)
>  		ret_val = phy->ops.write_reg(hw,
>  					     (STANDARD_AN_REG_MASK <<
>  					     MMD_DEVADDR_SHIFT) |
> @@ -583,7 +581,7 @@ static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
>  	 * the lower time out
>  	 */
>  	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
> -		usleep_range(500, 1000);
> +		udelay(50);
>  		mdic = rd32(IGC_MDIC);
>  		if (mdic & IGC_MDIC_READY)
>  			break;
> @@ -640,7 +638,7 @@ static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
>  	 * the lower time out
>  	 */
>  	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
> -		usleep_range(500, 1000);
> +		udelay(50);
>  		mdic = rd32(IGC_MDIC);
>  		if (mdic & IGC_MDIC_READY)
>  			break;
> @@ -748,8 +746,6 @@ s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
>  		if (ret_val)
>  			return ret_val;
>  		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
> -		if (ret_val)
> -			return ret_val;
>  		hw->phy.ops.release(hw);
>  	} else {
>  		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
> @@ -781,8 +777,6 @@ s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
>  		if (ret_val)
>  			return ret_val;
>  		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
> -		if (ret_val)
> -			return ret_val;
>  		hw->phy.ops.release(hw);
>  	} else {
>  		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


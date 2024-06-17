Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA916A942
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642841; cv=fail; b=gFVlqCwahRbFWEQpUtY3SE4YQxkHKI2EafmGywYVVy+S7BCnl1w3Bz7UB2YQlqNwaWilw60WYQYh+Q1yYNqqM05UjxCfXCrLBGyF78hWaVvCMgcttlBRyrxhDNdTrWhJ8rTC4rMq7xgSfyNHYWxYW9+r8U56NHmVa3wM54jfCMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642841; c=relaxed/simple;
	bh=OEjTOetVIUC9HLb5DmdegSLzDsaJg9J8WAlDNLvVVds=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cC16l6iM56aAqcGGKxMNvrBIUzeU5/9pJ1g1KI2faPzIzb4+Snm0CMo9kffmxAvKrLNGuncuFKeWGeKENqwoXL5hDkM8uo09+WG8RzIxtTo39WnhkEWBPweI8rm3UU/7x7uJRHwRaG75v7Eew4ywJn4sBBg4emXt9qFZUduZoRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AbH1XQlx; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AbH1XQlx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+dDELCKVGiz7vznzglrszq35Ethe1eXL8UNeAXomC+uBteEjrB28H9Ws6XdkGm0vI1dpWhaU0tVHrSFaSvBrrwVrUGcOMFhobPUzeVNdg3MyAOcHoBf6CLsaOyABl0t2uPdYiGl7t9OeNLPea8yzdf5LOj0xr7WFLASg45rtWosYr+nP1q0ZO+eocgPQXIrZcAPmqXL5FC3Yw1FWQgCy5WpQja9QMCmmy75BVGasuwQ4T8ZQPSEGp3IwrYayX6VT9roVZpWVCgyrHZ4sU/dNVvRG6nerrzyKWk/5uad1ayTsvGMe03aS1KdSoYXE1rqPtvKCTZdR6DZeaC/p2H0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWvmE0JRU13WxWmLsh6jo9fJgywPs3VmwV1ok32Ahf0=;
 b=g+MJHvW7qp8PSO9eVYjiiaLkRNpZzWiBdjPozsSIUyGrQc+6wqD/IZdMG7kYtW2fzpXfK7Ubtr6e8hd7RrGe8dhv6A/oDF+8iFUYTKCml/CNnmcBx2pQ9Zov0q/+EOywqe+q7tat4u20K/++/ucAa3j0pcoAVOeu/tr6BPM9tSxNyuo6EGJ+n9eg4PzjjSBNDdfiweQpNTKrzrAmcqeSPCba/BMQ2X4BZ80ds105kk4heU3h6zptrMTM8ZZSGwjGZg8MSle/1ia5U88leviCUSzlFz1iY2uqwvOXKCI09zI3XbZ+2dNFG8OPCMnWWOoOiAFTxghOLRSdIhpB5oaEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWvmE0JRU13WxWmLsh6jo9fJgywPs3VmwV1ok32Ahf0=;
 b=AbH1XQlxCXF+jVOjfGZrvEMSltHCcZXZ3pU8ww/Zt+ToT8eGLZ0aBAydg5CJplOLmGoTgkjhIdco0pUTKBzgsiBvqTxCB3Hx605sz2iYlvtcg0hBGPkXz7PicMLCHATre9gMxBFIm10f1wMU2CKkQ4Iodf8LCPItD47Us3xE7R8BzIidNKXUXHRJgUVxnwdTUbrq9hQrOFruaNhxO1Pc1iI7sWYab/coziZmCTCFLE9o9i+Tdawz6Fnp401KwFyQHb49hR5SVKh9Ozz0AYivvkvJB7b1OewCSCjRZ8BBYKq++vkv5btMJ6f3CiEIxmhxssHUi933N85dP+xuLFKtug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:47:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:47:14 +0000
Message-ID: <ab5621f9-de3e-4d49-98b9-0440f35bc006@siemens.com>
Date: Mon, 17 Jun 2024 18:47:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rpi4: fix arm64_defconfig CONFIG_BCMGENET
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
References: <20240617152859.32359-1-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240617152859.32359-1-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c292621-e125-4c21-9072-08dc8eed2456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cExBeWh3ZFhOQnc3Ykl1eWE0RVZBcXpkTHdmQVRzYTNEWnVsV2VyQTVkUEsw?=
 =?utf-8?B?bmNiUkVpcHNkU1NDZUFQSkUvTjROR1FmaHpMVEhoSG1SemZmSDZjMFk5bndp?=
 =?utf-8?B?Vm9wcmw5alNzVDNyeE5rdG5kTS9KY2tYT09nWU0xbWpJdlc5cFRkTlo2c0l1?=
 =?utf-8?B?aUxNZWxFV1gvWUNLN0VKK01sUm84ZDlGSlVoY0ZKTTd2NUF2eVU3bnlBUnA2?=
 =?utf-8?B?cy9WUUxMSnNjWGdGWVRHTEpkUk1xK3FxejNhVUUxL3ltVVRGc0VCcjl5MHoy?=
 =?utf-8?B?NzdpY2xENzFnWHlMRXFPVlZseldjQzdzVXU2Y0sxZGlobjNUbVVTYnA4VWE2?=
 =?utf-8?B?ZTl1eWlGS1RZVjE5NXk5SnBOdkQwUG00L3FYbGltem1rNitFdnN2OVE3ZG9t?=
 =?utf-8?B?V1NLd2FTSGgzZ21BRERDVjhIdnpnV09namo5U01LQktadlVISThrNExCZEdH?=
 =?utf-8?B?OGZGcHF2eG9vcElsOHBqeGtqZjFZZlZ1WWpFOTZFQmJSbVlwSXFrYi9SY2hh?=
 =?utf-8?B?eWswM0NMNmFpS3EralM5RHJXaXRRdjVRUGhCQmlKWWVqTlFCOU5RMURpMmhu?=
 =?utf-8?B?LzBxWG9SWGhTcy9xMndXWngzWHFua2pyRXRRUUdiSVo2cElmYzJzVVVQaHAw?=
 =?utf-8?B?eWVHMzRwWXU1NEVBelF1S0hGV0JVRmt1ZTU3UFIwNVNOeG9zQW1YQmhaYkhW?=
 =?utf-8?B?OG9FZHJvOFVnOXh4cDJBM1kycTVtOUdhaDVoUFZqQitiSm1XVmR4M3ZHWXp0?=
 =?utf-8?B?WkJQVHJxZEVLazdlZFFMZTZnVWQvOTY2NGNHK2hpRkE4NDlQK3l1N25XNFNt?=
 =?utf-8?B?R0RmSHNhMWpRYWR1dnh2RFZWb25ja2FEZlFqSlFLSnhFR3pSQ3RDamZMVG10?=
 =?utf-8?B?L3hTbDIwSzJBdExSQ1dFRDB4d0hZMEhYTEJFNWxoVktCdHg0bkVLdFFqbGND?=
 =?utf-8?B?THI5Q2pvQmpaYmVrRTZsQmJkUUZtd01lWStsTEt0emhBY2VzYXI2NFp5WklW?=
 =?utf-8?B?Y1NET1lNYlJJenVxTnNabW9GcXBOcXp5Ris5SUY2aDN1K0dMOWNpQmFyd1Ir?=
 =?utf-8?B?MmEzVmpnM0hQWHp1MURuZDVJaWcwcWt3aHM5VWFFT09HYzJZSElqT1ZWeWdp?=
 =?utf-8?B?VGd0TEVRV0JJNEcrNzJwaHpRckJhMkVFTlNIOEdPNTdxalkyTGc2K2JSYjl3?=
 =?utf-8?B?eDdmUm1GMFVHZGY2Q09VNmVNMTRscjYzM3RmVUFoTjQ2Vk1qa25KTWdhdk8v?=
 =?utf-8?B?TnlGMnVSY0pEVlFieUFadFhYSjVKQ3UxNjJzOEFPemFsejYxMVB1U0NZQXpo?=
 =?utf-8?B?N1dXR0plRk5FNkhnTUt5M210cTVmQks1YnhaK1UvOWd4S0JaMFpIcUh5TlRR?=
 =?utf-8?B?aUQyM2FrR25RSWk1S0JHV2w2c0l3NlRSTnR0K1dDZEM5K0JNcEd3UVA3MkZx?=
 =?utf-8?B?STNpazY4TG1EVkt3allCQmUvdUhGRFRXdjVFQlJ3VTZnSDJhNGtNcDliVStx?=
 =?utf-8?B?c1hycFZTSWdlaU9vcUwzU1JJVjB3SnZwVmNicFlrNFJTV1l0d1lxeW53Rm0w?=
 =?utf-8?B?bkk2S2ZBWDlqcXM0K1BtQVNZMU0xV1hyWEd1UURvdmZGcFhGeDY1VzFxTjNP?=
 =?utf-8?B?dWMvR3hPeU8zQjVpKzZZeG1UNitVR0xHdFIvR0Frajg0U0VJS3o1bWxaWnNH?=
 =?utf-8?B?OXJnMXJEZVZuL2RwR0ZKNEZzSk5FVDZpckRJNjNzU0ZMN2lGbW9KM21lNTNM?=
 =?utf-8?Q?0RnaOZtqncZQYm4BuU/T4hlMaP3WO68ZPF46pME?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1orTVJ3dVF3ZmpCU05IQ1lBcmZJeHp0MlRpR0dZSmE4YWlYaDJjcnQxTlBl?=
 =?utf-8?B?VDA3SktMZTZlYUp5cjVWRzJjaFJ1ME94RWpjUlZ0ZjBjSDRKOUFRUXRpMG5B?=
 =?utf-8?B?OVc1VXpKbjhVSzkxMldXektxQ29qMXVuYmRMdnFVMmlzbFdKdzlWcnVRVEEr?=
 =?utf-8?B?eFJxVVNoUysrREpEMlRMSEJaL3VVN2xYWlA4UjhkMjRRdkI1SWVTNDdoOGRO?=
 =?utf-8?B?UDZ6N2w1Z01Vd0lTd0U5V0FmYlZsQUhYcHBuc3d2WHZQbVRhU2dGQmhidDJS?=
 =?utf-8?B?NTBFMDh1OXZRUUtXd0R0b0duVWcwMVJMUEJaQVd1Rm9nRitLd29aZm9tSEFE?=
 =?utf-8?B?MFE2RFBjVG16N0J6Y05Gbmg1aXFBRmdqYlkyQTBTa2JsSXFMZ2NxRGIxZ2dD?=
 =?utf-8?B?eFNEcTRadVN5aGtiRDVyRC80U2hJa1lhaEllRzh6aVJNSVJxL3h3VmtXbzdO?=
 =?utf-8?B?UjJaUmYyK3Zhd3h0UkRQS29GVmhMV2pRdUtXbkZiWE96TWdLbWxsSi84MHZR?=
 =?utf-8?B?RjY1RktGZmE2dGN1TFl1RFZKZzMrRlFpdHB5L2xKZ2h2OEdCNlBDUmJUWmZT?=
 =?utf-8?B?alkwWU9OR3V3SlgxRGFrRndTMjBTTjMvOGRPUTFCNitib25qR3RYa1FuREQ1?=
 =?utf-8?B?ZXd1TTF6cE5Bb3h0Y1pVRjNHUUVWRzZyTzJRSitZZDBrWnd1elpoN2Q5OGg3?=
 =?utf-8?B?U29SUFByZlFhNHo0UTRWeEhvYjE3KzAwNFF4ME5uRXJSTGhSVkZrNk5DVytm?=
 =?utf-8?B?RFlTU3U0UkFvbHl4L2hRSU1hZnlXaTBuRENBTzFtMytESms5S1RTY0VGQVB2?=
 =?utf-8?B?aXIvbXBHVU1qUjFUbFJNcEo2UWdrM1I3MkViMDFoZmdXbnhsMURSSjBTZGc1?=
 =?utf-8?B?TG52SlMwS0VXRmdGM0xXQzRYYXZPZmlKWTQ3NUF6cm52S3hiMHp1dm9xSnZH?=
 =?utf-8?B?c3o0bi81Nzd1RWc5aWFaQ0NqQ0g2Q2k0N3JvUFpGbmxBMk1aVzFhdWtia2pm?=
 =?utf-8?B?a0lHdWlQVHgzeE82MjlTdGpWRE1WNHB4dXBiTjJUalEwQUQ3ZFRzclQ3MjRG?=
 =?utf-8?B?RitDSVBJdWpVWGJhSG9nZ0dUaXBldmJpZlFkR2lKNmFybjl3ek9yYjRWV2lH?=
 =?utf-8?B?YUkybTFPaWpQVU52am1qT1MwVWtrczFRSTZXWUd6UlZGZVh6bzNqUkQ1VTdB?=
 =?utf-8?B?eG1IZ1pXTk1OR0R4NUdkTHRUUG1FNS9sS0xkaFMrb1krMTJFajdXL2U2OHFY?=
 =?utf-8?B?cldxenFQb2dPNFBHSGNzZVA2WXVKZGhRQTJBRDU1cmhXMkZ6a1FXTis4TlU1?=
 =?utf-8?B?MWV2c0c5M1BFWEg4V1hEc3NRV0JJUnBVTVVjRlIzV3Y1NXVKS0hSUzVrVEg5?=
 =?utf-8?B?SWVJV1RLM1g3QjRnQ09HdUVLUkl0WTJycWowbkFpNHZMVzBCYXJWYVE4Y0JX?=
 =?utf-8?B?anR2QW0wSHgzQmpaTUdoRDhkR0NjdFhNZHVrNldrRHF4Z1NTOTNWdmsycHlM?=
 =?utf-8?B?dHRRRUdUSDMvQmlERlNxeHE0RnBuaUFBK0VpY1IyQU9WUEVuSElzbzR4SDRq?=
 =?utf-8?B?elVuU3FySEtQM0IrS2FNRHE5bWtjMTBJczYxSVYwQ1VWejhQVm1pV2FWSXZ2?=
 =?utf-8?B?QmlSWjdGZTNYVzdFTlJ4Qnp1MTlQK1VUN3NnUzF3MzVpSGFLZVhnNEdSblZH?=
 =?utf-8?B?YkRKYjl1ZVhKbXcvMU1mRGtLSkwrNFMxcEF3K3dmUEI0T2FoODEzeVk1eSto?=
 =?utf-8?B?N2VxOTkwaUMzeEJMcFNUamtMbVltR3FoWXIrSlZQVmRzRytSM3ZucnVGQy9W?=
 =?utf-8?B?dENnWVhoWW0zZ2JSSnN1V1c4OWk2OWVpYzhlaDNVZXZJZkpKTVZ6ZEIrR0FJ?=
 =?utf-8?B?b0dJNXR6VUY1enN1aHl2T05DNlpLMVhRb2ozRzVCdXBpbmYvVVhjK1ByVFBD?=
 =?utf-8?B?R1lzUVhqVWFVTmtHWURSU0pkdjdkVUtjM2ZaVUNMcmFLLy8yRC9mdG4rSUFx?=
 =?utf-8?B?MGNTMG53YTcrVGk5YUJHanlFU1ZRT29ESC9JZnpUNnFjbnZEUXllc0Q0OUc2?=
 =?utf-8?B?bmhNdy9Ybk1TSlFwOUJpaWorUFlEa2l4NVA3ZVV4MzkzVkkwc2RHaVVvNUNm?=
 =?utf-8?B?OXovV2R4UDEwNWdiUGZ2TDZSSFgvbFdGT21lYTNMYjdWUzQvdmpUVnVTanAv?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c292621-e125-4c21-9072-08dc8eed2456
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:47:14.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gitm4m4anz7HmNuQOZOur/olhPzmqkjAurZKbW78BSggjXjsOJ1XlFazcOsN7yW1AB/hBIll0g7Ya2pBbEJ1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6882

On 17.06.24 17:28, Yi Jiang wrote:
> Remove the typo "space" before CONFIG_BCMGENET, so that TFTP booting can be supported.
> 
> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> ---
>  recipes-kernel/linux/files/arm64_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
> index 94f7b5b..1dc8b69 100644
> --- a/recipes-kernel/linux/files/arm64_defconfig
> +++ b/recipes-kernel/linux/files/arm64_defconfig
> @@ -1951,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
>  # CONFIG_MACB_PCI is not set
>  CONFIG_NET_VENDOR_BROADCOM=y
>  # CONFIG_B44 is not set
> - CONFIG_BCMGENET=y
> +CONFIG_BCMGENET=y
>  # CONFIG_BNX2 is not set
>  # CONFIG_CNIC is not set
>  # CONFIG_TIGON3 is not set

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


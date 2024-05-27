Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEC13BAC7
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807989; cv=fail; b=WH1ctmgkDSlZapIB4B6x1PhwDvVD03AuSYm5dwUjeNsmDjR4+R/GLAKSUcdlUGBVZOph1tJGWqQ3yPR9KE7W3o9/3FjSA9oEjbqVpvARbzpBbbhUbsgBJqrX7cj3A3K1LX7E0STcLXFm9Kr/hUB269qHFwmt/GXLV8N9VMnZpkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807989; c=relaxed/simple;
	bh=1PZ5LyVoXnQVH8XWovu3lFKl8bGonApSS1EKU2cZK/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0QjTK2tco6m/goHelEoUwp7QbSI+kEz382UNkw47pmbjvpm1G3h35b1qX91r5ZvNT76SSDNM2D4wgk5Nk7IR5JFVq2aidORvTvnoePfexKxxcKg2nYZ3Sw/UDHV3Pnf0NLDfWNjzZEoXr0rvOlqT9hwl0mTxms282yURSMDww4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ssGkv0Ys; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ssGkv0Ys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJEVv+GBebZfM3UYbhxcHy9gnbc9ncZtWRajRDRZXi+0vA8895miSGFdKAbY+pbkd9FUhuSq2nFNwkbJpdriQaMccT1g0AjjEwYa3yzqbwjZ4Y+G/WxSGzaXHUfYVX/nFso+QLjGa4h2Q2JGxVeMYHCh97d5zXp+EhJdNuaAXuXodYisSaeqQqe7XrANbnkx+v0MgDr5sgo7pQjvAd1egBwsG8iLMwwtqYucCHQw5H6FeRSVhopxRu70RMCPZrhwU3+Ww/l+nWB4+3RI9g9QB8xlaFmipiMUk87grj+aI4lYBxwvFLcpeIWihjWBHbdyvYtLUSdjU9LlrQdOPGKB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ9RHX3WGV3dWS61uoXgL1tVlI7hN4JmM5Ebhassup0=;
 b=QUIVaEFoVQF6fCeZZ9yvfSyR/JPO0Fpguv3N5GwK8MCahO/M00M8Gl3dwqll8daRKh9jZZXkcqqmURux2nqJ6ZnxC85QHi4SiDB1oT5USmjiCMBC5A7zxfIgxQHQqU8+U2FUuHnWhB5Zfe/hktKTkwKMGCA8e9VnRjjdbb1UA15de+pR1dUQCEE9deAA39Ks3agR7FBgvXrcBl0wbcoG+QHOG7vzHPe7tXGqlwgnmuG04y2I9kFzRsfnTGdQfCRuHXClDGLBvtRWuF/Uh/gJIRRh/fWNWq7aOLZFAp5gGdFJnlKwh0WCdpS3+ex/jNVFsQc+9+pAdm69IPqXohn7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ9RHX3WGV3dWS61uoXgL1tVlI7hN4JmM5Ebhassup0=;
 b=ssGkv0Ysy6vOFBX87tUlpjroYBaY+YYe+06m9W6jNSsfwr9UUYkXLW/x1QIStV+44GkGJelYAAwu1rPdM0Phu0vPu7iP7GHIis6GDNHjTKEYfpLA4HXFVXTYN1rtha3I2t/1cXZ7TeyTEZG4XzHx1zCGTl9eRsr0JHYDKoD0FbOnzYJC0DXmGHu8j405CSl/Z1j6hKVOuKG1b42zMNRstwSmGnaT+jUb0abyulN2EsiZtvNoKmA5k8Zdeel6U3RyNQLFOvxa25pffUjbdignE8hq9BGhpkTndwxrAOsYh2KHY46zjN+bKrchxXaE5JtkzL0MZQWfjcZs2O7U/zLB7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 11:06:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:06:19 +0000
Message-ID: <952c24c5-1467-4b3b-9cca-0a05e3a9e11e@siemens.com>
Date: Mon, 27 May 2024 13:06:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] prepare-kernel.sh: Remove kernel version check
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-17-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240525115806.12101-17-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 323f24a0-449b-4964-5183-08dc7e3d0927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHFTODJCU3pxNktCQkxZbEl6VkhxdTJmZUpiVkdIRDJZOFhmV2N3TFBaSjhq?=
 =?utf-8?B?eDNrYmN0Y1BJMDc1bWYxQ1gydGFmLzRBbWxYZzZRSGFja3B0VmFiVEMrTys5?=
 =?utf-8?B?eTRoMXVnczM5ZUwyWjRIUndqOXRhb01CZkluQUtJTTM1N2RoaEtYTzV5T3lZ?=
 =?utf-8?B?SFVCOEdmWUtiUUUvbUhyUWlmK0RZZmlyYXA1K2lWNDdRWmg2QTU4MkpsZ2M3?=
 =?utf-8?B?MzVxWWlVZmpSTDk0ZHhBOTJvemIrY0V6c1d0NG5CT0VBdGtnb3oxeWFsL3Fo?=
 =?utf-8?B?V1EyQnlaNTE3S29hMzMxd2JvejVKTytOaktQS2c3NnVVVGNVQjFPWGRLcVN2?=
 =?utf-8?B?eThsbEhyTGF5Tk53MG9TalZJRlpDQ1QvY1VnYjZHeUV0UlU3UlNCU0ZqVG0y?=
 =?utf-8?B?M2xwTStvOEdsb0MzRVBCYlhWQWNON1QzK0p1VEF5M213TzlDMHR5R2VZSWc4?=
 =?utf-8?B?dm83Q3JERlVYWEpMVS9qUGhOZVUzOWtUN0NxQ21CZkJyM2R6d1ovUzgxYmNJ?=
 =?utf-8?B?WUszV0cxMTczSWJTL1A4U0M2NnVJNFQ2bTN2SFRZVmNySTJyK3lVallXZjh3?=
 =?utf-8?B?aDc4NFpkMEtoci9GR3hObTArR2RNMDg4ODhSemQ0UXJVMURlck9FdkxPVHZR?=
 =?utf-8?B?VXZwQm5ObUdzK3BOQWk1SDZKc2YyQ25pMVFPN0lKT2Zzc2FqblVWNFQ1YUNU?=
 =?utf-8?B?b3pMQ1RQcjNMNzFVSHRRaUxwSUJ2cWp6RVVzVnBDVnNxYTRTQUZub2JYZlQ3?=
 =?utf-8?B?MFZ2b2lrck1YNjlWaUhYbmozZU96ZDN6VlhZY2M2NFA1UGd1MVBlamxORmh2?=
 =?utf-8?B?KzExcUtET3p2Vzh6VVBGYkQ0ZDJrdmJxenZuL3dYTGRCOXp5Z1gyNmd3OXFu?=
 =?utf-8?B?aVF6eUpMdWJQeFhYY3RlWVN6aWxFWjJ1TjMzU1dQd3dDRzUzSHFkbWxCOUYx?=
 =?utf-8?B?b1hkMmdXVUE5cG9tMUxwa3ppa2RySjJxVmlFa0d6RFREamJEYXh3S0NmOXQx?=
 =?utf-8?B?bk9mNDBrYzJENWVZdlAzMk8zbEgySEIwTGcwSFpIMW9nOWFoVmliU3dvVlN1?=
 =?utf-8?B?bXRJWklYTTEwbzlKODVRWWs2OXIrZDNtRC94dGxpQmhodkhIeWtRaElzSDZE?=
 =?utf-8?B?MEVOeFErRFNlbnFtVlkreFpZUzNGNGtKZW11RjVUUUpmd202ODY0aWFmZlYx?=
 =?utf-8?B?ck5PSVFjb0lnd01SMm9MdU5VaEpFK1hWdzQ1UHBtUnEvNnllNXRXR2loN0Rv?=
 =?utf-8?B?VXlvWTF4NkIzYks5K0xzQWhrZjNRM3lSN0NSTzJhK01NS1MvejZneEVxajhQ?=
 =?utf-8?B?aDArTG00VlFhamFTS1BkQURjR1FGcHN6YlR6VmNQRkJnVkpiNHdWMmtJbnIy?=
 =?utf-8?B?eVB2OE9Ock84Wll3MU9TSjJZTXVUalJUb3FjcTV4ZWtWbFdDSWJOQkM5b3ZJ?=
 =?utf-8?B?QnZBZ3lVTXM0NnFFVFRweHBzdHZkZTZxTFduRUJZaExwdi9LMVJCQjdtWUtI?=
 =?utf-8?B?TEoySkxsd0NRSElLWGQvWTBEVkhreHdLeTlYSUFlSjBOUngyeU42WmJwb0Fw?=
 =?utf-8?B?RWhJVUcySGxyenBYeFYyWTNhbzlDSy82OUZFck5aV2I5SDRMcHFCQjJ5ckIy?=
 =?utf-8?B?VS9SVXlWcE0zdUhKSWZnaGo0d0ZpOTVxNW1Xcnc5WSsvNmtnRHUvZ2hldFJ2?=
 =?utf-8?B?ZXc1MjJLMi9wcm1WYTZLK2dJU2k0ZjVHYVM3N2dINlJWRGxnVEtXdWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkhaZlpJOStzZEtubExWaXdRMG9ZemxVYVR1dEEvVVErV0NRS1ljSVZxS2xO?=
 =?utf-8?B?RS9Nem4vZmR2WFlvMnBVV2ZsNkJ2SjlrenorMWQzTHNObWYxb2h0NDN6Q0NY?=
 =?utf-8?B?VlVxb0RJUkMzREtNUzMzMHZ4MXA4V2pxOUQ4ODdBYi9XQzVMcWFrM0JQcHhZ?=
 =?utf-8?B?VlhxQm1xUHNlQVFSeWpQREM5OGUrYlh1QkxYMm80ay9JSDlYVDJ4L0JpQVNZ?=
 =?utf-8?B?QXNZS0VFZnM0UEx6SElLZWFLRldnNHRWS2ZiUFNFSnRIcVNZckd0S1FWWENR?=
 =?utf-8?B?ZFJGaUtjbEl1amprek9lblBKdmtrTDBVTVVYY3YvZFJFVHNuTHB4aTUwT1FG?=
 =?utf-8?B?Z2ZDbTh0NkZGY3Y2a1JiZVVZTEVkWnZaQU1ySFN0Wnd1YXducWRwU3gvNER0?=
 =?utf-8?B?MHVyMTl0RTZGOGdUNUdqUmxpdURQTkV0SHFVaEZZZGRCcFd5NVJoUS9KbEJZ?=
 =?utf-8?B?TlIzVHRqZ2ozZ0NvckJzdTdOekJmSW54a0kxY1l6dUhUUTk4R2hTVzFBczhW?=
 =?utf-8?B?Y0tZQnUrRThpZmo3YmpvR3JGaVFKNXlXTko5N1c3OWNiYTlmZEtsS0Vzai9O?=
 =?utf-8?B?OUxPdVppK1RFZ3M5Y2lsUWErTkNweEFPTXAzalY5UkI0NFVFZXViblpVb0N4?=
 =?utf-8?B?Q0JvVnpMWHdoelhwdTlpcDNDT2tEOEJ2eVhyQnFjSkxRamRveFRSR1ZOQ1pl?=
 =?utf-8?B?TnZLNmVIRDJSdkNjby9SQ25iOWllYnIvSS92Rm4rQnhWZ1I4enN3aEhqSzRn?=
 =?utf-8?B?bE56bWszQlB4VU5UbDd6UFFsV3B1NUhLanEwRGt4NW1ZNm4yTHZHV2p1SVc3?=
 =?utf-8?B?N05oMHE2QTU1VWRYQ3VycTBuQ3V0Y0dFcTdLNS9NRkNDRjJLT0cwbnFOK0Rm?=
 =?utf-8?B?a3NnVmNZcTRObUVRaERxK08vcVZHSnlHWEtzanY4T21JamVURXNHaUplbFpV?=
 =?utf-8?B?V2VJTUxEM0ZMUGNNTTlpVWtPdjV6MHB5eWtyRjFKOGRvTmhjRWxpYXhjOFY4?=
 =?utf-8?B?S1FOT01ISlg5Si9XSlpKS1dGd2svWG1hZGxkSWk2VE1TdFFoOVN5bWxhbVln?=
 =?utf-8?B?KytPMmpNTHNFclpiancwTEoxT2lxYzRlYUZPbzhaM0tIOXYySTR2YVdMWXdL?=
 =?utf-8?B?MXhGclMxaFZKM0xhYzdiTUQrNm1yZU5JbENEZjdKeGtNK1dVcGdyTmNESXUy?=
 =?utf-8?B?ODBrK1JSdUFBVEwraWZldWxaUDdlZTJ1M01uTXBSbUNKRzFtOVppdGJvSzcx?=
 =?utf-8?B?azFUTG1xblVFcGZyM3BjVkVKeUYwYlE2eGNaVGhFaHJKU1YyMUZ2cVpYYzVm?=
 =?utf-8?B?MlRtdmp3ZjBQWWwzZU84cXZNMnlkTGtRQVdjaW9WaDZXUkhaUlI0ajNtZy9Y?=
 =?utf-8?B?aW4vSjBteGhUZXJEb1M5RjFLMWpkWkgwMVdGeUFmTXRZMEFaYWU4UlBzaFEw?=
 =?utf-8?B?YVZWRnBLTGtiN0dGRDZkenlSRVVVTnZuVkdaOFlocC9JVEVGWDc0alNoMmN6?=
 =?utf-8?B?V3NGN0ZjSFJHdjg2SFowampWMjJUQlBUYTliMDZPQUYwN25Md0VOZ2d0SjVW?=
 =?utf-8?B?SHFMOHp1WklQTVhYdEozTkZRNFM0bkxlQ3dCeTd5UHRTWkFCSWl2cEhHU0tl?=
 =?utf-8?B?Z0tWdllCbkJHVGRTdkZkN0ZiY1pXdlRaMnlhU2cyS0tFWnR3WWxqQXlCWWgy?=
 =?utf-8?B?SXQ3djZXazE3OEtxZ0p1OVdHYmxNc1p5dlVGTEY4MzRxUnBXQ0VvOUZwSWFX?=
 =?utf-8?B?VWNCVnpCTlZleGdmTWRNam45UjZsT3cwd1RTN1lvOXQ5SHluV3BLTXFMQ2w1?=
 =?utf-8?B?U0N3SmtBVWdMbC8rQVVvekxlcnpCVGY1ZHJIOXR0V0Q1b09IVmZrcnBiUTU0?=
 =?utf-8?B?QzNVcDFqU2tpWVE3aDJWUWxnRzFSLzluVmRLTmlmSWlBUFpNZGZTU0h4anFC?=
 =?utf-8?B?MG5XdEdRNXprRWxvdVZ1aGlpMVd1V1RPYTdXY1c3U1o1OStaWjhYYlZvbFNa?=
 =?utf-8?B?azJXN0FWRVBwcUxsWjB5Q3MyaXYxb0pjQ0VEVXloMjhSUjVvaVNERXNFZVI2?=
 =?utf-8?B?a1ZmUWd1RU9zQUt4RXRybVdOUm8vOHJqdEpYL0xhMXRjTHlid3NLYUwycHZa?=
 =?utf-8?B?cnVHRkg3NGcrUDBzNXpxQkxVaTNKbVhGVVVvMWtIZUZ2bE1MVmtJeGpBNEdX?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f24a0-449b-4964-5183-08dc7e3d0927
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 11:06:19.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mknfa9qhxeNJJRlFR60DuRsBqt3eEZ4PKgrTePSzsgbvzzDFG1yCj4flWFu/nfGbOGV+liz72NcSgwQ7FnP2dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5742

On 25.05.24 13:58, Richard Weinberger wrote:
> The kernel version is only used to test whether the kernel is extremely old
> and verbose logging.
> IMHO it's worth the complexity of reading it from the kernel tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 98 ++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 59 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index f6eedc1a0..b5644a4a9 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -250,15 +250,8 @@ if [ ! -z $foo ] ; then
>  fi
>  unset foo
>  
> -linux_EXTRAVERSION=`awk -F= '/^EXTRAVERSION =/{ gsub(/ /, "", $2); print $2}' $linux_tree/Makefile`
> -linux_PATCHLEVEL=`awk -F= '/^PATCHLEVEL =/{ gsub(/ /, "", $2); print $2}' $linux_tree/Makefile`
> -linux_SUBLEVEL=`awk -F= '/^SUBLEVEL =/{ gsub(/ /, "", $2); print $2}' $linux_tree/Makefile`
> -linux_VERSION=`awk -F= '/^VERSION =/{ gsub(/ /, "", $2); print $2}' $linux_tree/Makefile`
> -

Oh, that's the nice awk code I was about to comment on earlier. If we
agree on removing, that earlier refactoring should not be done, rather
this patch pulled to the front if needed.

> -linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
> -
>  if test x$verbose = x1; then
> -	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
> +	echo "Preparing kernel $linux_tree..."
>  fi
>  
>  if test -r $linux_tree/include/linux/dovetail.h; then
> @@ -279,7 +272,7 @@ else
>  	curdir=$PWD
>  	cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
>  		cd $curdir;
> -		echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $pipeline_patch`." >&2
> +		echo "$me: Unable to patch kernel $linux_tree with `basename $pipeline_patch`." >&2
>  		exit 2;
>  	}
>  	patch -p1 -f -s < $pipeline_patch
> @@ -297,61 +290,48 @@ if test x$verbose = x1; then
>  	echo "IRQ pipeline installed."
>  fi
>  
> -case $linux_VERSION.$linux_PATCHLEVEL in
> -
> -	2.*)
> -
> -	echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.x" >&2
> -	exit 2
> -	;;
> -
> -	*)
> -
> -	if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
> -		version_stamp=`cat $xenomai_root/config/version-code`
> -		version_major=`expr $version_stamp : '\([[0-9]]*\)' || true`
> -		version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
> -		revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
> -	if [ -z "$revision_level" ]; then
> -		revision_level=0
> -	fi
> -	version_string=`cat $xenomai_root/config/version-label`
> -	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
> -		-e "s,@VERSION_MINOR@,$version_minor,g" \
> -		-e "s,@REVISION_LEVEL@,$revision_level,g" \
> -		-e "s,@VERSION_STRING@,$version_string,g" \
> -		$xenomai_root/scripts/Kconfig.frag |
> -			patch_append init/Kconfig
> -	elif test x$reverse = x1; then
> -		patch_reverse init/Kconfig
> -	fi
> -
> -	for a in $target_linux_archs; do
> -		if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
> -			p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -			p2="core-\$(CONFIG_XENOMAI)	+= arch/$a/xenomai/"
> -			(echo; echo $p1; echo $p2) | patch_append arch/$a/Makefile
> -		elif test x$reverse = x1; then
> -			patch_reverse arch/$a/Makefile
> -		fi
> -	done
> +if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
> +	version_stamp=`cat $xenomai_root/config/version-code`
> +	version_major=`expr $version_stamp : '\([[0-9]]*\)' || true`
> +	version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
> +	revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
> +if [ -z "$revision_level" ]; then
> +	revision_level=0
> +fi
> +version_string=`cat $xenomai_root/config/version-label`
> +sed -e "s,@VERSION_MAJOR@,$version_major,g" \
> +	-e "s,@VERSION_MINOR@,$version_minor,g" \
> +	-e "s,@REVISION_LEVEL@,$revision_level,g" \
> +	-e "s,@VERSION_STRING@,$version_string,g" \
> +	$xenomai_root/scripts/Kconfig.frag |
> +		patch_append init/Kconfig
> +elif test x$reverse = x1; then
> +	patch_reverse init/Kconfig
> +fi
>  
> -	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
> -		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
> -		( echo ; echo $p ) | patch_append drivers/Makefile
> +for a in $target_linux_archs; do
> +	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
> +		p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +		p2="core-\$(CONFIG_XENOMAI)	+= arch/$a/xenomai/"
> +		(echo; echo $p1; echo $p2) | patch_append arch/$a/Makefile
>  	elif test x$reverse = x1; then
> -		patch_reverse drivers/Makefile
> +		patch_reverse arch/$a/Makefile
>  	fi
> +done
>  
> -	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
> -		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
> -		( echo ; echo $p ) | patch_append kernel/Makefile
> -	elif test x$reverse = x1; then
> -		patch_reverse kernel/Makefile
> -	fi
> -	;;
> +if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
> +	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
> +	( echo ; echo $p ) | patch_append drivers/Makefile
> +elif test x$reverse = x1; then
> +	patch_reverse drivers/Makefile
> +fi
>  
> -esac
> +if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
> +	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
> +	( echo ; echo $p ) | patch_append kernel/Makefile
> +elif test x$reverse = x1; then
> +	patch_reverse kernel/Makefile
> +fi
>  
>  # Create local directories then symlink to the source files from
>  # there, so that we don't pollute the Xenomai source tree with

I agree that the current check is complex and in this form useless. I
just wonder if we should remove or modernize it. No clear opinion yet,
but it was you who raised that question just the other week, no?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


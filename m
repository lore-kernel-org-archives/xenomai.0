Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB560B8D
	for <xenomai@lists.linux.dev>; Wed,  6 Mar 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723072; cv=fail; b=h4vg6mQzGVS4xDYaYQwjkN+lHiL69x8xeieOco7B6XxYqzi2loU02yKTSgcKAZQLox6WYgtaIsnsNwSp8OHYK5mBXf+2TRXt76kOOC63itJW9xsI3ZUkwp3fhl/sjVg0fdwOh84i5Vr0qXEuAxzBqujIiWekR1Rkxt+3gSgA/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723072; c=relaxed/simple;
	bh=w/GoLmT0BVfzWDg7jOE2V9LEWe3R+PZqaPy4BGCKRgw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+MLVPgy2m3GMunmtkEMCPUG8vvRNMdecSSMiVe/OljHhtO9NDExmta5quNqDhBTAXvOyE8OSyDhGgwz/C9LNzeN32VzHuiwDnwvJCiO0Lu0VAa1bMiaHLKh0pFSSAH6/jU8YHgdL6JDJqVA1yKg+EuYEYkh3MUPUN5N9+T2DkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZC07yMjP; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZC07yMjP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF0cPv1mPF53stSbdthxbvMp2GsqGsrla7wJLf8VPSHf5zltgn6KCtmkfhcZynpBEwi7/cHUThm+RouqtW6ew9j5dqhsWvKJgVb473rdjtNLjoBBH6TlnDYiPI31BiZl/SnJOfe7wgRbWMVVdtBBBxS+CL28YjjJgGNgik+n7Brm3HQ6R3xKZTPtGBmv+/lVMfIQM6F+H4tUEvf/H2BWY3D3ftbGwILcRqG+z1QFGxoFF/ZbyqrYTAbaG0diEZs/ViKsp9Q6I5R1W7JYNiYM4gaah1fDn72AFg+3nSmgTY+hnZ6YGwSqeeterHRQhYXdSsNoaMSgiNVrXnsbevs6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cseG5O6ppHso8noy4QdaX/CcUnpyfx0hn8UCW3BRJXg=;
 b=JTJcUv5gfIcLCzKy5i8fjNHG8MtMAPDts77EewI/aB4MngpVCaUrDkrXvEy1pQNFYWItqkkeyVF9a+pivyOuX6ASYNDRK+5qJD2mlmrmeeJJwZYF6MzgP51kig9pJMC3PxGoPGgQO0yEc1diVojDYgwOneg2RBYZXJ6DTRZtzz/FiD8DToSniJJlmwYe3vEirlh638DVnq41op1Exi9mnIL4oar0C2BDtUcb66HhaxD1ht8naRJujmBXYHHinqOSPFtLCmDlq1JHi8CnA3IY9Y3DW30cx4IpWJFWlPFhxfAnBl3ZoZrChS1ZkVDMDu8p+VWqiQMXk3Mk1cjzpoTFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseG5O6ppHso8noy4QdaX/CcUnpyfx0hn8UCW3BRJXg=;
 b=ZC07yMjP7cxyMV8/DAr4ckHAJ0flnjLhcZNnWxKHgdgTKn9WlGgY77RaGY5zGQz1o4IN6nOlhAbfPW1d8T4wCTi4TTWHYPlkKJhK6EMsUAgt9Zs8WzguB9B+aCIPgztJy1rwQZwewwu/KfPP/RUsSntpcH83lCOJr0DF0RvM7lu4Uhu81NzqqdyAAJXdO/tGoC0+MEwJ4pUYQro/Z4THe0CN9gRhgji2RDluDhb4rBOQeqEnoX5xXvP7fLcPsxaoj7fQhMvvaRcmM69llIL1D1LgVPBOLU1kAR4cKJOTfpjvcGTERaKn5FVq+yzmR3HMXc48de2YwWyVuyg3Bhjk+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 11:04:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 11:04:25 +0000
Message-ID: <3e6687eb-2052-49a2-b775-58135d7d0af9@siemens.com>
Date: Wed, 6 Mar 2024 12:04:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] linux-xenomai: x86: Disable group
 scheduling for SCHED_RR/FIFO
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20240306091336.2365758-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240306091336.2365758-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4767301b-c8db-44a4-6abf-08dc3dcd2f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dN0LuSoi2P35m0UW/p7zIdT0fWJUIO6AfULeFEFQ/Fe0xzjLAranXsYLju8lqiBXYhDBvY7rSHT0s/6cWCMftkQ7YNjRLcPlS3F1zTe0HayZKzZBqJbm/ZykzxEVfIkftTSOk25A4MbbZcQh1J6Oafp6RXktBa5CSWwNOQinFHrTLM3DqRyyN+nAZArQGFJXsPjX6R7mDjO2f1POri/AVR5maK1Ls29bdVLaOpnLgWrdTsIij/uMSQXU5zanbxwo0pF26vZxKuHMNfeRdyDJn1s3L+ua5HH9xW5GFIdBk0Ek4SaSRh6EpmNR5lSJ//W3Yazh5WmQABSjjc5cVoBeJ2ptmNGAakqxh7k++amdKeMDHgPVGlJ20/YcaOOV1hmCM5oWf/wHdmEQCFvD091MnNzrQ+oDYIu4X0MBJzJVCpdfo5Zi44l0ZcXlyrH3YiMJHpX5NpRVE9xYIBm6+MhRRUymn2+qcqseU6N/WhOe+E7pew9wBxvQi8YFh6QeBXLJNhXl0md2PW558wzm11ZQI72OIQZsga4ihcpLdBi3C6AuCgrdIpw+9vVz/zcw+Fmq40tz/degz5S2FUUji/fUpFpI5/Z1vK8iQYKBnNHI42MkuH9OL91Ia4NwlmfUXepBGwaSf9bnWAy1+D34HKHTXsE+OVf2vzp5u0xpVXUOetw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkNIb240VkVTeCtJRlNNeEtrSzV2eWErTXFES3Q3UkM1YVVhcjZ6VDE5bTRJ?=
 =?utf-8?B?SGJDZzRyY1pDQTYxMVE5QVZLS0I1R0QrUEdraThxa0NEWStLeUFWYmVNMjJR?=
 =?utf-8?B?Qk9xZGxTdFI2VkhHVkRVL2VwMVl5dENzVVlsUUpXYVVwb21KNHFwYWFKWkp6?=
 =?utf-8?B?U0pkK05NOGFMRk5YdUVNZk9adFhwS0FOc3pranIxc1RjWWJjZld0NTJWd1NM?=
 =?utf-8?B?OU9qa2VPSVFNNzAyV1p6N1g3RHAwMjJENlpZZXJxVDNFdUtkeGFURDZtMzVH?=
 =?utf-8?B?VHVyeHl2bDh1MGpWZXpKQm1vRUZ3OHZ6MytqeG9DVjgyam9nZW13TkpHRXBw?=
 =?utf-8?B?T1VGdFY4TzZKaVE0NHh4VHhlcmNrL2MxOTUrMTBnZUdWUTQyRjBoVStpV29P?=
 =?utf-8?B?ajFCb2lOcGkxblRaNDluTmxHTm9kZ29mdlkycWVoWktrQnpEWHR4Y3lBbExh?=
 =?utf-8?B?M0pJd2dubHlhamZaU0d6WnoxT3JnblVGZUU4b25rMFh2Q2FHTGgxeXh3Y1ox?=
 =?utf-8?B?dmxIZnlnQUQzNEdmMVhTc3hLQTNwVi9Tck4za1ROa29RVEZSalNpajZld2Mr?=
 =?utf-8?B?eWUvdnVlTURKWTVsb0dNa0xuVjBONFI3WjJ0YlYwdHNHRkpQYWlOTUNpcWxK?=
 =?utf-8?B?aGhOZTJCV25PbnJBMEszcW1EN0UvZWRMTDd2N2ZubTFGSmZDeFcva3JhVlA2?=
 =?utf-8?B?NDNmSG15T1FnajdBLzl6b0o0RnBIdGVQVjJnUkxnYXhCOGJWRXZxZGhCUkpP?=
 =?utf-8?B?Vlc5R0ZqZWRXRnBRNHJtUEZ2ejRJVDVLckVoTkhJK3RucEFlQkNjZVJVWWp1?=
 =?utf-8?B?eG04YVpTWUFjUk0vMEZIdU83cXhIamhFSUdRNWx2bFcrUGNpYWNOUlA5Mnpm?=
 =?utf-8?B?dGFKeXVDMXpjWlA4SHZraE9CbWlPUk9RUHFpaElmdE1iU1RJTCtQZ0Jha2di?=
 =?utf-8?B?OXdkcERNeGdCbVVkWm1ieFJyQnVLUUxNRFJMTnpERU5leXh6TS9PcHR2N2Va?=
 =?utf-8?B?Tm1BeGxmdnIzZXdvQU1HNEdlY05sMmt1WW1GNUxRcjJwdDhQWVNmMWNiZkZY?=
 =?utf-8?B?N0hKNVAxRFdqZHJmTFNOUUtEdXFLR2I0NnN3aFJCU0NMVVJUTi95VVVwL0JL?=
 =?utf-8?B?R1FJSTZXVm5weStTMEpRTGgvV1lUN3RjOXd0d3BmcXl6R3cxSG9JQmRENmZw?=
 =?utf-8?B?VVYwVVIvVFNKdlJNQ2pnVDBtQ1RPWGs5a1FkSU51SVlYY0htRkhRUUZodGxz?=
 =?utf-8?B?SnJ2NnBjNS92bUxGVFUveUFjQjlqMDFtUWd2aVVjSnV2T3lVK2ZJdk4rUkdr?=
 =?utf-8?B?dVZJeFE0R0VySHh2bmoyZndWbkdjanV3WTdGSlhRYk1zVWdHeCtpSnJiTTdq?=
 =?utf-8?B?SXE0RDlVMlZxMzBPeFZWVXk4aFFKNnFFT0hQWVVWL0MvN0dCakhhWUIrbU1p?=
 =?utf-8?B?dGhVeTFMalFQcnN3VC9LWHp4UVJqT1NzNUFBcmJSOXpnMnVxRnZxZUFXeFdZ?=
 =?utf-8?B?V21WY1VmdnEwcUZSajZ2VkVCQnFlNTZWYXlOeUxlbjBmYnlqNXJySlAzS2Fn?=
 =?utf-8?B?UGZpQlRwK200UnRGamlHQWJLTWVJTThEMXIySlJpcmNSbVJKdEkwRTYwUjNk?=
 =?utf-8?B?MDdGUFFmSTJsUDZ1MG1oNkgvR3BDQlREM2lBaWNoQlo5YUowUjUzaUNrcHhX?=
 =?utf-8?B?RXhoSUM3Mytia09NSWVRdXIzeUl5aVQrZ1I5T0pZR1JIU1pSZWsya21NTnJO?=
 =?utf-8?B?d081VEM2SStzUEJQYnlHQVdFVDVaeUZQbGVYU0dockZ2ZzlUZVF2ck52Rm9v?=
 =?utf-8?B?QWU2bDlXTzRzQlRhcFIxSGcxUmZKUmVDZHNDYWxqaWhxZXJRQnVWTi9oRzhZ?=
 =?utf-8?B?dXRxeW9SczBhVktWSEo3U2NXbnJ5Wmk1N3NPTVhJNm1XcVNkVnJYQzZ3YkpD?=
 =?utf-8?B?UUZnV1VpY0VmaUV1OG95T1ZwcmZzSmxtSk1Bekl4MUVoa3l5bzZDMm9jdGFW?=
 =?utf-8?B?Mm9mYkxrTDdvaXFLSVBGZjl4Yk5vcm1DRTRzN0xJQWlyMnBoeEh0UDFrQ0RI?=
 =?utf-8?B?YnJ3ZnY5aE5XWUhxaFl5VC9JRDREQkc0YlZjcG5zK3oydjk3SkJ2SnJTK0d6?=
 =?utf-8?B?VFI1SVo2b1hHR2hKRnBPQkh4RGg5QjJ6SzRLRkNhRzYvb1RSRVY3d21yM280?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4767301b-c8db-44a4-6abf-08dc3dcd2f9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:04:25.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SaYK985oiIdYAIEgJ5IK5rO3LeePJxxmmY91yKFrhd7eEOuRozdYuYdij46H9ZK53DEhgJBkRo8+IQdfXZHvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7055

On 06.03.24 10:13, Clara Kowalsky wrote:
> Trying to run the latency tool on the example image on an x86 board with
> Docker installed failed. This was due to the fact that the use of
> CONFIG_RT_GROUP_SCHED results in Docker and its child containers not
> being able to use system functions like sched_setscheduler() to raise
> the realtime priority of a process.
> The x86 defconfig has been synchronized with the arm64 defconfig to
> disable support for group scheduling for SCHED_RR/FIFO.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  recipes-kernel/linux/files/amd64_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
> index 2b7e63f..4f58c34 100644
> --- a/recipes-kernel/linux/files/amd64_defconfig
> +++ b/recipes-kernel/linux/files/amd64_defconfig
> @@ -154,7 +154,7 @@ CONFIG_CGROUPS=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_FAIR_GROUP_SCHED=y
>  # CONFIG_CFS_BANDWIDTH is not set
> -CONFIG_RT_GROUP_SCHED=y
> +# CONFIG_RT_GROUP_SCHED is not set
>  # CONFIG_CGROUP_PIDS is not set
>  # CONFIG_CGROUP_RDMA is not set
>  CONFIG_CGROUP_FREEZER=y

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


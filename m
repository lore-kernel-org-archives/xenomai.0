Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088E4A21
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407235; cv=fail; b=mnzVTfszWd4oWlRrTTTWf+wV4FsebsU7ukvmUxoFvBZPB8j7FhXrN9iTPQwt753m0MSjgVwPCQT7VanoAr7OsTlC0TOy+QEb1Zn7yHM5pMLJOPyWkAGKr1BmgqdKm5JlqC+VDgniio17GN44YdQw2XBt525GmWvTy2lJvBhLk8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407235; c=relaxed/simple;
	bh=QeV1tu88SefR405h4mFj7ZpY6Sqx9od//tf/oyBGoDg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxz39yHDoKEI2OPVtVq7uYjX2XdYTe7QsUb1077FctDTu6182jfX4EDPkEBO1a2gbbk5TIqkU90thIDCkhI/BxwyPFgsJZXMY9Z586BT9xe4X7Ef637WLzy4hAd7sJ+rWydAOwT/OLQtLz7SwY3/PfiH93r+EoBTYPI0zqZLN5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KnSUILvk; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KnSUILvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPL76WS1Se8ygWkVKRUfPDJlCruhoYt7aN5lfsYmYRr8Xdtf7+3qrhayl4ulltom91RsIiHCN2hwj7ayfjQYKW/OMQ5zGg34mOOCR/WFNMz1rpWDu7Pfs/3QF0B0jbIQ+ta8+ibH5NFqf39HGl6QxoQX20BMz5kOPg4V//TxeFAabutlGfmiLtlztCmrwH2xoZGeNVeyC/5DnWXLQNHiZgAUbvYU2sdqZKYJ4fWroOzhdwbQ1MI59UjHsuiU9zetzU1aYSlKVxhzp1W9ETipleTMImAE0hDoGdel/GQW5+RV6l4DnX1VC1Brdhndqc6+DzviRVBA28Ot4U6RdEPPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXzIE87fcNT5qLiPHf44rfd0ESTDVwijsD8TCH/32uI=;
 b=FTXSDtJnoBlDtxndqWgiRGzT4GTjt1+KdRVSTAx+mHB/0VOJhTqCqTUmAoeY6C9IaoNYUFnEixpOmqiNRd1B4sbCsoC7x+e7dehmykehNm7w7OhJFGYxZu4kSwMQOHTuz1/lg8C7JTqBqUYJSCyKV8Vek8wWzsb+oWapXDKx/tuc5zKNvrA/G2moqC/kw3+jnfXpIvScFpGHFMQ6C92wQY8Lea/1/S04k/Q+re/GzZGmKLrvbZx7uZlgEIJ1G9BqqfH10gZKLCbKYFBLR9I2PV7M75co9t6Nfdbcyya10SbTlpwKUvVUqdGmIBDS0rduFDMHINx/kXu9reG4PryfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXzIE87fcNT5qLiPHf44rfd0ESTDVwijsD8TCH/32uI=;
 b=KnSUILvkpkXTvxdJX+DyA1JqwQmDRLaOxqIhlCsd0M+7SJ0kyMJtDl/jpPQRKy3GcFCoA00uED7jAS/OFJS27WNNfmfwllufSQFHhTFYktzMFogE1ShbL5MFagl2Gl8ehMczj/9Q0Ndet0ofYdjEjGS+YQGNVR8z3rW5bSU8Qedirn84XReGTgJg9UHK0FbVWzuEGvaTDrBDsGqVPO4mtA0Z2PQrrugZV42G+6sbuyrG+KhX0hOGp4YS/kXYDARv+bQciOKyW+JF5cQdmRHiyfEX0zzkr9wVUULyIZksD4uxoTNU977IM5cJOMqcYoKICYhh4DHBoWrB/ihkOIdEXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 08:40:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:40:24 +0000
Message-ID: <488f8a8b-c7c6-4a62-98c3-a4e25229d2d3@siemens.com>
Date: Tue, 9 Sep 2025 10:40:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Remove sstate-analyze step from CI
 pipeline
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20250909064454.657166-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250909064454.657166-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: abd57e93-9111-4ba2-091c-08ddef7c84fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlZ3MUtWT01ycGZKWVhPcjJrVUNvMWZScWdINXpzV1VsUHAza3NZY0Q1Sjk5?=
 =?utf-8?B?UElpaFloZTIrMXowTk8vVkY1WXVmSFVVZXRTeHJld0V0SFozNCtsNlk0MUlD?=
 =?utf-8?B?bVVVazJ1UEJ6LzRzNkNMZldWcFVMTG5FdVZDcHNjelJXK3lTT1k4SVN5LzBz?=
 =?utf-8?B?bkh1U2pmSHpPWGlZc3ZGb2haOWRDNFBHYy9oU2ZRWFIwWUdlZEg3NjdxZmR1?=
 =?utf-8?B?TkNXNXR6U2syaElpMC9qdTF2V3VZaklmZ1BLaXhWSElBcTBhbnpyM0lmYjB4?=
 =?utf-8?B?MzJQNUdUL1kzOTR3OFpaSTB1bzQrVFJ5cUxUcjNYNkpleEIrenVkdGlyZlpO?=
 =?utf-8?B?bTkwVmxUZDMwMENWcE5iVnVoWVIwYUR1ajhYSFN5NkVwMFBLa3EvQk9KeURS?=
 =?utf-8?B?bElXQ0ZDbVNZV21QM3h6cW5uaitzR09vM0ZPMWQ1UytvNWRpdjNscVZRYmMw?=
 =?utf-8?B?a1VPaENxTmxkdU9EU1hFSlhDTjI0cjdkV3ByYjBFVHpiTXpwbVA3SHFuaVhO?=
 =?utf-8?B?QUNvK1FDN2pCL1JCTVJBVFFxdE5EVXpJK082U1JIWHNNYmlUbktvWlhFRkJE?=
 =?utf-8?B?aXpMdFFyMkNtVVduODZIZFhSTU1FZVV6TENGV1BqQzRIL0xkcFc0cGtFSUNE?=
 =?utf-8?B?OFlJUXpSTmp0cDQ4RWdvWGtpK0d6cmMxZTcyWnlKaTZ0c2dtRldMS0NoeSt6?=
 =?utf-8?B?RFBxTTA5UXVOeTlBS0dSckFXeFlqL29nY3B3a2tMVDk1M2tQdW5jTHdhZTA0?=
 =?utf-8?B?dkVtalRxTXBmNE1tek5iZDlmekVlUlI4MFkwVm9jb3FMMEh6MFpyemNEdTBQ?=
 =?utf-8?B?MWJqS0JlUzVYNVpmMjRGcU9HRHhPS2ZKd3ZvMVQrN3ovRWdWUVduUGsvNnhC?=
 =?utf-8?B?OUZjMjU2ckQzcE0vVElZYy9JME4vYjF2bEEvUTJNaWhqQXVObUViR01ZeG0r?=
 =?utf-8?B?L3FGWjczd0p0NFY5aW53bDFjSC9qaHpXRjBFWDZhWUkyakNobFo2QzFZSDNZ?=
 =?utf-8?B?TkZkaFRkYkZhZFFoWTBKR3hhc3JCV0J0L1RVZUFrYW9YWXY1WmVEbmxxcjFp?=
 =?utf-8?B?enRZOTlWUTBUbzcvaTNrZFYvR2Z0U2w4bW9vOWJkVS9kU0FPeWlFeGRmbjVS?=
 =?utf-8?B?dmdWdXd0NWVLKzZzSC9UZUN5ei9uSWlrdElsR3dmbGt1elpURm4yWmVZWU1t?=
 =?utf-8?B?RGZBY0lrbEF6TFoyTzBrd241bTdIWTEveC9yRFhZclJFbG0waVg3VUxDNUEy?=
 =?utf-8?B?VVlRMU5hL2hyTHMyV2lTb0RuUnRxVkMvK0tienViRlhJaU1NUUx1MWloRHBX?=
 =?utf-8?B?WlBTMHFrdDN2eitzdmNIQ1BiL0VZVzV5Mk84Z09yVHhteVhaNUlrMlB0MFQ5?=
 =?utf-8?B?aVNWTG9CRHNhUmc3RXZGQVl4OGVKQXdSNllldjdsdng5TmRDcm5FeHMxT081?=
 =?utf-8?B?bk9wdExNUlQzWkdxQjNtM0pzMVZRL2RHbmh4VnI4ZUN6Szg4QXA0aHJBanVJ?=
 =?utf-8?B?Q1RPNGsyN081djZ3L1d5V2dxVFhvb1NYQmU3c2lFb3BZTnd3bVREMUJ6ZDZs?=
 =?utf-8?B?SFZyMVh1L04vVXpDVms0QmsrUGxYRzVRa3Y3bFBJbExDZVJUZmF1NndXZzBY?=
 =?utf-8?B?WTRvVUJMZ3V5eVB0Z3lzcGpNVkF0VEEvNXdDL2NucnhhUUlacHpqMDU5Z0FK?=
 =?utf-8?B?SVhFMnVTODYvRmFQbjFBWmJibGxNVVRiaWV4YW1zVXMwV2c4YlJnZ3pOTzBv?=
 =?utf-8?B?VUJHVGM5Q2J1RFVRU1RQN3ZZc0pJV29RME1qWDhVWjlFRmZKdmtobXEwcVg0?=
 =?utf-8?B?eHg5YmFDZzE1ZW9QOUhIYzZTSVZFTFp3K0NWVkJJN1R0cW1OcU5QOVpNQkRk?=
 =?utf-8?B?NzJQaUdIeGNaTGZqVW8reXpaMlRqMVE2S2YxY2ZubDhFcVdiSHN1SG1zeTMy?=
 =?utf-8?Q?/FiN3CgJa4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXFMWlM1RVVLeHF2ZDc2QlVNdTRGTDNrVzNZZzJCRGFlVWRLOHl4OVVKS1Rk?=
 =?utf-8?B?NFRRODYxOHg2SWp1RmxyMGkxN2NSeEZhaVZvd05QbnAwVE1oK3pmQk1jc0Q1?=
 =?utf-8?B?UklzY2tiZUZGTGZWZ2NscFdSdzlrS09TYURHSHBCNzBSbC90MXNVaFY2RVN5?=
 =?utf-8?B?Ums4S3Q1ays3QlJ0ZHFBYzdFUUVxRmNhVzgrTERGdzZSWUhzY05nMk5xdSsr?=
 =?utf-8?B?a1BoeUJQaG5odFVaaENLdE0rYnBXQTI3bm9Bekg1REJNQkJxRmhLRGhYZnpT?=
 =?utf-8?B?N2lsK3FZYnh2czBPNVpKbm55NGpJL3c3emlsVlc3cmZLeXpjOGpsVTNicTRD?=
 =?utf-8?B?OHBIUjArWVg0YUdDS05VaG1ST2pQUC9PY05KUDM5TGtuK0FUeGlzR3dvMFRo?=
 =?utf-8?B?NWo5UTdpV0hmR2p5NTVHSFZjNFNTL01ta3RUOThBTGFFSWNrUm8zQjJRaW1l?=
 =?utf-8?B?RnhGalA2aTNMdStOd0pnckZGYkVTc1lOQkJqVXI5ZHhFdjBIZGQyOGhHYzNO?=
 =?utf-8?B?RElONURTaEdHU1VUVDBBMy9rYkR3eHlRRlFyR2phTmRkaGdwekY5UmFwNVlC?=
 =?utf-8?B?TTBBRmhJMzBkYW0wcTFtblhnZDZqbEpjaDdBVlZwbTJJSVVxTmFpUXBCTGtU?=
 =?utf-8?B?Q0ZLTVhuRVh6RGlkNEpSYW1uNDZwUXFuWnZhUm1xOTFlOW00Yk1RRFRuN21v?=
 =?utf-8?B?MTNNUWFqbmwrM3F1a2U3dTgrWCtZbG1hVmd5VkFKY3drR3N3OGFuaUhkeUJa?=
 =?utf-8?B?NzdzR3AzbXc5Y3lEQVh3OTl4eGZtZG9nOXUxOUt2OXRNRTUranNqZm5Ba0Jx?=
 =?utf-8?B?SjlESGFYM2V0SUprd0Rkelp6cjNQOE1Ud243bGpMWlFGbWRValJOdVBSSndl?=
 =?utf-8?B?RytrUWhKcCs4N3VlVjlyQzJSdEE4VmxTNkNzcHRrbFkvK3ZTdnJLZjlEcEdR?=
 =?utf-8?B?NUloWEQvc3pXM1MrYVpONWNtUlhGM1hxbC9WV1Zvd1p5Q0lMdkc3d3ROREdQ?=
 =?utf-8?B?U3RHd0FtN1BZMzVIVnJyZC9xa2FObVN6eGRmUlNzOVdQeWxuckNZb0lHZSsr?=
 =?utf-8?B?WENUMVprZXl0TFZkeTVnL0c1cnVRcUhkM0ZVOWEzbnYyNGlwQjBpaFhrMVZX?=
 =?utf-8?B?YVdPU244eW9KcUtuSjRhMllrTnZ2WExoVDlPa2dvenF4RkE2ZUxQTU9OajZt?=
 =?utf-8?B?YWF5dVpySkpRZWwybmo2bUF4U2Fwc3JhNEwvYVpTaVVhR3pWT2NSeFNkYjlC?=
 =?utf-8?B?SVF3bkhkbUVWdTE1dDdtZ2d5bnprd1dQbVN2S1hpcmhzSS9wVzFPZmVSbEJ6?=
 =?utf-8?B?S1hMQWN5WWxZUmw2UVB6ZnU5Vi9JQVY3N2tSQnMvMnlOQXNWWHRneUtJdXRH?=
 =?utf-8?B?bWZiWWRtNE9QSHVKTU5ZRTlGSzhrOG5GWU9Sd3lXTU9JYk1QSUhMSXZ5bXAv?=
 =?utf-8?B?Q1pVV2RQbFlGQUQ5MUJzMnMzelE4OHJteFltOS92RW1rYmVXemVvQUJQQWtP?=
 =?utf-8?B?dzRKNkJ4dGFHejF3YUtFK29HYUMrU3B6SzFySzBQaU4xMVZhbGlybFFZb0Zo?=
 =?utf-8?B?V3dqYkpjc1oyWXhBOWlIS1psanI1ZWQzaGRjVm9yb3FQcW5hOG5RWGs0M01K?=
 =?utf-8?B?SFNLVXpOZDhpM2MzeVNZaU1HWVcyeDdHNnlRR3VUNTdrWTRoNk82U251L241?=
 =?utf-8?B?ZkIzaHpaaGFmQ3YxSm5NY05LUXNuUjZEWnNpSDBiZWY3aENJL2pXcDVGdjdz?=
 =?utf-8?B?RDFBZkU3US9QNDVndUVkSERUSk02a0JNVEpkR1A3VnZrMWg0aVVGZzdGMEJD?=
 =?utf-8?B?djNJLzBLTGV0aEhTN2R0bzIzcXZJalpkTkRWek1idFpsTHdGZUpYdEdmN0VC?=
 =?utf-8?B?cC93VWlTdWpJMUVQRXNoYTQ1cFdXVUV6SDY3QithRWlNNE02SUhQMlp6eDhr?=
 =?utf-8?B?clh5bi9TeE5QNlZZdTZHSi9uOUZiK2YvdFJLdHhpMUtkSi94emF2QlErV0U4?=
 =?utf-8?B?NlMxeEJ5S0xOZ3grczhDVFU1M1FWYXpmTzRyN0JRWW1VSFo4OUNNSHA3cHJQ?=
 =?utf-8?B?aS9wYTdNS0dlWHNQbGVUZnA2R0haRGxEaUI4eUFWc3JzQ2NOb05DbXFNbTBh?=
 =?utf-8?B?ZDNzVEZpbkdhbUxGbHRYZlp2TmNFQmR5TUcxbnN0TDRCaitFNTZPTnFhMFZE?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd57e93-9111-4ba2-091c-08ddef7c84fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:40:24.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qGfVU+a8+9/tok5kVYDvfUEj/PUNAD7TXLX2P+7+38YbtytdTovJpBR1Lsxem76ZcZkjkbTtvr/R/MsvvYKvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8115

On 09.09.25 08:44, Tobias Schaffner wrote:
> Do not run sstate-analyze for now, as the cache has been stable
> for a while and its output can occasionally make the job logs
> confusing.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 875d951..bf1734f 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -39,10 +39,8 @@ default:
>      - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>      - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>  
> -.sstate-analyze:
> +.sstate-lint:
>    script:
> -    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
> -    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
>      - echo "=== Check for cacheability issues in build/sstate-cache ==="
>      - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>            --sources-dir "${CI_PROJECT_DIR}"
> @@ -80,7 +78,7 @@ default:
>      - du -ah -d1 build/downloads
>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>    after_script:
> -    - !reference [.sstate-analyze, script]
> +    - !reference [.sstate-lint, script]
>      - !reference [.sstate-upload, script]
>    cache:
>      - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

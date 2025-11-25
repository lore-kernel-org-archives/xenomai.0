Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE128B3E7
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100364; cv=fail; b=OJp4Tss2jQTSv8hHcWFl5kLb3N0H5RkrjjYnNSLTOLzn6oNxaHcpjF9D8Ts4xaSp5DRFS91JY1UiYjqLZNe3gwx1ughi9OYDm5fhxU8jsqSZX7WltuCg/5LYNsNS0JqJOA1pnI7bS5qLy62MsLVj1aVq2iq+YlvNcyrxdP+VZdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100364; c=relaxed/simple;
	bh=+57Po54GrB/HZh8lBK9TYnCL2Py73TLheCYMh2B9PGk=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EtNn1beZzWK5DUKraAaRFZlqlhixUvFCeup6K9l1SL8G1GO/9t7NcVh2wbM5zjPP6uGPxBU66PZWtcYBB5iEKoL4LdFH/J9eh+xKkzD8qlSalHDaxvb77wvRGf/ehLlX1yizlp0qOzcAzFHpsI0XTdahGSmZOffIgT0n2OfpTk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DMHwFhep; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DMHwFhep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixIZZba97rCI5ylvHzSCrDIdiwqueReRw6zUAtW+DqxkyIzGc+wIuFkEgXcABOICQjHgXTE/4jGfDjVBRhYJns+vpcHT8pwd3KfkNgBSj38ygii8mcqCpyZqcPSUh0WzQv9dj1RhMJdnnha1l7ywMvElnIvHLlh+cKPB5yKspWWMcB891owSHj4/xaR0oNGYYUG6HwvxM89EcNK35gvWp748BZ44Z9sZmNQULPPHi5hj2moSgYN4VZohKl6/Enc6ZbRtxb3NgYvu779UqcfgMMIMfagc8sFIBR+P4V+9zjFrFKKaON9SoqQCgwj85GrK1ppO+PLaLf9PIOI3ZSYBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY8Rysa/1CI7i/NbZuM6Mm0/o16o7AK29YC3OLw7b2U=;
 b=XbDKvPfI5a7yBDundlhV0sMWpqXGD9eCkBdSPVVaHTptuztI57dY7tiPt6Dhc4+wv8UH9EJcHGEsy3aNTJKEmKva8DZjach6jVXCY/qn3J6KBfHgj+BWLtLF2v7C+gInSbhb+28Gvu+eNGl4OUh+ccUiOpnDBoVn11Qi8AsJnDNmU2i89UY1ig6qHzmWxteS0qhBl7F/rUBTq676cK9pE8d2scYCSEm9XBQeSJlzdXmmeIGOvQ/3hteYHxF4GR66oS+lNUDc59KpqzvH7dLZjIBco/J3acPIv6J7xgCWWtdd8lyNwBBTM7qNsyWbe7Fs8BAe8FW5N2gWDRyOa55A8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY8Rysa/1CI7i/NbZuM6Mm0/o16o7AK29YC3OLw7b2U=;
 b=DMHwFheppH5M8QUbn6qkuReCbc9yt6/DWk+T4NmSGjem2+ZWQhMY1tFxQ5YMvj50jkY1AftPoA1hLDEjXUbeGC09aPoGJsFvvvv4im9KaVwEaTzi0i+fANhHq3EK2dk91Wh9hvyniFgLf8dxVwx8RuQP1wQrMxI0IviYk4RTyRyZLLReAq3skIZd+B5iUpCYsx+4eXghkD2nO9J3dOWV1uAPWtn5pp1MC7oasniXCDbYBdRIgk6t4i3evulG0j4GRxRfV092EjtSH3miPVovS9XVFAbn7HDzVfuLIn4lrH9/kbU+GEN4LdGiZMMM7R3uyxs1NCZwjUqehpt9KDw5rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 19:52:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:52:40 +0000
Message-ID: <160f8f82-4c18-43e6-a9a7-68199953db22@siemens.com>
Date: Tue, 25 Nov 2025 20:52:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, November 25, 2025, UTC 7:30
 AM
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <a583022e-ab0b-4cfe-830d-6a282faadac0@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a583022e-ab0b-4cfe-830d-6a282faadac0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dd9608-0cdc-4e5d-7b71-08de2c5c30c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFB3a2YxblBFYThnam5Ud3cwSU1JY0pGbGRjM3Z2OGxBRUpCQ2hGbnBmeEhJ?=
 =?utf-8?B?WGwwT3dRQzQ4bVE3NHVDRHh6eWRWY3YvYVB1TS9WUngrS3pWMkJWTURWY3lF?=
 =?utf-8?B?ZnZlemsybGRHMzlKcXViRGkrNlZWZk44ZGdNclpoYklXTWlKaytaMitNSTd6?=
 =?utf-8?B?TElMdzh1bS9UVmh4YmxscEZoRjVHbFJjU0M5RUtpUTlobno4QVQzbEQ3OExv?=
 =?utf-8?B?TTM4VEdVZ2drMUgrUHRkNXQxZTRNYzNTeDhIaHVJQ0oydi9MZTJQcnZENGZS?=
 =?utf-8?B?cmlRamNIQXRtaHRLazBGQkcrYThsL3FFdXBFVVhGcUY1YWxIZzNNRXI3Ny9q?=
 =?utf-8?B?VFFHZ3QrOUFsa2hoQVVYbFVYc0tEak5jTUp1Z3BjUWVjeTdQSVlSUmVaL1Fj?=
 =?utf-8?B?cUtWbTVRTTcwMGNDbmRkN3BiWHJuc2FZWml3WmRwbks0Yi9pRHNjU1o1dkV3?=
 =?utf-8?B?Z3ZqOURRV2lBOGJaRmk1VEJlTTNrRDVUNFNCVEh3ajdOS2ladSsrd2IybS9X?=
 =?utf-8?B?RWV0VlpJdjBSQzV3S1dseFdlOTJDSk1XZFcvWWdad3RpMjJ6L1l0NzRleVp0?=
 =?utf-8?B?dk96dVB1TXVDVDRPOE9Vby9yRGJDWTBJMUdYamxlTUxNL3ArWWhtSEZtaXVi?=
 =?utf-8?B?Qk1SL3BVaG5PRXMxTXZ5RG5rcEhmUUZrS3J4S1kyL0lBVExmMEt2Q1cwRm12?=
 =?utf-8?B?dW9ETGU4NE1Xb2IvNWhaNloxSnNjN2FzMC9xYWY1Z3BjZm1RZGxGcC9tbnhH?=
 =?utf-8?B?b05kaHBHejRaMjdlbGNoUllCd21LaFJGYVR3TUJmWlJ4bk5aS2lUNFFXK1M2?=
 =?utf-8?B?Q2EwQzlDOUEwUytaUndjbzFydWI2RS9oOGRnTWprYnY3cktjMGl6aGQxZTdw?=
 =?utf-8?B?TVpGWEUxZ0prTjErTVUrUG5hZDNtcC8wbjRKcUZFN3U0SHR0VXVuaGRzbGpY?=
 =?utf-8?B?c3FTeWhKdFluUXJ2SmlLclA3WnpzSlRSV0VpdVp6QmpYZ3JrWXhUMGh1Zyt4?=
 =?utf-8?B?Tzh2eTNTenVZZ1dEWjBWYm5xbExPWkdsMi9jNk9pYjJ2RnZhYlpQclNPeHFr?=
 =?utf-8?B?cjc0YnpqcWxsYWdab3BlMzNVNGh4bm5rL2pzaTdFMC9aUDlLRzFZNDBPOXRE?=
 =?utf-8?B?MUtaSGQrNVR4ZFVkSjhWckh2RmRabm5RMzBONjFsaWkzV3NSVDc5UTVLN3Vt?=
 =?utf-8?B?VitMQVM3UG8yYkhuWTEvbG9lcHdEa215NitWRTlDVmhPVk1heFptRGhTTDlW?=
 =?utf-8?B?RmJjMDBSazdmc08ydTE3d1ZKa00yYWNJakFBc29BN04xN2FnRTRoMktsZ1J5?=
 =?utf-8?B?Sms5ckZhbWZpeVYzdnZnTEYrZ1kvbEZWc2pGRmlmSDJHMFVnWHFGbnBIZFJE?=
 =?utf-8?B?ZVU4MktWZ0xLNmdhQmp2eXIyU3BUUEFxZ1FoRThOd09KV1BJSVpiNFptSytz?=
 =?utf-8?B?a1VxeWpOZndPNFVVcEI2WmtId0ZpbWhzRUNPV0M3WDdNQ0E4RTc4ckZ3SkFz?=
 =?utf-8?B?UEM3bjlWZy9JVEtpWnlMUVNHMmxaMUdnSENZNndKbVJHZ2N3ZmYzc0Jsa0tE?=
 =?utf-8?B?Q1E2a1VZcHZZcUNFTFhZM21VRWd3WlhNdXA4aXFvQUhNa1l0U1J3VXVUUzNH?=
 =?utf-8?B?ZFkzdkZWMm1wSy9TOWFlWWthNEhib256NmYxWDBnSTFqYVVtY01RL05GVHI0?=
 =?utf-8?B?ZGdLL1JGZGxBVmt5SVhvRVhyWGxaWDl0LzVjOExqMHVaelRWbjBYTzU2VjFW?=
 =?utf-8?B?ZUVWeE5tbERrZ3RZY1lsdldKWmMwUStxN2lVNE1qWlBPNDdzS0REemNPTTRr?=
 =?utf-8?B?RVYwdnJqV3lteWJKV0JEbEdLWkxsU2pmbmEyNnMvWGdDWWRkTGFBRHE5UjFO?=
 =?utf-8?B?dVVuVW50dkUreFU4OGNzTXFCTzYrTTdYZk5RZ25qeCtyU0JHK244SmlubHBz?=
 =?utf-8?Q?01IshKSEZPeSvXJQWcy/tUNDyk3ZTPOW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFMMVB5ci8yMzg4TWlySnB3Skl4c0ZoVjIxZG1MYU5aS081WjdVaStSVWF5?=
 =?utf-8?B?a3JYKzV4c0hVT05nMGdzT0YxSG9TMjh5dCt0ci8zRHVJOWNRdmxMbU1CU3dK?=
 =?utf-8?B?Sk5uVjlSbkp0U05yeHc1T3BKL2NUSkJIWVN3dnVraUNoZXdHNWZTQUpjbkNT?=
 =?utf-8?B?UGo4anlyYXdyRGJaV0hKdU9LNUZyZExiVWZBOTFzQ3pHMUcrY25lSStuMXh5?=
 =?utf-8?B?NWFOVlA3K09kaUljbFR4aWhvYWxtQWNzTDMycjFPTElnNVJKVG5nYWhteHdr?=
 =?utf-8?B?NHloZlFIWUYvVllCVzl0Z1FwOUsvWGRCcEtmVSthUzIzZmNYTnRJL1NLY1dU?=
 =?utf-8?B?S1VRTDJYTHlwMGxpcVZocHRpUnRRTmR4VThaVlREU2llS3cxSTNqOHpHRWNp?=
 =?utf-8?B?NC9wMDljc1NQV2lYMGt2UEpzTnVvWVVPWmhyRjBFMkFGS0xBY1RMOWdTREVQ?=
 =?utf-8?B?cDZra2lLelFhanU0Tzd4VDYxdEFzWng4N0dKbFc0T3kzTTk3SlpsQ211WEhM?=
 =?utf-8?B?bVd4VnlpaitkbUR5SVd5NXVhS3BkViswZkswdFFTUmNUSU5qYnFXSXlXNXVH?=
 =?utf-8?B?SVZYbW50RVlWa3h6YW9pWU1KWE5QeHJZVkhMdks3WDhLUDFhdmVHNWczRHVR?=
 =?utf-8?B?dlBpamFXSjB5NTYxQW4vc1o1dy9UbkcvZGxMZ1ovL1p6cVljZFZwQkRPVzd6?=
 =?utf-8?B?bEJERnlrOHV0alp3K0I3cnRjZjNiMFU5cjlVc1RUQkFtb0JjajFkRXhiZTZi?=
 =?utf-8?B?alM5K0dIZUgzMHhnQVNWOGNIVFlPeVlwMFBhMElPWnR1VEwxV2h0TG9Ca3hv?=
 =?utf-8?B?T01BdFd0T3pKaWFPa2JxZlZoSDN4VUZjN0VhQW8yUjQ0RmVyOXRIQU8vbGox?=
 =?utf-8?B?Nk4xYlRQbldZNGJHNFNjeGxRKzI4dUxxTk9pL2tkblpIN3hrOUhzUFNmZzUy?=
 =?utf-8?B?ZTV4N1dHdVY3bzVJNVNJbndGZU93Sy9ZbUNYazQ5NzhRdFNvT29DY2tnT3JP?=
 =?utf-8?B?VXgvRHZVdUNCTkxRRWN0TjJ5enYwTkhJbWNha0toN2pjZ1J4SGhzbG9yYnNh?=
 =?utf-8?B?WFVrdGxPc0hzR3VURkJDWlBlZjRtd1RETGxyMHZhN04zQ3dvRTZuaTI4cHFZ?=
 =?utf-8?B?eVhmSXFYb1c2SVFQTkNtZTNJN0xRb0J1UFBXeGx5K3FHMUQxSnMzZEVBcXla?=
 =?utf-8?B?U0VydldBaG1wb0FDaVkwdWsyR0xFdGpTdS9raUlvMEZYN1F1bCtxSFJBM1hH?=
 =?utf-8?B?UWNPci96OE5JT3ozZzU4RnBRaFN3MVhvZmxBZlRFVzlzeFNpbDdEeC9iV2pG?=
 =?utf-8?B?ZmdCK25TQkNzZC84OEZqaU8yT1orSFpOQjJKMkdEU0F4VDFQREFyRmxWUWFq?=
 =?utf-8?B?Ukd5enV6am9tQ1ZyK0pDVTZ3TVVXK1ovM2pKaWhxTU11Q0t1eVl4MnRncGtl?=
 =?utf-8?B?K3NFd25mcnF1VzdIZldRbVVySjZGN2FWaWw2R2tNK2pwZFBDdnFKU1oxT0ww?=
 =?utf-8?B?d2tKVjdYK0xlNzVPUDkwRUhRNW1RQUNBcmNmT0QzY2dROUpFV3N6Q1hFU2Jh?=
 =?utf-8?B?dkJ3bEM2Ty9NdVlqK0R0bUQyL3p1M2dYbGwzN1Y5czlSTVBDdFFRS09IMXcr?=
 =?utf-8?B?SmkyTlpLWWRoSitLMVFHSEVuOUVjTmlPTnNnQW5vanYwK3d3L3kyVnZvSW4v?=
 =?utf-8?B?OGlTYWg1czhEZFh3TE52ejNhZ2xQYW1HNHkySGV5eThPVmczbC8rK0JpcUZH?=
 =?utf-8?B?TlpaWEVRVThUVS9HbUtUUlNvNTBtZlhHd25vYklKbkhpU1NLZGFKdHFUbHZr?=
 =?utf-8?B?bGRBeWxhbFU4cVZTWjRvcTlMQTdOV0ZTbkEvdlRJcE1UZWZzZHZWNHZRMVA2?=
 =?utf-8?B?bnp6aEU4YkROK0NTakJDS3RxZ0RpNWFTTFVtYzRXRG9aNFBpRTBXUzFsQXJN?=
 =?utf-8?B?Sk5ZM1UvMmhIMGFDK0pNS0pSSW5WdWZ6Q2t4anZxcXR5QXZ1T2ZablU1K3hu?=
 =?utf-8?B?WnU3MHpmdFJmbzJ4MjkvcmFtazI3ZXlEZXhiUmxSNWJiZjZJY2hXa1ZIc0ls?=
 =?utf-8?B?M2l4Q2xOYTJOZEFXN1VWQ0JBREpSRTROaXYwOXpQWGhEVzdpVE9mYnl4SzY1?=
 =?utf-8?B?aW9tQUIraFpoc3RHazZBcDMrUHkyOGR1S1QwQTZISldqSFNxMlJBb0liQnhT?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dd9608-0cdc-4e5d-7b71-08de2c5c30c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:52:40.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE1dQvCgW0UByP+YAzMGP3aUEs7iCTxkJjNZ2S8uPOhbPo+L6ltW+Zp7pABkluiVYoISg6+EUcSmCAxNOHA6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8459

On 25.11.25 20:51, Jan Kiszka wrote:
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions (you may have to wait for
> the organizer to let you in).
> 
> Time:
> Wednesday, November 25, 2025, UTC 7:30 AM

Sorry, Nov 26 of course...

Jan

> Paris, France CET 8:30 AM
> China CST 3:30 PM
> 
> Join Teams Meeting:
> https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

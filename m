Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0737182D3
	for <xenomai@lists.linux.dev>; Sun,  3 Aug 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205568; cv=fail; b=GmIcMMzXZU/PAeKbBtHNQ+0LIHuWGdHtyz2UtL1VOcm+SgrhnnVt/aecnvDLx6/XCi78W1ZfbpUkr0nwb0AuaI3ixTCSJfmiPGNAXj91+PBW2sGIU39Gv/ftSXrQ7PcDGTeazcmVlrn9GUrXzhJ6mirwbxWtdk2Xi5X3/uomwTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205568; c=relaxed/simple;
	bh=sHJc5JOs5Lr+YqazreD8+AFBa9gkI0wGh1VC5dvvMjw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqSDHllagDU5wK/R89/cHqlSAIHEWb6tQtKBM9vump0Ix1MCzIFcrg96OflOx4dQTTLBZ9+NIL5ayc2u00mNkTqYvU2yorWTZuVVG7XpqinYHqbm6+VvjeBYnzWHi71+WO3oeGFOnhyLwYaQri2psNhUMyQU2tLg/LWHvc/kSp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=P0irXCBv; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="P0irXCBv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NapNnKcA6HJc/yFYt3Za6uMzmC57su0rm05oQHZoxqNAY6XbOJKgZHWWM9H+HlC1He/uvU9XsWTW3jratL58mPhUeP4tQ69vpdSgCEiqn3i9JtAGlYmzGlc3P97YowmtE55K8S+nRRNDvpmTfiFRqFkcDGouPGkuGLk58c0P4WeGvKcU83a1blGPhkZZVYt+0O2jPS7kmSnq7pnmgfzHAbSPowTN1B2YAn33VirrOOO8Dd56XYMr8xnMcpzR2VWU3jhHBabBgjPUgSE7ysaVRFnTtCrc3XpsCcrKoJeltle3nR7By0F2Gvyrp8ZcEtHQp5cPUjA1XI89z43a3A5ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQyGtbI0Vf5mY9k4l6xQbVP7TqW/dG8QZ3Wm3KGSoOQ=;
 b=u1nZoo9ypKT59NutFD6/O6pVToxaPgqCPo/I6eYHm+x2sMBzn6Nvdj5GkQvipu6RskG/2KMQXFsIld+GGeWAJpR1VzwgBGCCQSRwrSWGtgvuEwvz6Bdf5ZjkA/X2EwBRjskeUHm5BHImh+/383weU39V8MaObEXqsZfBBZkgeTg9BFIx+dlLSaDrjVsgb7UF82yQQg1PxxYPaB4kfEqu51IQC7QIohb7nvlzc6RhtFFQ47mrHGpT7Gngd/lI6IWt/ufL+F8cISdMLzDAvbgjfbstuuI5XXQ5DaPcuVvihYq3CtZFptF1VkjOUi8yhLj1Bvs0f81JvZnpVrQ0bWzALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQyGtbI0Vf5mY9k4l6xQbVP7TqW/dG8QZ3Wm3KGSoOQ=;
 b=P0irXCBvkE5TliZmI8Vm23Jk3GJTTxwLIocuX31OhLUKSpzNhbowXoD6USUn2sTqHC28tBAmooFr3aBBKaY//riYYjQRARDkGzThZebIxEgEYOeLn3qjl+DOg3BZnRGEl3XUQQDZ8R8LW8nZCn8VDaTA8NLGQkSRwiZwbwdM3s5nwF0zZCwnsSrO2mqKoFYdRV/8RqclWq9QUlN5tp9CR3QGSDTxM9eso/XOMDnyPNJL69pHlvOkKKjEmg8SZH9JmGsau/HnIQTWdZyTz4ScTEc/R0LZWPdq91w0p72bMZqqSygUoAUK+BQ+87xsuS/SipHKXoWquFqe5ea++uQaXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Sun, 3 Aug
 2025 07:19:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 07:19:23 +0000
Message-ID: <2e96ecb4-e3ad-4757-8bc3-77e56eefc211@siemens.com>
Date: Sun, 3 Aug 2025 09:19:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to enable floating-point operations in XNThread
To: Suntao <suntaoworks@163.com>, xenomai@lists.linux.dev
References: <310ab4c5.1f5d.19869cf7137.Coremail.suntaoworks@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <310ab4c5.1f5d.19869cf7137.Coremail.suntaoworks@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 00faf720-f2d2-40f9-d699-08ddd25e124e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVQbmZrS2FPUXB5MVFJMjFDWFFNOURBWGFlS3hwaFZhTEVsNXRjV1oxcHJn?=
 =?utf-8?B?UjB5N3lXT3VSZjhGcS9IUWtHYXdhNzZkb3RnMVI4MlQrOHNTWGppQnlHRkd4?=
 =?utf-8?B?NDR3Vnh0aDY3aWhHNVNabTRJam11eHU1NkRrUWcxSE9kbVhvd1BrcGhzaDMx?=
 =?utf-8?B?QnNONGpkcmI1M0xiQWJZNm5uYmZCbGp0TEp0ZUk2c3BuejJMM0UrcDNZT0pN?=
 =?utf-8?B?d1BWQkFUYm5qbjRwZlpOR0ZEQ3U1S3QrNE1tMEM1dXBCTzBkZTFjdHF6SEdI?=
 =?utf-8?B?aUNVcjkrYVJhTDlYRE5qWHB6RGZIWWt5bDgzZll4dTBVY1VCVTcvQW45MDZY?=
 =?utf-8?B?ZVh3VE5FZVp4WjhsWE9qd1k4WGRCMFRkWks1bUY3ZzBPTXUwZTJ2K1l6U245?=
 =?utf-8?B?SVBZUjlkTFpzcnlrUEdjbXhTSDl5NGF2TnFmYjNXbWhVMlAxRXhQcUZhbHhp?=
 =?utf-8?B?aTNoaVg2enFtYTdqZFZOMWpmdW9mVEdXbjU2dlZ3eFFWcEhVK3lvUDRkc0V6?=
 =?utf-8?B?cjNreW00VnM3V2pSU1dBTHVMVUJYQzFFYUxiclplZGFoV05mSGVKbGhKYmhY?=
 =?utf-8?B?V3hXV2djN2pyYkJ5Ni81alV0N0hMaTJSMDcrUi9oWDl2eDAyMTYyUGtwdWhl?=
 =?utf-8?B?RE1tSFlrc0hIdytaWWdzbnQ1UGdockpqS0FVVXh4Z1YyMlc5TXpHN1hxSVZW?=
 =?utf-8?B?UzJUc2Q3NGRQTXdUTXYxTGw1MWlxMjRMRUdDTkl3R3I0VE9nbmpwQmxXSUxO?=
 =?utf-8?B?MFdMZXk4U2JFd3ZRaDF1MzE3NS9HQWFOTlBONUo3K3l0ajA5WkcrWTE4SEpP?=
 =?utf-8?B?ZVlRaVNjNGtWbXRia1hhY0lSSHhpVnlVeStyZzZzYWQwbE5WeS8xUWJ0TDgx?=
 =?utf-8?B?TzViS2NDSGxIY1UyT3BZNnY5bEZOQm8vbmxRcUpjNFY4UDlUai9zMXJLY2FY?=
 =?utf-8?B?VEU2eDE2T3VZR1ozTTRPdkdQb0lWRU8waytkWndOeE92clVna0F1b3NTcmdy?=
 =?utf-8?B?enZMLzYxdXE0NXlpNEFISWJrSkgwdkFET2JhdmVsbFNpU1dHYk1kcGd2YlpH?=
 =?utf-8?B?Y0wveVlaaXBJZElTNU1LY1VGRHR2SGdLYTcwWTd5alRud29ZOXY3OTlUQnRW?=
 =?utf-8?B?QW5xZHRGM1JEVi9vYzdqWkpjemQ2eFZ0alFPYWphMUkva085cTNDYzE2T1pB?=
 =?utf-8?B?aUJ1azBYSFcwRWw4NE9YcHhOTmhLcDJMY0RrK3RMaHcyYTJSL1NrQnFvOU81?=
 =?utf-8?B?cnRrNTJ4VW1wL1ZhazMvdDVjSVpYanE1RHhCNUliNW41WktObE8vdllpZFR2?=
 =?utf-8?B?TEVIbEhlZ0xGS0xLNUQ1bHZFSjVQTTFFdS8zMUZIQVVGTGRBeGRraG5iYTRy?=
 =?utf-8?B?WS9DcGhzMEY1NmVaV2FobURtNTJNTWU4K2JBRm1Bem55UktWdSsvUHhiK3p6?=
 =?utf-8?B?NnpsRk8vZEozcWFCSDhuSWhXbGxpeE9SaHZFcXhZRzJTZTZSL2g2Vm5udm1H?=
 =?utf-8?B?NFlRTFJ4aDB6MjhjMENSMDQvZXEvUGh5RnFFQVlid2s2TUZ2c0xyMjZNSWtn?=
 =?utf-8?B?aERVbTU0aUdDSlhBRGFpM1JTb1JHM2RPT1R4RzQrK0J1QzQ4Umd5aTJZaUVw?=
 =?utf-8?B?NXoxVjg0ZlBoelNRV2V5SU94dUhRcnRrWEw5aVRWUjhxcjIwMnFyTk1UVGky?=
 =?utf-8?B?TlM4TVRUajhqa0E2M1EzRU9QOUxMd054dm12empnTThSaU5yRnhibnFrcmVn?=
 =?utf-8?B?SGNzOERPekZwNHNCN1h6eHZFbzZVTmw3dUFhUE9oeC9ZZ0xqSGlPT3dibXFI?=
 =?utf-8?B?cDVXc1FaMHpicjVRWlFnc0ZKSEV4TnRZdER0K2pROEtEVVliWUQ4dVV2M2E2?=
 =?utf-8?B?ejcxeWhwcEo0MW9Va2pLV3RCNWp0dndQMjQzR2U5RG5wWkN5bWRGNEtQSi9K?=
 =?utf-8?Q?iE4Y1cHUi6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElodEJERzdnbGlhdG5SZlhwMDhINFdUSHFGMllIRDVoa0xuRnlKUk1pRVlV?=
 =?utf-8?B?SkZQNnRYeW5IZWszNDZTQWFFTm9kdDFIT0NuRml5akVJVE40Rjk0a1hrR1E0?=
 =?utf-8?B?R3Q2UFp3R3ZKUTRNQjdHUitydGQrVGFuOGxxb0pZRXRERE5nRTVmdVYrMTll?=
 =?utf-8?B?WWhZek1pL0Y1bWthVnM1VWpZZUZicUdFbnRYVW9UN25PdlFkT04rZTNWblNs?=
 =?utf-8?B?TTlDTG05TUx4ZjE3ZTRrSHoxOVRxWVc5bFFXbXg5cEZNTGtpaDY5SDhxREdW?=
 =?utf-8?B?TFVoSy80cXBsOG95SzluT2FlQUZESk50V0w2ZUxkOVUvWnVKTmt3anlheU1N?=
 =?utf-8?B?bGI2VkZKZTVOL0JTK2F2VjYzY0prODcyeEFvSmQ4ek92T0FKaEdIL3plVXgr?=
 =?utf-8?B?aVhwZmk4TzdkTnFXcmR5N0dVOGkzUlZZNGZWSXQvWG9pN201NnRsanF3V01M?=
 =?utf-8?B?L0MxcmUvQUJjNTYyWUN5OUJ1QkdvNW94ODU3bU5pRnBVaHlZUmhKL2RDS2o2?=
 =?utf-8?B?WWVOVDdsQnNaSnkwU0NZYitSQnViRytJSFQxS25wRVN6L2pocTh6SlF6SVdl?=
 =?utf-8?B?Mk1RNU9PNC9zUzIzdnNZSDdIMDcvTVQyc2gybmtHdXdVektQMUxOSVlLYnRh?=
 =?utf-8?B?bjlrT3picGExQ0JjcGwvOHRqQitIWkVuOC8raXlHVHhlWWs5UnltUVF2K2Y0?=
 =?utf-8?B?cUFwOXAzMUhvbFR5cmdOKzVrZmhuSXpZU2R1WVNSZWFXekNHejRIRUVGZFlV?=
 =?utf-8?B?SzcyMXdaajJ6ZzlhTmtSd21iamtVTkJGNEFEQW1mUmZqZHNNdEh0S25nZUJw?=
 =?utf-8?B?RXU1R0gvTkV6WGdLNWlCaHJuYUo5RktqTGtGaDJGek5nOWRXSmhHTElwZ2Nm?=
 =?utf-8?B?TlNsa2lFdGM3c0hyU0ZNYVNaUUlMSVEvTklCd1kvd3hUMHRyeVlxdnpyL3V2?=
 =?utf-8?B?U0NUcVE3M1ZFdlRpMEw1RXBFclVwY1NMYlRlemxTSzJPVUhSY29pSnE2TFlw?=
 =?utf-8?B?TEhWaTh5YzhwWlBLUzFxTkFHSUYxa2N6eDNvazdpWVluZXNWR0tDZHMyTmg5?=
 =?utf-8?B?M2pEeG9KNzBjNEZuVGtYS0h6S2Y5ekdaK0l3UEQrcFBwdzAxOW1nM3FHblRo?=
 =?utf-8?B?akFpZkE1MTZnSGlQbEhlYkxtd0NzRE52OXppZzE5NXA5Tk1CTnY4N1N0K2hG?=
 =?utf-8?B?aEg4aExZWXU3VlNhejNXbkhWc0FnRGJrVnFTazUrVnoxNDFqQklndFN2WGI4?=
 =?utf-8?B?aFdNNTU0aXdlMlRZYVMxZE9tbFZwVGtRcW43aS9HakpkNmtIM29WODFkaGNQ?=
 =?utf-8?B?OVFOemp1cTFTWCtjdnZ2TjdFOG9YbjVUd1ZodU1hMW9BVzgyMHN4dGphOGZN?=
 =?utf-8?B?bXQ0cEkyOVIwV0FjL2FZVW42S3BwajZsdUhuVnExOUtiaktFenQ5cHFMd3dt?=
 =?utf-8?B?bEdmQ0dmdEFwMVVHbkl1UUNESnJvMktrTjdCVWoxc3daWE80VzAyTU1YOHl2?=
 =?utf-8?B?eUlCdkFZYnNJZktTeGVJTnByQk5Qa1hYNEY2VEhmU0hXWDV4NVA4ZFFIWjla?=
 =?utf-8?B?K2VhOWVpQlhiMk9xbndsb3JHMCtuL2ZOTjloZXFyTjMySk40VmdiY1FDcE9w?=
 =?utf-8?B?VWk4MkJZYkMxby9mZkNLaExJazBVWUM1OXpyTW5VNjNjYWtsN2tqOE5YdkM5?=
 =?utf-8?B?U2RLeG8zbmx0NWxFS2JiZUVhOTA5eStQMnBNRzFmQ2V2R3BhdUZyN1ZHeUxt?=
 =?utf-8?B?ajNtNkRFR285UlZjR0h3b1NncUY3R3R1S2pIL3FkYVJuSVpzWDlEVkNJaEhF?=
 =?utf-8?B?VFFJUkJmK25LcVFIallpS2o5K1JGcEtBWHBma2ZUbVNjWi9xNnBCRkRYNHhU?=
 =?utf-8?B?SEtJRWFrOVJzRTNsdm1UMEI4bFdVZEVFNXp5QXNaV0JMeW5rVzJjQmtuRWcv?=
 =?utf-8?B?aXE3VmlMa1QzK2dkNy8zUGVoeUw1cjJDM05pSkZBWFo5cCsydTBjQlNjZVhZ?=
 =?utf-8?B?Q05NTVBTdmFOclBvbzNMMXpKamRlcjgzUzhVdG40MUVqWTRkLzB2OExOZzBF?=
 =?utf-8?B?aHpJeExJVURmcGJROEh3K2M1czBLMnd0MVVJV2hhMWFEckFhVDJqTG1peTBw?=
 =?utf-8?Q?PC5U9saIgmuqB2I6Ufvyp9Qr8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00faf720-f2d2-40f9-d699-08ddd25e124e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 07:19:23.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcJnt7N4Q4z4XqXjr40mXOUNOKxQ1dJX41JTnRu5DwBwA0miRyEwU1AS47oagZaUygSsX0UD8r7r7OsmqQIGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7538

On 02.08.25 10:04, Suntao wrote:
> 
> dear all，I understand that when developing Linux kernel modules on ARM platforms, if floating-point operations are involved, it's necessary to call kernel_neon_begin()/kernel_neon_end(). Additionally, when creating an xnthread, the XNFPU flag needs to be set. However, I'm unclear about how to perform floating-point operations specifically within real-time threads。please help me, thanks.
> 

Please see [1] for the topic of in-kernel FPU support.

Jan

[1] https://lore.kernel.org/xenomai/f750c64f-0914-4b5a-831f-5353ddd0eb8d@siemens.com/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

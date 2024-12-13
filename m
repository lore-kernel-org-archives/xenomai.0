Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9271B85FD
	for <xenomai@lists.linux.dev>; Fri, 13 Dec 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083461; cv=fail; b=jxfD4W7WGBdS8he4kEvvoCnVGQMezDJfKIe69n/5aMQohqxbilzJKfN2LeGmPcD5ywAnnVLoWefN9cxkGpDaowdoUNvrsb+h6BIdh7pI/vWp0jpD+BFr8+sXN1LOPerGmU969orgqYuipu+u3BCDXQLNOkVLPymtcbWeglZRcwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083461; c=relaxed/simple;
	bh=pUngHGC9hE2pcA7UIaoQpHbtovcsXXt6MWweXL4hGrs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NdZlEjxl+6/xfsumNaRgd0erul50ZY9D1iepobqe7m5owptnOEPXQ+6JH1qiSp22AQFnFyftqOy+f4DeRHMYND2rZW8Iugi4CLuaPk172Ejlll6rY6a7TkLx+tBkMCzc8XMbx477I+6MgLi9aFfbcsEJpxxEv22dGfVW+P7DB5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NNkzFzg1; arc=fail smtp.client-ip=40.107.247.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NNkzFzg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9zEsRf4KSZtp3KcSJBQdz/eSb5RziugB8PdQ3RgUQp7URNB7mX86p0aQJoWxenUTr6eoa1esrJAZewniOyaBtxhJ0ljoJnd2rSluH9uWRMoSSDvYHsJYZ4mDbByf1yi+WmG4PfOVcjQ/RyhkvSnAYZKEjktxdLG5S/cIbwptwjwOmusQ/Hd5En2MKFfNFrOViTB6lEV5v6247SAy8FSVweI//kG9Lj6sQn3T/ZlMLFUCFQzE0wsyOAgbLmxxdkSR55L5XgqezfpRCTF5MS4pFR2Ibno98uH+uK5ID2Rv5DKMXjQ82GQ5iqLZTRzGjQr7nqSUIGnnSaaPH9g8h51Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH53eRFyScHun/NcD5Y3G2zlgcVOH1ycLVS3vKcnVF8=;
 b=mjvA6+1N3dlePJJH4dqO0w8W6jBzhnt85gBORA5AaMoGhKy4MtwYtJrLKS6ySMkncl26aP1hJrYKVUsnqnTSgfXS8ZKyr3HxFL5MFZKgwvNG24EvJzSL3qZ7fjmA4h5AXfqG3SYL/Tl0SNk2yzT6u34gqqYb30H0kzmbuwZ3Gmyr4w/QExRAM7bc1VrG1oHA7XTVJIpRM97f7Ygb25b0d768VnThLcGJdwEXsUvP7wF4JwlcW4lt2S5I7FuMWepdyR3ysyf9PJoLVavGhk/dodTGhvfBNQwl5ic3ZLGG+h5nEKsIaTyuQ9cDSE91vnvbvb6KV7DloMLyi+/OTtNMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH53eRFyScHun/NcD5Y3G2zlgcVOH1ycLVS3vKcnVF8=;
 b=NNkzFzg1NnKJryOUCxNzfwNRK5YhiIjiLCXyDuQkrQhwdkc1H0I8up5FzfctToxqLOkzxNhbQv9mGTRtbBNbwdyDHiSYH+oKaNVogYyZhmaXHw2uJOkdtuyhN0+cm5Xjn2faQ6pjByKBcHNQ4SoWCa7i/Yl8Uynu5ZwsZKfNaZd4jREXJ4/+qD/qTNxN77FP8OzbYH82/cug1Q/aN+VkWW17Z8JSMIDBwug6hze6GFmAno/MCgML1gjJrsgG3ok+Tsjfl7eaxq97GGbJVfUZ1J6hpsjyIcymjKH1+gWTlXzmLNjFtprsXrjW8lTDayJD8Tm5ugbei8H9zU1QQ486vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.5; Fri, 13 Dec
 2024 09:50:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.000; Fri, 13 Dec 2024
 09:50:37 +0000
Message-ID: <2450acf1-5d9b-43da-a4aa-60aa643413b8@siemens.com>
Date: Fri, 13 Dec 2024 10:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: irq_pipeline: simplify the send and handle
 operation for ipis
To: shannmu <shanmu1901@gmail.com>, xenomai@lists.linux.dev
References: <20241212163837.326938-1-shanmu1901@gmail.com>
 <20241212163837.326938-2-shanmu1901@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241212163837.326938-2-shanmu1901@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f3be0c-c057-4425-14e7-08dd1b5b98c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdSTklzRDFtZ3Nua3pUSlZjczAvV05YNjVWSkJFbkx2N0h0c0E3dC9qQkxt?=
 =?utf-8?B?dVlDcnJmalkzRm9SeTBheVorc1Bjd2lvbTQrMGxQdEJSenZXNThqNXZQT2pr?=
 =?utf-8?B?bVZSL09oVTJRSEIrbnJMOExpLzJyNWladW9KU1Y2REZZdUN5OTMvbTdETzFH?=
 =?utf-8?B?SjY2RGszT2tBTzBKOTd2Q1VSY3crQ2oxVEI2bmNKOGI0a0F5SjhRaHc0TTRh?=
 =?utf-8?B?eC9WUjl1QlFSeTFTU1RiWXlVTFRKWDdtS3B3WkFWeGtnS3lJUWR2bU5EOGZs?=
 =?utf-8?B?TXhaNzFpTzFqN3dSWHdCYkwzVnJRSmMrcm1PVUlja2JtQ096WVNCNnVhQm1m?=
 =?utf-8?B?QXo4R0o0K1NiM2dJa0xrMDgvb29OTTdhcmNjbWJlQnBCZ2FwNngyUitoeDkw?=
 =?utf-8?B?YUNBeFUzd2ZuZGQyTWgycHNSL3dRNkN1WjQ2VU96K25JcVFHdzdLbFlKODdy?=
 =?utf-8?B?aGxWeTFLQ1hoMTk0anNKMjZsNkl4ZU10YVAzZEdMaU9PZnEvd2lpZFRvQXo3?=
 =?utf-8?B?TDFmV1c0YlZRemw0Wm83TzRnQkwrRm9yQXh0d2d6Z1h3THppby9JaHhHb1lD?=
 =?utf-8?B?a3RTS3V6allXMVp1bHFqVG9vbmF2SFF2Y1NyQmdjMDZwY0ExK0RjQmxoYVE0?=
 =?utf-8?B?cUw3NGMyaFducEN6dmlNOStkOVl4YkN2VWw1aFFPdWxBY3h3bzNZbWt4MTJM?=
 =?utf-8?B?aGRka0RXMjRaYWtNVm43YTBwNU1zZTFCOVJNUGFBVzZGMEN2ZVRJSkp3YUVi?=
 =?utf-8?B?UXEwd0tpU0FIcUJkNUdzcTNkYUs4ZmtzV3FpV2FmaFdmSUdBSkVtOERSQkxo?=
 =?utf-8?B?QTFnMGdMOUVSV21WYnZ1Y09CY3ppdHhGQXhDUVlLdUdtaGUzUTdmN2wrY1RK?=
 =?utf-8?B?cFRaVzVhWkxVOTFuREVhYlRlbUdOcFllUDB5UGQ5eWJqcVJTcEVrNTJVcGVJ?=
 =?utf-8?B?RFAwNVlrbVZaUVNNdDFONXpScm02NmZiMEFNUlYxYUtSWndnL1VUenp2RS9y?=
 =?utf-8?B?aXF5Y0FGai9nelVkU2VINWNVK25IWnNEajJoTUp5MTRiMnk0cXEyeERnR1hq?=
 =?utf-8?B?YkJDRnduWjc2MWpVcXgyVlFycmE1cWE5NjRYQ0NDQ0dsSXJtZU13b3gzV041?=
 =?utf-8?B?MVcxeDJ1U0YrL2xERk1ZdU1hcXNCc3hRdzI5M1cxTWd5SnBsWDg4cjNNbUp6?=
 =?utf-8?B?RWVsa29Ybk9rWDN3Z2tXRU1keHBUbkRHc3BGKzg5L1FORjhxclVRRVk2N2JK?=
 =?utf-8?B?Q0dubEZoVTlUTHFKb1RQRGJReldnOGdmSVRsTnZqUjVrRVA1dzNhSG1IamUz?=
 =?utf-8?B?Z0tYbHRwMFNLQkMybjhYWUU2ZWNkM084YmVtNkx3cC9VVmRIcWJhM1liVy9u?=
 =?utf-8?B?U0t5clhxR0FzRzl1RzBidFZtalppMlQxaWw5aDR4MGNiK282ZGh4Q3hieGN3?=
 =?utf-8?B?bGh0SHo5S3lxQU40NkdjbDdWQlFSQ0VIWi8vNm9QVDBidkkwb1NFQnJoWmxI?=
 =?utf-8?B?a1ViOE13K0JPWXE3L1FzYzgxcXRVNmovZFJFMnh3U0pPTUtZUVVtNVRKTExX?=
 =?utf-8?B?aVo0ZlVGWnJXcTJmZlFTRVhHUHA1VllveW1VYi9hK2hWWDcyVWwxSXIvZURH?=
 =?utf-8?B?Qlg0czY2OU5xUTUwWnppdW1oZWozaDRObm1LbHhKLzdCU1k5bU16dFV4ZDMy?=
 =?utf-8?B?SllmM3JWNmpkWitVREthOXdXbUFTR2NUcDZRcHpFYy8zTnVUdE9qK1JaM0pW?=
 =?utf-8?B?dGhkTTAwY3JtZHQrdmZDT1dubnJwL0xXL3UxV1cxbFNuNUE1a1pQdHJJa0hw?=
 =?utf-8?Q?LBxgfmw8/YKsKALGi2Sp9/LoVC9w8GVNy7R0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWd1R2xJQVFNUk9XbUFzbzl5ZXg5aXcyaFlrUnlOL2tkZU9RN2IwZUZxQWpD?=
 =?utf-8?B?UjRJVmlQdDg4c3dGbUtXOGVZbkZhUU12bkdOVHkyNFlnbDVJaGYrMWQ1TlZw?=
 =?utf-8?B?OGpVS3lQSDE5TVh3SHU4RHFoY1RvMGtzNWdGMXU0UlVMam1EbGgwRGk2V0dW?=
 =?utf-8?B?cWxOd3dJTjZ5YmZjVnNBNGkzazh3bk5seVRLRnAxV0k5cndzeEpITUp1L3B5?=
 =?utf-8?B?eDVQM1dmZVJDd21iQ01sTmtZVDVvQ0t0NXVNdXVUQ0ZTMm83TXRtRW8wS0dD?=
 =?utf-8?B?cWJNK1I5L1VJSm83NnBNMzRSeVRuUG5yUHVyaHFDM3ZmOGovOGpXd0drU09N?=
 =?utf-8?B?RmZidVU2ZnlVT0ZBejlqVmh0VkpPQmQ3T3NJZEhRN3AyR3hGOWtEZXYvaG5T?=
 =?utf-8?B?Uy9TV3FDbnBRa2w4Y3dyZjI5NSttMlhJMHJwQ1RoR1BYdG00d3BmM1B0dGd2?=
 =?utf-8?B?QlpaYnRoejhmNmJXRDNmdGx4azFqaGt0bnhjVkQ5NHZRd2t6bEZSYnJORHcv?=
 =?utf-8?B?YlhyVWJmN3dCS3lnQmVRMmY4WG9IeHdlWm91NUZWTCtlYXlieGphazM0bWlI?=
 =?utf-8?B?aHZjQnRlNTNIWVNhdGM0M2lVeXNwL0FULzdHNEE1bFhSL0E4NlUwUnZsZnBh?=
 =?utf-8?B?R0tzR3RVLzVONzVLczFkUU5GdWFEcTFLNExFNnZ3WFZWVWJZWFBkcFFhbzZy?=
 =?utf-8?B?RGdWdXowcWVHZ0JvZVE5TWhQcDNQM1E1b25MMzZQOGlxQm1FTXc4TFNWQnNv?=
 =?utf-8?B?c2hld1dRN3REZ1RSUjhRcnpDNzdFalJSbFdqV3B1cHB6Unpma29mOW9Od2J5?=
 =?utf-8?B?bGlhaTZaWEFQT2VTdFlvMm4zbXRSNzM5Z1RaOUVDNmp4ZlFJRk9adm0yZTN5?=
 =?utf-8?B?UWVYUmMveVdSb1R4djBXZzAyeEhCcHpuZnRKc1ZHQzVQZXRCelBHSUtRQWNK?=
 =?utf-8?B?eTZLd1NJOUZ0OTFkZXo2QVBoU1k2LzhZeWVXZmNNUFNZVmc1RVNydkh0cDZ2?=
 =?utf-8?B?Y2prWEwycjhWZ240V1paRDNMcVdaUnppZCt5MnRxNFdBWkZ0MVVOS2pTSTZ0?=
 =?utf-8?B?SldaZVg3Qmw0MXdFaGU3NkhCVDlJZ1NSanV1eXUrbzdoYmZyZnh4UWhiR1lI?=
 =?utf-8?B?dnB6TkpDajI5dWtUK1loMEhodG9yWFVCR3NuU1NKVmpORi95WUFaeFMwSjU1?=
 =?utf-8?B?NW80aEVlQ1hmRzA3Vyt1K0s2UHZQOFg4YmVGdnA1TWwzU3h6Qk1JWDVrQXJo?=
 =?utf-8?B?ZW5SSWRsYVBNN2kzMjJVYTN5QkpnekpRQVg5VkZ0aGhiTldzOEdsVVVPM0ly?=
 =?utf-8?B?UlpibVZFaitUSUQwM0N1dTJnMlVTOTVPTzZBaU5maGQvUmJxbHRkT2x4YUJl?=
 =?utf-8?B?TFNRY3VFTTkvVUdlNzh6OTZlcFhVYzBTQTRoZ1hNMEM4Kzd1T2FwU2krVG9M?=
 =?utf-8?B?U3ZRN0dQVnVSK0cya3BHOTE2c2JmdUx1R3dmVnI3RmtRWUpGbUtTS3BwTHdj?=
 =?utf-8?B?ME9MOEVHMnAyYmNWME9JZ1RPemNkK2FwMm5oZFB3N0d2ZlFVc2MrbXNFNktx?=
 =?utf-8?B?VG02M3c2MWErSytkb1AxTmVWUG5BQWN1eDhwdHYyQjlYS0QvallJR2VJNlN2?=
 =?utf-8?B?VmRkYWlvQlBCSDBCci9Lc1VZQjl1aWM0alUzTHBWekNjb3gvK0NwNk5Db1JG?=
 =?utf-8?B?VndZREdESUQ0L0lvZHBiN3V2M0JFd1RYckcvdnJWb2JZVVU2VkR4RzBpWGpj?=
 =?utf-8?B?RkNianJaNUtZaStoczJxSzVxYW8rZnI5TkR3Z2R3eVpoMUtEZlZKNzdXWjZS?=
 =?utf-8?B?bFpiYjBKSGNtc1UvbU0rcTU1OWRxOGx1VU1pcXBVRG9JQjZtZERtNlh4NUpJ?=
 =?utf-8?B?VkRqZFczcThGWXRpQlVjV21NekFoOS8yWndVOUF6T2NFSEZCcWNSdXppUnY0?=
 =?utf-8?B?RVNSMS9NU01mY0pMa0dtZHhUaFQzcFlkZjBFLzMzazFjUEFudS9NRlRWeThW?=
 =?utf-8?B?RmYzbXVybURZclVLbVhmZFQzNXoyNnhQZkk4VC9MQXE0MUlWMU9RdXhpYjhE?=
 =?utf-8?B?UVUySHcrWmwxRnJJRldFQzZzZWlHVThZek1wNVlRczBnM25SNHJOdFlJbi9x?=
 =?utf-8?Q?2qSCyYb2ZTqhl+QHBvl9LMjIS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3be0c-c057-4425-14e7-08dd1b5b98c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:50:37.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHGFffoVhqsP2/YpU9j8lNH/Mj4yhylxblpVDcLUjoMiR6nVp15Shp+jpklKJzeoypZQhjDvsNr/M8QARMWrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8704

On 12.12.24 17:38, shannmu wrote:
> riscv is different from aarch64 and we don't need to
> encode and decode inband ipis multiplexed over `ipi_desc[0]`,
> because we can alloc for up to `BITS_PER_TYPE(int)` ipis.
> So we could introudce more `OOB_XXX` ipi_message_types
> and treat them as inband ipi.
> 
> Signed-off-by: shannmu <shanmu1901@gmail.com>
> ---
>  arch/riscv/include/asm/irq_pipeline.h |  18 +++--
>  arch/riscv/kernel/sbi-ipi.c           |  10 ++-
>  arch/riscv/kernel/smp.c               | 102 ++++++++------------------
>  drivers/clocksource/timer-clint.c     |   8 ++
>  4 files changed, 59 insertions(+), 79 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
> index 2ef91c2af706..030823745787 100644
> --- a/arch/riscv/include/asm/irq_pipeline.h
> +++ b/arch/riscv/include/asm/irq_pipeline.h
> @@ -9,17 +9,19 @@
>  #ifndef _ASM_RISCV_IRQ_PIPELINE_H
>  #define _ASM_RISCV_IRQ_PIPELINE_H
>  
> -/*
> - * Multiplex In-band IPI messages over software interrupt 0
> - * as we do in the arm implementation.
> - */
>  #define OOB_NR_IPI		3
> -#define OOB_IPI_OFFSET		1 /* Software interrupt 1 */
> -#define TIMER_OOB_IPI		(ipi_virq_base + OOB_IPI_OFFSET)
> -#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
> -#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)
> +
>  
>  extern int ipi_virq_base;
> +extern int NR_CALL_FUNCTION_OOB_IPI;
> +extern int NR_RESCHEDULE_OOB_IPI;
> +extern int NR_TIMER_OOB_IPI;
> +extern int ipi_max;
> +
> +#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + NR_CALL_FUNCTION_OOB_IPI)
> +#define RESCHEDULE_OOB_IPI (ipi_virq_base + NR_RESCHEDULE_OOB_IPI)
> +#define TIMER_OOB_IPI (ipi_virq_base + NR_TIMER_OOB_IPI)
> +#define PIPELINED_IPI_MAX ipi_max
>  
>  #ifdef CONFIG_IRQ_PIPELINE
>  
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index 0cc5559c08d8..176f4ad3c427 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -12,6 +12,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <asm/sbi.h>
> +#include <asm/irq_pipeline.h>
>  
>  DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
>  EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> @@ -57,7 +58,11 @@ void __init sbi_ipi_init(void)
>  		return;
>  	}
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +	virq = ipi_mux_create(PIPELINED_IPI_MAX, sbi_send_ipi);
> +#else
>  	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
> +#endif

Maybe we rather want

#ifndef CONFIG_IRQ_PIPELINE
#define PIPELINED_IPI_MAX	BITS_PER_BYTE
#endif

somewhere.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

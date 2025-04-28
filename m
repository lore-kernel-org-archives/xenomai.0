Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416B70831
	for <xenomai@lists.linux.dev>; Mon, 28 Apr 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825044; cv=fail; b=qpUbimoBqLf9UBYCe43jcS+WxOFf9azHBZOz3f70I8gtTaeXDCJ8zAFQojuh0J94DzXsaHBKqh5hXJpA5yNX305RwqnTkBMRChduSUKbDNrCwKKAjc6qv7M7wjw9HhEEqh3xFyYKUOkWmJmxsCNB2mtFc2LEarXxCIb9bxyh1so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825044; c=relaxed/simple;
	bh=0pHEl7YVEYr6kmzZOQEqsUYMMJdcqupmHYUbpTr3BXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fr2PrAlZLNSMGTxXh8Q03Us6G/EFbrnAEh3e6BICcRrlLYHIHlnbUNFpvPvDtbcK02F1CssNtfBi2ZZVW2lEvMoQe/xHZ/JCI8bKZOzMyJAKGmbmw7M8J04uOpFfyRLikA/cbq34TeQC3VEDgKkG0CyfnjDinnlbX4BWhdfljSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RWFg7BPD; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RWFg7BPD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOaWPCpte612pNhSY4uZTm2u4vDvBkd9pihkg8OBmIpd6RRVC9gh8bql5iBV0HFPfrlx786wiifYPOKBMRFm73VyCaKrn9Kj0CBpA722DH8n/exTH8EoHYw/N/F9eASZlqqlCz4TPyLietgAClYA/0n/dWQ9IOjW9CdaNCnvLEJ9nMycs3vx0RLsXQFZyHXRSiD7Qq1hva1hi/MR0t70PGFc6i0x4N2jmp0JTab2US1YoV6IYhlsq6GCSfnvbZCkvpV0D2Stkj6RA26B14124F8Sq9Mbd42Q25T7ixCPlDIGwQB+alLOBaSCI3RuR8mmoR5uN5FJqknEGfzQ4LE+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/mwx3CHqusYYFXgnB9NhcWGMVj7bBB+camGLqAKIJo=;
 b=Q29NfDnQrkkFpxOu6Lt9bIx7IXv+vu/YTOlUYPKEHuueNH6hAC8u5+/ZyfnF6UHnd+APwlZ+463tCspYfR422iu876xua+taXDBauJ9OBakIycgFNH6qHqKeS6sgb6A7v2gzqUqvHuQAMAYuyXOIVD6OBn6BVibADuNd2/b+xiAxOiuL6RQttz8atSCkadxMR2BR9QZL6hGaNFMVJoNkrIr6O+MRYP0A6SpXr8mkK5e/tS1zZTJubJ+NUExjir3W8s8r8gGjPKq/XLkMqnflSM497gEe4H+H0v+ysI/qRMbz8ARyxnYCUxsT+zUXxTtpl88/QVG2nV1cOc6vppULXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/mwx3CHqusYYFXgnB9NhcWGMVj7bBB+camGLqAKIJo=;
 b=RWFg7BPDk8nL09IAu8ahEpDHk2utiCxkDzITUnMOIl+zdvaGhwySs5lHtIeWVYZuuoiDKxR8w+824XbwF930zTa9iwlybKciGgijjvCxnTE/O5ZV/f3WtELdVn45MOOLePu30IwV9OtA7mfX5fYF6wITM2n+tmS4J543Ran/YK5GlJiDRGb+MgjgoLOD/2Z+DDqJAwK9bq03sjN8ElCsO6aLCYjbFKLX6hyKMOnsVtw8VCBo6BIVGsdnn+bpM4Bik0gfQ2cWHJbT8/6TBZowEdLaYScMSMbvx5OEbEd22Na/YK0hskCYNwRk2FTG0cYxRxPGs9hQcrrxRGvNJcaTFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:23:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:23:59 +0000
Message-ID: <64ed8c58-08e2-40c1-b02e-1e9551db46ca@siemens.com>
Date: Mon, 28 Apr 2025 09:23:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: Remove xenomai.cpufreq param from MIGRATION.adoc
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250426024707.2349986-1-aspirestro@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250426024707.2349986-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 533f7542-40df-43e5-5036-08dd8625a4e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk1DbGZRckZ1NmhZU1lUQnNxVHVld2xkU2JJUnozMFVSc0hNZHAwaWpTSkVQ?=
 =?utf-8?B?cU5ialI3T2FlMjFYR2NyR0hCS09TS1dGczJMN01NcmpqUm5WT2NHNFJvUndq?=
 =?utf-8?B?b2lsekY1VGRueTdjNjVpWUh1eHROV1d3aE1HVW9SdVp5SmRGRjlTd0RlWDQ5?=
 =?utf-8?B?OE8rbHFmTTEwdXZjVGRWU1c0cnBzaGtsUFg1WC9pNVNtQ2ZXdU4vNFBiOWNa?=
 =?utf-8?B?K0dqQ0lkSmp6V1Q4VitNWFdXNnZtMG4rdDN5dkM1ZUFjUEpEV1NjRlY0Rm4v?=
 =?utf-8?B?cXBVVEg2VFM4MWRiMDZQUlB6S25sUWFQZDQvajlDVWJoVWNVZzErSjFIK21i?=
 =?utf-8?B?bTYydUpNdmJvUmgyYTFFM0dEd0JneCtTMjV4dHBzVDF2aW9xTW9LbUZFY0Rz?=
 =?utf-8?B?aFhQTXdKb1VVWnBkK2ttZStod2l4RE4wREJpMDhsUm5kVlRiZHVROHowWHNY?=
 =?utf-8?B?STVNMHJNTm1GY1ZJMWpucjE3RnNmNmJwcExNd3JaK3pvYnp3RlArTXVsSkJo?=
 =?utf-8?B?aDE5eVVXZlBRUzlYOTZtY0RLVUVTd3NVakdRVHNiSmpJc1U2VUxQZFhGWFBT?=
 =?utf-8?B?N2ZaRVpicW9QZ1dOWVIwWE1OQzM2ZXBQUEtDa1N4Z1JZQjJVTExhdkdleXA0?=
 =?utf-8?B?enA4a1R4T3h2NUd1SG1Cb0RvMFVLT01WNDF2TDBnT2VVK3I5ZWdWMC9jWEZi?=
 =?utf-8?B?WUR4Zjd5Rm5zc2Z3eENqRklZN05ESCtFTldUd3Nna1dVQ2g3NVFGZ2RtaFZa?=
 =?utf-8?B?UzkyK2RUemsvWE9CQUxjWDFmYlA1OWxubzBaZzFabjBNdHVOZjZJLzNEbnNB?=
 =?utf-8?B?OHdud1JsU1FYTUJtY1hmS2MycVNDTjl3TTAzby8waUVIcWhtU09ROXdsVnFK?=
 =?utf-8?B?NlJDTWl1NGNjbTQ0ZEozZStnUlJjQjR3ajBPTjhzbXlCR3I3ejRCd0dnNk81?=
 =?utf-8?B?UjJ1c3RJUGN5WkJneTYwZkZXaXhaK1VNVFJzWGhNOEdxZ3AvV3JzMkJkd1hN?=
 =?utf-8?B?Z29iRnZrWlJqenlkaC9uRlM4ZzJaMmt5UE1ERjgySm1zeExBZUVTTURtZzUw?=
 =?utf-8?B?QURDNmtpcjJGSWRobTFSY1dISnRSN1RwM1AvSlVsUlY1cS9pUlpZRmpYOS9H?=
 =?utf-8?B?dmlhT3BWUnllVndQblNRR3U3cDEvRDR0THMrTUVYUG8zcDBqSW10eXRWaEtw?=
 =?utf-8?B?OUJVVWUyVkNZdlhENUE4a1JabkY1bXhpRTV5bHNpRDdqd0dTam0vRGU2R255?=
 =?utf-8?B?bXZweHNZbzhMd0ZrWklnTkNvVDFGVjlPR0xCNG4yUTBaSUU0bHNHcTZLQ2Zo?=
 =?utf-8?B?NW5NRUZ4ZDRBM0VjVXdsbEJjRnFOaEIrR2tUZ0dseWZIN3VRNHdKRHZpdXZK?=
 =?utf-8?B?elh0TFBTTHBqODdnMUpOMVFjVXM3RUpiS2x4WHJXWFBySXFaVHlzSGRNNk16?=
 =?utf-8?B?bms0QzRmdWxRbXVGN0N3L3hEWm5RaHZKemxOakZzeXVrNVN3RnNmUWNuTUI1?=
 =?utf-8?B?ZGNwbEFSRU9ES3FuUFBlcUs2OUJkUnAvNFBwbXhRU3dDajJDN1dvV2t1eWNS?=
 =?utf-8?B?Y29QL2pRYk90VVY0ZGpZWmYzNG51YTFoR0NqdnRlSTlFMnptZDZNKzVEU2t4?=
 =?utf-8?B?dThkVTVscnA3TzVpSXZvZVBkUGpqSVpkeStBcVpqbVdUbnBPcU5wUnVUaGNa?=
 =?utf-8?B?aHRvSHl4WEh3a1J5bDlHZjl0d1FVWEI2NnN4RktzSmVMalZzeFN0Sk52eHAy?=
 =?utf-8?B?cXlQM0JpZ0VvQnlwa3l0TGs4cjFYSGgzK01vL2dMemJ3cldROFA1T2ZWN1FB?=
 =?utf-8?B?K3RoN0VidTBGaFNsckVhMXF4NTRReVJQamRKMVc1REtSeWVCN1V0cWJVc1JP?=
 =?utf-8?B?Rlo0Umhmc25lbGNyelZCU3lxVWw1cGtESEtWU3RFcE5ENTluaTF4bnowS05G?=
 =?utf-8?Q?5DcBeNyy3IQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEtvWE05ZlZCb2hFV0doUDZJVHNUOHBpaEpMUUE3ZWtjbVFqd0J5c0taV3la?=
 =?utf-8?B?blIra3RNdVhpbGxRUFlHcWdqUXBoNnQ2aGVjLzhHbm1Gdkdja1h2Tkt1VzhI?=
 =?utf-8?B?YmhaWTJrdzJ4TTArbXFNMjY3VHNPZUdPVjVnMDlneng2cUpRQm4vcEpZSVBs?=
 =?utf-8?B?Z0xIQlErdCsvbStURStqZi9VN0k5NHJMQTRDSW9YMHFxTlMxY1BBMUgveS9M?=
 =?utf-8?B?RFNMZ0NydjFpbE1QSFBCWnVmYnFwbEY0RHoydDhKSFVKODF0WGZnQ3JISURO?=
 =?utf-8?B?aWFwa01iNUxMVWtOTFEyYnRzdm5iQitJbXRNNVNjd2VrK2FPZXNnVnpGRkJX?=
 =?utf-8?B?QzlhUlFUT0gyc2w0OG8xSmRXUE9PK29jUXlWRmV0b0YwdEoxQU1jUDNyUExm?=
 =?utf-8?B?QkVwKzJ4SmlvaW1jeXBGNytVNXRNanlwbjBub1hJVVNGcGlhdXVZNXM3RE4x?=
 =?utf-8?B?RkZSK0I2RkpvcnhiWGFwTFIrUVpGUDY0OGRMMHE1Y3FUKzZTNk5oQlRQQm0w?=
 =?utf-8?B?MzlVem9KRU16VWtBRFk2Wk0yeGpremdiYkhmNmFpVU9ibTVySXlpM1JCSnls?=
 =?utf-8?B?VXJ4aHhENTg5NzNmVlExWFZCa2trMDB3RXVEQjcwTG1ZTGx5M0NJWURlaSts?=
 =?utf-8?B?cEJIMXp0akdPLzJteHh0Y3NhT3Jiai9zcXZZbnRqUnJpdklKa2xOMVhKVzBZ?=
 =?utf-8?B?R0VQY2xHWW1JUnV4ZTc3UjZZVHBXQXFVeFhQMzBDS2VoWnNlSWN4NTJQU0dQ?=
 =?utf-8?B?NXRya1NwMEFSOE5LM2VLSGdZZTNtR2VrUStpdTJhb2d1Y3phNytnR1dFZjNU?=
 =?utf-8?B?dGJURFpjN0poYzc1TjU0Vkk4cU1ENnIveGc4SVpRblFRQy9ZbzFsbS9SNFhI?=
 =?utf-8?B?dHdNR3gvM2crZVJ1OUtJQXhMWVlIazY1T2QvbkNDRzNDUnpuN3JvbWxobW9Q?=
 =?utf-8?B?QXpPbEpnaHZZRmRxOExpWmk5eW9UNzNFa3BBZStIS1dCWGh1SFZUb0dLWFFv?=
 =?utf-8?B?VkNpbCtja0xCQkt4OE9TcmdVZzJpY2ZhMzdacjZHV1AxbWJXbUprcUZ3UXBF?=
 =?utf-8?B?MDg4WXh5UWNmMDFVc215Z2xCdWtKMUt5TktGUStqUnJML1Z0R2JuQnRBUmJn?=
 =?utf-8?B?Uk05OC9SeFpiVG9SelMvWlNhTGVFNDJtTzlyeExJTzA0d1VFUmZzWEpqYzFR?=
 =?utf-8?B?cTM2akhmeTNsUTVDVnppSEFJeUI0dTlieEZjTGlnbVFOdk4wZ1FKUWpNcDgz?=
 =?utf-8?B?bWRnamtOam9YNFhiMzZmSzI1VXZYL3Z4cEJJNllCL0xFelRWWTM3TzZMV0o0?=
 =?utf-8?B?WUVoZTZka2RTUlNqb1FJb3JBRnJ2aUkyS3pnV1N5U3dMRWJIVVJzdzluSk9q?=
 =?utf-8?B?SzFWZWJrbVFmaW55L2JwU1RnakFLWU9sVXBsck04SUQ0QkhybTZyTjBmR1ds?=
 =?utf-8?B?OW9Ud0VxbXBJMytmbk9wdk02TEhaaVBkNUUrc3krdGxncnJUajR3dnA0SHhp?=
 =?utf-8?B?M2dRSkJqQ2xiMFFwcmduSlUzaWpQUnY3OW1KM1M0NVE5c1VQMENIV25sa3Q5?=
 =?utf-8?B?TXlGUGhYR3lFNS8rbFczcjV2Z28xbzExK1Q0L1Boa0NoaEtKMUlYL0V3M3Iv?=
 =?utf-8?B?M2RiWjVGU2xObSs0MmJ4UFRBQXhPYm5jcUloTHhKN3pBWk9TMCsxNDh3K0Nn?=
 =?utf-8?B?MDhDQldYVkNvWExUR3pKOUtvckVweDJEQ29DdUJpd3FRTzRSb1Rpam1zYVBT?=
 =?utf-8?B?alZZckFCbUNaTHBkdUF3VFF6algxa2o3ZWFVYkZMaElBOU1ad0xjbVZZRGFT?=
 =?utf-8?B?YWFDazU3RGJCdElpZGdxR29MNC9xUFMxN1NnK0F6eTk5UGk2OXl2ejhhcjZE?=
 =?utf-8?B?MmlGVWlrZW5BaUtDR3NhUDl4S2RETDZMSXFoUHJQQlhhQmF5V0Nnelh0REJO?=
 =?utf-8?B?MEhOMk10S2ZVU1Zma3Vqenk5WE1pdlhMZFF3OTJhRWw4Y20zRk41QXYyd2JG?=
 =?utf-8?B?dXpQS05rOE1uaFZFcnR6TG95UTU4eHZCelYxLzZDMnRRVlBvTForUEhQM09P?=
 =?utf-8?B?azdGSk05alI2UXBRdEdHRTNXT05YQVhSRVJ5TGJRSUN0dTI5MUZYYzU5NXhh?=
 =?utf-8?Q?/0wAXe8k5xiUxBOokHSGHddf9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533f7542-40df-43e5-5036-08dd8625a4e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:23:59.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksDBYYfTZ5cRNMFlxCD0Ah2sQPMHdFqu2u+R+OkRWYlaTTMGP7cE0MLV38vficdiZsVv0QH+MyzS/Rte6K+K6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8640

On 26.04.25 04:47, Haiyang He wrote:
> The Cobalt kernel does not provide support for xenomai.cpufreq.
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  doc/asciidoc/MIGRATION.adoc | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
> index 8dc7c7a13..6f6800754 100644
> --- a/doc/asciidoc/MIGRATION.adoc
> +++ b/doc/asciidoc/MIGRATION.adoc
> @@ -75,7 +75,6 @@ System parameters renamed::
>  
>  * xeno_hal.supported_cpus -> xenomai.supported_cpus
>  * xeno_hal.disable -> xenomai.state=disabled
> -* xeno_hal.cpufreq -> xenomai.cpufreq
>  * xeno_nucleus.watchdog_timeout -> xenomai.watchdog_timeout
>  * xeno_nucleus.xenomai_gid -> xenomai.allowed_group
>  * xeno_nucleus.sysheap_size -> xenomai.sysheap_size

Indeed - this was removed (d66749ee2671eadeb2e53d629a4d104364315c35)
even before adding it here (998eb244b8ab0f8be54e71e93014c063e90eeb00).

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

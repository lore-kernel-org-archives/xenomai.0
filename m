Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36921EABA2
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625950; cv=fail; b=c5xNrVtTv8S1+yPgf9LVEUBSddY7S/SLK99Xtkc6YutUTCO1iuIah2Fe71Hr79DMW/2pu/vxcw08KamoC6lH8mxDQRtk1KhEMmWBrbIyXc18WR7L8aSIJoP9lw4oDJDL+GKhfEduz+uOOTvRsXSOd3FtLLkmmRtvmuRvrbP+SKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625950; c=relaxed/simple;
	bh=Fj2hL2A2xHVdr2DjgSaN5QNNvST5Vsvl+pbOXisGZ38=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBge60A8hrul0+NQ9XyXMfyiD3eFz4FwMcRPaLAyR9VtS4bXtkM4PHDGeqHxrJ5CayPUNwLOCaNFB/t1luwIurFMIvgD6vYq5P88Y2GesysupNQRbbXy4FM3nHDPee4M+HxXKGUvWRiFKN4Hzr3ouCXA9yNqHqlJ/9uypfreCI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y+VMhEKc; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y+VMhEKc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvdrIu0g+xqab+IWkO+vPFgenyOx+UqHhDoOat+xYiOVbREUfkFtvZTO+hAVXAPginHl9y0PiHo6SB+nrgI0USLZMRpz1rYAZ1Irx5XodGOxRGpMLstybHsrL9Zbzhzm23v2aVnO6t9WhlvY5jDY2u53FoI2jDWF/ZKU0QmgWvJNhhsO9rH8WG86tOaeWpf9PUlw9wg2pZWN7xbWb/1Ks5dB29gvotIY2AA479fc5Y6bKzMxphrdEYWiz91swHruBMFv5K9JEyn9WXgD+OKeH92mFnpO4SQjnZdCfIYIqwyHvsQTQkY5V4OBoQsi209KzjpNUwk0hGBhRFp3NLRbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4gOwiU0IywPrQ7ze2JQ1S8X3wsN1SPMhXGZx9sT7pY=;
 b=no2kOAqIuQRxVAKV6JNmT6HzExNG3k45u2tbbJMkS8qmXDjL/LZRtZTGOzsyTeYraL5hLAV262xCyS5RbrpyNWn8FFsgQAaaUEVbBjs0Jgxddg9G3LtAsKjz5F1WQJVsNxtoRFJwqh7fPqj641Ii/RomQ3ObTJPtbsc8K8LkGkh2oyiGTouHHj0a404gvZSa8Kbr6K7aQjS3GvzdRHaAv6U6B6AzxI+HPA4ss5kaqThbU7PqMpBQOYJ3JtzmDn987jasTenEnqPIqyQ/pTpxA7xonJrZYvFC/vY8bAAplnWLwXQ5AmjUuAE/PWJDN21crGjS+F0+XOE2CWqcKVRDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4gOwiU0IywPrQ7ze2JQ1S8X3wsN1SPMhXGZx9sT7pY=;
 b=y+VMhEKcsiFHISfkRkZdwrdbRWcfszGcsrcXkoBTWF0djLQfZgcgnnBtIx7LvMAOSf+3/QXTTn1vD79KysvWEo7/SfL7KiflyPq/qgxfy7oqWQ8RIhru5BdpKHAXAVz95sWTjvFXuIjnLUdyahboc7NBIqkRURt2E/BsWEweo7026HBm9qFJGxovC8yj8/Y5ZdZwhJveq2vCC72BNYGPUmNnIueju+JngnlvfwW6hKTNkSPgTZAowKsSy1whkx1hh8DMwJDeWQeI9JwxEKgAU0wIjshlQdWPVVKzmydzfqZfL5nHRTZ20CB6LaQpCO177R1btp9IxjWsUMvcJ8LdFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 05:52:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 05:52:23 +0000
Message-ID: <0b6c56a6-40a2-46aa-9701-8688207591c9@siemens.com>
Date: Fri, 11 Oct 2024 07:52:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Preparations for Debian 13 / Trixie
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 369c7164-cb88-4119-8100-08dce9b8e071
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHE2cXBreGlhYmljMEROTnBEejRLL2lpTXp5RFIvMlQwWVV5VkZhZklYT1ZM?=
 =?utf-8?B?OVZPWmhkRGJiaEhuclhPUDN6YWNEODFLMFFscDRnVUxlUnl0NVorUzMyT3pp?=
 =?utf-8?B?a3NMcWh4S3IrU01lblNHMENNd2FTVUJCKytBNTdGNjRvV0VQM3JmUUVOdGtt?=
 =?utf-8?B?ZkZaeFdNVXRpcFBlM1RlWUtHY09RcTVaR1VFV3VVb3E5YkxWdGo2SnlHRGt6?=
 =?utf-8?B?K1g4VmdNZHVnQmdvZXVFSVRoWFdMcFBRVGdEM3NFV1dyclRZWmJQRnFDTlZ2?=
 =?utf-8?B?RHNmMlFCUEM2aC9NemI2ZXVMRm92RmxRNGNQNGxVMGJGQUJ3U2VRK3RGSnV2?=
 =?utf-8?B?d0k3aElTYnNUekNONWRSZFBYMGVQRjROQ2ZhRWpLNkJkWWlxaEgzWkNFa0dB?=
 =?utf-8?B?SE9mT2h3cTZ4K0NOajBUdk85S1pqNEFSK1BRcFQwTkp2bitQNG1ad2h6UkJu?=
 =?utf-8?B?MVhXOW1seGZiSzM0YXl3SnhFYXlOU0VDb1MzcndLd2h3elA0ZDI5Z0o1MkZY?=
 =?utf-8?B?VitUYkN1dFVCc3NuNUVUbGltMXNwUmNxSUdRL3pHK1dyOE9GTlJYenJBSktl?=
 =?utf-8?B?YkRVelYvcDliQ0JKOXBqZGdFOEtmZGNrbExkbVV5WEg3WFJINXBqdGk4QTNw?=
 =?utf-8?B?bWx5c3ovT25DOWpNSTJmS3lVZFdIVTA1K2lLWkF3OGJiUElaK212ZVJJY2Ri?=
 =?utf-8?B?VTJNbW94NWdxWHZwUXZYT0lZb2JobHcyWU1TMTBtdVo0OEVXNXBaWFlneURa?=
 =?utf-8?B?a2huazhKK3ArcWsyd0pINnA2NHYxMm50THlVSnQvQ0JXUzZtaXMvRk5VdlBF?=
 =?utf-8?B?L3hVYTZYbkhRUms0SXhZWEdobEJyODBsWVp0ZmxEL3o4MFRMcVBEMHBEbkhs?=
 =?utf-8?B?cjVCOXREbnloSVFQTGt2MjN4bjV1SUM1b1YrK3VJZnBBYTFucTFDQjFpYXdX?=
 =?utf-8?B?WXF0eDRHb210Tk5WN2ZIR1Q0NzIvaXJmSGhqYVRxS1BoYVA4SGE1YXVleWpQ?=
 =?utf-8?B?Z1FjVTZGQVdSWnZlUElSWHNjNVpFbEwzeWRkbXg4T01SWFBONU1oM0FmdmtK?=
 =?utf-8?B?d1hzcG9Pdk1INnVrZ3A3UmZ3OUhIdWxDY05EZ3Z6OW9PS2ZwSlpHSzdkSmYy?=
 =?utf-8?B?c01hZ1FQbzF5d0VuODZDMW1iUHJlUnFBV1lqcW9NY1AvN0lMT1dQVnhteWlO?=
 =?utf-8?B?SGdJSjFHc3FGY2xkaUt3SktVWW1CQmdOREd1OTIvUEJ0SGZ2dHE0MnBlTjNK?=
 =?utf-8?B?RHl3bDlZcXEza1VTa2NjdnRyd2lMQXl3N29QQlVOWkJIcTJqYnBwRXNWbzZF?=
 =?utf-8?B?UEwvd09MaXVlNSt1RnVxVnVkd2hOY1QwWXE2YzVNNmhuVHBzWlY1VjZ0aWNx?=
 =?utf-8?B?NjgwWU53UVozQ0FGV1lnTmtSR01XT0ZOKzhtTmxwZk13b3pSUzV1YTJTRVhZ?=
 =?utf-8?B?amhXSUU2ZlVIYWFrNHVCZkR2M1FFNGgyL1I3S3ZtQmYvRWlXbk84Ym94dGNR?=
 =?utf-8?B?cWorTm5reEFIVjN1MEpQWTU4SnA3b3JsSmtMUDlMeHpYOUhaWEZ1dDJwWWtz?=
 =?utf-8?B?UEZCaFo0SkdHWS93RTFIdlBIYUg4TlArMmJIYWR4Y0V5clFSYzBhcUFIYmlR?=
 =?utf-8?B?SGZoUzRHcTQwRkhGTVNiTVpiTDZEWmdlVGFkZDR1NDFDNEpuUlN0WFFnS2Q2?=
 =?utf-8?B?bGxUSWl2MDZHSVBCYkdYbEJyVGd4SVF3NDFZUkF2ODdzYjBoOTJURm1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU8rMlc3a3ZCWEpiK2s4T2p4SEd4Vmk1SGNIZ1A3MVQvVEtBdExkUXo0cFc3?=
 =?utf-8?B?VE5XMUNNT0dORmd5T3I5ODJ5M1IyNnljQmxpOWVVUWptcTRucXhtSUtRZ2xI?=
 =?utf-8?B?Zm5OUGNVL3pCaklsSUJqY1pUak43SjhtYUZuUVgyY2RHSW5Cam5kRVpNMFlx?=
 =?utf-8?B?ZUl6dVNpYlhsSWhCVnpvc0E0R3N5RHovbmJ4d25wNEtwaFYxWi8yYXh6aHI0?=
 =?utf-8?B?cFJxVVNRUnBsc2VMNkRSREh2S0wvSm5Tb3BJbEZkTC9DRWNHVnNLdEhjaDJC?=
 =?utf-8?B?WEdvZ1Q1Rit0VFZiNUdWa3hJejNaT1Bxd1F4V1dXZFc4QXZpbHovQndCRkZ6?=
 =?utf-8?B?T29QaHdsM1FqZzZWbXhqS2R4b2s0NDM5L3VwNGVMbEFGRGcxRjVHSTdjYk93?=
 =?utf-8?B?SzcyUFY0Wk9DVU9ueUZ2b3dTZlM1TFJtR1M0bGZZNWFtRHhvSFI5R0VERHdG?=
 =?utf-8?B?cUpiU2pvWHlpTnVna050b0U0bklhSzVmZFcxRHB1aW5OY0c4dUlURnZsSTg4?=
 =?utf-8?B?azVxYWF6WlFZL0FDTk56OWVZWExmbWRBT0NCNnpNdlAveFBwV3MzYTZiQWRk?=
 =?utf-8?B?WHA0K0NQdnMyeDBXdUdmRVI4T1hra3cwNUl5WmR5NWhnRWlBRTNiNDNXZy9r?=
 =?utf-8?B?NEdXdWVmQURZZHF4bVlQSy9oSFBvb0s2Z2piZTM3cVBxajNsbGtsMzJxMnNR?=
 =?utf-8?B?a1JOZkVmZFU2OWEyMS9rK3cxaUFrSjlvSG5sMDJTbVlZSXM3R2U2dm5JMlJV?=
 =?utf-8?B?b0IzOFhMQ3paZlUrK1hQYmFEWEVBbVlFVGhYVnhnRFVZcEdJU3E5eXVoclZq?=
 =?utf-8?B?bFNZSlptM2VLK1NlR2pIVmZzczdMYzJKcTAzN3ZjVnpZbFZBcktOSkYrMkJ3?=
 =?utf-8?B?V2hsdlJOWkh4c1g2ZEp4bmpiZlcwaFdPRGt3UEUrNHpQUjc4WWVERE1wNC9u?=
 =?utf-8?B?SnNLUmgzbGY2TU5xaFdaY2dnUXZsMHYyMmNCWE9KR1k3UkhzeFZxMWEvQzZU?=
 =?utf-8?B?Z3RVdVJ6WDFVR29JdTZJM2M4NWd1c0cyRzNkMWtnN3lZT05hZnVkbTh3d3VH?=
 =?utf-8?B?THBuY3hzeERwbUJqWkJ1SWcybzlYT2ZHQUc1QnEyT1d0Mmwzdy9IWVpXK0pS?=
 =?utf-8?B?aTBCd2s0c09jN0lRUnZMWXRkek9KNTFlNEU2a3JKZjFXRWVnZEdVWmxaWnhJ?=
 =?utf-8?B?MTQ4dGc5cXFEK2xIR3FjbEtTamVkSGkwOW5iclZzNlZHMVVuZVlkenpaWWJN?=
 =?utf-8?B?aE9vSnlJb3c0RzJpT1dKMUI0L2RPTHVRWW5FWkU5R2ttZ0p2ZjRWbG02Y0dj?=
 =?utf-8?B?N0s3SjJraXFLWGdMVkF3U0Y4ZEd0V21MVHhLKzNQVXJpdG5IWjlhVUhZN1FJ?=
 =?utf-8?B?RmZiNWsvNWZ4TmZjMWdDdEV5aExidnVqaTQ0OFNCUUhiejV1MDFLKzl1Y0Vn?=
 =?utf-8?B?TUJ2ZU5uT0dIM3N1YXQ0TXUwem1zUS9iM2FvdmdHS2xTZTJzS1VwYXZBOVh5?=
 =?utf-8?B?VWZVZlk5NHVqTU9VcEl6bklGZEZZUDdheFRyMnV2MTU5MkdiMm1vN3ZWVVI4?=
 =?utf-8?B?eHNrbkJaQlZBWlhBTlFzbEc0MUYrRVlUL05XcWtDRGlCLzc4RjlMSjVGckdV?=
 =?utf-8?B?VWpxb29ucmh6aGNrdnozZXEvYW1SZTR1Q25NeUVhU2xQcEE0VllQSzkyMHdt?=
 =?utf-8?B?VGZ4MVhXTjJwUnZuMDdqREdxT3g1aUYvRlcyaE1tQ3owakoxZjRDcHlBK09Q?=
 =?utf-8?B?WU1JTTA4Qy9MSTZNakZTSWIya3dvcGZpd1U2QldQaEVKVDJja1FnUlFCODJ1?=
 =?utf-8?B?eHNzMVVOZmhxL1ZFY3hmbnZsMFN6aDBTWmdvZkMxRXlSMkpNdHo5ZnBMSHZo?=
 =?utf-8?B?TVUwS25CVTFrUG9vekZPT05LbGg4NlVuemtrR0V3OUx2UWlzMW55OTJZd3Np?=
 =?utf-8?B?eUJORzNRT1NRd0ZPbE9pMWxZb0p1SGthUmRUV2c4d21hYVIvVHllMnhXYnoz?=
 =?utf-8?B?WFErekh4MjJMVW5jOExSei93RFdQcVBJa1ZxZlpycnRMZEttSVF0Ky9JRUhn?=
 =?utf-8?B?dTFJWHJENnVteXlJQWhKb1BRN3NIVEZ4d0hmSnNvblc5UWladzliQjA2TkNO?=
 =?utf-8?Q?QN+KZKmS7BQjmwl6U5LCNo3lT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369c7164-cb88-4119-8100-08dce9b8e071
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 05:52:22.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quucwChOHIBZkCNmx9lPdkBqif0mf96cB5TxdSMWtss7edBjfX5KBUPZAwPGiUgkjXsljKAElUE0MA81QnLrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7041

On 11.10.24 00:30, Florian Bezdeka wrote:
> Hi all,
> 
> as we are already in the preparation phase for a new release I took the
> task to clarify that the upcoming release is in a good shape regarding
> the upcoming Debian 13 next year.
> 
> As it turned out a couple of minor issues had to be addressed to make
> the upcoming release ready for glibc and compilers shipped by Debian 13.
> 
> The y2038 implementation needs a couple of fixes due to changes made in
> glibc. For some reason they decided to change __USE_TIME_BITS64 macro.
> The commit that introduced the change is linked in the following
> patches.
> 
> Testing on Debian 13 was done manually so far, Debian 12 was covered by
> internal CI runs.
> 
> Best regards,
> Florian
> 
> Cc: Jan Kisza <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Seems it's too late for configuring b4 correctly... Lost one patch...
> - Link to v1: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com
> 
> ---
> Florian Bezdeka (4):
>       y2038: lib/cobalt: select: Fix compile failure observed on Debian 13
>       y2038: lib/cobalt: Fix link failure observed on Debian 13
>       y2038: lib/cobalt: vdso: Fix runtime error detected on Debian 13
>       y2038: testsuite/clocktest: Fix link compile error observed on Debian 13
> 
>  configure.ac                                   | 3 ++-
>  include/cobalt/wrappers.h                      | 3 ++-
>  lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
>  lib/cobalt/select.c                            | 7 ++++++-
>  testsuite/clocktest/clocktest.c                | 2 +-
>  5 files changed, 12 insertions(+), 5 deletions(-)
> ---
> base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
> change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a
> 
> Best regards,

Thanks for addressing this. Just one question: Are there specific
reasons to use different conditions for these different fixes? Can't we
use the same across them all, to make things clearer?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C714BF92
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487910; cv=fail; b=rO/fPwaZIp69WESsbFqEb9WXVme/TaIBbVeUDVCwWRKkO28jrOyUNBRVdja3jvLLmvi/RFASE7DDrBo3wJ/ppRfbMjKnXNHShSIt3UF7gnXDmMfQGE2d4/8PMAZ+ISvb7sy0Oz+5iLtJ5GNUStcKcJrGbJR3t3e5mHgRI+QY2jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487910; c=relaxed/simple;
	bh=F/APWRN7bDEZmPJPheG1orYUC03ftCPNh73J+GuCxYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpUkkl4K8+OPq9qdLf9AVO8Coq1IBQuzQ1gGFzwmSJQeFVjbeAfvbH/d3kyGhgzjHCBUguSD9UyLxSNNHThTNhYahZwCqV0MKh/q5MP50Pelfa9AJltMeINtvuiQPZAFsJrURnefPkKuZNM/QWY/Sy2j9YRzCfYV5Th097taCSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jct+vsI9; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jct+vsI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Byuq2NkiYYdAcJWXtqXk0Ak9+cbhkyrp38LHYv4YZ6zalHmVg06hR/rAsn55WPB4141wBUWkU+XHYgkqQujkg+BTcqdKR2WEiNYsyxxKTXjDr38qtIgKOCaTfEnPzs43Rt5PUAWUCt/jdNJ13wV6Y/gIWjymmBIAMIThhnmut5PnB+yguPvy+TNk+XahBvUKVXhLKQyhidvEBs9qutEEI/BbmzAJwOGxl54XA5jYY2glyPGWIke7JgPV885YW/Q/wPrY73ipZqZ3SPl4xhIePc9Rx2LmGfe231XQ6aRdmbXs9AJ4EfTwFF4aB06CghdypjLmYMBKQ6gy1e2X9Ps6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt0n2hyHmTQSJE3KIf13O55IZGeBZ/uviOg+6K2w0g8=;
 b=nNjiOroalFTzIRYZywqIo9mNihKi74Be9bdudxjWiOwAVON+nvY7YaRkRFMk+l7JkxohiCcvRHn0Mg6Ndf24uPvg/ZzbcH3VoO0sQAKs5jwf/QpgrWBh6vmH2qnVv8YxETH62D8A1C/CzvmGlTjGJdzwOX3F91EcuW7lp7ltSYtya5C87GATrwQwOSoc9xcY53RmBiUlHFvK/5a5hiU1k54ZIaHiodOXY/Pu+47cZ2AIGzz7jyn0Z4CJoNrN9BvdSpGV2koc14pHInXIsLQvsemcJv/c2Av2GSGksKbqFttnr2Qo9nm14XRuGp7gojXHylDD8rsTCiGrglN9pZSIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt0n2hyHmTQSJE3KIf13O55IZGeBZ/uviOg+6K2w0g8=;
 b=jct+vsI98H+nx3NojzXlfJzJTT57GZvuCiuOUjgwSnIti3hGUyLHH3qr2QVbchugQkidM/6S6eZ4ooVnZ8YRZU4TnHACiE7htWqqIZ4FkAbB+o4hDKDMSrJ0+F2SZpVao6ZUgZszSRHA51y8wootRYfLgttzeRKnWFyomSp8qokSKKEmv6OsO6Gyvs/6vDSmEKg3NUnQ64kfQMa4c7XxXVc5BH/cDnqScy0vvtey3hFlWkNaNT3PCP5DQAOMOiPSm6kj5ccXZY4pvM726b8Ea6F8r2KiBDAPIhLOtiD7f1WmOVZaFiC2dZS6JgO2347G/d5/TX/bQrnILMHycXg3TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:31:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:31:44 +0000
Message-ID: <666208c4-8548-4863-89b5-b667ae0353c8@siemens.com>
Date: Thu, 27 Jun 2024 13:31:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Clean up generated syscall_entries.h file
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at
References: <20240626192625.14745-1-richard@nod.at>
 <4209190.8TcEBkooeH@somecomputer>
 <33dbafe0-3da7-4065-bfa5-0fc7fe4432bf@siemens.com>
 <3081086.VqyquhjGfd@somecomputer>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3081086.VqyquhjGfd@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 701ca337-f7e4-4427-af1a-08dc969cb93f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z21IYzRqZnJYME00RWEvWHRIb0I0ZkVSYmcwa2FzWXJ2d1RkcWFQaVR2KzlU?=
 =?utf-8?B?UExoL296NWZLSVVWLytVRUs5VHBOc1lqdUJYRXdFd3JPZ2JIUFM1TElOZFps?=
 =?utf-8?B?aVgwR2p6eVJYaW1tZEpTSFAvS0pOcE96eFMyZUw1KytjbUNOZ1poSmZVUGFQ?=
 =?utf-8?B?RkZiZEN4bW51QzFkalV0S3J2eFJ2Ry9uK3lOdDVHK2gvUG5KcG5qdlNnUnd6?=
 =?utf-8?B?OHV4dy9QOVphVDhMTjUxS0hweTQwTkcybWsxYTdXdGVXZFVzK3pmd1VpdmR1?=
 =?utf-8?B?WFh1TmdvSGE4VHBZVUdkaTN2THd6WWJubEVkSkJyQVNjdm5hWVJ3V2xQOE4x?=
 =?utf-8?B?cWJMRngxdWFISE9ZVVAzVjdENFlLS2VmN2Rza1Y3T3RzdzV0MTY1bjlNNC8v?=
 =?utf-8?B?TWdzakhmUGlSWFBUbS9FdkNZSlhsSUpnZCtXZU96T1o5WGFsQ1FlVHBNYi9v?=
 =?utf-8?B?TU5mZlZzQlkzalJ6SEFaVFNEVDM0NndrR3FadVdhZitaYW9vRmJhN2VPM3BS?=
 =?utf-8?B?OFdZWEh2KzJYUGdHZnJkK2FVbFZ2MnozS25ZaStLbzVrOXZvakwvbEtCeUNv?=
 =?utf-8?B?UHJKeXFBNTFMNlg5Tk81d3JJSS9Kam5QaG9NMXdvMzNJTTRoZXI5cCtkRTlF?=
 =?utf-8?B?elhiTFRYOGhPdC9jeXo2eXh0dm56KytyR1Rrb3c4NHExR2cyWlpUVXpIRnZa?=
 =?utf-8?B?OTA1VTZLbTFPbkhYdzJkQ2pyZGFSZkt6WmZIVGo5d25QSDNlcWs1RjkwWkx2?=
 =?utf-8?B?K2xYbmhwa25xYkJVNDhmcWozY0ljeG1qUHVVQ3B1QXNYZFc2Ui8xMUZVKzZG?=
 =?utf-8?B?UjAxcDNVeVNTQ3BQQkZaOTR3cHhRdm5pRG1RTXBxQ1FHQW0yU3NyUVR6Z0Vz?=
 =?utf-8?B?TzA5SlZtQndsWTh6SGxaS3k1c2dKRktZdkxzbkQwbG9nVjFvQXVWMGNvbGtl?=
 =?utf-8?B?ZUptWExqdE42S1RsL0JHWFN6UURPdzhPOVp1Y2tOdGlSYklpQzNYYURZWmtQ?=
 =?utf-8?B?SlZSd0FISkpycW9LSnFGR01tWk1DQkhQNFZZVy9pc0lEVURiWDd0WVRhWGdS?=
 =?utf-8?B?bXl0WDdnNklFcHMzdVIva2lHSy9CQU5UVW5SWWZjem9UYjhqQU1ZWEt1TDZh?=
 =?utf-8?B?bTY3cVErMDJJOHNtRWQvbHoyQmk5SmRwQmNjWnc3TjQ2ak5iM0dUQkMrQ0o5?=
 =?utf-8?B?eW9qeld1RWlZb1JPVkdLbWlCK0tUdVFBbzZ4dk1nQ3E1UUxsd2pERnNydUxY?=
 =?utf-8?B?Z2R6cjd3a0FmU2FBbDNTMHJUeFNoaEhNUXhZOVpNOEZmVXNjMHc0aFdXdysz?=
 =?utf-8?B?STdvaFhNT3AvdW1tODBYZ2JnQThBZ3I3d2R4UkxMU1ZRQzhlQjdxR2NoV28v?=
 =?utf-8?B?cFFpYjNsN3ZBaG9JS2VhMjhSU2oyYnhVZU9RRkp1a0k5SzJkVGx1Ukw4cGlS?=
 =?utf-8?B?bHVtTkVFdllyVWgzaHBYZHBCSUVCV1RVOXN2SHNOVENndVJlYXZva1N2cXFW?=
 =?utf-8?B?VTNrUkhhK3VQb0pNcHpoMnF1ODRhd0R3UEwxRENhQlJCRzl6YUhVVWRlYytW?=
 =?utf-8?B?bzlKR3ZtcmtxSmZZRUl5UENTNkVOQ0ZxWVo3b1JsWWh1UlRBbENBY3d5TWtu?=
 =?utf-8?B?aDhsSEtVUUNjYlhEZDhxaC9qRlJieHBmdVIva0JzRFZKVnVOQVRFWjV1SCtw?=
 =?utf-8?B?ZzFjY2JwdHVkYWI2dWphdnkyYjR1TzlYYlhxSjY1RWdnMWpJTWt4NFFZN0RS?=
 =?utf-8?B?STk5UkhQSi9jN0crdHVDYlFOZ2ZMQ1NmbFhTME5icHp0MFY0aVFUR09zMlh2?=
 =?utf-8?B?bXhCdVlNZlUzL2tJbUEyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmVKSGNpSFhoRm11bGJ1YzFpbU9yZU1vS21kYkFTTjlyRm1oR2VLVWk1dVI0?=
 =?utf-8?B?amdNLy9Mb2RKSSt3cGRFS2VjTFIwUTVkdVFOTEM1V0Y2T3NEVFNhM1FzRUNj?=
 =?utf-8?B?dGY2ejhObTRjTGZseHZ5T3BBQU9wRUxKOFk3Uk91VVp0QUlpQ2k4ak9iUklN?=
 =?utf-8?B?RlY0NndJVmk1TjBTVVc4VU1DUGFXb3U1RWlQbDI3bzdMRWE5Q3FGSmxFUXNV?=
 =?utf-8?B?eC9tOWo4Um8wSmRmZzF2ZDQyMVZZTFdNWkFwV2pmU1QzT1ZYVDBxZkpjM3B5?=
 =?utf-8?B?S29lNHlIeVVsSDdFSjduZExqdmhkSVpNS3duOGRnNkhiN0x1MXdjRDhpRlhC?=
 =?utf-8?B?TkJxOWNRdXpnSDBvNGFYeHVXQ251dVpmVUdkUDZRNkk0UjJNaVdDRWtXUTZt?=
 =?utf-8?B?NE9BZXJzN3hDaDF6QjVtTGFXYkFtQVcvaXdUTlpFZ1g1d3g5Wmd2WkNFRFd4?=
 =?utf-8?B?ZDVEaEY2S0VsMk54OUtIV1pyVnlFODRob0ZrWmc5UlBrbm9QTEQ4Si9paDFK?=
 =?utf-8?B?OXZvbXZCVitEY3B3M2NZQ1dBN0dYZVJBdEJMNUVJbjhadG9BRkFrTCtwNVZ5?=
 =?utf-8?B?RzRBekw1TmxlYWZSUXR0bFJCand6N0N6bXF0MFJDNU12RExoZEYrZVh4N2sr?=
 =?utf-8?B?NDJwR3dKMVJSZVZRR1BaY0Y0ZTltVDhaRGNIb0UyZTRqakliNmxRdTMzSkNN?=
 =?utf-8?B?eXVTOWlpZHhtT1lIcUVpUmphYmxJeHl2TVY0MVJiZTFYNmpFRHZqOEtFeldQ?=
 =?utf-8?B?Q0hJb0YrMU9KYnF4UHgzVm9tQllnUzA3bmFhSkZFYUN1K0l0bGVTYk14Z2Ex?=
 =?utf-8?B?NkRPUEFjRFdBeG93WUVrbDFqTmUreWFwRFZ0cW14d2ZqbEdkQlArZWVKSVJt?=
 =?utf-8?B?SzIrYjMzcDRHRkxRdytKZDgrMG0zak5ZZ1VQbUxkNk9pTFRyVXdFaWtwT2xP?=
 =?utf-8?B?dFlTb3F4dms0eS8zYXZqbDNwa3ViYTBPczBkeEtXNXBaZElqNWdiRExZb2o4?=
 =?utf-8?B?SUMzWGhiTVJ1MjEwTVBnRTREZ3RpbE0vZkRVOGh1WmladmI2ZGFDR2RQNkxp?=
 =?utf-8?B?VGk3YlBrRDZMV0huNG84YW56WHVtV1NlOUpGWk9ueXJlMy9YWGZDWVcvQ0RV?=
 =?utf-8?B?NlhPRHhpc3NlMi95aFMvWTNPR3Bhd25lS3FaOE9CMDR6dVVZMk9zeGdhNnh1?=
 =?utf-8?B?YzIwTktDSTdNTzJtb2NBV1E3aHFTTEZRT085MEJ5RTRvV2c4UUs3SVFrQUcx?=
 =?utf-8?B?S3J0ZFpmMFZjT0pHbjg5MjRwbXRZenZmTnhVbWxMSnhDdDdQVHRNQUVYdUR5?=
 =?utf-8?B?WWxGY1ZxZFcybk1jWFUwdHRIeUFUaGJTTjFzV0ozQUJyeG5IVzdJdS9UYzdR?=
 =?utf-8?B?aHJ5d2d5Z0RwMTJsRzFUMm81WENieXI4M3hwYmxScXZ3SS9US2dXZjZBUFZK?=
 =?utf-8?B?TTNjV1RYN3l1aWY5N2tiYzJSN2RUdHQvUmx0L2lEL1hNSndmMTdZak5OY2tQ?=
 =?utf-8?B?cWFuZEEvUkR0OTFtblNrbFZ3cVJKRXlFdUNZdGdyWVA3QkNrQTVRTEJLMExj?=
 =?utf-8?B?b01DbmtqempRWnlmYmZ3THBHa0NoT0p3N2dEd0hIRndpYkhWSHVPZ2J3Y1V4?=
 =?utf-8?B?Ty9UUVhuWXFSRVFrMjg3eTcwSy9xaVRLTWlyYVNBcWtOdjFuRFpKUXdyNFV6?=
 =?utf-8?B?a21QYzRtc2h1SGlWemEzaWRXYUwrZmNxY3V6aVhNL1lVdyt0OXVQdTF5R3NC?=
 =?utf-8?B?SkRBWXhpMXVRUC9XNld5M09GdlFMSHlOeDVPd0ZvTjFqam9KYXJINFBxZlNl?=
 =?utf-8?B?V3YvcU9keldTU29POUZYTWVneE5nSHFGMHBLZ2ZVdTYzL2hQRlRoUE1lcVYz?=
 =?utf-8?B?YUcySjNrRDZ2eXNmUTlGRnU0anV6Nk5ZMFQ5TlZwaWYvSlJSSWM2WnZIOFVy?=
 =?utf-8?B?MVEwQ3AxdlQ2TE80U3VVa1N1eHVnSmhxdHhxN3NiSnJGWjFNN0VIUy9vUWZ2?=
 =?utf-8?B?N20xZjFETktVb3dhT3ZQTmJSRmNTSXZqL1lMOVdsMUwvaUcvWmE5bmhyVjRy?=
 =?utf-8?B?WUdyRm9Jc2E0SnVLclJFUGRWbU1WWVFQQ3V6WnhEeVpVMDFieXk0SXhIRDFF?=
 =?utf-8?Q?MJA3jUQoQx83j/E0u0eCJW7Gs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701ca337-f7e4-4427-af1a-08dc969cb93f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:31:44.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51/cxKOyPKOrrLMelXpCoSTvzJ2vNp412FkU0N8nBLVcL+qAW5aL86w2bmGzZzXrYFIkJMdUFNGNgkt5YJQ5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063

On 27.06.24 10:20, Richard Weinberger wrote:
> Am Donnerstag, 27. Juni 2024, 09:36:27 CEST schrieb Jan Kiszka:
>> "Any target that utilizes if_changed must be listed in $(targets),
>> otherwise the command line check will fail, and the target will
>> always be built."
> 
> Yes, but why is if_changed needed at all?
> syscall_entries is in the prerequisites list of $(obj)/syscall_entries.h.
>  

The reason is most likely (I wrote this 9 years ago...) that the list of
prerequisites is not static, rather containing a wildcard. If you add a
file with a syscall entry, this won't be detected, and no rebuild will
be done.

>> If you find a better pattern, that propose it - but test all the corner
>> cases of required as well as unneeded rebuilding first.
> 
> The diff in my last mail should fulfill all that.
> I removed if_changed and replaced it with cmd.
> 
> But let's stay on the safe side, I'll send a v2 for the syscall_entries.h
> file and do more testing wrt. if_changed/target.
> 

Ack.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D0302CC2
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996228; cv=fail; b=cJYj8e5Qcqt8sj+8eFEQgQbK5Qs49cUFeHB9u/Is64XxzX7ob1nKgnfydH3dD+Hg4SoEXQGpor9dnvi8f6/YUu/FfqPphw87UsNlM9MgSi8jGFeTmj5V1gZ1frMHsyLtiyao4o6f1rh4XefPWQw/9F0V0M2gkuORQZY5AcXsKfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996228; c=relaxed/simple;
	bh=HQTHcqrQsNKZpD5VOkBhckPgFpwjr6iz3/bof5v8oU8=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=hjRtrH0aKD3x3rR1RVp0t6+8CPPaqhSdc9cdcURLtbO47QJLl9lOcYcybBoxKgLj7f8F6SPP2Jt/upDTY4u1/PN062nZYwjNDScgHMiCZg/ATzvOF13KFb4zl/+qHvCcV1A1hKi/WcFekPjsc15HOgd8ys4f5RQFTKTNOnMbTPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=X6NOJ9yq; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="X6NOJ9yq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKZxj4+oS1lPbLRzfJVUuLBh1ZZXNTUxPEeBvF2rJNztfcnV2Ywm4A8CchxkiCtLpG8TMwBIgGt50qatvvh9nEAvxQ4kJXAzcKQrLOgLqMZI1JPzCcaY0QLDkTVdMcy/70KUmUEE71CquVIgd3ebjr5MF95Skp+8umGvK1wYmcefedKkcw6AlO16H2b+1f2FdN364I6URlHDTxbvqMHslIFOta/Pw2zAlxCWMTpmcBlEktbQ/aQJZcaNKjVROjkhDWFvFr0j08tmhqcyDlDVCi//w2rX4iLoGrDG+VJUZM4q2Uhhy49Da5nswQh9r0ZMf5WdtjQR2GGwRMhKrYfPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvvxqPMbGCHxYtr5mjZzBIqjAbxcxfaJvhqkD06XsCA=;
 b=DGFef5m58MCCP+Hm/ssCramlTlyteAldQ10aSGMYn1fTwgdTQOY/vnraQpzwvsYyayrvdvgt0s85kP2kdBwjShss8td+vLj0860UIzbGsTuWPn6p2PxL+wiP+qEOVojjyJCu9JSLUhnc2N6A4dM20BjejsA9wc9LskA7h0Dyy1QxndvFTIto54FRy5qfpe5PrmoVZDOq+4RsGpmsj2XilewqoCwA1OFwNWCTP79TA6aNFkzyz8i5421G4M5yY3eDcljgGEUWYNEkCL9A5CfvSgLuuMIBDKQ3DLvtTouHajFOI2uIXsrcWlFBDSNCtatZImImoNHSoa/O1PwK6Pbi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvvxqPMbGCHxYtr5mjZzBIqjAbxcxfaJvhqkD06XsCA=;
 b=X6NOJ9yqK8DzdKHe7g4h6WrSnfcC0G+j65ivDrHAU9pLnrKJ2GgUVOubUrQ/Z0gdbiCtLVECqtJD39jrKa4C5sHhjVNpShMOtRNB6gRbHlT+vkGOPtLCzgZsdeDV1cOTzFR2mU+/0ovvkx4iwhivngtw6J8k74n/hEGl6AHRPQTLpsPshmfPp1Ap30av47H4gd7v3KgphnjnfRBH3SOdgLGKFFGdLWRy4VIej/kI8cMCgsftxMgG28sJ4hwGFTfUxe7ZSTOI0v6Igfql/YQkCaTdsHbbr9ftDS2KWHYg2fLjn5ObvYPT2UyXnS8+B+07++JQcNkHwiMulRLT2L85Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:507::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:30:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 14:30:20 +0000
Message-ID: <380c9987-0577-4e9b-ab7f-4a3091645b3a@siemens.com>
Date: Thu, 4 Sep 2025 16:30:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v3] ci: check the device health
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:610:10e::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9ed056-268f-410f-4c05-08ddebbf9340
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmVtQkxkWXdxaW1IdEoyN21IUk1hOXE3N2RIME11LytadjVzY2FKcmhBbTF5?=
 =?utf-8?B?V0t4VzlpTWVvSUJJc3BwZW9XZm45SFFkeGxRdU4zQzBMbmJhbkx5Zm5Pa09l?=
 =?utf-8?B?ZTRGa0VwVkVPdElscHJOWUZrKzNEWGErdndZaWV3WG5SaDdPNGhUWldOcTdv?=
 =?utf-8?B?ek5QeXd6a0NDNFZHT0FqUmpJSE52SGtwOStkVXlwa1ZTd1l2c0tpN255L2NW?=
 =?utf-8?B?czdFTW5xcUQvY1hSSG9zUS9OTE5WS205c0t4d2VWb3VWQUk5cFFzWldjUm9q?=
 =?utf-8?B?OWRGbHd2a281ZVlicUZUV21ZaEwyMW1FY3ZZMG5NNWVEUng5VUZsTmMrN2hx?=
 =?utf-8?B?M01ncWNkOHF4QTdRNnUxa2NGSGVCSUNnWG02SVBBWlhRdm5NQ2lJNUxjZ092?=
 =?utf-8?B?WHllNEJNUGhOQXZTK1hHeEZ2Z1k1OTlYTVZ1SWwxVUxqMTVjV0ozSW5MOXpl?=
 =?utf-8?B?Zm1sdGt1b09Ld1lqN01pVkZPUXZXQXZCaStuN29FYTVkQ05qQ1BtNTBVVjRN?=
 =?utf-8?B?a0p1RElCdEhOcEhpRWxMaHhzOWtoV1dna3k4aGVVNDBtRnJrdTZ1b3l3ekpn?=
 =?utf-8?B?S3pNRHZpc0tIaFY0bkMyNmdxSWpzeGU2cGM4K0YwSXpwUy9mSW04OHJxOW1w?=
 =?utf-8?B?eTlqU0dGRy82ZStLZ0lDWWNObGNvR1lUTFh1QUE3SzRwZ2tTUWNHMjVPdXlR?=
 =?utf-8?B?QU5wNWRJTThOay9iRFdVT2NzY05WcGlIVVYzK2s3RGVBaFk0MStyV0NWWUEx?=
 =?utf-8?B?eGsxa0ZkVWRQd3FweWorakNOT3ZIeFFMY0NxN21iMlQvZDZxMmJRQ1o5b1RH?=
 =?utf-8?B?QjZrSUpWUkNZeE1jWjQyd2NmUEdIR0o5Um5UNTc2T1p4UEdNNlpxdUtCenVh?=
 =?utf-8?B?b0pVU0o2Q0Zuc1dpRm1Na3RqWDBzekd5YlFyeWxzaDBTQllXenpKNGJJYzFo?=
 =?utf-8?B?d0lNbDVHSXBHd1RwTDRyRjBibXJMaENMNis5cWtSaFhpQTJieG8vbnUrckt0?=
 =?utf-8?B?bHRsN25abWRXd3pIMmR1VTdCZWc2Nnd0cEdHQUR0RXBUNE96cjR2UUYvbEI0?=
 =?utf-8?B?S0ROTURlZTUrdlNTN1FkOFI2aFcxUEpDNE4vT3JaRlhjK1JYcHh2b0FacTdD?=
 =?utf-8?B?R3lqY3I4Tnp4UmxIbzFldDA0aVFsYU10ZFhhZ2hkYVN4NDZEa0Q1TW5pWFJp?=
 =?utf-8?B?MzdjVVRRZnQxdERzeEJ5OTZZT1BhbFhiL3NvOUtNbUR5bHhTRzdONndMVmM5?=
 =?utf-8?B?ZFNRSU11NE9XWERmdFdJNlVEY1A2RHpTaFJya0UvRE0ySXVGVkkzMXRINVFt?=
 =?utf-8?B?RWgwUWVva2s2ampjZFg3Mk9qaVhKQXVIMkRlQmVzKy9USHVPQXpsRXQyQkVN?=
 =?utf-8?B?SG0wTUh4eU5obnBNYktJS1NqWUZoa3ZvbVU3ZTRXckVvcU0wUVhFRjRLUWJ2?=
 =?utf-8?B?YjVEQXJKeGEzYTE3U08rME1hczQvS3cwNkwvZXdUY25QSDZTeXlIbE1RNlhR?=
 =?utf-8?B?S1FMalRHVllxaGY4ZUo0dUtJam14bytzK3pPUTg2SHJHUzRDb2VMck1TS3pK?=
 =?utf-8?B?RVQwU2Z2dFBnRGFtcHByK2I3aXhBL0lNT0tzQVV3RnJxSkRKUS9WbFA1dVpW?=
 =?utf-8?B?Ui85VDRzYWdLRHk3cDJNUDc0Slo3QVRVdXRxR0RXY0Uyc3g1eUZpYWtRQlJR?=
 =?utf-8?B?Q3BMMTQzbUhPYmF3YnRYeml5UkpsRUFud2NSMlFTd3MwQndTWXVVTmd4MUN2?=
 =?utf-8?B?N0w2ZmV5T0JiYWliaDQzV3RZd2R2OTFoREVyVFI4ZkF6NnNTS252aGxxNVZC?=
 =?utf-8?Q?drzs5lVKDB7mc2vG5HTAcfm1DiNpf8UpnZOYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFCemxFRFFOaGNRRytlWW1ERlZQVVJqSUc0YUtNWGhFUUwvZ0pVSWFyaFVT?=
 =?utf-8?B?elM5V1dyQmFvT3VtenB0QmFPK1dDNW1PcmpHS2pJc3Avem1aYnRmZG80Qkpr?=
 =?utf-8?B?UURDMkpUZGdpV1lOL2tHR3MrK2lHeEg5YUZVMlU1TElqcjI2NXpKblphdktz?=
 =?utf-8?B?STc3ZXExYTgrMFJDZUhPeS9FNGM0amhhUE9WRkUyeWxxRTA1NUFOWXlGR1pz?=
 =?utf-8?B?T1RTRzhEUk9acXpWdUlWRUk2MzRZTUU0eExHN1ZJRFovVHZXMUJxV1ZVazRG?=
 =?utf-8?B?a0lwVVpXUTlDeGtCQ0txbXlUc0VpSURCSkJURlRSbkpLTFlqbjJMUWpJVUty?=
 =?utf-8?B?MjFBc04wZ0hJTll2OG9wWlNlc2x1bXZ1eTZoU01LaDQ0b2M0U21RcjlzUHFp?=
 =?utf-8?B?UHBuZ2RWZ0dzY2RUSnZhNFR2N2ZDRVN2ZXNkbTduT0MyaTlPdDZ6c3U2OEpX?=
 =?utf-8?B?SEJiRVoxWWp4Z1kwQ21TbUdOWDVmYUNBVmRoUXIvUldNOENVS1dUQXBIQlFk?=
 =?utf-8?B?ekxiZTMvenlvbUFOSkVBbmVPNUtkL0ptenh3SXNkSjlxUjJaMXJxTmp6N2or?=
 =?utf-8?B?UFpMM09TeGdFcXo1WUhWTHZrL3hWSHJlYTR1bHAwRmlFbG1JRU0wV1VSQlA2?=
 =?utf-8?B?ZmczQzg3clNyd3FWKzVqY1Q4SU9ZakxvVWtNZEppRUdpbTFiRXNPb2NqOW9G?=
 =?utf-8?B?Q2V6T0E5MlhZb2d4VFdMVUpCTnBYUmlTMjRHa3pvNERLWDZTN3pWZlJFTmlP?=
 =?utf-8?B?SnQ4SWR3Nmd5dDlBbCswYzJwbk9WM2hMcjZxWS8xV2N3S21PTUg3TUJUU2cw?=
 =?utf-8?B?bmYxMEYraUx6NEJkQzdvTERQcVJZQ2NIR2hzcVE5RlVCamEyVVVwYXJ2ZGIw?=
 =?utf-8?B?cE9XZ2JBRjdzQVNuU0h1bVBmY2JHTzViRHVwSElIbVRKUnV2V1FTZTB6Lyt5?=
 =?utf-8?B?Q0JKR1llbEJpcmpOOS8xVVlWSTVGQ0JScHN5VmNta3krNkV3K0h5WmJTa052?=
 =?utf-8?B?MGpOcDVQK1k1eDV6ZXRqVlNaV3RwOUg2YTZRa1dRNVJuR1hBWm9tSUQ0SE50?=
 =?utf-8?B?SDlZdk40bHR3STZPQjBJcDdqYkpRZEExeW9MZUl3bU5oOUxTRTQ1WlF0MTZZ?=
 =?utf-8?B?Zm1zU1d3QzlqNVZ3b2VXZEdXSGdIcVNLUFMzbWIweHlQVFJoUVY2U0FseG5N?=
 =?utf-8?B?eW5EVFhJUWhYQ2RwY2NwRC9yOFhMNXNlbjZCVVBRMnlPcTJhVW9GMXo0a2cw?=
 =?utf-8?B?UTR4YWR4R3FCbHRyOEt4cGZsKzBHREVVQUdJcFN2Mzk5S2JqWU5UMnhBWXdK?=
 =?utf-8?B?QWp5d1RvNkxxZm1hZGtHL3FXQXc1YVd3SDZ6akxhU1RZcDR5WlhheTYzay9v?=
 =?utf-8?B?dEF6UnkwOEYzRzZUYWtDSTEyZEpGcEdkQ2ZiSk04UjVWbm5yQkJuYmJHVFpm?=
 =?utf-8?B?UEY0dHFLS0NSQVh3V29YNTNoYy9iMXJwUmZEM2pObU9vYWZLa3hTS29GN0tK?=
 =?utf-8?B?dkg3cmJhN1pIRGlPcElzbzlZenR0c2M3THl3MTN1ZnQ3R3BwKzBITWlpajNN?=
 =?utf-8?B?RmtsbFhGN3lWY2JNYTNmMzRoa3M3ZGJnN1Z1dGl3Wm1iUENnYXRJYkNIWk4y?=
 =?utf-8?B?MWx5QmlEMXpKcGkvSXRJbHl2b2RqK3hWcDJBeDE3ZXBPMnBMblJmbkRleGFV?=
 =?utf-8?B?TG9mNFhqd1MrTlBQUjVmWmJNWU4yMzZoYWdGajBscEVNYmo1WXBqRTh3NS9G?=
 =?utf-8?B?UEpnenF3TGF3cTdkN3UvdDN6R0dXU0syUU5rSVhvMWJHWWhVWnZIeGFEdXl3?=
 =?utf-8?B?Smh2WGtrUVhyOGVaMDB5dFZpaGtMc0lLRjlqR1RxMkh0eXV5YlJDTnVkNzRC?=
 =?utf-8?B?Z0dScHNJaktlY3puR1Z2a2trKzgzenluU2VHU3Q4OCs2RDV1cjR2OFZDYVlr?=
 =?utf-8?B?QVBXUkYwMEl0aDdqUU9WWkR2Q0k1bHU1MUx5a0t2S09rRW1Vc2Jybk5Lem5P?=
 =?utf-8?B?VFFSc2dMeTVuUWFDcW83ajhCSnRZblh0VFA2NTVTZ3ltY3VVY0lvMEZYcyts?=
 =?utf-8?B?WHFSK0FOVlliRWNnQk55ZlhXRTBsYjdOWEdaa0p4S0U5QjV5TEIzelRSekxz?=
 =?utf-8?B?ZFE1Kzh2NlEwSnBJbytYRDQvUmo0aFY5MmFldXFlbXB6TlBJcHZHNlM0QVNy?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ed056-268f-410f-4c05-08ddebbf9340
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:30:20.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8fsj59XKvCGSTcUHfiHIlRlNkGJMPef7Jr89beKATyr94G4Wy4+SqnztOUD4wjzx1/ZuSI20HpL5obfk4p6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5800

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If there is no healthy device available, try for
"WAIT_FOR_DEVICE_TIMEOUT" minutes until aborting the test.

The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: ignore device state, only fail if there are no healthy devices]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/run-lava-tests.sh | 33 +++++++++++++++++++++++++++++++--
 tests/README.md           |  1 +
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 5545dc5..8f9dac0 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -24,6 +24,20 @@ get_first_xml_attr_value()
 	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
 }
 
+get_device_state()
+{
+	device_type=$(grep -oP 'device_type: \K.*' "$1")
+	devices=$(lavacli device-types show "$device_type" --json | jq .devices[] --raw-output)
+	for device in $devices; do
+		available=$(lavacli devices show "$device" --json |
+			jq -c 'select(.health == "Good" or .health == "Unknown")' --raw-output)
+		if [ -n "$available" ]; then
+			return 0
+		fi
+	done
+	return 1
+}
+
 # S3 artifacts
 artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
 # public master
@@ -42,12 +56,27 @@ TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINU
 export TEST_TIMEOUT_MINUTES
 
 echo "Deploy artifacts from '${artifact_url}'"
+test_definition="tests/jobs/xenomai-${TARGET}.yml"
 
 tmp_dir=$(mktemp -d)
 template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
-cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
-
+cat "$test_definition" | envsubst > "$template"
+
+echo "check for device"
+time_elapsed=0
+while true; do
+	if get_device_state "$test_definition"; then
+		break
+	fi
+	time_elapsed="$((time_elapsed+1))"
+	if [ "$time_elapsed" -gt "${WAIT_FOR_DEVICE_TIMEOUT:-10}" ]; then
+		echo "An test device for '$TARGET' is not available"
+		exit 1
+	fi
+	echo "Wait for test device '$TARGET'"
+	sleep 60
+done
 echo "Submit lava job"
 
 test_id=$(lavacli jobs submit "${template}")
diff --git a/tests/README.md b/tests/README.md
index b6421b4..b8288e7 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -111,6 +111,7 @@ The following variables are used and set by the ci system:
   - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
   - `LAVA_MASTER_URL`: URL to the LAVA Master
   - `CONTAINER_REGISTRY`: Container registry server to pull lavacli base image from. Uses registry.gitlab.com if unset.
+  - `WAIT_FOR_DEVICE_TIMEOUT`: Timeout for device health check. Default is 10 minutes.
 
 - Image deployment settings:
   - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3
-- 
2.43.0

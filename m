Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7392D12E3
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979919; cv=fail; b=MBh0bla14pcetbb0D3Vxgc8iyiMoTmD/4IpUn8Q9FOmmfCXOHNEzjjTlkzpIm1hMrNGnY44umItcq/P3ovlmQWg+AUidZuPAPO2ASnD9xWPBDbGb3Rm2IO7L0Lq9HuTMZ6fysqw+1txEOY19hnwJp1XUZ6J0XhmAwY+FiI7NZRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979919; c=relaxed/simple;
	bh=KEyLGEAzJzVylqZpiw8NBHhKF2pTfPCOkik5TxiXzyI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9tmi00OnjGhpaYHERLe34m9UtlAUC9/Ic0pSUJTJS7FgkYGJlhUfOs3oGusC4zBkMOXFDfeRn7Q/5Pqodz+VbDQIZuQX7+Yj/fMbKSDFA7b5dbvJzwGvttBkWYYM71k1UCebxjBiVRG/1O8oMe3D7+B0Dr7MpKiuotwEQyyuzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xRx8jaj7; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xRx8jaj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyUTgAxEFI25i92r30OkJyUmuLQpHE7bPN+ObIeKSpr9yxCsx7QC0S7xsmwda+oaiG4FeTigbaOLS8VFpkdCSOsxlLB18pdBCTm+RQ4yo4XprcWyAMGqc+hUcNCn4M/rH4/PxoWHAgwtrYmUiOEnnQZ4ExYNwBn4KELKyHyfrZJWKjf4F2UUFBumX9vnNvRr4DIWz0jRpKT2ueZ5MLcMV1gEc2uAUZp6O1Kr4ZUq35+XlUqFWkqZi84VSlMSD/qYjUbMus7C1hddJ2y1xcbhMRB5DSTAUX62lbcJ4SXcDoM5tFGN3Do09nlAZNsZF8pDvJqnuhPnRdpVRuy66BjukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnhA+xbUBT9tHcmWwLPnqE9u20DRNVAOHm5Hy4tRonQ=;
 b=jmJXcaHI2LmQy2ja1laoLMFa9aPtuCG/r6mpxksmN4zoakQqklmDE9Gw84TjJwKAw0o2uRKlKvXQNSBSEU2MyxtDCSPILkOAI/91dCYWNYDYP9++0KOduMPNjtmLMwiWhrDQag4WkkZlfELDarkxPNnjX1K/nNtmpJ3DCBcowgVy7APiTVa1hdHtv+wEJIuvjZEmJCayA+IvdY2bLOKtfynntG44dC8c5QPDyezV2GIjrowp4oRxyPy1eOtAeK3RRM9caW+HX2xupxB1k8xokYqL/xANcbGZUArdvgyS6RcXIDyzjMc3EORL6819I0ulkesTVSqRV7nw64zx2ZW5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnhA+xbUBT9tHcmWwLPnqE9u20DRNVAOHm5Hy4tRonQ=;
 b=xRx8jaj79LmFR4npB/ADjvmgTMnsJ5Z8rktXi3bomj/MYl0m4Lju01bceuPlglLZx1BTV8cV68C+p6zuURB8EV6pUCq2Zpnz9LDkVG0x8jdPBfHjx2P/AwiyNrvWwhmJ1rlUGBztAyc10HAEe2Eeqie6PuWzdK1YSR/A2rjwHFkHCMgYxs3+92N5EsfArwtnAlCcMAL8/39AUJp/B7BdIhXI2i5AYiBiE8ryw8AyspmRZrsLdf8fVI1grx/acTZfGqxlT714J4+m0klFsK+v8IJiNlNp3+rxU4RCnSpKXDqBFPRDAtk+7gUcXNaAv6+uN/EO3c2aZmu5UuRIGlcBgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Thu, 4 Sep
 2025 09:58:32 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 09:58:30 +0000
Message-ID: <85b19acc-fd42-4a59-83c1-0063afecff62@siemens.com>
Date: Thu, 4 Sep 2025 11:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: check the device health
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
 <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb42793-05a4-4910-d60f-08ddeb999a05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmx6cGlsV3lYeE5tMDRRSVhwTFRMQm5GclRSRjhRd1dtcnRHNk9GbC9IaWY2?=
 =?utf-8?B?NkZvNUVjb1lnbHFxRnhpMnB1YzRoY2ZlWmVXZFo2YXhQbEpBZ0xHb2NyVThz?=
 =?utf-8?B?YUpYQkR1TjA2OW0wNDBQbEE5Y2NRSjNINkhJYWsyRGU1aXc0YUdDTWZyRUI2?=
 =?utf-8?B?WlJIbVAwQmVtMHR0N0U1WXl2LzZCYUpwSG1lMGNmdG9lbmgrRlUvb1NCRUI0?=
 =?utf-8?B?bWg0YjJlQlJaTW1tR0tFVzVlcndiaC9sVmZHVW1aQlRRL0FocFMwdkNXK3NE?=
 =?utf-8?B?U2QyTWNDdVFIb2ExNENEVVBIWXdVR2REMXlFNDZPTExUTnJlbGxZeEtNSW93?=
 =?utf-8?B?czVnUWduTTFxS3Q3UUo3RWhHQWhxQldNWDlMd1V2UStMRFhWVHlmb1JDWTlF?=
 =?utf-8?B?WG5NTlRMUzRoVUQ3SHQ4RnpoQVY4dUcwSkttZDdac2s2YWh0RWYyZ3JPdlVu?=
 =?utf-8?B?dnZPTGZFdktENm1jQVg4TzFRdU5pM0ZnU0l5UmVCY0l2MVpCcDZrM1BHYU9q?=
 =?utf-8?B?OGNJcVlMd1J0Nm9lWlRqK1ZzM2NzQkswTXpta2ZremNqNktEYzdGYkpVWVI4?=
 =?utf-8?B?MWN2amZmV0x2MzA1OHlkR3VwdTBWRk5pcnRBRHVoWWJkM25VcFNoZktWWVJC?=
 =?utf-8?B?L0RieWQvUzNpZktGQkVVRCtZT3JMbjVFWHJyb1U0Sk42NkF6MXc4WmVFUjEx?=
 =?utf-8?B?VlptSDNKT2xmYU01ZVZvdkxFNVRUenpqZWNQQTAwM0FqY3E3azlIRXoxc3Rz?=
 =?utf-8?B?SUQ3dmFFK09FcVdGSkc4aUlpbDY4eTd6cE1NaUUzeWVvTHNtdXJRQWFBdTd1?=
 =?utf-8?B?c2twRTB5YkZnRlNQQWZGZ280d3QyWCsydW1DT1pKcXg3TUVuUHFnakwyL3B1?=
 =?utf-8?B?d0h1YVJQRjh0aERvK2o2NHVtVm1ZZ21qcWVGdGdGa0d5VEhuM0JxeUc1ekJp?=
 =?utf-8?B?dEtMZTRpSk1iM3ltSjZreFZHYTI1YnE2cExUWGsvWThzWFNvTWhVbTlGQ3Vu?=
 =?utf-8?B?S1dHUFhRaStHK0JGT0IvSUUxMTBXVXFHelh4ZTBzQ3Erek1ZM3JZYXpkdFpX?=
 =?utf-8?B?T1AwbWhjZWVvY1lydnVlNHBXQUxCTFBvNm10aGpwY2ZCSXlBVXVtVUJ6UkhZ?=
 =?utf-8?B?dllJa3dLaWI0ZXBtK21kYnhlL2h6SDQ5QmNkYWtDZmZGc0tMdGUzajdrcGRZ?=
 =?utf-8?B?SGFrbGVhL2JOd25xQTE4Z1dGRlJQbFRDNlYxVHhvdFM5YUI4ODdBQ2NneUJ4?=
 =?utf-8?B?QTJWc0VNc0hmaUszVFZudlNpTlZDNHRhS3JvellRRndEVUthKy9zQXk0Wjk3?=
 =?utf-8?B?bmJ1QXMvcWx2K0ttMXduL2doazdlRXpMZ0Frbk0xTFF3V09OQlVRRC9NaFdO?=
 =?utf-8?B?bE93SXNWZ05sZ0VZNnF5RU1Mb0RzdWdpYUFLd3JJanQydDJSeTBxMWNjc25P?=
 =?utf-8?B?YlNub0ZwTFFmMG5ZQXVGdlZ6cWVEZ2c1ay9hT3E4dUtxc2gwelJ4RjdKWDVt?=
 =?utf-8?B?TXBnQzRJZ2gvMXNCM056ejBzeDV4OUYzV0VKSjJSa2lyNHVXNEhvMVdST2ZD?=
 =?utf-8?B?RTAyRFBtYkxYbkdwVVo0bS9hVlRsVStsMGw0ZUROa1BwdjZOcXR6K2U3emww?=
 =?utf-8?B?U3U0VUFVc3NMdmUwUzBPNEJzUGwvTGxGS0ErYWw2SHQ0cFZBblh6NitPc3Jp?=
 =?utf-8?B?U2xHK3YyU0d2MW9IVHNjY29EWkNZVzBibW85d0FCSm93OVZZT280Snhsello?=
 =?utf-8?B?aWowMisvVU1Ndm9admtUd3ZUNkZaZDVURXUzTEhMcHBKN3ptM1lIdHJ1clN0?=
 =?utf-8?B?UTZTQ0hwbG9NSnBBQUxhSFUvNGpETVQwUFJrdk9RY1ZHYTVsZktrd0oxNE1h?=
 =?utf-8?B?YWpra0ZDV2c4a3RvdFJEckJLQmJ6ai93djFJbW9ucnYzcEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjRYRXpieXp5aUo4UkRxTTViSmE1eGlockNKcVV1anhVK29XK05XS0tkMGFn?=
 =?utf-8?B?U1d3cWJLSDJZT3dXaEdRRzFubmJaSkwvMTYxL0tCS2Y2Y3EzQ1A4Tzl4bkFI?=
 =?utf-8?B?cHkvSTBiTU5kbGI5bGNOeGQ0OC95OTMzdnZFOXJVQkhQZUt6YzFjU1pkTHFK?=
 =?utf-8?B?SkM3K1NTNWFaYjVPMjYwR0p3eGZVQXl4U211YjZZMjUyVG9rdUNITTllbzN5?=
 =?utf-8?B?Q3c2Tit4aW5UNDFYbytvT29zeUpmbk4yNjZ2OHF1OEV6aUhQVGtRaHMzQWt0?=
 =?utf-8?B?bDVBakJkL2NUZUtsZmUyWHJzb1BoSmNtYm1KRm9QRUN1NHI5NEtBU3F0Zlh4?=
 =?utf-8?B?RElpVCtsVTlMSDlGNEF0SVJpZUZXR2lSUTdtK2FMVTU2T08yS3hEZG40T1Aw?=
 =?utf-8?B?ajJINFB0cjMvWGM3cktrcUdGRVJjMWcveFhPampjWk5nMmtQOC95V3V6OFNQ?=
 =?utf-8?B?Znptc2EzbGoyTUpUdlF0K3NOcUJCQy9SenFtcHI2cjlhOXZMYnhwZWpXOGpH?=
 =?utf-8?B?Y0g3amQ2VVovbDhWa2RMekpoTDMyRnk3VzIwK3JZb1ZQNU5aUVFTdjZMYkhl?=
 =?utf-8?B?N1piN2lUczEzeE5xVEh6bVkxSFV4QnZ0Z2RBL1Q1NTJEYlcwdEYxaTFveHFL?=
 =?utf-8?B?STEwUjRKU3hjalprL2pZcUlFVFg4WlV3U1JFTm02Y1JwUUd4OEZjU0JxL0dE?=
 =?utf-8?B?NE5aaFRLRXR0MGVTcVVMaldMVmY2Q1lEZzlES1l1ZnRWWTJGZHpUZHhvVGFU?=
 =?utf-8?B?WEtkUXphQjF4QnNZWHU5U0JWNy9xczZlZ1lwWVlrNU5EOW9SRWowWWJHcFhi?=
 =?utf-8?B?MVk1QjdoRDk3TUhuaFY0WGhjTHptenFybHpFTnRsRFlUOEhPRTQ2QStNdVlJ?=
 =?utf-8?B?dXZOOHhyU2s4TFBYdXlBcHNOZ3pBK2habXh1ekN3aXB1YUVYTWxFVTNqWDlw?=
 =?utf-8?B?OUY0SWN0Rk1MalZrZUphUUFnQkpUWE4wdTg1UEJoVnJESWxrakQwbWhwcnZY?=
 =?utf-8?B?TEZrVXhDczZSeVhQR1ZnZUdKT1MzbC9OMnI4TGpaRHBGTmJ5UW9MMW80UVFQ?=
 =?utf-8?B?YTBleVgxWXg5SEtiVG1MSjBZZUVmNnVoS1VISEtFS2Z0YXVUVWVrMGRFS285?=
 =?utf-8?B?N0x0WUh0Nm1zbmY0TllIK2ZYR05YZ0duZ3BKTk9Da3BCV0d1UHJTUld3Z3pB?=
 =?utf-8?B?dE42Vm55TnBwYU1BaXpPRGszWldtWjNjcVhzWlpXOFZVL1FhWEpoQVJRaS9P?=
 =?utf-8?B?RTFWVnJuY2p0RTR2ek1XS2psL3hvQnMrdlpvMWxxaWM3SGZhNUlQT3ZUM005?=
 =?utf-8?B?RGlpdmxPTnJ2UGdDVjVvMWdVUm5vU2crcGgyUCtJd3dPdWNUTUtmZ2hZeEtV?=
 =?utf-8?B?Qk1CbTg5VmZyM2pYSlJiUnRIL2lZOXJQTFdrWFUwQ1J6aFp1WHlNcVZhUWRv?=
 =?utf-8?B?a0d4R3ZMTHc0OEVkRk56R1VsV2pyNGpQbjVoTlErRjBWRENRQjZXVGZjTXND?=
 =?utf-8?B?UFArVlRrL1k5d2RmWFpFb3Z2QWJJWHUrT2ZtOFYxcmRLRmVicmgrbi9PVTNp?=
 =?utf-8?B?YllrdkMyMi91cHVIbG9EdVRUR2RjdjUyTnNEM1hDYjJDMFR1R0gvNGtoMDha?=
 =?utf-8?B?Y3lLUmZuOERkb3ZoZG1FdWZmZGtxWE9BMGhGYnZKeE40R2ZQNDMydHFuQ0VL?=
 =?utf-8?B?bzFkU2Y1NlNwZGZnSjNCY0t0S2MwQzUzd2dHWm9Fa282aWxpSWF6Y0h6T3Vt?=
 =?utf-8?B?VnNEamVZUFE4OWRhYklPQlVHT0ZXc3p1VkZHanNrN1hmRHRuamIwZmhQLzdQ?=
 =?utf-8?B?VnBUZml4eVRYcXdTSWlTbTlVaTZXMWdtUkNKekNKV1ViVitydDl4REdUMWY4?=
 =?utf-8?B?Sk1VUUUvK0RnMkg2ZEtQLzFhSFJIK0ZzWDhVQW11dDlWV0VXcWFFSkxSN29L?=
 =?utf-8?B?TTZZZ0l4RE9JVXlTd044RHNDeGpzK3dRZXd3bVV3Mm01bWFWYUtKTW9NM3Fy?=
 =?utf-8?B?RTN2ajVvM0hBdUlOb2hMZFZyZHJhbnc5aS90REVUNnY0QlMvdUVlQXZyd1JI?=
 =?utf-8?B?Vm1DMi9WaTRHVGRNbklmSE5PNm9md2ZSbXJvcmlsVlRwekNGeEVBTGh4UkN2?=
 =?utf-8?B?cVVSbHlyMlRkQXhacWNLbEJuRURjOVJXVDBCT2dpWDdxMzRmaTBnUTFsbE5M?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb42793-05a4-4910-d60f-08ddeb999a05
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:58:30.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N3z06ZM8TMaBhy44bQEC20kUZHbsN3fDSKoKcKnfFG59pGcogieapUoq4jgopq4W4C3uUBEGTSoHfGldasZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5908

On 04.09.25 11:42, Florian Bezdeka wrote:
> On Thu, 2025-09-04 at 11:29 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Check the device health and the device state. If the device is not
>> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
>> minutes until aborting the test.
>>
>> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
> 
> Hm... Not sure if I understood the problem correctly.
> 
> Assuming Jan spawns ~5 or ~10 jobs for a specific device type when
> pushing to one of the Xenomai 3 stable branches (or something else that
> triggers a lot of test jobs):
> 
> - One job will get the device and will run
> - remaining jobs will wait (and time out roughly at the same time)

Right now, they will not run yet because of resource_group:
<desired-device>. But if we removed that, we would have to take the job
runtime into account while waiting for device availability. However,
there is no reason yet to remove the barrier.

> - one of the remaining jobs will get the device and run
> - all others will still fail
> 
> Correct?
> 
> Does that really help? Maybe one more successful task (when the timeout
> was enough to wait for one test-run), yes, but is that enough?

The main issue this change is addressing is that NO device is available.
So far, the job would wait for hours then before timing out.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

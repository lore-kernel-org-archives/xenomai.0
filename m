Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2E23C4EF
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579909; cv=fail; b=ayWmXENAqdjpxuxtkpylftwgaDwbWAYD9B+fuzmb1wOo2SG29STDijNi7yy0+H2pY3++QUa7CsHPHNnyvxXoW+eSoEC3J9BTu2RlefS9CtLQQCp4HbBYS4ylu/6OC7o5q8JcG+DIM7rt+IDA2TJsG3N/w5wB2HbwA0cDc1fabUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579909; c=relaxed/simple;
	bh=0pvDuEc/7DNDBMsSj1jrM8RcCUWfcXmvVvlVqc00csU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=GmOQqZbWhcvUea328MPdknAFiDAuWmL29QKZtNfzyHosCFDobYsJFNnDju4BKHonlYBIoAh/ypfB/XZCDc6IjXG9Pph7W7qmhov+Tn4KyloqdjEWeR/cTQMpPTBm0gC3u2LRr3K6SI8rwY25NYDLrLWryN5w6RJstnjEJpgsj/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sAjPmgVM; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sAjPmgVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhFzI8UZoG1Z9ptlAf26fGEUWA8KFSCnSFr6vB1wzGkyTTOqHLpzHXcdJdiPh6pjuY+Sx7Qa413dR+07JQUeEmXHG6kV7ECjUR5KXK1EDEWNFPlMfUOydk/WqQr0q+DMYrQ2B6suM6B3RwggwEsZxjyR6RnTp4RkA/bCynHp+ZeTwkmEokrItYb2vfcrJUZziNfJwG/shzIrqrN9RGNf62OPTwwmq/aK7+urc3eVS7Fkch2H75LIfUShdah1ZZksqUwoFf9az/PAdaS7ZlYPifHrOvWBWS019dznfz/2egzEv78JY8aE2jFC5r7nXp+xAEy08Tp7dCTHcK8Ufrm4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrTF6JaqdSExY/akdL0c2nnx2GgmPmT14qMXKGCCJho=;
 b=baUltacSaUaeRu2FhfSoExJs8Tn1TiEo+ti53zmgf04pAk5D9f+7gU50vjK9way035NhQ0Vm5JVmwySt1Wa66O8kz0T4S2+LN+ZGeVfH3YyMIjZXKzqNwLfqf5hf71a9Gsh8goZSOhwZqMU5pu2AeX9YALwIaulOz9PSg81tFeojoxGITIssROGj1OPdapCgS7/4XwmgA+f2Urnn5OVDRxnP6t8HletYIkU2sxYs5LWseym6RFquehPw9m+NG1H9hGch1zGztTzsgEKpKiscgJB2EvL03/bHUX9zLS68k4fgvtAJE6dPTBLjERrAgEeFfWxah7inCrlk3m4bfgFT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrTF6JaqdSExY/akdL0c2nnx2GgmPmT14qMXKGCCJho=;
 b=sAjPmgVMWuuEwcBIh00XJZys1U/BT0OeebKez7gjiIJmQDhezMK+h72iKPxtZHHd7QQKBXRLoof0YF9jv489p5o5XcS+wgt7LUh4Ybn3YG71nSlH3/oc+Pk7Pxf+wpePKcUfACpYWCBYtC0y/aCu3aU4BDgghA/ZgW4gm6UxMHP1PagWLB78+bFxHCCeue638cHNPUNOql49qKZVS70h6pRnIIRQB/xEc9ESeGA9p9rJhMzxLPnW5qfc76/kM/sYpRT4f53E1B1KpFBu9E9OjenS81pbv+RyeUeoemYEyd7B3qVHcDpfsWdLURBYYwfrANu2wf5GTyaqYU4KBCmWJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 18:25:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 18:25:04 +0000
Message-ID: <e27abb83-6c7e-4603-b57b-9cb6abedc28e@siemens.com>
Date: Tue, 10 Jun 2025 20:25:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] lib/cobalt: Avoid deadlock during cancellation of
 pthread_cond_[timed]wait
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e6c9cc-9601-4423-b029-08dda84c1e55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWVzeHc4MVhxU2lxVHBiVitEbXEwSmpIYktUQkF5aUdLekF0VjVmMUMwN2ZN?=
 =?utf-8?B?WWpiNTJPY29xZjR6SkxyRGQ0a0pUdnVGNllRV3hWUzBSQjNRbEtxamxnejQ4?=
 =?utf-8?B?OXU4ckk5TVkxVjk0eGdsdkVTZ3h1c2I3dFIxT1RST3FLMzl2VkxTWE5SK2dD?=
 =?utf-8?B?ZVlpYkIrbUgzTTRUdDY5blMzYWd4ODNtRkNBZ2Mxb3ZtRFhKK25rUzlNMDNE?=
 =?utf-8?B?b04rc1RQUURzT0lNWk56bkphMXRjQ1pWazAxdU5FZU5GTXZkZ3NzS1MzVlpX?=
 =?utf-8?B?dkhvUTNESUdlUWRINnBrVk5VVzBwQTdrRHJWeXNKdU1ocWN1bUQ4VUtEVklw?=
 =?utf-8?B?MVY5WVgrRDJBbUVnaUk4SEZsVERPVGlQaUN0SEhFZXBSRWwwOTJ0RTl2UWJM?=
 =?utf-8?B?WGVESmhGUjE0QjRmelVabE9ZdjEvbk5JY2VMZG1KeVpRUUhLak53RS9QbjFU?=
 =?utf-8?B?MUR4bi9sUGIwUkNHbVFUQnhYMlVWai9wdWNNRUhSanBNV2UzZmovM3h3RGlU?=
 =?utf-8?B?eEo2WjdWbTBMdE1jSEFpUzZrZ1ZPQ09hc0pUVVNubG1kU0dvaWpZa2FrUkJ1?=
 =?utf-8?B?bjFRYlR3UnE0Q0h2d2g0K2ZwRFB1Zno0VUsrdW85WUhIWkg2cXJ1OVc2bkJs?=
 =?utf-8?B?V2NqejJtNmo3a1RSenBKbE5mWXJTQlltQnhQaWErNks4dVVRRHBaSjZkbWZ2?=
 =?utf-8?B?SXJDbTA4Y0pLMlMwdUtZNUc4K054QkF0QVRQWXVFK3ZaZjZpL0JlNWlET2J0?=
 =?utf-8?B?cEt2N3BQK0xkVllCa2tQREF1WkNmTFJmWi9BbnhOL0F3dEpoS3lMWFprSTQ1?=
 =?utf-8?B?USt1ck1MR01Iai9uaEU3RnhVR2V1T1BjZCs3T2ZwZjYzWkl4VHdMRnAzcXFv?=
 =?utf-8?B?NXRQZXQxRFZTeG5wMkE3Q01QWFVoR0pDcGhIQ0o1YldjUVI5ODgwdkYxRW5W?=
 =?utf-8?B?OWtPblJvYkkvN3UzMVA1d2NyZnR2RXNtZFpqS0l5S1MwdmZHR0x0UTJRZ3E2?=
 =?utf-8?B?K20zbFVxZVJCeXNDVFRlMWs5dzB2bG80ak9aL0Iva0dHNjRjL2dETkFqdWQ2?=
 =?utf-8?B?TUtMRUt5N21PNU9LdnZvcHRveTJrZGZBVXlROEkzZzNqeXY3RzFVUjlCQ0FF?=
 =?utf-8?B?ZEJTWkV4SU5tSFFObllkSExic3llUmpnSmg5c3cyUnlsbmxkRTdSK043ODFB?=
 =?utf-8?B?T1JKVTE4TXN6MW1JRG9rOUc3YnpQbjJhUU85OGRUcWZlTG5RcFN6cmdIUVht?=
 =?utf-8?B?RjJWU1pRNGprNy8yV0lMazN1NWM1K0tTL3V2QnhQbmtSZ205NGE2bjBMakhY?=
 =?utf-8?B?eTBsYWFsUzdBN0hDYnd0bzRvSGdUKytMK3ozRi9YanpUTXNUMFJSWnh5b20w?=
 =?utf-8?B?NWZpMElRM2tvOEJBUjhaWGhqd2dSa2FwSHRWM09hTGlRenRubVBTUWxQcjlN?=
 =?utf-8?B?dmwzUHRRemJKVUZvaUlUbC85aGw0UjBGUGN2d08vUkNYc1UwYTJXUnBHdk0y?=
 =?utf-8?B?RkhveDVRSUgzK3FUak9xTjlOaUladFpaL25JSzRBSU5HQ0RxNzBoSlRSMllL?=
 =?utf-8?B?TENhZEttVFhUMmxTY3JscVNOZnRWMlhPM290K1F3cUlpenZUaW1xN2ZNWldZ?=
 =?utf-8?B?VG5iVHlnWmIyY1d4M2laR0RTMmxXbXJaVEtka0hjWkJmMUE0ZkRBZURVeWlh?=
 =?utf-8?B?ZE54TW1qem5nd2lWU2RVMEJGTzhONEhOcDVWQktCRDB0YTZBVW5KK1o2cmE1?=
 =?utf-8?B?TERxajBzZlBNMjFqWVFuU1JuNDMxSmhGa3Z5a2dxa2JxR1NRL1A2d3BVdlVu?=
 =?utf-8?B?VnhJRUgzVmloNlkxOTlmYkFvaU1xaVh6VmdYRmRya3drZlpyOVEvRTJnemE0?=
 =?utf-8?B?UlJKcHRsYzVpOGM3TGtnRDRDT29PN04yU1BLaGV5ZFJEMmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkR5bWp0VmNDOEJQSWJkc25SUDFMZi82QXZEVENUcTdaQjh2aXZpcVBPQ2ta?=
 =?utf-8?B?V1FpWWtVbkpRSWlGdVJnRXdvQnd5WU9Bd3JTRFNsNGFmdFMyc1M1bEgrMUZ5?=
 =?utf-8?B?Uzhkc0V5UnJmYlBkWDNyRHVJRnZzZ3J2eVlBelJuUlM2cE1RVHE0ZHUrM1JP?=
 =?utf-8?B?M1lRUDc4RFNmS2VNOG51eU5YblBlMU10Y25KYk9mbUxHcEpoVTNOT2ptZFhl?=
 =?utf-8?B?SDA1aEw5Z1dKV2w4cDhkQTFvU2ptSFZqUUd3ZjhGa1FpUThBQldQUTNJWTl3?=
 =?utf-8?B?YkNxaS9OQXJETDRleFh2UDBLMWVpZFdtVHNnMXJON25mZEgzMEo2bFBneVN2?=
 =?utf-8?B?STl5QkZrU2pWcm02eGY2eVFscWEwTUxMQndNM0NlUGRRbmZwbEV1TXR3RHhD?=
 =?utf-8?B?Y1MweE9ON0lOSE15TGJoRWxIU0U0Q29na0tTMUFGNnZUcVlRMWJmQjRvb2RZ?=
 =?utf-8?B?eXRYRXR2QURNS0tRaWUvMy9xeDhtemtxYjFlcGttSzRUWDJVVTJ4SSs4V3Ft?=
 =?utf-8?B?eEFDTHhSMVU0RDBYSzRKd01CQ0tpUzNjdGpLTndmdGRNQXhCOWV2ZEtYTWNE?=
 =?utf-8?B?SFMzQmJyWEFWZEs3cXBMUDdUVnMwWlV2YUNWRHJpWWJiSDE4aGd3QWFhZzJi?=
 =?utf-8?B?dytYelRKbWd2dGo5eXJQcHczdnBvSGpkZzhlSStlTHIrUTE4NERZL3ZpSko3?=
 =?utf-8?B?NTZGSDB2eExYemFQQ3REbE1jRDVlaFkyc2tTMkpjZlJma2E2VWNuMVZubHFW?=
 =?utf-8?B?RnBUcXp3WDN2eDRVSnREbmlQa3laN0tGTlZRcFZkNUZ6NDZPVG42UER5ZFpW?=
 =?utf-8?B?S21LTGdIUWN3Z1FBV1NxdHNRVnplemhMTXoxRXNCZUxPc3lZVTU0cE1RaUNi?=
 =?utf-8?B?cjVweURmckU0MGhzL09iakhyUDNBTUMxaHJJNFoybDFURGpsQ3llQ2tUSGxy?=
 =?utf-8?B?UEY5Mk12bmdIaE9QUitiOHBrUE1VdmcxWnBhTW9HNytCUU9MMXJ6aXprZDFC?=
 =?utf-8?B?UDFNZjV4SEpaRGZyNmZoNlVDdXk4bGNTbHhsdlBsL3pNSStQcHdqbENaS0tI?=
 =?utf-8?B?RmNEUEJIblB0NVc5Ly9nOS82aS9xMVpTVXhaVk8rTDZNdGNyRXVpdGZNdytu?=
 =?utf-8?B?Uk9TN0tMY0VrR2RyTXBoUk9IOUwxOFhHR1BLbnYyMXAydDhQS2xOZEZ6VnJF?=
 =?utf-8?B?YWxGbGZnNjc1cVdETHk1UWIvc0UxeFBLMHM2SnVvcnJyQXVab2V0N0swYmtP?=
 =?utf-8?B?MFUxRlBJLzhBZkZXd0Z1OHZ1L21UVmNkNHVldGxHaUdxYVBiWWxQNENqT2g4?=
 =?utf-8?B?cU84MWFPelp1a2dsQkFPeHZLSVUyb2FwdmNsYmNKejFxSFM2d1EwUlRkY0VM?=
 =?utf-8?B?WGEzYVNONm1mY1Zwd0lSK3FLMWJZNTdyOHFGRXRkaWdZOW95VmloNVVNMytt?=
 =?utf-8?B?Wk1PY29Lb0pVeC90ejVVU3ljNmJnU2dsQVptbmF4TFQweTlmV1VHYjMzQm96?=
 =?utf-8?B?cmI1dUVMeXgwOSt5Q3gvNXFYMU0wMzgxcDlJR2oxdmJIZ3RKOERTK2FFOTk0?=
 =?utf-8?B?R01Eeis2cStNbVVGUFpkZDd3WjJDbWc1QWNhdy9FMEVTNi85MTNKS0F1RXYz?=
 =?utf-8?B?Qmo3aWFwU29mbGVVaHVDSTV6QVlVcHZ2clJvSmp3cHpUUWp2ekFvSzZiajl2?=
 =?utf-8?B?RFUraUJiZHhYN3ZKalZyNHBDcS84Z091SGNxTThncmdaOGxqcjNFN01hQktx?=
 =?utf-8?B?R3RpaWd5RGFOekpxOWdHMGtlV2xwOUJkTk5rVXJ4SVFEWkJuMytxZHZJMHVZ?=
 =?utf-8?B?UmNqMHpta01teEZQYmFSOHIrcHM3RllIMXVkZ1VtWnZoWWR0Q21GYmUvdXN1?=
 =?utf-8?B?cmZtZHJUMzRJRWRkNFB3NEJDdUVEQVJXZEdxQnY5YXIzbVE3TS96WkxhWlBa?=
 =?utf-8?B?UmFzMjBRbEIzcWZleUNVL1hSVXRSQ0ZFeXdRY0lodkxlVjZaT0dFbHNrQ3h5?=
 =?utf-8?B?QXp5aDRIWm9BYi9td1R5LzZ6S3J6Mm5qTVhWZVV0UXNkb0FzQUhIUDZ3dkpY?=
 =?utf-8?B?QWRubk1BV2d0UmJQVjRKWEhhd1JxOWVickplQ3JHVmhzY0lZWm9XM0V0V2p1?=
 =?utf-8?Q?n2tQxEy13WNx6dv2WmbniTAw4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e6c9cc-9601-4423-b029-08dda84c1e55
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:25:04.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf+L7tJsHngO+Al+MyYrf5DfEZtfry0HUzr96ZntrGnokmNEAtVw51/EqZNZiBnDk7xkteHxObMCpPfov5ePmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5785

From: Jan Kiszka <jan.kiszka@siemens.com>

If we get canceled right after the cleanup handler was pushed but before
cond_wait_prologue had a chance to run, we still own the mutex. In that
case, __pthread_cond_cleanup will lock up trying to reacquire it. Detect
that case and bail out early.

Fixes: d282a337a069 ("Posix skin updates")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

And another one from that area. This one dates back to a commit done
19(!) years ago.

 lib/cobalt/cond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 7de4d38cda..2d11f768ed 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -218,8 +218,13 @@ struct cobalt_cond_cleanup_t {
 static void __pthread_cond_cleanup(void *data)
 {
 	struct cobalt_cond_cleanup_t *c = (struct cobalt_cond_cleanup_t *)data;
+	xnhandle_t cur = cobalt_get_current();
 	int err;
 
+	/* if we still own the mutex, cond_wait_prologue wasn't called yet */
+	if (xnsynch_fast_owner_check(mutex_get_ownerp(c->mutex), cur) == 0)
+		return;
+
 	do {
 		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue,
 				       c->cond, c->mutex);
-- 
2.43.0

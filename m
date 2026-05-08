Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9F2C0303
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249738; cv=fail; b=Itn/KWJdtOi8O+52iLyRhBsrVhGEw7Gq2Uwjeaa83XtLWb1ku1f/+ZH6rxJZ2vNZAlpNSP2PZCKoStqdIp3Kp4i5LcaK8nk8D73D0agiKmj14at9XP5dKfXldvl8QHpAN6zZ2YH+1iYxupxmSTqfA0SIEoQZrfsJIuX8muEMLcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249738; c=relaxed/simple;
	bh=wHIoTvghNn0ZCDbHLnS7fZrmIjPLphrG/tmoxG+AHEs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jvZkqE4oNYJs+IF1AZQ5C58DvNvUOc5z6mANaffx8UemdjUS39NmNHVtfNO0Ddi4/VZZv5v9skrsy5vd/p/2m+5AYxRVG2AuPLtkVH24UGB5k5SAwhS/8s37jTI19BjmfpmEPPx7chUC2B4XTCPhmxSUpZeUbuz8IGSxXigyMnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U1O5xPoK; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U1O5xPoK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv7rFhafeqa8VF8ym/QtY7fBIkN1K1Nl6zx0CsqrCWrf63dzblCA5AXDq6IYBq5Uc50acZHpJym1SayiQ6wOmbNs1Kl2NfIf6zGHlFeaHE+v5Uu1KfNu/AjKAwn1HDSdSGxRusNRy0ZZlKTw+XRS/zUmGu/PSiEb8DFj6BCUI0w4HQWLCL+jlz858fs6kRHKjq+seP/WnjxRmMoVvBYK/sJTna7Q/2KBGmI3IxCokVsDfgL2jajFQHArwW4tIDA8xmQ/mvxAM2cLUb4VEyxJyOfdFtxoNbOawkvi3ZvGhx5S/G/tsF+6MUkv/SdcTWQpkKIMP10/0ClNfBpEw7eBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwPJQF8Q+JhtkzxSO6TIIx9yfn2oOVCXJWlns3866hk=;
 b=vGUdJzXOnVs+3aEPiPJ+0zm0/y/bslc4TZ9ZjVjRFxTWZLlfBE1KccEVNHQRDa9Z3AH5pWVNlGHiuPqd0ABVSPpNVjGS0KAEkwJqXKzzmytVIdf4YkFjha64LVkGXLJvRb3oYxopYPPJJ8b2INSxVn2dEav2i5T9t3UQ29YKtokTutxs8Wt7Oksl8KLHX6Lmqh7DBC3B3Vq8MoYBSSWo6+QmQQkCD7La6QUufuGxeIT4mqsk/tGq6i30PRMPXx9EseTPuBERrr+v7fopbuvdU4bo9znIAT3h0CCTaQC/dSThwlssPIBm0+NhPDCbqdOhHFxg3nzWJDx+Wv07AnVvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwPJQF8Q+JhtkzxSO6TIIx9yfn2oOVCXJWlns3866hk=;
 b=U1O5xPoKE2UYqFc6G5PSAlXQBErcFT56cJaEYvsB4UT4yO2CNaHTryllXiFoonJV5vazusOey7C60n9xJY4ryV8B13H/XsCZb8I1gqoA8bU/2+kQggTaGDdIG4dQm0OBtV7r1NeJ9QQAMGN5YsOUaywFVSN7EZqvqWxFT6i1E67SzVIqXDc2XeB1qip6Fij+6O8FTmEIxUxPGGIVkg1uGknOhpmxoRQzI8QbJek6b7iG3E5z2jlUqghcSAmCdnIzg/HC7MG+f1428w0gX3GRmPAvStoIfSdwhX3Z0uRpPGfGJYq669wWrkzxuckOUP5ztw8RZVtkN7LKWmlNZ7bZHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 14:15:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 14:15:33 +0000
Message-ID: <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
Date: Fri, 8 May 2026 16:15:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d53860-5cbd-4ae7-07d0-08dead0c44b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	NMxFBrG5QCCTJwE5ysVVXwyLu1y5aQO6xGcNQ8xaztqwIEb/KwLcFyQoSPd+AV91uug00Mppm6LBIJVYmrRqvtcN07pbbow0NH5dxrS0Q7TaqV+iySNkc8XeAG2209lYW/Mc1tzjyUynm2xDvxHbU+8MaAcqbPW0Fo9HgTDx6k/vWUNp1azcAkR6jP01v7PKkBnBPBAe8UrDwYvkNqjduNQgCqPD/CW/mIVCOvlBzemuoDpBz6VBLoi0rJCDCtauZWOdTwY78OLEkFBciRjaNX2YpB085XaEdMVC2xg3ELwrto9/LpNmg41mupwpIIUPewY9pqFCOfhevbzmhZ88dUNHTj6QTp8vBeHMjgxblOS4qIQxoiwsqLpJKULbJaZN4wcj23gT/zPUyQjBctc+VpNNCTDKJ9Fx7rzRpNMe1WFrQzWCc4WkUcKsu2gClEYmyrQ2hdI5ZGH5yZeySmOlaSad523TmGkEDducNPpMs/yIln/hKgL3zjK6VKG9ok2yg1FdymOx6iYpGp9uJyJlLA6uqoTWkDBeA/nZHtFVF4iFvih1hdStAf4hfzsFyNYYBK1jR+5EMJ60x1lLyAyWL83a/gAXezBmb6R64e00HTxlZdZKjI+kaiXTHoYiqhQ/+KyjNGU4GMvbVdSnA1jYZ1WrciwsV2dAQ9bKIQmEkeilzqSATHxM/OAHLZsWnTvP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2h6c0NIL2xOSkloQ0xoL0s1N3hMQzIzenJUWWZVK2w3QU55dmE1ZUxVdFFT?=
 =?utf-8?B?WkxPVXcxSTNXTHNqbUJ0aWM2UW5WM2dnV0o5V1ZBblNxSG9tWWpiQWI0WXN5?=
 =?utf-8?B?VWpMUW5aUkgzamo4TkF5UzBSSklHcTdwcitFWE9jazREbGp2QVZaMFlIT2M5?=
 =?utf-8?B?RjdzVE9MaXg0VllNWXczYjdVVUgxL0FxZzVsWFB5TFg1TzlYaVk5NkJJbjVt?=
 =?utf-8?B?RkNhSGIzVmFOVXV3aDRWV0VFVGhmLzFORXJVckVPd2RJR0FHY09qMExWMkVG?=
 =?utf-8?B?VUoxczQyQklhRyt5Wk0vWkFQbVdGSE84RGxkcEljdXBYNGNWUkdBeGhSbDE0?=
 =?utf-8?B?Y0NFNDh5RENiNW9zZktFZFllb0FGQlVSWUhmZmdONDdSSytPWVIzVzZIaGhu?=
 =?utf-8?B?bkpBd3lwYXM0SzFqVzZrRnFjaFVOTmpocERXK2lTN2JCU0cxZmExOCtBRUJ2?=
 =?utf-8?B?YU0zMmVsd2ZhNk1DVHFOd2NTbm41aVA1V3JjWWtadmpnZndVeS94SHIxOXlj?=
 =?utf-8?B?MGJsTmVUejBwaXMwYzBiQ1NraWNwdXFKeUQrcjhhKzJWb0J5NTN0emF3RUda?=
 =?utf-8?B?M3N0WG1ndFlQMld3SGNXdVNDTEdIZFNUV1krOVVOczRZZDRsWFBoaHRLTE1p?=
 =?utf-8?B?cWJObmxwUEtlYURaZzhlMklGSlJtK09ZejlBbTRsSmdiaElOdERkVlpyRXJh?=
 =?utf-8?B?VG5VM2NoRjNVd3FPbzdESWExbXMvUWEvUDU5WHlqb01FTGZEZDhJb2xBbVlm?=
 =?utf-8?B?ditkVmpmeDkxOHpsWE9qblZXSjFRaUc4bUJKcll0MUIzSkJTTVNBYjNWMFdD?=
 =?utf-8?B?dUVRYlltV24zTkVGZ3ZReUFIUSt6ajEyY2YreU54U3ZIMEljUEQwZE9uUnE4?=
 =?utf-8?B?UDllakNZdTZmNGhZWGxVUVVZYTdDU3RTQlRLUks5Q0ZkOVU1QnIxSDdRY3Nh?=
 =?utf-8?B?VXFWSzFkUWVSR0IvTzl2allxNkVSTU5ucFE3aUNPeWxWUzgrUlFKTG9TM2Z5?=
 =?utf-8?B?dGpJQU5KS3ZTak9nd3lPQVYyenRKSloxT2o0U3Q5eEdYMTJtNjIzZzJjT0xv?=
 =?utf-8?B?RGRXeW1QWHZMbjErSDVaYjd4SitQYjMwaXBpWVkzTjlGRGpQTWVaZFRHa3Zo?=
 =?utf-8?B?RmJxV3BKM01rWmpHbUN2QzhpUmw5M0EwUnZqWTBMbnFBc3hzejdaNXZXSUtD?=
 =?utf-8?B?RVF1WERMT2J5QUVZWHkrT28xNXVENXZEVkI0Vll4QytsR0hVdVJSYlNHcURI?=
 =?utf-8?B?ZmFBWUw2VmVZaVhQR0ZmWjJmTnN5Mmxqa1dDSlNtUGJneTlIVDQwTnloTHFZ?=
 =?utf-8?B?TTV1eWtiYlZNMEcxWGFWdlZSV1c3T0FXNGdjQWtWMkdtM1ppRmZVd1l2dkhB?=
 =?utf-8?B?OWk1L1hqZjgzczNPUUdaNy9PL1Z5MmRIbFBrU3h0NHE4M3FBeGszYUVQY21r?=
 =?utf-8?B?dkNHLzM4UXF4MGhPMGtodVdWOURacVZ6Z3NjTUkvODUxQWJ6S1pJQ29kMElJ?=
 =?utf-8?B?U2pFVlpheXFGOWp3aEc4TzdCOG96eEZ6Y3RuUkk5eE1tcllDM285OWpLalh6?=
 =?utf-8?B?RTFZTWJOMEhHSk9EUWFuRjlYcTA0L1g4YWZPUkM0bGwvcnpJbVFWcWphRzBr?=
 =?utf-8?B?Y2hkclFHNHhYaTRyVGNJYTVHQkVBU2pZZldDZEJHeSt5L2k0WDZzZ25hVnNN?=
 =?utf-8?B?Q2UzQWJrZTljN2RDSkRlaWVETnZrV09MRnRPWXB0dk04czRnV0xKakVIVzdp?=
 =?utf-8?B?UHpFd09DR1Q5S2J0N0NWM09uNjU3SEZWRFNBTUcrUk1mZUxUOWpMQ0ZRZUxO?=
 =?utf-8?B?R0E4ZEdRS3hRMU1FQjNGOVlhMFgrVFpjRjNhNVMzaUdBVGQ0dlFPdWJFcHhI?=
 =?utf-8?B?SFIxQWZjYTdUMXdGdElWQ0hUOUI5M3dnNnJKU3hQNW1LOGVoMmtyVnZ4VTZy?=
 =?utf-8?B?WXNIZW5WaWNiSDJWcGZKaElreHJLMmRUUFFxbytLQUhBcnJKbEh3Nm5FN2ZR?=
 =?utf-8?B?c3RuNGVOa053V2lacjRPS3A4NTVTYmx1MC9Jb3dGODJOUmpvYjVPK25TODBL?=
 =?utf-8?B?SXhjTWxxYndFdjI2K0NoYWIzRk4yVE41RFVUeC9UeDJvNjNSNEdIK1luR2xY?=
 =?utf-8?B?eThQK3JnTndEOWRSWkpSSGVOdW5SMFo1b21SdDNnKzhJZ3l6a3lGMjBSSlZh?=
 =?utf-8?B?Z0Y1S0FnMFdGMmlqTUJkUWZjdXFWYzkwWWV6dnlvdHRINWNTVjc2NTRMMmla?=
 =?utf-8?B?KzVraEF2RktuRW4rd0l6M2Rsc2lpSzdYRHpKSkJqMUhveThmWC9jbXR0M2RN?=
 =?utf-8?B?VGZrWHRBeEJZVGdiYktWcStOTy9yY2pqVjQ1STQrdHlMZkFPdVZEazcwUXRo?=
 =?utf-8?Q?1NBP1gUmjBpbyQ6g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d53860-5cbd-4ae7-07d0-08dead0c44b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:15:33.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e/6nqhdivcfeVHhk/WrNWPAzjlj0MlioiNWENBaudpXSBZkJxioVFQ+Sde5EyDRcm3Jd3v4CMGrGASID2ow/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7531

On 08.05.26 08:22, Florian Bezdeka wrote:
> Hi all,
> 
> This is the missing cleanup of demo/, lib/, testuite/ and utils/ that
> was partially handled already in the past as preparation commits for
> bugfixes or build optimizations. I finally found some time to finish
> that work for the missing folders.
> 
> There might be even more potential for cleanups inside the include/
> directory - and as a result once again inside the already cleaned
> directories. I skipped that for now, as I consider include/ as an API.
> Changes might force users to adapt/recompile.
> 
> Tested against Dovetail 7.0 already.
> 

How did you retrieve the header needs and coverage again, manually,
script-based or AI? And what do you suggest to maintain consistency in
the future?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

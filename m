Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC2AD24
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266580; cv=fail; b=O22ofbXLpSo+waolRgbf+zBqxj+m9AWYv2oFg07wNVeq9z+PN+DkytoAPOV3o9EmJ/lVOcIqEKonYgmyqNPXIOfPQKrXrzgF8r16hev2jLYOebHpi1vKm25WVNo2GVJybywps39DA41jn57UDHYo2PSxSKbl9ZnoLqqCm6sVU3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266580; c=relaxed/simple;
	bh=BMiUv/jIvsihAajVLHs57d3urMi6V5wbh/zs8csWoCs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLAgrnZ3leaAssOGIR7LGnvGGxq/4gfdUi7yR0Abo/oS3Ed1lDLNAoSxHfWgt6fb/4ypSs/lLyNCc4v6YEILUaaSalOuoVK9v9jHKKUpulHfPQsmysbSy//7jjRJioBRmDlrUHB/Hvek6yJPKfv0IqjINXMBrt1IBYRDIqngGn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cphSMsiW; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cphSMsiW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxaeSrxBix4sWCzGMfti4eLdWsj2urYR2vnlRa/mrjqjgdwvxPNZlTWUq4evzUGjrcJyN+HNMd8PcZLbwcRsMaPysxJCEtCwvt52D5Oj8WN1OGK0VJPyG/GN5jN9k860hwYIY4ZG+wmLdgY7dYVFimWKwts0Dqm/aULPzcSuP0qFZAUn4xOR1E2POHMUG20189l2LP5r9+Mub3sT9KdJoco0xgJT3XzFQ9sUywTe8eTsmLSnMsD75v3X9pZcpnHCWCWVD1CvTNY+r65r437M6cXCbYTL9qW4E41KM8ns54xMadJioeZ3fX4UVSmf1rUSUVkdz8f84lV77Yu2XDmbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9cwPVfAKdUxiFM3IvSe8ECWDMd153KEH0NZ24aRdfo=;
 b=XhUCRLu7VPsLpGQhx3TBKFNilEA+vKDrbda654a072owOd/3hfZQBBolOdUC5dk/uH1yBYZXrl4T2LrSKnZQ66z+ZWB+WbWqMacQ+/Bi2NaU1T505GcnsEvFp4TuO93MPmvjAdMxeH05dmw8lBPilreAEmpT1XsFjPRmuGFPe/P8rgbdwKvB7fwjtYnj8nE2EHypHtrZE0b9cU1jJ9qdfurQo+xwZUrxmitYLhVxjDTwFfw/V83GTYWZxSi4CdtHHJzY36/5sabLOgUwygSYbJjqrF4QHuC07soKSVvIIO0ket1ABC8DUtIJ4qUihiAKONcSLm9HGWwV5C0dNmjGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9cwPVfAKdUxiFM3IvSe8ECWDMd153KEH0NZ24aRdfo=;
 b=cphSMsiWnOBJKY2xil/YhiAq485HL1C137zv7qofChfcUWaSG3gOgQXS0rAZD/xo+Nz8dg7Q70NoUh65m7ycW3weOboe6Q/VKP9vqZB2LIWtCJcJ7WWXEnOmZQBNTWwPFF2kk5DAPw/Ke85MHQ5X+aM9NCCh6nvtwbAiqAqOG9J2RP9aImKykkVawXOuktrSnpk/nseqXaxmH45kSvib5bpQeH05uywWjE9/7j/b64JkynuA6z4Vs9/s6+EbnS9hkELOGOYBSqGoSRidPCyY5sY3H/hNnhr7A2CORuq2D5DYTd/WhtJG44/3rNNgBa2stUdCl1VhxWUWQqPuTqxx4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:22:56 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:22:56 +0000
Message-ID: <cfd2c126-f5e5-45b6-afe1-5299b04f362e@siemens.com>
Date: Fri, 19 Sep 2025 09:22:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 05/13] Update isar revision
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1758210955.git.jan.kiszka@siemens.com>
 <91f80fd207c8b717c02205ddfa6f9e40663191f5.1758210955.git.jan.kiszka@siemens.com>
 <bd88da11b8d2e32765f8b779093f1cecc9f0a1b7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bd88da11b8d2e32765f8b779093f1cecc9f0a1b7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b43d87b-d6d1-44dc-4d6d-08ddf74d5aa8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FuMXRPeEtuR0w4dW8wTjExam14VE5MWSttNDdIYzBuYlRDMmd0aEZXelpX?=
 =?utf-8?B?UVU2aFI2eGVQbWZVbGF6cStacEhIRzZ6RDhyK2FodHVjZXZuM3VrVnNLRm5U?=
 =?utf-8?B?YmZqRUxLZ1BKaEpyaENEMjhJaDJrSk9KT3pRajRDMkpxL3V6L0xhSWcreGZI?=
 =?utf-8?B?YlRDMTlsRVNiWk1SNHdoU0Z5ak5VWUxMVkFyZ2VEK21QUGFCeC9NVHg4M1RN?=
 =?utf-8?B?QzV5VWVRZVdsTnQ0WWZLNmhhVGVUMFUyREk4endqczFhV3dTaVJaVnRHQ09a?=
 =?utf-8?B?R3lNdzJjMk1EYUVwOHR0WERPZnRiL2RQK2dJTjMrYitCUnY5MFVpdjdORTJ5?=
 =?utf-8?B?Q21TRm5VaDUwUE9RSkRhQXNUMG5wZG5VM2UwdWZjL2Vvb3QzWXl2aDlXcFBX?=
 =?utf-8?B?a1ZlbWtaVTBOR3psenZMNUVBQUdkVW9Pc2tGbHdMM201djJTZ2NFak1mQlIz?=
 =?utf-8?B?MDEwdGJhL0svcXVOVkRJQ3lnTUVjeDAvQWFkNnY0OUdWUUxvWnVkYlpNTC8w?=
 =?utf-8?B?c3dIR2Z6cHdXWUxJMGJrUUVvYVhOWVpaaHY5RVMvbEduZ1hjdUdUdkFuc0VE?=
 =?utf-8?B?MzBwaUtWUTFBdUJWK3hDeGtNQWx3VTJxQ2FBblNpWlhhWW9VL0l0djRUVm5C?=
 =?utf-8?B?MFg0SlhGejQ5OWRBa2FlUXNwSkJvU2F5NFpIMmdGajJkektuWU14NmxmdTdR?=
 =?utf-8?B?citWZld1OWFzUUVibEhqZjhCS0ltOGgxMXpuV1FoRThsUk9JdCtWeVZhZkRI?=
 =?utf-8?B?TzZZSm1UVlRpNnNZWElvc2c5WjIrN1ZTUTQ5SFA0S0xYaktDNnVEbVplcmZL?=
 =?utf-8?B?VXpxVWdBcnZoNElMRUZ5am1Vbmd1alpndHp2OWVWLzFzckYrWWZVNVZ1bmRE?=
 =?utf-8?B?cjFQSGtXaFhiUVhmQ2lVanF2Mnl5Tm0xUmU0OFRBTTVIcE4rM1U3ZElXc2Z0?=
 =?utf-8?B?c2dqdnBNajF6MS9rWkkrODcxaktLajdPcG9FYVhLSlRXRUhYL3I1clRHNCs5?=
 =?utf-8?B?clBBVmZwSHB6aFJLWTJkSGxNZC9ma0lCUnlTOThXMDVnY240UkVncmxzaEdo?=
 =?utf-8?B?clM2M0Yvb0wxQkxCZXh5T2Z0NlBoemNNa0N0UXRoWUdEcTJVTzJ4MUsrMUdP?=
 =?utf-8?B?WE5Yd1FBSmxLNVd3ZGdldzRMVHgxcVNobytSU3AzNnJTTm1QZU5PeFVhMEpk?=
 =?utf-8?B?Mi9tSkNVY2hPYW9IQ0l5ZXlabVIzOWdPS21mK1NDT0VnWmsxVjVCbm5pdGJM?=
 =?utf-8?B?N0Mra1hYTGlGd1huOXVIYnVyTDFOMDJpeEs0VndCbm1CWnNJNlBxYWlhZ2Rq?=
 =?utf-8?B?V1l4VjlRMlk0cG5LVGNFVG0xam1GTGNTL08wQzRoQkFZN0VwL2l0Sk93Q0Ev?=
 =?utf-8?B?dVd4bUNrbFBwa1ozZEZ4QUV0dWl6WWsxU1VrZm5MaEpENnFNMnJmMXV0bzQw?=
 =?utf-8?B?aHl2eWFKRTArNlhuNzJ6NDBaQ0VwT1g4dzNRY2t0bGxLcHVMeE1oQ29nSGc0?=
 =?utf-8?B?VXZkb1lOYlduWVNhb3Fmb01rcU80OU5rblpRa2NmaElYc2dsYjM4NXRoNE1W?=
 =?utf-8?B?QzlsSXlvc3JveC9mUXVDS3I3d2RFWEJkQ3QxVWtYWmV4dEl5cVhXWklmbWFx?=
 =?utf-8?B?cytyQXRHeUtydTlpQThtcGR5Nk96dDk0bldUMHJaancrR04xZHRnY1VCSEM4?=
 =?utf-8?B?U0ZhWHY2ckswVklmSXlHdzc3TUQzaFhpRS9mVWlPWXQzQ3E1cGxLNFYxRVJW?=
 =?utf-8?B?dGZkTGRYQVlJQ282WHA5QWxwek1JaEdaak5yUVhiRm13cjFCZzAwWDF1d29J?=
 =?utf-8?B?blJSME9JdHBTVXI5aTR4YVZZTVQrR0NzVFppWFFGRGtUR2JiejFLMzdLNkZo?=
 =?utf-8?B?OVVVeGlaSjgzUG9HNHdLUE9mNW44OG8rRVd1andxU281TUFIdEZIMlFoakhU?=
 =?utf-8?Q?DH/z0XcIVSE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUdiV1l5VGlGczNWU1EyQ1E4TjlvNXNzMW5ZN2RrejlCRWJMdE9BK0lheWd5?=
 =?utf-8?B?NUZOWFlmOGplYmVTT1dZUDZKbjNwcmZMT2JGZWlqMkdrckFUd3dEL1Fyd3dY?=
 =?utf-8?B?ekpRUWM4YlduZzVqTE52ZUtwOHd1ZDVxcjFOc2ZkMFpZcGdKbDRpeE5rODY5?=
 =?utf-8?B?cVdJTWNmV285cURvQTZnMk9BZEJQcHVDd25JaEZJT1A4c3ZqSUFXME5XZGFY?=
 =?utf-8?B?WjE4Tm84YkpVTHBtYmhkVEk1S01TSi9OWlB3bjAzWWVlb3pveGl6RW5JaEow?=
 =?utf-8?B?YVJZTEV6WXNBMUhsU0FySGJWN1NtZktVUlNhTC9QQ281Y3A4WGtjQmVIbGtw?=
 =?utf-8?B?cWRWZnRNeHpmNVp1WGNia1kvK09PZVd6bVRCa3YyMWx3L3pQeTdmNEVyTk1W?=
 =?utf-8?B?RTBndEhNREhSMlB0SjBFdGk0TGczWXNham9DNm5UaHltR3BhK3VGNllBRmp0?=
 =?utf-8?B?ZjdXUG8rL2dWSE5DYzZYcWlPVnN6ZUhvUmdnS0g0N1hLM0tlc25HK0lZMlIv?=
 =?utf-8?B?MzR1UmlwTDA3QUg4ekFBMG1XNmxpZ3I1bE5jUCtMSVNXWTZud1k1T1I3SmFa?=
 =?utf-8?B?VFZQZU1lOVBJMWdlQmxmNDI5VjVPMHZMTC9IZk85alpWL1Z2S2xmN05yV1Q4?=
 =?utf-8?B?K1plaHd6bmZ1d1ZNQnNxdzRUVlRUc3gxNC9tOTAzaFVyRHRnV0R0OEdoUFFU?=
 =?utf-8?B?U3dHOXhYZStIcm1SbC9rK1N2MEczbmM4U3JQVkhVQnkvM08yeTh3Q09FR28v?=
 =?utf-8?B?dnBjS1daQm41b3RzUFZVRzdSeWpoUmNZTHlTaUpDSHlwcTJQdXYzMUFaYUJW?=
 =?utf-8?B?VmZrODhwMzJ6ejR6TkVJaGNoWVN3cnlWb0FBVnBoNFBXTjZVaHg5RFZ1UmRK?=
 =?utf-8?B?ZktSeWNlckQwTW5FNUQrTnNXWjlHZTFwc2Q3eGVZenFleVoxY1ZMZGtvVDZ1?=
 =?utf-8?B?elo0dzZ6SGc3RDh4ZXRTQy9YQlpCRTVON0RxNDg5WkVxSTBwc0tYTWx6dThm?=
 =?utf-8?B?bW1WcmNrQ1VER3IzcGF1YzNvaHFTK0RhSXovY2gwZTMyR3BIWDRmc3hXVS9S?=
 =?utf-8?B?S2dTd3FYTCt1REM1TkJZYmxFS1pMU0VpZ3VSL3drRmRLN21iNHlXRGFZbVhz?=
 =?utf-8?B?YzZvclpkelUrRWJnL2pRZnRvWVp4V1VaZmFsK1FPSmxVbmo4T2RmZWlsbjZz?=
 =?utf-8?B?RGZ4R0h2TThhSFVZTlJCeElqNUI0ZWswd0VoMTdlak5PSmZtVk90TmlUSFJ6?=
 =?utf-8?B?NDdMUEZIR2h3aVNRcHExZUlqcVIydWZnYndSZDRJWGpwbGxMckFOQWpyazFL?=
 =?utf-8?B?UmNjb3JRQ0g4cXRNcGNJODlaSlJYVXhwZ1o2OGpjNGJERlllamcvOExsSCtX?=
 =?utf-8?B?MFI1MGNURjk1a1RHemtYaTV4SVFKcTlXT28rUndxbU90TzRkY0Z0NmVXZWIy?=
 =?utf-8?B?NittODRROXorYXoyQlFqRDN0ZFJrWExaOUFZVG9ram9YaWJaM3p3cmlnbVdk?=
 =?utf-8?B?Q0lrV1IybldpRmVqbFIvRHFTR1lYYU9NcDRnRGxLZ1g0ZU1nL1Q3L1JCOGRu?=
 =?utf-8?B?aWw0MnFTaXRGUGJ2T3czT1RjVTYxWjJCTlRkR3NGeUVGTXd5YnRBSW1CWnB2?=
 =?utf-8?B?bG95OFJNaVFEU0s0cmFhNUlidWdsQ3pQdHA5VnluWWdweFcxTUtvZU92eHpK?=
 =?utf-8?B?OGQ0c3NaY2kxL0VBcSt5OUtQeEVQeHQxeURPVXMxQ2xGVnFrSXI5dEpTM0ZX?=
 =?utf-8?B?TVY3Ujk1UkYwSjJtUk5GVmdjVVFuWExxNW9LeWFSMnZMM0FzWTVpVThVZDVr?=
 =?utf-8?B?ZVVtSkczSFJ6Y2JIZXl0ZmNjZ2V5SkQ3RUtXaWgyZ2JYZTM3MElNQWJNbGJ2?=
 =?utf-8?B?dUdqQlZhQnNmbTdSWmtjNCt3aHBnVDQvT096RWJMdlZOSVk1eG10cGR5czdY?=
 =?utf-8?B?STBsbnRaTmhXdFlCQUVyZEF3Zit0UU1tSnRqdGxnZnNySkpaMlhTOE5GV1pB?=
 =?utf-8?B?bHhMVnN0UHFhQk1UTXZ0UEJpTVI2UVE2Wm9MTEF0d0phNmlLazFaOXFzdU0x?=
 =?utf-8?B?Zm5rTlAxc1NRWXBUY0Eva2ZySHlPSThaaXdOU3F1bmM0dkViNk9vK2pjeldG?=
 =?utf-8?Q?heEIH/py3EA3dDWEsZOq5iDPq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43d87b-d6d1-44dc-4d6d-08ddf74d5aa8
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:22:56.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE3MPvxHvJxJFIkv1FTfj7X+PMK4h28Ouy6dFjGzi8pbAVzdtzMsCqGZvMkTzxPxjajA15jWs3tpg/8ruS0tYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048

On 19.09.25 08:50, Florian Bezdeka wrote:
> On Thu, 2025-09-18 at 17:55 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Required to move to trixie later on. The two fixes are awaiting upstream
>> merge.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>>
> 
> [snip]
> 
>> + do_prepare_build:prepend() {
>> +-- 
>> +2.51.0
>> +
>> diff --git a/kas.yml b/kas.yml
>> index 2020ed7..5d66228 100644
>> --- a/kas.yml
>> +++ b/kas.yml
>> @@ -22,9 +22,16 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 483093e11cd722f0c88dc2fcbed1e937fc0abb60
>> +    commit: 48a7eb4e0e9846e7e5bb44e52730d0bf59549a67
>>      layers:
>>        meta:
>> +    patches:
>> +      p1:
>> +        path: isar-patches/0001-Revert-linux-custom-support-to-add-linux-libc-dev-pa.patch
>> +        repo: xenomai
>> +      p2:
>> +        path: isar-patches/0002-linux-custom-Add-missing-Multi-Arch-foreign-to-linux.patch
>> +        repo: xenomai
>>  
>>  bblayers_conf_header:
>>    standard: |
>> -- 
>> 2.51.0
> 
> The isar update pattern again. Bumping the isar revision comes along
> with carrying patches. 
> 
> So we wait with merging this series until isar is in a usable state
> again?
> 

Then we also need to wait with the trixie update. And that would prevent
benefiting from more findings via gcc-14 already. That's why I decided
to not wait for upstream.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6D258A
	for <xenomai@lists.linux.dev>; Mon, 26 May 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249055; cv=fail; b=kmmXXa4MAS1NEtU1y+jha0v44K0c/BEdUEXW21NsKo/fRizYFiRiMJnnJ5BFxg7T/+DPVNDiD71BQxcHF1odGDrGp94/c4SddpUwaKsPhiNBC2SToXFoaM4+12ecoBEcUr/bQC+GQY/Ud04FhveOKT8mTDFp5u3rd0QpLX8pEgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249055; c=relaxed/simple;
	bh=QSW6LO6NPaLK886V0F18fNEvpDKaDWLmrHZPcy0xzxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JVOPefe9wK4Zm8jqkJ17NKxR5pziLPCaxfQle1D8N9RZrb3EnlPKEOwUp+UUbu6KFba/+kwIhXuvVhuC3FHOzmtW8AAmRz6ZxaNYrmkZe8SJIrF2xPaUdifOrscwTzbhBmY075SBJvDU3mgPr5O16llbcImVOLKWmwZnEDp5DlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Z0rpetcX; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z0rpetcX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYU7E5nxX0iMM1S7W6ZnXt7noVaKsVVF8dGDFWlzvNTqIGfwNdu4iFIrNgcJBk8xe1BYRFillq0vHq3sZfIK5uFXLPC+XspdCjerwV9xIbmID6NOHR26M0dxtTBjdb2Y3fmab8p3haHoUhWgu4FgZedpw9ruT7MOQ09z4pCQKFIg8XgzRy0T2WMUm9Hg6myy1+j3IpyCbwmyec0UX1fHK2i3f9KwjCT4p8jy5s3ApjOXG4BimCTUvLgkL6Jc30RJWM6BQD847xqY6AB8XnOpVHzvBJyUl4vytjsciSYAY0ia0DlmYhQowvM+vhVOZyV6jFRoshRw2yGz9T7gbo3B9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Becrv/fihgc4ui9fbGItSCq797G56dvGSyx7we1EHA=;
 b=g2622y5w8Ig2IhAgpJi7zigNu0QvVU0/8tMSco2FwNpIAkp/LcJAa9te0GxZQLAQbzI6A81NbzFLqc12jzeNhxsoBWM/ol7AwP2j5j8u3C5VjvP85lZ+WdSQNZYrrB4jzhMdb2O/+mj2nDI8tAfvnIEtfnWlDuq9j5atyw6VxShe3agFnrSbayQuUDcyDFjzmttFn4Koa5FiGXFp2eEsCzftIfwQE2x+CqTdqEgrpn8WBLkFJT60cYMo0IR9Jzaf5lHIaaMiPqfkNNL1Ygsx8gtu+RD/bZ5tcDl0XmjtKxGp5Il0WpgXdmDqkpdaaK/m3SVFiEO+K42PjOt1X+hvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Becrv/fihgc4ui9fbGItSCq797G56dvGSyx7we1EHA=;
 b=Z0rpetcXefUihK6fNTKN6qRq3Z0XoxUlzpT1YTq03IGJPZPti2Hcl4roQhWktoxgi7ig47CLcH3gL0waZR5vkq9uWqQ1xZ8eATs5zf//CrDZWGnXRnVo4ngG/0GJUe3cKnvTYpRo8Wbc41UiP2/CymSxgnRxVvuDDpDqwPGu2kfUKA/a+ief1TH2LromhEz3vNhevMJcdblJ4DZUwbvjY3ICMDI0qrJffNru5oC6sr8lfbVxE45RmcZzz3ikoOlNIbMUAdM2oVDXMpTJE9uprbSQ2znwoW0txIlapsJ7LXbg3eGlhpMba7QNusycN4blgW8RKh3tYULWYV6jpqlziw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 08:44:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 08:44:09 +0000
Message-ID: <a6c8e4d0-3dcf-44e6-ba14-6a4384b52269@siemens.com>
Date: Mon, 26 May 2025 10:44:07 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Xenomai_3=2E2=2E3_/_Kernel_5=2E15_=E2=80=94_Periodi?=
 =?UTF-8?Q?c_task_occasionally_stretches_from_=E2=89=8870_=C2=B5s_to_?=
 =?UTF-8?B?4omIMzUwIMK1cyDigJQgaXMgdGhlIE9PQiBMQVBJQyB0aW1lciB0aGUgY2F1c2U/?=
To: =?UTF-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>,
 xenomai@lists.linux.dev
Cc: =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>,
 liuyang@sinsegye.com.cn
References: <A843D8BF-1964-4E87-A2EE-1B8D8E067BE0@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <A843D8BF-1964-4E87-A2EE-1B8D8E067BE0@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e966e9-e69f-497f-a4cf-08dd9c317b3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3YyQ3l4YjhxMGxqWEVQOXdTY0pZQWxtamNhVkM4ZFVUbjBxYjdLUUtpWlRj?=
 =?utf-8?B?UGpIeGk1MWtSaW1wN0ZmNmk1bndCUzhmdU5lT3pSMVdSTTZNQkQxNXlXWXQ0?=
 =?utf-8?B?M3hpQlRKMU1vNGFUcm1qUG9IeDVHRW82dm1YMVlPakhvQ2VqVUxGcjlQaWhr?=
 =?utf-8?B?WW4vVFNlSllmaXJLbmNKVVFUOGJsbkFrTWFXUEpEN1ZSNGlBdWNueVEvc0tN?=
 =?utf-8?B?ckR4dklQZXdnS3FUdDhpUXFrZnU0TDJXSW9ZZnF2anRRY0FNSEtHKzE2d0lY?=
 =?utf-8?B?ak8wUWFka3dON2o4TE9PUkF4VmhQWmRJaW5ZTVFSa0lCQ2I3OUYxWW4yNUdr?=
 =?utf-8?B?WU1RNEZRMkRyTlpXdmpZK08yRnpGd0tZU0F2Ky9IVGtyRmJQWS9TZTgxM242?=
 =?utf-8?B?UklObGZhNWJGOFlBU1FHL0VuTmtCR1pXczI3dHpFeGE3Zk1aTVZ3UG9kcUdI?=
 =?utf-8?B?cWJ5eFg5TFVITndDalBTZE5NNEtUSWh3L1BwTGV5cEJKa0ZBaWFBcWVrUTFr?=
 =?utf-8?B?cTErWFZlcE1UbkdFSHRXOHo4cXJCbXZ2TVIxVmR4eURnd1lld0p4dkhhaHFD?=
 =?utf-8?B?dFcwTDZkTlBOUExOT011cUtDOEx0b2pZMXd0Sm9yUGNsbFpldG1RdTI5NVBj?=
 =?utf-8?B?WkRaNG5hTkFRVDRRN3h6SDRuRjhKQjZTamUrMHRXeU9hVlFyRVNFSWovdnh3?=
 =?utf-8?B?alN4TXJGYldVNGJ3Uzc0T3RKQi9GS2lHdHdTbXJvZ2t4aUtpUStKVGQ3bHUr?=
 =?utf-8?B?UGlBZWQ4TUhQQktNTk9QREpUd0ZIaWlMRFFVZnhHbHNuOUxYQXdwaDhycVdV?=
 =?utf-8?B?RnFtdnNTTGQ1NnJRdDg3Z29kV2JpUmRMNWcySUMxVllRQ01WTGtHdzloOHVo?=
 =?utf-8?B?ZzllR1VzejZhSXJ5bW14UUJCU094R1NWR25JZU91V0RBbzlvQkEwYzFsK3cw?=
 =?utf-8?B?S1NNckk5R3AvTjlTbjBhN0plRWdWeUs3cUR5Tm9oZ1Q2N1dkbFErdWpvWTky?=
 =?utf-8?B?NEFJZlYvR3F4eS9vekNMM0lKQWhYWGRQTGlheWxCaXdLdndDclhyWUt5K3Fj?=
 =?utf-8?B?VXJmTklSVFovMlE1UzNuRTh3dlJCa3NRQzkxcGcrMmZKZTM1Zm0rVjNiSU03?=
 =?utf-8?B?Z0g1WCtlSzlmUTViL3lVT2tRWTd3RS82SjhuMVBhZlVpNkhuU3lGYU9oZTFl?=
 =?utf-8?B?bDQvWTZpVzNxUVNuVU1TZFZqc25McDNQTWhrM0l3VkZwamF5NWptVDl2emo0?=
 =?utf-8?B?azB0NEdvcFI1Y3pYVnBuQjgvVmJqbWFmeHF4Y1BzWnFUOXVLTFE0a3BVMWFH?=
 =?utf-8?B?ZXo5ME1vNDNhRWU4ZmtUSU5PWGRuU0hIbGJGRWVMZXFIVUc5NEhyWk13cjNn?=
 =?utf-8?B?NlRweW1XczB6clMxMldDb0lqQWFqaDQwQ3BLYmM1cXZWblNLNU1FTURGNElt?=
 =?utf-8?B?YXFtNUVWdlAwUGtvSFNTVXJybm1DTUlyUmY1MWhGQzloOEtsSnlmVlg4NVlk?=
 =?utf-8?B?OHhoMWdXUFJwMjFBUXlvb1ZLd0VnL3dCaDZUeHVhR0pnbGl3VWRDdFFnUDlU?=
 =?utf-8?B?eUxhajRvU1Z0UzliZEFZWGhpZVYzVWdLZmlXeEYwMmVPdmxEd2lQT2x2WldI?=
 =?utf-8?B?WWptRWt1ZUF0VlVyNndWVFVXRWtDbTYrMXNXT2hFRmNIWlZCRndsbmJOQ1Nl?=
 =?utf-8?B?bFlMMzBQUGpWSGlaV3hUSHdBZGNDY3JCa254ZzlJd0xhRWtqMS9Tc2JnZmhO?=
 =?utf-8?B?QWNvdnBoSmhtR0kwcnl0NGlMalRGVEZkbEd3cUlOQ3JrMmpnZjZQOFR0NTBh?=
 =?utf-8?B?aER6d2FNdUtYek1haEVSZDQ2VEpNL0d3UjZuM2dUdHRvb2xtVE9MQU9qTVA1?=
 =?utf-8?B?VTNTUDdNNEJVQXdZczhpcFYxWE9td1c1SVcybEhncUkrUEQwRHVtVnNRcXNq?=
 =?utf-8?Q?TmmZoZr7oEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkl6MjJObUsvakozcm1yZU9saDU3UlFYb2lIeGVrbDErR1VsY3FheHNoVzJY?=
 =?utf-8?B?Z3dZeDZPdWRJRXYxbklsY0ROQnMyeFBlWkE3OTQxcDJDVndOWTlqa1o0Nm5T?=
 =?utf-8?B?emNxQklMS05DekxzYzJ0SWd2L2NiNGVCR2VPNVFZRlBjakFXSXBiUmFKNkJj?=
 =?utf-8?B?d29rRkdmVnNEQ0FIaWtlcnlFbks0WHNSSXZCQWJ6V24rd2llZ1BWdEVQUUJa?=
 =?utf-8?B?RzFCSStGWlhpd3Vyd3cydUJ6TjBOUkFLSFVHT2J6Ui85Zkp5Rmh4NTE0Unhx?=
 =?utf-8?B?bEx1TzZFNUkwSUovTFRiYjRkWnd0b1hOUTFLaEpBNkpCRldNOE1kRi83Y0kz?=
 =?utf-8?B?bFdvUGd0WWEwUHo2YkxTSHBhNkhnZzZ0WGNTWnVjWldiZFBzZjdoam9TWEFM?=
 =?utf-8?B?QkhYcndQVE9TaDdnb0QvMm1acHJGM3pRVGxMaERsNGd2d3JNTzVHRlgwSFR0?=
 =?utf-8?B?UXpMT0xuWVBnV2V0a2NEb25MdW84MHMxRXhRb0lrNmZjQU1UQjVnSVJxVXJr?=
 =?utf-8?B?bGVyZ0M4ZU1iT2tTK1dDdVBvWE5TN2Y2UnMvaGQ3Nm1jVXoyQlpPM0lQbHcx?=
 =?utf-8?B?ZHJ6VFpIeFVpb2xsbHJPa21ncWt1MEtFMzYwYVZvZFFURThzREpIemZhMWxl?=
 =?utf-8?B?QmZxY3V1K3N3VWpwT1Nqd0xPWnpmdHJVSjNYalBLUy82ZkFaT2txY2k3aUt0?=
 =?utf-8?B?U2ZYWUJLZ0xwcFArRnZnc0E4NXNSNjFiTkozTVpGblFpNkZXRkFTV3BQREdZ?=
 =?utf-8?B?SjFoUGhKYUt5THowM3QxUWxBRHNDakRvbE5GVit6NnBLWGh1Q0NDOXpKVjBI?=
 =?utf-8?B?WmVLSm0rNXp3QUwzcFp1bzhKRWJIU0s3NmFlczlwZkcyMzB6d1kxdkpzcFRY?=
 =?utf-8?B?QmRmY2YyWTZVTEhJdlVWVE1pUEtwc2RCcWRvN3lZemJ3M0ZwMVJaWTlrTlRq?=
 =?utf-8?B?b0l3WVRLMkptdlV1Y25iblEvUzhGejhVNGFhMEZpcWhScERVWFBXajFOQkNL?=
 =?utf-8?B?aXBCcGwrNUQxOVFFWSs5dGVPUHBBOFZ5Nnlhc3BhUFFCekJiWDVwZHo5L3Av?=
 =?utf-8?B?SWlZYnZoYldYWjVxYVAyM3FrNHdPN2xXZzhPRUYzbGVHK0hQbUpFL0hIdU5a?=
 =?utf-8?B?OStPNE1kV1dyRVhjcVFsUUxtbnNvM2hIcUxRNlpuZTNHYU13MUN2OW1zYkZn?=
 =?utf-8?B?TmFlazBRZzVMaHNCRHZqaURqejZGWi95Sjl4Z0M3dWpGZks1M1Rib3dCWnhj?=
 =?utf-8?B?aHFJYkhwVXRlcC9FTlJ4b0NaN0xMcDdSTk5qcGtZNVVVTm1jSnNrYSs5eHJn?=
 =?utf-8?B?UE1wei81Y3lBdi90Y1IvaGpIdWxZMHRFTks5M3lwK0hjRWY1NzJvQ1dReEFs?=
 =?utf-8?B?QWl2WGwrUlMwcXdibW5pM0xiRjFVSndETXhpaFpJMWFvbjBmb0RvWDVmbmNt?=
 =?utf-8?B?ZGdwWlgxdVVPYUtFOTUvTitZNmwzdkowRFpZUXFnRndtUHRTMUU0M3oxZFRY?=
 =?utf-8?B?WThKL3g3ejV2VG4zSDZNOWRpYXJVdDNJK29Wb0lZcEN6QTI5RW9lTzNtb3JY?=
 =?utf-8?B?Q3RDZ0I3eFpzUndFcGNvaFRuNmcySTU1Sy9qaFN4THdFS1YzRkxLa3cwSENa?=
 =?utf-8?B?bERmM09jeW8rSEhMYzF3MlBGZ015NkVKVDRSQkhzK1kzT3lId2JlYzBYYlFY?=
 =?utf-8?B?dEZ1V0hLTTRzRG9URitQK3dsL0hYRlpBbGk5Vm9iRXMvQWtGSk1mU1p6bkhN?=
 =?utf-8?B?QTl6OGlHdEVqRHhzc05RVmtLOWxvaG5mNGZVbFVzR0xFVDQyZTczMVBoc2NW?=
 =?utf-8?B?a3BTS29CbXZZUTJxaVFTeWNEZUt0WVpCS1F6TnJiTy9Oa2FmMUo0KzJBRE5w?=
 =?utf-8?B?U000VnZKV0FiLzYrcE9HT1k5Y0NCMWdDS3hWcjEzZldQNGNsaWIvaGcwRW02?=
 =?utf-8?B?Y2JxMWl0M3Y5Q0VRZGdUa2l6MlZWWmk2V21zTG9OSU9xRTBrRk1sMUxzTjIr?=
 =?utf-8?B?c1hObHVRTTNXOHRSSVpQRnAxK1doL0lqKzB5d0l6VWRmTXl6L2lSVDRqOXYr?=
 =?utf-8?B?NEFpcHlGbXhabHoraHBZK2JXTW4xZmgydHRxMDVTZkhtS3lmUThqdHJYRlFB?=
 =?utf-8?Q?1+lU1SShYHLUh8rUusqogH8bd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e966e9-e69f-497f-a4cf-08dd9c317b3e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 08:44:09.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6athbK3GGaeGEHbHT3/E3uUcUGVf72odIU3wPjQFoTlc2o1AsGX8TbrrZeBXY1fVS1pUe15+IENvziUXkwpzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7692

On 26.05.25 10:19, 李胤颉 wrote:
> Hi,all
> 
> Environment
> • Xenomai version: 3.2.3 (Cobalt)
> • Linux kernel: 5.15.y
> • CPU: Intel 6-core, 12th Gen Intel(R) Core(TM) i5-12400
> • Boot parameters (relevant excerpts):
> isolcpus=1 nohz_full=1 rcu_nocbs=1 irqaffinity=0,2-5
> idle=poll intel_idle.max_cstate=0 intel_pstate=disable
> 
> Task description
> PID 2780 is a periodic hard-real-time thread pinned to CPU 1.
> Its period is ~3 ms; the actual work per cycle, measured in the kernel, is normally about 65-75 µs.
> 
> Observed timing
> Using trace-cmd (function_graph tracer) I measure the interval from the first
> cobalt_trace_pid pid=2780
> to the corresponding
> x86_fpu_regs_deactivated
> for each cycle.
> Best-case: 65-75 µs (expected)
> Worst-case: 320-360 µs (occasional)
> 
> Typical long slice (abridged):
> <idle>-0     [001]   804.488903: cobalt_timer_start:   timer=0xffff93812f4ddc68([watchdog]) value=30000000000 interval=0 mode=0x0
>            <...>-2780  [001]   804.488904: cobalt_trace_pid:     pid=2780, prio=99
>            <...>-2780  [001]   804.488904: cobalt_head_sysexit:  result=0
>            <...>-2780  [001]   804.488904: cobalt_head_sysentry: syscall=sem_post
>            <...>-2780  [001]   804.488904: cobalt_psem_post:     sem=0x140
>            <...>-2780  [001]   804.488904: cobalt_synch_wakeup:  synch=0xffffb42c00b55208
>            <...>-2780  [001]   804.488905: cobalt_thread_resume: name=SchedProcessorL pid=2776 mask=0x2
>            <...>-2780  [001]   804.488905: cobalt_trace_pid:     pid=2776, prio=0
>            <...>-2780  [001]   804.488905: cobalt_schedule:      status=0x10000000
>            <...>-2780  [001]   804.488905: cobalt_trace_pid:     pid=2780, prio=99
>            <...>-2780  [001]   804.488905: write_msr:            830, value 1000008ea
>            <...>-2780  [001]   804.488905: cobalt_head_sysexit:  result=0

Here, we enter userspace of PID 2780.

>            <...>-2780  [001]   804.489153: irq_pipeline_entry:   irq=524546
>            <...>-2780  [001]   804.489153: irq_handler_entry:    irq=524546 name=Out-of-band LAPIC timer interrupt
>            <...>-2780  [001]   804.489153: local_timer_entry:    vector=236
>            <...>-2780  [001]   804.489154: cobalt_timer_expire:  timer=0xffff93812f4dd318

Some timer expired, but no one in the RT space needs to be woken up.

>            <...>-2780  [001]   804.489154: cobalt_tick_shot:     [FAILED TO PARSE] secs=808 nsecs=719099802 delta=4229945802
>            <...>-2780  [001]   804.489154: write_msr:            6e0, value 1f765d1d54e
>            <...>-2780  [001]   804.489154: local_timer_exit:     vector=236
>            <...>-2780  [001]   804.489154: irq_handler_exit:     irq=524546 ret=handled
>            <...>-2780  [001]   804.489154: irq_pipeline_exit:    irq=524546

Therefore, the timer irq handler returns to userspace of 2780 again. It
took ~2 µs from the application.

>            <...>-2780  [001]   804.489247: cobalt_head_sysentry: syscall=clock_nanosleep

And here, ~100 µs later, 2780 decides to issue a clock_nanosleep syscall
which puts itself on hold.

>            <...>-2780  [001]   804.489247: cobalt_clock_nanosleep: clock_id=1 flags=0x1(TIMER_ABSTIME) rqt=(804.491955411)
>            <...>-2780  [001]   804.489247: cobalt_thread_suspend: pid=2780 mask=0x4 timeout=804491955412 timeout_mode=1 wchan=(nil)
>            <...>-2780  [001]   804.489247: cobalt_timer_start:   timer=0xffffb42c00b4f4b0(CMHooksTask) value=804491955412 interval=0 mode=0x1
>            <...>-2780  [001]   804.489248: cobalt_tick_shot:     [FAILED TO PARSE] secs=804 nsecs=489901754 delta=654196
>            <...>-2780  [001]   804.489248: write_msr:            6e0, value 1e5f6c5b37b
>            <...>-2780  [001]   804.489248: cobalt_schedule:      status=0x10000000
>            <...>-2780  [001]   804.489248: cobalt_trace_pid:     pid=2780, prio=99
>            <...>-2780  [001]   804.489248: cobalt_switch_context: prev_name=Task1 prev_pid=2780 prev_prio=99 prev_state=0x48044 ==> next_name=ROOT/1 next_pid=0 next_prio=-1
>            <...>-2780  [001]   804.489248: cobalt_timer_stop:    timer=0xffff93812f4ddc68
>            <...>-2780  [001]   804.489248: x86_fpu_regs_deactivated: x86/fpu: 0xffff937dd4389540 load: 0 xfeatures: 203 xcomp_bv: 8000000000000207
> <idle>-0     [001]   804.489248: cobalt_trace_pid:     pid=0, prio=-1
> 
> Questions:
> 1. Is the out-of-band LAPIC timer indeed what inflates some cycles to roughly 350 µs?
> 2. What practical steps can I take to keep the cycle time from blowing up to roughly 350 µs (about five times the normal 70 µs) and hold it near the expected range?
> 

There is nothing visible in the trace which point to the kernel or the
hardware contributing delays. You need to check what your application is
doing before it calls that clock_nanosleep.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

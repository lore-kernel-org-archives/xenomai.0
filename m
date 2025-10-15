Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29213957E
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515442; cv=fail; b=URlwXHW4xYKzkY4tosvoLJO/CSrxcVlJzecv3D/BmeJybR0DZravjA5TJ/DBv5HbcGgNneLXu8Yek4tnhKl7JPrRM0xqLWdnHM+bwgXp1nrO9HlUOLmlxUd89tt+166AP3a/vlYTU+uGk1+cplD+18tcCqCJN7lrQIW10XEuKKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515442; c=relaxed/simple;
	bh=bGqrGYfIMcCOpim8TgROCVwzlZ0GVzxpjt61eRHJ05Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqy9Bpf2d/u9GeDWTZ3kAhTjpWuc6D7xWjfboVkJPRtRSrqrjZGrFbO0wQgwPaVTolj/frmtwachhkJ+tYRHvEFqaWnyD3AwkzSvpq6JzjT2V6087dsU6Z6E0AtUdlYxuUefYYB4gkA7xXorIA4Ln8vCIy+rPM19OV9frca0AqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PuTRRpp7; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PuTRRpp7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U306XrJ00OhsLTU+khLiJDr1lvE6w8KUtaOWphxrIGFeh6m+MdiA51sVYgNuSqWtVdiP0gi5+GLqWKtx2dyRNE0CR79WRpe7OawBHY9mc59pNxcEABdRWMabcoi4UgR6FQBQ8QLlFYSoI64oUnA9wmhjE5xgclJsyT26fckPqTElb33LiLdd9KURWvPQSvVoFIvSOMieDVXfVi/esxgBfzWhtbWlOwg0VSYvzB5Fe39z1/x4fDidBOhfxyAn8FUA/Ykiiz7QS0qAyaCeGHVQUKpr2G/bMLK0zW8tSfsx6AmGrXBaXHV+v+s7E7lTmF5fp6A2VG3n7cbc2xxbxXz8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ksPd0sDqzSVFgEnYhU3jjMXbiCDrkweS0mi1DQKHVc=;
 b=SMTTJ0tlxSDkPe2tTJk/ksVXyzjcmH78QcRuBgFoadjfFcdIMMEhXiFwRxOC0BMEfFjBap96lJMMDH84iD8d4cciCO2Jvw4UXsStTo/ytsRgtD25UmbYVeSAm3AL4GLrRhHpEVGdEuoJ1Nc7/lil2X/qbWTbIKeJcme3pkQBXfCo62/XGtrCOScwb5iyRp0rMRBkpxU045F7GGuViRGVQy3P29iFsgLSsdgZtNi/2TN6dzhIExvFuerb9TyDUzcgGh+zMjxlaPrlJXsVPxvM7J6lHgAlLpzc1H1S1tl9MT+aWv5hYs0CwqW9n3VpX/M/iDS8CGN2ilQtDkPODXwZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ksPd0sDqzSVFgEnYhU3jjMXbiCDrkweS0mi1DQKHVc=;
 b=PuTRRpp74hvI5hdduC8FB9yVaZx/XMrXjZVPnuznIAsb+aVG2N/7YrSdCnN8YhWw3/22G1HRGOzOFuSav+HQq9jiqJZnPna6vUzhuRu9/YD81/39gVJM7RbamsgrOAxAssV1SwCu9CL2zoc0fvUnfZ0wXgW3UfBaU/4lzeAIibyQBCmzVw0hoBhmTHZVXUvwIpzxdcz2DP+fBf9Y0TIRw4coXE8vRu3rYHQlgJViYvJfaJVOZtncMn7DLU0ny2x98OcY0FTZtsUPSo+Q2+brsiYBXeD3DNBJVEge0lmVD1Hln8sz4spDgs0LytiphvLaHUF2CoazPnS0OFzZAfW28w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:03:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 08:03:55 +0000
Message-ID: <0369aebd-5b0f-4fca-8431-0948dc4e9fc3@siemens.com>
Date: Wed, 15 Oct 2025 10:03:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] lib/cobalt: arm: Avoid thumb mode in syscall-issuing
 modules
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1760374860.git.jan.kiszka@siemens.com>
 <b2aa6e5eb2bf3b7357239aae8d55289f0baac9a8.1760374860.git.jan.kiszka@siemens.com>
 <77c5c99cb6dda43b48ba8bf8ef29f665ee19ea6f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <77c5c99cb6dda43b48ba8bf8ef29f665ee19ea6f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 1813f375-4a7a-48f2-e561-08de0bc16306
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUdWTTZLOGtYT2k3SHBjMjdRTjc4WVpjaHJwcXNRNlBnRVBxUVh3Zmc2M3dL?=
 =?utf-8?B?R1NiZ3R4QjNNcFZZRGxJR1lkaEpRcUZmQngvUXlsRlZGbXN3VklmTmx5ZjhG?=
 =?utf-8?B?amh1eEJBWmVacExKRXIrcGVSeTVDKzE4b0gxeng5czAvdXlUWGFHanpFbWJI?=
 =?utf-8?B?Qmhjb2VCVGk4M1orQk44TmxWM09jM3lpUDY0cEhCWGlXVjY2WTJIRXFNMjdB?=
 =?utf-8?B?K2xjVEVMUGdMQ205L1p3clVqQUR4Rk5Pd1laR1VLZjVQeFJ1dDcwRitvdmR3?=
 =?utf-8?B?NDJwbWJ5VUlsdUo0SU9IOW5yR0xhdXZ5eU9qSGF1WXFacU1FV3kvVUwyemlY?=
 =?utf-8?B?Q2UrT2J6ODV1UFMvdUxiV1JSODNmYXpSQmhwYm5Tc1cxWm1La1Zock44RUU3?=
 =?utf-8?B?ZFJxTW02bEdoWk1XTUtCTVdXQk5HSGdKaEh5QmhqdDFYQ2hrV1BmaVl0WDM4?=
 =?utf-8?B?OEVIY0ZHRjFhVnJxWmVISjUweStOWUhJRjJZNVhYU3o5S0lGVTRZZVpmRFJl?=
 =?utf-8?B?eVhYR1BpUDEwRVU3WEFVSGRuRU1vcWsyWVpNN3JmWmN6TTlyNnExaXVCNTg4?=
 =?utf-8?B?WS94aENXaDNvUUUyOTcxN2xaMG14TThFSkdHeWpqNGFUK0IyRnd1MFpzTlcz?=
 =?utf-8?B?ZzlKT1BrSFFHTjAxMEJqTnkvSGJ4Z2dHZnZKSEJMcUlQVHY0MFh6Zjl1SUhv?=
 =?utf-8?B?R2JuVDRZNFhoeFdMVGNZK29uRkRBdlVwVENudmJwQ3k4RDBCU2lEWkZ4RmlT?=
 =?utf-8?B?VVNuRnVQZVEzRlQrcXI3ZFNwenljb1Y3U0VYZ3Vwb2Y4S3YxSU91Q0Y2Y3Js?=
 =?utf-8?B?TlRoU3RUNXB2Tnd3VnJYN3E4ZE1CYm1NdnZqc0VvZWVXclRLNElZbFdqQUha?=
 =?utf-8?B?OXl5Sm4xOWdkVjU2cVQyakZVVlB1TDd5N21qVXFXNFhTZGFZSlNtRUoxSlpj?=
 =?utf-8?B?azNWbWUyTTUvZEgwRTJvOWFJQUcyR0JxT01UeHY1R2xmYlJQWHErZjdObXJk?=
 =?utf-8?B?Sk5GZ0UvS3NpWTRsQ2hEeFJHOXE0RHUxbXp1TmFXdVkzaytoUG03WkpQalNh?=
 =?utf-8?B?U29yMThUYmQwSVlQSG1ad0l6VkE3NDc2NVB5aEhlY0MrTlFoWFRPYW9haGl0?=
 =?utf-8?B?Q3FSbHk0cEtwOWZCcEV0bkg2R0w1TEpid0lZdXExQVNuZlJybHUyZGtCbjdv?=
 =?utf-8?B?V0tWalJzRFlIaFpjSmRkQU9PNkppMkNmUDI3RElPcEJGTDZ5dWpDb05xZWVZ?=
 =?utf-8?B?eXJ6dGg3TVRIeWU0R0RMeXNJVXhScE5xRDRGeTZUZnRBQU96TnZQUnZaWXlT?=
 =?utf-8?B?YjhJelh2SWY5RkRSQW5PZ2JJMDIxTEM0Kzd5cHVKcnZacStoOVZRWWZndUFH?=
 =?utf-8?B?NzZxaFU5NnFqQzR3SGdxZmlDWG5xVXJ2V0E0UG0rcVdqWEJtZGR3dVFXRE5S?=
 =?utf-8?B?TEkwQ09xdEpFOTRkNUJUY0Uyb09rK0xWSnVoTHVHQ1d0c1ZUSXh5cGozOFVp?=
 =?utf-8?B?UlV5UzlOQ3dLd2o1MGc0eUdjb2J1Ui9rR0hSUE5rV09FeEdzNkJOUlVTYXRh?=
 =?utf-8?B?VVN0MzBHRUJaSUtwV0FzR0EwWUROQ2YxYk4rOG1rT2pRdC96Z3pDc0M3Mmdm?=
 =?utf-8?B?NWo3cWFFWE1Fb1NzejlRV0pyeFdaSGpXS0Y1Tyt4NFZsRnhsSEQ3bnVNWGc1?=
 =?utf-8?B?Y0RMVkZHZnVkd2tWYXNsalN3bHBPdzg0Qk5ybjJacnlXYTEyRlRFTWFCRzJi?=
 =?utf-8?B?eGRDbnYzeFU0VHVKTS9XKzdVME5LSzEzNjBFTUJ5c3paSjN4TmNqK1NwVzl2?=
 =?utf-8?B?ZDJYaXk4aXRSajNoWWxFc3N1L3RwZEt0bTU0YXF3UnRMcjVVeEpadHIyeFUv?=
 =?utf-8?B?QzVGS0FDQ3cyc09DR1pCRDI4VitBaEJkb2thNGFOY2Voc2o0Uk8yWVdQWGNC?=
 =?utf-8?Q?dQ/fY9rxwtFcLsmHZBQ52MZwTHLM+q77?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFwTUFCN2xOKzVpTWt4TUdGdzQ2aEMvanRoQlZ6bnlKbHpTWHRVMk9WaTUz?=
 =?utf-8?B?NEtkNWF3cUc3VmpKdXNMT0JHTjh2ektsOUdDdWVRUTBaVGg2YmtiR2pQaUhB?=
 =?utf-8?B?MFM3TTlsVDVzL0pXNjU0Zkt3L2JpbUpOeDVBQURJNFlZQTVsZEU5NStXNmla?=
 =?utf-8?B?Mml3cGhydXdWZURZYU9HaWs2VURNUGw5UmpTckwzT2xFR2lzaEs0Rk9DT0FH?=
 =?utf-8?B?RW96N2pUN0hjRUJ6aDBKbHprQzZiWjU1RVRjNHVnUVpXMlZBcis1UkJhWjBW?=
 =?utf-8?B?UGd3MzcvS2lFUFB1c1ZVZ3pKV2hmSHdVeC9EalR0VTN5Mmk2NlRDRzhibmNG?=
 =?utf-8?B?bSsyQkFpa0hyWTk1MHUwMTZYdFNJdzJINDYxRnJVTEQrNEtRNzdLbTN6VFlz?=
 =?utf-8?B?N3d2NkJoUGlTcXBoQWw5T2d6aE1YOUt4VVo1UnZLaGtzZ1d6RU5VTG83S25X?=
 =?utf-8?B?ZWk1TjdWVWF1NGVEdHdXdUdHTTJnTlRleGtWOWc0bnE2TGF0ZnFBVWY5cEt0?=
 =?utf-8?B?MzJHbThRZWNXMi9VNnlaNEEwTENoMTFvS0JuTFg4bldhQXpxdlJ1bTRvS0xQ?=
 =?utf-8?B?bisvejduQkQ1OHg3aG9lYmQzaTVwY1ZBbDZpeUNvdXAvbTlkajdHU0kwL3pT?=
 =?utf-8?B?VHhZUTViOWxPZytSVjJaRUtwMjBqWE1lQ1MwZGpqL3kreS8yTlVYRVNOYS9U?=
 =?utf-8?B?d2I3SFBFWmFKWEREQ1hpZCs0TytMQi9yY3Vhbk5Md0tYeGdoc0laL1NFTk53?=
 =?utf-8?B?OVBETzZuMnJKVm1MNU5YL1pnWUp5cFdNRGU3d1hiNlZpR0NSRGVGNGRSMEc5?=
 =?utf-8?B?aW1ZalBNQUVpNVJscW0rUkF3QlRDMTRXeGVXUmx3VnA5c0FXeFNEa3BPRWUy?=
 =?utf-8?B?SXZWVUtPcTY2MjlLMDVrNCtJZHlpdHMxeDREZUI4WHlTS1FhTVR1ZStYRU9W?=
 =?utf-8?B?WkR6bWRWRWY3dUFPUnBtakF4Q0dMYWl1ekxhRE94U3lRMXFadlZmQnBPQlBW?=
 =?utf-8?B?LzRTWmVDUURUS2o2OWt3WTF4cXNTeVRyWHAvVHhRTW5JWDNZbys2ZjFuNVVz?=
 =?utf-8?B?dWdKajhVT04zRVRuVUltUjh3NVZxME9GSTdnZldOWnpsdEkrZWJhZ1RGWmZ3?=
 =?utf-8?B?R0JPTGxDWTdZUXZ3NENnWW5yU2E1Qk9EVjFKWmk3UEttWTdZYmN5WEQwWTZE?=
 =?utf-8?B?alhsNU9PZzd5Y2dwMHFMUzRsSVBKU0pNUDRyclM4ZjZTaFI5anEyL1JtNnlD?=
 =?utf-8?B?aG9WQjRxTGxYclczQ08wdFdkN1B5RkRIV1E5UytnS0RHeFRROW5PaDlIaG0v?=
 =?utf-8?B?bURMK0sxMG1pT21FaUpEczhJZmlwY3U5VHo3bjAzc09vWDVkeXN6dmtZMTJY?=
 =?utf-8?B?bGoyN3orL1YzNVZ5QTRjWCtUbXN6dzhoSHVKM3EvcGR6Q1dPajRiZ0ZrRnVF?=
 =?utf-8?B?eUQ3dlYvcDVxV1EwWkJRUW94Rm9zRGFwT2FFb0ZNMUljM0Q0c050T21hYm1F?=
 =?utf-8?B?QjJGQmxTRmJMd1d6bzhXeHBadVpUcnV4Sk14bXIwQkFuYmxIZ3NsazUvLzd0?=
 =?utf-8?B?TXhyLytCUVo4aUVZaktBMjJ5K29oeEVqZW1DL08yYjNpdE9aV25uS1BXdE4y?=
 =?utf-8?B?SmdUUk8vL2trZzNQeUwzaGZDK0ZJNnFkSVpXNmhaRXNuWUw1azNVcm9WaW5r?=
 =?utf-8?B?cEkzQVNaQjFnMGJaQ1VraDJ2VnFzaUorK011QXlabys3RGNqejFmU3YzUi9M?=
 =?utf-8?B?cjJNQ3lpcFQzUktXZVozYWExZHpMREplMlZzemp6ZWFYNXlleUVyZWtGTkJM?=
 =?utf-8?B?Ym9nS0ZoYnh5L0dTQ1EwVmNmMFdlUnIrK0ZJcHNHSm1NbDFLbS9pMXY1aGor?=
 =?utf-8?B?MFk4OUdPWm0zMGU2Rk10QU9RZkpVa3kzdExtSGhYWFVhRjRSbi8zOVN5c1o5?=
 =?utf-8?B?b1grVWM2TzZDeHRjR2V3VTVDZFVVREpnQmZvSEoxQmxUQTh4MTBHVXVjTUZD?=
 =?utf-8?B?NG9FNkZrZlFGVnl5OUN6SEhXUmVzbUdUV3lVbk9lYmVtNW0rdFN0R25uY0Rr?=
 =?utf-8?B?VEYrQ3k4Q2tWZElGeHFRYVV1ZHpyRUZndHVGMnliNzI1dStyNkJobzBmZDJh?=
 =?utf-8?Q?GFHKQ9BMc8auLdcyobFsMwKeP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1813f375-4a7a-48f2-e561-08de0bc16306
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:03:55.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS2ZY197m+Fr34B9kyhAm8y1JFG9+rOFOplmTVuH1/XGJlaXepXADAYeHxSmSeEuyxo0ZfW5ecKqy7wP+fwYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8062

On 15.10.25 09:12, Florian Bezdeka wrote:
> On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> In 4abd59b4e3e4, we noticed the clash between r7 usage for setting up
>> Xenomai syscalls and the compiler suddenly refusing this. What we was
>                                                                  ^   
> "we" seems superfluous.
> 

Thanks, will fix.

>> not clear at that point was the origin of the clash: if the compiler
>> is configured to prefer thumb mode over regular 32-bit ARM instructions,
>> it also starts to claim r7 as frame pointer.
>>
>> Now, the solution taken back then turned out to have a problem: It broke
>> stack unwinding. That is not only an issue when debugging, it is
>> actually required for pthread_cancel and pthread_exit. The glibc will
>> use unwinding to call destructors of the terminating context to call
>> them before shutting down. This broke when we were inside a syscall
>> because r7 was then pointing to the syscall number.
>>
>> Most glibc versions detected the broken call chain and simply skipped
>> the destructors - which was still a problem, just unnoticed. But with
>> recent glibc from trixie, we are now even crashing while unwinding, and
>> that is even less acceptable.
> 
> Ok, so not a trixie regression, but something that was never correct on
> our end. Good to know as trixie will get more traction soon.
> 
>>
>> We could now either use the pattern of glibc to push the syscall
>> invocation into an assembly function - or simply enforce ARM mode for
>> libcobalt so that r7 become usable again. Take the latter approach as it
>> is leaner.
> 
> As it broke again - and as already written as comment to the series -
> we might think of reviving the syscall() series. That would allow us to
> simply remove that code here. Seems hard to maintain and hard to
> debug...
> 

I'm not very keen on adding that overhead anymore to the low-end ARM 32
platform. I think they should retire with the existing inline model. For
more powerful 64-bit targets, it takes at least the benchmarks we discussed.

But when benchmarking syscall() already, why not including prctl() as well?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

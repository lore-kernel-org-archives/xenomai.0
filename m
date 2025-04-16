Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46422233703
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806203; cv=fail; b=KjG3+ggB+a1XmxoSXqD9gH0ptISg7miA1CTvcXXT5OJw/vnfkjaX+3s7J+J4lg5uefTJdgKzMWDfmkaUm3a/H85MnKGAOVSjv98RvK1st1zFrX3M3p0gupY5DKbuBpKUZD3kuNo9dlA8wUmNyQHEEjca2YjEfGL/iZ7+2ove404=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806203; c=relaxed/simple;
	bh=8hcuOUsuMS9eRtkGjfFGKCqK8slyOVGglv/lsgWfvls=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=So9kDmsAQ6Vd7S8QP8UTdufh4qq56FrlYxYYYctpCvH9Rqle339YHaZ5wt4IlL/G2CvwsCi6jAozAXyNhjrzFTaCPqP4YJHONl4CCUjyC4s4aFTdWV2cQhB56TA1faaTC1WDrCveAP+mi42Ik82BOz7sklKthQ5GHV+z+LA1D5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vYc0GBSq; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vYc0GBSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8WIao9oEz8wmX7huyCZnEOxCmIIsKIEtwP17HPiO7yssPgybvKl4wqHhbtdvyqWrgnt8lpI5yiE+t82vx/pcd4r8fQZPSPoVIcNxa7Sh2N87Fgwa8qX9cPx3M61LDLOhfS1w9xqyY4M5zx7dH1bIMveRV+JsCJtl7yHeztF7jp7+eTmyFihDEbpSgHT/3jaAQDUOH6kyuFp3NkMLp3vpF7A1vT8oQOuTPn1g4etFOYWCjmoUMiN6k6lyizt/iK4EZSwA5hxmPtuceTl6Vt4a7K5WlFvZWzKjRn543jtjzIdS0THOgCVfNTJKj5tLUz5wLp1UqnEyLIjTut9D2/44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBRBd+2mF2QKM//mwdVgEjywHSg1d5kkAcyEoO621Fc=;
 b=SexncS+jRYfFRSGlfhwWy/Yf/5ktqzCj6If+jMAbC/LZYKih7ZfyFCE/w6s7oXkdtU65T2QrrfPBU/hFlkKBtcbQqPiYx706JQ1em7BJVKco8wu09+g7Be0OjP1axW4CNy1fZdycJmKBEuM2Jf8Socues9zNlcYY3EMmcXqG+zG+ufAI1l3XdYSKUfpOZc72kBhILqqYchy+7NRFlexermut/Jt7Wo2o7qdrTtadfIIhSBL/mST2kcHYtbqhGflrJinUjqDd2C200LUJQgvjYCYWnrJ+Hab71wGzFOf/I3CKhmS66FkA0sGLe70dzoDWgw0hTT+fc1cRMaqWfdBQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBRBd+2mF2QKM//mwdVgEjywHSg1d5kkAcyEoO621Fc=;
 b=vYc0GBSq+9lEtDVTYAwA2tJS/vxusEGm1OLanpGGdl8Dgfdx6HhoB5/ZawvmGyCsAClmPKdQcFK95Qxu2I+9a0Nv1OM4NbgIOuBK1ZOghgUo3hfgg3BCqeNdCgdMH/+XpHSkfEhbUqFX1WxU8/DsJVClDZRhTyqnyYHG9eK1ibGTn4QpJyuqoBwQ7oyUSK3MpvZ7zct8K0S2uYlE9byrcfuBEtKMo4F0rdyFWSuWQZGgcOV3VNilHFVYYHdi4MlRWz7JOg+fjwgOHlOm+QRzCoqlrd5WrCquEBQGC5Asu9t/1yc3bWSitrRynwQBAWbOSY4xiq6vsjraEEdQaLpFCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 16 Apr
 2025 12:23:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 12:23:17 +0000
Message-ID: <03af5d00-06d9-4145-82d3-ad23fb5d5f07@siemens.com>
Date: Wed, 16 Apr 2025 14:23:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/xeno-test: Raise watchdog timeout while running in
 VM
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 391872c0-a895-42e9-c940-08dd7ce17767
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3FIMWF0OWc5eGx6SGd5TldSZnVPLzF1ekJ1VlNWU0FSai9qWk1sRkVlU1hK?=
 =?utf-8?B?a2Q3MUxjalZhdlQ4SDhwWGhUbUNIKzlRck1hTDhob20rUHlqUkpmK2JSelF1?=
 =?utf-8?B?ZlY3RThyK1hIUVFlaTd4NlBKYkdCczM3Vm0zREo0ZkxpS3l2cWUzZ2YvYVVt?=
 =?utf-8?B?RlVyR2Z3enpZMmZJNXpZeERpMjNnQmhtWjEwT0l3bDJJQ0hSdkhwdE14ZmQ1?=
 =?utf-8?B?UExiLzE3THk3dW9UQzh0Q1RVQ2N3NUpJaWlQNE81TDdjU1JZQkRENUw1MU1Q?=
 =?utf-8?B?bmMzMnhDOVh3NjZmTWlMNVNHaHZHWXFOVHRNRm96Z1VOTlBKNWFhL1puN1cr?=
 =?utf-8?B?djcySW16NWdxSjRJY0krM0NqL3Nldy9QWENjaStIUDNWQ01MSkhIcEJCbGFt?=
 =?utf-8?B?K3VxdmVqMUZKcURNNHo0ZlNCSDdlS1FlZlh5K0ozRFcrTW5jd29Eb2lpMTRF?=
 =?utf-8?B?QTJMRTlqYnlZVjNtMWZyeHNYVWZ6Ym5sVnpBK2liUzdYcS9VTk14M1NsdjZD?=
 =?utf-8?B?NytCS2VCZHdZdVhpbHhHRWIxalNuWTFCbDBMNFc3YXEzVlc2QXhmT0p6aEZq?=
 =?utf-8?B?enROekRqZkhUSDlWa2VacVRsK2RSZGpxcGZRUlUzZHh3dm8vN1NZdVREVnJQ?=
 =?utf-8?B?TUhIbTBqRUNvQktTRE9SM29iYm1GMEZhQUgrSEtuaHBEWnZDZm5UVHcza1Fp?=
 =?utf-8?B?VXVpYkxERjkvTUk2cUdkemFYQVVWSjIwVEVqYmwxSmkrTkZBQmMrUnFkNWFX?=
 =?utf-8?B?Y3lqMTdyMGNrWUtZTWpwMzBGK1hETzNhSXVmd0NMSjRXTDlqckZGa0JlZ2xZ?=
 =?utf-8?B?VnE0MC9mNlkyUTB1SnlRZS9KM3QzcG9sNXZSZ1FMYmptZ3Vyalg3VTBSbUJF?=
 =?utf-8?B?ZEJyTlllV05GS2FVZ212NmlIcnNiMi9XRzBJV2tVakJvSWhqaWh0RVBaVlBm?=
 =?utf-8?B?WU5YOGJTMlUyTkNoZTh5UE5KQk8wcXZjR1g3R3NMWENxQmF0cWNzUG5ybmti?=
 =?utf-8?B?dEJybkxWa2dyUzV6RmMvVGZvZ0w2M01uWEJCZnZJa3ZEV202VVp1TStVSHFx?=
 =?utf-8?B?bUtlRTVBVjhrRUF4Rk56ck1qaU1rWG1uTUJJYlVFSEovOS9OeFA3eEx0Y3Aw?=
 =?utf-8?B?Y0MzdjFUcHpJMzRwTlFBSmJkKzl5UFZOellIQzBGUnlPSktRM1BvTC9Za052?=
 =?utf-8?B?QlE4dnpmMlBIWWRUR29JV3ZQQXRhby9RUUhxM05NMWVEKzhLait0TFNwL29I?=
 =?utf-8?B?NDZEWlZ2UFlLWTJOekFobjluWUZxcjgyZzhNNWRuQ2tGQlNvSVdJUEh1NTUy?=
 =?utf-8?B?OUxoY2dRbVZubWZzYWx2RVlpNjdPTjJTKzJiSDJKMnpxcmhtTGJ1aHc1QndG?=
 =?utf-8?B?Y3dlZFN2eDYydWdYVmlDMDhqcWVqYWNqZzBWVzdWQ0JzSllHWnJhYzlTV0Vh?=
 =?utf-8?B?dllqMzFMMHlSVjRKMlAxKzlLcXVIeW1NTjBBUzJyKy93QlV3dGUwTzM0SFZl?=
 =?utf-8?B?dFRPR1I3UU1EU0lQSmFUc3dueEU2a1BFTXB1VWNFMU5QRk9yYXVMY2U4bFIx?=
 =?utf-8?B?MTdUaUdUQlZYdjhvMU85R1c1Q2psYktSRzhUZVI3aFZYdVlCNC9wRVVFTVJo?=
 =?utf-8?B?VmxDQVNoS2x1RXg1LytNL2VDRHNqbGdvWlpFUWE5MEw5VzJKcGdIMDNzeUcr?=
 =?utf-8?B?cEpFQkM3RnMrK1MzU2Y2aG5SY2FaK3JWSktMS1FXTUNyYm9SU25OUVVhbFVt?=
 =?utf-8?B?VGRxTkN6UVdYTGJTL3ZmeTBtN0xaT0VISVZ6dmVEMTRqQ3pTOWxtOThydzY5?=
 =?utf-8?B?c3p4cDhvQVFHRitTWW9Hd0xhenNUcERSYk5rY2ZFMStGWXdVdGZmY2FPVHk2?=
 =?utf-8?B?MVNRYlV5SVo4QWQydUsvRnkyUXkwTVJuNFJ6d0tWdXJETCthL3ZCaFExK1lW?=
 =?utf-8?Q?JEdlBXJe04M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVU2d2tBYkZ5WGg3RHdJQ21RamZFVWpjZ0NYRXlBSlBiRnJTV05TVTMxU2RN?=
 =?utf-8?B?M1UvWm0yd01Za1UzQ1VPTExtTWV0YUtjT1FuZXB3NTltTUJMbmIyMStrU1da?=
 =?utf-8?B?VmlVMGFBR1Jjd3JQZzhxOW9XUUNHeXA4c2tMMHAvKy92YllsNXR1SkhxeGJO?=
 =?utf-8?B?dzZlMEpaNmMzQ0Y3WEg1R0tCdjZGRWt0blRiOUNNcEVkei9vbjRNYm1vOUl6?=
 =?utf-8?B?Wnl1aEM1TDdadkgyaEFmNEl3MUVCenUwTW1YVjliMFE3UXVBMHdFRGlCaTRL?=
 =?utf-8?B?MWJEOHlRYzBIbXFqMHlGa2xqVUlHeUx6eDc1elc4VlRvSjJVQkNvL0dxQVVn?=
 =?utf-8?B?alBpYXJpZzRzaWlReUViSnZITG9QYnd4Ky9FN2Y3cFJsNEllcyszS3p3L1NQ?=
 =?utf-8?B?RkxQRWhCYm5nb1JxUnNYY2k0WTJ4OVZUMzUwTVZDWkFJbkNhcEQ4d1dNQURk?=
 =?utf-8?B?aXhCOTNPc2hGVHR2YkpYMFN4S0k2WFRHUjkvSjJ1em94dDJJMjZVVnF2SUxR?=
 =?utf-8?B?YzlzdkFIUnFmMWFkd1VlZHhLOTdjMGs1V0JzNXF0ZmllY0pVWWZFNVNkQldy?=
 =?utf-8?B?Q0JGYU1XT01UckxHTStPS3BieVQ2MnlSckNES1JvczlyajlkUEZNNEpBbldo?=
 =?utf-8?B?ck5FMEJ1QVUrMlBxazArL0cvOVhlZWwvUGZGUWNDYTlGY3NuQnlWSmR4L0NC?=
 =?utf-8?B?U3NLSnl0dVUxRmRmcm5zclVjNnRxWjY3bEZzV3FoR09rWXcvQnJFa1UrazRm?=
 =?utf-8?B?eFY1WWZvZHZUa1JOUVlGWnN1bHpvMHFsei9ncEQzdjFlUWNGZlIzMmlVMHNR?=
 =?utf-8?B?eWc5QmlPRzVVNmNlaWE3eDRrQXpPcGJHcjZSMXZteHovRGIxSTlDUUdCRldC?=
 =?utf-8?B?UXJiMk8rVUcyMm4rbWdKTm9iUEcvcHJNNVpnSmkzTzhVaUhTZUdFaWlMc00y?=
 =?utf-8?B?d3UvMVR1c3BaZG5zRkxFUGc5QVJPWjZwUFhJQSsxNTR5R3IxZzQrL3p2V2JO?=
 =?utf-8?B?bjVHOFhSQTFLd3IzcXNFWUlZWitBWG5YclNxaGVQM0Q0ckFxMmg0dFVMT3Bk?=
 =?utf-8?B?NHo0NE9QNXZoNms2Nyt1UUlrYlhYVnVVZE9DOU1BOXVQUForTnFSaDFiRmFh?=
 =?utf-8?B?QWdCVG01L2MvcEV5YnlIdjNqb1VkZEtMeWxoRmNqcG8xK21IREVoNUNScmhQ?=
 =?utf-8?B?eVJteDBOM3BscWQ5eFp1d1l1eEFyUVVERkNtNll1QzBtQThIcXVYbVNLRW5r?=
 =?utf-8?B?ZWk3a20rNjRMY3lFdC9rK0tKSDBFUEk3Sis1VDJjQWREd0p6a1E1SXZqQU5s?=
 =?utf-8?B?cnd2RDNzUUgwcDVuUnhZVEtMSEM5NDZvTE9nZUtDTzcxUm5xWk5uZW14WUY3?=
 =?utf-8?B?cFg1R0UwOFYvSDdGUE1UajlETjlaakFaWDhacVl0aVlBYTVxQmdYK1ExN0t0?=
 =?utf-8?B?UXpVUUFjSFRwVDh2a3RXdnlpZ3A3L2haZUdONkxzMmt3Ui8ybkF6L2gzeHU1?=
 =?utf-8?B?dEo5ME5OQVk0MXQ5WjlPcU5mL1RSNjdYTjZwUzV6R3RrY1NtSlJRWG5YdkdG?=
 =?utf-8?B?KzdEK2cvVzJxUGliak95SnBrN09BMWtNcUgxMlJtVDVKWkFwZ2pIaFA5TkJO?=
 =?utf-8?B?Zms2K3V0MHRKMkd6YVM5MmNkQjFjbnhzb0kyVEJnOFJ6TysxRDljT21ZSVRQ?=
 =?utf-8?B?enlGbVNwV2hhTGZRamNMcWs4ZkxLb0lZTWt1MFRHdlZEY1FhL1A0ZWdZOTFI?=
 =?utf-8?B?VjRUdnRzUTJ1a1VONEhJRnFLVEpEc3BkeHBiZmhteDIza2toYkNSR1JJTHVi?=
 =?utf-8?B?Q1hyYm9tSUYyeUt0bHl1dzNuSHB0eFZTWmpYSEJCQm1Cd3JuRjJ1MFlaSDFv?=
 =?utf-8?B?ZVZtQW9xSDhDNE1EcFF2QkxlWSthS1pSQVNPREY3aTUxejlOMmR0YWlZSVdj?=
 =?utf-8?B?N0VROGVqWXBHZXptM2o1OHJRUjRaWWZuaW1pcGJJcXFsWUJNU2w5dTBOZ3Zs?=
 =?utf-8?B?cHZjOE1XTm03N0RYR0FXck1rOStVc1F1bGwzWnJWa3NHelNDMG81clRmRWZo?=
 =?utf-8?B?MUQzdXJFN3ZmaTRabjhpQzlYUVhXWHh6MkQxSENkVkNETE9JczdKS1FYK1dR?=
 =?utf-8?Q?XJsju+aKIfnCx49XPWvpbHITc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391872c0-a895-42e9-c940-08dd7ce17767
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:23:17.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNjfHuxLd9NMpdkqSquZ0lKJqxh/2txzaiCFruP7v5I/jTzhxSwNo4WSoFaPaQr5lt1EDYQ1XjyU5PBhaq/jxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7811

From: Jan Kiszka <jan.kiszka@siemens.com>

The default of 4 seconds has been not enough in too many runs now. Lift
it to 60 seconds so that a slow VM (specifically cross-emulating QEMU)
is not causing false positives anymore.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/xeno-test/xeno-test.in | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
index cfa28df18a..590eac1e03 100644
--- a/testsuite/xeno-test/xeno-test.in
+++ b/testsuite/xeno-test/xeno-test.in
@@ -97,7 +97,14 @@ if which systemctl > /dev/null && systemctl is-active --quiet systemd-timesyncd;
     systemctl stop systemd-timesyncd
 fi
 
+if [ -n "$run_on_vm" ]; then
+    wd_timeout=$(cat /sys/module/xenomai/parameters/watchdog_timeout)
+    echo 60 > /sys/module/xenomai/parameters/watchdog_timeout
+fi
 $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=64 pattern_check_rounds=64
+if [ -n "$run_on_vm" ]; then
+    echo "$wd_timeout" > /sys/module/xenomai/parameters/watchdog_timeout
+fi
 
 start_timesyncd
 
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8B1FC6
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 06:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9s3ZwlttzSlkhd8493yPxQjOvVxVtKgiOY1U+548PKOqY21/JOnx44O8ITIJghwXhOLJWDCflCN7G2gomuU4PKXZoaTrm+4PZ/SPav9FHUEBkTAUPu39cD9iMgKxyppF+j9+GANDFPjzcMkwJa6KzgCTynvYG0zVZvYaRC+oWBtHy6P6fbzniF0KG4bBvyNFYa9INdF7Fr+S20i8U8bX04y6f4dWNQEAmXcDb+n3/pt2tOyKnDyAdJB0a1TEQyrZdzSKOnMiIjZbIQpNVA/QxMzat0KjkEzOE3wc3oWeWFMRL9cPdvvgbWej4suWl6PMeh5/AAFRgRWWJSZe9WxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/rQwaSq46OBB5eDvRtSq4bJtKLpPWrstoys0v/jmNE=;
 b=XXjQHHrgkKhqe0jnIGH4qOiuwmzWBQqo0RT5g73DIsFX6P+EWgou64K7A/yEaM4ESIQaSS/Uv5uVuRajS1eJJZ3GIzYUT5SFQmjuMVjLPQ2ZwCKip/Om9B/+oqzevc9wkZUxV7m70gu8L3x6AzxbFWiJ8EMA8HrZus/Mt9OG2vR/kSRM/piDz1VI+oLgdoibX8kU07CN4mkTbxLxAqArojJYIojrEbHonCMqnjVhbKtCoNTxg29KmH+Hvl1s15Nndz9u1rITySvUsXiMA6s+tnFFsrYXsX7vw+bA1BeJFVuih+iJ++noJiFPoyu4AonI792kpZ74gylDGlmIr6mgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/rQwaSq46OBB5eDvRtSq4bJtKLpPWrstoys0v/jmNE=;
 b=QJqJT/PjawZ8oJug6dixktr2g2zQUoa0wIWNXjXqecuaSv/HXqjnFOWyZW7KXz6MRpm9XFeZcXH5TlmODHxQ4PjLvEq8xBG1U6pTB0vDSHiwxQRfK434sjdU7tt9Jp6zmjkLYKODlxPzAc1cViylFKlCkHEN/nPycBroQsQva34hKzueVR/zT+sQhs450rqfeOUGXSyt9VeMjkXSuE0WICNjfwtunUimway+dWY0bcCWw85epeXbJT+Cc3M7DG3Zy3LEsUEkva1+ZXkQRjWnE0YSnIrDPaswg4p7jSrPPdRODtE30YSrFxbNE0TPypXqRWeWFp7nwOoqkSjD6WnP/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 06:43:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:43:20 +0000
Message-ID: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
Date: Fri, 22 Sep 2023 08:43:12 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Dovetail 5.15.129 and 6.1.54: New kernel warning on ARM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:610:b2::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dba2f07-0282-4bc9-cab1-08dbbb3735f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNIXUrOMxIB9XmNa3I/bOT8pukn8r1/ngb6oU9+8sgA481Tp5spj562sCGxV2oxTFshg6VMRLUkNQkaxbCEcndQxH6/R8iOYUIjzgCoVeMiFx7UajilYTPbmfyH+ftbxTjo4Kx9I5Lcp0gzZVieVUfyjbzcJpkT1gCYhpgxJ0xrIwhVli9KngIhyu/M97qyKmn3pt558KMLk4DpAMO690o/i5du2t5HaRaXJIF0pi8ykg7VG8u3quudWMdgwhmdvgMM6ihBLDIf2n2vyAKUZNSy3GvGckmvEF2oI0ApLqXm+G8MxO7eqw4i5BPKYZdZb1VqZWYxEcQwlOp3LOp3lNBomoKxgk/6+DCfACvcMwL8Hx2kkBy3kN0izDzsFAIbOu0nWq1W5clrFmkq6+LM9iQma1yreZ8rNtGdpG0RjszXS+5MOleWZ11WMuJU0/JawBL8TqoDxquaarRluqp5Fd6IKSbAD3cpDFDtArXUBiWlmOm0z7qpOKXBE/tvDHp6TTVDdsQNI8Z+UOPpZfti4gAr1cADFbRMvW2XPd6xgDmz69S0LqSI8rBPUARS73MiGccS7gc22mP0Zcs6VjUEYYvJ9OmdSqrcMpgWQkK6JOk/i436DwAqzXFsllXa+3xa3bMXeTeApch0BwTBP+NnXKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6486002)(38100700002)(36756003)(86362001)(31696002)(82960400001)(26005)(2906002)(478600001)(6512007)(6666004)(966005)(45080400002)(2616005)(83380400001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(44832011)(66946007)(66556008)(66476007)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhXOGNHWjZYVUxaa0ptd1grb1BsbnY1Tmlpc1NBSE5NcGkwM1hGdkJJa1M2?=
 =?utf-8?B?ZHl6U1FDNVJvTDFqREFvYk5ITCsvZCszZU13SDdkUWlFODlReUp1TStqeWJS?=
 =?utf-8?B?UGVXSCs3K213VmZCdlRUSVNjS1RCeEtsRTVpU2VPMDBBdXpVSjVLRENiNVBC?=
 =?utf-8?B?Nm9aVnczcEQ1TlJqaWlXZHVNTGtBVGQ3Nm5PODRoVDJ5NlNiMmV0U1ZkRDJF?=
 =?utf-8?B?WTl5VTNDTW9IWHdWbnNuMjI2aHhNTDRyRGZkYjVjOFlQNUpsQ21NdGp1M1Jq?=
 =?utf-8?B?elJwNE1CQ01JMGxpNHZ3QkdYYVlvWTJYZllqc05ySjVGVHhqSTVWcEtBNjkx?=
 =?utf-8?B?WHE5SU9HMGNNRWRSaGE4c3RUVUczZ1llWml4ZUc1Rnp3VnhXWVFkdThJTVlE?=
 =?utf-8?B?MHJNOExMd0ZnM3JiTXFLUnVjWHZwaElLYmo0TU4vcVpsT2NIZ05aZmJtYnln?=
 =?utf-8?B?c1pjN2FHOGVpWUFtc3JDRFRCbmxlNjhCaStPa1Q5Q3lBV1QycFI4ajBvOWZL?=
 =?utf-8?B?L015Y2dJVGN0a1BoTnJ2Znk2Q0lyUUw2TEt3N3JxZ0pEa05JNnVDdkhyWERL?=
 =?utf-8?B?WXcwMTQ1TEliT1pCOEgxZnltRjZWTVphKzdibXlYVDlsMnpEZUVPKzJ4Z1Q0?=
 =?utf-8?B?Ym83UFV5ckhqSmc5M3MwT3pObG51ZE9rWlRDNmt2M1RMLzhDRXMvUWtVN2tQ?=
 =?utf-8?B?RFBDUmJkeHBCdllsYzBPUU1QMGZlNEdsWWlXSU9tYjVaeGEzSjNaMjBhUTI2?=
 =?utf-8?B?eURJc3JBZXFLR3JkWG9GV3ZMOEtpYXJ6QmV3S1VNaS93TUVZN01hYzRQQ1Rw?=
 =?utf-8?B?bldpZjh1ck52cHVRdFdLVXpjZ0hjdnphcmhRb3NLRmtPK0RkS2xiYkxoLzBw?=
 =?utf-8?B?YTRaOUpxdkZ1M2dINDRGd2ovRG44ekc1dm1ybnZXZjY1aENtL0w0Smg0RmR2?=
 =?utf-8?B?dVFXVEpqK2VjYWxzSTZ4S0VmbjF2ZVBleXo0QlZVVmlWWXI3MmVvT3dzcWFE?=
 =?utf-8?B?L0RnaW1JUWhKKzR6UUZQbWpPcEpGOEMxYytkeElIQ1cralVWdWVVNDlBU2xp?=
 =?utf-8?B?UE9aLzdCSkRlS3Awb2pNME1lWW1BN0FIMGRIQ0R4aWY5OW5KUE9nUFdBUnpC?=
 =?utf-8?B?ZzYwdzFUS1NibDVnVjVQcG5FQUl1UHVqa2pCMFdmUXZDUlVqQkVxb012US9u?=
 =?utf-8?B?am1qeFg2akNMcFF3azkwNWVRRnZGRFNtQVpXT214Mm94SUpZb0lWSCtHOUdq?=
 =?utf-8?B?cVp3ZlJVT2hXWkw3Y01jeGRETUh0UGVIeUw2Q3VHenBWQWplUkFCVm8wZ1p1?=
 =?utf-8?B?VDlHWUppTHhYbnhwdVNoUGd5bmFZVGFvY2M2Wms0Q1dkSjJ3NEJ0Ly8zaHI2?=
 =?utf-8?B?K1YvSnVROHkvaXpmZ3lVd29WaDM5RTJpL1lwWjUxcjJjYlpxeXV1aG8zbEpQ?=
 =?utf-8?B?aWR2a0N2SlljZTdSWmRqQnlBUkt0bE1xMXFMWnVNcSsrelp2UzNObmFmN09h?=
 =?utf-8?B?WTJkRXpnSzVSN2pOZGc0YTZlSENMaFl3d3dObW1qNSt2TnlTemxrR3c2OG8x?=
 =?utf-8?B?R01RL2tVSStITUwwN2Y4bFNmVjVwd285OG5oL2lJcndsanZMbHlLbk4xdlJx?=
 =?utf-8?B?bStKK2JUazJ4Z09GQlB6ZUNpYjdzSHh6aFV5QXlKMDBwbWEyRldRemwrc2dv?=
 =?utf-8?B?cVRNd2N2eUFEUU9wRHdhalEvTGtTWE1Vd0w0UUNqTFVXcHJTSGd1OGZIZ1V3?=
 =?utf-8?B?eTVnRGsyei9vSitHYW9DNWE5cEMvK2xIRVNSSHR1NFMyUnd0em1YMDJ1cHIz?=
 =?utf-8?B?V0lHMlBKYTlSK1FjL2pWNldtcDlhSlR5S0lXUElZY0s4Tm81MXpSVmNKZ3pH?=
 =?utf-8?B?a2VuUHpmazliSkN0c2ZlblJDWWFwK1QvSnBMRHgyUnVlMGVyN3ZuNTBYK1Mr?=
 =?utf-8?B?eEpGdlZnOXVGSm5JQXl5dzJGMnk0UUVIeUJXMEhUcGdRbFFrUWxjdG9oVHlu?=
 =?utf-8?B?aFE3TDJvbE5lWno5cmxpY0VOOTduQWt5REI3U08wNXRWTkZETWtTRmN1Z25r?=
 =?utf-8?B?NVNmWWh4d0ZWMGsyVFNjOHozNnZCWjVpMU81bGNmR1RDbU9tUTZMZ09vcCtP?=
 =?utf-8?B?dXZyQ1RJVHp4OHZqa0syeTIwNmgvdlB3ZEorZ1cyd1NmSEZsY2laR205QUQ3?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dba2f07-0282-4bc9-cab1-08dbbb3735f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:43:20.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPoavCQg/MXk6A9ujo+SqEjX7hGD7DERu40FZk5SqgMoZbsHbrPEtqJcBmYhaU9Gz88aFjZFHECktrEaciykMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7498

Hi Philippe,

something regressed:

2023-09-21T18:21:40 [    0.000000] ------------[ cut here ]------------
2023-09-21T18:21:40 [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1829 irq_pipeline_init+0xbc/0xe0
2023-09-21T18:21:40 [    0.000000] Modules linked in:
2023-09-21T18:21:40 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.129+ #1
2023-09-21T18:21:40 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
2023-09-21T18:21:40 [    0.000000] IRQ stage: Linux
2023-09-21T18:21:40 [    0.000000] [<c03117e0>] (unwind_backtrace) from [<c030bd10>] (show_stack+0x10/0x14)
2023-09-21T18:21:40 [    0.000000] [<c030bd10>] (show_stack) from [<c1092dd0>] (dump_stack_lvl+0x8c/0xc0)
2023-09-21T18:21:40 [    0.000000] [<c1092dd0>] (dump_stack_lvl) from [<c0346b00>] (__warn+0x88/0x128)
2023-09-21T18:21:40 [    0.000000] [<c0346b00>] (__warn) from [<c108ea28>] (warn_slowpath_fmt+0x70/0xc8)
2023-09-21T18:21:40 [    0.000000] [<c108ea28>] (warn_slowpath_fmt) from [<c171d37c>] (irq_pipeline_init+0xbc/0xe0)
2023-09-21T18:21:40 [    0.000000] [<c171d37c>] (irq_pipeline_init) from [<c1700fec>] (start_kernel+0x4ec/0x6d8)
2023-09-21T18:21:40 [    0.000000] [<c1700fec>] (start_kernel) from [<00000000>] (0x0)
2023-09-21T18:21:40 [    0.000000] ---[ end trace 58996bc4bee07162 ]---

https://source.denx.de/Xenomai/xenomai-images/-/jobs/693461#L544
https://source.denx.de/Xenomai/xenomai-images/-/jobs/693455#L543

Not seeing this with latest 5.10-dovetail.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

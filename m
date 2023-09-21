Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447C171A6
	for <xenomai@lists.linux.dev>; Thu, 21 Sep 2023 17:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba5pqnlYhX4uIw76F9cTBwkuAMU0BqP730HElcrQaMQayN5K4JV2lwg//bXO+zUsvj46XPh/tju5o0NJrjLfz5JsjpXYdFYUkvK0CAeeuzK5WU3NvnKiM1CfcYs2aV/Sbl6cqj9R3hxFnG5hgIMxHRX+W5Ak/R76jhPgEKxiSU+gc+xN75OwsR+H76s7qTVPtF9M/7ouqJ1KeaP7gHWmJOleBIMyS2ukdoL9XqX/ZrLkzOszx4OhH8OQoy5KjXYgcfYtLTgrj29b162+chRAZcPBtfzfujVwTCH3i4psLUo1/Iy5/e4lQHjyylscV1gqTsMUzYrx9wcAK1wu/7BDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtdpcMuMdurQc+Y3Bdwru7yXWaAecyFVirm1NrsUSok=;
 b=NOkZJcjVd4v/9xgJ0h8ru9qN4gxZfwteEfmDvwpr/3MHy+f40V1kzF6pozl1nZK4zd7FNH+zk4GXhv6OZBrtc21MHHt390G2whN8TrAogAEh9pozcWKUn9XB1o/4RTCp5ON4BZpxTxEHjcfCw2AO52pJnNx392xUdUyBg6xeAlboef7PCa2nEQmktfc5Uq/lkKwkx2ew7/z3Gz0dxlIdzUOBu+X9zksM2UR8IKpt5f7wL0OcKtJQmGx2i3VRcXBFA/doHDhXVLx/a1D0TSIPhkqf84OJfEkOfpML0IaqEYUSItTjte7uCg/+Lt04XXQBcLwpDPqc5oaSA6pkoV/5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtdpcMuMdurQc+Y3Bdwru7yXWaAecyFVirm1NrsUSok=;
 b=glBfsbXlGywN1HxRQ04OWaiGVHjKUwgGJ44Nd4J7j/9OuGrxy8GwhO6uFynhNqD1Z7mdrQeDmFBm5762w/eXF9xaWCJ0UsjFzaFEjGJhzC/Q088G1Gx3EHX034Evl6KOH5kkPQl48ieWEDGxtZGnAS/6QEgPxpduVhYJDyuUb5BgkfFaIwGNBwiSkAndw4/nsfpTsgvDZXoedifI2Kbyr0PNINZLDKE1oe6wRkTD+mqeaN5TNwu51sWWcnWBXbrip6opF6pLLzT4oIRyWP6yjaESTXaundNnRTB9anuzsGrJkk4539EbwTfZVVM70tk5fjzbdN2aAQVl5H4CzhdQYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32; Thu, 21 Sep
 2023 17:53:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Thu, 21 Sep 2023
 17:53:01 +0000
Message-ID: <b65b1d56-a2a9-45a6-a0d4-6426be70bae5@siemens.com>
Date: Thu, 21 Sep 2023 19:52:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail-5.10] Re: tracing: irq_pipeline: add pipeline awareness
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <1eb4952e-f76f-4831-87e1-5effe76700ca@siemens.com>
In-Reply-To: <1eb4952e-f76f-4831-87e1-5effe76700ca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: ea84f462-74b9-4fda-82ef-08dbbacb9919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjJMGz+4x0aWX61EiFWB126W6RNRrYX5LW1n26krfm3sBdkBfQd/tYKXpErDnY+BOIH3e9WKdfwKdJTjI/mwMnDRyZNuZSPXYzNFxE1mDIwiebS7Awc6/1J6VzjTMRjt4Z5c+bp2hUhqooZQ88kWhs7Sh/meadzemIVBzpL+gH+mU1NknUFaxHKAiXUxyQO5AC/spL/jS3keV8VJ9eMv/jasrXMt23aBYKPP5sJlZS9D0KYgvxB6dZ/Wvc+uEWUuh2wPgRfkjXcUt5xWEYT0tPrH+zLZWyFp7jN+g97rIKG73xj7gCxdu1GHlAwvL5yyQRnmGoUt+bF2K2yNtI9YbRFwapjNJkhdQuv+cwedmMX+1oi1lUUxKYMcJ1O/Pj6IMtNzVl/3/qt7l7TJH51aOCMCqih+0CkaaQ524kjFJKTQuChjUttit7lRf7vllDDgSAFbFAJGusPBqiI02iD/FHnWaDR3Prc25NokMRJDLKxUaM2Xv5cRhzcv1mQEPE4KG5vj+rN7J8RQ1IOZdnSz0eBnGFZ4CVcviObsEL4hIdJJ1bv1yBR1B4GWUMjCmrPo56SnrkA5LoYehr/0OwEWFzaSsJAFl6JAeZjGCVSVXB2UuZiH3LxDZNQe00dxu9W4Ks9E7AmX+0AqwAorHVqN0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199024)(186009)(1800799009)(26005)(2616005)(5660300002)(44832011)(41300700001)(4326008)(8936002)(8676002)(6506007)(6486002)(6512007)(82960400001)(53546011)(31686004)(83380400001)(478600001)(6666004)(316002)(6916009)(66476007)(66556008)(66946007)(31696002)(36756003)(86362001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnFvNTdOa2Mxc1d6eHFBOWZzM0RsMTRmRThUNXg2M1VvUENmVDU2UGFSMG9O?=
 =?utf-8?B?cVVYL0VHZnI2M2djWlZBbDFCR3IycDgrTmpVdlNlMUgzaWhTNUxBWjRUVFI2?=
 =?utf-8?B?Y1JKaG9HWFpIeEM2bjJnYVVLNCtDVXVYUkVwcSthZUdaTFVvU3hEQk1OK0gy?=
 =?utf-8?B?YkpTM3BQRmVJd05DbzdWMnRKdTdDU3RYcGU4NG54akhtT21iZGRraVkyVzdT?=
 =?utf-8?B?ZVN1Z0J0Nzk5UWdob2x2elgvZ2xZMnozbUhFQ2tyUktOQWUvamRVLzBqNU8y?=
 =?utf-8?B?TUI1MGl6U3B5Y3J0YVhFeGtiYWFZWXVkM0VLSXhlSU5ha0NUeXZpZ0xJSDNs?=
 =?utf-8?B?OCtZMEdwQ0htdG1RYlp1ZGtVQVp1cTRPYnk1ZEgzQm4xa2U4dUtJcUljQm9w?=
 =?utf-8?B?c3JHZjNIaFhLUlRUenhqQ1dxaGZtRk9lTWVvR1V6bW5RcXo4M1h6SElKV0ZY?=
 =?utf-8?B?SUxUd1RCNFRxSXNHM2lXeDNaWDBWNEcxY080ZGM5REhCU2UzQ0VMK3BFa1BB?=
 =?utf-8?B?YkZBTXdYYksvK2srb1pic0dRYTIxWjVkbXNrcmZyT3g1YVdySlp4c284MFFu?=
 =?utf-8?B?cWx6WWFiMEc5a1Q3NFNYeEFzQ3hDWmVyT1A0azY3L0M5eGVmb1JOK1BnaHRw?=
 =?utf-8?B?cXQrQ2dEbFZiTWJ3aHpZemRNM2VpMEpvNGFscEYzNDlGQno1MHRPR2pCTnls?=
 =?utf-8?B?TTlJMGVSdmJic04xaFFEU1VZYUs2bHhNekZLaFRpVVNXcW10STZxZHN0ZTRy?=
 =?utf-8?B?RVUzVGJTaFNhbjRZNVlQUUtFTGZmU1lXQzdFb2VrY0RhMXhUMWtaeFQvbUZ0?=
 =?utf-8?B?dzJ1VThkZXM3dnJkOU1hSENEU3pjNHpyWWg5ZU8zT0FNTEZ4cHBPWnBER3Ni?=
 =?utf-8?B?djhZOGNFOElDb2l1T2VUYWVOQnlld0o1dnh2S1lZNWhyR0xnSEV2Tnc3aTlD?=
 =?utf-8?B?bE5EbW1BM1RjV1JrSEZDeEQvNmI2bVBqQ0VoTkg1Q2xaSklOT1FuZjFnYXRQ?=
 =?utf-8?B?dTAyOThZcTJ0M0dsd1EydXA1ZkZsdWJPQzNEclM0S3NjWVhMSWtwdVMxRC9M?=
 =?utf-8?B?L3ZBKzVSSFE1M21GUmJUZ2RINUl2UzR2a3hPQkd3SWxjcngycEpYa3VqMVIv?=
 =?utf-8?B?S29IVEtKVmlRempxM214OGFtdWYxUDFITjBSRUcxVXo5a25ERGtZQ20ySXBn?=
 =?utf-8?B?bW9YamVObUN1RGF3V1dRbW0xYllnQ2Jsd1pDL2ZJMVAyeUNScUEzTkUvcmNU?=
 =?utf-8?B?S0p3d2lQTHNlME9MbDZNOTJtdUhGbzg3REVyNzZiSVdnaWpBajVLNDFreXpi?=
 =?utf-8?B?SktDczJsZnRnSjU5MDB4TnE1b2pIWmxXT1VzWCtTcFVhS1gyaGQ5NnlyMkpi?=
 =?utf-8?B?aGhCRHJJSXY5L05sMnlIQWVVc0VXdllvZGNoR2RYWkZUV2NnYS8vcWxqbEk4?=
 =?utf-8?B?Qk4yajd3N1JTVXBneWg1WE9UZ2JCbkgzcm1CdXFVeW5YaVlOOGdMREVGMWxz?=
 =?utf-8?B?ZHBESGQyWDYrVnYydU5BVWsvMDZ3RlFvckZtVHYrckl5YWREWEdqMnJERlFN?=
 =?utf-8?B?eFo3QS83SWZHd2xXWWYramJJTEYzejNrWEpoMi9sVWxFZUZmTUVjZGcvQU9M?=
 =?utf-8?B?Qzd4Sk52TXJ4N2w2c3NXNGZySFFubENCS1pmQy9hYzBXWG1zVVNsTDNiT3VG?=
 =?utf-8?B?WFpqNlNpQnFHQ0syZHEzN2k2WDNsVThzOVNUOTFuSUR1TVRyU1M2SXRtQWEz?=
 =?utf-8?B?ZWhNdFE2QUxKWk1ab1Z5bE5sWlo2WXNaTlVCa2Z5S25ZSW12L2grOWdUOXUz?=
 =?utf-8?B?Q3Z6Z3Z6bVdoc2c2dytFQUtjQTZnSktYb0lSbC9rZ1ZxQ0F3SXZ0T0NxQjRu?=
 =?utf-8?B?UndaZG5Kak80R21BZERXOElPbU1ydTZsTy9YSmd5MHZiLzVISE9TVkkydUE5?=
 =?utf-8?B?ZUxHOG5tamlucVR5YWhKdUNiU0pXWVV0L1BMVUtUQzdiZlhFM0p0VkN3QkJ2?=
 =?utf-8?B?N0RLUzlpc3hLR2kxemM2NWNuc1pUVzJqeTNBbXRqK1BPSHVYNzQ4OHU4a21o?=
 =?utf-8?B?VndQQ3ZXdzhJOXFsQ3JSc1p5MWppZ0o2SlVQd21sT0hIYlVLZVYyVlVMdTVk?=
 =?utf-8?Q?Mv24qbpOVTWDy/V2A13Vo3xsD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea84f462-74b9-4fda-82ef-08dbbacb9919
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 17:53:01.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SACienqtnoZPozQig6dmkiglHQYXOEHTC28psOJYL07leng74/eZPABMpK6lu1KqGrM8VbjofOfcEI0PeqHejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6370

On 21.09.23 19:38, Jan Kiszka wrote:
> Hi Philippe,
> 
> what is this fixme in 5.10.y-dovetail-rebase (and only there) about?

Correction: 6.1.y-dovetail has the same thing, 5.15 does not.

Jan

> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3e0ae1168069..8d10bdfd8ccf4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> 
> ...
> 
> @@ -7229,10 +7231,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  			break;
>  		/* Now, we're going to swap */
>  		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
> -			local_irq_disable();
> +			hard_local_irq_disable();
>  			update_max_tr(tr, current, smp_processor_id(), NULL);
> -			local_irq_enable();
> -		} else {
> +			hard_local_irq_enable();
> +		} else {	/* FIXME: irq_pipeline */
>  			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
>  						 (void *)tr, 1);
>  		}
> 
> To my understanding, tracing_snapshot_write() will only be called in-
> band, no?
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center


Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363A34C140
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227114; cv=fail; b=V7Ef9tSvYZ7/P8VHaM7jMJBXUDo2lO25DrjHC2bGfXu8kGZ76CcKFN0SiYF0eJfvpnaa7Ktv+gek1OYtdCBo5zJLyV3+//EXnRDGKAYEIVM5jshMlpHKnUCrND/+A1b2kk27K6ayJVDq9CYxmu+Sk6ACOZnO1YqDY4D9Hp33VjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227114; c=relaxed/simple;
	bh=P1JjhWDZ4A2Ic1Daua7nj1skJsgE1ckf5LN8YTxO+D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFG0Jz5MktvY8u2h2k7YMTMZTgUuwrvYaQI3Qv3e3le+FEuCrEU+BgqWHRDDx4D/nbAxjFw7lFi54p5VwjfWfNhDAfSKnK/CC2l3urv+5qgfwqB7Vo1m5ZpfCg97KWAlyCs/6mClqthdepwARbKcRmpw0+y5nTzCFt0bqL3udw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N9yjnKgo; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N9yjnKgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjzsu8tE1waC3E3G5ZgLLLUgedhI/cCpsNPO59WDSD2tiwauzBCskkNX4pEvXq1Z3g8L4aouFB/pa4O9calVCK/e3Ub63epkU0JW8sNR3PfwWFq/06jPRwo2UB64/4CFUR9bFpBG3WuG3926cpXKsYJTCy0XXsPeanrtHbMunWwiWPV76olq+lupJRftDjjLiiaUhMoRXbyC3TorGQacotxFyJjMW2KN+3YSdSjfS0YK9ak68zgmxBoxOjVKP8GbCFs84q3qroZTB+hwqu6PBrp8h7duN5nGmrEpg4ygc5qfPRdiyHoboXHtnwb8AS++izJFX4PX88IPlQUCLc+NAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc0d+7ane9sThDBH/a2VAxDe9oxT47BKGFxslojKaIc=;
 b=WBteVFwBUTcPsjwYuhVSEeykJ+E6rKHkzoSzriHc+xF1Q9KJyGE717ZEAdSyV1rWZKoGzuP3hb8IGP0ov6fAnzRwsuBQfnkWwl1xTgoc48sohslJl1xYyfX0lg+GVst97EzigbGMBIY8eNs4recNNxY65iTFxz8BR7R46bnerYQ3hRasYvAwLImFPJl2ICxTqFj1auG6D7lRGsCJ0Q+anAOt5QuX60gD1N580KwzU9NRPgF6SKEbwGOyTd7Lg1xP7xHsq9hGbD4evLvy0akE9HEDMmdCDfLAhm7zSJRG7rPvd3c+eH9+EEnarciK7n7GGzAXxUC1D4tf0NVqMHpUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc0d+7ane9sThDBH/a2VAxDe9oxT47BKGFxslojKaIc=;
 b=N9yjnKgoGAUC3KOuMXEP7rmSwPIl5Dng5tgR21Do6/qYI4ywHe+EMNjnAodPy+5+5gJ949oUPZwXdsXvHkf5kl7UUuSwjWZvjdl1GX6pJ38bXX7/3ubVrAo5hPGA4NxEzMrfqlD1WanoW1Jto5GFyjbQQdIDkdYQqoaavYxQl94S8FEJizpXdd6m0OiDqTYMn6YBlw+kUasaIaZvvTYtEoi5ySEiBFWYt1KiWcNzEjqynDClbFRWzMpHoZetJ75Kl5tH+9X8mCH2zMPMnfhx4BE3MzZ3l/TsuMaPTEPS5GGgud3WbjeYEjc+a1xqY3cO+M9R1DAgQVQKWExG2XE9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB4PR10MB6095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 17:45:10 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 17:45:10 +0000
Message-ID: <a9dee4de-dbbf-49f9-a10a-c826fff92aec@siemens.com>
Date: Wed, 4 Feb 2026 18:45:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
To: Richard Weinberger <richard@sigma-star.at>, xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>, upstream+xenomai@sigma-star.at
References: <20260127213927.26960-1-richard@nod.at>
 <5491679.p2sp48Hzj3@nailgun>
 <ee18b4b8-22df-480f-be6d-38e23a3d6c1f@siemens.com>
 <8859804.d8oTp23Qrx@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8859804.d8oTp23Qrx@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB4PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8232aa-2f78-4934-07f5-08de64152495
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0VDRnVUSEVNcUNuWU9XTThxT0NaRW1qSU4wRG9RbW53azF5dmVlQjY3alNW?=
 =?utf-8?B?blg4NmgxZEg4M21VenYwaE9qa21TWjcvU1EwenZ3SUIxZm5iaXp6N0dNNWtK?=
 =?utf-8?B?U1IzeWlVSUk5N2pYaVZTZkhndklMeDFrcklIcUpDMEFtQy8xSmZDa1ZSL3l4?=
 =?utf-8?B?UnRVMDFLaVZGdnA3WGw1MVd2ZE5RZ2laUTVVUDFyY01zZnBUOTNuSHBha0lW?=
 =?utf-8?B?cFp0UHZXemNxVTBxYm5hdGRtQjJKL0NlTG5BUENFcW1PTHB6MjlqMGFzc21w?=
 =?utf-8?B?bkNMVHBpWHgvUmw4NUp3Tml4eVllVnZQYTI3djh3ODdqOVpjNEo0dGlsMmRB?=
 =?utf-8?B?NUtVT1k3WUpsTHUyYVg1cWFJQmVtZHFlM3JUTHJteXJvdUc5dXNrR25DVFdZ?=
 =?utf-8?B?VTNRaVNLQjN1dm5kSDVFdGJqZkpWTnhyeVU4dHpaTzhpd25mM2lqN3NIT2lz?=
 =?utf-8?B?ZHg4TnMwRVpUZFZWQTIyZ01tS3AxQ3FGcDBIczdDclVzR0M4ZFNZUUhQTTJi?=
 =?utf-8?B?NmdvaGFJTldDd0pydU8rMVUxcjZ5Q003VmZBbWs5cnN1NGNiZ1VjZVBvMjdw?=
 =?utf-8?B?TlpDaXFHbkZOYmZTeEM5akhzYmpnSktzRWJ0eU9VbHpTQktyR1ZDL3MzbEVv?=
 =?utf-8?B?T21rNGV1Uzg2VHJkV1VuZU1iMDA3OUhYMVNYSWtmaUhHR3grUmNENitKNGZh?=
 =?utf-8?B?U0NENDJWeUhodFdNeE41THFpUm0yU0RZbXpMUG9BSEZVL00rdG1lWHpVVkRQ?=
 =?utf-8?B?Mk40WnJjL0hSU053eU1lc0E2bXBsaWdVR1lpUDJVM0t3clFSb1ZSbXFGSzE0?=
 =?utf-8?B?aFVoVUxUYWIyOUZnOGRkamZUY0RZSUxFZUZyU0x2aXJ3c1dSa2tSK3FDRlQ4?=
 =?utf-8?B?ZHZFR3VjdUtIb0RsOHBJU3FLcDFWMXdqZnMvdzJGTnhWMEdnOU9rempFNVBq?=
 =?utf-8?B?ZFlQdWl3UG1kdXlWSERkcmdjMmFmZHI3WHh1K2VyMlhXbDZBQ2M0TUhTeHNv?=
 =?utf-8?B?aElHVUYzS3VjM2N2d3o4RzJMWjNpZitBWEl1ZDhEeUJJR016bCtMQ2owSjBo?=
 =?utf-8?B?VHYzZHlkQ04vbml5WWFoMXpXQkZOVVNpNHF5WWpyTGhvSXZ4cjJMUXJrMlhU?=
 =?utf-8?B?QmZIZ29pc0Yzd0k4S3VvMlJEaGp2OGQxWk83Q3ljK0ZUekp1aXdUM1RtOTd1?=
 =?utf-8?B?TThhRkl2YzlYaERnM2hudVNCT2JPaDVwaW9zSjl5MnM0VHJHYURXS3k4Y0lt?=
 =?utf-8?B?WUdLcWgxOWY4SGszYWZjeXNHQ2kzM2pVWTBDY2tWK1MyYTlua1J2cWlJUnRO?=
 =?utf-8?B?VjhDT3B6L3grcTdWVkFwaGVIcklvRGNQVDlqSG9SYVhlN1VqWFZ2RFQ2SkM2?=
 =?utf-8?B?RzNjbVladG5rSis4SUFaelBHQi9tTjRaUkRDNTZOT0J3ZXAxWUVlZkR1cGNj?=
 =?utf-8?B?OG83STdmbjdmOE15UHJzZVZpVHpwUnlTcUNmWVNuWTFEdjE0elF3ZTczeXEw?=
 =?utf-8?B?NUtGYWU1bHlKTjduamdtL1lLTUlPY0JiUEdMSHZRSUZINElpdFoyWG1BUzlF?=
 =?utf-8?B?VjlmZ0RjNGVudlNVM3RBbFNwVldpdS9MY21TSXFUdG5Ga2ZGQ2hRdlU1NWxH?=
 =?utf-8?B?dWRiY1hiVVFuMERQbjA2bWlZYmhQVi9kRWxCam1wUm9kNzRRQ094SWNCZ0o5?=
 =?utf-8?B?clZHMjVaeitvb0EwaitpMlRqZk9UdXhmTlExRFhFY0JRZ253b2VneVRkdGxt?=
 =?utf-8?B?ME91RnVEb0o0aTFFODBBb1Rvcm1PWjQyaWI1WXBLN3FwRUJXSmMyS1ZzdU9x?=
 =?utf-8?B?eDJ4TWNvaVVoaFpkTDRna2s0cHRLRDhBZTJSYThlaDY5Q2d1OHl5dThaejgr?=
 =?utf-8?B?R3BSQnFVU3hMaEJZS0oxSkxJNjJBNmpxbUlsa1FySlMyS2tQd0gwK0E1bEsw?=
 =?utf-8?B?dW1yQjJyTjA4ckE4V1YwVkQ3TUMxVC9kbHU0VXdYOVoyekJLYjQ3Y09CZHVv?=
 =?utf-8?B?WWlheXg2Y1AzWkdDMHFTQTBJWDQyNDVtUWhEUEdGblJmcEtlWWNDZ1lmaVhu?=
 =?utf-8?B?cEFkT0lnNmJ3WHloNXpQcFJyWURkNUo0UllVRmNjVVlaK2tUTUoyZzhoZlg1?=
 =?utf-8?Q?bcD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWtLRTJFenJFNyt6dzFZamRlZXpmUEdlUzVVVnB5ZzFSbXE1VlBQNGFOTmR0?=
 =?utf-8?B?S3dzdHVvZ2RqZzZVUVQ4cFZXZ0YxYUI1WDZSVWdtWGpsOHpMZ0ZzSTkrZCtO?=
 =?utf-8?B?d200Vm1xb0NySDRrUUhXaDVtc0d3Zm14LzBFYVQrcG5TV0pEV2xtTXk2OG95?=
 =?utf-8?B?bWJMVnZBTGJkNzBIaWIzT2dxWHNaTnVkWVVpV21IdHFESjdYQXNlVTloUFIr?=
 =?utf-8?B?bCtnZzM0Vk8xYkRlYkZHZVI0RHR6VHJzczUxdS82SmROajdwNUEranhFMEVV?=
 =?utf-8?B?ZHQ1eTFYRCsxT2FHMGlzRkgyVENKZEgzaGlHcjQ2SVkzRDlPS3BjMllxZHZs?=
 =?utf-8?B?V29VL0Y3cTNlNW5aTnBESnJvRUZYNjIxNEFBa3I0THMxbWI1dWt4YU10azdN?=
 =?utf-8?B?Nm5NUEhqY1NNc2RPRkZQTjBlVHllRXB5S2ZHdTNPNm1sYy9EanptQ2FMcEd5?=
 =?utf-8?B?Z05tWmtxUitscHBPRU1KbVhwQjlNTUZ0MTBjRFNJRm1YVUlGZ2dtRW91ekZO?=
 =?utf-8?B?ci9VazhYYjFCZ1g2SkVPaGF0SXpqTkdYZmZQMVZZaGNVRDZlNzdOcWkwa3Y5?=
 =?utf-8?B?VlhaMkJNUUVYNE1lZlFhL0Vla0IvVERLeDdqMDV6UjBGZm1PMmowUWhRQTQw?=
 =?utf-8?B?ajVsUGxzRm4xc2gydTJERTUzSWtCWEhlOXpsS3F4NURIMEV6NlZDdGRab1hr?=
 =?utf-8?B?dlRuQnNNRjZOQWlHQUhueW9VRlZ4TnFBc2JhdTdGdGxnNi9XMG1IT1pGbUVD?=
 =?utf-8?B?VjlhMXlVYng1Ymp4L0MyRUJQeG9BUDRyd0s3eDhCSU1aQU9PdmJ5WWk2ajZZ?=
 =?utf-8?B?NWZqRGRhaXIyL0Z5UnF6ZVg0NVB5Z0RocG1rckN5ZW5wUkV6b2dJSVgyM05I?=
 =?utf-8?B?amJQbC9xY2RCc3QrOVVRSGduVEZCbEw1OXpMRXorWVJzNXJRbjFoTHltMW5R?=
 =?utf-8?B?S2dyYklsU214S2ZDWkdSNUx3cXdvMUs3N3dPRTNDajMzQ2prSlEvbFBXbHlS?=
 =?utf-8?B?OC9URWZTMUhqcmI2ZFlpYVk0SGQwYStHc2JqR004a01mL09LNHdGeEd2VFFW?=
 =?utf-8?B?Y3ZTbzkvZ2VoQisxbzI1dHhCSWlCNGhKRmJaK0J4T3RrUnhXQ1lDWkViRy90?=
 =?utf-8?B?ZlhEZkFPdDFPeEVNTDhoSzZLUDc4SkVZYUtKb2ozZ1h6ZVVDL2pQaXVMZ3A3?=
 =?utf-8?B?dFA2S0d5OWd1ZVVjclNzUHZtb0pneVpZb0hiWXVCQ0RldEs4cy9zZjMxeXZV?=
 =?utf-8?B?eDBLZkN5WWx2c1UvZW5YTnE3VXoxT1dJR2tocmFaNjhDNCtldVQ1ZGxqVWhZ?=
 =?utf-8?B?dGhpZ1dWY2d5Wndvb05mRzFUTGUwWW1sNkQwMG4zdjF1ZHFkMzVXL3pFbnRa?=
 =?utf-8?B?SXgzTUF4aVpFZ1pFSnhhN05VSER4S2J0dmVzbzlrR3ZNU2djRHhDVmVPWTNR?=
 =?utf-8?B?UHZZbVZOSlJJQXBsWWx1NmJEbnRoR2V3dDh6Z2M3Wlo0TnVQOE5ybWVLZVdV?=
 =?utf-8?B?VDFOcllqTmRnSzVEby9uOGFGZ2hRMUwxT2NhNENZUXFDRlNJb1NGUWt2S1kz?=
 =?utf-8?B?K2t1ZTFmcnRicm5SOVJZU21jcXl1YlNBM2MxcjFkT1VBRGlhNDZnRTJDVGlw?=
 =?utf-8?B?a3g4Y2xBWXN3TGIrYzlBanorc0VxcVJoK1JDdkRzZnN0cjMwc3BJM2UyR0RQ?=
 =?utf-8?B?Q1htWDhFWnNvNkJWUkhLUDdrMEh5TC81WUlTM3daZFV6b09HT3AxMlc3M0JG?=
 =?utf-8?B?ZkpzL0xZNDVsdytQQWtBVzl2RnhGT0FyWElPRXIzcThvc1doNmFPTlFWMGxx?=
 =?utf-8?B?NEtFVzBXMFR4SWdRMkNaV3ovMUVXQlpMVWErd2NqNGJ4d3M3QzV5Ym9WRkFD?=
 =?utf-8?B?Y1N6RlBKanJ0NGd2WmFpM0NwQitPS2hzYTJ6VXhpNzY0TzRDQ3ZkYmxMbWhy?=
 =?utf-8?B?aEcrSDd5K2VJWi9TbzNyNkFqTnNMMk5tTXNuUHdENGhzeXJOenZrM3hyN0Zr?=
 =?utf-8?B?UnR4QnJyazh0VGQ2YTdqY3AvLzM0RzROMW5sWWNBdjBBWUxHQXdma0FiTGx4?=
 =?utf-8?B?R1JLYVA1bjJZRlorUjUvMTd4MmI3WkQyMnZTQzF1VHFuSkwyemVHSkk5TWgw?=
 =?utf-8?B?b0NsVTJGbDdzdjc3TCtUOXRuZmRMV2VTOWZ0clMwZGt6eGRLS1BzVjV2MzVG?=
 =?utf-8?B?ODd6cjVMclRkUUFLajJVbWZBSU5kbnovWGE0QWNyZ2VJMnNFRUUxREdiYlZV?=
 =?utf-8?B?cHdsQXgwbitwbWJRRTQ3dDdIQ3FnRjRUUjRkb2JHYlFQRTl1cE03UThDcWZB?=
 =?utf-8?B?S1lyWE50Z1ZHNmZPdXFKUExidmpDajFLQW5VUnBpVjN3NGYzRWF6Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8232aa-2f78-4934-07f5-08de64152495
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:45:10.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT+1QWptI709yXswlvexjdUQ2F/hOBtTmc2MLCcKNKsqAJ4oqbJ2qQb2DlxYoVwBNZ8yhqsGOaPk9mzTKJuM5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6095

On 04.02.26 18:43, Richard Weinberger wrote:
> On Mittwoch, 4. Februar 2026 18:28 Jan Kiszka wrote:
>> On 29.01.26 11:34, Richard Weinberger wrote:
>> Thinking about it, I came to the conclusion that it would be nicer to
>> keep a copy of the host pid_t in xnthread directly. That nicely solves
>> the race and even simplifies existing code. Patches will follow, tests
>> still running.
> 
> *rw mutters something about PID re-usage issues* ;-)

Exactly, that is addressed as well (match pid to task).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

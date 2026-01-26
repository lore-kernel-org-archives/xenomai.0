Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0134889A
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446191; cv=fail; b=CJBDtiwWPVhvRfXQ7ChlJzwd/30MANI0ImvK+pbZOgkcJKMaGzglTFLPkJrFndw4pq8V3mD7BKXOVbshAS/CLlmjzlDtcfh7Pw3waM7tOsTKkCnisQ6XYdZCbaHQuQBPps2618+cX6tVS5c6DpB3IW6HrdFQxrvZCF+Cdacx5Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446191; c=relaxed/simple;
	bh=QdIo7zRGpz9CYgmUOgd1slzsyNQvt2MjFt++uLEewaA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=teJXQBOnta+yV2kHGlmgJsubwUPRKS/TAF/YGtlA6jfmgDWzMHpOozKrzphUM7zjcH4pYziYFVLSzAEAc7W/ZanKPKbOwifDkPXSEEW94Fw9m+jKE0a3BBsJcLgtnJOYpaqL+CEfiFFq47TX/aC8SkaJyD8Czn3p0E1D+TVcdsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mxaKz1RN; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mxaKz1RN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1IEsvXMF0ry03a4FuMbOB8XnBJP+gUwCiuduThr03Gn1ERIzsek/GpyzRVmkT+POZ67N5NA9Sm1RApJDzDf77ZIesFYKp2p6j/kmxG7pX3i+prt15nb88tSHCm2thlLF2xEwiEeZ1o3X3b/bf8VEXF5ovkg25Q1/aHI9DKUG0adakuVfAMpW1mhXZZiorJpV+JUkw5bbp1u4oQOw3L2Ohv7zH1YGlieJkrucigqO6615XX//VK1avVoGeFU40kAgvYrwgXDS5TnwGuXKkH3mwB2suXQuUKdF1Zm3f5jmiYe73NYka2T3XIkyotlEpWheeaeq0aZWGaKL6xxnPnyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpTzbzBzoHew9KS+28sOXJIVus7gtrmFxO0oDGPsie0=;
 b=iXcrkqTlZj0pW9wlUvgvtxeYnpTBY5oqAxCiaH6kGjr42LVAKBDj+DYow3AqIOUfhwRMd6ZUeoHIZVpGmsUpQDXuAoGcDxvUq3zRyhaX1YkFbhbB2uloE6mAj7Dhg1YpT9QmcoEiVNlV+NayAFtvUsBAfin1bEPWTow+8GXC3fsQPwy0TWJFZ0y7htU7ZGoLZjqeiv1KBflnuEmlyW4TttqwgfBXOtOFsemfdlgAnVw5PhfV73z2/FfWxdS3D54MN/CnxY6QeXh+oWoeJwWJ5zFuuydF+PcCWCHsIIipwQdcJ67RUdtLXNdZF5FRg4Xgru5ghNeY8FOtKyLwdv2e2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpTzbzBzoHew9KS+28sOXJIVus7gtrmFxO0oDGPsie0=;
 b=mxaKz1RNRGx9URinI7vj9PR105hdr6jr1l+MLUt0IVgOuUhrsUZ0rbqHQUHev+Xhq+6Qrhz+npPsiorVbjj0uhVMAiiDExwJm6fDWEjhD1nQbbYpBAerAXVxXU6AAb5w31OO4+ZC1DBuSuVgQdswiWdYDOBIWlgw6H7wI4XEndnc2meNcnSmAbIu50XAijo7WzIUmTaseRdnbVSxces8GtjGhrj5tvcwhb0adT5GL4dZo7fBq20rqeIIG9X4+qKGWIZTWrchMHKhdprUia69zvk+dOxtkgwfWfmMDdlFPgOYHPxFUY402kDyh9LHe/uablJB+SP7d31MZemdEdUuUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 16:49:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:49:40 +0000
Message-ID: <a0773141-3551-41e2-ad7a-0ef90b505e58@siemens.com>
Date: Mon, 26 Jan 2026 17:49:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/3] ci(xenomai-images): Add build job for
 dovetail head
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260126161445.349483-1-clara.kowalsky@siemens.com>
 <20260126161445.349483-3-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260126161445.349483-3-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0130.eurprd07.prod.outlook.com
 (2603:10a6:802:16::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 069b3c15-3cbe-4dab-d63d-08de5cfae5cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1hpVGY1UjZaTlIra1VpcVlhWUw0TWNpT2Z6Q2ZSSVROSG4zQjJRbFZiNG85?=
 =?utf-8?B?ZGhFL3RtK1FkWlBEYXFwTi8xU1d5RkdNVnd2b3NpTHMxWUVsV05lR2c2UndF?=
 =?utf-8?B?Y3R4dExFZVdHTWpiMG5meFB6MXluZEdjejBXdGxGUU9oNzV1YmFRaUlhdjJH?=
 =?utf-8?B?VDZhWXUyY0sySG1NazRMcHZjbC8rK0hFd1g2OW0xUHRnMW1pMWhCZnNQN283?=
 =?utf-8?B?L2ZHclBPS3hxc1E4c3JPQ0hkMUgvckhrVDhtaXh4eW85ZlgvYTlFcDR2Ymx2?=
 =?utf-8?B?K1BDUnZ6eXBYMHhDUVRwb2syQnZ1T3NDaklVeS8rL2RsK3FSWjM5VDFDeUJK?=
 =?utf-8?B?ZVJvOGVKbFkzcGtJbXYrTGkrVkgyakMzL1lLRzNQUUJ2SzVqblFYOEdyK05Q?=
 =?utf-8?B?SVNPVG5jVVcwTnR2L0Vielg0amxwZm5CMVRGSnNQeXpEd2xjaU53RmxOUXc4?=
 =?utf-8?B?UldHN25hK09xYURmaFlObDRGYnFWZ0gyMmcxT2JHdWFJUVJrekxaWkZTVVVq?=
 =?utf-8?B?VjBxcmlWWGlkMHFPdlAxNWRwbFoyOVcyQ0Yrc29UdmcxTVBobmRUSm5ici90?=
 =?utf-8?B?Sks5RGwvQWVjdG5MdC95QUNpUVZWWmVYbkFtNnIvWnJqRXc0WE5XYWpsZGFO?=
 =?utf-8?B?UEgvaU9HenVUQ21OQmNtTndvVURLZ3JVa01mU3hSMHR3SlNzTEdWMjlTWHBx?=
 =?utf-8?B?bnVzUkRlc1JUM3U1bVB1STlPTXZrOENvYllKajJGTll3NE5HK1VuSVcxcE5a?=
 =?utf-8?B?NE4zL0xURmlhK2gvSkFGSWRvZlE4eHUveE55SXA4YTVVZWZXZ1R6WlBWOHo3?=
 =?utf-8?B?RVVUTk9ZTWt4TVZnTDZYVm5QVWdpaE9mREZWWHZKUUtyMEIrUTdQellreHM4?=
 =?utf-8?B?TW91M0szTGdJL0dsaGtBQVhBMzNYRkl4OU5NVHZkSzU5RGY0dTZQOTNyYTla?=
 =?utf-8?B?ZU9nTGx3UTBvSEN2R1hubkh1NkVjeHZ4MUIvbmk3QjNRZ0t4d0NkZVcwcGNi?=
 =?utf-8?B?S0FWRXoyN1YwNDJ4STQ4WnlmS3ZPcllmYWxxTHowc0l2TlQ2a3k3SGlvVFVE?=
 =?utf-8?B?WHVCT09UQnRTSWx4cGVMUmtwd3lPL3BTTjNMWWJTV1EvMWRMQjNrbEFIWVlJ?=
 =?utf-8?B?cHdUZm9uclRtT3F5aWVhU1Y0L2d6YUN5c3NaZHlWQVRkY255TmVMdnEwL0Ir?=
 =?utf-8?B?TENoQWtVRGdoYTNodHZtNHhuOURYT1JUU1E2VXYvcm5YR3FVNk1SYjk3Tm12?=
 =?utf-8?B?SDZWWHFPWEE3ZkRtbEVadlEzYVZWK0VQRlRET1ZNL2NxTE11VngzKzlEYngr?=
 =?utf-8?B?T2lBNXRQNndjWFBwZW9mc3RldUdzdm4wa3J1STdpekxHMk96SWh2Z3dsSHVZ?=
 =?utf-8?B?bUQxKzFVbkxrZGZrVTErbFIrMDBQVDZ5eWJ5dFVSYitrSllHaWowVjdnMzR1?=
 =?utf-8?B?bXE5WEtwS0NQYnlBSFY2YU1jNDBNQXhTNm1uN1YvakJOU1VBL0FabkNyRjJa?=
 =?utf-8?B?bUVTZEVJWTM4U0J0VG1oK3N6VEZoOEw3ODdLUE9OYzFOcjYzQlVKM3pzUGwv?=
 =?utf-8?B?S0FxeWhReTNnbjdqdnUvbkNnTjVNYkxJS1kralJQcHBXdHpwQXFIL2Z5allV?=
 =?utf-8?B?aGZPK1VDV1R3TVBDMHdNZUlTbzBlZGZaQ2MyT1pxZzFzeDE3RFRkWVhwaWVn?=
 =?utf-8?B?SG1FNGtlMjdtUG9KcTMrQk0xVWl2VEdtS3NudXN5aExGSlFLeFNUcGFqNmRa?=
 =?utf-8?B?M0F2UEg2a3l6N25tTk8yOUgyaEZuL1RFeC8zOUhzY0pFdkhIK1RvM3Qxc3hw?=
 =?utf-8?B?MDV0WWVOU1VBTExCSm1EL1JUMC9pUUZ2U3llcURDMHptNXRHMmRQYlcrbHV5?=
 =?utf-8?B?QlNqS0RPelBTdjlxRWVHWTNxRk43VldJbjVsYjZwbHhqdHpMOGJhdFdnQ2hm?=
 =?utf-8?B?dnJJSVgzeTVLUVI0SGlvYzFncTJibDYwcllnaXRXUnlWczNWTmlWNnRDZXV1?=
 =?utf-8?B?ZVZsQkxjNm5LclFrL1NkYVltQVNjR1hqVWRoOUdTMElKdU80N0Z2VXlOQm01?=
 =?utf-8?B?L1RqU3J1RDI1dXBIOUpMckxmSjF5OFIyVHlFZHBxVU5rNDU4N1d4bEFMdGdv?=
 =?utf-8?Q?tUWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFZK0JSZVAxeFpOOGFWZThoZXNoTVZPMXlUeWpmN0p6bDRQRVBNZHV1V2Rr?=
 =?utf-8?B?bUJQcHJMY0U3Vy8vSVRHeVpIYlM4dFlTZHIvU2FMc2hqR3lFN0JTTXdUN3Jt?=
 =?utf-8?B?eTRnNlNkbEtjY0h0eHhVMHV3VTB0U000RFl2NTB1Vmh1UHFPaSt4MVNuTXRF?=
 =?utf-8?B?TmpMZmJwNy9tN0hBKy9Fc3dHNkQrUkpjaWFsVENFMi85MlJtRkdueXcyUEJY?=
 =?utf-8?B?U1RPemNCenA0TU1CdlJlWG1GME9sVVRqU0x2VVZla0lmS1ZSZm1IOHl5Z0dh?=
 =?utf-8?B?d1lBclkvdFE0NTFMQjlxMjFsTy9JcGp6dDFlbVhKMWU2Nm4yOXJjOWxldXgr?=
 =?utf-8?B?Q21jclFKRlRjaDBRRC9PdnU1NmdYTE1tYW1aMEhKaTU0R3Y2bzdZODZldFRr?=
 =?utf-8?B?azdIQmdEb3pON1lIY1M2VmU2dzArZ2FKVGxESXBFam5HKy9wdGdqTzYySUM0?=
 =?utf-8?B?Ny9yUzQzN0hxeGlLclJZSi94RU1jdXlQZHI0a2RkU3NNUWdtcXE0QW9SSFBh?=
 =?utf-8?B?d0VQTUFBTUtNS2JuakpBM3hPdTNNc1p2dHgwWXJrMVJwZUhLZFJmQWovZG5t?=
 =?utf-8?B?aitCb3VHREYrUzFMOTBweFEyWnhDbEN6b01RUG1ZM0F5Tnc0QnFLeUlkN0hx?=
 =?utf-8?B?RGtGNU16NlB6T2phbHJIalExSG1kNXRkTU8xUVdwVE1KY0RTb3dGSU9xbThl?=
 =?utf-8?B?UHJDcjR1dzZuaVM3bFhaUHMwMVRPUHA3cE9mNUdMNWgrbWFIMm9pWnJlZWFr?=
 =?utf-8?B?SWFqN2s4RWdiRXhKVXo2V2kvYytocFZzMUhSOWJKZE9BOCtoRVgyN2xLSUll?=
 =?utf-8?B?ZmZkSHVYZk8xb1VvSnNCNnRxYm5XN1pYL3NTUVpBWHRyYkVVOEJscEd0MDZY?=
 =?utf-8?B?UFdXbkllRVN2WjZmaVpNMGNiMkhDcWduS0p5Wlp0L2ZQUmFCRmVkaCtHM2c0?=
 =?utf-8?B?QUc4WGlGa0ZzUk5zazQ2SXk2MnZNK0tkaTdBVXlKRW0rbmVzUFNYOXA2cExJ?=
 =?utf-8?B?ZFIxcXJzV0RtVTFKNHN1YXZodmZxMkRoNjJvbE13bGVVV05COFo4Vy8xTkwy?=
 =?utf-8?B?blVqRVd5VlhGZ2UweVhvOW11Y216MEZKQlRIbzdJcndtUk51K2tiZG9RNTdv?=
 =?utf-8?B?c29lVFBwT3JHc3ZEbGE1Tks1cE9Zd1VqYTNKcWo5SnJnaHlqS2g0Q3l0cElF?=
 =?utf-8?B?ZTA5YjlXQUVBZFQ5cWMxd01ZK0NJVXh1Um53RDJRYnBNdWN4ZURRVFdjSFIy?=
 =?utf-8?B?dDZmblg1dkJxUklyUGlXOXlSSmppcUphRHZEVUxYVjVyQ094WmFaWC9IZnBK?=
 =?utf-8?B?bXBHMGY3cWxiOGdoOStURDBFTDFNVHVJbFBvb0cwd1krM3VLckxxT2sySFRO?=
 =?utf-8?B?OVlwZVc2ZGR2aFIxSDhLYlVaMUNrVFJhT0ZmcnBEaGQ0OHRWSnZaKzlaWDlm?=
 =?utf-8?B?Z25JVFZrUGRPZ01uSFYxYlhoY05uMHRUOHRQVTUzLy9NazZtRWI2S08xRWFx?=
 =?utf-8?B?L0E0T1k5ZU1BeFRJdUZlR0toQWhicXZySzBSdmFkNjVmOW5xejVpbFlPSTRX?=
 =?utf-8?B?cGhlbWhPaU1Qdy9lYWhwOGFZVFBrM2c3elE1Yis2L2hLNDJIWG4yRkp3MTBs?=
 =?utf-8?B?UkZQQzNIaTF5K2JHUEFtMXFsaHBnUHREWERJQkxnUWhqT1JJZVRkS25TTits?=
 =?utf-8?B?bzlFLy9lY3RBZjMrekxjc3FEYWRkaWo5eExRWVkxejg5SHg0NHhUdUxNaVVo?=
 =?utf-8?B?YzQ5aU1xelRiakRBeHRpWFZrdjMrRXdyYWZDT20xMzNxNXNRUFZlVjRRSGtn?=
 =?utf-8?B?MGM1c0JVaFVNeTVGcnpxMEZUNjFISW4yZGh3MW56MkVaWFlQWkh3Wmc3Qzdt?=
 =?utf-8?B?L09rdlZGcVlJVjIxdWs0aEJmU214REJZWkkwbFB0UDJyYWgrOGRQUDQzV3U3?=
 =?utf-8?B?eTdOTjJoeVFyNzZOMzJoQ3Z4VlRIeHcrSk1QK294clM5bzVpU2sxVlhOMEJW?=
 =?utf-8?B?TnRuS0luUGJRalhHc2hBc1BNcStqL3lHeTV0S0ZOak9Ld0tsUGpFS2NnRDRz?=
 =?utf-8?B?Mkl2bDg1VXN6akJneVFmUEQ1N0NoNGVUTzVhUmZMVFpOWEVVRHBMYU4yZW9P?=
 =?utf-8?B?MmwwRUV5dnFiM3BuSDA0SVduZDZEOUJaMGlIUG1WVENvSFpMS0p4ZE5HRUp4?=
 =?utf-8?B?dkFGUTlQUERKUWQ0YUxpNXI1cm9DZ3IzWGlLblByVitkckhRTUd0dUNqTFhN?=
 =?utf-8?B?MUZIbURUUkZDdTRUcVNXT3ZaSGxWQzhUMnhnenk3Rjh4a1FBdW9uanF1aUo2?=
 =?utf-8?B?YUMxNlRqNE9RTnJlbHljTXA1eGtDcEFnRGkyWTlWNS91M1RkOWN0ZnIveGN1?=
 =?utf-8?Q?fgR8i/s9ZhNB9A8o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069b3c15-3cbe-4dab-d63d-08de5cfae5cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:49:40.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAAopAZY4zjTC3FqoINVwsHOEpeP9xQPlqeEIDbaPNizWmcAwaXhOSbLR7AIM7275fwPrW82S28qg11qkquA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8443

On 26.01.26 17:14, Clara Kowalsky wrote:
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/dovetail_xenomai_3.yml |  5 ++-
>  ci/kernel_head.yml        | 70 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 ci/kernel_head.yml
> 
> diff --git a/ci/dovetail_xenomai_3.yml b/ci/dovetail_xenomai_3.yml
> index 3ba027f..1628af2 100644
> --- a/ci/dovetail_xenomai_3.yml
> +++ b/ci/dovetail_xenomai_3.yml
> @@ -25,6 +25,9 @@ include:
>    - local: '/ci/kernel_6_12.yml'
>      rules:
>        - if: '$KERNEL_VERSION == "6.12"'
> +  - local: '/ci/kernel_head.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "head"'
>  
>    # select xenomai config
>    - local: '/ci/dovetail_xenomai_3_3_x.yml'
> @@ -32,4 +35,4 @@ include:
>        - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
>    - local: '/ci/dovetail_xenomai_3_next.yml'
>      rules:
> -      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
> +      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "head"'
> diff --git a/ci/kernel_head.yml b/ci/kernel_head.yml
> new file mode 100644
> index 0000000..fa109a5
> --- /dev/null
> +++ b/ci/kernel_head.yml
> @@ -0,0 +1,70 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +build-head:qemu-amd64:
> +  extends: .build:qemu-amd64
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:qemu-amd64:
> +  needs: [ "build-head:qemu-amd64" ]
> +  extends: .lava-test:qemu-amd64
> +
> +build-head:qemu-armhf:
> +  extends: .build:qemu-armhf
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:qemu-armhf:
> +  needs: [ "build-head:qemu-armhf" ]
> +  extends: .lava-test:qemu-armhf
> +
> +build-head:qemu-arm64:
> +  extends: .build:qemu-arm64
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:qemu-arm64:
> +  needs: [ "build-head:qemu-arm64" ]
> +  extends: .lava-test:qemu-arm64
> +
> +build-head:hikey:
> +  extends: .build:hikey
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:hikey:
> +  needs: [ "build-head:hikey" ]
> +  extends: .lava-test:hikey
> +
> +build-head:beagle-bone-black:
> +  extends: .build:beagle-bone-black
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:beagle-bone-black:
> +  needs: [ "build-head:beagle-bone-black" ]
> +  extends: .lava-test:beagle-bone-black
> +
> +build-head:x86-64-efi:
> +  extends: .build:x86-64-efi
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-head:x86-64-efi:
> +  needs: [ "build-head:x86-64-efi" ]
> +  extends: .lava-test:x86-64-efi

You forgot to set KERNEL_VERSION: "head", thus no QEMU jobs will be
added if the head pipeline should run them.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

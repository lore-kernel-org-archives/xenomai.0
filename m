Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E8145354
	for <xenomai@lists.linux.dev>; Mon, 29 Jul 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257594; cv=fail; b=fZ57Vaq5Nid+/E6CvNIRdS5FPct6Um9qWbru7SOE/7Wo0JT/+PgWHdzrXPfIhlt0GbwS6JyFLo+TumZnUnJW89jfRw6rVVgYqNrmk1ikoc6i85XJ430uvxFiQNVqLS/xSuIORwdUZPSLggnseW0qpdJhTKJxvEmEcP3fBMeRVkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257594; c=relaxed/simple;
	bh=3MgjCaVXHCMgtf2vQfQDDesXp7/MBLmW1XTPkgu7V8k=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=n0+p+kDJVNgvXRNYjKHvZ4VTgUAVjZ0yTV5HOcoxQV0APWrZVxyMX53ULKxef+iqX8iyiqsB5gAxDgGVkeSb+DiJLHSeSDP0u4IPaa2slcehCpFBnHAuoYl4jKLvjp73Ofm0hK65IiNwPjNhiPox1LzuznUWzQKATK7taCC/vVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VAKShaPv; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VAKShaPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpsjZ5spW+uxZJeEvp/SLJxPCo/7xKgUBYYUAymqD351bgffBH+/QsYRZdvkXx0MMa3eCm9kK+zNbfbiFvVXNCp8L//NiOxAJQxRIV23pCkAYfeh6T7VIXf+U+CnHmtS05jIRG0kxM74h8gKw2EN1aS01odDuCiedwnr/1UcGsQrL0A4Pm0qO4eHT7GNOqGQLC1RJO7MEW4uq6htruWoSQ7GrsJ44A10RY3lbEkNXAeg4gPvl4YGIFQPzpGs4HuJbyXQXAHGlf+L0fCSqiJmGTY6HU6/ctWjU8OqpYYn8OHUcsZKB85GP6uj3te0J2shNnpl/XX0xfQl4Y3YfXs+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxP2UcHIWQ9Si7NskMdyfjzZtIgjAQcjptyzlCvXNVE=;
 b=yHHYENwzcMEnrzcui86QM93NnJMur5JFe7N5RIV9FWGmQfUsyD4ZhoQ3/tWc+uRUplkuICd3SWLgC38ti8trWj/0F7bLFKeK0aLgZVF1u3168okf4a88a+Of9yysf9CM+Z4zaKM7YsEE0/ZVPgPLxqPhdqL8Mg7CRgLs80E9lBT1IMTEp4H+Kg6vtONBoMjtHIm/BEJiaaWIMmDjp1N28TWCZg6hGpur8Xkse3wCcgX/AxEuWrmpHrIH5KqQsyxiwQvGt+HIm8e5qjTbZwsegj/OBli+bMt+8koNcPcYVhbxBkNAtMg1901Kpms/R/snOYr8ab/ru8NBK5EBDTBqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxP2UcHIWQ9Si7NskMdyfjzZtIgjAQcjptyzlCvXNVE=;
 b=VAKShaPvRdOuJWyFaCMQZ1Z9mvBLiLnuWFY18Am6+ITcv1K6hwVRSWwLmzzcwhzAyrrXOkkN31bBsQbtEkjvBBclpaXdoFHKPtDDskBsveR4rQWdGTwAvugebuEOz+ww9eDsGmXWs2Eb6Pw3Jb6IxQQl0M0NZj72PC+qixeZIDzZwOC18IGVApRKQFpUfmJe4CBdv7rxegUvy7e392ClhYYgNjpTvyxj4VwOsWc++WsNEglPlTPeazMjuUIsqeKq3yscr31/yIR6O6ofGsqhN3g0hii0zh28jUP9njKTS/QQ53YLSW+h6YVk7nSOOkvRTpZjcBkQxEWSPezJkWIYQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM7PR10MB3718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:53:08 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:53:08 +0000
Content-Type: multipart/mixed; boundary="------------jliEosa0WcxUKlKhVo79ragU"
Message-ID: <2a5b0a7c-4f31-4091-9a4b-7e9ae09c5d7e@siemens.com>
Date: Mon, 29 Jul 2024 14:53:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
To: "Nechita, Ionut" <ionut.nechita@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87h6eprhbg.fsf@xenomai.org>
 <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87cypdr5fm.fsf@xenomai.org>
 <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87cyn03qxx.fsf@xenomai.org>
 <7edb3e30ad2fa511a189cf6262c5c7fa997d074f.camel@siemens.com>
 <8734nt31by.fsf@xenomai.org>
 <PH0PR11MB59491575F8AFF5D7DD7489FCF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Language: en-US
In-Reply-To: <PH0PR11MB59491575F8AFF5D7DD7489FCF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AM7PR10MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab67a2e-8ec3-4a02-9da6-08dcafcd6569
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlQ2Q00rMXhhOW1uS0VKd1VvTnY1NFdueXA0amlORW9vQTlUZTBoRnF6Qmg0?=
 =?utf-8?B?cFh0RS9ERDVUSlhTeUExbEhQVXhEV2NyOE4zcXpVNFk5ajNuSkZGZXhUdDFt?=
 =?utf-8?B?V0NxU1FwaytHbThsWHkrdnJVQTdFZUJjRTc3RmtXYTZ1Tmo3a1NWNjVxVTNh?=
 =?utf-8?B?eXNML0FjenM4anh0cEp6aWJ3MTRhaUlMQkFJVGs1bkRCdjJWMzVyNVhINjJs?=
 =?utf-8?B?aERFcFp2RUYzbDBlTmhuVGZkZGNlYkxzREcrTVBPMDhpMkhEc3VjRGRORk02?=
 =?utf-8?B?TWZCRHZHQVloODRqL29aeWVCeEN5aHFQMFd3QTZhSjY4dmZiajdJQkg2R204?=
 =?utf-8?B?bE1xTk4ycTFJZGZNVG5uZ2wvaGVxZGkwL3NmZFlXZ2FJK01UOGQrQ215UVNx?=
 =?utf-8?B?OU1iTSswRDViem1RSkFCTDZraVduK21KeFJqTmVzT3lKZVp0cEMzM2ZFcUJR?=
 =?utf-8?B?RzNCQ2pPckxiOVBMOEs5VXFjejNBYlB2Mm5DdTRuMlhNYkRKODV1Rk4xWXl6?=
 =?utf-8?B?V3RCZ2o2M2NKOFpKWVNKRGw0bXl5N2p3QjRYNXpBZThYOHJHMkhlQ2doR1M0?=
 =?utf-8?B?K25qUHVBa3BBMXNhU1pTSEVHci9tVmlWQS9oNis3bGxldkhzNUxSQkl3SHgy?=
 =?utf-8?B?c1c1bFpXVzFmT2F0NUpEZTRVMDUveWt0UUdUcW5mZFovNTNGV3ErZHgybmhP?=
 =?utf-8?B?R3BjM3FON3J1NzBxbVlDbU4zeFJnVE9lczZMT1hXemlNQ1c2SWpQTHZzdDRs?=
 =?utf-8?B?K1JhYnl0S1hhd2ZsdWxnTkpZS2lIVGJNS1dNQUkvMENaYUdIWU1YK0FTcmRo?=
 =?utf-8?B?UTh2eUJhb05LLytUemtuR1hocnJ4SnhKNHg1WUJyS0hvZVdhOURCN3UzSi9Y?=
 =?utf-8?B?OGVsREEvMDVvbnAxaEZzRzgvZzRhRWFZUzBvMllzS1R2NmZBYlRneWk3SkFp?=
 =?utf-8?B?cXYya0FHckVPczNoTEV0dWltZ1R4QkN1RjY5Rm5OclJkSVJ1ZFFwK05lTFoy?=
 =?utf-8?B?L2dtQ0pPbHcwaVpHV1M1dFBnYXd5NHhCUVdMRGJ3d25aL1lXZ1BKaG5tazh4?=
 =?utf-8?B?WFhYam5WQlNDMFRRZHlya1VFYkt0VWxhWHcrbnZOWUY1bGczUFlWYU9wWENM?=
 =?utf-8?B?aUZKOVdGYmhhcmp3T3VXMFFSTmJkWWREZjZUa0cyTGtyUVJnU3dvWWV2OXA5?=
 =?utf-8?B?cEZJSStGMlNHWkxqb2xlNThueWFDeml3Tmo4UEhqUTNla2o4RHlTdEx1dXFz?=
 =?utf-8?B?bkFBazhJbml0cTNSWEZIdUI4RjdiTnlLV0oxSDF3NHZVRXpGMDkza0xVSjE1?=
 =?utf-8?B?QjVadmN2K0gxYTlXdjVFRWlvWVF4ek5rRnRnLzJtOHFLSWVWRUJlV1JzNmRq?=
 =?utf-8?B?WTIxTHdFZWlwODZEVlNiRWF5aTFIYzN6cC9xa0J4b3RBYktzM3EvaVpuUzFZ?=
 =?utf-8?B?TnpZWFppSUM4Z0dOck9ZMkhKaGVVY2JDZHdVbDBmeU10NFpFNisyZHBLZWhQ?=
 =?utf-8?B?SGUyemMyOW1EdDJqU1RNU3pkTXllUmVYN3Z1SGYyUVZLYmFxdmpsenBXVmFH?=
 =?utf-8?B?UkdmREpjcm5kMVhVeG0vdjZ1QWp3QnlaNTE4bE5tWWNIVWVqSjJhU2h1cW5k?=
 =?utf-8?B?Ymp0RnNZS1kxNk16V1BnR3hyTVlON0k3QUs2MjBPNC9sWnk1cjdmZXdWSUpD?=
 =?utf-8?B?ZFdTb25Ra3FLVlRwU2JhWHZDRmtTNlRkcFFtbGJ0OWIyaElFczJVQzZrWGQr?=
 =?utf-8?B?cTdFR1FuZi85TUkwTXVjUlh2bmFqTmw4UUtWSDRxODZhb243eVRqdXgvOHI3?=
 =?utf-8?B?V1U0SHMvN2hDZ0JXY1RvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHVxTTVTYjNvUXMvREJRTk5Eb0VGNURjaUFYc0NaMTJxcVRXYzZqM0dvTzJC?=
 =?utf-8?B?K2pqZzNWNmlsNDJzSWw1YVIxeGk2dEVMTTBDQ3c3MG8vODZzalB2S1lHZlp0?=
 =?utf-8?B?OWpaclQ5NXRyN1l6M3hoQkphSlljNVFLMUVISnpQVU9CYU9qUzBoUWNkT01O?=
 =?utf-8?B?NENUZVErdUgxa1BXTzV3N1pyRlRyRnAvOUhYSnF4QjI4NFpuUlovNHpXTENY?=
 =?utf-8?B?bHVyT0xjNkRVQzFRbzRCUGs3RURBbUUwVnU5RmR4OWRIWkdpMWpQYlpDQUw5?=
 =?utf-8?B?MHJxd1BTaFdXazJwajJzZkY5ZVV1NVE3ZkpVZ3NUa1NCNTlXVktRdEk2aUJs?=
 =?utf-8?B?Q3Z6bXFVTlYwQ0V5anBMTW5EQkZQcHUwd1RqcnZPUU1Rb0I1N2lYKzlnaTN3?=
 =?utf-8?B?cGc0cFFnN0JZbzUvYlNHdkEvUEg3WEM1VXpDOTBPdVZPRGdqNSsyejRKZ1l5?=
 =?utf-8?B?aEJWdEp3aE5aQk4rTm5WcVM4a2dPTVQzWVF1dks2TGx2cU4vRnpXQnMwV1Er?=
 =?utf-8?B?UkJ2a1RvY2ZUOTVXcW13RElkcGlLWDVVS3ZFSHJDWVB0N3Jvb3dKUDYrdXU3?=
 =?utf-8?B?RGhZNDBBS1hrTEFNVFczZ010QXhvZFQ2VmNyZTFpV0I5WHhSRGtQNE8wblNm?=
 =?utf-8?B?Mjh2bVFtYVFwcEtPWkhIcTh3eFJ6ZnhPSEl1ZVhjUTJJSTQvUXBRbFpuZGNl?=
 =?utf-8?B?aDkzRHJpQzQ2U1NBSlZVSUxRVWlqY0FMaGZrRUhzUHBqU0o5SGtLOTYzYkUx?=
 =?utf-8?B?SDBnZndGam45NTlCaHkrWFVUMlRPTytJUHdlQVNmYmdlcUJjdUtYOEE4TDFR?=
 =?utf-8?B?S2dhd1psUm10NllSZzRNdWR2UW1KaWkxdnFrTXdqVGRFQnliaitidEcyVlcz?=
 =?utf-8?B?NjJad2ZCTXl5MGkwVW14WmxZLzBkZ01WTE12djFYUnRCM0REUG85TDYxU0hU?=
 =?utf-8?B?QzdCMmNvbnkrbEw2djBaMmlIUDB2bGZxTTlhcHk0ODAzNnMzekhoSkRqS0RV?=
 =?utf-8?B?WENNZy9LUnRoOW53UHUxWi9BdGtBWGVlVVh2UXVoQU0zM284eGJobC9rL1Mr?=
 =?utf-8?B?RERhaEpZb1dJZHZqMUcxQjFXWUxpelMzekdlSXg2c0FBWm11VURaVjNZeVQx?=
 =?utf-8?B?di9UM1B2VzczUVFQOERVSFZlaUNaRXRFdlpZajlnaDlEYnBzRjNxaUt2Rit4?=
 =?utf-8?B?dmtzMWZSK1N0cnFPdWthOEhaUXUrMGxoNy9tWFlqNnpEZ0tTQ0s3Y3FraGRQ?=
 =?utf-8?B?dkw1Y05uSENNbFZWYmx0ZlBsb2U3RUdINnJJTkRhbDZkL0puSWNLa2M5REQr?=
 =?utf-8?B?ZktxYVhPRkt4Ym80NGRNS3BGdVVFVUVYc3Jsbi9pbnZib1FGVmJnWDdpS0xM?=
 =?utf-8?B?SGNZSDlUVVRoSE13WmdueHRsQnVkL1JWK0VHVmdlSm4vRW9ZZGJyV1pOZ1NO?=
 =?utf-8?B?RElDNkZiUnRHKzd3MEdackNPNHM0R3VxZGM3WjRoU3A5Tk9CT0JwdXlYMVFu?=
 =?utf-8?B?SElubW5OK05kdEJZTFRTVzE3a1RNblFIcEUxYmQweFhUT1QzdU8rTnRXdDBW?=
 =?utf-8?B?Wk9XM2JZWndGZ1FJa21uMHRQQUkxVkxHTUsyVm1XN1RuMExpcU5sbTNobnNP?=
 =?utf-8?B?WldXbytuRyt6THN4S0xMajZsd3RuSE5HUVBSc3Urb2U4M0xZbzhUUElxc0Q3?=
 =?utf-8?B?WVlUL0tKTE9nV3dVVGdFS2gzWVdIV2VwSk1JMnE1bmdGR1lOY2xkcUE5MWU3?=
 =?utf-8?B?M2EwMEZBVnpGWi9FTXJxZ2xQTlY0RC81SnA3aVQ5b3BJYTcyaHZpSGNEMDd5?=
 =?utf-8?B?UXZwdzFtdXJJTU85SGRHYmNMSDZLdmZpem9ZQVV0WS9GVGpxTzRlSXQ1VXd1?=
 =?utf-8?B?RUs3dmNvNGRmakJtSzMxVFExUzJnSlVOM2h2YU1zVVdqdlhla1JUOGE3dlFj?=
 =?utf-8?B?VTBEVmdqSElLdWpwT1hDY1BkelNRdkdFeStJeklxNzMvWVl3SVA4NnBMU0p5?=
 =?utf-8?B?UHlkZGpNTDVlZnZETm9rNXQwVDVaTktjMlFkWXRucFFtK0g1YWpGR3dGZG1O?=
 =?utf-8?B?bzB4ZEhjZWdxRTdEK2FuUXlFSHFIL0R4UlRhUjFzM0VrdGhXTlhLRnNJSlZ5?=
 =?utf-8?B?SlJCRWZTWTdXNGNFUTZqMkk4c1VlL004Wjh2blJYcW56U2poQkxzL2RCMnly?=
 =?utf-8?B?K2ppYWFJdk52dm92eXM5Wkg2WXBiL3ptaEVWWDVBaTBMMDBWNHY3eDM4U0hH?=
 =?utf-8?B?am4vUnhzR2hmYU00UERUK1I5bHZ3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab67a2e-8ec3-4a02-9da6-08dcafcd6569
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:53:08.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwZTxs1GuAZB/IV8dYBPt1VKkusRc+zJxSxeqoeYVjI4mbWAdjaFQDqWpcT/1kSUt4Hjq0SJ5Nt5bjyM6ORkTq1SPj7EcaGqupoLFNYZdio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3718

--------------jliEosa0WcxUKlKhVo79ragU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.07.24 13:09, Nechita, Ionut wrote:
> In this case exist one fix for this?

Nope, needs a code change and some testing first. I might have time to
look into that next week, I'm on vacation right now.

The testing part for KVM is quite easy, the ACRN part is not. No such
hypervisor at hand...

Quickfix: Disable CONFIG_KVM_GUEST or CONFIG_ACRN_GUEST in your kernel
configuration. As long as only one of them is active the problem will
disappear.

Best regards,
Florian


> 
> BR,
> Ionut Nechita
> 
> 
> 
> -----Original Message-----
> From: Philippe Gerum <rpm@xenomai.org> 
> Sent: Sunday, July 28, 2024 7:53 PM
> To: Bezdeka, Florian <florian.bezdeka@siemens.com>
> Cc: Nechita, Ionut <ionut.nechita@intel.com>; xenomai@lists.linux.dev
> Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function 'do_sysvec_inband': error: duplicate case value
> 
> 
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> On Fri, 2024-07-26 at 21:15 +0200, Philippe Gerum wrote:
>>> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>>>
>>>> Hi Xenomai Kernel Team,
>>>>
>>>> I notice today one issue when compiling latest version, v6.10-evl-rebase.
>>>>
>>>>>>> error: duplicate case value
>>>>   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>>>>
>>>> # make -j208 bindeb-pkg  LOCALVERSION="-1-lowlatency-evl" ARCH=x86_64
>>>>   GEN     debian
>>>> Using default distribution of 'unstable' in the changelog Install 
>>>> lsb-release or set $KDEB_CHANGELOG_DIST explicitly 
>>>> dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes 
>>>> -R'make -f debian/rules' -j1 -a$(cat debian/arch)
>>>> dpkg-buildpackage: info: source package linux-upstream
>>>> dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
>>>> dpkg-buildpackage: info: source distribution unstable
>>>> dpkg-buildpackage: info: source changed by root <root@0296de802d65>
>>>> dpkg-buildpackage: info: host architecture amd64  dpkg-source 
>>>> --before-build .
>>>>  make -f debian/rules binary
>>>> #
>>>> # No change to .config
>>>> #
>>>> mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=/srv/tmpfs-disk1/build/linux-evl subdir=tools/objtool --no-print-directory -C objtool
>>>>   INSTALL libsubcmd_headers
>>>>   CALL    scripts/checksyscalls.sh
>>>>   UPD     init/utsversion-tmp.h
>>>>   CC      init/version.o
>>>>   AR      init/built-in.a
>>>>   CHK     kernel/kheaders_data.tar.xz
>>>>   CC      arch/x86/kernel/irq_pipeline.o
>>>> arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
>>>> arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>>>>   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>>>>       |         ^~~~
>>>> arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>>>>   154 |         case HYPERVISOR_CALLBACK_VECTOR:
>>>>       |         ^~~~
>>>> make[7]: *** [scripts/Makefile.build:244: 
>>>> arch/x86/kernel/irq_pipeline.o] Error 1
>>>> make[7]: *** Waiting for unfinished jobs....
>>>> make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
>>>> make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
>>>> make[5]: *** Waiting for unfinished jobs....
>>>> make[4]: *** [Makefile:1934: .] Error 2
>>>> make[3]: *** [debian/rules:74: build-arch] Error 2
>>>> dpkg-buildpackage: error: make -f debian/rules binary subprocess 
>>>> returned exit status 2
>>>> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
>>>> make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: 
>>>> bindeb-pkg] Error 2
>>>> make: *** [Makefile:240: __sub-make] Error 2
>>>>
>>>>
>>>> BR,
>>>> Ionut Nechita
>>>
>>> Mm, do_sysvec_inband() is wrong when it comes to dealing with 
>>> HYPERVISOR_CALLBACK_VECTOR. We need a global pointer to the 
>>> hypervisor-specific handler, that would be set up by the guest init 
>>> code which traps the vector. We cannot ask do_sysvec_inband() to 
>>> figure out this information, it depends on which hypervisor trapped 
>>> that vector in the first place.
>>
>> Exactly. It was me duplicating the "wrong" ACRN implementation while 
>> introducing the async page fault handling for KVM.
>>
> 
> Strictly speaking, the bug was there prior to that addition, the async pf patch only revealed it (I'm hereby claiming authorship of that bug! :)
> 
>> I think there is no way to look at the IDT and check which gate was 
>> loaded by the hypervisor guest code.
>>
>> I haven't checked yet if that would work, but at least the KVM 
>> implementation enables a static branch (kvm_async_pf_enabled) when 
>> loading the IDT gate. Maybe we can check if this one is active. If so, 
>> it's KVM we are running on.
> 
> kvm_async_pf_enabled seems to be controlled by a paravirt capability flag. Would we receive significant information from
> kvm_arch_para_features() <- cpuid_eax() in case KVM is not there?
> 
>>
>> There seems no such static branch for the ACRN code...
>>>
> 
> IIUC, we cannot have more than a single guest allowed to hook that vector anyway, so could we just track who's doing that in the places where this vector is trapped, e.g. by setting up some global function pointer referring to the proper handler which do_sysvec_inband() would call upon HYPERVISOR_CALLBACK_VECTOR event?
> 
> --
> Philippe.

--------------jliEosa0WcxUKlKhVo79ragU
Content-Type: text/vcard; charset=UTF-8; name="florian_bezdeka.vcf"
Content-Disposition: attachment; filename="florian_bezdeka.vcf"
Content-Transfer-Encoding: base64

bnVsbA==

--------------jliEosa0WcxUKlKhVo79ragU--

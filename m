Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103325C83
	for <xenomai@lists.linux.dev>; Fri, 16 Sep 2022 14:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc4XQzTaTgSBkGiWmXDiB86DByo5V4wdcm19z+DIm1iqgSuWB3OcTizxEtxAqe0GrunCrq9Vs5vWV+dnwZY9qbbc/BIzC54DKAPviCphntBNbphjeBUIzLh+UHAlHQ2Dcb/+np3YtJhguU77J4USRxZJwksnmDtFgKx2YLRSVw/Al4OGXyQbO0yhWO9G0Yfg7wJINPB00WM54T53VNTqr9aNsP2EKhgpZ8o/BkdRzGH1a0tt+t9m7KFrTxL7ba+PfBVViFt4+PhzaIrZxQHHxf55rw0rh9tNdOuexDLTvfJ5k6oA8NulGocJ0QiJE93ANjhr30+yDAEN2GEbXne7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN2qTP1/FSGof0NGIF8WA1hqI5+6UWhJQljar6nfkv8=;
 b=i5rAcfsmvfCLCqwJYPoQ1NNUa0b6LOdfDoUFLQXF0sMkZqAqT/6Krnd9Nget7m93sJhPFiwpPpgMEHFV0/MzFbpfxvxIDNqLtUVCfzQRZI3Q1fsd5ZNfaD0+0KxMAV7P7ceENfxzFvW43qBoWxYGoPt8QU000Z1tptoDsN+6L8++PUMyy2c3nQT1K/RwiHFECNgB5btMWOAvj5onkJliSvVzPQM+QBPlUBTRm2oZJS0fCd7EIF4GI1LtubWJPXuqhZi4tGik1eWDCspXO+O9nv1OedA/iY0vVcx9QGeoAcboELytETrZNvM18ETNAGiYw7fmZNne9kohMIH1wO3tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN2qTP1/FSGof0NGIF8WA1hqI5+6UWhJQljar6nfkv8=;
 b=pgIlc8sxZ8YEpB16qnHJYzE3K1VgkhF+3zwpLvsKMdxg1x2RnQHAlZbi0F38kqHNiR7BRUKexXlAKTD57EfnD2gt4QL6e9kbBA0PUYz395/g/fGyRECjLEhFMBJwQaJ9YaEQ01DaDaivycyW9N4khvRtj5xXuLdzeaYci617rLHCPIKefXXE/V0F9P3RrNuWOaUy/Je1fo42Cl/O6Z1d887HkSbgoqxQ+yIy4jAP9qqHoNpNXY64EGc+fEut28XlQaY9P6K6h1bABIHWxg+CVuQybQkkJxyegZfCSFeACV9c3aKVZ6oIEZni1CHeVxbLKn/yZjklGxfArWxzW0lTKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 14:42:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5435:f167:af38:40e0]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5435:f167:af38:40e0%5]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 14:42:12 +0000
Message-ID: <f471945a-95b2-bf12-3244-3a251f371dee@siemens.com>
Date: Fri, 16 Sep 2022 16:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [xenomai-images][PATCH] ci: Update AWS Deployment settings to use
 Cloudfront URL
Content-Language: en-US, de-DE
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
 <20dc6cd3e7bbcdea499b9590c25af2fa8cf0ecc8.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20dc6cd3e7bbcdea499b9590c25af2fa8cf0ecc8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::35) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b65069-7395-4b72-fec7-08da97f1a425
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mKw0WgpujamJbQ/WdJ1/0YkRXVWphDv2RE0P+91SPtrjGbXYKf8l8eUmhzcWPCI84EyxoqnHyUMCzLM01C+DQca7DJcxHImg0IFUVwUF2l/X/1hk57MArV0NC9eSjfLBHiAbMOvMXSGumicknPIumUJst96NUtWnNQjXxSRswJSe/NZJGiuiDZOe2rfYH6rPZG3/G2uD6OHzfltIbWi3itfagIFtCnKSVn8YmGYnEy9WHjF9/y2NxSp1ZhGJtgKbZ1+uIOuvdHI/r3kPANpOrWXS/qPvKtRHc3b8Jh99yIt69ID7SXXHDm6QMFkYvnq80Ws2QoLiYIh5A7N0gHY5SoLTjyEvmyC0gh8U8QLKt2RAtukTcL9n0gDeidZDMg+tfu2jWpw7UGTFhJTjx4MyzuSE8tp1lyJFS1QAwfiTc6QVD5cC1Rwn6XqhWoIpU0wkl1CFgk8LrvAaYFH9A2jOON+UqlitO7qVSDqcavQj2EyTQ7PNgiHaQi8HyDNQEKY6zjkaMak/PkPLOJNGTUFzfcuUSZyg9SZ8U7vOdqrTfJNzT1eiaMOyREkZLxE8mNkK43K22KIvLo9+Mgyf+/ZMJWpK9oKxy7ke5Q0PYtB5/7oEb1SEj+SmqfKTnAtzHr9geXl4IN1zoFB/G8Wbb8JV/NkCa5FsaXlC9V0gqiGcrUZmTTU2YXIoTbSTT+whmfwaoQVHSLmQ3icJWSbI00IwamGZpso1Cl1wvMrMagSfZkEGMIzP+O0iVfhzYTAZONOvnGNcc9O14TfNMYP/YzMLD8q2GCl4S8gB3apKSCeFXvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(316002)(478600001)(6486002)(110136005)(8936002)(5660300002)(4744005)(86362001)(8676002)(41300700001)(66556008)(66946007)(66476007)(2616005)(82960400001)(6666004)(83380400001)(53546011)(6512007)(6506007)(36916002)(186003)(38100700002)(31686004)(31696002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXplRnByRzNoYlJuSUpnQUgxMzRUbG00azRqTFl1MC9pOEQ2MEwya0VacUww?=
 =?utf-8?B?bXQxQnltdzBCdkx4aG1jVUZlUHR1OE1jTUhUWjhiOG9ncmZlYmRLdTYrZDdO?=
 =?utf-8?B?TEdpWTJSbWwwcURGRlgyTmhqK0hWSVo2eW1EWU1mblBxMU9oYVdrRGVNUU14?=
 =?utf-8?B?eG9RSGI1b3lLU2Z4c0lKblZEVFJCb1pibldzdXR0eWhDTWhuNHMvd2F4ckFn?=
 =?utf-8?B?aEFPcm9LWFVJZGYvbFpPd1l5MWNsWk5rS0lwYUR3UE5vQXlvWGpvdzdpSFRG?=
 =?utf-8?B?ZElDU1d0QWdRbUdQSUZzYVZpYW96RjVsOUxaSm9GWVhqU05wU1BBVFNvdzBl?=
 =?utf-8?B?U3BrVG9qTERZc21iMERuV3dQTkp6YkRUS1AwRUhnWFFzcE9oSGdaT0JLTFRO?=
 =?utf-8?B?cDBUV1hHaGgzMVgvMU13VDI2YzhhVFFUN3B0SlRyalhDMjk5TmkvaG9TeFg5?=
 =?utf-8?B?QllnbUJnVWhFNE0yWkpRbnNwdkxJR29KSHM1d3B3OUFiUGEzSlAvcElkSW9o?=
 =?utf-8?B?WHB0ZVNBTkNiaDFrRFZ1MDEyZXZBbDZFWTd2WTFlUzZSYjNHbWhES1VWbVZo?=
 =?utf-8?B?QmdFT014NWFUNGlkd21GVXVVRFlSRk1nYzdKWS9JN000bzNaZ1k4YmpCbkJ1?=
 =?utf-8?B?WUs0bzhlUHlKK2lsSk9hWDZQSWY4VHc3SkFmcG1Oa3lwcHlyNUJIUWJCTnFZ?=
 =?utf-8?B?ZzVaNEwxNnFtWERVdlh4UE9QRldWK245K1NLbkQzSG5NUVNlSGZvV0tKaG1M?=
 =?utf-8?B?UENqNVVOekNIZEhaL2JBaXR6Mzd5VjJtbmNDN1BuTTZFMi8wMlNaOElUV250?=
 =?utf-8?B?eU5IYTVkUGo4UjdrRHVVYXVPUWNpMUVGcnkwQXl2Q3B0UjM0NGgvSml2Y1U0?=
 =?utf-8?B?QzhvUmxNNndLTkxyR3dZYUhjMnZ4RU5WUmllcEJNdnhYMmVSdDNaQXhwZEdK?=
 =?utf-8?B?WVVZZC9MTm53NHJNM3U0UVF2aEVOSmlsc3RlQmxFNjk1SnBUcHFoK2w1ZmpP?=
 =?utf-8?B?TlZUN2w1OFI1OWUxUERjUTRscWQ1Q3M5cXZtWEF2Y3lZNVFoWE1sWGhKaW5Z?=
 =?utf-8?B?SmRReDFrZGlaY3NOUUVmcjlXVG1iK1NGeU0ybitlaWlRUldyRVI5V1dBcGVG?=
 =?utf-8?B?eno4UDlOMy9HVURTcno2N04xT1hmazhsVTZHcGxjbDRZRFpLMXVOZG52bFk0?=
 =?utf-8?B?L0lpckREYWNBZGFXZWtsY2x4cHA4aXZEUllqeFh6L0Q3eWUyblBhZkZFVWw5?=
 =?utf-8?B?MU1malBPWkJzeTBiSUNjUUk0djBwUjJLNURpSUFwRGpzTlBCQS9Mc1crRUFz?=
 =?utf-8?B?L3d0eGpLL2pDNk9zaHFJT2dOdXV1RC9KbjhydzdWaXJ0Qzd5bnptVjNwL1p1?=
 =?utf-8?B?MSt6b2R3cE5ZdlNJdmJ3b3NWNHNWSitmK20zVHhTbVR4ZENHVS9Tc3gyekpi?=
 =?utf-8?B?MmRDSk53cWtRMEJzeHI5U0FNZkxkWU5IWWdvTTRmazdJbU52S25uWFhreHRN?=
 =?utf-8?B?U0ZVVzBITGR2OHZZVGVWZGpSUGVVNWZaMVdoTS94VS9nNVY2d3JKbzZQNHV0?=
 =?utf-8?B?SDY5RGs4MUdRU3N3QlZrZ2k1aDJ3RTRJY0MrYWY3L1BnaUx6TjhuTHFmYlVk?=
 =?utf-8?B?allkZjhpSVgvTlRTeFJydkxaRUVpMlY5M1haSGQzeWVUb0xvT3FUSDlXR2Rq?=
 =?utf-8?B?Nll5Qi9WRG51aTNwYkFGMXRwSUVBaEtrMHdmUnhJb0x6WGdkYU1kVktJNUo1?=
 =?utf-8?B?Nm0wVW5OTCs3NXZGNnhCcGdKd0puSUp1NldUK1ljdEN2Q2N4UG5ubE9GVWE5?=
 =?utf-8?B?bWludFJBWjlFK1FKa1d5NG1aL3hpQ1RNVVlXQmNha2t6RlczbDVCOUROOWN6?=
 =?utf-8?B?RHFPc3hESkI1NE4zZEhCVUY5S1MrUzBZMVFSTTd3Vk5tNWROU0pnSzQ5aFFr?=
 =?utf-8?B?aXhXb3RsNHZzcGlodmNwN2Uvc05wS0tsZ2NFM2FPQlpiVjBTQnZrRzBVUFRE?=
 =?utf-8?B?c2ZyakFQZWtGdFlKVDI4ZEJpbFAzcFdjSnAvUSt3Q3JrcFhVSTZIK3R0V1NC?=
 =?utf-8?B?T3Z2c3lZLzdZSzdOd0RjTUhMc1N0TDdjYkRxOTZJWGIxVEdDQWVCejA3LzZB?=
 =?utf-8?B?RWxwcEpBMHJSLzlCN2VpL29FQ1dzL2VxdUpBeTNxUjFMam1SQnFNeVpIcWow?=
 =?utf-8?B?R2RKaStnaFVoOXIzRzBTY0lMcW5sTHprVmhXdE54OC9KS05CWGozMThjUmlT?=
 =?utf-8?B?MUFLNDJtVlhuekl1ZTUzbUxtUUZRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b65069-7395-4b72-fec7-08da97f1a425
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 14:42:12.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK6tIIDB4IDlf6aBNGu4Tjh9iII1hyf+aYoAnDhzl62cRHaGaWGvbqQr2nHHTBeuJor4X/LGF93NVUufY8opUPyPdHwEBelLo6IB12kAsOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5908



On 9/16/22 15:25, Bezdeka, Florian (T CED SES-DE) wrote:
> On Fri, 2022-09-16 at 15:21 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Remove the acl settings as the are no longer valid.
> 
> Hm... I have no better idea so far, but that means that we can no
> longer re-run old pipelines, right?
The short answer is yes.

For the artifact upload I have currently no idea to fix it in a 
compatible way.

The download URL can be fixed by setting the `LAVA_ARTIFACTS_URL` in the 
gitlabci environment.

Quirin

> 
> Regards,
> Florian
> 
> 
> <snip>



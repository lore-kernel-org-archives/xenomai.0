Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87E7C
	for <xenomai@lists.linux.dev>; Sat, 27 Aug 2022 06:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLBjgi88JAtw2tnFvLdAXwgwPpBzL75moiCsol2UHnvVdjkEvve1bKA3sO4LStahHCtrtwaB7sNQqUKNBRhh+eIOVC6+lHLONDBVTWF3qZFifJvlvDVd72um696qFggTLakcc+zrr8NTllESXEYHePJRjWN0pmxJneJRmcV2cRgzlhfzczPKTev2GyMrGICupY5hjTcHg/Gm7lCig3yx9mbswNPBWXX9O6JFRxMUN+OG7M5LQzJS5CLpK2x2PgAl4sQTjWnCUIKD8n0jsOwRCer9CksLlgECV3x70JAyPlqQoC+SsOgLzMW9EBCBXJYcKD9orvDK8Lk3weBTO9BQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfaAg7GgXrBGQPGKZy0P1vGf8f4qrkRD6wR6g9QpSZ4=;
 b=OKoDHpZ4AksAyodwL+45P10UFXvC0k48kvLyzRCS8VERJM94bW6PEsGP6VVksaD3a7iduLiNPNMJOet8uq8DVcyDERKAeAwaIqWrAjCO4f+vj4wlgbBj9yJl/qkDbxyVA3oufJf2FcuhMmGgN4VH4Dsf1dOvEba2YWO14q4R7w0biliPLlo6UGdxAep9WkgAtoN+gVdlcpA2gGuuWYaVKI8uv2HgYRvZHQCgjX5V0EL90mOPn20BZccW7Vyl65foKBZ6S2mK0B9ag+dLTstbnTNkETIgcCrgk1XNpdstVFu1Gf0bLrNv5GP1Ra6iO1uoS1iJ5MeDsQxY2as4o/7i0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfaAg7GgXrBGQPGKZy0P1vGf8f4qrkRD6wR6g9QpSZ4=;
 b=pjS3l9Z6t+CppreeX7hF6wLpI6exJ7TF4iLGTPKkXpTlSWWyS3YlZ6nK5C977/CXm3Buo71fpnkk2dqD0ncaeTAQo+m5pzA06UEquuKRKE046kl5A4z7i4njjz4LQZhu+AUATsG53HM1AZRO+4aBIzZ2CQg1rhypkZFq9rqIMKz5He17DCUJoIkS9FUEdpAVuuE+cqe1EZlUEaOXUubj8uH1vj/CHVjLezlm3jLwx6BTo/qS7EFemvJqUhSdHvJGIJKLOKfIX+hLeZlhnaosf1EZKOjoXV8N9lOGGLqqX2qL6DE0rZg5KAhEHj6rq46h6z1pwjy0UOiam3anAkIr2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VE1PR10MB3870.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 06:35:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5566.015; Sat, 27 Aug 2022
 06:35:53 +0000
Message-ID: <675196c0-9c8a-9a36-3cc4-c292658337ff@siemens.com>
Date: Sat, 27 Aug 2022 08:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@web.de>, Hongzhan Chen <hongzhan.chen@intel.com>,
 xenomai@lists.linux.dev
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03e93ac-04dc-471b-4afa-08da87f663e6
X-MS-TrafficTypeDiagnostic: VE1PR10MB3870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KhtCgrTy1YZOArVpau73B6PSInOEt8zGdELV3XfKj1MOtCLG7cvQJ+07fmdvOcEqOFS6vEk2dWKjc4k4sGZE6JbknP0a3PH7NLIqxqlxekbYQxjQAwS2bXzSp+ARyYcaCM6qYSEHntirFBgeh+RYnEzOvCgdhRHzypEu9gilIvLr8WEqKKJEMLt4d/rYpywAi5e9thf4CArcbQCppdMMO3fL27T1L0ItTiAfk/lr8b/4PpgUYsbpn5uYva1bl9HzZ5TDrIsAHBqInK6zFUdUX4T3PBE85EM/keIjABFcvWNbS/6tYtNbRG1GGfkB/O0hvqEXnAKCOJDsNVwQzdqD2Fi6+8estGO0G9sAdm+edbuIAgKVwh+dAgp3HEyHm7c+GnyuDaxXb8fk+U+OCMRIBjSbVNqUA3lOsycfj+CFHqTyIng+vFzzea71JO3NFINPm9my9PDFFC6Ix0lrpqYz22LS7EExwNGIDjFh1S21tOkG1tprtuN9cjcrTHw4hB0Et7bikNRvLpBWBTbiG5PJFpU/dM8qnuMFVHIvM28+h/s/JfsPeoZRhYXzBc4A5tkRxrgi1gLsdS5ehennB9jF5dViAjNlJbezTDQvXTb2k66/8FxCJTWYD2XPYRNQuqfl6hXN/H7FI0Kj18I9S9oHHkbx3N1j7HpCmSX8zHwUoQt9MjUM4pg98OHaTy2MrPPVCmlQEBOv9DQw40lKb/RJyKeKPXIhUZNJiLKTUHIfFojLIbowOJwd0IFfteHd+Aocvj2Kc1PH+xx+O5NwBJBWsyA5PxY2BbUf1tVnFyUuSLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(6512007)(8676002)(6486002)(66946007)(66556008)(478600001)(5660300002)(8936002)(66476007)(41300700001)(83380400001)(2906002)(6506007)(53546011)(44832011)(110136005)(86362001)(82960400001)(31686004)(31696002)(186003)(36756003)(316002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUNsbm1qVjRxZ3BWUGQrYThjVnZteHJJSkx3L2VwUHFxUFE5SmFoOVRZZlR6?=
 =?utf-8?B?SmJyTXpCeGd1TUxta0p4cjVqdmZSQ0xSdzlDc3hvd1owNDJSR2VTVnBUaTl4?=
 =?utf-8?B?Y0NPZ0ozQ3MvM0gvYm8zbzltODdob1o4MDM3Ui9DM2UzWUxreS95VlM0N3lv?=
 =?utf-8?B?U1FEd2pkcnpkREZFK0tQNnNlRDg4U01FSkVmMm1DL2crcmRHb1hVQ2dwNTVX?=
 =?utf-8?B?NnA0V2VrM1lVVnVFY3ZmQTBidlprNnlHdnBpeTkzY083ZC9Cd3U3NHkrMkVR?=
 =?utf-8?B?YzlRRzhrMkNqU1hBZkNuTW01cTdUaEl5cC9oWFZFZ3UyVmp5c3Z4SlZKQjNu?=
 =?utf-8?B?Mk9rdzNIVEZYRjVZakdEbkRONkRrMlhkSUNlT1VzZmx1UnUxNzkxYnY2dmxD?=
 =?utf-8?B?UmRFOEcwbDdUc3Urc0hjaW8vdnRYQXhDYmpGamlLTFA0MHNhU2ZLdmMraytw?=
 =?utf-8?B?aDlFUTlMODhoSWNIc29VVVFXZG85Wkp0cHNBRGtGaFRDTUUzTG9HL1IzVW5P?=
 =?utf-8?B?ZWticGlLcTh2am40Q242U1JXR3R4M2lUbnBSVkdzMVdrWXF5RlkvbUxZOWhx?=
 =?utf-8?B?cXRWSGhJcjZBdXZFL2pkbDNJbHdEQnRBMTUwRXFDTnNuNVRqclA0TWJvTGo5?=
 =?utf-8?B?ZEJVdmpRVGdqRlVPUnVJWCt4OEZ1dUl5MWQ2K3VBc0xNeHlqQWhxWmpESWd4?=
 =?utf-8?B?aHRpMEd2Y2xuTGo3dGh6aUVTZzU3TjlBMFZyTktWeXQ5SS9HZmRJbTg5RUtv?=
 =?utf-8?B?SWdqQVUxYTNmK0MwZnpJNk5BMEJzVEhoUXJqMCtCSnFSS1BNK1F5bHR5d09P?=
 =?utf-8?B?UnRPOWJVUElVdkh6L3MrdStxZGZoaWhTZ1BpUnFvUkJxRnpBc0cycGhTekZE?=
 =?utf-8?B?MXQ1WTdXMEpMZnJScFRva1lBQmgrUFZYWnBRZCt4dGpUMVZDUm5IV3hvRlk0?=
 =?utf-8?B?ZndJT25VcDVQTEM5SjY1d1NXMWJXemUrY3p3ZFpHRzVodkNKOXBpS1JCdUpj?=
 =?utf-8?B?T05RTEFMQXhLaVhhL3pGZXhuVFlBY2ZuMlkxR0hqSHlFL2o5dmI0UUVqQ2dL?=
 =?utf-8?B?eWVXMTVEN0Y1YkV4ZU5Ha0o3QWx3UDdHQzA0dHRENVJqamtzN0hWWDdVQzZu?=
 =?utf-8?B?WkFmYUNTSmJhRGkrSHhGRzJVVUpXNzM4R0dMTzdYV3lSb2ZhZlpjclZpL0Yx?=
 =?utf-8?B?SDFpNnlrcWtUZ0d6cm5IWDZKYThYd25hMXllYllJSytrazdTTHBvVkttL3pr?=
 =?utf-8?B?aWpFR0w2SjBIKzUydmdWM3I0RlB1VGZrT09xUXhMR2kycHpRNkJLbHl0Mm5K?=
 =?utf-8?B?NzhFcWRhWEkrbEZVU0lPczIxWEc2L3dlUmJSd2tERllVNHNFSTZmeWFqTG1O?=
 =?utf-8?B?NGxCbTFFSWFJQXoydDZ5c2tBanJGdTZab09IQWJzajMzMWx0cUlCSmpEanBJ?=
 =?utf-8?B?U2k3KzJEckw1QkNwWXJ1ZUFyc2dxd1k4R2NycitRMS9aT1FYNXZNVFppOU9E?=
 =?utf-8?B?RTlhNDMzTGNVZnBMMktlWkFsZVM1UktuWk1SUHVkYmU1Zi90eE1VdUgxQWVj?=
 =?utf-8?B?aysrVkhLUzk0cWIzWHNJdHN1ZU5PUk5VMFNoYXhlek0xUWd3S1hFc0ZqVEdv?=
 =?utf-8?B?VVZOTlJWMTMyelBFNmJZMFJQdERFZjBUb3dGUXIwZ2tGVG0rcHhEQUxyU1dr?=
 =?utf-8?B?TjBTZ0RNMzY4aGZrNy8vbjFCTUM3eFBPYWNVMFp6MisyK0RxZGRuMXBDcm1B?=
 =?utf-8?B?aFJLZ1M5QysvdTBqcFp5bVFJS1VNbXpZTmhkNDFZL1JMUFFCRzV4TTVZNE96?=
 =?utf-8?B?cElPUGdZaDVnbmlLbGxRUVVuYjhvZ1dwcXpGTEFIQlpoQ2lKbUdVZUJkaVFy?=
 =?utf-8?B?QnAwQk5UWmdMcVN3YzhNVDBkM2VOaUFZRTk0QVRJcTVQQWo3b1JDVTNzbUlC?=
 =?utf-8?B?VVREZzIrR04zZncwOXhha0V1aHNBYTRsaUJOYWNiblBJdVBZUkhQbFZGWTR6?=
 =?utf-8?B?S0FxcFFNR2hvb0VKRGxQUit6dStpc1VvRlFaVElHdGIvL0NTZUp4S0hHTFlS?=
 =?utf-8?B?SWZ1U20vYy8yTm82Q2NCLzFQdTd3RU1oOTNCbmp4Q2VZOE9LbG83V0lsa1Qz?=
 =?utf-8?B?VWQ2THUwSDR2OUJtazZVS0V4b2RTWDJkUWlPa3o3d1ZKTUhDUno5SzQveEZX?=
 =?utf-8?B?akNHbjRJTGQyYXk2SW9tc0FlRU4wcmwzTXlYZmxLdlllS1NjdGk1a1VUU2Mz?=
 =?utf-8?B?b2lHT09xVHZVZk9XZmJWWjJYUjlBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03e93ac-04dc-471b-4afa-08da87f663e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 06:35:53.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDRavqriscl+Jug1mJZIA3hucd/rKur4jSoTVDD9BxP/ox8ZeLbaJEnbeBcyeMndA4l2ax/2cwyNyaguTXwTAeJEtS6OEWmbeHHD+oV7FnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3870

On 26.08.22 18:26, Jan Kiszka wrote:
> On 22.08.22 03:18, Hongzhan Chen wrote:
>> ported basic network functions not including TSN.
>>
>> 1. passed three network related smokey test: UDP, raw, dgram, But
>>    I do not know if these three test is enough to validate the
>>    driver, please let me know if there is other tests need to
>>    cover.

These tests are using the loopback device if no device is configured
manually. You did that? You run the server part on one machine while the
client was running on a different machine with proper cabling in between?

I just want to make sure that you were really using the HW and not a
loopback (or any kind of local) "optimization".

> 
> If those tests exchanged more than a hand-full of packets (to make sure
> we are not leaking buffers, thus will run out of resources after a
> while) and if you checked that the reported latency is comparable to
> rt_igb e.g., then we have a good indication that the driver works. The
> rest is field-testing.
> 
>> 2. In addtion, another thing I want to discuss here is TSN functions of
>>    i225 has the very similiar effect with TDMA not only from clock sync,
>>    master and slave arch, timing mangement but the difference for TSN is
>>    that most of fucntions is implemented by hardware. We are considering
>>    if it is feasible to implement TSN-enabled TDMA-TSN driver to make
>>    use of i225 hardware feature because TDMA itself is really heavy.
> 
> Yeah, time-triggered send is basically what RTmac/TDMA introduced via
> software almost two decades ago. I'm not sure, though, if we should map
> the configuration of TSN capabilities of modern hardware on interfaces
> (RTmac & Co.) that were designed that long ago. If it happens to work
> our easily, it's a nice experiment, but we would likely miss other
> things (Qbv transmission windows e.g.). And there is also the question
> how to set up an operate PTP aside RTnet.
> 
> Jan
> 


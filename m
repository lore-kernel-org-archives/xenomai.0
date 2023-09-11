Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1820EB
	for <xenomai@lists.linux.dev>; Mon, 11 Sep 2023 05:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZxnFDizTvOmVGvn5DO3D/X863hMkuB7clmZxUWi8x8rqbYpKDeXaDZrd/FVIAbtE93sOdp6yeed64ruiWerV77SHE1yUMc6FL2fJU4NUPNhQ0Girs9PflnCl4cpa4m862k7VVwwfFOZ2G8a5/4NqMIFOMcHDt2L09qr/fMpn7hGM/6+fwm0nhNSXbOSYnjjq/Fbfr95HueEpuhu5uBXTIXAsCzQ5gZ0HB/xC9XgjBkxPa4W4Oglr1DYXkfmNPoFQ1fyD8I4l2ieTJ01GNgXSx7Ki56Vn0XiRtMK5mqWJv208m49tS58upUOrKFGPfj0TwHyXlqtJ5dEtXZ3v2aB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUqjTWQiiSmQjQqoYBC7DP9LVcPsmsFgrPaixGaWbpE=;
 b=HlK6PTRDgwI1A73NT6bRJbaYipvMpZrwwHoDQE8PFqNOBNKJC+Gzc191Secu78Ai8HPOFS6QBSvNeWN1t+iuicPrDjyqmO/VmEhVzDl4tHARcW9lPTKYqEMur5Ll0GG47k2vLIUJ4jcZF1CZXbXwpe1ckd9pYtYBxUogZaA+Hny4irr9T9KndNWX05FoX6JoO3q8CWWQ2+ZOF4W8qpFkpqkGRXwHg5bfS/QuUrIXNLrHSudU62wVyEgXo1qUVCWfrSQU4AEhV/HbnY/OvAaaKedNRmIfAxFi8Cmix+5pX+I2o5JYGs60iopryuL3OblKsjPATi6qF6/GqnL1UZTDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUqjTWQiiSmQjQqoYBC7DP9LVcPsmsFgrPaixGaWbpE=;
 b=RWulHzyoCJLZWPg5qrfvsbwVRj+5IJR3Lgqy0hA8W6+dXI4gwnY05NmS2v39oXMu6WsEEOo5gz7hgLKjf80yV5+2DltJOEdYqH4gJ2fXOCYi7A/8QFnTAv5vnEbYHLaN6dlkusg39kGvRk9zM+NrO4xdBtc+RDQ6+0QQSnSEq2QDoprXerXa35FiQ4lI+1hkSbiCzSbYgSppLxH2gnEjTofiiHZot/yPYDHngNieODROxuzn9VVsRuJ417jY/xTpn7v272//gAEF23anQVE0ZDTOmCSfre5oO8QQMayIJUc6UCXZgj/caZ/9zmNCAzyNX3HrMFg5s5RZpzl0Cwun0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:335::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 05:42:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 05:42:42 +0000
Message-ID: <d36c200a-b8c3-4deb-9e9c-16a9f7926b51@siemens.com>
Date: Mon, 11 Sep 2023 11:12:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] x86: dovetail: add dovetail signal setup function
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
References: <a59cde89-8bf6-4f94-814d-20c3456cab05@siemens.com>
 <87y1hevshd.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87y1hevshd.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:33::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f5c293-5dde-4c9e-d8cb-08dbb289ead1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 o4rHl6FsVvHTQ+PUaIcnfPJXSvzSVWD5mNgGZWD8BMqb+7Myh3QArDhEn93QV6z4/jDgbU5c7G1brtXMQYETS3GwguqkdRANl0iUhPMAX6W5qQbaI3TnJbleA7RZcXLOHHSRtDcs+HWdxuJ9CPtvJB7IALu9homLC7Vsqmcf7GpYIMDNvSjWQvrOSVtYso29Az29N+wBdCqzryMWSGc55WBcZtTwhJTjyrsckxjs+fN2sDgRdNtJg4cJPmoCyruODzTJG1thKcW740y7Drw4+8L6loiw+BkbGRSxLrTaJEIH0hY51OlHnRQtPGROXMYxd6XQlFGwY1KUrpabgfGf4ia+GvH1BzTku5Lgw2hgarHKPpjvUMQVVeNa5CFsMqf+ZWyOq7TE+ptC6bC48CnJ1DWS76w4lvXPxmPR6/G50zBU3lpZBL3kx+MZOO4g6tbOqkf/MVueEA1gKx5QVBfdGy2K4IXhBx10/OmRzqnQFWTttYZee+InD3Obx67LZ/PPcT84XET2s9kwpzSFHLhplFCUnYif7t7BljEgFh3gS4NDZZ2+4ii4/Z0+m8m2a3AXXDj/MkFAi6hMs0C997G0Ui/curd37XGSfMJNl7Ui/vo4bsSLpB1I43U9WuKrW2yd4TXfpZQlUFleXqKFnXrPag==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(186009)(451199024)(1800799009)(41300700001)(316002)(6916009)(26005)(31686004)(44832011)(8676002)(2906002)(8936002)(66556008)(66946007)(66476007)(4326008)(54906003)(5660300002)(478600001)(6666004)(66899024)(53546011)(6486002)(6506007)(6512007)(36756003)(2616005)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cUlIWWZPS2tJZ0N6VzRBU2UrK09jak1HMFlJNXdsbHNFa3hDdjFZYm9rWWp2?=
 =?utf-8?B?dTlyYk1DNFJEYUY2MEorOCtsOUZVOVJCVVY0TU5yUUpLeGFBN0ptT1VHdmJX?=
 =?utf-8?B?TWJ1Z1hyZUZKM2xBcFZjR0QvaVNPRGdUYi84V3hpN2wvM3czVmkycVl3Smtr?=
 =?utf-8?B?SGRJSlNYOElVaCtFZlJ3SEJseElzTkhyL1lKcjlnZnU1bjlwRk10c2w1TFo5?=
 =?utf-8?B?ckxPZGxYZGpSMUxpODdFRW1pYjBwZXZJaFl1ZWRXRTgwL2lFd2JqWDIvcis0?=
 =?utf-8?B?QStxMlFQdGQrNW0rd3JwZGRmV0I2MmR0UjdCeXVPV3Q5eFVLa3hOOWRDcU5O?=
 =?utf-8?B?dlVHLzhYZGhiUXFLaWI2Tyt3TGZDeXllVnhLdXM5MzZGcmVkRytzLy9GUC81?=
 =?utf-8?B?L0tQcWswTi9ML2NrSFRnUU1Ed3NhTEZpTExPQjR2NGx3dmlrOHhBeTdmVlhO?=
 =?utf-8?B?eFkwRU1kNUwyUTRRUVVFWEZ4M2orRVRMMkFuN1cxSGRWMHdHWmhKMXJ1bi9o?=
 =?utf-8?B?ZjRlTEFpNjJWQmgyZ1FNTVR0K0Q3S0g1NllmUnRNdU9PNzV5cUZibyszQzdm?=
 =?utf-8?B?VldjSHM0NGRHVUM3cEVKSjV0eXdQZVkva3NhMmg5V0pVeVhwVE95b1IvVnky?=
 =?utf-8?B?Uyt4SXdGbTlJWHJEM0Z2eldWUWVUVi94TEp3dkp2UVhkazBPaGtuWGVzeDlW?=
 =?utf-8?B?L3Q4Sy9CcjZSYysydE5ZLzZkckNEMWNRWDAwUnBXSHRJcHJXSS96RHprQUVk?=
 =?utf-8?B?TWgwRDRyQ0xaSnQyUFJBOWhRTisxYytTVmFldXBRRldYd0t2ZFBoQlo0MDFZ?=
 =?utf-8?B?Rk52MjliZjE3UHc0RDFkR2FweE9BZTliZXIwZFBIMkQzcTIwQ1NCSU9nZDky?=
 =?utf-8?B?MUVpT1h1Uk5vck9yL2RPakFFeXVIbVc4WjJ5d2JJak1WejRxWlUwdHlBOUxi?=
 =?utf-8?B?WUxYaWF2SWV3ZWhyZytVNEowWTFoQTVNWEhwM3dnbm5iYy9LQVJHS1RDVzNk?=
 =?utf-8?B?NjFGNmJpTDJUSDR6T0lrbG9ZYVExajhrNTJPdlVMWUtyOHRyS2w5UFNaZXAx?=
 =?utf-8?B?TDVIRWYvYTBvbnNia2dTOHd4djRCd0w2TDZHY2dsaTFwU1F1Q2tyZ3dtYktH?=
 =?utf-8?B?cW5mT05MdkVmTkVzSEV6K1FJMCtnRGhHb0ZuNFZHajNRSkNSWnZNSEhleE9V?=
 =?utf-8?B?OWI3YUxmcDBnSjNjOW5SaVlVWVNTMU9Uam5TT1c0cWpDSmtFM2FseTB3UzdW?=
 =?utf-8?B?SXI5ZlhqL0FKcjhmc1FwdlNWd1lUUXlVTkRBLzUwWDJjRlV4YWErZUZJN1Y0?=
 =?utf-8?B?a2I5R1hFYWN0aHlQNUorcHplSU5XOHR2Zm1aU0ZTVmF5WUgzMStkUjJNQWJB?=
 =?utf-8?B?aWFNTHVFakNTTm9rY0U3ZmdCRmNOREFpME9vZlJCWXU3ckd2eVRvRHEyb2FE?=
 =?utf-8?B?MDFwQ1ZoZTZMMlcwZmM3R2ROMVRmTmJxK0JFcVlzZEFPdTgyOTZHYzdmVmwx?=
 =?utf-8?B?bG5nb2JsdzB4YmlwTHE5VFk3bGkrVlRWSzhFc2w2Sk5hZzRXQjg0bW9aZ3hI?=
 =?utf-8?B?eXIwU0JaUUY0eGxlSTFoaUJxZ1RvRVdhaUw5NElVcE81eHJSZEwvSmpCU1Y4?=
 =?utf-8?B?NElzU2h5dGFNYzB3MmdzN3Nib1BIM2xBS1RhUmM3OVRNa3d6YzB3Qnc1QVhi?=
 =?utf-8?B?SUhaaWNPYmg2VG5DMkNJbHNqT3VyZUt4MlQ3dlhOODZwakZMNEVOUGQ0ZUVq?=
 =?utf-8?B?MjFqeXlOczA2MDZsdFRIK0drck83N0dpTWVIWHQwOExCcFAzWGVMZ3dBZEZT?=
 =?utf-8?B?MW5FYm51MFpuTW41MFBBY0Ria2ZhMHlxbG45dkRGc1FGNXNiOSswZE55TVM4?=
 =?utf-8?B?WURnR3pkbzY5akxFUXF6TTVDV1B5MHNhajhoUHpySFFaRGJETkRDZDAzQklD?=
 =?utf-8?B?VW5HZmtzSnczS21ac01vVWRDYTdnUUk1LzlsdVhlcEY0UzEvcWtsS3JJaXZX?=
 =?utf-8?B?ZUNxMkdCU3NjZkNsUjZxZlF4V3BLVFpDaDN2WEljMHJ4UGsxbHZaS3Fibk5v?=
 =?utf-8?B?NmZpMzdaTTRDeVhVdjRMaFNLUVUwZ2IxVmc0LytIUjlKNzNJVXRNM1Brakpr?=
 =?utf-8?B?S2pIeUcwK0thNUZNRTZyNUVETXZqNU1RRTQyZFZJWHNSMkVWMzdseitSVWhP?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f5c293-5dde-4c9e-d8cb-08dbb289ead1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 05:42:42.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DmXmbfDx8I8hvQDNWdDp4GEFD3L4Wr0117f0HIyuV9TD3+VKGcM0oTLudLAiP1Rj7ZUSl1kxvjAc2MwEC0UzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5426

On 10.09.23 22:32, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>
>> add an interface to dovetail for signal frame setup and restoring.
>>
>> This is useful for implementing rt signals within Xenomai.
>>
>> The interface makes it possible to use the setup use functions provided
>> by Linux.
>>
>> This is just a proof of concept using a very naive approach using most
>> of the code provided by Linux to setup signals.
>> The patch should be discussed, especially considering if using the
>> Linux functions is viable in a rt context.
>>
>> Also to discuss would be the interface itself,
>> for convenience I used the kernels struct ksignal for testing. But maybe
>> we should maintain our own struct, that is not that feature rich.
>>
>> <missing signed-off by Johannes>
>> [Jan: moved everything into x86, fixed might_sleep issues, return code massaging]
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Philippe, this is not yet final, but the question is already if we are 
>> at the right abstraction level with this - and if the EVL core would 
>> consider implementing RT fault signals on top of that as well.
>>
> 
> Regarding EVL, I'm not opposed to implementing oob-delivered signals
> (anymore) for the purpose of dealing with the critical error recovery
> path Johannes and yourself mentioned during the early discussion about
> this, which sounds right.

That's great to hear!

> 
> However, the whole idea of duplicating the frame setup logic does not
> look right to me, at the very least this goes the opposite way to what
> I've been trying to achieve with the Dovetail rewrite: a saner
> integration of the oob services into the regular kernel in order to keep
> the maintenance task tractable - which worked fairly well so far. To me,
> the ultimate scarecrow would the stratospheric mess we reached,
> afterburner fully engaged, with thread switching [1] until xenomai3
> moved to Dovetail.
> 
> More investigation is required to find out whether making the
> setup_rt_frame() and friends oob-capable is possible though, at least
> for the code paths we are interested in. I believe that we have enough
> infrastructure in place to detect invalid use of vanilla code from the
> oob stage, in case upstream changes the signal related code we'd want to
> reuse. Duplicating that code instead would cause those changes to go
> unnoticed: I'd rather fix an obvious merge conflict in Dovetail compared
> to a tricky mismatch arising between a Xenomai-specific frame builder
> and parts of the common code (e.g. signal-aware stack unwinding in
> *libc?).
> 
> So far, it seems to me that we _might_ be able to reuse the common setup
> frames, provided alternate stack support is disabled for oob-delivered
> signals. This still needs some work and a proof of concept to make sure
> though.

Looking at this, it rather seems to be a minor issue, at least for x86,
not fundamentally changing the interfaces between dovetail or the kernel
and the co-scheduler.

One thing that setup_rt_frame does and dovetail_setup_rt_signal_frame
does not yet is related to rseq processing. But that is something where
I'm unsure if we need it or could even handle in OOB.

At the same time, we will need those pagefault_disable wrappings in OOB,
something that the regular code path does not apply.

BTW, did you have a look at the sigreturn path as well? Any concerns
there as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


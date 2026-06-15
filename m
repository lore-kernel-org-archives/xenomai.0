Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B31990C7
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519949; cv=fail; b=c98WyHb8vhZBKlF38WOCORROGp6JbZisXz2f0b78AV0jt18mudlI3kLMACXwHGC4/sD8nd42helNfycYjMrSwr9USz466LCm+a2tELauLEuOICIGonDoEDrItsrldQ9fHT0LRsa74i2iNRSYTjK3homdAvf5ZzWpFi6Gviys0PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519949; c=relaxed/simple;
	bh=GzWbPLAp1cyqc20Q66W6SQIzEcpl9B2vOeL6qpCMxRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMo/Umql4TGxdZuMDcgjrGgqtyCYVvMxQ2MKDNl4aoV5t/zs6Z7iZZuRvscEWKS/536HbLkegpfIjtGBZECl1RJyV5BUll3c2WGhQ1ewWWs+hv+9FJt8hIdGNkGriL7tqyCcaDSSpMHOb+YK/wmdLrcGNdAZq2Gh+oeJVovt1GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GksYtm3r; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GksYtm3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPydqPZtJ3lwLhdrxqBGrU2wr2RHGGWbXpbrWQYalztdzs/ek23AOIqduB5sAA5+69EblzQAcdsWHBe+jpPA0tdBB4zR62jqsmv6v7jXni5zuvTfjSeqxkpqie06N3jPpAU38yg9S3hBJOJ90Z2btbW6xWcepcItILD41MNu84pA1Zfc9waHI34xBgnAIvIkITQRS5g4Dc7l+NtgcqijHGJw6qqmLTl+nqd7RpMHXQgZku9B5LWr+UJ3Q7feYULuUlCtyQJVeTNCl3OJyHTjljUjyHXtSTYC/k7z8As7KPQDdI/LLoosvpIR2LoCiqwwhkI0S/8/7sX9LRYaE8PZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6jS/IriarN6+faHQ09hWdJ/w2kV5umwdWAWGCThToQ=;
 b=oRtc3cKqO8UVGaYU0QXq0IKwZS9DG2duDi/aSFuzVBMYAQa0ZNM7fWoK1pRivnyRTilVKTYU0A6DFnr8n9z5pXWvt9buw8+Wk/Q5CCATDaoArZAIVonuT+3c3Q0LyHvuc1ZawIc7piXUU6AwnUvRfVleSpejw9/6IBTnZIsDBm5OAbGB3ohyMECn0aOTYYn7cu+NqAIxFh/K3Vcf8lUscWkvAHqmzsoyhoXyc0hQud5UiVC5OhaSCIQeWknNdaIdQbf0smVcVAELZiGUYtHLMz672ys/CoxKQRAAeSEl8WO6P27hNYz7gJicXi9OvjgrlXf+6w2oeG784SBncKh7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6jS/IriarN6+faHQ09hWdJ/w2kV5umwdWAWGCThToQ=;
 b=GksYtm3rh7U07sobMfjwz6th3ZrGeEItkflYotTfE+dhGTcF5NjmsMZwzz5v91uQbIgVY3FwGQlS4SmXocNLE3dN1QgK5NCBKlII9rlOv2tTEFS2zTpXldmGa4H9Pgx17IqO6KyYWwkhE6xGgRsir6M6ipjgzTG9FXerNxNphJa5xtT0ZW6HZ3U90uO8A1zkr9QWKMlfu7BIIazNzg7eOsKwNM/qanA5ug5MpSuGIxOKPzvu0864wMRarxacyA6buoMgx0SaBPy3tzc+iUA48CDsHH0J4/VTV2IyDyqFjSgH0dFGTe3uhjMdeJa1wyhrgjaxgp1bvdv3BESdhMe3Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV2PR10MB6456.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:39:04 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:39:04 +0000
Message-ID: <558d80c8-8787-4726-852a-5008440a28ce@siemens.com>
Date: Mon, 15 Jun 2026 12:39:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Xenomai 3 latency regression on arm64
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, =?UTF-8?B?8J+QsA==?=
 <384434518@qq.com>
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
 <87tsr4fe74.fsf@xenomai.org>
 <28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
 <87cxxsfan7.fsf@xenomai.org>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <87cxxsfan7.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV2PR10MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b3cfbb-0956-49dd-41db-08decaca5232
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|23010399003|55112099003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Pm6sZA8xSNq3or67Y20Hmbt0z6AS7v8xCsOk5/uSusmCosIenVmvDVovCD7OH0suwmKbWn3aqc720+olZTKBaNGyuwnIB2IR2R2xJv74ILdAvygaKLMp10Ad+nE1a0tYVS6klSh8FklPmisOV22jxaBygc6MAZtBoWZbuyHiMHXRPmGnRdIybDBWLWMH+58RK8ZPptihvS6rqaM5aFttu4THxFFnYFMG4DBF+k5Dp527E+ewhe4PngiO2ZlzB8Yvu1jbkcghnnQ1/ioPhmzrtjUkuOex3zyvD+B6zahV2OF4Vdst8kGKH0hLPfwe6bLbndYSRe9Gh7+rKVgRK0IqR1l2amYWuatnqJOD++9K0Njuj6Cd6eZ1LRN/ee0hGw9EMLVer1yIYZx0RhqXVMWhdGDJvjGVKJwihDBvZM8ADEfefl3QEz9OgWBBH81kALkgaClMqJOXiKUebjSfngj/AOVkuIdF7BlA2HbwQdgGSXAvS7LTgdzqXWQeQkfNvO5HFgC9GPaKbUryreHvFpEQ7ybp8ScRT/VaB4gD9SBDzBk4vXCck7mF4UrHZdAf82cAsfdJvfOxLmLEFeKsvn0XEYWj1iIufkfouVeYigKuV5OqvqlLwArN5Y+cZMbSeg99X4Z0R6wadzHsh56Flf8sJNCUwujcvfnM94MQUbaU5GeykiNGQ6VXRfExuBxU9fAW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(55112099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERrYlJKU1p6YVBJc2o0OGhMTktObUFpNE9xK3NWWDZrVXlYZHArSW90NkFG?=
 =?utf-8?B?TVNQVHNrSUtQclpUWXRhbEQyTk1BelhxTW4vWk1LK3NuTldwT1dzcmhxc3dF?=
 =?utf-8?B?M0RDTjNuREVNOWlPS2hMUkY0UXd4THdqbk5BUWlHWC91WnhSYjExTXZqN01D?=
 =?utf-8?B?K2pTUlEvNndaL2IrZzV2dnh2UWxGR0poR3BITkE5VnRXVnVUL0dWV3lxMzNX?=
 =?utf-8?B?c2R0NmpXYUJxSjZkemlPak9VQTVVWjU0enQzU0I3MXJVT1ZEdU5jeXBWYWJw?=
 =?utf-8?B?b3pHaTZ2b1JkNkI2MTlTZWFhR2NITGx2b21nSXV3N2hQKytyT1B1VTlLOW1o?=
 =?utf-8?B?bm5aQkxSVUtxbk9hTVo1YzRCQTBUNFRWc1krMExhZExQWHc1c1NTdTNmWlcy?=
 =?utf-8?B?WFIxOVAreDVQMzQ2MEhDUzM4UlBuQTA1SC8wZnNHYTN3NVBkTW1jQyttYnVV?=
 =?utf-8?B?ckhRNWZYdGdHbnpYdWJIaldKOUxqNVBoN1ZLZTZUd09ZK3ZFVWdrTTlONTNw?=
 =?utf-8?B?YTZoUXQzZXJDVXJ3eEFnNWNyR3JaNWdGUFJueWFVbXVXVDN0U2c2d3ozWVNP?=
 =?utf-8?B?eXN4ZjJvd1BUczVxQ3VOMTMvanplUW1mbHdrSXFyZTN3U0QraDUrZE9zTnI5?=
 =?utf-8?B?ZnBDb1p3cHJodnNLSDA2cXpiMXlCVmMvOVJaZGVBSlhqMUh0MWtRN0dBRy94?=
 =?utf-8?B?WDJFcXhYUnhKSjAxdmQ5SlZnYUUyTnZlQ3EvVElISjJiMENkSUMwY2gyT1dV?=
 =?utf-8?B?VE15K0ZyYjBDMGtLWFZEK1pJcjJtRU9NcE5GYmFNQVAvUHI1Y0dxSlBKTFZZ?=
 =?utf-8?B?TjlIVXc2amVnVHRlY1dTRFlCbkVoWDRUZXJZTnhSVVUzSGpMRTBmbFA1R2wr?=
 =?utf-8?B?L2xaOVZwdStIQlBhZGh3R0Exd2VUdERmK1FabkRCZmlJK0F3WjB1aEFabElt?=
 =?utf-8?B?ODhoZkFjVTNPeFEra2JFdzh0L3FuM2ZyTVZ0TWwxbWlYVkFseFhDbzhheGVH?=
 =?utf-8?B?eS80TEhHdTRtZy8yb2R4Uzl2b1RZYTg0YWw4RXJUeUI2SDBtVlNKZlRMeTlu?=
 =?utf-8?B?TWthdWIxdUJ5QmdOMmtvS0srTGkrTHhObTF4KzRKOWxtRUljR0pweWt6bWdw?=
 =?utf-8?B?clE5MG5GT3R5Y1V3ekdtME5EazhSdHRqMUVpdmF1dU9ZQzZnN2Q1NUVONW5H?=
 =?utf-8?B?SFpybkRDbENOcHpJajJzR0tlaWdlYzF2U3cxOTU0VCtrY2gxTG1VNVZ3clNP?=
 =?utf-8?B?VjhPcDZqMkd2TXFXUGIxVXFFMEZLSmtOS0VtOG9ZVmt4OHlHRFM0SWJJQ0la?=
 =?utf-8?B?ZWovTFZzNVM2RE1IelNsSU9seTRPUStaQmx2aXNhSjRjSGxuQmpMWGtJYkIr?=
 =?utf-8?B?RTM2dDd4d0FjcFdTQTEzN0IxazhObVNJd3U2cUwwN204SGYvTk5pTWI1R1d4?=
 =?utf-8?B?Mms4aGdKQUthajJPNnI4WWF4d1V0dFdTbzFMcm55aWFKQ2xhV3ducjYwSENl?=
 =?utf-8?B?Vi9UbGNlOGhGYUVsaGhqTlI0bE1hR3B0VHBsbXoya2gyYkRFZzNFcG9zd0d3?=
 =?utf-8?B?RFYrdi8xQyswNURKc2IvL05vY3o5dGpsa2s5aTJPbk1tRHRlTUlyb2hWNmpL?=
 =?utf-8?B?NEV1WkJHYUhSRy9iNUJNUlVDNmEvUWU5aFRKbjl0SlUvSEZmL1B0Ky9FQ09m?=
 =?utf-8?B?Myt2L3R6Y01qMVBjd2VsUGQwZVVoeXZwRGlzcUhSTkQ3QktzZDhVeTJPbVBj?=
 =?utf-8?B?WVZWMlc0NW5kNDF2NTNsTjZyMW52NjAxSkNHdUJibDBpSWl4Q2dpTkxHSVBh?=
 =?utf-8?B?Z3BMNnVqOHlaN3lwb2ZxcW1TQ3BTL3BsL0RueW8za1owUGJOVnVEc0t0YzFB?=
 =?utf-8?B?L1VlaE4zS0RJV1ZFTHZkY0pyZVZqbmc2aUxUbUFUTmNYcWl2Z3FLR2FyZU5O?=
 =?utf-8?B?Q0V5VDRrTlE3NnJCZ2EwVWpLd1pqa3E2RUJMcVB4THU4MTZHSnZldGZieUMr?=
 =?utf-8?B?VUJBWXdYeC9sVWtLTkVrakJQbzcwSFl2Q2pyQ3MrVWVBVWlIZlVWR1dWMHhX?=
 =?utf-8?B?SFV6MzkzOTY5OER5cXBzWmRjb1pyazBwZXZoRWtndWFKalc0VGZHU1k1Sjd3?=
 =?utf-8?B?NXJrNjEzRVNQT2hzTFBISjM2SXBIVHNFQkRUUkF0Q0oyeE8xU2d1SlBLNkNH?=
 =?utf-8?B?akZoaVViaU9SS0VocitQaFByd0RjaHpPRzdCQWhlc0VWYTRFV1ROVDVOM09G?=
 =?utf-8?B?Mk5LRDlaOXdqTGd2V09UWEtSanNsa3hhSWY2ZzhsRDR4cE9BZHZtMFYyMWFw?=
 =?utf-8?B?WDFIU1lwQm1XRjNtb2tMczBERU04SVhuc1NMcFdob2Jiak5ya3k1SzZJYWJz?=
 =?utf-8?Q?LkKy5MxHuUbz3txvuc0SyMVAKQl3VLJQdyXeftLBb8kxM?=
X-MS-Exchange-AntiSpam-MessageData-1: 0pSpr6bg+m0JPuSTOvX3wmaS95KqYT5OV4o=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b3cfbb-0956-49dd-41db-08decaca5232
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:39:04.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZy2jAwfkuUdjYoNY+L/jGQaJxyd0vIZFLU0uJRrtD5znuTyIccDBLbVuYynpP1QUsEqKIUQdKk6xg6rbXVfP5mGPnnZcMBkRRVIjHstmOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6456

On 6/15/26 10:52, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.06.26 09:35, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi all,
>>>>
>>>> it seems we got some >10% worst-case latency increase over the last
>>>> month with Xenomai head and 6.12 - that is at least the setup we use in
>>>> our long-running weekly test.
>>>>
>>>> Tonight, the RPi4 test triggered by exceeding the configured limit of
>>>> 150 µs [1]. About half a year ago, we were in 130 µs range with it [2].
>>>> x86 and beaglebone are apparently not seeing this change.
>>>>
>>>
>>> My rpi4 fried. Is the issue visible with x4 as well?
>>>
>>
>> We do not have long-running latency tests for x4 yet, do we, Tobias?
>>
> 
> Ok, I can try this on an odroid c4. Did anyone succeeded in booting a
> mainline kernel on pi5? Last time I checked, root-over-nfs was not
> possible yet.
> 

No technical input but adding 384434518@qq.com who also asked for this
SOC about a week ago.

Cite:
> For your reference, mainline Linux has added support for the BCM2712 
> SoC starting from version 6.12, and later versions such as 6.18, 
> 6.19, and 7.0 continue to support it.
> 
> Is the BCM2712 / Raspberry Pi 5 currently supported by Xenomai 3
> over the Cobalt core (including the required Dovetail interrupt
> pipeline support)? If not, is there any plan to add support in the
> near future?

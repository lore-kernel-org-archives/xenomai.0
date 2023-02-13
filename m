Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8781FA8
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 08:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPSf7c/zkWyW/HPxrs/6xhy/gTJUD6ilJaWoZWRnvmrpntl6s+UM/VbLlIwMSnfCr/npQhHnWTE09e34xdEa8TsVTMJrcMhGf/DZhfhG5KwHoRRxIKm17epsBqArN0RSDCjM0nlHolAVqB9VmjWk60g+bLGKP1F7+/4Ebywju3nuxXyzF0sGjms7ozLTa0n2v3iN3UCkDYfQDhWZgKCfNxucsv8qb0VWGMwVZdlGoXWvgmJiMfmED9qcNMVnjDr0G+pZl42QG/YypgIfHcGr+LsyoXmGnbfmCpV9u7nvdEh8TNz3iuJHjS3pn4HcAZI1btjVV0fO7mVeQZVgYhpXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzG9WZjykgWU8KkXcCwOJ+q8cHmrxjx4YChadpj/F8s=;
 b=mgAUOV1Cg2oqo4eVdhdppIwS8rF6irQyZ1gPlhrrGZAkGnWcZKQTo6gMLVwSvuo/azyPB/25w2lc21TtoSDw2yeCclh6p6hBhfmS3WOGLVLE3XjIHI6plTIHscKtZzXC+EJPsuTf2VnlKOoMQZW5H45AdI+pQ2MSC6eF67urP2yUwj+YVQMYfk5f4JKzC1pwx8I1Suk3HqFc+78gOji2hm6TZNkfCqtXyFRNlj5TfzIlEaFUSD/ChEi3jgVJF3WQIXtzKZTLFJfYi3ql4iVnxDeHgOnC6MIZoJVYTB3N6Ebj4SbITKx/Gy+dfhFasKQZubBsdEDpAXzHK8Kh+QIVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzG9WZjykgWU8KkXcCwOJ+q8cHmrxjx4YChadpj/F8s=;
 b=LFlPiqK4YQ23loA84srYvUS7FwIIt0Alo1oTQ/Wm6XQfcycYu4n4fp/oihfuGRmzgGTuRpzzYDhM1SyG9yC3+RWoBqRMXx59wufg5ckGpZMB/bDNJbgpi5GLJp+mn68yiRAvrodwSNKRYcuO1b7XiYj280QHsxbPExB1xFhbLJ3AlBzEzhbwYXW2nM5GcKUYicWhw8U+GFhc4lAB0BaS6i1R3U5V9SwjvstjHYqTGY1McMp8K5F7TVEmg0PMMgQXRGC3QBqYZyhQPa47q4UeivuHiG+5ZUMTcBz26BGa75bp6HcH5XU9WUbbkP+MDylLh+bhCrRj/cKP0U5ToJyJ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 08:17:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 08:17:04 +0000
Message-ID: <b02fe669-a425-53ed-e386-6d99af47b9c0@siemens.com>
Date: Mon, 13 Feb 2023 09:17:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [xenomai-images][PATCH 4/7] ci: Hook up kernel 6.1
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1676271676.git.jan.kiszka@siemens.com>
 <5573a966fecb301447eb73ea3350ff5f7b986bf0.1676271676.git.jan.kiszka@siemens.com>
 <a7be0590fd6d9d44ea52b0129fdf49870b696e84.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a7be0590fd6d9d44ea52b0129fdf49870b696e84.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 4674bc92-6bcb-487c-2c39-08db0d9ab0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vLoQ0/06JGZv9+1J4DOPBRPUMCm8NWv+E4vmAEXY35C9HL/mjrZS+TTRZnvYw+3285jz+dd9NRbEhVcNhX0iMPu9WF4k6KdblfrEfP2qR9+pzlYz27zY9yxnPX5HXXNNerki+K38r+0xItlAAKUSoLCFTHQTBqo6Vi9qDhhj1e4ug+f9jZxB/6Is6Eg5PV0cU2yNgf5Vi23J5krK5rcVViwXE5V11wPCaYFfmauHfrcA0wGCk17vUYKR8YSfUZ/PHEioNtmrOcY2V0f9jcrl1U/PQVlr9g1nth/PbSLunxSbsrbPWsHvAOvCzznrYlfqfkF1QyiwKMuyz187iJzb0Qpjv11ekxv+cGZKauK2UHvsbV+iWCZqoi6nssmVwEd0J7SBCRfLg1mIdGrkLTWxeHkofzAgDH1xOe8LBkf3X3ExdzwyFGAC1amepnako1rQRtDQCr3UO8rzxfXjjdKmevtEx5tQUPRMiMAnZ7TY7WaSN7D4ZWuWzs5lClKDvlweioaI/QUXAyRl+WO+B3nCxBXRGSoRy9ej6XOccmcIJQ+KoQ/7pbPrusXAreh0/fhl7ReMBfCf6bsvx24ybiWll77G74oIyhpdTAaglSspJGNUeUZYb25AJlTslklDDpzo55hhPY60HI3OjRT/l3R+wI5t/VM2easxEBEYeOveWWHvZZVpllLqw7j/yU+5fPwKaSC3xMmYR1Ftb/QtH6PAQUj0lpO4pOLACHJxkSILvlnAwD5xmmiXjeTyyP4+nHGjbGlPzGb/24uCwqrzOdqOi5ptolMBvCadnBeAHOyghXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199018)(31686004)(36756003)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(38100700002)(82960400001)(31696002)(86362001)(53546011)(6666004)(186003)(26005)(6512007)(6506007)(478600001)(2906002)(44832011)(5660300002)(4744005)(8936002)(2616005)(6486002)(52103002)(158003001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JmbWdnZHFKS2xvTWJwa2dEVWlzR2VZTDJzbWIvbVpmYmlydUg4cFQ0Kzlz?=
 =?utf-8?B?WGNUVEs2OTd5U1dPNml5eEVxMUNQSXlOVUpGNjZCWmFXMElXQ1VCb2RZWXdo?=
 =?utf-8?B?UnRmQWFPdjViTldJWFJmYlJJa1RPZWNERWZYbEtjR1VsbW9OMkQrLzZ4cFg3?=
 =?utf-8?B?NGVhQ1FQNTF0RjI0YzJkNVNyN2d3RXZUY3lYb0ZJb2FydHpFdEtZT2JmNTI2?=
 =?utf-8?B?dUdrM0xCWUUzT284UWVjeXpZTnBzNXk5SXl3enphTDgrUVFIOW1TdmdmdHZB?=
 =?utf-8?B?b0Q2aVNIZkpUdzBwN21wdElGREQ3aEx3K21BU0o3bmhCTFovd2pvQWxwNzBO?=
 =?utf-8?B?LytnTjh4QjBWeFlsb1pSK09HTm1GQzVPanFwZjJlVmFuRjlDOFgzWkFkb1F1?=
 =?utf-8?B?YU5xaGdiNklHRjRZY3BEVkRCWWkyaVhnaGtVd1E4UmZzWi9ZazdyMTV6NHMr?=
 =?utf-8?B?YWlOYXh3bi90d09ob0RFeEZ1ZDBqQWJPL1lrU256Umd1ckY4cmNDSnZqajNQ?=
 =?utf-8?B?Rmp4cGNtN25jcmpDK3BDK2p5R2JXYmx0bkprOW9ZVlhMZzhXLzMxTUQ4T3ZH?=
 =?utf-8?B?dmh2MUdFZytjMjRTRk9RLzhMWEFFWkUrVVNTWFBNVkNJZnlUbnh5TkNtTVZ5?=
 =?utf-8?B?TVBhTHJGVXRwbDJJL2FHd0VPZlVCUG13a0tORlNCZXZBVFY3Um5hRDAvWlk2?=
 =?utf-8?B?VWVONjdJQ2hUWDM2ZVRGcWRIV0l4Y2hWVjI2ZGNZbE1ReE9ObTNPb3pKTmRw?=
 =?utf-8?B?TVpkSlVjQTVMenQwZnpzQ3ZIUXg0UHp1QUN2UHo3K21TcWI3R1ZVOVBxNzZS?=
 =?utf-8?B?OWNxVmRLb3p2N1FtOVhtR09KQTRubEkwd1lvZUYzUnRYeWhxTWtHd25VM1c4?=
 =?utf-8?B?R0pKYkZzbXhwVkd2dlZLQmd0VEhIcGluZU1TOEN1alEvaktLWHloTVBndE9D?=
 =?utf-8?B?NUh4cURhMXZ4YVJQZmo4dEFxQXY5V2JsZEpsS2FRUmxRci9iQ0lZdDJ4K1pX?=
 =?utf-8?B?c2FZNlYybUUxcW82ckp5TFNwWFNXYU0yZmFqS21Cbkc3SzhZbUZQMnlSWnU5?=
 =?utf-8?B?Uk93dStQK2gyc3pyZG4xTDhPYUtXanIvRU9Vem5wUGlQLy9ZTDVEcDROSHMy?=
 =?utf-8?B?ajk1UVFHYWVPS3AxeDFVM3kvT0VuVkZpeEVFSE41eG9zQ2FId2prUFZDeUNL?=
 =?utf-8?B?N04yVWE0SDhGZVNodG9uTGF5NVZVWVBUVWJibFR4dENDR1J3MTM1b0RiK05p?=
 =?utf-8?B?K2h3SVM4VnY5b2EzMFJqdHM0UkpnVjhnQW1KRUd4VlhQR2J3UTRpQnlnVGxz?=
 =?utf-8?B?RktDU205RW9hbnRKanFJNXIyMjlOZmRwZGxGUlFKMERzdXY1Rm90NG9MOEZ6?=
 =?utf-8?B?ZjVmWTlrMWtYL1RhdktMU2JMazgvTE1JNkxuQVVyM08zUm5EN3ZRc1pjS0NP?=
 =?utf-8?B?aFpUZVVHSnBsUk8zYmNsZU9vcU8wR2RtL1F0aFNab0lESy9Bc05mZXJNSDRQ?=
 =?utf-8?B?ditreWtJUnhYaHRaQXZMSzFTdVdzWjhMZ2JaY2JlMlhpczdkMUkzQWNMOUll?=
 =?utf-8?B?WmNIY3hMZm1KOGp3aHgzOFpvTHdTOHYrM21RaytNNHNPVFJTd1Bad0FUM0ZU?=
 =?utf-8?B?NDNaQW9IcVk3SWl2SDBxbE1LS3d0a0tXZUtEdytucmNzLytDNDFlbldGNmpU?=
 =?utf-8?B?dk53Z1JVS3N1d05TQytwMDhYZlNveWYzTEpOWmoyR29ZWk1Yak5BNGl4eUgw?=
 =?utf-8?B?aGl4bXNQTVprZEtTWk10SlZ6ZUlnZW1zZUxLWDBYNXhwVkxkaUdTZTc1ZXZu?=
 =?utf-8?B?ZFFRa3RKcG0ybWp5Sy9YOEZTS09EeVVOaHd1R2JwZFdGV2JWTHFEcjFqa1lQ?=
 =?utf-8?B?Mi9QU1FZQi9Lbk14Q2E5bDZmd0pyMllYampLMERwR1BGcU4yR2VoUlI1ajMz?=
 =?utf-8?B?L3l4SFpxS1g5bDY0TjQ1Y0RucC85NEd2SGZjaHVCTkdHWnRlOVlVblg5Tllr?=
 =?utf-8?B?TjhVR3dIMWtBYm9JdHl4RG5acWZPVXhFaFNDQnorM3Z4bkI1V1JjQnFDQ0dX?=
 =?utf-8?B?K3BpcEZHZmYzbm9yMDlqK1ludWdHZXh6R2ZqT3J4bVU4ZG9jQkZnNXNxNTNn?=
 =?utf-8?B?U0liMkVmZXlXTGlUL3R1VHhCa3BveFBOYkRsanFwQmlhT2VCOHZwWjR1Ylps?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4674bc92-6bcb-487c-2c39-08db0d9ab0cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 08:17:04.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTKH8QQY7D1JFjgWlLgh20go8WDkV1zrkMpTNTgX2RiY32H6xi2shQqXXNAPRB88gG5h08x3iID05fZ16Gz91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7021

On 13.02.23 09:15, Florian Bezdeka wrote:
> Hi Jan,
> 
> On Mon, 2023-02-13 at 08:01 +0100, Jan Kiszka wrote:
>> +lava-test-6.1:qemu-armhf:
>> +  needs: [ "build-6.1:qemu-armhf" ]
>> +  extends: .lava-test:qemu-armhf
>> +  variables:
>> +    KERNEL_VERSION: "6.1"
>> +
>> +build-6.1:qemu-arm64:
>> +  extends: .build:qemu-arm64
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
>> +    KERNEL_VERSION: "6.16"
>                            ^
> I'm quite sure we have a typo here as this version does not exist
> yet...
> 

Argh, good catch.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


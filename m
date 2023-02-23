Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970262F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 17:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ4j7lzwdHyi3ovOeTBbmWb7mJW//VjdCcjEx1OFHn4FDBaC4DBfsDN7Kq4xzWMZgbfwKIgvsIJYddjtUgJrCfyxtFG0+zUceRjbTnVvt5vLXcZwxEWzaZ8kaInavPZe3LipIMsnbDiGpbMmxpI6c1u0/HGq1ZcaIIa6GZUu7OEIaPnJLoXewBzXhUvAWaHig6z/z4E84IKXWWxyi2RnuPCRVvWGsCPcRrmchsnI2OPX/VUuqiosjY0gOVn2LePNeyYXMNhA87KVSJfU1SxGcnOPU3VU27+wIZJFcIfK8rOJyZ0EP0cKr4/bgYLzMd6tDTy18KjJHvwwFSpPttBOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRF4o8JExjQOqwjw9yCToGf45nYuJGQShVPh9dS8TS0=;
 b=gkmrDGgdDmsUdwX+zu4mMd2Cnnums0HijQpl8FvHWKjnqcjIdlhEPj0mid5zeG7LU2B4udTBjhQzNILRzzt3/67Off7O8J4Qfea6A5loI6ZIDIslG+QZbNgSl8knxSdCZb6Ro3kEFiOmIkEPH5yWXeRdPfX6Gwb2YhZCYIeN54SYUoR2S1LetTEF2mo5a35kKAcP3v59VPx6JNS3tu6G7Bjm2w4wptsYM4FwTsK2cBr3NdpYXyCQzE8MBL+ac32tIzT7qWBB8Nk+dyI2yZIy3dmQqM5vWtW0dVsoHcebtS7zWqiNGLjI7qYpBmi9hp2B/nfHLEE5NOKsstYA84JnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRF4o8JExjQOqwjw9yCToGf45nYuJGQShVPh9dS8TS0=;
 b=HpAvw1Ut6Tu+viHkdfxglkBo1/IbmobCs+/cPc8+mXiNgt/fp5KsAgeK/BEKk8HwH+fh+6MnK6W8Jl+pP0x+TkwU/1jbIbdIpZPtmTd8DH2CQbBYc3501LDHtcQJp0na6QHH0JYAcurJUhkexspbs9TcxNx+l32kjf3S/V2+vRB3H6eLx7Xvhtnb9WeagkenVK8KkarS5fC8vBpx5Y8OP9qres6k5HigGhBr9GRaC7S57nhacB1u4Xp3qd7ZJ9/n2nyw9iZUaNBMKizOSm5/1uhh7jcSqbanmfprLswsdOO5Tb7p3bkIHye1mBpJmM7F1f6LcifFUtXDAiP+HfwtoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 17:54:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 17:54:50 +0000
Message-ID: <64692286-6986-4954-c297-550b154f5910@siemens.com>
Date: Thu, 23 Feb 2023 18:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [xenomai-images][PATCH 0/2] Fix pipeline failure detection
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3880:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e78c05-4e5a-4fd5-1740-08db15c70f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zw/pxb028G3007EeCFqKAkLzwYT4YT4zSrFpkw5+o1KnOrlfWrhB+fQkgcJXV6gkVH8Gr/DaM+kpSnWg8egnsz1+tmy9q2UovDeNpbWzFbDVEvRn45CScyhdXkET9UZ1XSjKXngvEB2ibUymnPvgicR9gYugQr6Y5dPcriaF3tc4xxkEfqKAE5w+bKy+/AXqiePcLu5fsSSrr4cKbXv0Ebkt4nqHTvuIbK9JBTkTntLmX+/EcNO72kZMqNZMdFF/GxNjwboCCOi0zKXiRAyOfv5xmoQBW8MLes7N5rVYBhbe3QlQDpsNO6fOVpzcC6qkqiwUogfrMrS0M6w46374V9hC3kYvBhAWhs+TNZblceYUC3/ofPqGx1CoCy9rOS9IyLHKQk0bh0LD7uNyt/boSriFLdcapKVvenCRvQtOAnfg//1OMXFOFPQQuU+8xoplierjB884fx4c5ntMrn2tdcmcV97BQIyUzyAzBmwgHwsfKT7vU7hNPK0dzWj+/dCGurhs8X/Mp6az/Yhd+SofFf2MoAp8oONDWLowVf0giwmM539wbLlIklBwvLxFSc/x+mbivdZieV/Rd70pMH97L9OxhBns0OK+d712mDRLzzOK9IHM8YRVoJtqBGGmbXbVWbqh9iM7NatByT/am4yOffnWS358jpLXOonchYY+V46Z+nqfH49tjxyW3epTd3qZnRbw6Vf0V/IqciFYZgs7G/+N4roN7fTiqR0FmzWk6FU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199018)(8676002)(66556008)(66476007)(31686004)(83380400001)(41300700001)(38100700002)(44832011)(82960400001)(2616005)(316002)(6486002)(66946007)(186003)(6512007)(26005)(53546011)(6506007)(31696002)(8936002)(36756003)(478600001)(5660300002)(86362001)(6666004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDViK0RMMmIxMUo0TzRGcUJOSkMrWW55WjhoTHFIZVVpcDRGSXlvWFpUUjhK?=
 =?utf-8?B?ZlR6emFZdFdMdXhiZlcxbXMzaHE4dUt4Sm1CKzc1bHZrWEFTMENHcFNyczNp?=
 =?utf-8?B?M09rWk44bXlBTWIzYmJvZmVjS0RZVzcwZ0RCbHNISmxuM2FXUXRhNlB0VUNJ?=
 =?utf-8?B?MFZsQzdzanViaWFWa1V2N3F5b2I5Z1I2UEpoUDNQRDY2ZFp4UjF0aDdraitH?=
 =?utf-8?B?SVJxZUxHMVB2RjdNVTNhTjZMQVgvZVR3ZXJSRVMrNzVVVkdPVC9rQklRdlZS?=
 =?utf-8?B?dTdSaEJtTzlWd2xGN0FINHlIeCt4ci9Fd2l0YTY5Z3JrS3hYdHF0Z2E4M1M0?=
 =?utf-8?B?clpBR0RDdU5WV2ZoN2E0QkpjejQ4SC8xSTQvOEtVaUEyV0g5amVnR1NtdzE5?=
 =?utf-8?B?T2J6ZEJCWHVrZ3VUN085NFNTaFBQWVdtQm9XR0xQZnVSVkloVERqalNLMWIx?=
 =?utf-8?B?dUp4RUtvMzRsNXY0SUQ0b21lUWFoais3RnNucHVpd2J0MjIyRUFycFArOTls?=
 =?utf-8?B?VkFkU0xyWWljdWFXLzZHZGJaSDh4NFUxZjNmczg3cnkrUGFvYWFyR0tsV2xE?=
 =?utf-8?B?U3JqRE44YkxQdlBBVk43b0FnQ201a0xDMjU0K2JqcVZDV2N5Rm1QRFFJeGlM?=
 =?utf-8?B?Z3lnL3B0czE4elQ4Uy9KWkhxSEZlMUdvdVdwY0FoUmg1MDFjZUVkS3hVWWhJ?=
 =?utf-8?B?eUk0TFA5V254T21DanAyQWlYdUE2Q0djVTBicEc0eUF1N0RLVktVUDRrdU5O?=
 =?utf-8?B?R0pqU0k3NHVPZUhJU3hXUitiZXBhOEZYakl4VERiZkpvc3cxc25hZDF5Vi90?=
 =?utf-8?B?SXBVRk5QWGtVWmdaYlNQSURNQnRkQUFmRjZxM1doa3ZhWnhmSU81NEduOW55?=
 =?utf-8?B?cVNqblFlUmgzV0Y3VkY2ZzhaTkMvT1FPR1MzWWtBS2dTOThzaTBLZ2tBb1do?=
 =?utf-8?B?TW0zMHQ3dVpqMER0aXlyR0l1d1RUcm4yQkhoWCtlSjY3aEE1SGNod1NuenZs?=
 =?utf-8?B?UWwwNnVRZnluMjI1NGpTalB5YXNubjYwR2dqK1NaQ2JCaWZaNm1kZFFQRG42?=
 =?utf-8?B?S3dWa0w0d2VUZlYwd3JCaVE5UUpQWGlDQjYrc2tQbGRkMDErS0l1Z1JwMmg5?=
 =?utf-8?B?ZUw5QXZpQkhVK0ZrUXkxekMvUXZtbHhyU09IQ3hEZEEwSDBEVG5XUjdicVgw?=
 =?utf-8?B?azVJbEZRQ2xJakRaWVlOcTEwaXhGSVQvVzRsL3RMeVl5RWtpU3RpK0IxekFa?=
 =?utf-8?B?VDhpc0k4S0NLWDR3WXRRNUhmQnlYR0phelBwUEhyOW1jQnFJQzhkL0xDb0ho?=
 =?utf-8?B?bjh6MWNsT3lVZWtRMVdSV0tDeGhMUVFZZkVTMTYrQkZYQThwOEh5M0RPVEhQ?=
 =?utf-8?B?VGltaXA1OUhhWjlDTU9jQno5Wnd2elJnUVhKUUx3WUlmOExIaDNIeUpjSVgv?=
 =?utf-8?B?ZUNZVnJZdTZsd1ZnWE5oenE4MHhCWWRWZE1QM2w4QXRmOEhHN3RZcXVEdlN3?=
 =?utf-8?B?WDVUWWNSOEdUazJpZEpxanVNT3Y4ZDJVSDczRzJJcnZCdUNNZFllR2o4TmdL?=
 =?utf-8?B?bnQrT1FwYnJXcWI3VllOZ3JvY3hHRWxBdWY0dG5kTzM2THk1WFk0UDlzU0FF?=
 =?utf-8?B?ZjZvVFlwTnhRL3N3Z1FxN0M1ejFVSXNnYmRxU3k4cThUbnBhTi9Md1YrL0NE?=
 =?utf-8?B?dElTR0s0V2NLcllibFNiL0FYMWhpQ2JJZUhIZ1NXWVJmSEtxSmNXbVdsMVhR?=
 =?utf-8?B?dDMrVi84dlJLMzNEVGJxbEM5TUZzdmNHUFlGUHBjUnU5elkzdXB3dDgwSXZ5?=
 =?utf-8?B?SVV1MEIxeXN6UEtlcDVEd2V6ZG1mKy9iQVpBenpNODBVUTE2YWpmSDV3Rm81?=
 =?utf-8?B?S0t0dmZUTis5amNPcmptZ2RoR2V2Q3dHUHVYWGs3aWRUazh5Ukx6RGlCZkxP?=
 =?utf-8?B?QUpPaWlvRkZUcmNVSm05TU9ReDAyblVybXlYUWk3MVI5T0pNbTZCMnEzcEg3?=
 =?utf-8?B?aUdhMFc4WmVFWC9LbDczbDd5QnV2YUtUZW40ek9jaHE0a2xyMWpqcG1udGN3?=
 =?utf-8?B?V1lQZHBHMHR3dzdFNDdBOGlqQjd2L0lDUzhJTnlCOTY3YlZJMG93azFaRG95?=
 =?utf-8?B?K0NaaXJwdlZ6UUo2SEV2djVTOTdJTUpJV01vTGo4L2tPSWI4LzN2TGE0ckM3?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e78c05-4e5a-4fd5-1740-08db15c70f45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:54:50.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xOrY3YCD4WtPbUonkMgdM9UewEx/iD+j4Ax7YakHbvr6sfuS11iGmeZc2ROEaeTkUw0LXZ9ulvhuy3s/iphqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3880

On 23.02.23 08:40, Florian Bezdeka wrote:
> Hi,
> 
> a failing xenomai (smokey) test was not properly reported by gitlab-ci.
> In addition some bitbake warnings were triggered by the option file used
> for CI builds.
> 
> It seems that LAVA decided to report test failures now as "failures"
> instead of "errors". I did some research but could not identify any
> recent LAVA change that triggers this. Might be the case that I
> overlooked something or the error detection has been broken for a long
> time now.
> 
> I have one more patch pending: Enable compat testing for the stable
> 3.2.x branch. Let me know if that is of general interest. It helped to
> detect and fix some compat issues for this branch.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (2):
>   ci: Fix handling of lava test failures
>   ci: Fix some bitbake warnings triggered by opt-ci.yml
> 
>  opt-ci.yml                |  4 ++--
>  scripts/run-lava-tests.sh | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFE24F29
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 17:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLWLOMojyW3R+8aDRtD4gFyLhVVddHkK9JTX7rocMFmZV+JoBFWXsebz671YbdsX8k2eUyn+2CzU4rDfky4oknghxJ4REDp8CKQSJaNoWpQtSlZEsRHGr50/3o6ESUrZqktSb7rFirlW0zYzQzZnE9vjOFMJN7neOeqa6XGo+npct15eUxzWjkhYhv2fRXTABvVKn1unpwIIpEPRL0MXPJDxH22x6nWjDJyVVhgI2oHlQVaseS3NRJSFp6ve8spzKeunubLy0Tb08vPOppkYFpL3I6DJhDboKkEKd5GmBhRAHorwWxztG4H91hFTbXBDbbcGqSWFDYMaAZlsjvucnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7nLvp3S36zbHG84TT0BM6WZXuBGnBHBythd+nQV/vw=;
 b=ADLz4qg3dbvywh79lUZL16/BITMPdXE+VjiWGZBCmSvzpQhUDrvVoKpVlu9/LM+7WYqVrpU3SNCmwOUkaAUpZoAeBOBB+BBNk7F/EXqEjzcI6ICa8SgDduxmIjyxwfb9fBP8sva4Q5Hw0kRRnlbBF+9P0se5SLTWD4Hkg8FKaYE4TeHZUc/XX5hL0ExWJ1zVODx/Q79dnDJVpSzx5qM9KXIsuuCkp/Dg8yoxk7LY0VFawE7cskSnqeY3x/P231OsXdDr4MTQsPfBJQNfFHpxn4o5YBUeDROdsAU8syLbW3bAtl21J/ppBaMc8iA2AyLqA4UicgSYKesX0vxtcC+MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7nLvp3S36zbHG84TT0BM6WZXuBGnBHBythd+nQV/vw=;
 b=RYVa9pXQOUQ7IJtR+l+6zp1LRWkr1+UgGI0wJUP+TEAn8mw2WbPHAdVGNucIFMbeYtmQtRYWYBhf8cmgd+edHf59MVGh/a0ek6+z+cSjOCbfGogZwYs6UI5jqxA19sqvREM2vAZZScZwv+PK37bTWdN7vdagCGybQP+O3HmTo5xKuEXbF4RFkuyOgfwevvKs/QMQTXxU+q7IgHgfH/QRDpIrEbU37icPscZjABIT4yUVaCm5zHHaIIECOKo5TJQhDTIlxZafk6BEH2t7aY6GvsFPwVyfeNvyVPnRguNUU6wQC6Oo3SPCmhCJiYzgUZm8IsR0JovN77SdejWDaZnk5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 17:19:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:19:23 +0000
Message-ID: <228f0522-eb76-2d76-e36e-e694c2c1a034@siemens.com>
Date: Tue, 15 Nov 2022 18:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread hardening
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
 <2934513f-c67b-35ee-e72c-dbebd23a432d@siemens.com>
 <FR2P281MB2654EB01BCBD13AD63A59326FC009@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <29fd6c4f-65cd-3961-99d0-aa1bbfc542d1@siemens.com>
 <FR2P281MB26546335664C41F97F3D8CC5FC049@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB26546335664C41F97F3D8CC5FC049@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: a0038262-8d4c-4f94-7ca9-08dac72d8a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gv1QhGSIb3ngvod7fC04pL7mntE15cOlHMYwx5XvK2y1fAJi8l8zj+UaNb0/9N5uM3wewmW3PbTr4maNNTVNF5PHsww2QwnKla7uB2jCNl+v9bjtigOoEtxwXac8q0vmC2QOHBGWXwUI1pKpxFGjeM/FcpEMhRIX2DNZBLQR2KbEIaN6uVuR1es3UsqPkIFmgx1Lae0MT9cH8lmOf2tULpOkPbFpKKi3WPlCJPtKlBeCbAwTd+rhFh8DNSeSSu4brToci1/v9wVQqPk7gVxe5R++m2MCvZ9nz1ydEl1Z/TuQx1CO7zCLVDzNnQ6SAFCv/3llzdeQCjzyQFFYEnobxko6WJSL5Um4yMq+Wa5qjg3KzViBC8TP6jYjdP8I1x+lyuCPVoypdy8iuK5mOjFOw6zIG0eRom79IzqBTbCOykkdKbSCt7TbgLtUjlZor8EPqyH9Qfb2D5lmQlIoCX8K4VFuKAYRjumL8Ea3CrlKJcmxJj7MG3thBRiZiigaSgnur2UxnpOnRoIbFqFYkdOiM+5ljRCVPXLORqDdQFiba5SF/skCDlQY02d5q/5M6LewWkv0U9jslNZGtdw3NPfA2JSd900Hp2DLcNrm1OVsYk4npRJo381VMmYIQM51Im7E8jAPhM+tDqei+L2/Ro2CRnSxNxbRP4g1h50KU+JMBMJToHKZXUqFzbN1gvCRRchJVqhO1S9AbYEFtNFcCv0InFMYFOPNab/lhU+Rq0od50JOOt9hNdU3+uIS5suWd6dOqAN0QC48QS53rsFZMDjkYXD569HhmnLymrLmSiag7/+0IF5xpiNfH2giYLELnZst
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(38100700002)(83380400001)(86362001)(31696002)(82960400001)(4326008)(66946007)(66556008)(66476007)(5660300002)(8676002)(41300700001)(6916009)(316002)(2906002)(8936002)(44832011)(53546011)(186003)(2616005)(6486002)(966005)(54906003)(6512007)(26005)(6506007)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REVBNTNkVCs1b2liQXczL2xEbzFZYkptalNSRjdmbVJZRVI2QlQ5MklUWUtQ?=
 =?utf-8?B?RFc1OFpmUzhIY0JwcE5iQWJZdisyZWQ2MGpyT3FsTTgvRk9SWFVSeHM0bXhi?=
 =?utf-8?B?a1p2Y3g1aU5UbUhVNVQ3aEg5eTRidDRucVI0OG95OVJkQmQzMjJOUUQ1anZR?=
 =?utf-8?B?S1lTbGdjZlIxRmI5aWFhMVZVSG5ZNW9HV1VkU29QSysweWdpSW5kbjhvNURY?=
 =?utf-8?B?VFJmNmJ0MjFYTlVaUU13QzgwbVV5d0NtZTlkbGVVcjFBWTNSaHZsQmFlY0lZ?=
 =?utf-8?B?TnMzTTNMcnhWM3loKzIyeGNzMTFCbFBZTHk3S0U0L0M3QWZna0FRNjZPTVlX?=
 =?utf-8?B?OTI4blFEc2RoRlg1cy9VZlFQbG1DdmNUWGR6cjhETzMxcVpVekJzK2RLbGly?=
 =?utf-8?B?aTlCMDd3VHRBZnBmQjJLeUJaYkZFSnlCdUpmUFllUUtXZitmaHBGYnZicmp2?=
 =?utf-8?B?MXM0eGU1M3lQRDQzRzZZVU5IVWY2eWxRS0h4b0piejNTbUVKZUNnRjV6WFJj?=
 =?utf-8?B?TGlGZ0hERUg1NmcxeUp0VmhvWXl5WnVRaDhKZWRIeXhjVjFyVml3Q2xjYXVO?=
 =?utf-8?B?T3F2Y1BRc0FvRmIzazhibkFQL2NMRlBvUGhxMGRVUURuUjNvZTlpdXdHOWVR?=
 =?utf-8?B?ZzNDN2psV2JYbXJjWEVaeUV0UU9COXhYS0xOTVBFL1lReWZpUjExRHlxUnRM?=
 =?utf-8?B?bWd3OVVZOUFSZTdLSzZaRUp1UjRUdVVxYzJNRDR6cjVVaGdLNEFnWG5WVzcz?=
 =?utf-8?B?dmpiVHJQbHROMnFreUpnM1lRM09pSmgvYUNKbmI3clR1K2pKTWxuaElFeDVx?=
 =?utf-8?B?dE8yTllKcldxTXRCUG9DalZtT2srczBOSDNKZWlBbENBcEd2djQzamtxazBI?=
 =?utf-8?B?OUlsNEdpUmdUbUxraSs5eDBoZUdtMHBOZVJLOHFQSDZ6emVvajY1S1BpMUJN?=
 =?utf-8?B?cUVOSDFVdnJUeGhmYWF1RkRFUXZOd3FISDFEVlBlK2xmSWVKa2xwTHd0Ym93?=
 =?utf-8?B?SVg1LzVydndndmV5aGNwN1RrdmY2OUMydUh6K0YvYnV6dUpVZk8zaUMyMlNY?=
 =?utf-8?B?YU5TZ25ZYk5sYThmVG5hc3JyMTM3U01NNXNYUndIcnZOY0orR0JwcytIVjJH?=
 =?utf-8?B?c0t2QkhIbGVIMlRmZTY0R2wvdThYbWo0cWhpM0V3eStRY05hQytmK2huVS9Y?=
 =?utf-8?B?Qm5LcnBiaHh2NWpXbjlnUFUydnhjTU5zOTRLWTltcXI2czl5Smw3MTFKU1cr?=
 =?utf-8?B?T0lyU3JOdGNOZUhMRmJ0WHdHcTF0V0h1UVdZN3pDTjBudFE3YWt4T3FNdklP?=
 =?utf-8?B?ckQ2L1cxOUdyNGZJY3RzTzJsT1lJMUtRcFhUVElyTDhMYUU2SjZKU2RNUEg4?=
 =?utf-8?B?ZnFZSnBaWDUyd1pKTWM2N01KZ0QyMHNYSmZTVXZFUnpQSkNMTHBHays0RmNG?=
 =?utf-8?B?ZURzb1REWjZPd0xCWVE2QTlwMzNHTHF6cnliMGszSkxlbEx1R3VGRXVGQVRI?=
 =?utf-8?B?VStTSWtpNDcxSjMwK3NPdjZsMnI0NEM4dENBTkdWQmkwVFFmcEZSMmIxVURE?=
 =?utf-8?B?bysvaU1jemRxMGQ2ZXhJN3g2NjloWDRPWGFweWcrMjZHRGdjYmdZV2tmbGJt?=
 =?utf-8?B?Z1hTSG5mZWlnVE1QOE5RUTdzVUFPQWZram82N0E1MkxYOVM0UGNkRW9jWWpy?=
 =?utf-8?B?TjNneFM5OVJVOGFpVUpMeUg2R3VxbW9UODZ2T3E4UmlDWGtIY2M3U1YzZ0lX?=
 =?utf-8?B?Zkp1VGxNWVpDSTVaeVcrdUNMakdvamxGRm1oMUNTWEwyaGVSbjdSWVYwTjFq?=
 =?utf-8?B?cFNZM20xais5WDRFTTdkZHE3Z2phNXQzdTdTbHl6b1RSQndPMVFuNDlqakwz?=
 =?utf-8?B?cy9CM2RyUmpMK2lsSW0wbmR6U3NMbjNHV25QZW8weGZNN0tKd0RmaHFGOEh6?=
 =?utf-8?B?TFpDOE51TTJaUktrTnFCVVl1enZXNW9kQTJ3cHZ6L2hVNVYvZ1FqTDAyc0Ix?=
 =?utf-8?B?bFYyUzQwZHcwMno1VFc4b3ZVQUpRdlRWSmJIRFhwZmliQnhFbWNWdHNLbVBq?=
 =?utf-8?B?UTcwWnZyQi90SEdSM3FaM290enBucVM3UDRkTmZZb0VHWENYZ0MyemR2aEJ6?=
 =?utf-8?B?eHJBRmZlUSs3Sk5lK285YXNWOGtwK3cramVaZXRhRThPRkFJYW9MdGd1SFoy?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0038262-8d4c-4f94-7ca9-08dac72d8a29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:19:23.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe28THJN/jJfa4N3WEcgtxuUg8thc5LnJ/ZI6I3OeWRrML9VRAAg/hp6lv0+6VT03oqWWvtc/zgKWIfcUoEYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6925

On 15.11.22 16:07, Heber, Stefan wrote:
> Hello Jan,
> 
> I would like to thank you once again for the help and fix with our problem here.
>  
> Finally, I have two last questions.
> It would be great if you could give a short answer or assessment:
> 
> 1) Why has this bug been discovered just now, or why has no one else in the world had this problem so far?
> Is it because there are only a few systems with kernel 5.4 in use together with Xenomai?
> Apparently the problem seems to occur only with 5.4.

I think this was a combination of the not too broadly used kernel
version and the fact that it "only" affected tasks after the transition
from NRT to RT. We still have some need for improving the test coverage
there, see https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/22.

> 
> 2) Are there any concrete technical advantages for us (from the user's perspective) if we would use Linux kernel 5.10 and Dovetail instead of 5.4 and ipipe?

- support for Xenomai versions past 3.2.x
- longer LTS support (5.10 is and upcoming 6.1 will likely be CIP
  kernels)
- better long-term test coverage (I-pipe will naturally move out of our
  main focus)
- possibly better mainline support for your hardware - you have to check

If latencies are different on your board, I can't predict. You can
likely do smoke tests with the Xenomai test suite upfront.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAE6AA5
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 16:57:09 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 5BF1D200004
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 16:57:06 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::61b])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3842A941A2F
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 16:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS/lOJa+cZBQiiWLuaDa96HAy2QY0Awj6StfV31f81Vtg62Kl6WtWR3rRN8I0L55QViVKF6nQL+lqyyK5dSVzPgEkst0Zw66QH0vV9AfM+ISmw+aFyaEjjwuWFr+oUgHofcE2JJy26ou0VXqk0nm28tlAiX9Shqqsr85/mRy8Hzi8Do4OhScfGxnjtAw0XZxEtxGDoUkLNsUWkDeZRCB7Be3RJaz410kXWtYgemAqzb7mQ/ZnAUpl3Q31lYq3bjKLPcJjK8+7GxE6r7HFVUDrHi5F/eTOJ8lV0DyNbeTFx9oTp0P3cB7ctxWrScSdYhO26c1tsBzEh9YmK2dVA76dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gpqMExGtxmKencyW4WRkeoysJZ1y1sXMFSSOSVa8Dw=;
 b=D0XAMui9hKjjdx+XVTEHot7mKLlmXKPUVmmUoM4Hqm06VRTqx7m7oRNDxoy8u3MPHolBNnB0JwIGYsxzgsw3UpFyvI30lYix2Ldk5v97nRN3Accqj9KNobCzG5s/JS0Ze+FeJtQsL8za+BMeToaOVmh60wYCB2Rz9Pg5GiMyKbxtuVoO/hAaaIECMLsc7Qj9ulERXHddK539tKpTbIpXDGn0xVMC+Bk5tkBLhtbfvj7Sbvvu4bnUScb+36luFyjpr/nt/YqjBv6Z3dr5yBKBts5RVINsMq8cWl6BI3897O8yjaG5mIUh8ioTky9PyUTkOSeSacmomXjHKyYBX0UXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gpqMExGtxmKencyW4WRkeoysJZ1y1sXMFSSOSVa8Dw=;
 b=vCej5FBzTnjGp9Ae1Sea69yvlNABRpoS0DlEGoO6jx24M+LqBqE4MG+Bqup4gDwQq+YJ3463Ieafljim/f/JgJ1LfkyamODE2m5IeQu/W39ijtRyjM90NWxOjx/x6JufgGY78kKBB7pJQU+MK508BhJ6sH2HVATqctx8gmMosc/J7bjKmokfcy5UuwkGFClyclNiOtr5V66qNCo9BFyWuo2riY3XizadBH2zt9iEmYbmiVLq5IGcRg4tjLd/OD5ng3V90qxKeQMaBMuFKirBWE6LkZYBH6vS5E+CM1K9W9i/VtIz5PZF6ul2CKEjx8LMtSwE4Igwt0Gy4REW4gTXxw==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:363::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 16:57:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 16:57:03 +0000
Message-ID: <d7f6cbe1-ab60-8a85-08bb-0555feacadd9@siemens.com>
Date: Tue, 4 Jul 2023 18:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Invalid Opcode
Content-Language: en-US
To: John Ho <johnho26@gmail.com>, xenomai@xenomai.org
References: <CAMjL99Lk-QT=vev=3QeeUAjHzfP7X-fCRwJM18OkvTR1V5SRYQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMjL99Lk-QT=vev=3QeeUAjHzfP7X-fCRwJM18OkvTR1V5SRYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:610:e7::35) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b14b8d-2f99-4ff8-d1a1-08db7cafb0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUeF7f6ZJWw/HwaI6kUTiswb9eKLRNIJGmXl+IN6p8mJdIW3ydMZ9PmOPE+cxgkqT9ZJDF6I9Q7WLUITQOzf3HjqLBf8rhUSUG8Nr/dW7piTWjyZOVqIis9Xm7fGCM5/8cXoLT591bj0WTf0CeGKiyfA1oDYMD2UhEaR7KsNx+MdItPlTMyFQT8b6R5UDIK4NMEIlEy4Ub/efzNhd/LkC9I0/M7XoHwrfxwmHvV8TMKMRoI+F7wahkGg0WduDxvjzzcBHSVOrUZrD3z5eJ4hgC53IqWkY4Wguc0zZ/OF0YVerrGz+heVbn0OTp5QvU+UqVsMy80S3Ny3217Z9iPtJ9v3PkiPbfNC+UG6y3qw8CLRXKpCGAFZQJyuGWtJi0Tong3aSW73hd16fRXdqv9LoaAqUxNWrqUXY1L66X1KClZrM1ukc4bsfOWxoHqnI+P4TFmuBkheU7AoeywTB7/IZts2OoLn9mEDU70Hci1Tqk8k2zMlsbB5Uo+KE9HqlIsUm/I5h5TlG8Nb1sxZNDum9EybUuseWBZuUsucupysK3YfppcC42bsed2eAnix2ZnglezjysB6CNxN7PqW2ElFOki9iPMrcZNUXJp20YxllFtIw1dQXhIqEECVOkDf4h7k3AvwD8jYRD4UoQ76+eVPpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(31696002)(41300700001)(4744005)(6486002)(53546011)(6666004)(82960400001)(38100700002)(2616005)(6506007)(186003)(26005)(6512007)(3480700007)(86362001)(478600001)(316002)(2906002)(36756003)(66476007)(66556008)(66946007)(8936002)(31686004)(8676002)(44832011)(7116003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0gxR2xXYWNOdEJueTcyQXFrdU91UTlybmw0TVB4dVdhVGxtVUpmRW0zTlNS?=
 =?utf-8?B?azNyMUl2bmd5L1lPZWN1bkJxaU1oUFRKbVAwdlhUMUgva3RyMG5NR09IWGZx?=
 =?utf-8?B?YTVVbDFtemJUUEU0V3RTVEhpM1FVR2FJQkY2cHJLMUtYdzZuYTZDM1dxc21l?=
 =?utf-8?B?QXBOQis3RnhIMDJFUzhEbGV3TElNRXlrU1cyOG51Qnl1YzRqVEg3QmRYZTFD?=
 =?utf-8?B?aGhtbElGemQzcy9URU9yT1FUNDI1Q1RWYjJYVnpPTkdNNEc0aDJjYVR4UHJE?=
 =?utf-8?B?WTBPbm1Fc2hxQzF6cVdVTGtrZ21GWWRnV2RwdW8xTm8rVzB1OFBQMjV1b1BL?=
 =?utf-8?B?Z3lDUVY1TTZ6N2NMVmhIdTJxTHAyaytSU3ROMFRLMmhHRktTM25aNXJXRnhi?=
 =?utf-8?B?S3ZuVWpzSnBnc0lJSkZ4dUdMcmt6OFdpTCswdzBCRmtXQW94ZGZkRkkxQU9N?=
 =?utf-8?B?eG13YVQ3SmlPNWxQbWYrRFhkVDdScHNPQ1k4ajRHRWhxVWlTMWs1cEp2VWVN?=
 =?utf-8?B?RG96UlBtcHdHQnkrdk9rYlgxcW1xNEdGMHIrWVBHaHdNUEVCR1FGcEVPRXBD?=
 =?utf-8?B?Uk1ITEx6SEs1TkZxbVpDcjBMYXJKdThPTzNSTjdlTWdQRi9BbVdTanhkQkFn?=
 =?utf-8?B?RWhZV0s0STJEMlEzcFU2b0l6R2E1Zys4cHlxbFUzWDUyNXVFN2g1bldVM09l?=
 =?utf-8?B?WnlEVDh3Q3RtN05rNnpQaVpNMFRSODk2VWxaYnBSS3YyelpRWXYzbUFqTG9l?=
 =?utf-8?B?RVZFTEo4TmlwcnZ0TktDK2JwRlYrWXNLT2FmRUszTXc1ZjB4anB0TDBnTGZF?=
 =?utf-8?B?VzdKbUx4WHdWdWx3dnB4Q0x6TUR5M0lZMlZ3T1lvT2pNTy9QUlIxQkhtenhj?=
 =?utf-8?B?VVppUzZCMmFueE1wSEw2MlA3M2RnV0hBNEIvR0Njc1lwcEJBbVl0ZzhZQUlw?=
 =?utf-8?B?NnpzQklXd0tiNnd3VnN1eTluUEVUdnl0cVBHcUxKL1ZRemZYTlM0aGszOE5j?=
 =?utf-8?B?NEgrN3Uvdk9QRHhDVC8xbmthSU9DL0xGOVJTVjRmWU4vVGtvMDVSU1V5WC91?=
 =?utf-8?B?UHIyMzN0MWxSaTQ2dE9ESjlFd0J1ZEJMbmc5RFhGTzU2SmgwR05Tb3RaVU9x?=
 =?utf-8?B?bnFSMmowZ2pOcytET1hrQ1hHTHlZVEFTSkl2Zk1uaWRycllucXlLZUhmQzZX?=
 =?utf-8?B?RUFiU0FTNXlTcWVDb3VXRW1lWEo2dUcyWVMrZk1wT0FnS2tpb2pyZEU1T2NS?=
 =?utf-8?B?R1RXb0hYVDMzMkpxT2l2WmxTd3hEOFFYNThraGFmcTgvdDJZNngrMU53cURF?=
 =?utf-8?B?dHp3dkYyd0s4NlIxZDE2RytUdlBYYzVkVndXSjN2ZS9IOGpxSjc2UFdCcy9j?=
 =?utf-8?B?YVJsOFpBZlptcVFDU01kMlhQaEc1SEtEdi9LTGpPSWtTWUFMbXhaRWlid1ZN?=
 =?utf-8?B?QjFyczg3REJXd0VMcWorWkZ2WVY1T1pEMDA4aDRyck5meWN4NDc1NXEvZ0ZD?=
 =?utf-8?B?ZHgrSCswQVVFVjhJNk45L2xVaDZBL1dqWGhyaGlKL3FxTy9RR2IrMG9wa25Z?=
 =?utf-8?B?Y3k5ZTB5Ym1YTmRTYmpUNy9nUE1WVUdpTGVNYXgxQjNYZ08zU2JYUnZaand3?=
 =?utf-8?B?WDhLV2twQnZacUZTektWcmJrN0pRNkt2MFZNVDFMb0ZlUEsxbmgrNmNGY0tF?=
 =?utf-8?B?b0d6enRIQ1dBVlU2TVpIeWJERnJWZzhuVFh5OXRVN3hqeVgwcSswaytFNk9K?=
 =?utf-8?B?eGt6WEpIOUx1d2xGSVJENDcxZ1FGb3UvVG8vcnNPNXhYMnoxR1pQaTU4VGpU?=
 =?utf-8?B?bkxXUGQyMk5GZG1MTVFNaXpFaE5wdW1Tb0didGliMktQNzJRenE1aVQvWXBM?=
 =?utf-8?B?UENYdEVXbW12QXFzR1pHQjAzVU4xRmV6N09VbStaKzdmOEtPekxWNkxLVU1P?=
 =?utf-8?B?S3pDa0s5Skw4dUh1U05OTFFCVFMzYnd1V2FFbDlFN3RPWWo3b0h5c2lmRmFz?=
 =?utf-8?B?UHVCOUxGeHVxOW95Q3p0Z1o0WVkyTkZlc1NvTzNWUy9QSjlmVmZYUlNVN29M?=
 =?utf-8?B?Nzc4QTFLQlJOaU44NFY3UmhjVWo1VnI5akVhVE5rS053U2p2SWxiN1FaSUdh?=
 =?utf-8?B?Zi8wdnh6VHlnMG04QkhZTWFjUkIySXJsbHhucllGN2NiM2RrWk4wNzNDSDJV?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b14b8d-2f99-4ff8-d1a1-08db7cafb0aa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 16:57:03.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4bj9b8djbsGgi/lJVJzcZ0O35vmhxNkVeXcgKCnP6UBwIB1ZcgvwadhQs/KWSYiFqUSfeYiucs5150Dgy87GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7771
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=vCej5FBz;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0d::61b as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 04.07.23 18:52, John Ho wrote:
> Hi all,
> I have encountered an invalid Opcode while running some of my stuff,
> and I have no idea where this is coming from, and I would like to ask
> for some help.
> 
> I have assumed that adding Nopti would help eliminate this invalid
> opcode, but it has not helped.
> 
> [  100.456173] kernel BUG at kernel/xenomai/synch.c:968!

This is

XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));

in xnsynch_requeue_sleeper. Something very strange happens here.

Can you extract a simple test case that triggers the issue and that you
can share?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


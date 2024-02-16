Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711712FB36
	for <xenomai@lists.linux.dev>; Fri, 16 Feb 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097117; cv=fail; b=Au4yoDQmfGun3ywIF7jXWVZfqxPgm3n8gBUuBsdyyrKQsqz66rnf/4b+WDTPnmQAuIabiiJouUM84MoyqW/ExFMtcEiOO2rvckL6s8+Kyc1Fqo/QoH7VoJyThkvP/0tqNp/ot1byHuR0vr49GsKNLthPUC+EdTK6Yvy40nyVC0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097117; c=relaxed/simple;
	bh=QerOEZqjt4GNR4eOaoE9PNsYnyqHqAmM0gfMMHkgGF4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qEjU+UNdGAxow4NA+MQcltTDuiwcaU3RfpW+inrGl18iy0V3jqq//MWzplUkyorqRhEdV67i144PTZk3MDbGkOA2fRCXBJXFSFOhzblEI6cUjSM4Ff1q1v1uKEMBJpUQW4e4B+eOwgwZOrdG/Mi3xpekx7UW18AldJQPeP5lBm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WUuGr0+a; arc=fail smtp.client-ip=40.107.6.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WUuGr0+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a68VJSj4n8N09gt4x6ysAgWhACgt25vx52tPmwjtJ1a+g/IbswMUX7ZIosbe5AVoXGLPp+BUzEnXCEPiepBoe/6KkN0kCCCy6sM6dhcD9ke2J3X7FcCCsgrs8o00CdwbXeep5orWQ6gyIX+NZYef7KbLMaIS7OgtI6brJQqA4WSmv1dNXzrnj6YsQN1pgkrC8s8fmcNTi9+L84bEHYadEGZ3rM4AqIHhHve3GOY4NcJafqd4R3TbyQkQZWQZUekhDzvciFYMw3MWm9uT8lfB0HPFOonr38mFMe35WjkbIMHuv0Lm/Uv379EK4t7g+QmcaBW9+U5FXzEx677mD7fUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwpE8WNr653bgMSAuUgsrGXIEQNthxaRzHumFZ3btrg=;
 b=BBKB3O7RqrjyBeNSBCkDBlPe34eUKWYd4vdOMDMaQhSB1gBjkpa+8/jpDppnAUULTWJVcBQJ8Jwrf4qtxPsXVd+IumT3L+rkWPsg8jsRB3LnicmQjs7rvmoR+VZkXFyOQ9FpUWQZMMM+xZi9r+wFJDWuvjXaEuVbg+Vxps0AhiRJvd5sdmEkm5IfW7+6hL7kpeddEuXjrpdOWtrgYO7CJ/BHenwHpp9ZHuZL6aXna8RhR2+2ak7FOcHqtCeTj0hJtzYeVYY/HMBRlnH5Vq3XNiSqTm4NjjFnXtB/9MGo7x48HhqDRUbaDpnRPKAhBF8a5YmLFsLJt1j71b4AuYGaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwpE8WNr653bgMSAuUgsrGXIEQNthxaRzHumFZ3btrg=;
 b=WUuGr0+au/r/5Eow1AOl7lybWqFF7ojq8EOHUilbDIZSHyBQQDgSY1wowv0wlqCu3YGVySwbZUbk8zLD3Q/57zARN0fFrBv7EGxHFTObq7PjroEFUDDkZ2tRAwH61PqJFRsU6EIAU/Pu7jD6qc5mp7JsWAET+YWR9+OQ48nPLjJH8NhZG3zrj+8rJVmTcvnPyxaSGKg3hMtdID4Qt3LREaRxrjKKpvrXWmXc0WIqsb88cEH1SZKdkYoga954BzOTasHQAHot9N9dQ1p6V0L3HjVA+lzuzgTY36r/ZwfutC+2pHxreJFIBQTdLhDVxD241eYSt7Itow70i3vSzBK3Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:512::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 15:25:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 15:25:10 +0000
Message-ID: <19c3f7d7-a1dc-4796-80ee-8d41b95c81fa@siemens.com>
Date: Fri, 16 Feb 2024 16:25:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai user space application static link
Content-Language: en-US
To: =?UTF-8?B?572XIOWcs+a1tw==?= <ericvic@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <SY6P282MB3909502DB24D7E09607571FCEB4D2@SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <SY6P282MB3909502DB24D7E09607571FCEB4D2@SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0d4620-6aa3-43d2-3a7a-08dc2f0376c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Lt8/h7ukbLrAF9UNOLFzpu6hIuSPFwFZkY8VkZtJOKjHWIlX9/x1CU05FOglIfPO++szQZ68QxEe7qDQp5xY362dX7arnsESUhd+EniWAO/s9n3jygOTY8oGj6hiYH55CfxPmytTxnfv0BBjSVbHBSefPiKZDVJeBWgUPIOdYYQkW6zVzEtmSgWnExy0KsF91etdnqlyFBwnLaAHeT4p6Iz5cfVUqtsrFII9tqX7yhjScX2E5BN54f0dxbIHMhvBY6EPG6hnhc7pckBQcULDCz2mNmWfCvK6Ep/2ty1BIb+fZfFjhSutDtzeNPsGZCu66BzdKcMNZzULiUvqSI4RVeZ18zH0L+yUYJ40qYcytClgCV+4Ns9dTsqFTzFaz311KVDR5t9dH3TYfFufqQEGb2Q/nAj0hEMY8VNylmJL+vfh6rr/u0NsWkSGtoYbapPpEUTmnHGhbJEsHN30RhD2IRcZs8QDFkJJjiaZ+W4bkbECS2N1XkOb6ZarjedLLo+VbK+xQjCjWuyi5TMAvIM1yEPc6K6yqmXPVqf1b4iOPHjVCfjm82KtdYBon3d0vxk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(44832011)(2906002)(8936002)(8676002)(5660300002)(86362001)(36756003)(53546011)(2616005)(26005)(38100700002)(82960400001)(66556008)(6506007)(316002)(31696002)(66476007)(110136005)(66946007)(6512007)(6486002)(478600001)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVUQ0oyQVdCMmlZN3lHWnpuckN5ZjIrdXFDWmtvMEhmYWd0L0E0SlFWR25m?=
 =?utf-8?B?TVNpUWRySllsa1A2TnFYaFAyemEzZ1IyYTFuRU9NU0NyUnJqYXFhVVQ0K3NH?=
 =?utf-8?B?bFFjanFqVG9PMHk5TUkwSmhDSzBOc3FCWFVRNmdnZFc4Wmx2NkNuL3ZIdkRs?=
 =?utf-8?B?eTl3OXU5MW5zN1NhYXVVZWtFekQwYVcrcGQ5WUpmc0tCc1dEcHdZcWxvd2Q5?=
 =?utf-8?B?R3dRazVuWFRBdXRJcFhyR1lMOUxEaEdxNkJvcVlOc1p3WTNLK2pxL2JhTm5n?=
 =?utf-8?B?bVozcW1mbi9WQUVsaE9XdTd2a2FJc0l6eHpLWE1wRHZiYkErS2lEZk9YTFpX?=
 =?utf-8?B?SE1md05MNHpEY2VFMVRodTg5TnM5YWppdHBiVzdLYlF3cmNkSFB3dlRENit3?=
 =?utf-8?B?NUREd1A1Skd0eC9xS1NMQXRDNVZxbC8vYkdOWmFhQldiaVEwMzRKNEE1Um1L?=
 =?utf-8?B?ZFhuSFdidnZnaDR0dnJqYTB4RmNFeVI2RGlyUmlwUGtRU01XOG1Jc05xY2g0?=
 =?utf-8?B?MGtGRXNTUlAxNkhUQzVLVms2OWc4SzgxeStvWitQaDBJZS85NWVwQXpSMnlV?=
 =?utf-8?B?aThjeFBoZHp4Q0V6c3ZtQXpHTTJqaVNYVlM3SXJJOWp6bC9Gbm0xdXFqRWJH?=
 =?utf-8?B?N1JjbURMRC9naktFNWx4L0txd2xQbnNVSzFGVlA0Ky9JUnJCdUs4WHpLTWZ0?=
 =?utf-8?B?cDcvb211bzVPUzAvQVdVdklQd2lkOXJ5OVd6Qm9BV1JuZzFTd3FIZzhab1ZH?=
 =?utf-8?B?SWo4NlVZVjBIQ0Q2YlNsS0FaSGtRUnFFUFFpT0N1UGhpUXhtcUZtNVRia2kz?=
 =?utf-8?B?ZzJaZDVpd3Y0dVd5Wi9BcEJrT2hvVDVEc2l5bFc2M0pSMC85RnEwbEVGNWdN?=
 =?utf-8?B?ZmFrc09xZTk2b0FTdjcrTk0zeGJFM0ZSbHFCYU9OZUJPQmVoYS9pVGhEWU9h?=
 =?utf-8?B?OGRWUXo2R2FWNHEyWTcxczlHWkE0TnhXSXZiT1lvanJVZUZCTDBONS9YZEpD?=
 =?utf-8?B?V1kwNnJRK0c5bE1EN0RCSmdPd3FsaVRCTzlWTTE5bkJ1MEJ2eDFmSzFUdGRH?=
 =?utf-8?B?Z0tkV3B6K0xma2VHSUoxaStHazhadlJvYS9raEF3UG5pODEwMXB0WHkrTmhZ?=
 =?utf-8?B?a29SWEFNSDQxUFYxTVI3NXR1aUFWT0hxQThJYnUxVmtrZ3FxTWF4Rk1sWjdU?=
 =?utf-8?B?UGsvbW9Mb1V4WjBqNnZFVklISFhOek5BemU1OXpGclYzdllBdjIrazlkUDNQ?=
 =?utf-8?B?NlV0Nk1aTEE0RjE0SzJmd252Ykpmd3JqRVRDeWVyVTlzNHBpZ3VDUUxsYXRQ?=
 =?utf-8?B?TzR6TjFXZWhzankxbUVYVnA5eEVVVUdEZG5wV0pnZVRGVTRZS1FQVnQwM3hq?=
 =?utf-8?B?MXpmQnV5cHFXQ2tkZlZhbVcwMEJQdFRrb0NPM1k5QU42aHoycVJ1Skp4ZUxD?=
 =?utf-8?B?ZzlnK1RRN0xFUThWUXRVN051QnNtbDNoeHAzMS9ZRUlNbFFWRDViS0M1WEdT?=
 =?utf-8?B?T2p3d1lLZEgrSkdMdnNrVlVoYWcvVEV1K3ZidzFxaVBVNWsySitqU2NUeFVr?=
 =?utf-8?B?U01tZzI5RlFOVWcreldUbmRVRjQrQ0V2WlowMGFZSGFKcmFoZGViZ2JUN0NX?=
 =?utf-8?B?ZXZscGRXK3g1enQrbll0cVNUQjVGNHBHR0JJOGJMeWU0bXV3amJjZzgzSnpl?=
 =?utf-8?B?U3phbUxaMmZudk45MFhEd0FXYlpXak5lOXdpYXhBRHR2dGhjbnZEVU54UkpB?=
 =?utf-8?B?dTVQS0Z2V21iR01TbzNKRkZTNVRhRTFIakpBSTJMWVNpNU9QN2FDTnFWY24r?=
 =?utf-8?B?dVMxcmdUZ1hwWGczaHN5c1g2WWI0YmM2Qkc2T2JKc3U3OWEzREFyRUloQW5w?=
 =?utf-8?B?OVBrQTJJSmNjMWNWbnJWVkF3RnpHbEhiM3AzTXBvTEtkU2VLUzBZWS9lblZq?=
 =?utf-8?B?eUpubnBLRkdNTGlJMXVqaHpDbURvcnZIN0hWYnZKRDZmZVYwc2YxUmR4MXZq?=
 =?utf-8?B?djNRSmNLVnhHek0ycEhDWGhiOWVoOTU3bTJ6S3o0WjlWQjRsSHNTREhpVjl5?=
 =?utf-8?B?dThYbGlsRDZ3MGliNVFqck5BS2szdUc5RyttUWRqVTlkS3RZTUszK0VVR2pj?=
 =?utf-8?B?WFZQTTlvcUdRUEMzdUZ5MmNJUlJ1WWdTb2lXV3ZqYmdQU2c5Z2ZUdThnZnR4?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0d4620-6aa3-43d2-3a7a-08dc2f0376c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:25:10.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiAZuEiOrAIqzcBhGVhftl7XMn5ZFAXNciVVTEPYG5Uspu+gjHrdXieBwWONPg949MIvlyBRbPbG1JUamwPoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5847

On 15.02.24 13:01, 罗 圳海 wrote:
> 
> Hello.
> I comlile a user space  application with gcc parameter -static 。the application can not run ，but with dynamic link  its ok。I do not no why。
> please help Why would this happen？Thanks
> the c file 
> #include <stdio.h>
> #include <signal.h>
> #include <unistd.h>
> 
> #include <alchemy/task.h>
> #include <alchemy/timer.h>
> #include <alchemy/sem.h>
> 
> #define ITER 10
> 
> static RT_TASK  t1;
> static RT_TASK  t2;
> 
> int global = 0;
> 
> void taskOne(void *arg)
> {
>     int i;
>     for (i=0; i < ITER; i++) {
>         printf("I am taskOne and global = %d................\n", ++global);
>     }
> }
> 
> void taskTwo(void *arg)
> {
>     int i;
>     for (i=0; i < ITER; i++) {
>         printf("I am taskTwo and global = %d----------------\n", --global);
>     }
> }
> 
> int main(int argc, char* argv[]) {
>     rt_task_create(&t1, "task1", 0, 1, 0);
>     rt_task_create(&t2, "task2", 0, 1, 0);
>     rt_task_start(&t1, &taskOne, 0);
>     rt_task_start(&t2, &taskTwo, 0);
>     return 0;
> } 
> 
> Makefile :
> XENO_CONFIG := /usr/xenomai/bin/xeno-config
> 
> CFLAGS := $(shell $(XENO_CONFIG)   --posix --alchemy --cflags)
> LDFLAGS := $(shell $(XENO_CONFIG)  --posix --alchemy --ldflags)
> 
> CC := gcc   
> EXECUTABLE := main
> 
> all: $(EXECUTABLE)
> 
> %: %.c
> $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS) -static 
> 
> clean: 
> rm -f $(EXECUTABLE)

Didn't find anything in our docs quickly (probably because static
linking is harmful ;-)), but you need to split linking into two steps to
avoid wrapping also the system library symbols. There is wrap-link.sh
which may help and is used also internally.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


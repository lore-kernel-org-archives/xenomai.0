Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C71137E
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 07:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBccV837gPG6CHrpu6Ec7lNeAtYMnZv8L+sinKOdb0QyRzs3LkrCbUG5uhncyTm65d024zmZnHauvMuV1wEOsI6zh6me3Ssim0IMfjiwBzOhjkhY/DEBR9Ba+/0nUyK2zjIsr98LkyQBeRc15kD/OjO4pRCxG8PBU/C9ErDAMhFYNEvvGD77SfIbvhXla0TFaxK0UMueMC26LDFZSH0G4q8KifSeHFEQ/wjFjqY7eVIAg/WFhEQUPnXrn+lPfX5K7uyc6okRH4cQSmpAab7nU3FCwluUI2e1WlK2bSOcgwr4Jhplnk3bN112NBSyOog0cxKXcEwIZIvzHPfLfM+lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0wxPnUt0l98l7lIKVmmLX4yYq5KqfTle20RE2mSl8c=;
 b=LnJw8knnFoxzfvVUpADpivUZQc1LaAT/CnwRBUWEkxu7suJkudSMfo0ssjUYipX7st7S3wWe7yHK4JBuhUAeaAelDZTnH6XRgUeBVLjfdpm2fOD+r3nCUZJpvyBv4VflvS2TGlGO32ziPFravZ8Q7zKxSNLEcEc608lg3Wt99GdXBLh8QTsQxZH5MLaBOkeMeNCQlKWWbgZT2bQikdtC3TQxKJVRr2+KZlPaMl2PpeTX6VqsI/Q5vyquMPX5d4dofd+511I68kEstJy2bz+M+1P3GVNBPzNq//KvEiAZGMn7bP1tNG22OthSlKXQ44EHdpBEDxgiz7x3B/8U1lpEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0wxPnUt0l98l7lIKVmmLX4yYq5KqfTle20RE2mSl8c=;
 b=lD/pzJqqau6/GN7DYW/phbAfglw5dVErmLvXMqRmkMekRXB3W1tOYt89wkBgcIHF4eAQUtG+VxWkistaoXKebv1rSJV1wD9hODWrrOj0CaA94Rs4AQaHWjQU1UFHM0GeU5YdS8LvIGuZFn+UMKntd3387dSgjyMivNx9t6oFXJAODW4zz426SpFfNsnTnzcsBT8Fbskdl/OUU99HdtXo/lZHf4ZfI7rSRwFoOKKFiwuZT8LeRwkotpnbUxD5swTlnqS9zy4Hm12OS4CZiOr6968d0BRT2UajCQgZju4wxLWKo6/nG2+yjbbW0GlF8Gz4omp5DPvBGs+tzWvz9Tjo0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:15:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:15:34 +0000
Message-ID: <4aef8acc-aa8e-76dd-31ed-0d32885a0e98@siemens.com>
Date: Wed, 5 Jul 2023 09:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/12] y2038: testsuite/smokey/y2038: Fix a race in the
 pselect interruption test
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-10-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-10-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3687:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b30d16-a80c-4833-fa64-08db7d279fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PuiyX1dK+ySFC04hxIGahIG4zXEF3ZSYHbsJrl53UEsxmGEb1jDVRlQenlWj1iI1gxO8+t/QEfLOqO6bnBCTm1XGOYPl/7PvQVCbJJnpJ/6/QUDlqVW6VvBG2HZE2E6woVrK+vblk4iXm3HGm/PkNKXE6ZzX0ENxsDBR/9KiS7A/Eu9Z8CbQ2uAPlwpmXishnUn+tK4wM40rSzKgKqbVSfPoejVulPxv4JkB3pFn7q+s3wy4++S4+bkgg3Q1BSREppOXAlBJ3BTgV06jbWWlr2DP4HwZISKVSX3hyuQbSHPDAqdGvoJTNAPCMvmasX2lEZq6uY7vA/JMBOJGt1yCgSP5xI8lzksLZBKM4/z6+V7sd4TRbxB5O8OVnQ8Pifi22Jia/IvpYWdQIPtoRd7dYOYQ6z2Gjfb74lpP/DITAncTLmh7As7nD/dJM0LMf5p1mumfg31QMp5h2lbo+PiGnDJtjOF+JxOf6z1nMJKnNbplR8PSXiTbHpI8VVHZxlFrrOFDj3SzpNbgqj/9/XZtBGMiSHFn36+c8TwcloF3cCqq60r8Goqml1VoHFwqFIBASmQcegdUYuu2O6RccaZQi8MzxD41ZfPy5p+lzcIE8a+BdcSIHsqWuNC4ZZ91FM1b9xC1xypIpA2FdL4sMVDpeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(8936002)(8676002)(2906002)(2616005)(5660300002)(6506007)(53546011)(44832011)(26005)(31686004)(186003)(41300700001)(6486002)(82960400001)(66946007)(66556008)(66476007)(36756003)(316002)(83380400001)(478600001)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFUREZOcUkweUtWSnRBQmhta0lvN2h0V1VkeThwSU1GamtmYlhNa1FTV3RT?=
 =?utf-8?B?OThGaEpUbEpKeTRCVEE0M1VacHNZT1JWb0JkU3VSTGFZRS9DMFRRdnVOR0lK?=
 =?utf-8?B?b1h6Q0ZJcENiS1JvOUR5Uk14ZE1DU1dPT2Z0TEN0R0ZHZDdab05GYnJZSkFn?=
 =?utf-8?B?ZW5Hb1hwbENGUW9JVDFKOUozUFZ4V0ZVNWxxb3ZvRXRDbk13cmsweHV5MzJO?=
 =?utf-8?B?TzQxUll6cFpUSUYwM3ZPTkxFUVRrNmlidThXZExmZHVvWG43SUFmNnc2TUs4?=
 =?utf-8?B?cnZKVEFuOStHVUMrOGVSa3dZOFVUcVBaaVN3ZjYvUFMrNW5udFAzV1NSV0Qw?=
 =?utf-8?B?NmdTVEJIY1U0Mi91WWJtUDV2V1E3d2RCb01QZnZvSW02T0JNYmpHTUoydE1o?=
 =?utf-8?B?RlRURWlDN2JxTXNDa09uNk1LMzNZejVKVFFyYjJkdERUMkNFK1NqaXlwWHpX?=
 =?utf-8?B?U2xiSlZtblhybXpYNGovbkZoNVJFZUh2QjZDWkNYdjc1blJET1VyYml5L1po?=
 =?utf-8?B?YkNVZ0xPRFpYTGtxRDJrT0lSRHhBWDhmRjUvdTRBMWNkK1R2TjhvMGpwdFlh?=
 =?utf-8?B?c3RtWS9tWFNMOVpUNVFVL2JEZGlkUlZOZHVSQytxZFZQYlFjQzN1RGk0d05J?=
 =?utf-8?B?U1V6ZVNodzJvUDJuNzF2T2g1NzRGU2xrZTFZVGM1V0FSNC9JdUVMVk42cEN6?=
 =?utf-8?B?Tjh3L0pxazlnRkM1blV5eStLcWNSMDBxaG5UYjZaSU5TVldQK041TlFHaHZu?=
 =?utf-8?B?NUpIc2pLMnhKMHZlRnErMW1PRzVaS0NqMEh5cTNNdVlzR2J1V1dZL1RJb0VU?=
 =?utf-8?B?S2JDVG5NckhuaE1yRUNUSWx6UHFRNjJJMXpTYUdWUTBML0RpYnY1T3pEUzdy?=
 =?utf-8?B?VzB1TWZ1bUk4bFBlUWF6VnB3dVY4L3BJQTB5c0o3YUdYRWlsVnVKTmo2d2Fh?=
 =?utf-8?B?eXV4aEF3eDhVYjZOL1NLMVZvUUh3K0VUSFlCRzJQck83UUVxT1ltVWkvQTZL?=
 =?utf-8?B?MVYvbWNBeEVXY0lFdktxcHZpaWErd1pVQytHR2NBaXJCaUN1dXRCNWJtYnFo?=
 =?utf-8?B?WklNNmYzQjJ0cVExVzdLUVo3QWE1d3hkZ0JUT0Z6VmZZbSt4R3B1c0hOeHYv?=
 =?utf-8?B?OER1dktTWjNIRXVraWtmMUttdUt5blQrRFVjb2JRYkJkSThwVlAxL1dqSy9S?=
 =?utf-8?B?M2ZNYi9nYnZ4MU8wV3ZIRWZFWG5keVFyakZxTGx3dGx2ekRmYkM2a3YwMWs1?=
 =?utf-8?B?UDIxaXVBankvU0Z3U2V5ZUljL3B3NWFERWc5NXBaeHdLOWEyMFlnd2FjNlNI?=
 =?utf-8?B?ajg4NjhZTXY1Y2MzYm44QTlWWFNLYjZVQ1NPcnJ3OS81VWF5RlV5bEVZYVRw?=
 =?utf-8?B?TDdaWWNjdWpldFJIcXZBQ280NVVRUXZHU2Y5R0duVllHZ1l0SU53bHczcGt6?=
 =?utf-8?B?djdrd2MzYjZWMlhoN0J5UTRkTXAvc1oxclpBa0hWZmFlcmJlck0xaWNrMW0z?=
 =?utf-8?B?RXk3cFovUm1Fb1pCTjhCVWhmWm9NeXM4SDN5alJJVEtRVUJtTHZkclFrQS8y?=
 =?utf-8?B?Mk1KT1VRdmNMTk0weUhOams5Mk1qcHhJaFVpMGF3bGZ1SFErQWR6R1ZlT0M3?=
 =?utf-8?B?dkZqV1JPTGdPWEhGTzlLUjJ6NFB3SlgrV25HbFdlN20vN3hlaGRtdit2NWwv?=
 =?utf-8?B?QnZPczMyOXFGZ1BVU2pSYXRNdnRrWlFJWTBOakpPY2VqTDJUVE5EWmlPMVEv?=
 =?utf-8?B?WU5aUURVQUg2a2cwMmwwSW43OVFzUmxHY3RqSEppRHM4SmJyU3pJYTNFeEVh?=
 =?utf-8?B?ZjlvMG9MZFBPQ0oycS9WQWZXYmxySXFlKzRSbStoRFViN3BCTXFlREZiWmtI?=
 =?utf-8?B?VFJGMjk0TUNud3h6OXpRZm9KbmU4d0pFd1NFM3ZRbjFyek1ubnJEQjRRY2gv?=
 =?utf-8?B?bnNMdlA2TkNlWks3Q3pLaHdmQ3Jvejl3U2o0am9CWTdMV3RuUm5zTi9CY292?=
 =?utf-8?B?Sjlia2tQM29ua0pVYUxxbmUyVFJLLzAxTUhVT0VVUWFyeDNiZFRHNytTME5t?=
 =?utf-8?B?dEFQOC9ReWlLdjh3U2ZJeXlIWGlKT0RkMkJGKzByWkFOZ1o5S29DMzVIUUxB?=
 =?utf-8?B?UXB5SlVNZEROOXVySkFucEh3UjNpaEloRzVMaTkxR2dKM3FndlkwTzdycU5p?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b30d16-a80c-4833-fa64-08db7d279fd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:15:34.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9hWx8OCdkVXIPI/3j2JPE6zivIZaCvVKURS2uuvRdNMxZfX53dzrgnz6nyBvJrnGRAKR7nM5IyNDc49i543wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3687

On 05.07.23 08:38, Florian Bezdeka wrote:
> It might have happened that the signal was sent and handled before
> we reached the blocking point inside the pselect syscall. Adding
> another synchronization point right before the context switch should
> fix that.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index ab7c3bb4c..0ee0bc48c 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -124,6 +124,7 @@ static inline bool ts_less(const struct xn_timespec64 *a,
>  struct thread_context {
>  	int sc_nr;
>  	int sock;
> +	sem_t *sem;
>  	pthread_mutex_t *mutex;
>  	struct xn_timespec64 *ts;
>  	bool timedwait_timecheck;
> @@ -1472,6 +1473,7 @@ static void *pselect64_waiting_thread(void *arg)
>  	/* Waiting for 1sec should be enough to get a signal */
>  	ts.tv_sec = 1;
>  	ts.tv_nsec = 0;
> +	sem_post(ctx->sem);
>  	ret = XENOMAI_SYSCALL5(ctx->sc_nr, sock + 1, &rfds, NULL, NULL, &ts);
>  	if (!smokey_assert(ret == -EINTR)) {
>  		ret = ret ?: -EINVAL;
> @@ -1494,6 +1496,7 @@ static int test_pselect64_interruption(void)
>  	struct thread_context ctx = { 0 };
>  	void *w_ret = NULL;
>  	pthread_t w;
> +	sem_t sem;
>  	int sock;
>  	int ret;
>  
> @@ -1505,14 +1508,22 @@ static int test_pselect64_interruption(void)
>  	if (sock < 0)
>  		return sock;
>  
> +	ret = smokey_check_errno(sem_init(&sem, 0, 0));
> +	if (ret)
> +		return ret;
> +
>  	ctx.sock = sock;
>  	ctx.sc_nr = sc_cobalt_pselect64;
> +	ctx.sem = &sem;
>  
>  	ret = smokey_check_status(
>  		pthread_create(&w, NULL, pselect64_waiting_thread, &ctx));
>  	if (ret)
>  		goto out_sock;
>  
> +	/* Wait for the waiting thread to be ready */
> +	sem_wait(&sem);
> +
>  	/* Allow the waiting thread to enter the pselect64() syscall */
>  	nanosleep(&ts, NULL);
>  
> @@ -1528,6 +1539,7 @@ static int test_pselect64_interruption(void)
>  		w_ret = NULL;
>  
>  out_sock:
> +	sem_destroy(&sem);
>  	close(sock);
>  	return (int)(long)w_ret;
>  }
> 

Applied to next already, thanks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


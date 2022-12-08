Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2089.outbound.protection.outlook.com [40.107.103.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E392F3D
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 13:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUVlkBDNzFBNHzzFi9dL0kvAD1MqOnPLSbrTbTxxGr9Goer5k+1JZnc0Gf0RahzYYtLQfCJBcr/CVU5pAvOCZZ8CGlIxgLLcG2yMEyhPOTyWq3pPjwW1dRnar13GAN/dJRF/7AVQD6FIHWNcVcYFkoG6+v9TVwOEYVnpjmgMeXwczLxi37mUFDX0uWg9RArLLdwtNQqsXDloCSHQ8APlGvJbjYkrqiHpkqaHsJBO4OG7gb4CMGT1EYUYMFVaFWNF8hCr1pYNfV/kQSl6fLWuTK5ZFXeCO5rshqM5TxvnuqN3GVkc4vOUWiBMdDy37wAWmlho80VIdy2eIzmfnpztfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YC08dEDwHQFS62V/IK3JnYcNxuISMljTFM3TKBrX44=;
 b=U0zGcakm++ryuDDH5otX64/LsSHbxmm5Lgvf0sBYrrDUgx513rT94nlJJHLy3gMJqgSDoW0OLpuhy+8VfSU/Vu1SU1ZuAhAdoQW7QnQDQYwcNUezYk9frKKNDHbsWSPpEBqIVk1P8s7nlyh4rqW2gk6vjCdryq3dDEEuw1xswIdB5WtZI9ghsUG9Eslw+7L4n8Jw4nrcRw1QsdXXG5158tPJM7dnF7OPKL0EiHD925LmfNXsgnHHYQkU6StR1m2sDSX6gW08DZ7Ufiu+QBf/GG43tMymX7YMeKTshGABY3E2O4RGTL0c4acbkCrHWrNeGyKXiBFxkkQnvkI6QOXQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YC08dEDwHQFS62V/IK3JnYcNxuISMljTFM3TKBrX44=;
 b=HIfDGrrv5dUQYbuecMW9GMdGIp/JYBu5d7sDwgat6+WWUld0eFTOmctnv7hS3zRtsVFL1dTC2stHKMC12GswNVcnM4fxjL3XDOyjhLHnT449nphHNuFZiYZMryzY/A/jHq2hMzLPzDAuCEDMYi2UDXLOVM5t3d+vISi3lgBDsVPVRSdb7lFET+PD4WtAmsZHXlA+E+GT8OzN7Zhx4rAUZstOv82T2MzlTZ0zJuowOZH+eyGnwuTO/hIUEqdpzNhYYkR/MfbereOCLK5kxy7nzLhAyCLHemzt7uCwxNKCCLU/p6QCSWRWgPh7YKopiiHFABt8NAyTR4jyX1I6UpW+CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 13:53:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 13:53:28 +0000
Message-ID: <9aa8fee9-0700-6568-76d0-ef13e38ba87f@siemens.com>
Date: Thu, 8 Dec 2022 14:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] switchtest: test multiple secondary switch cases
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <20221205152104.3555474-3-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221205152104.3555474-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d72a5d-be32-430f-e933-08dad9239594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QAPukzX5+u3/wnVlC9jFmK5WsjWf6jSNUk7pkNH5n2ZDJy5LKXk/lw3mxrkOU/HwoD/Bs8XX90xkN9p4FBslFMKkbaRIgKjxah3Bj8mPOpYC/RCMVII4r+6gz1JWZQog7iipgr1o9jR5w11aVvhjYPWNvRTCXnBorkThpqZ1RKHqj7PtSMyF0rEL2IloKAF4ub/ShQTCRqKWTQ8vEGyzIL8jD0TftRJ+5yBqJ/cd7G1FtBfkMpxmSjEfuDoKYq0vH5Ldu7A0W11a+vcIGyOFubiRzm8xwRfr0YrGOYG0AOlWa32/ZKNscnQuTB4AMUTNiB9lJnMnBp0tvtNTIJ18BNPBfVRSu8PluGxVgDoLIbwNnafIvCpkJ+Nsx6wyWDk77xQROc/ZKJkQoVjuZnXi718G9iWqxj0bCk5zpoVAyWMIfB9m+sc/a0XvFM5xpgrPwBUB2j5M8UUj54islGd26Kpy9qArff8NQQWGL1QT9FjHm3o7lpDWHTm9OqotNKgLhTt1c6x946EJK4KOYKBKn0etfdAh7VbxYPd3ievLvqtrsMWVmLIDacn1AnqgzugsAqf1g9MyPLxX3uB5U3zmRw4szVT2GqWGRUZUFg4dKfxL3s/cLL1rs31hpohjVUZFj0NbN6Z7hPVHpotrioeJKRcywypwgvhcatLKgTSmp7Squ6Eo6jEQzFuq++KMoBzfM7VPP3oADOmsiFxFk3t+J+YSpxI9dEM62UoRNt+oUXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(38100700002)(31686004)(36756003)(4326008)(83380400001)(44832011)(82960400001)(2906002)(8936002)(41300700001)(86362001)(5660300002)(8676002)(6486002)(66556008)(2616005)(316002)(6666004)(478600001)(66476007)(66946007)(31696002)(186003)(107886003)(6512007)(26005)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nno0cnAxUW4razVHbmFYWVNQYUFxck9JdDM5cjV6K2hzWE91NEl3Z3B5cmNR?=
 =?utf-8?B?NC9ONzdPc093Nm9uajNQNzh5R01Qc3REWVdqazQvZzNxMXB6RXJWWG81akxS?=
 =?utf-8?B?MWFhY1dDdFhCelFkdzZoREpycG5jMXZTK3hDd1Bya2VCNmEydmNjRVdzbVhN?=
 =?utf-8?B?eTBPMFhqeC9uMHBza3h0UmVhcW12N2JJMm9MTHhoRS9PRVVZU1pmUHJQZ1VS?=
 =?utf-8?B?a2pHZHFJbUtkdmdZd3NielBhSGV1YStzYUhUNktmbEloYkM1Rzh5NUV6SDNy?=
 =?utf-8?B?dTRTdm44ZTBwT1lLb0VXZ09NVVUwbGN3RUc4NElNaklyUlhwQmdsVE00MEZu?=
 =?utf-8?B?WHlJSFBLOHFYNFhmTytWVVlac0dTVjN1UExZczRwcUVUbDRVR2N5OGhUNERI?=
 =?utf-8?B?VXNQdnFwV1pQYmNvNXcxY25FSm9JWlAzbWkvQ2svUEY3SEpGc2RlZWlMbGd2?=
 =?utf-8?B?VUw0RTgwRS9vVDhLQ0xESFpDa1pGM3QzeUVRZmMxL212b2k3K1lVSjJwUDIr?=
 =?utf-8?B?UXh1b3VGaSszWnpGM3pCbjlaYy80R1pWbFNkeVpWTEZUTVE2dmdQVm1TT3R0?=
 =?utf-8?B?TnBqNXFzNHdTZGhtaFM5MHN2YXlCVnBtUGh1cE8rd3ZXVkVlRFZqdmw0OUZ1?=
 =?utf-8?B?b2duOGpJZlQzaFdqQjh0Mng4OWIvaFpMamwrMi92Yzd3eDR5YVcyQ2N3Y29y?=
 =?utf-8?B?NVdZcUU0WUsvSW9QUnRhamxyMW54VTJsd2VEVHBQcFNuYlN6em55Z3JrbGVn?=
 =?utf-8?B?azJwLy9uZFhnazlMWFRkVnd5NkhqY3dvYkJHWlptdi9qdi9maFdPTm1pc2pw?=
 =?utf-8?B?VW1xc1d5RDZSSnYxbVNDT3pWNG5PcGNBeFRudE9LdHN1MThUTHdBZ0ZDMTZn?=
 =?utf-8?B?SXdUNnlCOXF2dXpnbkNOa0Z3WXVidENUUkloNlhkTlVxSWZLb3VHbFFlcCsz?=
 =?utf-8?B?VURpdWF5UzlWa1l1SVFxMklRYjk5ZzNwTFVJc0lwUnlRQWZYNUVSekR3Q0tj?=
 =?utf-8?B?LzNlS0FxeFlsWXhYT3g5Z2hEeWExOE00Njd1cjZsMWNvcDloN3JUK1J6UDY2?=
 =?utf-8?B?TENiN1V3bGlYMVFSMkNyMG5zMXlETWJIWDg5Yi9oOGZ0SUkyMVVicGFaK3R5?=
 =?utf-8?B?S04yaFM5NjFJRmg0V01KVVJuR0lsbGtrWlExb2poRjlORXU4MWFmR2xVMHRW?=
 =?utf-8?B?aUdFUFNPb09KWS8yM2hWZ0ljQTVSQmZpQVRhMzNTOUhLUHdzcUcwYlM5dll3?=
 =?utf-8?B?VzBUUGNhOWI3Q1VpZWRPdEwxc3ZXck9SRllhSm94bVRPVmd3TnB4QkRGWkdv?=
 =?utf-8?B?Yy9FbFE4empKMjVrTkJwNzVITHV1SUVGT0lvZ2szTE1GMzVGNGtKamlWYWtR?=
 =?utf-8?B?QWlmcWQ5VG9WMkY4Ri85NXFXdjdmYkNvcVlLa2ZSQys2Zi9QeldVOVR0Mnpj?=
 =?utf-8?B?bWVnbGcycHpsQWh2TXNvSVIvditMdnVUT3FQampEdFhPdnhQSW5BZ2dZZWVj?=
 =?utf-8?B?aSt3VmtSbE01dlM4QmpQektYOUQ5WlRNcXJWOGNmaDRsdm1VUnhEVWZjZm0z?=
 =?utf-8?B?ZzRYeExFWjZ1K3FlUmF1L1hMR1NBOW1NWWpzOG4yQS83c09kR20zR1dwMll0?=
 =?utf-8?B?ZXdGanFLeENwTGpyWVR3azVaRFpRS0NXVFBGcW9vMDAvN2ZGQkRSV1hLR3pp?=
 =?utf-8?B?cDUySmsxd1ZxVnV1Tmx2eHdyYndlSjIwWDRDV3RrQnRjVDlrOU9HMGhGdk5K?=
 =?utf-8?B?U2d4YjVDSlJIVFczQ2h0OGgrY3RTemh6TEwrczU5cjI3anlZZTFaV2VuTU5U?=
 =?utf-8?B?WldncjhtalJpeFA3UU5KMHpsa3hOR25WR0RZZ29TTytpY3d0RDA2ckJHSG5D?=
 =?utf-8?B?ckdiUmJuTUFhSXVYbGJuZGxPYk1oMUdFWjl3RFR5SElaSHJ0Z285dVkrdHhM?=
 =?utf-8?B?ZWFsazBsSUdaNTBpMHVoRU5lZTVaU0xiZHdMdzNobkYyTGI0dUdLNnhoVVl0?=
 =?utf-8?B?cEFESUNGYWFGQkpVTHNTYnhmQzdnMFdHeGFzWVM3RzNtSTdVZ0hDSjFvUEVH?=
 =?utf-8?B?VE5EZUhTUTFCTzlFZkYvWER1SWZueWFnb01KbU5uWEVRSFpxcS95bENMK05y?=
 =?utf-8?B?SDB4cStnM0lDaVp1NUpMK05iQ1JMZ0RhWDY0WUUrYzJNZENnUjlEOHV5bU5r?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d72a5d-be32-430f-e933-08dad9239594
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 13:53:28.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIO6hMIJWUJ3MIu+fGLciYrKpJwURxiRyeroW1+hS8b6hNUVOlTNwxPrt6x03MolKNYZP52EfhKvwt/H7lOR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6935

On 05.12.22 16:21, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Switches to secondary mode do not only occur when a relax is explicitly
> called via the cobalt api but also e.g. when a linux syscall is called in
> primary mode.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 117 ++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 38 deletions(-)
> 
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index f8a37da79..12516186b 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -34,7 +34,9 @@
>  #include <semaphore.h>
>  #include <setjmp.h>
>  #include <getopt.h>
> +#include <asm/unistd.h>
>  #include <asm/xenomai/features.h>
> +#include <asm/xenomai/syscall.h>
>  #include <asm/xenomai/uapi/fptest.h>
>  #include <cobalt/trace.h>
>  #include <rtdm/testing.h>
> @@ -75,6 +77,14 @@ typedef enum {
>  	UFPS = 4	 /* use the FPU while in secondary mode. */
>  } fpflags;
>  
> +#define TASK_SWITCH_MODES 3
> +
> +enum task_switch_mode {
> +	TASK_SWITCH_PREVIOUS = 0,
> +	TASK_SWITCH_NEXT = 1,
> +	TASK_SWITCH_MODE = 2
> +};
> +
>  struct cpu_tasks;
>  
>  struct task_params {
> @@ -297,6 +307,57 @@ static int printout(const char *fmt, ...)
>  #define check_fp_result(__expected)	\
>  	fp_regs_check(fp_features, __expected, printout)
>  
> +static void _assert_primary_mode(char const *calling_func)
> +{
> +	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> +		fprintf(stderr,
> +			"Switch to primary mode failed in %s.",
> +			calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}
> +
> +#define assert_primary_mode() _assert_primary_mode(__func__)
> +
> +static void _assert_secondary_mode(char const *calling_func)
> +{
> +	if (!(cobalt_thread_mode() & (XNRELAX))) {
> +		fprintf(stderr,
> +			"Switch to secondary mode failed in %s.",
> +			calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}
> +
> +#define assert_secondary_mode() _assert_secondary_mode(__func__)
> +
> +static void switch_to_primary_mode(void)
> +{
> +	cobalt_thread_harden();
> +	assert_primary_mode();
> +}
> +
> +static void switch_to_secondary_mode(void)
> +{
> +	cobalt_thread_relax();
> +	assert_secondary_mode();
> +}
> +
> +static void switch_to_secondary_mode_by_using_linux_syscall(void)
> +{
> +	syscall(__NR_gettid);
> +	assert_secondary_mode();
> +}
> +
> +#define SWITCH_FUNC_COUNT 4
> +
> +static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
> +	switch_to_secondary_mode,
> +	switch_to_primary_mode,
> +	switch_to_secondary_mode_by_using_linux_syscall,
> +	switch_to_primary_mode,
> +};
> +
>  static void *sleeper_switcher(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -354,13 +415,13 @@ static void *sleeper_switcher(void *cookie)
>  		if (tasks_count == 1)
>  			continue;
>  
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to == from means "return to last task" */
>  			rtsw.to = rtsw.from;
>  			break;
>  
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to == rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -440,24 +501,6 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
>  
> -static void switch_to_primary_mode(void)
> -{
> -	cobalt_thread_harden();
> -	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> -		perror("Switch to primary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -
> -static void switch_to_secondary_mode(void)
> -{
> -	cobalt_thread_relax();
> -	if (!(cobalt_thread_mode() & (XNRELAX))) {
> -		perror("Switch to secondary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -

Please locate those two already at the right spot in patch 1. Then you
don't need to move them around here which makes the patch smaller.

>  static void *rtup(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -493,13 +536,13 @@ static void *rtup(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
>  
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to == from means "return to last task" */
>  			rtsw.to = rtsw.from;
>  			break;
>  
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to == rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -574,13 +617,13 @@ static void *rtus(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
>  
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to == from means "return to last task" */
>  			rtsw.to = rtsw.from;
>  			break;
>  
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to == rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -656,13 +699,13 @@ static void *rtuo(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
>  
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to == from means "return to last task" */
>  			rtsw.to = rtsw.from;
>  			break;
>  
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to == rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -679,6 +722,7 @@ static void *rtuo(void *cookie)
>  		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_regs_set(fp_features, expected);
>  		}
> +
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -700,14 +744,11 @@ static void *rtuo(void *cookie)
>  		}
>  
>  		/* Switch between primary and secondary mode */
> -		if (i % 3 == 2) {
> -			if (mode == COBALT_PRIMARY) {
> -				switch_to_secondary_mode();
> -				mode = COBALT_SECONDARY;
> -			} else {
> -				switch_to_primary_mode();
> -				mode = COBALT_PRIMARY;
> -			}
> +		if (i % TASK_SWITCH_MODES == TASK_SWITCH_MODE) {
> +			uint switch_iteration = (i / TASK_SWITCH_MODES %
> +				SWITCH_FUNC_COUNT);
> +			switch_funcs[switch_iteration]();
> +			mode = !mode;
>  		}
>  
>  		if(++i == 4000000)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5342D29D02
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920451; cv=fail; b=S8shzdAVodzAARCRe8OI6kfK7haLB1kwFBdyShIcz1lihqkZzF1BDpYjJAjzUXer8bLV6bimeugyPn0Drx/plwwp4gJMkHQvjjJ2pgPfpQ0TT2XJ5dpIgOYPXDjO/5WJhuMn8SfC/8rL5nMX8WaGY1W0YneiJW8MKGpo3QdC4fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920451; c=relaxed/simple;
	bh=WpSXWkQlIyriZSQLaCVLwJ3E6WppgMwBGBAFgNNcC60=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sF9vMpkOaDfpH1BJ7fBFVgZ6ozJzVnRkaFW5er5HpWySFSUjFdCsM0kkLrw8hPZIoKpxdzxlWWCE6cxfKZRkmba8TIzDgig9c54ibs+J4F8Jose3xb/ESaswSmCn7zJfkw1abZmwP4EWxCq/RcwE2wrjwDfhMorvs1CBlCTeOLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EeE5i2L6; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EeE5i2L6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCbbNz36oWZIvZ/5MU4phzCLXRRJkgZKIDx7727WZ6xNAPCQ/OC13x0ZqCHJOK4xUT5TmneOELueS/Nft4EyEGZbkQGwPk2yLRSzzh7C24oYmn371yKnpGX2W0jKTk/aZSbU5g5pM3ckdKEsEszo4NuciSC1YlI3PXVDKYXOU2ao2cBQphGtWKTgkxmSzu5Y4kVn4rnW3Wh3ZTKY31HsTUUXUWnvNmdGtZIX79s0Q4JFuo7AdBq91Y9qSDL9x3/S2m0aEAK+4WfGhHdFk3UGiNPa3WBJ6siZCJLfVpGL2xOyQ/VrS2GWpYnt8FYGcnRfpKbjp4opeWgwS1IeIxwxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv+HL+W5R3GdpZgllnQCxLF5j8f2h5rGm7TR02LT3sw=;
 b=RE9nti76yhhHAgUuidd1mh83XzPRMILc5ivnFGtgqJ6T0ISnGCiRwy0c89gyFA3Vf0b/OTogffqsTIEHifvjTv1BxKTkCJ8QOlZRxZrHMX4eQsz6tKI/pf9AzCj/YwR2P/N3XJZ2wlntc4e1UsqMlhYeaGWvOQnsJsdwB9xKB48ShTtXkUYzGI2M4VmPETWtgers4QVbVkwa2VHih4GIqotChv1vVgQmnIpUfH/jtTwkFNJLNx+l8mCjqPsb0RzeXR15Va5YgonYw7s3PKU7/LXvBnSUYPdjq7QwE2wVy2ju0kA/He9wteHz0B07LHNyL/mSoklrgqwz61fX5geNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv+HL+W5R3GdpZgllnQCxLF5j8f2h5rGm7TR02LT3sw=;
 b=EeE5i2L6M3wyOEBY7Cb1KOrndyTkYY+DHwhpNk/UTA3yh05J8IeRZ7OoY+yLLmfQddO7xQUPhzs3+OS1IEuOmsskvpVMGUxCMnehBUooJmnjKNUvQvjXxUm/k+gqvGWRpeC4f1vnsp8yTp+Ssv59H6fSKPnblvn2ySj3vBEMKTkhnmroGzDHpByKiL8j2F3yrWptKkAcRWi0ULz28JRIgozBjYkYAp4IEZxd6dITpCY4Qa1f0ZqVaQcpu3KbHF9vgeKT6ONHlOQ4Y7Nv3lgnCFuTofo54Yfgjs/diUEGxDc3Y2OsHhQngeL7p8EQToBCktZ2dxcGVNxCJuTIKXxRng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 07:40:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:40:45 +0000
Message-ID: <62f6cf88-2aac-4300-8e9e-b868c42ebbf6@siemens.com>
Date: Wed, 20 Mar 2024 08:40:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] testsuite/smokey/gdb: Fix race-condition
Content-Language: en-US
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <55c1a08a-6b1a-4d75-8a1b-2df85bebcbe1@siemens.com>
 <20240314134411.28121-2-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240314134411.28121-2-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c55fbc-6586-4e33-64a9-08dc48b10daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cSo+ozhwEV3mm8E64tnpfnI68ZUr2wTMvMPBNIyVPgGTqJcj2ldiq/YHxS72hY6SvYxSs4dRupHb0L5JoNZbEoc8AlCephpNZRECO08P694rn2eOLhLuowkskIZkho7WyaUo5E6epHKC0PXhnE+xm20VfMqNH+P1uaXhrW1vMfrmTHsqeBBwk9o2lXp4JFYVhTU2lvgU4gpGBRuizucr6C/LSAJWduK+mUJZdM/r49dPFes2kEYGQXwBXgnf/UVbzZQvVeD2fiLtSrxxV8///vnju8fLDrjHz7hrJp8mwlNFfiExR1nVa2rBbcAe9gPcOySK3PaPv+v3mglRtaGqUMOYZkYDvMosVix58li+RNc2ly4aVZHxP5qOKvVR5bhPfYFbsP+kRDyWVQeojkHy0w2q8Sngz/zW+cLjzhGjduZEnkkXweUIbvxlut1dhj/ETF2R8AgGqVPHLhIhZf1BXl88A73LOPIoj6lBIFsPOEHU6t14Q8wSK076Wip5zuqBk98K8DVb1HmdLyqF2MxMrMnZ9qtrcDTgXW+cn8bgFYoPQotn2pHQrhqn5lrnm0UipSd0792vx/lxU8Ev2Qz29OJZFfYtOsBdDFxaAD1Eyv8X8an3hriprv7Y5gnEgOkvB9XdOR1m1I5NqvQ2WOBwOq0DZq3dcy0qCsAkR6Hkccs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlkaWtLUnpxRTkzcDJMYld5UTh6c202Z0NJdlBNSm4zVWJIdWxOa2FXMDJE?=
 =?utf-8?B?eThwQ3lUNzRXc203U2F1UHJkWU43ZVZJUmpQY0NRQW5aczJjbUt0UUhwcXVk?=
 =?utf-8?B?RzUxbEVZMkNjMFUwcE13a1R2VmlPU2pXRFl2TktXVXJkcGF6SS9ZWXlmeTZp?=
 =?utf-8?B?RTlNdzM4eHlqbnNNL0c2Y3ZSUW83SE5zL0tzZ0NGMEkxNE1tNEJVUXc1NkVz?=
 =?utf-8?B?MTUvWmhha2p4YjFWNERhOHZSemNOQlVPbGd0R3oxUEhnVFhYOGNRL3ZMbUlr?=
 =?utf-8?B?UXhDSmgva2RIc1NScllhUzBNSkhydDFxaXlRNWpFQTBBTHI2MWFnRzJldWgv?=
 =?utf-8?B?U1JTTWpiTEJjNE9ZS1JqV1pEMTZFdzNNcG1sSTQ1YW81NXFCcCtQdlMzN3Ra?=
 =?utf-8?B?bm5LUFpCeDBQQWc3NG1kMUdVdE5aNCsvUUFvbHVYa2Q5MFhkSkJVOXBObWNO?=
 =?utf-8?B?bEhJa3RLUFpFZkRYaEJiS2dmcGhrTWkzSkcvVzhua2lIU1piZUtyYXFIdkJ4?=
 =?utf-8?B?WVBnWkFIcUdlenFhclJlT3EzRWNpOEFDcHJvbGlzSkh5VGcwaUdqTnZ1Rlhr?=
 =?utf-8?B?enRQQ0o2enlvWHp0UTRIZFV4ZnNrYlZoUkN3WStEdDNRNkxuOFFJa3BFcXBy?=
 =?utf-8?B?VFNlOUJEWHpGMzZzcjVEMFQxU0JEeWxhQ3BCTVV2SmpaOUdVQTF4RG0vNCtE?=
 =?utf-8?B?UGVIRmFsZm1WN3RIdkZKUW1oWTFwZHk3RGpiSStWNGFRbXRjcEwyS1N3VTc3?=
 =?utf-8?B?bkFJUm1LYlBQM3RyazFRNFZBa20xUmwwWVFjdDhqeDVxYnFoRkQwbVJqdTlO?=
 =?utf-8?B?SDNOWDJIdlNoQkhnZFl5SXd3TUhYcGVPTUFMRXNPYzFXQ3ZKWmRicXkzZmJF?=
 =?utf-8?B?NCtubEt1UHFNS1dDNm04UXd1SDlmOWZYck92ZHdEUFVZNXQ4WDhkais5M0NU?=
 =?utf-8?B?NHZlWEZXbUlvUzd4Z2F4VHdDcHlwZU5qSTdVeVNEVVYyb0pjenZ1OXBVQ2gr?=
 =?utf-8?B?Y3YyL0VSYkowb2NrSzYzY3lXbC9CTzFodU5HQm9GMTN4OW5ha2RIQkhKN3FH?=
 =?utf-8?B?QUlsUXAxSk8yNnBiNWlFNVJUcnY2MkRIeEFhWmZJTzRzQWF0bCtoZzMxcHlT?=
 =?utf-8?B?RjdwWmJwUDdtbFEzKzZqSWFVYUNPZ2h4WEQ4Q002RjFKTHdNWGpVbitubkxI?=
 =?utf-8?B?Ym9nbGNjaFVRbEt3SmdhRzhoRHN5Vi9uaEhlVkZsNCtEeUdOZXU4bHFBVEwy?=
 =?utf-8?B?VGhOVmlzS0Z1MWI2bDI2QVJQby9KK0ltMjkzVW85MGtUbzd3ZlZGUHVJczdj?=
 =?utf-8?B?WEc3M2EvTGhtZ3VGcUc5N0VpdTNIMGhLamlFYTZyK1o3THdwMXpneS9pMVo1?=
 =?utf-8?B?WVUvWHpFWDEzUndWSktJV0RPUEh4YXppTE9wNFM0cjhJbWdQSTFVUERsOXJu?=
 =?utf-8?B?S2FMVFllYTNiVnhHTW4zd0VpR2xpa1cwYzQyb3pOd0JvYlYvV25wbnU5enc3?=
 =?utf-8?B?WlZhc3JORTcxU0w2OFdFNWo4cjFNOVlnMUlnTk5rMU5WWk9wRkd1UDRuNXFr?=
 =?utf-8?B?VktEWXF5bHpjZFdYWVFsM2ZSd3pMMS9mTk9ONVcyeVl5Mjc5amNuMXZVeXh1?=
 =?utf-8?B?UGdMWHc0WlRJcGZYaHZzMTdueFJGRWtCeXplbDUrRExEdmJQeE9pYVdMYWdp?=
 =?utf-8?B?V1Fxc0cxZUhpbTI5MllackRKWC9hY0REb2pCcTR4U2YyTU05SVhzNTVnVVhD?=
 =?utf-8?B?RCtyYUw0Z05RTC9iSnRLUmI0ajZlWGRXVWswd25uSG5OLzYyUVZMWHIzZHVl?=
 =?utf-8?B?U2pTTkU4WWRMSVBDU2p3NnFadGttVG9ibk5McERyYTFVRjNvcEpVMUlSeEpB?=
 =?utf-8?B?T2ExQ1c0aXRkTVI4UmhXTHdpK3BtWkpjU2d1cksvM1ZsaTFxQ3UyQUZDcW1X?=
 =?utf-8?B?WHd0d3FKN3dmdzltSUpiMTNOSUJZYjFIU25HTlNtRDRjcUVwamJlUm9DYTB0?=
 =?utf-8?B?Qk5JWjRCM2c0NDZweGliZ0NmT3N4cXU1ajdOcTRkUldSekJNNUsycWFJV3JH?=
 =?utf-8?B?UHRCaWtqZCswbktxdDY0Mmd0MmNaRHM4dEs2bFpqMjR1K3V1YXJhVVd6WERU?=
 =?utf-8?B?WnNYNTkyamx0ZWhod21aR0hHeElvRnF2Zm5UaGlmNit0VjBmRDV4a3liQmFO?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c55fbc-6586-4e33-64a9-08dc48b10daf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:40:45.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLN/P5/Kd4JmwJAL+Q5zILusdoauNCKzEkHXNqv5q/LJi3v/xaeZcjbRdOxyh91ycj8Z55nNkKvCzCKJA8cxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6274

On 14.03.24 14:44, Fabian Scheler wrote:
> When quitting gdb by sending the quit-command, gdb may actually finish before
> the father-process calls pause. In that case the father-process would wait
> endlessly.
> 
> The fix now uses waitpid instead of pause to explicitly wait for the
> child-process, in contrast to pause waitpid also handles child-processes that
> already have been terminated.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  testsuite/smokey/gdb/gdb.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
> index b09b78b4e..1daa7ee4c 100644
> --- a/testsuite/smokey/gdb/gdb.c
> +++ b/testsuite/smokey/gdb/gdb.c
> @@ -78,7 +78,7 @@ static void handle_sigchld(int signum)
>  	if (WEXITSTATUS(status) == ESRCH)
>  		smokey_note("gdb: skipped (gdb not available)");
>  	else
> -		check("gdb execution", WEXITSTATUS(status), 0);
> +		check("gdb terminated unexpectedly", 0, 1);
>  	child_terminated = 1;
>  	close(pipe_out[0]);
>  }
> @@ -202,6 +202,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  	pthread_attr_t attr;
>  	char run_param[32];
>  	cpu_set_t cpu_set;
> +	pid_t childpid;
> +	int status;
>  	int err;
>  
>  	smokey_parse_args(t, argc, argv);
> @@ -257,7 +259,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  		err = pipe(pipe_out);
>  		check_no_error("pipe_out", err);
>  
> -		switch (do_fork()) {
> +		childpid = do_fork();
> +		switch (childpid) {
>  		case -1:
>  			error(1, errno, "fork/vfork");
>  
> @@ -283,8 +286,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  
>  		default:
>  			wait_for_pattern("(gdb) ");
> +
> +			/* the signal handler only is used to skip the test if
> +			   gdb is missing */
>  			if (child_terminated)
>  				break;
> +			else
> +				signal(SIGCHLD, SIG_DFL);
> +
>  			send_command("b breakpoint_target\n", 1);
>  			send_command("r\n", 1);
>  
> @@ -301,13 +310,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  			eval_expression("thread_loops==expected_loops", "1");
>  
>  			send_command("q\n", 0);
> -			pause();
>  
> -			if (!child_terminated) {
> -				fprintf(stderr,
> -					"FAILURE: gdb still running?!\n");
> -				exit(1);
> -			}
> +			err = waitpid(childpid, &status, 0);
> +			check("waitpid", err, childpid);
> +			check("gdb execution", WEXITSTATUS(status), 0);
> +			close(pipe_out[0]);
>  		}
>  
>  		signal(SIGCHLD, SIG_DFL);

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


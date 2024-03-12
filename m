Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46386FAE
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231360; cv=fail; b=L7SNsf9IAgJNRn6+GhphbzsKHbLdmchAXdJbvGf/h+Zj0SgtaHTIu+zEKEl8DDVQx1xsYHOuc2/Jp5m+U4ecjID/pr4IQLpiNo0O8d9xkZre0IDS6PtbGyxZHVQqoMXlsubyi1oxIafGGe7fW6XeRvyID/SF67SWXBMUb9IEHao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231360; c=relaxed/simple;
	bh=UyDPc+gxdK9OsPzrG+eHX6N4Xe7+bRkQ+DBNxqYhtIs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoZAvdraVgZCg7rQMNxN9KMOJnhbna3YPej1s38szROGmit0Mpy/JzWs+NirE53iijkblE6fgRyo+0hxQlJwT0FdRhMkyO9bSG1gO5znFeGbqQLz6QKB/Gylq9kJaa0xem3E7GZyWlDbMvKC4bT80v7MzJIou1X4FMKIKdur5WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ho4B9LHG; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ho4B9LHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/cJKDnT1bxakTUCBPOa+p/qodPOnUWBSB+HgxAi3KxpaJTBrMasiVlxzbd89ivEby0JjFFNxPTVNEKl/5Dk4teo2FS0lj5MKhRRtGirDDbJk1rb5HthMPYNDm7pvumvSO0m41PQW2ScD8ZOPaEzlUgOUzc0C6C1ozAfCjaFwshLsJ1h91zL+24Ww15Q9ew2+cGKugdvFJCkSoSZ68znVXcNP66uK1HwqOWo2EGrFPFWhptaPxOfArHjoo2QmKjMS7+2htanyuHYFErlher1dPyp3CCnhunF7cDRtoW0v9qZxuucIyp1lHZTokAdYL8o+xUii+c/Qni3EG6fWjHP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfn5ruVvqZD4+4VAETGpOirnnDrVfngDAqXGVoYihtU=;
 b=YTjl9fxDwafu8Gq9UG4qhQsBDmB7WbCqWL6GX9f3qutK8S8NPnENcz9nqJhUX8B8C7K8NkHaslnUzZ5AniOAO2jymuOnVyAtaB17w/tbI+2+bfnckR2QFKl42dImirnUC9e0rBy660ENECQ+D4nYp22jQEHLYTogdF0bJlMWoBe1ZLdhkVBeDLvp4zWe1koM5jhJk8dj+FtM6PgpvNRSjbZenY7yXZtHxS75CHs9g7bBBzqyQcChaODaU+E/Hb7mkBgHxyBc3Y4LCplIAoMx/QBIhtTm8eMInVKjPPATUthxnyFWp9mav9y9/9aV26C5PyvpRe9n2fGJT/DgvrKr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfn5ruVvqZD4+4VAETGpOirnnDrVfngDAqXGVoYihtU=;
 b=ho4B9LHGUnNR14KELNpXKxgVgS7zfTsxCrWoh/zflcmwIon5q4aNYwiuO8BRBbgeveEtydfg4tOJhnkEsLg9RC2LKHqxcJ6o9PlUuc/HskPcn4mtV4ukQpIFwrUzW7YR5aP97Qf8UpONWmUQkHwe1N9z76JhLLVwK96ThIFY7ItSDc/GPJ8VS3PdM+wOXBz0lKbaMLqvIxMNGv3PJ7OpwTHooWZvCiPYdF7JgR47b400yB6h+8mpyEEm2M6zymyPsJzgaol25TluKTm96BdwxfnjAfu5hFRG3CllHhpHlOr1gjrMOKikuGzx4BEzEY1RgxQpUF+zeiReTIXRlgLvHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21)
 by DU0PR10MB5994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 08:15:51 +0000
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9]) by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 08:15:51 +0000
Message-ID: <55c1a08a-6b1a-4d75-8a1b-2df85bebcbe1@siemens.com>
Date: Tue, 12 Mar 2024 09:15:49 +0100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] testsuite/smokey/gdb: Fix race-condition
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
 <663887db-5cfb-4a5e-bf29-ce2c2ccf1093@siemens.com>
From: "Scheler, Fabian (T CED SES-DE)" <Fabian.Scheler@siemens.com>
In-Reply-To: <663887db-5cfb-4a5e-bf29-ce2c2ccf1093@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c3::21)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7672:EE_|DU0PR10MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 666d69d3-609c-4961-a203-08dc426ca156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hoH2eM+uv8Snp326hOGArHsaw4YD35IgBsLlKrp2Xkg9DqCIHC5QJF4XA9rE7Jv5ZaVq35OFx8A+AwvfXvJNcgpbAXfxpp85F+dy7OiekCQleM2j59h4IhFuqQDQ3d2cQEziVeimRGA3IZWN1RINs+44jvUFxb9BKls4HnGURqrGlaFRhj5ONKgKcxxyJDiPe59Q1J853HAJvZEaO8JYpQN24qXcsiZCgIpFLwoLae3G6z6XIQXc7eGWdozk84SrMEEwAZQd6kntapPyw2n2RqkC1cVhi8VfKi5oNvF0TNQVSdK17b7WGg7dQrbzyc4Efy0LYzF2ecBS1LiUmYGLBpJ824DqBF5QQ9P/dCt07gE2VIJNPBb+n8fjFncHTRiqLxngjF6l6CkryZ9ACHBGtCeqgir+NOJzsavMDwplcbSY/b/5w42tJO12Mkff6ZuzG8dpTeF2ZbkDEN+kBvZFZBcAmvgKWjNJFfOIIBOoRgjMGd9O2NJDcT6V7AShWZUnd3DXa9WCUxiEoxdLdPLwmeHRVzY5ZF1GfyzdpkWhbuH8TBjJxkOa9xE1iMz8DrrGik9XkXyTrttpW6lycC7k04upiGN+ibGsvm0PGoVSzkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHZwUFV4NnI1ZmFIZHpKWDBSWU9wWTM2am1zVlV5bXNVaHRyQlRxTGdBSjlS?=
 =?utf-8?B?U1QvWjBiaDhXdDFyWlBUeS9KeDVBNUN6eHoyVlF2YXcwLytNcXFYeXNCanAw?=
 =?utf-8?B?YlJrVk1RQmlaSzA4STZxNmN4WmtMNjA2S0dMaGtDUExLVFRPNWxiSjdUYlly?=
 =?utf-8?B?V0FXbVJUb0swUXpHbFpxT3Vqb3c3bkhSWHFXSCtRbDhsK0FOREpxcjNyemJI?=
 =?utf-8?B?ejhaUkk4eEJlWXk5NWRoQkUzMFVKMkJ0eGRhM1NYbXJDMVM3VWRKSGQwZVdE?=
 =?utf-8?B?YmF4YWlRcENxRk1SbUtuSVNaMGl1YWU5YW9iOGoyM21ObldSY2w4SzZ0TDJZ?=
 =?utf-8?B?R09SSmIzZnNDVUNUNW9ZdEpHb3I4MFg2S0lkbGlDZ1Y4VVZBbUV0ZDBVdEFp?=
 =?utf-8?B?a0hoTEEweS8rcFo0VnpMYW5uU3NqbmxISkNsUUpNbU1yc2dobmNPUWJjVDd5?=
 =?utf-8?B?aEY1b2RUeGZxeDdpMGcrcFpFVDlQandaTXRhalEzZjc4enhoR2FQb1BubG1P?=
 =?utf-8?B?eGlMTmsxd1hmWVkxZVNKMm9qam94T3l6ZEwzNE5tQ0VIeStGNW5KRURKNXFo?=
 =?utf-8?B?ODVaTU51aDZydXZKOHd0UTFPM3UwZ1Foc3JWVkxGUlZ0dkFRUDRRbUFtKzBG?=
 =?utf-8?B?b2w5K2YvcjMzODRPelRiOGpaS1dBM0I4SFZqQnY0em5COVVnYWRwQVMrNU1s?=
 =?utf-8?B?NkJTUDk0QmpjU0E4M0prQ3FjNk9pNEw3OGZ5VERWaHlaMlRRZmpiSEhqNGI5?=
 =?utf-8?B?QVdDbERhTEpITldSdWpKMTlBN1hGV1NaYUxsOXNyZm42eU53L1JjY2RmcG0w?=
 =?utf-8?B?YWt4RTNxR1plUUVTOGVjMDJ5Mzg4b3NJY2FVNkp0YkY1WmZhT29UdEM2WElZ?=
 =?utf-8?B?dzhzSGVQZkFtczVNckFNRDRXeWpubDhCZjNMa1hXdzFicThCaitmNllEOTlF?=
 =?utf-8?B?ZTViSlkvUEo4UmNZVU1BMUhMeGJUa1g3cnQvMEUxYU44RmU2WVVtQ01hNjdy?=
 =?utf-8?B?bXp4VG9uWWVoTkNLT05ucWNrWGJTSm5YYjE4bzNEVmxXOVdya0RHM2dxNk1k?=
 =?utf-8?B?V3FTT2JqaVR3TFhwcFFrYlZlZ2h1cEJrcFNWMnViYUFvWFJlN0lGQUQzNTJ2?=
 =?utf-8?B?NjdEb1B3SFM4TDRsK25UZEVHalY0OW9OQVBIUG14NDFQUWx5YWNteWl3eUNF?=
 =?utf-8?B?OFJFY1pFcmlkY0xEaFZ6WDNGYVBSdU5WSVVUZkhuSnoyRS9TdS9nSWwzZHo1?=
 =?utf-8?B?cTJyNFZYa2prcEtKNmNTNWpuUEtBeFJ6TkVwN01xb3ZPNGdsRTJCcWRzSkRr?=
 =?utf-8?B?TVVZYmdKaHgrU2hya0FUamJpT2JJVEVpclZndHpYVzNkTHd3SGN0b0FYR1lC?=
 =?utf-8?B?dW1XUkhFcEt3T2M5dEw2OTNNRUdaanBEM0UrbmVQS2NGTnpLMFJ3SGlSM2xF?=
 =?utf-8?B?R1doU2grZ21wWGlSZEJBd0RvWXFrM3F2YWpWRUdaSXRUOEdxS3ZMMmtWVVBa?=
 =?utf-8?B?OFVyT093TkJrRzZCelR2bWN0dUpOKzhCQmhpdnJ4WjJzb3VBVEFWTWtxRTl0?=
 =?utf-8?B?Q1V4V2V1ZjhYU0FBN1VBV0tjL20wSGlnaERxSDFRNTRneVpEQ3ZTZHRUNXJp?=
 =?utf-8?B?ZkoraWUzTWtublhEd0UyRzN3dStLcGpWSE5Sd2NNbmh0RlpSRVppRDZUVWNI?=
 =?utf-8?B?dUNTeG9yVnlaUm5DOWg2aVhmcHZqcDBXaE1MUGw2bkxDdjFERVZiSkYzM0xh?=
 =?utf-8?B?bUxuTEFJQWhpcXZ0UUJFYmR5KzVyS2ptK2krRlNLWk1lRlRVa3ZGVEdNSWFR?=
 =?utf-8?B?RTI1Tm0vakZLS0htNmZud1hZSE5DZGxtMEZ4dmVjbkJGUXFzY1psWkNCWUJ6?=
 =?utf-8?B?THJ3MkNZT1RJeGZzREpuVnJRVXpHaHVwTEJqOGpZMS90ajNRWGRUa1FsaVdz?=
 =?utf-8?B?VG12ZE4ydGFkUGNYcktQZmJDK1Z4VktMaS9STjJ2YTNGY2VJNUdFcEJDZE5V?=
 =?utf-8?B?ZGJidE9ZR2haK2NUci9jUnBtamdJUnRyWnZzVjBnQkgwc1gwSElhTzBaTUhj?=
 =?utf-8?B?VmJUZGdpQXdxMTFLMlhWWU5IeGZmcElDUTlCSXEyNWVicWlsTUlOdXpHeFkv?=
 =?utf-8?B?NGVkV0tod2hXTXFGRFZORGFVd3B0SkhmSnNLalB5UFRqYWFLVkxweFNPMjh2?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666d69d3-609c-4961-a203-08dc426ca156
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:15:51.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViWpCSefm4v4rnZdNYeaSkqczCrKBGqr+7gq5OaXJJdalHWlqO9EjkmV5CATJoOZv5VoaNBopqk7/vynLpgdvSgWwBmuk/KmZQQC1IUCiLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5994

Hi Jan,

Am 12.03.2024 um 08:49 schrieb Jan Kiszka:
> On 12.03.24 07:38, Fabian Scheler wrote:
>> When quitting gdb by sending the quit-command, gdb may actually finish before
>> the father-process calls pause. In that case the father-process would wait
>> endlessly.
>>
>> The fix now uses waitpid instead of pause to explicitly wait for the
>> child-process, in contrast to pause waitpid also handles child-processes that
>> already have been terminated.
>>
>> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
>> ---
>>   testsuite/smokey/gdb/gdb.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
>> index b09b78b4e..5e9e9d101 100644
>> --- a/testsuite/smokey/gdb/gdb.c
>> +++ b/testsuite/smokey/gdb/gdb.c
>> @@ -77,8 +77,7 @@ static void handle_sigchld(int signum)
>>   	wait(&status);
>>   	if (WEXITSTATUS(status) == ESRCH)
>>   		smokey_note("gdb: skipped (gdb not available)");
>> -	else
>> -		check("gdb execution", WEXITSTATUS(status), 0);
> 
> Why do we have to remove this?

it is not necessary to remove this, but the else-branch should not be 
hit anymore. On the other hand, hitting the else-path indicates an 
erroneous situation in the testcase, so it might make sense to replace 
independently of the child's status

check("gdb execution", WEXITSTATUS(status), 0);

with

check("gdb terminated unexpectedly", 0, 1);

>> +
>>   	child_terminated = 1;
>>   	close(pipe_out[0]);
>>   }
>> @@ -202,6 +201,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>>   	pthread_attr_t attr;
>>   	char run_param[32];
>>   	cpu_set_t cpu_set;
>> +	pid_t childpid;
>> +	int status;
>>   	int err;
>>   
>>   	smokey_parse_args(t, argc, argv);
>> @@ -257,7 +258,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>>   		err = pipe(pipe_out);
>>   		check_no_error("pipe_out", err);
>>   
>> -		switch (do_fork()) {
>> +		childpid = do_fork();
>> +		switch (childpid) {
>>   		case -1:
>>   			error(1, errno, "fork/vfork");
>>   
>> @@ -283,8 +285,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>>   
>>   		default:
>>   			wait_for_pattern("(gdb) ");
>> +
>> +			/* the signal handler only is used to skip the test if
>> +			   gdb is missing */
>>   			if (child_terminated)
>>   				break;
>> +                        else
> 
> Indention via spaces here.

Thanks!

Ciao
Fabian

> 
>> +				signal(SIGCHLD, SIG_DFL);
>> +
>>   			send_command("b breakpoint_target\n", 1);
>>   			send_command("r\n", 1);
>>   
>> @@ -301,13 +309,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>>   			eval_expression("thread_loops==expected_loops", "1");
>>   
>>   			send_command("q\n", 0);
>> -			pause();
>>   
>> -			if (!child_terminated) {
>> -				fprintf(stderr,
>> -					"FAILURE: gdb still running?!\n");
>> -				exit(1);
>> -			}
>> +			err = waitpid(childpid, &status, 0);
>> +			check("waitpid", err, childpid);
>> +			check("gdb execution", WEXITSTATUS(status), 0);
>> +			close(pipe_out[0]);
>>   		}
>>   
>>   		signal(SIGCHLD, SIG_DFL);
> 
> Nice catch!
> 
> Jan
> 

-- 
With best regards,
Dr. Fabian Scheler

Siemens AG
T CED EDC-DE
Hertha-Sponer-Weg 3
91058 Erlangen, Germany
Phone: +49 (1522) 1702973
Mobile: +49 (1522) 1702973
mailto:fabian.scheler@siemens.com
www.siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and 
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. 
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany; 
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB 
6684; WEEE-Reg.-No. DE 23691322


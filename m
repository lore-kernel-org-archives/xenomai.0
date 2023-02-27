Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D303659
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 06:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkKrhI2+DOAtUQl3s7Iy6oKzLcD0kG7PuycbEud4XWSsN7/mwsR8kftqK5qMW1TGaUN2EhSoeZ7eDnTurP6wCgdm3/wGRWNNF61TsgQZECQrw5vpo0MUz0yxB1Tt+1UhC6sLzk2F7niUl/pZlBBJyu8RMKdRBpS4ky2vohq26rRx5F3k52k4U5INXaV87oEvfrXa/EPdjhcPlmRPSGknNfY62eW7q1k5knzUf3wcVH4H4czzPcXsDfLoCAM35XdSsNt6XDnsX85EfHKYM+QSZy3VvBuMAO/VB4ZLU5mPaTmKFo1gAyK52MyOxgGh6UKAPWqMbVTRrUCnDiDkTVmfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QeeTx3BIHwV1yWE7G0o8eYTuNoOfWJ3SbR0Bn6Lb5o=;
 b=PF4mgLEYA8WTkqvBCy2oSeePoB7BS6M6RMU0NDmtIDDGXDKUnRljlLTjx3Gh+GXWIgBR+rRGjoBkgVQ2FtlyzeLEJGhE6jOxo9fq87Q8p0oCtBZOdQu2ykPH/eNuNq4KafOhkaMABjM/s9uwhabLxxtpTxUTayYXwgGhyOS+lqFJi07D3DAzGZDuCr3WRl136ZCiZjRjN2qOgvgB5EDyZFzHmUIVzuew01WAdfDi3VOKARi4xzFsbM2M5psCQT0XbRkmPPjgKHRWiR/OFSSwdPj6QXptd/WJIznNzkd2FDLdtS3iXT6MwVRPGd44kN8Z2iT4rM9xm444q4gt2U7R+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QeeTx3BIHwV1yWE7G0o8eYTuNoOfWJ3SbR0Bn6Lb5o=;
 b=Ok/HyR3GsMTa41k+WIBYZs1muDw1qPewjFuuakGRPqxTUxNV+NfbGWqiaqzvohzYydzMiD5CGra6LNi4MKkfbBYhaR7589mw+V1VVeqLXsnvYYU8oiHndZ0Ct2inAUsmJTa24TZGCRvZ3Xz/5fMxcocw6hu977mUPM/K4bezl3bEfXQJe9hkWpZEIf4E30tKoEmHTP5Lbv3c5YbkczjzJBfjixTfnuMBFLHWL62kPRQWoxR0ywKdF86Px+vwQJ9gjicCOPsig43gQrwsDp7hhuoCj7HfX3TvfDGgaBSnupRXH02VbSIJLkF7whZPKRsh4TG1kGz/yf8Hqywxgcu+RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 06:54:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:54:10 +0000
Message-ID: <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
Date: Mon, 27 Feb 2023 07:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
Content-Language: en-US
To: C Smith <csmithquestions@gmail.com>, xenomai@lists.linux.dev
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3780:EE_
X-MS-Office365-Filtering-Correlation-Id: e10f45fd-49cf-469a-83e1-08db188f6d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kPFRWH5f14Oz2Z9anZWmDgThCNLWnfw89lrD4lRoH7K0GwMqEyAMqvuPbPP5rijs12HAHbnEIzHPRi56MO7bPCk1oxZEzzVd7w244lbbxEJoNWIBBiNLrIvpwa6RNbgqDWi8Ip1U3lQU0aPiUqVNH9IHyj5fJVFCugu08lF12Mz+yl0JOt7FHINrgBOp06/qBxtKwTYQZCgQi9QXIqMtjbnO8svF0jmifmMa1CtN48zpRyw0YKCkffUPbfYQjUqv98cnrqP6EIGfPrNzqSQDDrWCLC6DJk6gWhk/1zQMJqfSVF9U5/m3quzUd3ZRBnhAI2WadEMrHMz18jEwPIMHUMPVM5AKo8fPWqn+qqkMp8SG/mhTVa/mQg7SL08qmuQziPHnd5VKYwgQ9H11rWgrYXjpl76mGglj3e2/d33G39pymJrNyQy/w13da7YMgHx2PcC8Ljh/ppL+Jr9wslXYB5ygfkkIFYNzQcYee9q+ThFh3/YNwRyI93Do+YO5DwuF8FzenxShTgSLUqs1Ddwz9FziDW7Md7Fg6SWFISQPSe6R9znLTCpCZnKOyrleZY+xYlYRunZCgPF6ZtRcXKtli5JU9tKOM1/9VAy2inA4Ae1Cm4n54WyatzboNT1juGcwhPBaUbkHC/LvY+wpRKHudShutbs6KjIKCuWssVQW5jPljtBr/gLd0k/kdQHuzjO5GV5tw7DoyCnoxZScmHxVAWtHF/m16i+cWSlzSopuc2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(316002)(82960400001)(2906002)(31686004)(36756003)(44832011)(5660300002)(8936002)(86362001)(31696002)(6512007)(6506007)(66946007)(186003)(26005)(66556008)(53546011)(38100700002)(66476007)(8676002)(41300700001)(2616005)(478600001)(83380400001)(966005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlNVQUpibTJsdVhoUTBFMUR0VFUvQlpoR3k4RHprOEwwZUtBa0RKc3hZWHA1?=
 =?utf-8?B?YXBCOFdta3o1Z2Zhc0RLclBRbkVpZU9nSHFIbENEYTI0MS9tOWhuN2JFWnA0?=
 =?utf-8?B?OWRLQkdhRG5BZm9adXRsanpjMm1KM2lqWDNuZ2JuK1FlaHBMSU0wb2xCWUFQ?=
 =?utf-8?B?ZVN2TFRtUW91dFJhdDBwNWNMYVlEaVYyV1ZYYmFWTktHSDFqTjNXLzVTRVor?=
 =?utf-8?B?UlQxVzNKVGZSbU1PeVROU0x0Yzc0MWRLTHd1Nm9zOXJQdU9rRmlaaHUrU1hK?=
 =?utf-8?B?ZUdWWGNydXNPTVhaNkkwUTBOQzBya1RuMFlzY3lWdHdHQzU2L28xSFdmdzM4?=
 =?utf-8?B?K1JSR21STGtNVEFidVdCR0orWDZQbzd5MjVDUkxiU0g2VHhEUFVlNno3cnR5?=
 =?utf-8?B?OHRuMU4xYVkyYmxqbXI5SkpVdlZIQlNpblVkdEtCd0M2NjBJZmJQV1Zhc1FV?=
 =?utf-8?B?dGdVeXlmZGJGeDl5VkI5dkE5cnViVUpZd0t0Nk1NeDVJK0xaVWVmOGpCdWJn?=
 =?utf-8?B?cCt0V3BEL3R3em5VMHNZbldaUUNRVmpJdmErODV4dDRTbzVpM2ZITEY0Ykgv?=
 =?utf-8?B?WUF5K3VGWFNkREgvMHRPdVZIRm5qOXEwNS9IQzl2ZlJvWmtHQ3hlVFhRWnBx?=
 =?utf-8?B?L3VTMDZGd1Z0bGUzeFlWaGRpemM2UDdZalo3VU5wS2RYWTZaRFlscFB5WHky?=
 =?utf-8?B?ckVEaFh2L05NSFFkcWo5VGI5MmVNNW5ua0lNVVlvMWFRdXRhTHBtYjl0KzJC?=
 =?utf-8?B?ZTBVUnZtRjRhQ1h4TjMrZjdwbW5nRVN4TFNuQnQ4N2c3ZVR0Y1N0OVdzczJT?=
 =?utf-8?B?VXA2R1RtMjM1YUhldDgxL2VGdFcrNDZIcncxa2Y4YU5RQTNvWUFoUGNvS2pK?=
 =?utf-8?B?UWV1QVZ6dld2NmlvanlPeGgyVWxHWjVhWmxPVmxGbW5OZHVTM3hiY2cvMmtZ?=
 =?utf-8?B?cGZHeitmc2Rkclh2a2JKTWlkRlhrQ2pGVk5abjVJbUx3WjJ0Q1VsRlEvTmRB?=
 =?utf-8?B?cmYxRmpJTDlnamtwV3BlcW9NTk95bG51RFJUSU9TS3Z3dTBBT0lsOXdPaFpk?=
 =?utf-8?B?bGFGQkt1bjVQeEdyaFdUOXM4ZW9kRmp3TlYrdlFxaHprZmI4SmNNM3dudUJV?=
 =?utf-8?B?blMvb0RFbWY0YWE5cWsvZ0ZQNGMrTVlSem9RQWQ1NGJXWU8rZmZ3bFptWmk0?=
 =?utf-8?B?VUF0a1AzaXRSMnVpRm5wcTJQbmdjZU04WVRYeGhVbHdBRVRtT1Fndk5kenlM?=
 =?utf-8?B?Qm9NdlJFcFhRbXBpZ3JtWm1sOU1nNlJsdWVGd1lYYzBRKzJyR2ZzcEpTTFdn?=
 =?utf-8?B?SkRtL3U0MnRIdEhycFNRY3B6K1Z6TUlDc21FRXZvT2M0MHdKR2lnWWpMV1pI?=
 =?utf-8?B?NEh2M1hMU0dtTjdJSXhibkNIY1NPNmpQUHFMR0tSU2hLcmJmWjFOcWxsMmNp?=
 =?utf-8?B?OXFtVVFCdG9FbFJlVVJHZlFlR3VGdnRPM3UrRTREajI1Yk9tcy9sSHRYY0g3?=
 =?utf-8?B?VUpJZTZpSFFxcXlYSHdIOTJBU3BSd0czVGtTS2VsbE9hbVpBUFVzYk9QekM4?=
 =?utf-8?B?MGwrUUV3a3RDd1ZMMzVCMzlhTkpzMCtTWGtoZGNQTUVLeTZua2tiVEwzR1J0?=
 =?utf-8?B?clhYclpxTGx2MUNFS0NRck5WUWMxMldIT3RQd2MrbVJQQkJaN2tUa3BRUlJp?=
 =?utf-8?B?WFJjc2pjbEhWNUxFZm53U3hhM05COUQ5YkdjT3pQNjBEOGNBZ3luUFM3M29Z?=
 =?utf-8?B?STlveUx5eWlzQlM2T0hpOGhBeXBkZG9qQlBiNlpHTGozNDhUcnZtSUNlS1Vz?=
 =?utf-8?B?S0NCSWVBdVpQL2hlSDFWeTIxRkZqZi9Mb3FxTVdlRVNjc0laVWxkWHJPSVpo?=
 =?utf-8?B?Nm9OSWk0bk9ham9LSzFCWWlsbzNCQVo1Q0JQc080YWpJSHd1bjdUUWcxN0cy?=
 =?utf-8?B?T09PTERNSmhBSC9ZTnRaK3pPUUlWNis4L2RGUXZzSGlxK29iYkdRVnZIb0lo?=
 =?utf-8?B?WWM2ZHhzVkN3V0xlbGVud0VrOG95Rjk1TS90YTNuN0NQWFBFdFBOS1F2QStu?=
 =?utf-8?B?WlNpcVFjUlJKbGxXaitmaXc2OUM1VVB2Y3JXcGFKaktDZ2VyZjZCSnZhQmZ1?=
 =?utf-8?B?aFV5TEsxMGVpYWc5V3FzZ3o0eU9yMk0rL3BqTmZFZmdIZmIvUGtZdWVMUWxB?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f45fd-49cf-469a-83e1-08db188f6d7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:54:10.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku/OBnpfsfE9OjHsIPr0i615wh+51FMs/Ixv0XSeMo7sltRKcXQb7S1qLL+uRB/uryAJQzA27/Y+3Coz9X6Rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3780

On 27.02.23 02:26, C Smith wrote:
> I am unable to compile xeno 3.2 after patching and booting kernel
> 5.4.228 successfully.
> 
> I had done: git checkout origin/stable/v3.2.x
> Kernel is patched like this:
> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
> --ipipe=../ipipe-core-5.4.228-x86-12.patch
> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
> are the configure options:
> ./configure --enable-smp --enable-registry --enable-debug=symbols
> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
> LDFLAGS=-m32 host_alias=i686-linux
> 

Not really:
https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624

But we don't think have the registry enabled. Maybe worth to change that
(debian/rules).

> The failure I got is as follows:
> ...Making all in regd
> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>  CC       regd.o
>  CC       fs-common.o
>  CC       fs-cobalt.o
>  CCLD     sysregd
> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
> `cobalt_lookup_vdso'
> collect2: error: ld returned 1 exit status
> 
> I got the same problem when trying to compile 64 bit, with:
> ./configure --enable-smp --enable-registry --enable-debug=symbols
> --enable-shared
> But I actually need to compile for a large suite of legacy 32 bit apps.
> 

Can't reproduces. What is your build environment (compiler versions,
host and target distro)? which revision of stable/v3.2.x are you
building (though I'm not aware of any related changes)?

Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
included in your case.

> I can send my kernel .config if you want it.

The kernel config plays no role here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


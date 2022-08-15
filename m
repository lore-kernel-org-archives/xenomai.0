Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F011102
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 07:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9ZUTkjLAHYkE5ww3sfJ/piR1ZqiLItvKsy7pJD4atfSO339OSt389Oe/PUVqympFkSEzXuSAq5LJs69FC2Myhaa41opLc4zhg/iQraRHikUnXRbJ3lrDw0OCx29W+Sqy4LUIeXzilSWRqq8gelUNxvvyotD/zpwoxjuednnhY7tStpEJntV4LjkaHzfdOKuNMx0UFOBHBKCX8V4vGl7hS2Ooe9eYAcMKT3tkQ5Ym9vey3jwCc3H371dmc5P5QE6ZS2qQ6xR8Jv7U2oOlYXxvVzX8iZ7HS7+1FdiCXMYoSAVmfAQwlIj52tJU0pm/bcf/Wd5RrdWJ7x0VrpownG09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpyQ/rPKMs4M8d9k8Znk5TBRgMrvKkkaBaV4dh1rWH8=;
 b=fIWmo6VlUYHXbbCue0hxvg9lfoHD1zu0x0Q//SGmpMlruuC34dj7gN3y/QrFxeZw7X2fbD/8wemEOTZOyax0iNxBkMblRbOd8zt9/AwQ0vOVh8KUBa3TD0/Smd3Rh4H0IkNM+bJPa4UVHJ5iJpaNN5L6fvodpWOaAm7TiqUYTxdDflgfuMIEdbzcCTVQDfuHz1ZZaMfAjQIXkWqpyhmCZCWJ4HpsLQqgo/DiFJ3TKRrIOVAlHXZ44XabgrAJ9cqpk8Z17M9N4OImmhAX7DLk6qarRQmV5cPbTh/B7vbV/2uwgEwkqyMeNPL4t8nvb7Ckv0EYTJF7u0dHiixLlnElUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpyQ/rPKMs4M8d9k8Znk5TBRgMrvKkkaBaV4dh1rWH8=;
 b=swl/xWMat4OuStVaM1SyNRIvJTmkIDZ+iB1qeXPPEbjseviV89pon++KY/bmTXNO6wU3pfnUQNJ+oF3mXw7d+zlC4Y3sFTFqMQTCjHS/FvYYanORIeOVe7ERpPyyEfyXsF1bNKrK/3Y8DTiPNZwpjaNqu+Frarbdxp1GbtX101NRSNuhejCpK/nhfSIyr2q2+x9DbKOIoEvkUmwsUnKxBHuQXLVqrQflGtYZMvFWeDrdmPnlBor5ShHIdU4sFrlpbHRzp/n7q0le4KcgW2Fo++pxQR0KlEKas77aOaAjvjSogyk5NhqSej/vSKF68yVEYQLKt+eGZLTTEb4lGXsWRw==
Received: from DB6PR0601CA0014.eurprd06.prod.outlook.com (2603:10a6:4:7b::24)
 by AM9PR10MB4214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 07:00:34 +0000
Received: from DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::c0) by DB6PR0601CA0014.outlook.office365.com
 (2603:10a6:4:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 15 Aug 2022 07:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT087.mail.protection.outlook.com (10.152.5.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 07:00:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 15 Aug 2022 09:00:32 +0200
Received: from [167.87.45.91] (167.87.45.91) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 15 Aug
 2022 09:00:32 +0200
Message-ID: <78184c9d-83bf-b75a-4b55-15d894cc24a3@siemens.com>
Date: Mon, 15 Aug 2022 10:00:30 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 00/42] y2038: Allow building and running somkey with
 y2038 support enabled
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.45.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--23.754600-8.000000
X-TMASE-MatchedRID: ytok2O4LhVs5QaOxwNGfvo9bHfxDWoibx/Z5eXpUUhQD2WXLXdz+AQ73
	P4/aDCIFGxbFDAEoIooAwlwc7PMO4+8+tYH+bsNfo1iPgKgiLB17rjItHwarhR3EEAbn+GRbT5y
	sQDj6eFlYC5LPd7BvbR6q6HJi0bIInjUGEK70lFOiAETbARUxfhaWO4rB/YQ8ttAWxuM5sl7YUD
	vAr2Y/186RYIECOWSq6i57CzM1bRvtRdaYkrITB7xOw796cWi96ng+QM4KwJQtMfCdg6KRDY5A6
	wTicMJ0zulpDGRdyOYjGAiCSC841CltdLRpYJkGA71GV1rRunGMtwEagfW7G6iUivh0j2Pvp5HL
	LTy++LOLeLYcBsV39yACYtpe6t5bq4lZXyR8DnjozSz5BEVDr9FMBnmJRh/JC8FMH3T6F74V8rV
	6fVLsBHxz6Ei4ZX4xWOWLMlqL93tXG1puYu9iTWQa9V+7S6z5OgFKp4GU2qgtep5gtv80qqn/3n
	yhTdZwj1UOAOjhpZHQAhvnsK0MAyYKdnTbtpdrB/iW/INxnLznog8SXCuTCZMIKPXbrloXWNbBp
	Q++I1nM/0sSqPZieHrCxgfs+1d8d6F5USj4uT3gxbc0qkj4UYn76yGQcyuFiH95tLFH8ecXw5Hb
	3/XOHQkVOSlHtMObtFb3GVdOCmlJK2gV4PFM9gYdrsbAIOcl/Tb1X0NT+CqdVNZaI2n6/wiuJhI
	TDnyhHTMj5a5/7iYgdJS38LsCnPobDz0cFNgwQ6A5rv8EiAEkVMQcdgU2qZr5ykm9NtIc4/qn72
	YRaUKDjc5a5YrawGQHMMo0zV6pOoVDnE6J6/SRk6XtYogiau9c69BWUTGwVnRXm1iHN1bEQdG7H
	66TyKsQd9qPXhnJ/4rWvpj9UcgD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.754600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 900EBDA8192DA0ADD518C502A247DFC7B25ED56C6A8CDED44496DDE8633B3BDD2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50a498db-d871-4cd7-55ce-08da7e8bd8f5
X-MS-TrafficTypeDiagnostic: AM9PR10MB4214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnZKdDQ4cDRBQW5SWEt5QjAxUTFTTm5xWGVLbysyazNVUUZMV0FvZXQwUkFR?=
 =?utf-8?B?cmdVNm5SeXU4cE8yaWQ1Wmo5cVlhQTBxbktUTmIwM1dVN3haNjRBZzlkYmph?=
 =?utf-8?B?aE04bG81RXBablhhaDlrU05xZVVSUXhOV0lvWGIzUHA2dHd2NzdpZGZEK2x2?=
 =?utf-8?B?cjFjTjIrdGR5aVVmNDhmQnRuZlZ0OGFJRXFIOWplTXA2a1BpNm1ySGlBZzlz?=
 =?utf-8?B?dlVuQ0wzNHo0eTROWHNBWkIwQzgrT2tkMWpNaEFwdml3cC9SV1pFM2E4THQv?=
 =?utf-8?B?Znh3Y0dtVHQ3ODRrSWlrUkNPeUlkaHFBMmNZbmJ0TEhVc2hzNjlHdG5DaFZw?=
 =?utf-8?B?S3E3N3h4YjhqOFNwVFBod0ZUQjNqdHkrMEhnV2JCSlRWYlNIZWJGS0V4ZjIz?=
 =?utf-8?B?eG82NEFXUjlUdXl1OXFvZEI0ZHExWUU2N0Nhbzl6d3o5Nlh4cWVDNmkrR3o4?=
 =?utf-8?B?d0xLbDlmaVROQ3gvS3ZManZJZ1RFaGNZQ0o2c2NjcTdLYVVrdlVvbEZIaUEw?=
 =?utf-8?B?RjdqR2RmSWtnWWI4aHZaa0FUM3IwT2NiRW93OHRreVMxUm40VE1LeWFvY0NH?=
 =?utf-8?B?ekdKNjVEQit6KzB3NVhXMHhIdGpNQmdjMXVrUDdlcTQ2bkx1RmpFZ00xV2Zj?=
 =?utf-8?B?TE1IYWZnMGV3TDRIWEhqN21oWnZIMVQ0YkkyZ1B0TXZsSWdCNkZjdGtpLzhu?=
 =?utf-8?B?VnlteSsxNjg3TjFaU3dCSmowZGlTclFaT3EwaTFMVHhkdktBSFNjLytOZFVm?=
 =?utf-8?B?K1hEaHRuZTNVckdOTVUyNEdOMUZEYUFGQlZWbDcyN3lJbGxjZWhma0R1Q0tR?=
 =?utf-8?B?d3ZYRHdMV2VJQ0FnVEhTZldkdS90U25Ua1N0bnRLMmtTdG1ER2U1aHY2akhM?=
 =?utf-8?B?Y3pMYVlaNXorcUhLNzZWUDhLWkQ3aS9mRjBUR25RNldqMEJJUWpsQ3FFSmdM?=
 =?utf-8?B?bC9lVExSWUs5VGNBNXNFYWMzSDVTeHppVTFQNVBiU2ZjcHYxcmszc1k3Ulp2?=
 =?utf-8?B?THRaRVdGZ0hHUVlqaS9SR3F3bWNYUlVrMldBL1l1LzZXSjJTeTlLRUIxOUlY?=
 =?utf-8?B?S3dFdm81a3AwNDhSU1ROVElWS21FUGxlR0I4bytvaHd1SjlJYTQxM3NQR3VH?=
 =?utf-8?B?bmt6NVBId1dnZzhrWkFkVnVRZUdZOHQ5RXdVbWhlSTAxblN0VHM3R3g3QUJh?=
 =?utf-8?B?NnN0eU11SEprY2RMSWpDQ2lTK2I5dVowT2lCc0RXZkhzZ296RE9vSzBMdnhC?=
 =?utf-8?B?NHEvL0FIRXczNFJJZUxPa0lSNjZJTzBYVjZvZiswTTRjZTJHUT09?=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(186003)(86362001)(31696002)(34070700002)(31686004)(36756003)(36860700001)(53546011)(82740400003)(16526019)(47076005)(2616005)(83380400001)(82960400001)(356005)(956004)(336012)(81166007)(26005)(316002)(478600001)(6706004)(16576012)(966005)(41300700001)(44832011)(8936002)(110136005)(8676002)(2906002)(5660300002)(40460700003)(70206006)(40480700001)(82310400005)(70586007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 07:00:33.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a498db-d871-4cd7-55ce-08da7e8bd8f5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4214

On 09.08.22 16:42, Florian Bezdeka wrote:
> Hi all,
> 
> it has been a while... I made some progress regarding y2038 support in
> Xenomai:
> 
> With that series applied I'm able to build and run Xenomai including
> smokey testsuite without any test failures or skipped tests with y2038
> support enabled!

Smokey or somkey? ;)

> 
> Preconditions:
> --------------
>  - glibc: You're glibc has to provide y2038 support.
>    glibc >= 2.34 has that.
>  
>  - Xenomai: There is a new --enable-y2038 option to enable y2038
>    support. This option is off per default to keep things disabled for
>    now and avoid breaking any existing application.
> 
>    When --enable-y2038 is supplied all userspace parts (libcobalt,
>    smokey, ...) will be compiled with y2038 support if glibc supports
>    that. If there is no support in glibc the option will be ignored.

I think we should at least warn during configure of y2038 is available
via the libc but not enabled by the user - to slowly push people towards
migration.

> 
> Structure of this series:
> -------------------------
> We start with some cleanups and drive-by fixes followed by adding the 
> missing timer and timerfd support. Finally it cares about select() and 
> some drivers (ioctls) that were missing compat and/or y2038 support.
> 
>   Patches  1-12: Cleanup some compat code. As long as there is no
>                  difference between the compat and native syscall entry we 
>                  do not have to declare them again. The syscall machinery
>                  will care about that by placing the native entry point
>                  at the compat offset into the syscall table again.

These cases aren't test-covered yet at that point, right? Can we ensure
that first?

And what's 13/14 about? Something to pull to the front?

> 
>   Patches 15-17: Add gcc 12 support, drive by fixes

Those look like early options as well. Or do they depends on anything in
1-12?

> 
>   Patches 18-34: Add y2038 support to timer and timerfd APIs.
> 
>   Patches 34-37: Add y2038 support to select()
>                  There is no y2038 safe select() out there. Modern
>                  applications should switch to modern APIs like pselect().
>                  
>                  Implementing pselect() was not easy:
>                    - We have no support for waiting for signals and fds
>                      at the same time inside the xnsynch infrastructure
>                    - We already reached the maximum number of syscall
>                      parameters
>                  Solution taken: Implement pselect64() without the
>                  sigmask parameter. We do not wrap pselect() in 
>                  userspace and only use it for select() where the sigmask
>                  would be NULL anyhow. So no additional pselect() in our
>                  API but select() is now y2038 safe.

So, regular Linux/POSIX application will use pselect when looking for a
2038-safe API, but Xenomai applications will continue to write "select"?

> 
>   Patch 38:      Switch VDSO to __vdso_clock_gettime64 in case y2038
>                  support was requested.
> 
>   Patches 39-41: Enable/Fix compat support for drivers covered by the
>                  smokey testsuite.

Shouldn't we pull that to the front to enable compat testing before
fiddling with it?

> 
>   Patch 42:      Add/Enable all additional glibc wrappers necessary for
>                  building with y2038 support enabled.
> 
> 
> Testing:
> --------
> I used Xenomai images for testing but had to switch the distribution
> from Debian to Ubuntu. There is no Debian version yet that ships an
> adequate glibc version.
> 
> Switching the distribution was not that easy. Ubuntu packages are now
> compressed using xz which is not yet supported by the Debian package
> manager. You have to prepare your host environment (kas, kas-container)
> accordingly. 
> 
> As Ubuntu ships a newer python version some ISAR patching was necessary
> as well. If someone is interested in such changes: Let me know.
> 
> Open topics:
> ------------
>   - Testing: Integration of compat tests to CI (not really a y2038 topic)
>              See https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21

See above: I think this should be done first. Then we could also split
the series along
 - drive-by fixes
 - compat testing, then cleanups
 - 2038 finishing and testing

>  
>   - Testing: Once compat tests are enabled, try to enable y2038 support
>             
>   - TCP:     The rt_tcp driver does not have compat support yet and is not
>              covered by the smokey testsuite

Maybe open an issue for that to track it. We have some users of that,
though possibly only very few.

> 
>   - y2038:   Re-visit some y2038 related syscalls like
>                - sc_cobalt_thread_setschedparam_ex
>                - sc_cobalt_thread_getschedparam_ex
>              There is a struct timespec deeply nested in the API.
>              Seems not covered by smokey.
> 
> If someone is interested in helping in those topics: Let us/me know!
> 
> With that: Happy reviewing! 
> 
> The xenomai CI was regularly triggered. I do not expect any build or
> testing issues.
> 

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

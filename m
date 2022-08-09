Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C74428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlBGUgPxjONNOTG3pgKYhz98x/xfCNVXxI+wNwJOMVd/tlFz/mgPwbZJewQ8YFQ9qzvco4RBazRFpTi5w5KxKhBHEZRRGlgryOnQ3P6ZqzhPIOu4pbV8ZMsyK0q04mXvYFlEf7bLzdEQ1z5sFJOS9n8GUvohht7XMNMtHVdWGXP3HeV679T+rxf+oLpxtpyZvGHdDv9jkKi+ttXBTuL5whSZ6+CUGXY/AE5qQsDQBSyeLOb6JknMVLe/XE50oKJMm/a+ze6LnHPUC4dakE3moyQJY/uYLeIYJsqcTT34IL8sFsz7qw1cGigbfh4ZVKTfUxd+HqJbfMRnaCKiIh+IWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAZ957Xp5M6MrjygRJO/Emhyw8TYIMdhZbaWeq2ymVw=;
 b=JNrD0XqJfn39/TWZ4RHfJoFvvdHnQpNkpoKz8yY+zgpKHCOXxaaSmqBDmvGdA3i9mPEDtBgsO6e6J2KnOoQGKM+4vPm9McRjB35Ss76whlusUevg65GTX8waAJ/cfV78sEhHNGt8O6n3q4ApEQMJXMnFkcK+X4Kfjl/7VvAk+MWE37SF3tTH8Pa4rNOvPzUKyYZxKYmqfjsGB8tYgLT8Ccc3hGjN6+NBlwmLGVzYuCdfjuzO9kpnz3yipS0/FPVJd/l9CWzmePYphZIlQmpIusiG+VnJAfOs/N82NT+F1/7PVTp/+KEwk3bovwkJXii0GkDNMYf6KGY56YjGoTpTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAZ957Xp5M6MrjygRJO/Emhyw8TYIMdhZbaWeq2ymVw=;
 b=ec/UylWfBey+UNIwgY5n5d8R/9/9j+xHmZeT/EpMBH5+1jlihjkPYm4msCXW+cmKqoTlh94wLUnPwBdIvLHStF/EhCipi6KbHASppa0ClrtV1155bTUyuRdIFrBHKHbyfDBPOT4q7qQ81nZ2HaWeDvNE+XmCN/TGqghyKe/BhgytpoXa4XTOsp4DwuauyKpbLZF0dufanNyg/pfY3NdIWVxa4JbfEBMvdZwGrbGeL+pAZKNX51bHzO8dp8dC0fKNaPXuokIgM4RHSt2o1Pm3gX49c3E8kz9krvZS1B3xzlbICrVBhuj8P00NIH2Z4+43qn58UPelNSd/mOKC+/ykfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:43 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:43 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 00/42] y2038: Allow building and running somkey with y2038 support enabled 
Date: Tue,  9 Aug 2022 15:42:44 +0200
Message-Id: <20220809134326.23688-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0461.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::12) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71abe3f8-7c26-4d30-153b-08da7a0d2cce
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	es2hC5xOsHFW4UcEWor1vRw/YpUn/lRFOKY2NH4YvPAnOWTFTkysSFrm4ZZAjxNTgna6oMBaksfjt8dLmCvp8mzhencIog6AnHjA0j4ZXcRT9n3C+aDvzbyd8CyLk+s2j4BCPCguXGPsNsp+OG/A7KctU2tdsYo7IewhqLBKW5amLhpBjEX3QhkJIdg+MD/v4fOF5Wh8lpsLeKVmZ+JLBUYlslvLuNrbP6ngSvzfgZe6mmy81NGG46ks4v2G5xNbEMIJduYyMWExRMf3TpJCDOvBtRQE+nYdf/K3xKmyZ6dz0zcPAT1Vo4dO3D1afBegKcEjNtf/pek7REBHna4SBcIGLf68i/bfqrRMAJ5WKPuPOlQif5e/yEus1Doz9oIYqXhV/3FE9maANZcEF9WAzTlOjFzWxyFbUmaaysDUL7ZBkPVkAs8eJVnPYJIn67qOJOjM5vujbIIYQ2jScDB27PiU4/EqXXZ8Uw/V9rsi7r93dwMV5GUgfmSLeRuAauIBojBZpk7HxgCCmPSDfpOj7WVUrFbep7yPEVPwsCyAV1SCoOPWL2ZD72FJxQmQJ8m+PhA2lywygBByOsvurXroyzydSDvkdiIzygDyARUG3Y5tqDVWNjh7EhGxZshOcG9+35H1acCtyhiF7fs/6PJcx+hHCkUufEBfS5PoL+X0XpRQQtONVTyJqUmovwJmutvEIU9KQxWlCGkVBh/m9b8azegmPdNi3yK0pp70CoRIjFE6Dk9uRmBHaYNtPQFnRlwAFHnJDW6nO3N/CmgE3WqXpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(966005)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(4743002)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWhCR01HNDdnRFlQc3B6TFhvVUJta040MHN2Y0xrSnBvSmtkdjJqVjZabGM2?=
 =?utf-8?B?RkNDeTd6Y2pXVXp5aG93dlY5ZjB5cERTcDZBcEE2L05PZUVLUG45b3lGZk1r?=
 =?utf-8?B?S0VkRHo0SmFHT2V4bDFubzBJL2tLYmw5cHFGT1QzTE1ld1RCTnNFOU5lV0xX?=
 =?utf-8?B?cjVmcGc1L0JjbS95d01pSWt4aDFNMTQwS0NObHB3bHR3dzJvK21IRFZXbkZH?=
 =?utf-8?B?dVpxeDMzMnlYUkZ4R0dYMkxzUEhHckRuNHhaVlRXdFY2ckU0eUdVM0VqUWVC?=
 =?utf-8?B?Zmx0cUJQanN2WE43dk5VZysrZXFRQ3pDT2hoa0FnRlNzNHNhU1VvaHlQZzg0?=
 =?utf-8?B?dVAzdVB3MktEVTN0ZVdWem5mYnlGV2p3enhXUVJwTHBxZXdFNFVZTUZpR3F3?=
 =?utf-8?B?RnA4MU83OHMvK0VNVCs1Q1NVY015aUJGV2trSFgzNXIyR3Y1aGlRTFhjbjRm?=
 =?utf-8?B?Vm5SUDFmdDZGWlhibDdqWUMzQWZKRXhubktWVkFPK1Fnd0NibVJpYmhXcGh5?=
 =?utf-8?B?S3hJUXhqaU9OaWVOT1VxU2t0c01DempWQlhIaHZiN0VQSXc2SjJSY29NN1V3?=
 =?utf-8?B?bGQ3U3N6SFgrT1VHalVCQmpCbzZXTVpKZkxjWmVkeWN0K1NvZy91dW80R3Zk?=
 =?utf-8?B?Nzk2M29GWjh4TXBnYytCeEJUemRVcTkrN1NiakoxSDBjQUxLa0dpbFBCVXh0?=
 =?utf-8?B?VGUvWm9EU3p2dmNjZ1Y2VVFla3EzZm9XcWRNNkJ0QTYzOHY4SWdLQkF2ay96?=
 =?utf-8?B?bDZVZ1hxYVpXdjJlL3E3TTBjTjRMbnQydVFzYUZUK2NnQ3F4b2hNdWRCVkhX?=
 =?utf-8?B?ZnF6RlR0T1Fqb0JDcWFwcVVxOHZOUEdJMytQWXg1V2VXT1FCWUZVRFBkcWxo?=
 =?utf-8?B?cjdSU29NVmNPN2wwVmgyYmtPZXpMRjZOYWVWQWlROWtuMlBSM1RycGZPTUJX?=
 =?utf-8?B?UEI4TURBdHdFV1A0Zjl4YVN5RkJ4OHZGcXlsY3hEZkJxZ2tDazU2TXlYUytt?=
 =?utf-8?B?bVNBN01aYlVUdjlzRnBpeDhLY1E3aDlTeFcyV1QreWpDTXNnekE0SDFUUkdQ?=
 =?utf-8?B?bWZCV0VrZHE3dHozVGN2dlMwOWNxTmxlWGZmS2VnMldhMlhWelErb2FsZE5C?=
 =?utf-8?B?Q0NIaTF3RGpsa1pFR2hkcXVseDdwNGFXc0E5NUJZY1hkRXdGTFNHa1pXclBo?=
 =?utf-8?B?ZXY0NGFScDNOUkttMWVvWWQ0TlFXU0V0Z1NEbWx4V1ExNHIvRTBiK0ZtL29F?=
 =?utf-8?B?dWZBWGpONWdkQ0VnOUpKMHYyVVBkbythdTVjZnVkRG1VcEJtWnEvN1lHVVcy?=
 =?utf-8?B?bWRCNlgxRlVMQnJPSGs2Qjh1MkZWcnZnRnBNMnhhVWxUZVpKejBZN1ByZXB4?=
 =?utf-8?B?Q3d0TlNaRXI2WEs2UndqL3ExK2tWYTAwN0g2NGEzem4yQk8yVUt3QUErelZv?=
 =?utf-8?B?cTcrd3c4LzFTaFpOODlZWWJJekFxMHlUUEJ5d2J3QXQzaW9pSUh2UjMrQkF5?=
 =?utf-8?B?RkFhZndRUkJDb3BrMVlhc1U0T3RsaU5sQ0VWVDgwSGcrVkhPUVVLcGtZUEtq?=
 =?utf-8?B?dmF3cHN3WU5ESVpFRksrd1Z2bDA1UUJzOEluRVJXYWtvdHljUEtGY3FWOFIy?=
 =?utf-8?B?L2dLRExDc3BubStPcnhLQVRGTWpaaWhjSlkvZEdhRHM3UFhPbHg0aFBmVzV4?=
 =?utf-8?B?NTl5TTFYSTlIZmtUa3lGV0Vyb2ZVUnQ1NFRFdE90bG9McldmYTE1dTJlS1Nw?=
 =?utf-8?B?dFlLRElydWZNckhBTjBXQk9CMEtJT1pNck5LYnhYbUE0QXZLZk1DOEhtMjBm?=
 =?utf-8?B?clo0cW9WbGx4aDhWRG4rNUo0K3ZqWTBsNk9HelRxTmkyaE9UQXFhZ2RlbXN3?=
 =?utf-8?B?eUQyWkVMaHNEUVFwU3drZ2ZnenJweTFQRSsreDBIYTd4RWhnZGZVYlpLbk9X?=
 =?utf-8?B?UUkxNzVpdHJWbGFzcGxtWVBZalVPYTRPWGlZNXM1ZEZ3emVSR1ZxUEtHRStN?=
 =?utf-8?B?dDdOelR3eVdwenZld1pHQXVPd2Y2Z3g5b2FFWDlZb0VTVW45QXNuS3hrL3Jp?=
 =?utf-8?B?em1Fak5sRVhHU29BWmtpT08rdFU4TTNKb0dmc09QMVVJY3Nkc2dubFhGRHhw?=
 =?utf-8?B?MWhpajluR0RRRHVvL2dUT0RNQU42Wi9kcVhCSnRQd1hhdlFQNWd2M3hYQmRY?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71abe3f8-7c26-4d30-153b-08da7a0d2cce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:43.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O37owwdujFR03ICPyr/O5HNrBEt+PMP8hFiTI0L/eMa9cO/vmRm6i4ddDzgkjiHM7+iFsUOaJAAtyf6XctZ889vcH5zICvx2qLmZqsuUaVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

Hi all,

it has been a while... I made some progress regarding y2038 support in
Xenomai:

With that series applied I'm able to build and run Xenomai including
smokey testsuite without any test failures or skipped tests with y2038
support enabled!

Preconditions:
--------------
 - glibc: You're glibc has to provide y2038 support.
   glibc >= 2.34 has that.
 
 - Xenomai: There is a new --enable-y2038 option to enable y2038
   support. This option is off per default to keep things disabled for
   now and avoid breaking any existing application.

   When --enable-y2038 is supplied all userspace parts (libcobalt,
   smokey, ...) will be compiled with y2038 support if glibc supports
   that. If there is no support in glibc the option will be ignored.

Structure of this series:
-------------------------
We start with some cleanups and drive-by fixes followed by adding the 
missing timer and timerfd support. Finally it cares about select() and 
some drivers (ioctls) that were missing compat and/or y2038 support.

  Patches  1-12: Cleanup some compat code. As long as there is no
                 difference between the compat and native syscall entry we 
                 do not have to declare them again. The syscall machinery
                 will care about that by placing the native entry point
                 at the compat offset into the syscall table again.

  Patches 15-17: Add gcc 12 support, drive by fixes

  Patches 18-34: Add y2038 support to timer and timerfd APIs.

  Patches 34-37: Add y2038 support to select()
                 There is no y2038 safe select() out there. Modern
                 applications should switch to modern APIs like pselect().
                 
                 Implementing pselect() was not easy:
                   - We have no support for waiting for signals and fds
                     at the same time inside the xnsynch infrastructure
                   - We already reached the maximum number of syscall
                     parameters
                 Solution taken: Implement pselect64() without the
                 sigmask parameter. We do not wrap pselect() in 
                 userspace and only use it for select() where the sigmask
                 would be NULL anyhow. So no additional pselect() in our
                 API but select() is now y2038 safe.

  Patch 38:      Switch VDSO to __vdso_clock_gettime64 in case y2038
                 support was requested.

  Patches 39-41: Enable/Fix compat support for drivers covered by the
                 smokey testsuite.

  Patch 42:      Add/Enable all additional glibc wrappers necessary for
                 building with y2038 support enabled.


Testing:
--------
I used Xenomai images for testing but had to switch the distribution
from Debian to Ubuntu. There is no Debian version yet that ships an
adequate glibc version.

Switching the distribution was not that easy. Ubuntu packages are now
compressed using xz which is not yet supported by the Debian package
manager. You have to prepare your host environment (kas, kas-container)
accordingly. 

As Ubuntu ships a newer python version some ISAR patching was necessary
as well. If someone is interested in such changes: Let me know.

Open topics:
------------
  - Testing: Integration of compat tests to CI (not really a y2038 topic)
             See https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
 
  - Testing: Once compat tests are enabled, try to enable y2038 support
            
  - TCP:     The rt_tcp driver does not have compat support yet and is not
             covered by the smokey testsuite

  - y2038:   Re-visit some y2038 related syscalls like
               - sc_cobalt_thread_setschedparam_ex
               - sc_cobalt_thread_getschedparam_ex
             There is a struct timespec deeply nested in the API.
             Seems not covered by smokey.

If someone is interested in helping in those topics: Let us/me know!

With that: Happy reviewing! 

The xenomai CI was regularly triggered. I do not expect any build or
testing issues.

Best regards,
Florian

Florian Bezdeka (42):
  y2038: cobalt: posix/sem: Remove compat syscall for sem_timedwait64
  y2038: cobalt: posix/clock: Remove compat syscall for clock_gettime64
  y2038: cobalt: posix/clock: Remove compat syscall for clock_settime64
  y2038: cobalt: posix/clock: Remove compat syscall for
    clock_nanosleep64
  y2038: cobalt: posix/clock: Remove compat syscall for clock_getres64
  y2038: cobalt: posix/clock: Remove compat syscall for clock_adjtime64
  y2038: cobalt: posix/mutex: Remove compat syscall for
    mutex_timedlock64
  y2038: cobalt: posix/mqueue: Remove compat syscall for mq_timedsend64
  y2038: cobalt: posix/monitor: Remove compat syscall for monitor_wait64
  y2038: cobalt: posix/event: Remove compat syscall for event_wait64
  y2038: cobalt: posix/cond: Remove compat syscall for
    cond_wait_prologue64
  y2038: cobalt: Cleanup code style of time.{c,h}
  y2038: posix/mq: Fix mq_timedsend syscall routing
  lib/cobalt: Fix possible fd leak in __map_umm
  testsuite/smokey/sched-quota: Allow building with gcc 12
  y2038: posix/mq: Harmonize mq_receive and mq_timedreceive
  y2038: testsuite/smokey/y2038: Fix a very unlikely resource leak
  y2038: cobalt/posix/clock: Use timespec64_valid() for validation
  y2038: Prepare code base for 64bit time_t
  y2038: build: Introduce new build parameter --enable-y2038
  y2038: cobalt: Introduce some itimerspec64 related helpers
  y2038: cobalt/posix/timer: Adding timer_settime64
  y2038: lib/cobalt: Dispatch timer_settime
  y2038: testsuite/smokey/y2038: Adding tests for timer_settime
  y2038: cobalt/posix/timer: Adding timer_gettime64
  y2038: lib/cobalt: Dispatch timer_gettime
  y2038: testsuite/smokey/y2038: Adding tests for timer_gettime
  y2038: cobalt/posix/timerfd: Adding timerfd_settime64
  y2038: lib/cobalt: Dispatch timerfd_settime
  y2038: testsuite/smokey/y2038: Adding tests for timerfd_settime
  y2038: cobalt/posix/timerfd: Adding timerfd_gettime64
  y2038: lib/cobalt: Dispatch timerfd_gettime
  y2038: testsuite/smokey/y2038: Adding tests for timerfd_gettime
  y2038: cobalt/posix/select: Refactor __cobalt_select()
  y2038: cobalt/posix/select: Adding pselect64
  y2038: testsuite/smokey/y2038: Adding tests for pselect64
  y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
  y2038: lib/cobalt: Switch vdso to gettime64
  rtnet: Enable compat ioctl interface
  drivers/rtcan: Implement compat support for the rtcan driver
  drivers/net/stack/ipv4/udp/udp.c: Add compat support
  y2038: lib/cobalt: Add additional time64_t related function wrappers

 configure.ac                                  |  64 +++-
 demo/alchemy/altency.c                        |  26 +-
 include/cobalt/kernel/rtdm/fd.h               |  16 +
 include/cobalt/kernel/time.h                  |  23 +-
 include/cobalt/uapi/syscall.h                 |   5 +
 .../include/asm-generic/xenomai/syscall.h     |  22 ++
 kernel/cobalt/posix/clock.c                   |  59 +---
 kernel/cobalt/posix/clock.h                   |  22 +-
 kernel/cobalt/posix/cond.c                    |  12 +-
 kernel/cobalt/posix/cond.h                    |   5 -
 kernel/cobalt/posix/event.c                   |  26 +-
 kernel/cobalt/posix/event.h                   |   5 -
 kernel/cobalt/posix/io.c                      |  94 +++--
 kernel/cobalt/posix/io.h                      |   8 +-
 kernel/cobalt/posix/monitor.c                 |  26 +-
 kernel/cobalt/posix/monitor.h                 |   5 -
 kernel/cobalt/posix/mqueue.c                  |  10 +-
 kernel/cobalt/posix/mqueue.h                  |   3 -
 kernel/cobalt/posix/mutex.c                   |  10 +-
 kernel/cobalt/posix/mutex.h                   |   3 -
 kernel/cobalt/posix/sem.c                     |  20 +-
 kernel/cobalt/posix/sem.h                     |   3 -
 kernel/cobalt/posix/syscall32.c               | 110 ++----
 kernel/cobalt/posix/syscall32.h               |  55 ---
 kernel/cobalt/posix/timer.c                   |  45 ++-
 kernel/cobalt/posix/timer.h                   |   8 +
 kernel/cobalt/posix/timerfd.c                 |  40 ++-
 kernel/cobalt/posix/timerfd.h                 |   8 +
 kernel/cobalt/rtdm/drvlib.c                   |  17 +-
 kernel/cobalt/rtdm/fd.c                       | 122 +++++++
 kernel/cobalt/time.c                          |  42 ++-
 kernel/cobalt/trace/cobalt-posix.h            |   7 +-
 kernel/drivers/can/rtcan_raw.c                |  42 +--
 kernel/drivers/ipc/bufp.c                     |  34 ++
 kernel/drivers/ipc/iddp.c                     |  34 ++
 kernel/drivers/ipc/internal.h                 |  27 ++
 kernel/drivers/ipc/rtipc.c                    |  29 ++
 kernel/drivers/ipc/xddp.c                     |  18 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  31 ++
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  29 +-
 kernel/drivers/net/stack/rtnet_chrdev.c       |   1 +
 lib/cobalt/Makefile.am                        |   7 +
 .../arch/x86/include/asm/xenomai/time.h       |   5 +
 lib/cobalt/cobalt-y2038-glibc.wrappers        |  20 ++
 lib/cobalt/mq.c                               |  47 ++-
 lib/cobalt/timer.c                            |  17 +-
 lib/cobalt/timerfd.c                          |  27 +-
 lib/cobalt/umm.c                              |   1 +
 lib/cobalt/wrappers_y2038.c                   | 187 ++++++++++
 scripts/xeno-config-cobalt.in                 |   5 +
 testsuite/latency/latency.c                   |  34 +-
 testsuite/smokey/sched-quota/sched-quota.c    |   4 +-
 testsuite/smokey/y2038/syscall-tests.c        | 324 +++++++++++++++++-
 testsuite/spitest/spitest.c                   |   6 +-
 54 files changed, 1384 insertions(+), 466 deletions(-)
 create mode 100644 lib/cobalt/cobalt-y2038-glibc.wrappers
 create mode 100644 lib/cobalt/wrappers_y2038.c

-- 
2.37.1


Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CB17AB6
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQMGtC5NK5UJClETstgUChz8yYRep+E3v9NJQSnmLoeYAQ1jqQlu2n/MOTBJl38j67LZDIHqpnKsMTkVe31eY3AsUFUzW1CRNyx0X/Ab9kM7AlVyzlOOpuBCUn0s/R8Nn9GnGdkdrVupSSyoTfKCopVZ/YpHQGQrcFN0UYmtxhpeXs+K8AdG9268ZcHx///c01IneZ5wqgTrY9jdx2xvGybeodpbnajngYZnA/+rCC3X7f8FxN9OhrNwi9npycJvODCvIR/RRqxxIdEyLnOJRM4P6v+yFTErf2IRRgC5OBawGxkTD8py7khHALKxaDdlDkI/FFYZjZ0i9KkhQ3gXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ2JNG4yz+rEwVHojEBfIHR0lCVHA5xO1KaQX9OWga8=;
 b=HM2db4ED3CdOWVgnsWuiGJfGYuX/6puHPeaK/teNLzefo4z6YIDDFB3AyO7HVCgCz7+ulSs8bf8kJBOR5wiMophX9Pj3kLoJnD0lulAIkH0FpnnVYtKQOgM8hi/uY4QxLSdRzqwXBor9dyYjUuHJsjMI8B4FUMn61CVkFYiJzp0NAEYdLQ8fUEdq8iKZWF/hlIxxJWDqoNs1HKxZu1C9KUWrmVlg1W62qpQ3ZGd6dqVcNqNaJNLpJxSn/XcXaW4OzolSmqERzG24U7zRzDmNWlC+h3iDbCEdwLsLjmUo26ZBkTI59Pei7W0y1ympMuKD5YriVOqZNoFBbNb10NGntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ2JNG4yz+rEwVHojEBfIHR0lCVHA5xO1KaQX9OWga8=;
 b=g//NqIxdrcrko5BXhPffQsIIJwrvOs9TdGrqw6oXsNywfZhsa4ZuvDtJG4XCs2eim+/XpBSnw+aVdccwP1rSpmWIJuRUguEzaPkUaWJ9A1kVjPq+Tx3Xb4RarBwGiuIMAs8/D58no8Sk82PERlpVm+uaV7uqZvS+vMZehOxV+L1yPCFa5DEgy+DQcIjVVDi7x9aedZtOKff9NPfNTfYOmfnJLasaJnG7MkPeaqStQN0wmiXuuMu8nzbdfsz1OXX6ZH7zV1g7ocnCvaOQJv/yz2jcHBcfYbAyMDflbuNrs8QL9uJ+LHE5quA/+ldmvgJxEqDP7O7nMT3v7gPEEDAcmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 11:33:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:33:51 +0000
Message-ID: <7528f4da-e5eb-4c1b-ae3a-64ea92e20b99@siemens.com>
Date: Wed, 9 Aug 2023 13:33:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <6b3a57a7-01fb-f40c-ee81-b8aedaf2ca4a@siemens.com>
In-Reply-To: <6b3a57a7-01fb-f40c-ee81-b8aedaf2ca4a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0744e7-40c5-456a-64f0-08db98cc8135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o8VhWqHGPq6ZlQ+PH+B/IzpAPvkiDEDw9RgkbiL/sWwBm282s2eLGwGjhrr9QkwCe5J38Kvgs7Z+EXWm9+MQLlhOjUKntXve8SrwTvazTJ0sG8ESm7GS71nyhasyrItlY/L9SSuVcqBX1OD+vXEkGZ/nUGL9VgVF9QKCKzomeNp5egkmNDvwY5GW3BmGZazPnn2UNTbnksKv9qXyJZEw5pvvMPIJiHxFfe+Pc19Wr+62hwwppQkYgtcXDK9ttwazvVlkZIzt52ml/w1Ofm0nzZcJDO+ULRIKy+Xl7dUM+UUl1uuer2xvez/ffjQMX2CbTRnDYiLkoTw+jJbMRtSA92YRe4uaPppVJnYwqaetrM+CmE6ImXxRpXjF4w9NwHf+/h3XsPn5sOpX/KgezAB/tDxnWsDZycii6AR6dbqudNRoXZyFAhmuiaI4IXdY7T6MuipimnehzwmpiGxAlC9GO2L04JP/pdZoBncDZk3wvh4bAmaeWR8/DMhIah4gDux4we8o59Zlw0Qgm2RIwEa6wmi4JQCRQJjKJ7+ApZElXQhOUzjyHowokwJE4OHyVokyMlr1q1dUPuhIExe83jIB825UsuiZTK0Q4thqooOheHTOHQkticpajMjOo4Dj9TUjt1p5CApQxp8rvePO9vbK+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(186006)(451199021)(1800799006)(316002)(44832011)(8936002)(8676002)(5660300002)(2906002)(82960400001)(6506007)(38100700002)(53546011)(26005)(83380400001)(2616005)(41300700001)(36756003)(6512007)(86362001)(31696002)(6486002)(66476007)(66556008)(66946007)(4326008)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmxyN1RhZzVUc0JVYmdzc1U3U0c1U0ZoSGNITklwYjB5czE3MVRFTUtub0VP?=
 =?utf-8?B?OWFjWURreHIzaWVkWWtPODRwcXpudG1iek5tL0kxM3MyZ0RuOThuWDFlbzhZ?=
 =?utf-8?B?Tm1RQnB6TWxlYXptTlpLZ09wdWJLSzFhREpzMDVjK0Q3eGlHY0dxMEFtQWds?=
 =?utf-8?B?NU44bHJzQkU0Ri9reWtZRHBUenQzd0JTcWZKSTJIb2k5aDdKaDRUV1A0Nml1?=
 =?utf-8?B?aWFIeEpaQzJ6cUhiNFdwc3BPRzNTUW5RR3JGN3FnUkJRc1QreWxxNVhBc0Jo?=
 =?utf-8?B?aHhqNC91MEUxU1ZpQzZTS1piVFI2eURzVGpDS0grOVZXd1FjY0FEcjhzbDY4?=
 =?utf-8?B?Nzd2NnZnc21QZnJTMXNkT1N1VGI5Z2x6RHZxaHNYV0JnU29UT1FsaU1XNGEr?=
 =?utf-8?B?anY1Vk9HQ24rK3pDaHRsaHN2QzBPTzQ2Y1JQVkFZYXV6RVNzN3VZSG03WURQ?=
 =?utf-8?B?emhmUlJtdkdBL3oreXFJNlFPVzZ5UGNSRjVFbktEK251WWxTeU53djdlTUhO?=
 =?utf-8?B?QVZaeEJKeXd5eXc5MmhXcUtzd0N2RkUwWGErbnN2NWFzVXlDaXBYYVUwdlAz?=
 =?utf-8?B?Y05DLytwaFltNjdMR0ZkWDJJczhiZHlBbXhVeVNlcnF6NUNNSVppclp3Yi9V?=
 =?utf-8?B?VklmRkJrOVNMTDYyNlFRUGVxVDJZVzQxMFYvYXFhU1RUVXNtMlN2RkM4am1T?=
 =?utf-8?B?endtSUJOZ09xTHIyZ2YrQTNtdFJxbS9FKzhWVUsvLytFR0xLWDZ3WmRFbGhX?=
 =?utf-8?B?d3F3dlhEZHMyVzJZYjRjR2gydjhSZXhGS2dJV2phMWJmaURqSFZ4REZvMk91?=
 =?utf-8?B?RTIvOHhuWmxjS0Jqay93c3AxRVBzQk9zMEJJSUJMWVpxQ01lZ0gwOUMwTlBI?=
 =?utf-8?B?UExQQklJSE50SXpMdUUzdWd0czJjZEk1cVE2MmdtYzFyQ1cwbEptemZyRUNv?=
 =?utf-8?B?VDB3VStSNVVzeGFnTW5yMG9xTTVWeWVqbWtqTFdUeTVxNGFPMnlrdnY4K1pS?=
 =?utf-8?B?OWF3cTNuSXgzVW9sUnNBdWNVZnpxRFlXeEFRNzMwYjZUa0JvbVhsaXZ5SFU0?=
 =?utf-8?B?cUhCM2c1Y1MvUytrWGMwVGlYSFRDUTdOcTYvSGFjbWdjbXh5M0R1aDFjOVVq?=
 =?utf-8?B?MDJPVzRaWFNZamZybFUvbVdBZWFyd01KV1dzUVdzN3RnMHlLak13dEthMG1F?=
 =?utf-8?B?b1JWdm1uYkZwcCt6WVF4VzdOcXJrc1NESWFVdyt1Smord29EQ3c1UW5GT0Vm?=
 =?utf-8?B?bjZHKzZhdk5nZ2VJT2FIRUZSaGRqdXVyQm51NGlDNG9DNlhnUW8zTXhFcm9v?=
 =?utf-8?B?eUhOOXRoUFpVRDZTN2NkcWlEKzdBM2FmTnN4dkpock80bm9iVC9SYi9DM291?=
 =?utf-8?B?WGxOb2tYd2djMjhSZExlQ0VqMjh0REc2QUZQRGVjbytuanNMR1A4Qjdqb0tm?=
 =?utf-8?B?NUdsNTRMRkhiZUcvdVZrQlBEY3JGT2M4TmNvUmd6eWdpNGZSdWxHc2tyc29s?=
 =?utf-8?B?Sk9JTFJVcTBLR2kvSUg5ZlUyOGsrQktxVmpFWDFhd29PSUNwQUloN3ZyeGZi?=
 =?utf-8?B?T01NNDZIOCtpM2wyanl1dFgrNTQ2MmJFYmIzanpIUnQxRDVpZGxQeklxL3hO?=
 =?utf-8?B?QjlhVUp4bTdYL1FBa0VBRDBnSUQ2WFdUeWc3VDlNczhTWldvdHV2OVFlSXNP?=
 =?utf-8?B?NWhLbnlKUyt4U1U1VGpXK3orMTFtNlZiOStmZ3NDZGUycWFiWHFGekJGU2Nr?=
 =?utf-8?B?cERvSko2L0gzOEhONWUxb0w1MXVYY09vcE9pUDEzdjVGWHFaaEpFQUJjbklD?=
 =?utf-8?B?bXVaYmROK1pzbFJxMFZZd3VJMTBGV21td1dqWVQ5SHgxdzBhUjJVWlhWMGd2?=
 =?utf-8?B?SzR0NGRRZzNQY0ZQK3d4Y3pMK1ZxQUdCNUdod2trL0ZlRzBSNWQrNGJZNGh0?=
 =?utf-8?B?d1dVdXQzWEJZTUtVRkdmK3BKS3g4UW4yWjdreGZ0SnN5TDZRY3YyQkJGWHho?=
 =?utf-8?B?RGx2RkxOSUtmMzdicHczSHc5SHJ3aWF0cktIb2x4RjV2UHoxd0wzZnBhS0lQ?=
 =?utf-8?B?Rkhwb3dQL3dpVXhmRkpvdk5IN1pQeWg1TVN0V2dPVXJUZTZZTHBWMHNtQ3pu?=
 =?utf-8?B?UGtzT2ppS1Q5QVBTT3pPZVpDZzQ3anZNRWNqV3V3TUpwaENHNTdPRUNYSDNz?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0744e7-40c5-456a-64f0-08db98cc8135
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:33:51.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOgSlgFSAw/NRkHixH2Ou8zwJnaulOaR41gOD/28YQZBjfU/HBoKTB0sqByDs5yzFcNvq0rPMGVp39WLyRZWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5149

On 09.08.23 09:36, Jan Kiszka wrote:
> On 25.07.23 10:29, Aaron Marcher wrote:
>> This patch series fully integrates the currently abandoned alchemy, pSOS
>> and VxWorks tests into Xenomai's testsuite.
>> For each test, a Smokey testcase is hooked up.
>>
>> Changes since v5:
>> - Improved task-2 fix commit message
>>
>> Aaron Marcher (7):
>>   testsuite: Fully integrate alchemytests into smokey
>>   testsuite: Fully integrate psostests into smokey
>>   testsuite: Fully integrate vwworkstests into smokey
>>   alchemytests: Check pipe-1 asprintf ret value
>>   alchemytests: Fix task-2
>>   alchemytests: Fix task-5 logic
>>   testsuite: disable broken tests
>>
>> Richard Weinberger (3):
>>   testsuite: Remove old alchemytests Makefile
>>   alchemytests: Fix gcc warning in buffer-1
>>   alchemytests: Fix gcc warning in task-9
>>
>>  configure.ac                                  |   7 +-
>>  lib/alchemy/testsuite/Makefile                |  70 ---------
>>  lib/psos/testsuite/Makefile                   |  49 ------
>>  lib/vxworks/testsuite/Makefile                |  43 -----
>>  testsuite/smokey/Makefile.am                  |  15 +-
>>  testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
>>  .../smokey/alchemytests}/alarm-1.c            |   1 +
>>  testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
>>  .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
>>  .../smokey/alchemytests}/buffer-1.c           |   3 +-
>>  .../smokey/alchemytests}/event-1.c            |   1 +
>>  .../smokey/alchemytests}/heap-1.c             |   1 +
>>  .../smokey/alchemytests}/heap-2.c             |   1 +
>>  .../smokey/alchemytests}/mq-1.c               |   1 +
>>  .../smokey/alchemytests}/mq-2.c               |   1 +
>>  .../smokey/alchemytests}/mq-3.c               |   1 +
>>  .../smokey/alchemytests}/mutex-1.c            |   1 +
>>  .../smokey/alchemytests}/pipe-1.c             |   7 +-
>>  .../smokey/alchemytests}/sem-1.c              |   1 +
>>  .../smokey/alchemytests}/sem-2.c              |   1 +
>>  .../smokey/alchemytests}/task-1.c             |   1 +
>>  .../smokey/alchemytests}/task-10.c            |   1 +
>>  .../smokey/alchemytests}/task-2.c             |   5 +-
>>  .../smokey/alchemytests}/task-3.c             |   1 +
>>  .../smokey/alchemytests}/task-4.c             |   1 +
>>  .../smokey/alchemytests}/task-5.c             |  11 +-
>>  .../smokey/alchemytests}/task-6.c             |   1 +
>>  .../smokey/alchemytests}/task-7.c             |   1 +
>>  .../smokey/alchemytests}/task-8.c             |   1 +
>>  .../smokey/alchemytests}/task-9.c             |   3 +-
>>  testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
>>  .../smokey/psostests}/mq-1.c                  |   1 +
>>  .../smokey/psostests}/mq-2.c                  |   1 +
>>  .../smokey/psostests}/mq-3.c                  |   1 +
>>  testsuite/smokey/psostests/psostests.c        |  69 ++++++++
>>  testsuite/smokey/psostests/psostests_driver.c |  34 ++++
>>  .../smokey/psostests}/pt-1.c                  |   1 +
>>  .../smokey/psostests}/rn-1.c                  |   1 +
>>  .../smokey/psostests}/sem-1.c                 |   1 +
>>  .../smokey/psostests}/sem-2.c                 |   1 +
>>  .../smokey/psostests}/task-1.c                |   1 +
>>  .../smokey/psostests}/task-2.c                |   1 +
>>  .../smokey/psostests}/task-3.c                |   1 +
>>  .../smokey/psostests}/task-4.c                |   1 +
>>  .../smokey/psostests}/task-5.c                |   1 +
>>  .../smokey/psostests}/task-6.c                |   1 +
>>  .../smokey/psostests}/task-7.c                |   1 +
>>  .../smokey/psostests}/task-8.c                |   1 +
>>  .../smokey/psostests}/task-9.c                |   1 +
>>  .../smokey/psostests}/tm-1.c                  |   1 +
>>  .../smokey/psostests}/tm-2.c                  |   1 +
>>  .../smokey/psostests}/tm-3.c                  |   1 +
>>  .../smokey/psostests}/tm-4.c                  |   1 +
>>  .../smokey/psostests}/tm-5.c                  |   1 +
>>  .../smokey/psostests}/tm-6.c                  |   1 +
>>  .../smokey/psostests}/tm-7.c                  |   1 +
>>  testsuite/smokey/vxworkstests/Makefile.am     |  94 +++++++++++
>>  .../smokey/vxworkstests}/lst-1.c              |   1 +
>>  .../smokey/vxworkstests}/msgQ-1.c             |   1 +
>>  .../smokey/vxworkstests}/msgQ-2.c             |   1 +
>>  .../smokey/vxworkstests}/msgQ-3.c             |   1 +
>>  .../smokey/vxworkstests}/rng-1.c              |   1 +
>>  .../smokey/vxworkstests}/sem-1.c              |   1 +
>>  .../smokey/vxworkstests}/sem-2.c              |   1 +
>>  .../smokey/vxworkstests}/sem-3.c              |   1 +
>>  .../smokey/vxworkstests}/sem-4.c              |   1 +
>>  .../smokey/vxworkstests}/task-1.c             |   1 +
>>  .../smokey/vxworkstests}/task-2.c             |   1 +
>>  testsuite/smokey/vxworkstests/vxworkstests.c  |  46 ++++++
>>  .../smokey/vxworkstests/vxworkstests_driver.c |  33 ++++
>>  .../smokey/vxworkstests}/wd-1.c               |   1 +
>>  71 files changed, 749 insertions(+), 177 deletions(-)
>>  delete mode 100644 lib/alchemy/testsuite/Makefile
>>  delete mode 100644 lib/psos/testsuite/Makefile
>>  delete mode 100644 lib/vxworks/testsuite/Makefile
>>  create mode 100644 testsuite/smokey/alchemytests/Makefile.am
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
>>  create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
>>  create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (96%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (95%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
>>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (94%)
>>  create mode 100644 testsuite/smokey/psostests/Makefile.am
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (98%)
>>  create mode 100644 testsuite/smokey/psostests/psostests.c
>>  create mode 100644 testsuite/smokey/psostests/psostests_driver.c
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (96%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (95%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (96%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (98%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (95%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (97%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (95%)
>>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (95%)
>>  create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
>>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
>>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
>>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)
>>
> 
> All applied, just with some whitespace massaging and a reordering of
> when the build system is actually updated. See next branch for the result.
> 

There were also bugs in the makefiles, breaking vxworks and psos build
on debian bullseye toolchain at least. Updated patches submitted.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


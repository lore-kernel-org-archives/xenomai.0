Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CCD284
	for <xenomai@lists.linux.dev>; Fri, 15 Sep 2023 07:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8agGoEw9i0etQwE2/9xBd/aC4O+yErFNDkM74MXH9f2nP1Vh4JmQ891OT2E8zzeQ1+JeaoviYEWLpP7QAfrFKJHUZAQP4FzPhZztLdxMkZR05Z/lT4qP5l95B+D667Zpk7TXR1kOVexV5NM0tIQ0a1lpQq2+stYzUL3K/cMqCtvFwNBU6LGGy6F2vN4vEt48mFHE2at9od4E/jpS5r5oLOPddOgAfqK0HOd6qQ98HQ50O87q92EPh2e/vjI4/w/EWIWQBRxORUZO52126RRqnBahZFgy7GxfIGPh8eOfUeddmDvX6YJVD+boI/6MTUQGD0aQux4AhJvx4t/XWYMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd9t4lELgZkz0yC1pgd5IMY8/T8U+CBt1qEDm9fcs+Y=;
 b=iP/YB1vHGQssZ2+h0t4gEuIcaDOqn+u7+P/8Sxym0xIPPTXFWRRMdM7PnwmwY5Jm+GHxxptwmYHpCjQIc7awDhMQbKvWd+/Gdb0hFmWd5tc80oMLXAiWGWGKaVvLhgPfbLlbC/LzBNxd3GLfVKi5dQZetbQynu94vsA5CJj4uCWfMqEEclNX8cz98sta1Z/2k4RlwZYXEAAzNElxwn/O+IOwPbrhNi/jQiEWwGOdb8BfEi/ieuA2IIFp1qKwVumiRxN+OjcpvYMJ1rcZ4vCNaWZCfduZoLrhRkwmccYTQYtkiAkMmNnO2p2H0dbFcX/eHRu6iz8mzSJoXJIkL/ZfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd9t4lELgZkz0yC1pgd5IMY8/T8U+CBt1qEDm9fcs+Y=;
 b=LURi7Mpklap1J7Z4ZmAsSFWyKfcSLTIKPfriFfPCFsBMaDud/c4CIgTCsUupar4+dJvC9SvMUfeWx75FVr8kl0aKIfTmCSCy2+4IvtfMpEgx8KdIE33B4T16JpShI1O6vmTHlOs40JtVdGao51Km1s91r4jWTK9mLFR2Yz/8yzsrUeSfVCMYDw6fDZwhuOSgX+T5Lf2nV+vQsZo8iGHb3laHCu7SrDwGdG9Tv/jMs+2e6zSGgyx0dxSPV2nZDcIda4J6z4MwYZXe8DnP4i/5pY7Ag1L5UJ83UqDMekGHY3Hz7C1M9Az71Pu0MeWTIJh28bp+NBvD+oVHiU/RVGUV8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 07:32:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:32:45 +0000
Message-ID: <f84733fb-1e30-46cc-aba1-3ff8b5eb9dec@siemens.com>
Date: Fri, 15 Sep 2023 13:02:33 +0530
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Do not run CI for tags
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a459bb4-e29a-49c8-d5f5-08dbb5bdf429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9XWOddra4C4zzmCzW8La4Ak3/J2A8nNVDVEMlWVLsabyi18ghkPtuHNBsoyjzok2EvOAgzHauVQ5UcN2ZTGVjbAoc3TkjVzNcF5r4o4MeWI0O0phHt/YMwq7/tGjZ1D0VyihDEOtS/e9QFj9dJ3KWcxMUXDMOR0GRkJUSTtmOOqkLOUCmjbZVjmZBjG59K1HHB2iT2J/xe5TCdIgpaMtSjl9nEuTjcqraF/mqSgO5yHxtvNcaJJ/7K0Z0FXv1n1OoFHpnEhMpP9sxCxnPztzj0lk6xAuXMQAvY8rsAUNUGJ05tsUx+nLXXrppduML+zu57BS28w2DjlYvZofD/OpaWnCWVDWoZ1MV9sDD1Lwu6J7tonUSFqylNB47ALJ3VlZbuGxa9/xoBY1yvCmkY4eCqOTC+UMrVPiaMQTwE2zdiFGnBvG0UqGzuy7HNWn3+ewtYhZbikJrYj2mqdOyCDj/rmE6GIBNcUniMtrTE+icoKF50Zb6c3ToYzXK9yW8U52xSJd8bwthkTso1pdameMLCiu5DIksdMRD0qcp94pAmKhN063tSOGPGEo2400GGNnVP7A2kP8j3rHR+ZkVvwjA8FZC2cgkm6w+3lEaWnDWkWwAYhH0P++qbv/SA9zzUsFlf4l04D4BRAPERll8bznXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(66946007)(8676002)(6486002)(2616005)(478600001)(316002)(66476007)(66556008)(6506007)(6916009)(6512007)(41300700001)(8936002)(83380400001)(44832011)(5660300002)(26005)(31686004)(6666004)(4744005)(31696002)(86362001)(2906002)(36756003)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUd2aEttQWpNbytaK3lEcm9Vc3Rjbzl3bXFIZzZzRnFpdU9tSHFmcW1aMnpB?=
 =?utf-8?B?aHp0T296RVM5Yis3SlFsZVFscDI4S0tIZTFpNzBtRmFjVDc2QnJrV1J0ZjBu?=
 =?utf-8?B?UWpwTnVXUXNld0VqNzhOd1g5T1pTWXJTc0JDTDdocG1IM1ZLb05rTjlqTXc0?=
 =?utf-8?B?dlo0cEdYWXpvNWNFeW5TWmVsbFRMeVFsdmhDRmRpNXJHeXJYQWF3UUJVZFlp?=
 =?utf-8?B?eXA3WUU2QjE1TzRUZDd5S2ZuVXVNdmQ1Nm9KbWlZZnJ3cHpuZ05TYmMvMUQ4?=
 =?utf-8?B?UXF2QUcwYm9YaEhlejRMbnlGQjJCMjlvN1d2NHo3b3R3S3Z0NUQ4Wk5ZTWdC?=
 =?utf-8?B?c0FkeU1IZzJ4Wlkzb2VpdTdxcmNlWHpOczNjQjlzc0N2QlF4a0RmQll1R2h2?=
 =?utf-8?B?K3MyMVpVMXl4YXZ6MVBJTzB4b0kxeTk1UTJWNldDdTEwbjRJTVl5VDgybjB1?=
 =?utf-8?B?aE0wcGlaMWJhTGpZWXNXTG1mR0tCWTA4V2YxMldVdC81UnlXWm9YN0xnR1BS?=
 =?utf-8?B?RGg4REVMUERmcDA5a3JnTld4Rm96YlYwcDZHZTQ3RjRpQzRIbFZIZmEzdEg0?=
 =?utf-8?B?UThTYUUvQmpUMUNDZjV0MkVqVDFIMGVPck9iK3VSYWp3cTNuTVpySjg2d2J4?=
 =?utf-8?B?SzZFZVIyUERaMGd3YVUrZUQ5WDE2UjYveUdieGZGdDQvVDhxMHlxeGxVSlp6?=
 =?utf-8?B?VUZsT1BkbTk4c0dSWXNIQitsQ1JrdVVKcmY1SjRGQVNiTlpoWm9VN1ZORDEv?=
 =?utf-8?B?NTZ0c1k2QmVlQ0U4RlZ6cTU5RXYxdHNTd05jc1N2MXBzc0k3Mm53V0l5T1A4?=
 =?utf-8?B?MG1NRmd3SVpacXpQSWlzT0Z3WThvR0FDYURuME1nQkZ6dFJPbzJOdFR1MUxo?=
 =?utf-8?B?ZDdod3pPVldVNm5XRHJzY3U0Z0thMVRZSDVac3dwd24xYldrSlZZWjFaWnNX?=
 =?utf-8?B?UWNaRzNUekQzOXlrdzV4YUFNb1doL1doQmJ4QzMweURWdExKVVVVTWJOYW9U?=
 =?utf-8?B?Qm54OEJMT0Uzc1JoMlcrNGN6VXJ6WlozcStVb2lSU2FBL1pNWU0rcy9qUTRi?=
 =?utf-8?B?Y0lGSllCRW5QY2lFS2tQTGVDU2JmVWdVMVZNV3FTQWVNck8vcWRFNnE0V0V1?=
 =?utf-8?B?ejdBaVFIWGptWHc4aFMrMlIyZ0dYTXVQNU56U25Fc2JYUThmMGJ4b3lCWHFU?=
 =?utf-8?B?MDZsekZXdk1FUHUvMGh4MmxiMU8vMS9FSTFLWjhscWMxVlY3QU5oVHFwOUI4?=
 =?utf-8?B?ZU9FRHRIQnR0VUlubE1EbUhNSlBYRE1qTXFuejcxUHlCdDllTm9ISTQxVG0w?=
 =?utf-8?B?bnNJQmdaVGJuK0t0RXh5TzZVR3BRSVhEVGpOVm40OHI2SVBua3NRRXlCUUZJ?=
 =?utf-8?B?dDlBTlNSKzhoM1h2VDhwSk9TTVU0MkVVTHhzODlQVzdUTWdTdVg1STZYRWlw?=
 =?utf-8?B?TkNZaWV5MWxyV2ovRlVraDZvcCtsSzNqMUxrTlBHcXlQNWVvd1ltNnJYT2F2?=
 =?utf-8?B?Ti84WEFadDRydmZiQ25SUElMa25uTVNDdlZEclcwOU94MmtMV2hrVGJEZ20x?=
 =?utf-8?B?eUtjcERuS3pQNmdjMmJjRzlqR3NaZXFoQmo2TDA5M0ZBTWNIQTNQNnBnL3pu?=
 =?utf-8?B?WEdvOTFuRk1rSkJsc2pQWWYwMHk5NWVLOGRnUmowMkwrMjVCOXpzTk9UUkZa?=
 =?utf-8?B?NFJTcUdWR2Y3c1RCWWtXa3RYWXBSVnowV0lNdWxOdXk0WE9JSFZCekhhZ21Q?=
 =?utf-8?B?dW8xSlJJK29oT3U1V2FTd01uU2g4M2N2dVkyU1FzdzlxdVoyemNKaU1OdzZP?=
 =?utf-8?B?VGQ2VmNUazRqaWFWRFBNSHA3MFBjbkpla3hlQ2NsbG5ZQWlZdWFYTnc2WHJS?=
 =?utf-8?B?bWRxdkgrV3BOUzgxM0RRZkk4VVhmcG0wOEhiSVM1MkR0SUZ1OVI4bmhDVThR?=
 =?utf-8?B?L2VwUEtDUnNWN0dmS2lTSzRjM1VhRnNJZ0lNcnQ0SlB6ejRvNUh1M3dHVUZh?=
 =?utf-8?B?YWJZeVR0TExlNFNORDZVS0xYTWZWQXlhamVkOGlHMnJpRnovV3BRRjdqVEha?=
 =?utf-8?B?V0lQWUs4azRkZVplc1dDbk1LRXc1cGFWUUZ5VlpYQlpYTjdTMVNwdGMwcVdN?=
 =?utf-8?B?RW00cjBjU281dG9wYXZLdDVFbnhab29ZYTJTTWttR3BxSHJQNVNaN2lHT0c5?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a459bb4-e29a-49c8-d5f5-08dbb5bdf429
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:32:45.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdMM6mwiv32NMCfrFIdOsm74frAbusus9D0MtY/0rk/SypxIpy9rs+8SHtJ1JbUl8gwx9xAOxKbKtTJ60maj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6067

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are already covered by the run of the containing branch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8c1cfa2dc9..e2281c9e17 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,6 +35,8 @@ variables:
   stage: build
   rules:
     - if: $CI_COMMIT_BRANCH != "master"
+    - if: $CI_COMMIT_TAG
+      when: never
   before_script:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
-- 
2.35.3

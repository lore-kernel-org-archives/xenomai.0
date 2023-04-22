Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7D7F
	for <xenomai@lists.linux.dev>; Sat, 22 Apr 2023 09:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMOrvBx5qyfT2M5ub1U2/b9/5yEXVlaNrzwRHPyr5b3U20c6d5Z3Q2l/xMFCX1gGQKjJe3LgvUHC9qxFmE+EEm71VrkquOdS0v5Fb0J8HXCjtEa72bIq59BNRbyx9czCA5aDByzGc/LrTA3laf58yJV1yOYAnfxQWM2fkMG27Fe+jzNvWCn7jOtK0N2BGRW8dkCELGUrTBI5jO+qWiq2IzZqlf+JRObnhw9JYhtHw2LLhuV/HhJAbvsvaRDlao8Di8ZFQ9U9Vvkepn6thJd2xBpep0cncJbAz565KaMgvhJ5qqSEm5OOv4tecErySxM9ei5KuAq/v60fO3P2qqkZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8VX+drkhRZLr1T0LWQ1KUPXJ+6FGJvL0y+al8VAlr4=;
 b=KCoz29aDGWtY5HVWA3TzhOKEWo9Pbm9ZyYkSvduZIOdXV6kKGUDHHzOZRZE0LlHfz7qXeQsmwKY78EcbMXNf8dvgO0pfGhTLAAMEpnsRRPB5Bhl0t2JUY6h9cFCIJbTeXpjIUMDMj2TFtxqoRA9GpbIKcc7HwR0NXqRoVwGawQGjHzACUWVvGlNwNLHDmRVRRgwF/c4JwOY8XF29hRm56aPvWwwnd4UOyECEYKMxL58n6J6M/yGUOhCb+ptA4ztWIVCxU/D6fSPag7R6kd2kqyeFcJRpyE7OJxM88kd4J0xLXPUamw0uWyizJ9b7Q7bT4rz3qG0kiUueU8vPSDagcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8VX+drkhRZLr1T0LWQ1KUPXJ+6FGJvL0y+al8VAlr4=;
 b=lbnOXwx9UEdLJb0MdVVrU6u2hbhnW4RR9lmMCN1AV0Yo43w7HJeFJ7oFvlQ/yR3lYVCTdKDB1kdDfODNGT49ZjEA1IukRMbZsq4crRGAmlenj8vnaul5hA0evQ2MtIQ/j6U+W8YaSpDbEr0JQJL80UmLDvfRVhj4o777ehLN8sZa9vz3aARJiIrVuSGD0bvslmw8e/zr/tzT900h0FAJpPtx+c+0uhCHHycLUSvib5P/G6jx49MOu81kMLSXTVD9Fw7cQ3h7HFPP9DgTDL9ba8KWm5CWUPwiyZmJ5SjPeft4C5kqrpiLrlDZMxdubAPdlsAWqEtqT8iDA4rhWs14lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.15; Sat, 22 Apr
 2023 09:53:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.015; Sat, 22 Apr 2023
 09:53:28 +0000
Message-ID: <f18bffbd-362d-8acb-2b37-9ac1f7cd4d15@siemens.com>
Date: Sat, 22 Apr 2023 11:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/copperplate: Add libfuse if building with registry
 support
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Aaron Marcher <aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3577:EE_
X-MS-Office365-Filtering-Correlation-Id: 10aaf6e0-270d-46b1-98bb-08db43176bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6GuMexiJsfHwMSHwqVaDieUdQN+hwE1AMoFTjwNsnOwlfYQU0imkNN5F39oa0oiN50nT3l8oOSFaQfjeygKp4vzRwO1JX+mQ6AZ0h84E2lZGwdMJeCi3rr+SHw9/BBf7H2LtUcY3ao9X7dp+KWf+/CDb7bqmO+U7Yhl4dxSxZGuXzVDakMGg+nF4fknAS2+ZhKsJIwKtKqQMjzXUyQiuLI58uY7WRf54NoFfELWik/Jp4AGJXZ2oe/VAW/5YqEP0Y2b1uVL5mtJKrD8VvM5/Eby/qxgs7yxH2qcUSIWcfS4FEQCCDoz9ctd6Nj3LsZtbcdtEVrr2vDoz1azUX8sysKp+OvnHBHpo4fiRNKvmydp7Ko7sIEe5zFIY95OahpKlOB4WheeyVfibw9z1Dljwo6pwGcVN/JskAgznl0Ay9YCFxbEvs1OndAhNiw36r2ykotVKsjVEKHGpGODRG4hkvMbKM0Bh2CkSdyRxFavU3TThuVGK6BQdP9Zie4wYCWQD/X1q7p97LOM6JD3wfzj51L+epqP1C/E0qh1PSHRr1bqBeh09+x4gyetd0KTeoqmhis3mv3eY2K4DWR8tgT1l4Jh5gEpmhMYQ4f1C/b/4NnO6T/OZ4xDR8fYmHNS6n03kSM8dw9y0JK4ze+OgoeQBUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(31686004)(66946007)(66556008)(66476007)(2906002)(4744005)(44832011)(86362001)(31696002)(5660300002)(2616005)(8936002)(8676002)(41300700001)(36756003)(316002)(4326008)(6916009)(6666004)(478600001)(6486002)(186003)(82960400001)(6506007)(6512007)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERDbDlZdzM1d3luRGt3VlVYU2xwcWR5c3ovYXNxbWc2ZHJVc2M4VVdRK2Z0?=
 =?utf-8?B?cVliQXh0bWxvdWFpOFNoZitaOW8xaU1IbWFJT00rTDgvUmtXMVk0VlZRMmJj?=
 =?utf-8?B?NU5tcmI1Rm12aTRLK0hOWkw0VUxDWkFaVUtUcGtRYXNzMlhTVStFcnNyNGhT?=
 =?utf-8?B?bnR4RVowZ1ljamtYNG4vRjAyelNKK1V6MU54VXJJM1NEZ2kwaXJhV3MzSnlY?=
 =?utf-8?B?OXdGS25zZEJJdUZnWEljdUpodFhKK1NvNk95Nk9IeU8xS1YyZHMxK0N0UXEw?=
 =?utf-8?B?WThGWFIvd1N3NWhmQlVia1Z3bUdFbVV0bzN3bmVIWGJYL2pFRUZUVURuY0Zx?=
 =?utf-8?B?RW1WdXRKZ0tlY0Z6MElFS0tNckNHU054RFQ5L3FKejQwbktCWFRBQ055b3Yv?=
 =?utf-8?B?YUEvb3hLbWlDc3JkWTY1SGJOMlJ5MHk3QVZHNkU5VlFhVTBlaThmWDBubUcx?=
 =?utf-8?B?R1dKYStUMHNFR3dIRTRpQmNya0lQQU1rUFQxV3NBK3gyZHRhL2EycCtCcytT?=
 =?utf-8?B?dkh0OXRvZ1o3ZG9DSjdUZGVnN1RqaVJLOGNIeERmejAwK25zeFIyOEZzMWZJ?=
 =?utf-8?B?dUd4SitQMGNjSG13b05XdStOVk5yU0lzN251Mm1WWDZwNGhZcDZSSTlWOWZN?=
 =?utf-8?B?My9vY21NSjVUb0I2TUpDdGVSL1NwMUJIaUxEOWpISkdTVEd3NmFTYm4zNzky?=
 =?utf-8?B?TkFjclVrTW1YcEczQ0lmbTZCWHZza0tuRUNMRGlSOFFJdG5ra0tDZzNqenpW?=
 =?utf-8?B?YjhxYmdZTFplRzRuL3ZKa1NxeE0zQkthSzRxeEhGNHV5MVlnZ1BuMExaVEpw?=
 =?utf-8?B?QzBVNC9hMmZjSEx2ZHBaWU5iMjN5MVNaR0xSampSeWlyQWhrWTJodmdOOU1T?=
 =?utf-8?B?NTNuMno5OXF5SHN6VERyWVFtQWpjc2hGZEtrV2x3Nmh1YzIwSmdOTlk4Q0x1?=
 =?utf-8?B?Vm1rQjYrdG9RdGxPaEpIMkU4bFFCMDJNZ2NvUEFtUWlCaFo1cDFyMEd3OGpl?=
 =?utf-8?B?VlpWRWNONEJoOHJoYW5jTzRpeUlsWWJMVEFqMVo4eDNHTHgzNmRLMmNXWHRM?=
 =?utf-8?B?M1ZvVDFpZXl6V2RtQlV4VlhvKzBCYjJwdml1S2FRQlJmSXljS3JHNWorSkRV?=
 =?utf-8?B?VHNoVUE2SDdGTU9PdHR4MnB1aFkzbCtndzVuS2h0bktZeVFKOWl0UlQrdmRB?=
 =?utf-8?B?UHBlSkdUbFpYak9rZmYwZ1JtM1NvWmlaY1hLS2Y4Zyt4UytlZEVkQkpHU2FH?=
 =?utf-8?B?ME44VzIyRXJtU1htbjJaeE1PRllSK2U3dVk2SGRZZEhqQmVzMW1Rend5dW4v?=
 =?utf-8?B?aksxcjRLS1hwRVhtQm1Ib051QURCalhXbm1iMjRxRERkUDVkbjFZRmwxcHVp?=
 =?utf-8?B?OXQ4ZHB2L3JaZjdqYUdJYXJ4enM3NUlmNTFKVzR1dzJ3Zk1CRzA4cU12N1pn?=
 =?utf-8?B?OVFzMHhqWUpQRnVZdUF6bjJldFJIN05pS2FvWUloM3ZuZkJjMVE4MkRZVHZK?=
 =?utf-8?B?cGM2eG9SWHlIdDZqUjV4UTFHMWxwV1NDVEM1T1d4b1lPd3pPTGczQlVSUUxr?=
 =?utf-8?B?NDg1NzBkMlQ5WEtFQ2hRMURlWVVyc2NhblVLWk1majdHejdTWG0vV1ZCQm0z?=
 =?utf-8?B?akdGUkZKVDZuOVV4VUxpNW9Vc2htaURRazBPSUdMVUhNTnJDd0JyRmx3NWti?=
 =?utf-8?B?aUJwSWRMNE4wcG5JRnZxNlNMem02V1FSWEtOLzhOaXRhYUVZVFNRSFoyd1RH?=
 =?utf-8?B?Z0Rveng3SVZkTjJObTZlaldBSFZzVnNYL0R6SW9DN0M0eUJqdzI2Q1lxZlN5?=
 =?utf-8?B?SFBYUmxCK2FXM3FIMHowWmtIRUJieGlWWThsVTRaL3JNNVdlSTdndXZmRHd6?=
 =?utf-8?B?WVBTOFVmL2RMeVltWWZlQ1MzSHNDcGdiOCtGSzlZNVNCRVptM0FWcVZINzR0?=
 =?utf-8?B?Y002L3h5RGtjbkp6bHhFajhQUndLMTFBblhldVdSNHNFMlk2Vzc0dzBWaVEx?=
 =?utf-8?B?WjBVbHBPVFhlblNaMGEwOHlXVjJXNk9sVHEwTmVwUnIyZXJOeXZCcytIZkR1?=
 =?utf-8?B?MGtBMlRlT3p1cCtITXBBL0oyZTZ0bWppK0QwNy9ybE9aRmJWTWZjd2tzNEox?=
 =?utf-8?Q?q+wFA1IbcnabczKVdp6T+RmJK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aaf6e0-270d-46b1-98bb-08db43176bfc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 09:53:28.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcRnwNRFsMWbL+7fZk5DEb9LKiH2CvAyhcLsCGdMSyWORZV0my6sgu5hMM4Z4dfWPZvSB1S/3SgPvwun2Pq1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3577

From: Jan Kiszka <jan.kiszka@siemens.com>

While our userspace tools gain libfuse via XENO_USER_APP_LDFLAGS if the
registry is enabled, libcopperplate itself does not if it includes
libregistry. Fix that.

Suggested-by: Aaron Marcher <aaron@sigma-star.at>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
index c6edea9853..0dd52c7367 100644
--- a/lib/copperplate/Makefile.am
+++ b/lib/copperplate/Makefile.am
@@ -34,6 +34,9 @@ libregistry_la_SOURCES = registry.c
 libregistry_la_CPPFLAGS =		\
 	$(libcopperplate@CORE@_la_CPPFLAGS)	\
 	@XENO_FUSE_CFLAGS@
+
+libregistry_la_LIBADD =			\
+	@FUSE_LIBS@
 endif
 
 if XENO_PSHARED
-- 
2.35.3

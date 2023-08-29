Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC14F72
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 09:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX+54agikwZjgMQd2hYytKcaCZakHC/OBPVSwWCNtWdX+yCACjW/35PZL57LzP5rfxGvC7fpWWiV99VH/7KYWi8o3P6GkIxxvT34GmSsxAHFm5r19BJ9O2fgG60FebgjG+66ZV/uNNeKK8S+MS73UG9uRPLDoOrTogUjC63kJw7h9BDpXTUyfWLvfHMb1UtY9QUKYuyMDUmndgnHC//Gc8DWxnfhmzAOp1LlzzO33HHPimVHzJvNVw+Zdl0O31cnICgnFztwDBFCK3rdyoweXw+fXv8Y4H/ji70H+U4jV/pfE91aRt2h4bGyslrtAfrPspEFPMM1ONTIdUiaajizcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQmOwA2zZTvdK2PgG+WxyXI5Khgvc1u+2e9ODrqJqUo=;
 b=Utdul0TAoue4ltUQ9u1VTfZkW5EdoPTgsXD1xMMV2iW/BMywVBZi32zc0iSpe4iMI2sR909Jffar4LwEeFEdvGhhbzNlTX7CmDlskG2VUg+MdQt3cOMUOwPvhBxGReNaUlIacoFTwQWtw4q6aqoBo2vFtQyWTD6c2b9jWeI4zLEQpZAey6sOH63/dbUCCoXWmNiA9H+aa0F3SmfnL90fL2N6XJ6mcBeX0NEzrT2jRDNiQEoc1WEyi8J+CGCQhoo4ojxPggsMHSQ7TRcWeTB5kg317FY7w+h3izHain0m2idVh0A4LAtdY+pEn5qewEfjYxcGpSxX55OsmhHmylan9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQmOwA2zZTvdK2PgG+WxyXI5Khgvc1u+2e9ODrqJqUo=;
 b=CjKXCQKRtCp/CcL4AhKl2UeHNyYrx3zEnxDOHHA5gCWXht0L0fcevjphHnojqFypSRs1H37RuSF/hA2bcb4r5S831S2Azq37tSmg63Vbs+IeCs282sOzGNrFKB/ugEqQRK8B678C8zV+WScNeYqtZRMJDYpg9ntpCQHlYEA5VOEtPdHopgqqynaTdB8djKUhuZT7X8+9ex3KxE96hrOcT/bSJBuqAbkic1IyaodyQ8L4HoSXrtDXlrs5IAduSieFmT/fJQkc+r8rx2B3H1v4sm7Bw3IQvbk2cynr96P4Atc5v2ITQILMKaqqDhNjOP0j+YkuyQCGzxm8n2Gc21ua+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 09:40:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 09:40:46 +0000
Message-ID: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
Date: Tue, 29 Aug 2023 11:40:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and 4.19
 backports
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: d95fb251-de1a-4ba2-35ea-08dba87405ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	acOSywyqZRnCiHWRHd7NBY+6fKRgqPC9W+Mzrw18tCtqew/jsU2YpC1oQaYMrJAujzmysnMCB7FG8tmr2M8Xnlal8vb4DB9BjIEH3JAFIoPOzJekKqAbo0QzM272otf39Furp6+W57WPyvdW+exZf22HjTDi5gCjmpkHSwCgGU7HM1nO1ahjXrg3vyP9fsgkXJF80oymy9xU2k8loORbOhPw0Z3aDdrzWDP9nSgqNdOKe5WwiDi9x9JhEzl3FwsSMqmPM1lwwU6xhRg+bz6gPGoXRI+RIQofPR7PkGqdClgBx4+GMyFYOm1rwGEwlB+zFl3+Vrp+4tGgXyNc7TTLEg+PYffy+h/gYidjExPwHESovZiHs19kXNo6ASWWk7Ab3YAwskne2w0SBFTrpevSzuNTxSJrZUdWuQ17ANB1LnDFwkud7mfPlEOtRjySo6xnTzHvtMjO3lFAGW2Dl6hAhzMt8sWsAcy0dZtSRcmfJyW26jYdEEPZTVNImkb2YJHPqNjwMEHQK4c0CGyLoMECfwffmcyOy2IjRL670sRppMbLs7migEO335ZHBDJftgz2XWrJY9bZdoVGJv9bOK4iLKn8Mca9KaZXnTDl2gTZ+AJIShEVV4WZHHLUM06diejTd3RDNCR8a3J8V7OcfIIDYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(186009)(1800799009)(451199024)(44832011)(6512007)(6486002)(83380400001)(2906002)(26005)(478600001)(41300700001)(4326008)(8676002)(6916009)(316002)(107886003)(66946007)(66556008)(66476007)(2616005)(8936002)(5660300002)(38100700002)(36756003)(86362001)(31696002)(6506007)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJNSE13bzZ3OVgyMjJSeTZ1VkttS3h4Rm1la0xITWNESkQ0TFBIQ3JTNzBw?=
 =?utf-8?B?VlVGdXQ4VHcrb2RwSzNsdzcwUzVnU0RTT2w2QmJGYWFGTlZReGYxNWNSWlVU?=
 =?utf-8?B?UjdEaWlWdzR1bEJGMFkwZmZjWjdCK0YzUXZUOWNsNnNiYUxETnE2enFFWVlV?=
 =?utf-8?B?NlZvZHVhT3N1bEFUT0ozbFJaWW9DU2cvZzFSRzZYejM2NFR1TkoyWmp5NDNT?=
 =?utf-8?B?TGJORDltK3o5d2xOMXAvMUljVHhKS1pHZ2xGajBjUHc2OUJEK2pRS0JGcmw0?=
 =?utf-8?B?bUZDeWdTZEllcEI0VzZYeHVPaWdwb3h2UGJFZ3huZkozRytDQ2pXSjFJNzVy?=
 =?utf-8?B?ZU95emhuOGpmWWxsdUMwUzZBa3BzNFFjYjMzTEZRVWNoeEdIWXpEVVN0cnNY?=
 =?utf-8?B?K3NCa2x4UXFhbS9FaDlGRXRWVmFsUnBVR1p5SG1TV3Q3d1ZrTjNBK2UrRjRO?=
 =?utf-8?B?NVVTSU84bk9FbE9Yc2ttK0pnTEp2MHZjYjUwQjEzT1cwd1hVeDRwWDMreXBD?=
 =?utf-8?B?WGVqRE9rNTdFRnJNdjVpTVdFWEF0RkQ0WnJXL2hOSjFvbkp1NW50MDNXNmVZ?=
 =?utf-8?B?aXMrUmorNjBJOGZBdmtzUVU5NUhoamNnSWNWTE1rcjdEeEVUNHBuRys0NTcz?=
 =?utf-8?B?bjZtcHd4elcxdktqcGczdkZlWGxyQytrdVl1eHZNWVpZUzVXdU16dzJuNTk0?=
 =?utf-8?B?RXVSYnk5VWl1b2o1dlZxNEV6dnlOdDl2VXdKZHg3OHQzdlBpVktFNzNiYjlG?=
 =?utf-8?B?bERUY3ZSTEpadkpjTzhKOGFpU2duZEhqRTRKMkRhNXppOXdaM3Z5VldVK21N?=
 =?utf-8?B?dlpGSE11c1ZBcnVqRlFzbGx2RzA1Y0s5L3BON1ozRXhVSjZXaW1Ka2N6a1Jj?=
 =?utf-8?B?V21SWnFWWlAwbUdpaENSblk3cVE5WmdFc1VwcEd3UEtSazd4SnRPV3BtV0pa?=
 =?utf-8?B?SUw0Y3JVZGEzMWRSRzBlREIvOVVKcUJzcGVBZWJra3QyZU1hV0cxRUFJazcx?=
 =?utf-8?B?bGV4UVY1ZnAyTU0zcnpPQzhJUWJaVU5oRlR4NGpOK2JnRUxidmtzaWFDZ1ZB?=
 =?utf-8?B?dHAxbVhOU3Bzd0wrZk80WHhGLzFyWXNHeVhINVV1bGluaCszTVJWOEZVNE9P?=
 =?utf-8?B?MVBTU0FUZDZSL3VLSWVqMEhxazNBNXI1b0hNTUp4c1pqWUdEcWcvZ1ZQVWUv?=
 =?utf-8?B?VkswcWhDVm40c0lFV2NpZUJGcnd2QndsaFhMb0tuSm5UTW1DYzJEODBnODdF?=
 =?utf-8?B?aW9sM2ZIMFlYTzIwVHI3T2dpeXZncVVGN3lpZ0hqMGVTUC8zM1dySnFLOEZm?=
 =?utf-8?B?eFZmcTNDVzM4T1hJRVR2cDcvSTlJVFpSbDdHOGtod0xwMnhTaEx5ak1OQldn?=
 =?utf-8?B?M3h2UTVtMDA0bzdjTHlFUldNWFUycTZPMGZkSU9RcEp4U3d4Q1RUTlRObjBj?=
 =?utf-8?B?WjhiZU9acTM2NkJXeWthaXhKay9iaHlHYXNQakxlYUhEdmoxTTA5czB5cEhz?=
 =?utf-8?B?SjM4eklzRzNOdmoydnlKTHFramtIckRVT0FXSUxydllkK2JpcjZVV1lENmp4?=
 =?utf-8?B?K0lwVEFScEdpQlcxQ2xqTktTa1BQWTlGVmlVd2RWTjB3ZlBEQkVRQWorK1Rk?=
 =?utf-8?B?R2xsbXlGVlQvenY0ZW1lclc0VktjYjFOQnZSRzlkV3Bia1dMMW5iS0Rud09T?=
 =?utf-8?B?VEhrTEZ2MmM5M253NTY1YnhjTU5HRXZGVkpzZDNjZU42RXdlSWdKMTU2RW04?=
 =?utf-8?B?Yys5YzVIa1dxU2NLM2RmNjhQK2JGbzRmc0lNcS9XU2pLcTFJUWVYZXpLSmN3?=
 =?utf-8?B?UTdEWXhVRXFzdFdZK3piK3oxcDd3R09NYWNTa1VYRXRxTjVaUGNTRk1LQnNU?=
 =?utf-8?B?ZnhIVTJ1eDhObHRCQ3RBaTJRajFlaXlPOWJpdDZOUkx6Y2FiRkVkSGpUM015?=
 =?utf-8?B?NkljMHdVcVlZVEZUSFlWTFdSM3l3VW8vd0s2QVNkVTFkbmNiSHlLWEhuUWJ0?=
 =?utf-8?B?Yk5lQ2MzbTBWTmw3eTNjUnlpT1grZkxqUzdqaGN0eW9LY2pvZVB1a1JHQmo1?=
 =?utf-8?B?WEd1aG9vYW9QZmdBUXJuaUwyMlNidGJpd3QvTkdyWjlWeVBQWktqSUQ4Zy9Y?=
 =?utf-8?B?ZWVrRklQYm5YUE9ramFZMjB4YkZCcTFQYWhKRHJLTjlyOFBJN3l1dXhWUmpi?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95fb251-de1a-4ba2-35ea-08dba87405ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 09:40:46.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHGtQ8J1Z7Xuct4bi/0hU/d1Z+/AO+GhnZXAQwEdM6E52OUpBLCNk9I5ddtiM34toMS0yOP9LEEVGPX3w+N/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5538

From: Jan Kiszka <jan.kiszka@siemens.com>

Some stable kernels gained this helper meanwhile as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index ea7ed3ad56..a533d46690 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,7 +54,13 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
 #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
 #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
 #endif
-- 
2.35.3

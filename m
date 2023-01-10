Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB407474
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 14:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYlorENBpLDjEEpItcnNrubCnXMfgZYCYyGve3v2PcZ1xT1+zam7JAJoaEMOfV9BO/j0LWXLqeZNvTNxmvoPeu2wZ4V6pxco1H2e9iPi8O+I6CE8vPBYx2O305GpjLvLgro7h95ceXDRS9SWJIyBQ0lxy60x9fAiMZxb9YFlXrwdu9Rj6CYsgthhpG+SnYcJLGIQx/2+uFhqMzWUE3SxBR/2zUR8n9VrIJsRnrt2LB766VuaOM1aYO1EN043hkPJdmh8/510xJl4lmYHUYCAokBkyvScwfEu57ZE/QTbxlKqX29I3G1fZsiF8pcENP2vIS/ab2WT9NvBziq53h6sSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSjptlRSLXqnEjM+4cOPnZrS+tCqjuyZkCidADmTlr0=;
 b=CQ9AQ/zt1hiM+X13FR8BWjGV06+AN1HB51ebIBeSrX66vr64nLJwaoa/ie4nuyfwLPPdeda5rOq7ZmiQ6Qusj+RViZYw+rF1Po8yp27MTFE5p7EgQIkUHwk5v4t1Pvu23Qa9VKi7ojf+m34dTIaPQ+AJq7RBSdB4gKSkHhZ6j8p2vrdgtj46KsbWvwD8HoVcv9Al1AJAMh0ggLMRZ67pgZJA8tH8AONYTaaLXktPJKLKB6cwich4goWq2O1iqfVxUq5Fl116yYvlejS/crvlfwvbT8eGjWv8unUfgx1NsHjRit2QMIkyI8V5w1RBU4aAPs1/r3rDFvsa9JfIqAcXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSjptlRSLXqnEjM+4cOPnZrS+tCqjuyZkCidADmTlr0=;
 b=U/0f3Kr1JegKCxg2JLZ4x/jG0x0Kam6e2ODZHxkM9SxUexcWsb46YBSaq2f3oKZbtn9OG7cl2k/6XLEtaVraekHILJNToKelktI1PTp/cxL5f8cJmpDwqzt7cvLMz76BCBYfFh9NF78U1hCwhXhJ7osvkvmvNkbp+mCoA+CjyTx5t5mnX4vKPeSxH+g9higRPYUy8hJn/eIgJ/vhcxJ7c1v72VToVxo1Uh9BSePehDp+Wv4M8uLaTyhrekPULtvrcDf+33XC/yTiRjdttDAoU/LiR+5UHEjH4z04URTw1yZLFd6oSX+Wc/Bj3khknctPxW967ajXSoBr1H1iKLu+lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:06:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:06:17 +0000
Message-ID: <240a51b2-d441-2b53-a414-020b08292af9@siemens.com>
Date: Tue, 10 Jan 2023 15:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] ci: Switch to native trigger
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:610:57::38) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3983:EE_
X-MS-Office365-Filtering-Correlation-Id: d97e6a98-e286-4310-5d21-08daf313d70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePNJIaGUeQU8z6Q7qaJ1DtkWnJ/MszPhoDRNv0qF/Gvgn51V49eP9cerNsAUOwAXETmh8+8vVHBan+p5ME/mf7QqKDtSTU9MzQhbotr/TD5+QhoTuvabE0XsICt4SpdUIPeC8SZEErOPa4ESFpuONGP1I9VWu2Z7qMDxAcTY6nrTvYugTk2ao4IsrX0oK/7R4os9kCpQyX5TfcCm3meLGMfbmHZy2b/1ujbGcrG2eRNUxXe6LYJkhy76RJHN3/fN7Fh+VRIY5nhNgenz24/1i2ByXdruKY/hSD2vM+FUfKFVO0WESyxqUf9N32yh3EXh/4iDjyFBPiy6/GJfAGFtIGDiHQmN1+BkxYCHNc/TDNVsihPt8f3IW1JDJS2rA3KdeoUQtD2VfGOXrkgsDrz6F3VYhcxBeT3KaOFaEgnTiFk4J3Ub1HGHZ1tLbr4FHCYFHm9KKrO3DmvLD2nshPtsKqqUBi5BD+tdQnGbHplFbtHscD0oanpNM9QQqQmzII8+OWKWndZAL1hBXJA5A5Lb8FrLn9cumIswe43ahHzqa2WOrYKCMMNoTh3ft+NxiEa4Y27WnkHcptvaO1JqIrp5fpA6xNekI5LfIjR9LMfyhzl4xNPiv9FY6p3/j9i7K94ED19pZTMOrpcECUktilHY2Bws5LkbDWzW/XXQAg3XxNNBNakmzwmElvviWcvJ2CU8cM8EPj20bjGqFpK0O9tSmj2QOa1UaofLK4nHvQTnNUujPsdHJmwUj4lf4jlWUF+h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(36756003)(186003)(26005)(6666004)(8936002)(31686004)(6512007)(6506007)(2616005)(66946007)(5660300002)(6916009)(66476007)(66556008)(316002)(966005)(86362001)(31696002)(38100700002)(82960400001)(478600001)(6486002)(41300700001)(8676002)(83380400001)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGJjb2dBV3ZNeGQvclBxTVg5cDVVVW5UQ0M1ZkZmRk91a2RCZnpUd2Zra2NH?=
 =?utf-8?B?QXZMaGd0WUVRZlBCMm9RODh4dTZWTjNieHpzMEVzNDNsYmtueWlOaXg2MUx0?=
 =?utf-8?B?b2FMTWt3Zm1yZVQrTTMrbXdaRWsrNTBWaFNXdWR2eTFoRU9lWDhFK3cxbmty?=
 =?utf-8?B?dzNYT0FCcHZGYi9hY2l2SHVaUXFEWU9WaE45Si80NDVWc3lvNUdrM3l5RWZi?=
 =?utf-8?B?ODU5ZVE5bGtKbjBlaXIxWHAvUUpPZWdnVFFKNGp5cGgxbVRJQjdjQjBKSUFq?=
 =?utf-8?B?T2JaS050eFp0TUM1R1hUMnRYRGZJZERkclNyNnpuSVRIYTQ2bjYvdi9OWndB?=
 =?utf-8?B?bDFmQ29mdkowLzVleDJhS3dkWTJiWEFBT0FJNTdhU255QWp0VnozeGMyVjJn?=
 =?utf-8?B?UlRRV2M5cnRFTHhxd0xlVEJKY3lZUVZ0ZkVqVlFaV2VrUS9POWRseHBjdlZn?=
 =?utf-8?B?VVBQNWsxQTJxRWpoSGJNbmllbXdmM1J5UEExL2J1YjhYeE1ScVJSN3JieldU?=
 =?utf-8?B?am1NdHFpTXQ1UzZva1dGNzBxcUNIaFpwZWh1NUNTaHhKc1hhSE1va3Z1aEh6?=
 =?utf-8?B?MnVOYXFjL254K1NRYVA2OWMzMDhVaExQV0FpdVYwL2l5YmRPT1Q2MFI0dVVy?=
 =?utf-8?B?QTFJQVl0dHFnWEt2RW5LUTdFaFIrWWsvMXF3dUxxMHNHRC82NWxpQjd4V2Uw?=
 =?utf-8?B?MjdXZ215RWVudnRmSE1UQjN3dkNoRlFyeFJIV1FtRkFQVTR6VWVmK2tFWHFP?=
 =?utf-8?B?bEhoQWUwOVV1bFhjVC9SWGhaWVhuM3FDNU9YbCtjb1RMUnBLNkRVeUtzTXB1?=
 =?utf-8?B?TnJlTmw0aE96OGgxaHBsbWppcks4WVl5aTRQMEFDRzY0YlFoZERVMk1tU2sz?=
 =?utf-8?B?M2ZrNjdaYmtldHE3UWVVWVNHakRNdzNXeDdQK2R1dWQ3cWlLZ3dWN0F6OENz?=
 =?utf-8?B?ekhiemdYUXFSMzdaeGN6K3RJWmlBbjZyUFlYT3pIUGp6LzhTa2htUHY4Z0Jx?=
 =?utf-8?B?U01MVEIxdDM5eXl6S0Z4UzYwZjZ3ZlRKODBzUDlvS1c5Z3g0MGhsYjJIejFu?=
 =?utf-8?B?YUM3QmVhQ094SHd3V0xwckh6bGVKZUYxdkFjOTZBT25Db09TRFRQLzJ2T2hT?=
 =?utf-8?B?ZnAzdW9UcU1xc3ZlYkZkZ3RmazJxZ21tTzNvNEVCcVJqTkxuWG9URWhMQXlS?=
 =?utf-8?B?bFpXc3pKdXR3MU9sNDRkZHlCMHdRU1JkUUxhQmU3eDVleTRCdCtwaGthVHZH?=
 =?utf-8?B?Y1BuNEdhaUdWYWcxWFVPYk4zTkhSOHVVMzhNOVRPYWdRdnNnMzRiVTEvblR6?=
 =?utf-8?B?VXhHZVJscEhjM1FKL29qTS96TEM5NVpCZ2dkUCs2ckN1cm5DT2tiRkRrZkQ4?=
 =?utf-8?B?c29vZCsxaHVMT00yeXdCMGRqb2xIdVM4Slp4QnhHVG1UYXl0K0JOaXFRVkZ1?=
 =?utf-8?B?dlB2OWREWFlBOWZaVjdwaVUyb2YrUE1kUzk5dUdQWUZrZzAxcGpCSzVtTG85?=
 =?utf-8?B?NDRMenorL3FJcjNWZ0pVZjJQVjlQL0s3cnpxQWdlQXFkd29jd0xkcUh1V09L?=
 =?utf-8?B?ZVJSbDlTc2FnNXpkZEtaTEsxYmd5Tnl1a2VSMnJBMTNPeFc2bWN4N2laM3Rt?=
 =?utf-8?B?a1FVMDdsVHI3cmJHajlacG41UVRaaXVNK0lhZy9MVmQwRUYwSWVUbGlpTWFk?=
 =?utf-8?B?anBjdzJjanlWSnYydHpVTGppOGlmQisycWJtMG5Ha243VkFZa3N1WXZmeS9N?=
 =?utf-8?B?UmNOalRtakJCN2lyZlQ2bnhBZmlLdXFrZ3dlSC9BQ0ZoYjRaQTRrTjI3ME5z?=
 =?utf-8?B?OUxYanFialMzMXFpNWZ0dXhCZDFsdWFyNnpoUkxuVVFaREhSSytIYklzTEhu?=
 =?utf-8?B?TnRqeTNlamszaUtBSDhUcEJGQ2Q5VW1BaEVPdUJub0FnNUJkclNpVXowY3Ja?=
 =?utf-8?B?Q1VVTEptWTlsd0ozZ0o2bTZXZkplczNzOThHbm9rOEFaTWdJRTJ3ZFlka0VY?=
 =?utf-8?B?dDgrRGh3THJvMGRRZW9QTkdYR2phaUJZWGxOR2lvdTZxYVFPNDRnaFpNcFI5?=
 =?utf-8?B?MnVZWWx1MGllNWdReThQZWozZUtSRTZrU1VEVFlHMUt0MEdmaTZuVCtyeUJ0?=
 =?utf-8?B?VTAyQTR1Q3VxemlSbGxTb3pUMDd3WGpCMzlRQ1NTN0dNWDFSV1JGSXZSRUZ3?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97e6a98-e286-4310-5d21-08daf313d70f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:06:17.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUqqf59VWKEpe8EtHTY0onI0BRolsun0UhrSNVuONUwJW3bx/ND7D43jNPr1ys9s5UshXxu0hgIwWJ7gZrQN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3983

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that we are running both pipelines on the same server, we can also
make use of native gitlab-ci trigger mechanism. This both obsoletes the
need to configure a token and avoids starting a real job on a real
runner, just for calling curl.

This also improves the visualization of the two related pipelines in the
gitlab UI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - keep triggering "next" pipeline of xenomai-image

 .gitlab-ci.yml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4d207dbd61..a80b4dc277 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -257,11 +257,10 @@ i386-userland:
 
 trigger-xenomai-images:
   stage: test
-  image: curlimages/curl
-  script:
-    - curl -X POST -F "token=${XENOMAI_IMAGES_TOKEN}"
-           -F "ref=${XENOMAI_IMAGES_BRANCH}"
-           -F "variables[ONLY_RUN]=${CI_COMMIT_BRANCH}"
-           https://source.denx.de/api/v4/projects/479/trigger/pipeline
+  variables:
+    ONLY_RUN: ${CI_COMMIT_BRANCH}
+  trigger:
+    project: xenomai/xenomai-images
+    branch: next
   rules:
-    - if: '$XENOMAI_IMAGES_TOKEN != "" && ($CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/)'
+    - if: '$CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/'
-- 
2.35.3

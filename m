Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28A495C1
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F2di9Rt2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpxPWS6QDvnE8ltO2IXTE7RFkUnC+AN5NoBckuMayZn9PaZELu9+aH3s5Vd3x4u5C14B/CVxyG5LJmqp/KPNDHxKMg0cwAMGSRPAIKWd8JwmdrWpyFJT+x5Du7PlKCiohmhH6nP2Mqf5aocCjRVDOa5Om3aOwieMaIOs4+D2v1q+Ff8i7ldNXf12jp+9TteNkJiuJupn0+Mgj+abNgTYoc/jfQP91g5GK0TdpAUxXv2ObQ4WCPNvz3noqFAT5Am6J/caa3RcUmuOSgJ+HOHCF2jbOz+BsW/JrsJW+J8YZMEaJMEctiZohj6XrqEZO3NYslkKZkE8KHHNQKbOKncrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEjESLmllJ3zZZihNzUfHUdj8SHXIEqoOFougksyWmw=;
 b=V9DlY4Nu9sxzweePGO003shL8FaF8ttK6AkT/XWTO5dXLa/K02OzpFSG4FSt1zFj1tD+DqkQ22vRtotduNU+AsRDihv85oAgz6riaADJXUG+pCb/2rbaoUI6jNFevot6XBYdCmqY1ZIEVvZ8Gcn6ye0Z9SEZHC1O32Uv/J6ZvywluO3alQobyE/3hKtDiTqX0lUbhkj4R1St2lk5ZDSbvre/RJFE9+l4s8d/BwAquQbBI7lexmMq3q1SWG8KZytYw8VV+p86rrr8G1otLFkVk/aZkYt35I/7vVyEXhlKnytBwq6rPmkg0fxgIvKDsuHO056DVmiiM1kkmh5YGUpZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEjESLmllJ3zZZihNzUfHUdj8SHXIEqoOFougksyWmw=;
 b=F2di9Rt2kqzyZ7yEh0vrn04LxZvzK37ovMwMiLPa2whr3M55TcTt1mWp3ulnpVcEVb2pMx1fq6lGLB9BpSb/gUu9nY1SAZ0SrJHYW0j+qSFxE6fqpT0UBvgIu9MB766rDyHKHWP0kC+WYU9KAygYCn0XMEAHBlR+aQ7WF2YEWzFwvFlsNW3TXSVckYl+WsNPz5gC4+saesTRRnkhmWcviJ3aLy8Xu7iZqa7ZBDE1DVsunsr+83gvjaatjv5a1mh5go49Yg2w/D9wb7QfU/dzPPkDqjUErRdCKYYJHMK72ulURGZwmV/uZL9qvKM1PMBVAnhpjF6TZERi1JeGeKcbew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 18:11:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 18:11:34 +0000
Message-ID: <fefd5b13-cde9-4232-b288-a21d211c6fce@siemens.com>
Date: Wed, 10 Jan 2024 19:11:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai-3: Fix race between
 do_prepare_build and do_prepare_debian_rules
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cccae6a-1cd6-4555-be17-08dc1207942e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DXdxK3nWdm7aQElqRtkwtmtUU0Myh0xUYR/iCj0RmAq/hmhyXom+1o/QPJ2B0TcbreO8PrO+6HTzNzFM/ixJXoddCZshp3z+aDO/ohXOGDTpBuQgZUVrxSqXSkjksoHdDLppmoWYaKMyEJ4CboAAkUfwXscU7v9y72SKj34JutIUkkK66k1/wNQb/V8jKAQ1RQsnjkr5OZ2X98+BmB52abtNBPfrU+uz9H6wKziWpU3EKeQ7O4eFDAmqt83N5lL5HTSd28W5u3hoQUZXdNpeYOpviZwtJoSAML1TJqBAKopRKWFwhwrngi+Bz5T3rAgHjyPDTqwHq8cD6cyooa73AVwaxA54/+ICdSWPMDvrrYTj0OYqc/E9rnyulj70ssnwQ7dnIB+CxGzFVJaTJkTj9cn0FqSf6RCCjt7FtqeyPbPc+KiE7Gputv8bq8dRaLxufDuYuDhsfvJi9sD+ZDTsjR82pjhZEL/1a3eJcgzEV/AzbcV4+r9l5mnP92jlvk0ugKNz+7H2M1+kHNSegwcKN5yHUK8vNyiIOq1ORVO7eDTOKyKisQghSMY2tBHsU4SukimK8RPd22ice5yDsmQn9AXG3W5BiiUYoYiuUzQ0gIhe/Ej3KVhjeJ5RNZkuxJULHqalfe2Gi9XEOzB1TWSfx9ot/lKe7P+ffQ8VY9DqhLAN9yJLvltHAltB7uAW+ltRzkrvZj51H5qO1oDOxDeMUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(6486002)(83380400001)(31696002)(8676002)(8936002)(66556008)(66476007)(31686004)(44832011)(6916009)(316002)(66946007)(36756003)(82960400001)(26005)(2616005)(6512007)(86362001)(6506007)(478600001)(2906002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtvdUJFVjc5TlJkYXRyKzMwQ3Vkd0xQMm5HMVlIOE5RSkpZY25wMHpSNDVR?=
 =?utf-8?B?dFY5Z09WS3FpYmZUc3FrUEZEcERIaEQrVXpDWFc5QUV6azBPUlhJeUhQdy9G?=
 =?utf-8?B?bVMzMmR1ZGIrQmhCSHFUYU9pWXVYVXBxdzJsS1hnSmhUZEZNYnQ1S1Flbkpj?=
 =?utf-8?B?R2U4R01nWGhpSFNDbWRBQ2N4MG9oSm5MZjlYYU5VTnAreGpQRVh3QUtZMHVO?=
 =?utf-8?B?MExNRVc0bHlvejBKL2tXdjJtUWQ1S1RFazUrVVdueXhMYUs4TGNLY01Fekdq?=
 =?utf-8?B?U2JnWEcyU29Ndk80OG8xUTZlRHZIZFd0MmIxTUlubmJSKzFRUCtRN0ljM3d1?=
 =?utf-8?B?RldmYjBHRjRqcUNLcS9KaXVrbzFadEhaNzBvcUtFeUs3bEhoaHRVU3g2VStH?=
 =?utf-8?B?TU5RSHFiQ0dHMzdENXZGeG51ODFvWmw3Qkt1TmQyMVp2ZEVtSG15SUdZOFpJ?=
 =?utf-8?B?ZTJjUjljTVZuVVEvcWZiMWlEUU9pUXEydGJsK21YWTdEVHJ4NE1qYVFiNkwy?=
 =?utf-8?B?T2dkMXIySWljaTFuVEVPQ0kxUXBzOUxhNloyc0I3THlmaFlNR3JjaTJwVEFn?=
 =?utf-8?B?c3hWNEh3ZGNGVzBzcDhTT1Jtc3J6d28rWmhPUi9mSW9VK2JLWitneHZpRmhI?=
 =?utf-8?B?QkFrUzJ6Uk5WejZBM0dRQmpwajVWd2p3dTJ0WHpXUEZWbERIN3BkazdYczZX?=
 =?utf-8?B?V2piYTN2ZzVZc21XTHkzemIrb2dham1ra1o4SURoWHlFNXA2NmVKNDdvL2NC?=
 =?utf-8?B?QlhYaVcxbXlSNmpUWWZndndzZXVyelpzVGZVU0RXLzJEWUVBZnhkMVRYV2M0?=
 =?utf-8?B?azB5MlNhNE15VFFrbERLVStmUnVFeVdFKzg4NllEc1B4YUt4Y1Rxc25iYm5P?=
 =?utf-8?B?NjZ6TnI1ME1EWmMxVjJxZjdTZllXZ2x6WUpueGMrMXVEQUdwWElqaE8yN0VO?=
 =?utf-8?B?QUJ4VVNtREMzWnB6WnlMQzNRc2VEWVhHQXV6M2xMQUlBVjlRRE1IenI3dEU1?=
 =?utf-8?B?UThIZUtkR0RoZUlaOGw2dEhLWWs3Y0dUZ0JsV00wTDN6WnA0ZXVCYXFCc3Ew?=
 =?utf-8?B?eWgvbnVTTVBwd25oYU53WkpXa2t0alJ0NUlRbStubWJieVMrbnlhUGhxM0Mw?=
 =?utf-8?B?NVd1U1MzM0RORlhIRnQ3OXVnMVppbFY2U05OUHpRN3c5dk9EdFhkYStjKzZG?=
 =?utf-8?B?ODQvd3pDZi9PdS9sa0VrVXc5OXhNMmhEbkZKblhLd1JJVUs0NEZzdHh4Q1Jo?=
 =?utf-8?B?alBkcTRqeUg3bDJlOTJWS2x4a0dDZzN6dE5YT09LUlhpenZPU1Z1cGxiRzBT?=
 =?utf-8?B?UDV0RWZxMVVmWktsNmpDanM5RVpLSUFIVkhOeHJhVDRBM3ltYjJXTzhDdlVN?=
 =?utf-8?B?bFp1Y0dBd3lwU0NTdjNnU2ErS0RNc2Y3SThhVTFGNzNRbFMwWDNMblV5dURZ?=
 =?utf-8?B?UmpUNFo3UkZ0b0tWc1lvcDlaYzRvL0dWOWJMVlR6WUdmRGVhRTBVR3pQUVBF?=
 =?utf-8?B?NFpMd0FjSmxxMjFLMXEyMDBVaTFQSWtRVHgzMkxaVU1yemw5TlNGcU1WVXpy?=
 =?utf-8?B?WDZSWkNlODJyMFRiUkNrOUpaNTNTRmQzcDBtMHRzcHhXbTNYMysrM2tnQTAz?=
 =?utf-8?B?NkJUNUMyRVkxRFZZblNmYnZxd2pXZmRid0huYU9VeTNKdjYwRE5BWEUxVWVO?=
 =?utf-8?B?aHRtL3o1amRJTDMvN0F5OUVRSU5jYkZPTllzM2xRU3RvUjhoSzJSeC92WjZS?=
 =?utf-8?B?RzVGQ0RFYnZqZGlUVE55Y0krclQyYTBialhwM1FzeldmSnFVcFphd3JMK0RH?=
 =?utf-8?B?akt6ZVRGaWt6YUVvSzIyVG01K0M0V3ZxQ1Z3SlVPeEJNa0RuVklzTXAweGxH?=
 =?utf-8?B?cTFwQTlpZWNNcWg3ZU1YRnBJeFZ0TW1sNmFqZVZRSHE2L0JtS05WRFAyRzZS?=
 =?utf-8?B?NnNxWTUwMldsZXluT2hqTTRXTFZLLzZhUEN1Y3ZTV1A2V2dWR0NHcERCdlhX?=
 =?utf-8?B?U0RPSlVGakxac1A4V3EvRHZncUZtSDF6SVk3QkVSVGN2WlFFSW9tT1hudnI5?=
 =?utf-8?B?UVBkb3JRdXVsRk1DazdidVZVbk02TzdGeGhpOE1PdUozOU9XOXFPeml5OTFp?=
 =?utf-8?B?ODJyV0IrNVViNDdrT0RBVm9oRU11WGxwUVRYQXBGYU45TTBnc2p0VUZwakdP?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cccae6a-1cd6-4555-be17-08dc1207942e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 18:11:34.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R4mpthn2s99T8x6uA5+OIFF5Ko5IcO5jiwGMYAzH1OFsODQFO0dG3x1w9Nt+Zr89yNPPOs9ciQnn/gxHuD8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7041

From: Jan Kiszka <jan.kiszka@siemens.com>

The former copies the files that the latter first wants to adjust.
Serialize them to fix build errors like this:

ERROR: linux-xenomai-3-9999-ga72af45114-r0 do_prepare_build: ExecutionError('/builds/Xenomai/xenomai-images/build/tmp/work/xenomai-demo-amd64/linux-xenomai-3/9999-ga72af45114-r0/temp/run.do_prepare_build.57941', 1, None, None)
ERROR: Logfile of failure stored in: /builds/Xenomai/xenomai-images/build/tmp/work/xenomai-demo-amd64/linux-xenomai-3/9999-ga72af45114-r0/temp/log.do_prepare_build.57941
ERROR: Task (/builds/Xenomai/xenomai-images/build/../recipes-kernel/linux/linux-xenomai-3_latest.bb:do_prepare_build) failed with exit code '1'

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3.inc b/recipes-kernel/linux/linux-xenomai-3.inc
index 64ed9d0..85ed105 100644
--- a/recipes-kernel/linux/linux-xenomai-3.inc
+++ b/recipes-kernel/linux/linux-xenomai-3.inc
@@ -22,4 +22,4 @@ do_prepare_debian_rules() {
     mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
     mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
 }
-addtask prepare_debian_rules after do_transform_template before do_dpkg_build
+addtask prepare_debian_rules after do_transform_template before do_prepare_build
-- 
2.35.3

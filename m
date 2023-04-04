Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269A361
	for <xenomai@lists.linux.dev>; Tue,  4 Apr 2023 06:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQlCwyd64quIiT2w3L70SjknSL0iIf3iCJl61D5/NUXX9zNs0DuiawI+ibond8XkUeghoT9laZpyR+nNsF/qBX8ir68yjfgSL/y0T2XeGWAFj296ricp80ydgPPaoJf9x6KkUXsAsoeW8LvbVOhE0zqdI750LPPuRIS6Z02EjQPCAzLjcrsYq5iK6JU3nKw+slKVhqZasGeyYgUWB7i1qKIOS/udBi0y8E+e6CFwtmdJiw6iOdiL3BaojEJvwveH3PJl78CvBJTN73SMxAUPTVIhJwp/6HLcFYKQXHxbz9vxVkj47ai/6d/UgY4gtQWNmXaegCzFDh29+La3159X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkqH27A2AtvOgGRYA/gzdtB4lDSjJ3M7ga+2Rys3MDQ=;
 b=ac49666fP5hmzH0S1YQArQfCY14s2Vqq0oK/6oe38pSbnrJGORX9PV8/e9TODHBK+AOOnPffiBzNgR68tIxDa9c92nIl9nARFzjOg/wqiYJLjsTZdmWW5BC0akqRmqcoOb9dWimsHLaOgBLBnNWS+kP/gorAPN0bHMnozQqNOnV2OFvE0W8heCrR6UN+uVf29bNi3DNpEOJZvMCNcvW0d+A7Dnj8QwGiJ2ilC7wjRJDCcsQtFhNEI2e9ldPOu9sfwB5Tpe9dVoiG3o6EeESmjApqsWniL4A1dg7qPacMKYGoy291fRTz9AI/EU2G2W5puBrIx1PD7g/TWOmNuQGHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkqH27A2AtvOgGRYA/gzdtB4lDSjJ3M7ga+2Rys3MDQ=;
 b=AOkyfmdZFSStpKJneDDzIPlaAUoaX891vpxW9n2QVGz4GMOXXdeYudanb4Jr8vJ72yj7ct35eT/TgdAbP24bh3Qx6LXZPDbZwZRVTfe0BW+GQ8khrykGrhtQtxC9ZDwGz9RIFeSXDtTjeGf8JsWg8zFeX1/Gc4NIlFxG7ajsn9s2JcR62CoYTW1OKNV11qjeV+EEei1ZCFhfWfcrpgm++5EhZVv8CaadcX+WSmfb//fE0fAqIFh6ak57myILZwHqAp+SLUNBZWQHgqyvRpU9xrLaVrPySYMh952LynTXewK+PI/veSDzHiuQJT3lBmxfQQ+Wv8YDbfHRS5oa0pTnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28; Tue, 4 Apr
 2023 06:35:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Tue, 4 Apr 2023
 06:35:36 +0000
Message-ID: <2a7dce45-185d-419b-2fad-5ad20b6222ed@siemens.com>
Date: Tue, 4 Apr 2023 08:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey/gdb: Skip test if gdb is not available
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: decedaba-f932-44d9-0649-08db34d6cc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NwF+Ze1Ml26jhCYqMbQPrUTqMP4Wtspt/7cq4fGMhxrQ9AYbHSMnOxy+6GIzyAfFGJIKDzB7H6R8U/4WPJXrZJWSzXGxvTffGnvm+fMXixCCKH2zBpOGlTStA4OkzTPSq1TpR8mrdTLyYEtjZneFETMiJ5SrJeABT6vGcX7/OvwavvsuEBdqQnA2z5ixkYCjTED4vXfQA6NX3Wn1yEWCPKr8fMAxbRktqE9BVjyAqzXFm9TbAA8Flhx4Jg1OV4T3hI1CR/YdhKvyJSCid10ucCQH7bbn+6xzRhIhMa8O//BeeSuSGFTGSAaSSf/3px4SC7C0XZX/b+P3jpluwf6oFMt5MRhCb9502p54pUbG1i3BOSC8v8UmGmRKsop2LFvYZBL4iQSZmEIjhZd77Mwt6d6T/Kux8axhvRXnOzyG8M4MspZFytwo4EAfsyAI8BB2RYcVQnuH2ob0dVwghTS2UO4C7godWCaM66U2Jxm7QxGTOJnfAJiJwMKpeUBFoPbrxPfdxfKbHvyFViLr90ru3/j9cT+X5c+425NdwkigNnr6O+Y1DhP/1oZCqyJRqf5NDgXGM90cvhYqiFpI+Qe8Aw2N4GGvEGodGib98EY42n7fAepJHofJPTcSsDj8nLUTuXOH5wzIwC+lL2KsV1eF/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(31686004)(36756003)(38100700002)(5660300002)(44832011)(66556008)(66476007)(82960400001)(66946007)(86362001)(8936002)(8676002)(41300700001)(4326008)(31696002)(6916009)(6486002)(83380400001)(2616005)(107886003)(26005)(2906002)(4744005)(6506007)(6512007)(6666004)(186003)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2k4OUpNWEloL0FqbjBtOHlrU0ZoVnY0TU5xbURHY0JmZUxFUUs5eDIvY2Vx?=
 =?utf-8?B?STU3ejhTMHdCN3hEcjhHM2NxTXFpUUVmTzdsYkRmSmlHMnE0VVZIZGhzcUNJ?=
 =?utf-8?B?M2J2SlQ2aHdzcnBGcFJtMjZxOVhheTk0T056cHdxUmYvS2QzSUs0RmMxZnEr?=
 =?utf-8?B?eWQrU0pPVmlZdXhzQU56Tk4vanR4c3d0VGZRSGZvUU9oMEFxQjJUNWNmVFZx?=
 =?utf-8?B?QlJpRkdiekRpZzBHYzhjV25lb0puMzRtR0JNTkpVQWVTMVh4YkJDaDc2TVJv?=
 =?utf-8?B?eGh2TVF5K0lVNzU3WDBlcFU2QzNNSjl3L0trOFhtQ1VMUkZ4eWlmQitOcVZi?=
 =?utf-8?B?UHdTRGtoUFZjUnFScEQveDYwemtWUUJXWWNMcTJiTXQwTEh1QWxlRUx1SGlv?=
 =?utf-8?B?VmY4dnFRclJ2eTZseUJhN2VCS1A1eEU5U3Fhd2xxVFdxMEtjS0ZMUWdPaUI5?=
 =?utf-8?B?eVF3QmFvNEc4R3JENnc1ZS9JVEhXdTQ5TGV1NU1HRDBMQ09yT3A4Mnh0TjFG?=
 =?utf-8?B?NjJRdTJPaiswQnd4Q3VJazB0R2VEaWltQTRzRng0STZpdGQvc1E3dktDOXNC?=
 =?utf-8?B?VWpaMWQ2VUFENHhNOUlNM2lDajJzRzNpek5PNTZtT1liTUdmazZFNnRXNXNC?=
 =?utf-8?B?VTFSQ0gxOVJ3aE1QUkdHaEZRMEx1ajRWanE2TkRGeGxZRXVHOUtOZ2gzRXNV?=
 =?utf-8?B?R096WmthbWpVcjdJZHRYZGJ2MmxKdk5HajF2ZlVicTkwRHd4UlVIZTRSRzZ0?=
 =?utf-8?B?M1N5UjB3S0NlNjdONzBlMmxQMmVHUHp0YW94ZXVDTWZrLzB3OEVhRk1WT2tC?=
 =?utf-8?B?bFArOU1ac2VsdG5VSXVCS1FXVnZlL3N2WlBQK3A1WEZWcUZWM0ZOMVFjeGNZ?=
 =?utf-8?B?TTM1ZFZXcW85WVU3S3dPRHZ6NWZ1QnB0QmllTVVJOGtHb3Bod0hERFE0SGtH?=
 =?utf-8?B?L0c2UkErMFEwa0VOT1pqK2tOeW82NGU3RDZCNkNiWXNtK29WQVZqQkxkdGpL?=
 =?utf-8?B?ZDJaWWRTY1U3TTRKOXdDOWZaV2k0dk1meFJUdEYrcnltZHMwYVZSUTN5THlX?=
 =?utf-8?B?cnM0eGU5dHdSZ1JiQ2xYdWNyQkdsTnJSVCtub1Q3NTVFTHo3a1RlZVdRb1hm?=
 =?utf-8?B?Q29zQVVHZmV2TWpsNnVBbkdjNDFLa1dtb0s1RGlvS2x1ZDhwajZXZ1VNZUdT?=
 =?utf-8?B?dC9qWHQ1VXhaOC9VNTRwYlgzNzVuSW81NGJxaFc1Nm96RXc2eTMwRFZhZktu?=
 =?utf-8?B?dTdKSWxhbWQ4czZaUmRXWlFGZEtGWVczTk9ITXZBRHRvV1ZmU2plMXFpc1hX?=
 =?utf-8?B?ZEl5L3BtV3ZWUS9WcmJNMWd6SnY2ZWVhdlhqbnRRamY2dzhCb2JCNzRXTnhN?=
 =?utf-8?B?eVRnWmRqVHVOdTdKUnlpVTB2c0FKV0ltWFlNZyt0L29GbXlscDR5dG1oL0RF?=
 =?utf-8?B?L20yMk5ZK1RpQ2x4TWd4WDkyaER2cFJFbm0ySDBMUTJVYVpweGs1ZGVsRWJP?=
 =?utf-8?B?Qk1LaTRKbWRmNVYwQ1VwckRnYjFMQ0lLR0VJczZnWXVnMG5YY0hvT0dWSGF5?=
 =?utf-8?B?Q0p1YU9UVmkvNEUxRXhtQzVpallXMVQvMmM2LzJNMkI2SDZDeGw4c21nZk1S?=
 =?utf-8?B?UVVWSUJBZlBOcS9XQ2w1YXhSdG5WaHdWb2JxYUd5MjJmYVVtN2cxa0VJSGZK?=
 =?utf-8?B?K0FBSXRSdzYvRU1nMlpnY0s0MUthYjNEV1FBa2d3TElzeFNRYmlJQ0JJam10?=
 =?utf-8?B?R2hMdGNTVUp5bWowQ1QyQ1ZSV0N5a0ZNN3BwSjFuOHp6eXpLS29pdXJ2M0F2?=
 =?utf-8?B?YzZtdVhhTEUzb0VhdW9OSXhjZjhnMTZXVHFSNGcyVVZRZmhXSFJraWI5VTRG?=
 =?utf-8?B?UCt3Z1J2UEllTVYzRW1wSExlQmkxSmlZR1Y5OFA5UHV4d0RNbnNlSHZJeG5q?=
 =?utf-8?B?RkpqWENENHp0WW1NK3NPNUlscjgxOWNtMTJwOXdKVW41OEZGZjFuQ2R6LzUx?=
 =?utf-8?B?SnFRNzdhckcwRmYyL0tZQy9QRVVpOS9VWGxsY2tuQVNwNTNqNFdYaGVSTytq?=
 =?utf-8?B?R0RTdzR3cUJMM1ltakh2OFNSczVWdVo1cXVVOEhDR2huekNObHhWMlRnNitP?=
 =?utf-8?B?amlhT25oUi8yNGpwTU1BQmJMZjJLR212QkEvamV5UXlQWmpCUy9Ua0g0MnI5?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decedaba-f932-44d9-0649-08db34d6cc32
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 06:35:35.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZpXUI38lRpfSKCOfPRJqg22JXcX28kH1EWBO3amRLWK1JpUcJY0UjunvRG9YF84kwHYc7uFSCxymOSyL5YTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5336

From: Jan Kiszka <jan.kiszka@siemens.com>

Make gdb optional so that we do not need define it as dependency of the
xenomai-runtime package. Can be changed again in the future when
factoring out a separate xenomai-testsuite package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This could go into master and stable for now.

 testsuite/smokey/gdb/gdb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index eabf75e6a2..ff15dadf8d 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -75,7 +75,10 @@ static void handle_sigchld(int signum)
 	int status;
 
 	wait(&status);
-	check("gdb execution", WEXITSTATUS(status), 0);
+	if (WEXITSTATUS(status) == ESRCH)
+		smokey_note("gdb: skipped (gdb not available)");
+	else
+		check("gdb execution", WEXITSTATUS(status), 0);
 	child_terminated = 1;
 }
 
-- 
2.35.3

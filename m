Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DB28F3
	for <xenomai@lists.linux.dev>; Tue,  4 Apr 2023 17:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftMFov1zpK/UJ7ZSyJb6VsSyBXv3ffxfvA4oI2KoLK0T0xdQml5RNwINKNYxcWGFpBiwpsIT6z8B8lj7RNOtAcoPBU24x4v7NdCg6zt0JL0tmP6tB6K8eKwkHDceSXZtTP2GQsiLaCxvEcyiGvn6slAu5F+18WD2iSUmObxAxrAZq12DKl49SVukhg4Vd4ASWm83vtPTJDfKmZyQoEI3FT9xwSWKG/gopzV0BSto2cBYRxVIPGUKkydUUYq8z6jFix26AtIkoqCFngQUNwrpTKyFvGCV7xVRXtAvvprD4mJJAU5i41CZaYAwsn80X9hxcctl+FWRk7fsQqBtMWc2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqpRONC5VddQUm5ZPMsTfhw3H1r5W5zVUFNSSP9t3/U=;
 b=awj4TMWYVSMUW45SrXEw6UCSzKCCJRZTm/I3p8N2rVwxGtVgzkBJjoF+i5EKAHkAqqLGOP4KaAOWlB/+lCd0VC0EIkUgz01oLqFnlMNMpecXRLVecEwJQ3sszQ7eaZUmiKpgYmanqqfsejomG2IyI67s7n3MeTeWom5muppt9sy62HPYRFFNw4Cg77pF0F6RtWJK/Fxr2BSQPwFGO81Bfh2+JKFBjliJQVT0Xoa+bIOHKQLN0691SSpspj86tfHRkRG5Qp4xe27Z9K0h3oKbZaHHSwN3Kf7hq0Ew6+Qtl+8r7+3ZqqJbxJP+xNDqKFcQDDGnL2zchoVyVhQm08v7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqpRONC5VddQUm5ZPMsTfhw3H1r5W5zVUFNSSP9t3/U=;
 b=Td487v113/FDuzMhirzTxdnVLe5r3DS/0eZCkrmR2Fixe6GeDzWdrC5YEZMB5UEaSBK232fJWulW3ZSxxJWTgO3pJojfB3cd1nzSAUD8ENCa4nMiOzU1Oo40YNKXHFnvcgquPrWqq6cx4KekOjdfh2Sm4v2GlSt/k0tQzx+RF+VKcsoG5JEFv+lePlugIgIAcDdYv7YIICfXBH4aTvwYkUbyUqYjiZMJ03nDm/FdW3iGprh63rUjrD6VZhb0xyYScAR1A/VC4TmcWwPHJD6eWz8N/MGJ5V7AQNZBgpAGiQlJmdkcTgGEtdqzlWLj+9LeT0VCskB/hnrDwwe08kZK0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6717.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Tue, 4 Apr
 2023 17:33:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Tue, 4 Apr 2023
 17:33:12 +0000
Message-ID: <e99a35fe-92cd-1d82-fa44-e824ca570017@siemens.com>
Date: Tue, 4 Apr 2023 19:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey/gdb: Skip test if gdb is not available
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 436b689a-dead-4174-7ac8-08db3532aa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RWqlOmUmjKQDiWlladxRjr0yz2s4ElSQ5rM2jR/p2Oxqpck31W70bUT6moJr9F272UtUQZubpG6A+/RCDB0mpagYkOfK/gtOV0o2XPe3RdR4Dp69ssGB++nH8cLaZxXnGjB0MtrhouQHwXdxSfqCDrCmZEVlkc6/ifejSuCPLRUkd2j3aGgrRowjgwQKv0N3heUUkMU34QTgJFDfFKM0f93zJLqSV4h90uA18NuiKp1rJzZjRQq6GReQ0babuWkCWopDGJ2iAUD+LpUxiKeYL99xNneD4QDQQIwa8O3CNfnmpQvILQwxkyngVOHjy1MINyH9qV05XWJ9aA+//M/CqAphR61dNPkI+Dz7hah1P5nY6uG5LC3YFBIddFk9RTcw7LMiYeHWqey14gQR6lBcFKTtKP22SWKDFjJzwCddp6+q78P2LLsJsdCCZiCeyf5v/4Qbs9Y+FttCCU+pphX7BgH16VxAA/OwoiwmwoTw4O96izXSCz9sFeZtLzEwwLwI3Cn3xm2sUucSaRLGQNzmzC8Y2VpJk54/eDFhbNXIJD2OezqZEibsuv49d0jy4dxW4IAp2lsaK8Iv/6dGcbn7Oho2YJ/Q2ca+yrTck2LE3UW5ud4bfVCvSTQLv+hC0ffeZuy7Qh6HnVPu8qoTDW7uWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(2616005)(316002)(41300700001)(4326008)(66946007)(66476007)(36756003)(6916009)(31696002)(8676002)(5660300002)(66556008)(44832011)(8936002)(38100700002)(86362001)(83380400001)(82960400001)(6512007)(6506007)(26005)(6486002)(186003)(6666004)(478600001)(107886003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0g2QllWNkVuQUpBMnJmdGNScENUWVErdHllS1E4cmF0akJUNjZWRU9GNHJl?=
 =?utf-8?B?YUo0UHE1MG1KN3VnVTlkbHRtT1VZcFFKOWIrSS9wMUxVVEtydUVuUFNhYVgw?=
 =?utf-8?B?c3hyY2c2Y1pQRmFMdGNBdmJKaGZVMDQybTBNRWRpaFdBc3d5dU1ld0NWNWR6?=
 =?utf-8?B?ejByZjJselNoYXE1a3pndHp4T016WEtJNGpGN3BoUmt1T0RuS2hiMXpxdGJP?=
 =?utf-8?B?bnRMRXJXOVNSa2Yvdkd3Z2IzQTJUR3MzdmEwd25KUFdRV3hIMEdjNVNzTlc1?=
 =?utf-8?B?N2Mwd0hhdmxwYkwzUGdqRVpkRTh3cDlNU3BRYWg4RGkxSTd4dDgyMnBtWTM4?=
 =?utf-8?B?eXZURVlSb2tHUDRoUmJvU0x6NTRoaENKclVFSG9yWURCVnZyRmgwMTNubDBa?=
 =?utf-8?B?dDFnb29sc1huZGttM1FpL0czNEw2c2ZvY1FoVGVISFNYRytlcVQzWXRmSDNk?=
 =?utf-8?B?Q2xaVjk3UjFFV1liWm51blJPMEN3djNpQTJvWVlPQkhaTG5XMHE3dzZYWXA0?=
 =?utf-8?B?Q2dpVW8yV05XekhzQkRjV0xieW91NnNXcS9OL3FXcDNJTEpEU0lmaGlEVlgr?=
 =?utf-8?B?OHZDWkg1RVp5SzJpRDMxWCtFdCszQ05XaElvWnJ1WSs4bVoySkFIV1lqMWYy?=
 =?utf-8?B?eG9UK3N2SGFpbXJodTFPdnZlSVRkSlo2blBkcCtuNWJhN1NNYlcxYUVkLzRF?=
 =?utf-8?B?eG1iczVMMXJXWkY1SGE3clNJdVd0MnJ5Q0I0Q1lsNFV4WGZvZUVwSS9QVkJq?=
 =?utf-8?B?bWd5WGhMdXdQV2Z5SXlKMmRYcnROU01IK2ZiK0FzWTZaMVFhc0IwVWluWWVn?=
 =?utf-8?B?eUcxNjlEMXFvTVhwdnIwVUFERW84WEhUMHJMM3d4ejV5akpmZERIV0xFdEwy?=
 =?utf-8?B?YzhKOXVTWUw0eTNPdEpOT0hwVFByUDNodkljTExidnhYNE13M21hR2JpYVMw?=
 =?utf-8?B?czVVb1NISTBPclVodm8zdCtKOFNrbE53MWpOaE1tT2pScWkxUU1IY0Zhamxa?=
 =?utf-8?B?Um5TaW5nUTh0TmdPNWV5V1Q3VlNkOUVhNVpPUHhheHptdWZvSUdJSkF2UFFa?=
 =?utf-8?B?L1dsM3pDWWY3QnNUM2o4bnVDTjNQNkVxSUZrVHIrd05lbDJwa0t4M2NmbnRJ?=
 =?utf-8?B?N0F5TFRKTHJxLzViL2NRcnRhdTUxQ1RlKys0amE1UUJKWEcvbE0xWS9RRC9Q?=
 =?utf-8?B?YVI0Tm54VUdxMUV0YXZtTkduTzhKTDZmU1JHSWZOZ2VRdHBtY0o5SzUxUENy?=
 =?utf-8?B?UmhWVWFaUUREZFQrU0lUYzB4Rk82SDAwS3JHczBXRDFpY2podEFxalg4blpF?=
 =?utf-8?B?VjJuUVNCZXB4MFV3Mk5zai9rMThrU1VmTHBoU3ZGWmtoTDBaS1g4a1J4M3VW?=
 =?utf-8?B?cUphMEYzQUlkaHJmZ25FcE1RMEF4ZkNnWWlhOHVlUERXUVhVU3BXb2dpTllJ?=
 =?utf-8?B?aUpYUVNNSmQrZSthcVlmaVBjRUZEbTRwRDM4dUdzMi9PakZyRlljdzBQWWlw?=
 =?utf-8?B?TEU4YnByTFZhdXBqVUc3UVp4VXNaMWQ2MXBPTThxcHJ0MVZhR3E2V2ZETkZ2?=
 =?utf-8?B?VGYwY0Nhb3duRkFZdUtOYUFBbHRQQ0U0NDhSSElvcElHQzFSeGdJbitOY3di?=
 =?utf-8?B?N0pKWHJZejcvRHFiMkhHbGJkUm5JZlRBV0pwU1RsUWpscHZPU3c3RzRoRmxQ?=
 =?utf-8?B?eTRBYk9pTXIvMDdxZnkybmhaVDNoRXkzMnR3SmM1YmgrM1p3V2R2QUQ4OGVm?=
 =?utf-8?B?WHppN0NwYy9URHEyd3VUd280UDBldlJSQm9JUVVYOEdKd1p3eUc0bWlyeEdU?=
 =?utf-8?B?UU9tQVl2OGtIU0tSQnFPNWZTOXliRndLa243NlVNNXdPV3lLa0ZtcHRzcFcx?=
 =?utf-8?B?NlQzVE1aMmpoQ1hEMGo2UHBWSlVOTkpzQ3ArcTIrRjcwQk9jTHlrRFd1bUVa?=
 =?utf-8?B?MEw4V2NIR1hVK1hkQ2MwY1d6SVY2eG5CeUxQdVY1Vk01VXRxVk5qaFpWbmQ1?=
 =?utf-8?B?N3RCMjIwL3dzcjNlaHFwYmJlVE5rS1NRNDVlTHA0bFZORzFsNEZiUm5CdEZC?=
 =?utf-8?B?WVIxNWRCWEJvSEVpeGRQMTRQUy9FbmRpd2JqZmFtdFhEUERsWm1OVDAway83?=
 =?utf-8?B?dm12MTBWRm54YjhkR2pxMzk4RnN0MTJSanBhVVFqNTFla1ZNN0VtNitNV2hw?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436b689a-dead-4174-7ac8-08db3532aa75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:33:12.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPZL1PL8/xDcFQ2ncLdeZjXmaDd7EUkI0mbAacoem8eRog67KFaE4DBcEdOZWLrv1yTVjO94ksZiKX8FMQyICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6717

From: Jan Kiszka <jan.kiszka@siemens.com>

Make gdb optional so that we do not need define it as dependency of the
xenomai-runtime package. Can be changed again in the future when
factoring out a separate xenomai-testsuite package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - close pipe_out so that we always leave wait_for_pattern

 testsuite/smokey/gdb/gdb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index eabf75e6a2..b09b78b4e0 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -75,8 +75,12 @@ static void handle_sigchld(int signum)
 	int status;
 
 	wait(&status);
-	check("gdb execution", WEXITSTATUS(status), 0);
+	if (WEXITSTATUS(status) == ESRCH)
+		smokey_note("gdb: skipped (gdb not available)");
+	else
+		check("gdb execution", WEXITSTATUS(status), 0);
 	child_terminated = 1;
+	close(pipe_out[0]);
 }
 
 static void wait_for_pattern(const char *string)
@@ -279,6 +283,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 		default:
 			wait_for_pattern("(gdb) ");
+			if (child_terminated)
+				break;
 			send_command("b breakpoint_target\n", 1);
 			send_command("r\n", 1);
 
-- 
2.35.3

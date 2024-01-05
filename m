Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7E219E5
	for <xenomai@lists.linux.dev>; Fri,  5 Jan 2024 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="teW9dnYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSdmUvACkBtJDeIBdbYlqHvnVXfXsnmrn25Ozq5Jh7YWZyrNLVfuDZod6LALgNB1R8r72ppnC4kfTYT8X6oyBMabPLJzD3lZgc8yHZVHJDctQEgvAj+fXSH6DVPJmekejY6vVYr5RE+Bs49beT0n5jy+1wA9HOy7E6qhct/R3w31MEGXKtRsIZJO99UIUId3Rfj0q5naH5PP6n54FO71De9fIpFNKPbs76gEKJzvm7IHhxx3t08B5JMhfdLHJMwnm6b0nihM8FvCMBiGUInO4JPLGZkJJ+BPF4Nq0xIaLa2RjdsCITawNLSSZ77RhQ3CW/uI32QDdysUhjgIMGvizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKrdCZ5ozS+C5Y1eZVALFH75cKaXatwPxmUbTiV8GuE=;
 b=UI/W3xXbG/ugflVCkhUrIg73yaC11nriXDzy3r/uHPhwR/d3ZrjVfNCFVJcrcUP4k51I3e/qjTdZQNtNxTbs1f/JTPHs90smcwyiToTFYAn+aG3vegzraLm66RQgCNewINVSqgXLBkmkq8LUoH7RRzUQmJnIaPRETBIAXrct+H9l+ZswsSpCy9C2TDwmArYSknmgtLhltezOFp2nbJqpn4OXKPCP0a/y44ctVjV6nE2KiZE54hSBrVWVM1VJ0PMETLBGVhLMiz+yJpe4gWlDuroqx3a75WdaBI3bBBWivHmTsLmFd8+Q6L/qZY8upRAh9GUR+hSVFKBgR398ZD+tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKrdCZ5ozS+C5Y1eZVALFH75cKaXatwPxmUbTiV8GuE=;
 b=teW9dnYPC1Tz5NJf3sofUk2CMUZZNgC8q/3CVz3WTnXK5EMBcM9FMqTXp/iu97rZKNOIY2t0IM3A7iUoprR2hMhyDmUeXWD9jjcJmUTeMpYBtYhr1Sur6aXe9ZcYnpYevHO6ZB/U0vR8U2hq6vTZTJa/6NBPJEJybNwM7YZxyJrbVjrbBPDCvcqC3o8l9oHse/GSYE9nqYo1c8RCx4oC9mjvZnaN1eNARh8F7gtclmc0kWMcXqL8XuYVt8krwB/19Zp/e5BJT9tWt/KneorjlKa9WgHqjAZIup2Wz5t5Uq2vMcu7ajIZ0E+ya5LWaPoxdbb8vbnGKG2aeM2cDAz1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 20:53:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 20:53:50 +0000
Message-ID: <cafa3048-07bb-4a72-a7ce-3de961b971f7@siemens.com>
Date: Fri, 5 Jan 2024 21:53:48 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [libevl][PATCH] utils/evl: Respect custom libexecdir
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3651:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d7a0d-b380-42fe-831e-08dc0e306b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mJnmtl3TFY5bw+uIf77fMRI9R0J2fyF61pONevQZi7izcyhBbCj7/Xi5/vaqWydNW0gxwur4hmg3yNNc82E0F9vjviA7UDX6W4pI/mTPqqVqg0qD46NNN/636xQ+m+/KZ/+V/jXIwBULRz6WTXUq5tqEzVaU5iLSSbtuK7Al6XLiKO+A96I3E8LQFCtb2DJ0GV81gTFMgM0zjPW0fYyBUMOk9rIOC9fDLbX/Yj81CPKImZajyAmJknkwLs5gNtk5DzyoXUb4liFhF5DrIijBjiujUAVNSh1TUygOguxusuSMKlLBsshSmFI5gymlhpY+Tc7/yTg7gvVfjvsCCBzqQD/eVjmRHBF62YiVniDXx5wb6ZIo7OkAOKOKibK5Dkly2Qw9J8PYfg4p7W9+IArF2XJhi5Ps8RVmVqFx30LUdWhHxi7vTtS1oGM9U9b1UxvhwlXigzqq4XcMF129lFdQt4V9G5mvvCkFv0W9AFiNPP9q7ZmKkGwthygktZGadb0fQHHw6iq2cC+xcxNOxg7W7hPYS33zrcm13gS/KXq8SBoGYKpLmK+UASkAq6JG+rwiUl0bg/QXKh1RTYFLsQoTpvlUxKi4w8OfooZu4SREJm1DAOvKStzVknMTfdv0JQR+OPifw7ZmdKR4qTYIKqjBJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31696002)(38100700002)(44832011)(4744005)(5660300002)(2906002)(6512007)(478600001)(6506007)(83380400001)(2616005)(26005)(110136005)(316002)(66946007)(66476007)(36756003)(66556008)(8936002)(8676002)(6486002)(86362001)(41300700001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VmYUZUdjVsNGZhSzg2SSs4ZWtQYmR5V215MVVYQWNWVnlPTkY5UDdpS0xB?=
 =?utf-8?B?ZDFtTk9KbFkwOWQxczFkeWdScEJzblJyMTU0SkFVRDBWMGp5VlFiT0hqRFY3?=
 =?utf-8?B?di9UaFJoQjN3VHV6T0w1c0FYUzg3QzJwVnp1VWdHRlJpZHQvSHdGSmx6dXlu?=
 =?utf-8?B?RUJsZEJSZWt6Q3UyNFRFcmFSK2xCL05IRGNEVk5xa0dBLzMxVS83TGRCNUJI?=
 =?utf-8?B?OFErY29MSittNDJKSFhUT0hzaHliUnh5Q3lBRldqeEgwZnVKdTJNNGUyYUNE?=
 =?utf-8?B?aGN5KzNhK1Ztd1lUaGRhS0ZpZU1WVmwyQjVNbVA4czlTc0FWcnNVMTFIK0th?=
 =?utf-8?B?NnA4ZVAvN0lmNEx5WVlML21rWG1heEd4QWlHTlJCT1Fld0w3MHRuMVJQVnAw?=
 =?utf-8?B?VzY1R2pPbWtsbDYxZWZLTkt0OEI0cFhlN3NEN2J6elhkaEpDekovUTltYWd4?=
 =?utf-8?B?UHY0NkwvcnJGSlFEVE80clZBQzdXeEdweHdCQkVSY2tvZXRkZWdJYlF3OG1k?=
 =?utf-8?B?Q090d0NjQzhYR3F2c2I3NWMwVmxJOG1Jd2N4ejNYSUM2eWNsQWtybzdobnQv?=
 =?utf-8?B?Y2NqQXlkTm5kcE9FbDZjdTV6QjEwNnJJa09YeWRWdEp0eThGL2o3MzEyTFlY?=
 =?utf-8?B?RHl5U2h4TnV6OTY0a25OVU5PdzZqdUtiRC81ZWx6TmduWWR2bWI5Y0w4d1pv?=
 =?utf-8?B?NkZOc0JhZ1FFYUl5QkJEVllIemhEa1pRcElWTzNuTFJOUGQ3NTBheGxYaXJi?=
 =?utf-8?B?WEF0YjlHdVpEMVp0RDZ6Njk0bXpPQUNseDc4bDZZQm5JQ1ZjNXRHU2xTYXAy?=
 =?utf-8?B?TXlYVVFsMU9sdWFaK25iMGhCeHFDbVk2dnlPNjRrSXFuNnd5OGo2ZVpqZHNs?=
 =?utf-8?B?YytOTWdFS1ErSXI2SzZTTGo1VWRPMDVaMmlOMXVZdTBwb3NJSWRxRXVJWjNy?=
 =?utf-8?B?dXZVNnlrRzVwZDFMOXJTa2s2TGJXcTRzcEE2cy9LUXNOT2g1NG9YdGtEYVB5?=
 =?utf-8?B?czA3T0xKV0tEUnVKZ2lGaG8xcXVTdWlzY2NLNEcxbXlsOGFlcFJXd1BCVGpN?=
 =?utf-8?B?SVdxR2VBNXlsMUxjTUZyWG0ya01zUFFhVEQrSDdwYVRJTEtEdDJZWUM2QWxD?=
 =?utf-8?B?ZjhWRkR0MlVaWW5NUVh3dXh4b3NhS1JCQzhva0djQ0RyQW96Nmxjak9VOWpi?=
 =?utf-8?B?enIyeHI2WWpRdXJEcDJvK2FHVUN1disrRkV1dWRXaWpjL0VCK2hLYkFvd0RH?=
 =?utf-8?B?YVpHR3FHbmlXcm9tUkVvSW9sbyt5MWpwOTVLODZ0Nm15R0R0WTAybE9wSXBh?=
 =?utf-8?B?cXAySUtmSGQ1S1hDU1BYWm1lN0JKczBrZjBiREkwME5BOGlmUmpGWHEwWXJI?=
 =?utf-8?B?UmhpVy9nQ2JSSXRSb2kzRzNFRUYxVzQyMTZDUkpEaUh5bm5rS3NXMWQ4dWxD?=
 =?utf-8?B?UFJ4dG42UlRTN2FXMSt6cHcwbFB2ME9VRHlvOUlLKzdZcGxpZDRKRlo4LzZZ?=
 =?utf-8?B?cXVXaUlVejQwTTYza0VEaHIwbGd0VDcrMmIydW1FdG5ELytINHk5djZKOWtS?=
 =?utf-8?B?dmxHalIyQ0VWSzFxdFJBbnZSNHlra1htNXNyc3Mxd3RDZzdGTDdnanIvOHli?=
 =?utf-8?B?Sk1LL05SZitreVhoMjJKR3hrOWkxVXlOcko5UGpjdUIwNFhCQXlOZW55M0di?=
 =?utf-8?B?Ujdua1U4c3dpZUloYk9YT0Q2eUs2MjhIazV1YmZ2Q2hZTUgwL0xxWTFXS3Vp?=
 =?utf-8?B?dzlndXg5QlFMa3NEaCt6cEp6djdzN3FwM0xQcEVXRml5OGNvT2ZsRHNiVmhx?=
 =?utf-8?B?NHE2Z3BWVnFldktsSjVvaU9yMTlTd0VTczQ2ZExKclpCbU5iTTNTSU1TL1F1?=
 =?utf-8?B?djZ1V2x6T0lhUm02Y1FuS25CRngzQ2F6ZWFUbEpSOUI1QUhLRGc1RDNENFp5?=
 =?utf-8?B?ZHB3WUNMWXRaZEZvSTZEUjNIeEhXbVVrYVZVcVNPMFVIbFIyRFdvQVcweTFU?=
 =?utf-8?B?UE5tY255WUJvVmtvN3NMK1R1eFpFbmIvV3d5ZXVTVVVxS05YR3FZSHJMSVRG?=
 =?utf-8?B?QlVkN0hOMVpZekgzYUVjWHVpcmRLZk4xSXJnWGZ3TW52K0FlekxkaTUwT3FS?=
 =?utf-8?B?QXNWcVowTzlFbmNPcUNqQTFlWm5vWXJ6RVFhK1ZmMGJIMFRwWEVmUWtvc3Bv?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d7a0d-b380-42fe-831e-08dc0e306b6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 20:53:50.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdRkT2+cMaxbOQONO/uHdDHTFYNqk/ApR7QAeTFTVqVhtnpdHRlO8K/9BW8UXLuNsPR6HQF5ynGeawy6DUKylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3651

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes execution of evl on Debian which uses multiarch-compatible
paths for libexecdir.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 utils/evl.c       | 2 +-
 utils/meson.build | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/evl.c b/utils/evl.c
index bb6aeb7..d14fce4 100644
--- a/utils/evl.c
+++ b/utils/evl.c
@@ -118,7 +118,7 @@ int main(int argc, char *const argv[])
 		error(1, ENOMEM, "%s", arg0);
 
 	if (cmddir == NULL)
-		cmddir = find_install_dir(arg0, "libexec/evl");
+		cmddir = find_install_dir(arg0, LIBEXECDIR "/evl");
 
 	ret = asprintf(&searchpath, "%s:%s", getenv("PATH"), cmddir);
 	if (ret < 0)
diff --git a/utils/meson.build b/utils/meson.build
index a34ff19..59d818a 100644
--- a/utils/meson.build
+++ b/utils/meson.build
@@ -2,6 +2,7 @@
 
 executable('evl',
     'evl.c',
+    c_args: [ '-DLIBEXECDIR="' + get_option('libexecdir') + '"' ],
     install: true,
     dependencies: libevl_dep
 )
-- 
2.35.3

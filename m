Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E36ABD
	for <xenomai@lists.linux.dev>; Sat,  6 Jan 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yyB3xATG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCyZXtlm7wN/IJD9FiNTnlhwqa/nEDhSsX81BcM3op9P60Dr3jVwZ5N70w8ZsESJ4Kd8xCeqxPelPctYVPOtQuxbeXWQ6E3UbuGqi6uSVlmW1ZqakhTUdVlGhD0q1O5BYGybjDiINDvU3Si9KHOMrbF63gP4BkEVRM5fdifnP2YNqfeN4IRzX1xFbdL3/m/OvYqjQbscSKi/X3xEKX78L5XyV9zyrBUAlztsEGEXdaujzoB9H6i24mJRceKzcZa1ZCE2U4zaXxj9CrfocTtyQHfwPLLBRAP7naNVzQaABQegGCH1y1DcsCEt1QMemj09KTlye7Kng5fgMXIFiFaZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgYqRnJpSaJz4IpVUworEAoi3EiJCc7Q4Q2w1E8R6gs=;
 b=apP4Cmhdno0YcBU6QjZ4iywmAR25UdIb0y6JqvDf6g7iwYJmWv7a+YSFaJ5vWs5mM9nPNrJM04PFc1ATc7r0PSFm9TXq3/9nFEydydlLhcpSnkiAJk7ehwMhTvmZanvlv6HsvjsAkBa/r2nauqFWzxj45UhXPdqrOLS8wlsFHR0l5s4kRZCNmohNycBx68k7TIZJNcUvjMpfBwALIISAdEKroPU3VX3AZUJgWjwVwektMPo3dQVgqt6Zxsnem7M5CUJMPT50ULgu3pSbhui1v108dr5uCuP5wEYZxHFNA/nsdHy0ytkz7j0lbsbZlx5DwvY5CPxNN5LUQntkQdOYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgYqRnJpSaJz4IpVUworEAoi3EiJCc7Q4Q2w1E8R6gs=;
 b=yyB3xATGn6AbWdWxbFxv+7VS2eYiffpvpCFrWrVIkU8uTEHCmadPscSMZK/KVsu9zYrjWYO4PibsxePnL32Jtz4RjktFZbVTdt23YzGgNyIpuhcVnvgvazhgeDcqyvkZuHbQx/4/LrLuAAbgc2IFFAkxtVbF+gL7Hh85cSTww7uveR3HuqieGXEzjxRJUI2b6rgMMVUNHM5gXP22OyCfcKKQ5rqv4MEbt7D6vHtK1rd/G9UpFws+BKM7cNJkcPzcaXROjhVDEEiF2aQstymwt3d53pFFoHPmWHtOYPHawwb3Ercy4y9yH5LRlj78PPlHIJ14SbpzJpD1MloA0qTFKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 07:53:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 07:53:11 +0000
Message-ID: <55f09668-f73b-448e-8c4a-0d43c67af092@siemens.com>
Date: Sat, 6 Jan 2024 08:53:09 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ibevl][PATCH] Install tests under libexec/evl
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3595:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d8009a-7093-4638-383e-08dc0e8c87cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PrU11+vLskC0pg6YAsBORO7mJd0N//cN6sNhfqNeeArkbcXMtiULmeeOtYQhSWNlldCZMr8G9vnR3al2fzM62SjRDChf5KSDCnqhjzzyZFB7/7vdLkSD8LV0XLMK1IxOOEb/mg/XVlOqinI9j2GziqkQ5nHP24YeH+M59FlIFURn8iqhaf9DiqT5XUW2PgzTZ+kodsiOxPFRp0QNsrfuTgwitEPUxPmncigaIrIsxFs31CnmqV4lMgUzobeCB5+QOi6tf4HeNzRqqFlrLw86KJHwPSZxvW8GMkry9FQ66w76cKAXAhJSKNDCPVHgrzd8xrt3gamTNb0huCPJDMWgdNjn8qg0CgSG5SKtEJ7D8kYkavQydj3ua2KB6GFUF4dCDKG4rIipLvXbRKTB/DWayMYGv4Mzwlc/nMPQVBMO+/0Vdi0FcjI9AxAzAJnP7h6hoPtdH0i2yfTs9EqbEP6Y8HII0gpnfeswQZ2Bw4O/Zz/DBEBJ037/uRcX1OoBlArzuiyLadhjlobACG7KDe5fU/Ck+0XKIZHRuETIQnQT87+Lkl+yvwkHQMdvoW8eLK4DpIfZUjstkQepIXR6LvmLIblEu117xIKuXsx1Al0fV+fRBxQZ/R74kqN6F6ScEEja+6NqUOo9ga9LeauZHQlxfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(2616005)(26005)(478600001)(6506007)(6512007)(83380400001)(5660300002)(2906002)(41300700001)(66476007)(66556008)(66946007)(316002)(110136005)(8936002)(44832011)(8676002)(38100700002)(36756003)(86362001)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci80ZldidmxyWHFWSU5EaVo1R0JNazB0M2c3UDlIWCtpUm5GRy94UGR5RWNN?=
 =?utf-8?B?RFlMOGJRTjlOcG5ncFFaUnVSeXI2bCt6Ukc3SGM0ako4bUo1Y0RMamEvMFZN?=
 =?utf-8?B?WkdqbXNZUGhXekdjbmIyK1A1RnIzdG01RjJCRU1Mb3IvdUdRNUN2QzNHZXp6?=
 =?utf-8?B?d0Z3ZUx2SEdDZUozYWR3czM2ejdFdTRTM083NXpoQW9aSCtsNmQxaEdlN3Iv?=
 =?utf-8?B?Y25OclBIN0pOakEyeGxKOFd6bzg3dkRMWThDQ2RWKzZPT3lyYkEwZ0FVOGFq?=
 =?utf-8?B?NmhDS2FhclRMS2ZGdUdOOE9lU0lUbGU4dTJjQnQwT0FxRCtEQTdqN3NFc0JY?=
 =?utf-8?B?bis5T3ZtRE52UmJJRHROSFltdnNtMFdrK2xVanJRQmRlSW5aT0pUSTNmVnR1?=
 =?utf-8?B?M2laY0VodiswdEc3WlN3TkpIZm83cmZvOHBqbHhwaXg4SFRaK0VzWjd2NE1G?=
 =?utf-8?B?RnV4eEhvdk1nZ3BPa21YWHV1ZndBODVna1VnMlphZTJXd3JjckZuczlHQVVT?=
 =?utf-8?B?a254eUpWYnRmQ09OZjFPN0c5cTNHbXFjY1lXRmRBblpRbU00VGc0dlpXUlhs?=
 =?utf-8?B?bUVvdGJkRHFLczNMd1h3bGFrQkZsZ1RZbmFtOHF3R1ozNS9PVmxWZVRCV0Fs?=
 =?utf-8?B?UitTUGRNYzFvQVZBUklmajlJYkhETFkwcU5BYVZFZjE2VFlRdVJaYUR0aCt2?=
 =?utf-8?B?d2JlaVlXR1U3Sks5UFJlSXdYUlU4dXBDZFVQNFl5dDkzWkVzMC9BSlA5UDds?=
 =?utf-8?B?RGtlSEE1WTg5WFhCZkQ5OW9QNWgrUmEvTGo0VVIxa2ZVOGJPaTlMc051RERE?=
 =?utf-8?B?dXVNR1c5Ry9NM3ZzL2ZDbWs5aVZGRGY0di9VNW54cUJVbnJZU3Y0OGRKNk16?=
 =?utf-8?B?dVZQQWZiWWxVYzFDU3BHamQ1U0psSzQySGdnQ1F3MGdFNnB0N2diTmV6eFBr?=
 =?utf-8?B?NVYrQ083NDJmK3laWmRLTE9aMWE4TExwK1YyZGxPSnM0aE1DNFZNMXN3K3pn?=
 =?utf-8?B?c1pNWEt1MC9mOGFOZEFWWElMcE0rM3Y2T1ZGcFk5V3F1UmhFZFhUYi95cVJz?=
 =?utf-8?B?WXBVMHRjeFZpb3dtcHRuL0VCK3JXZHZuMGhXZEhaOWpHUGxCb2VGLzNBTS9p?=
 =?utf-8?B?Yit5Ti9XM2J6WmQyUjZXTzVET2JEbE1IYmpsWDg5UXpYQnpTLzRyK1pYTm5K?=
 =?utf-8?B?a040L1lOWFBUVGdINGxoait0S3JGekphVzZOYVZia1c3RkU0K0lxNDJubVl0?=
 =?utf-8?B?blVSU1JhMG91SW1Wd05WZVZvd21wMTZ1VlJBYm1JNFUwcDh6WGkxQ2N5aVNE?=
 =?utf-8?B?V2F6RW1XYmtNbjZBMUY2SVFsOG96OEJ5SUpHd0ZaeksxbXFXclVsbkNrVTFZ?=
 =?utf-8?B?Qkx5UEw5ZVdjMXRCZHRBWHZUWWZVQmZhL2FlV3o5RzBzWXQyeElzNVBIWkUx?=
 =?utf-8?B?RG45NklISDFobXlpZFpITjZuY0R2TlZrSWswOGNuRW0zc1RqZDBXNGdoN0RQ?=
 =?utf-8?B?SlFhcUZHWFRLVEVYWkllRVNaeTJnN3Q5R0xLWnQwcXMwUHVYVll2dk5DNFB1?=
 =?utf-8?B?anVpWGFCejZiY0s2bkVYR1NhcW1zaDEwQWJJVU82Y2NnV0QyMm0zRmNIeXV6?=
 =?utf-8?B?ZUtIa1Q0YktNYkIrZ0RzOVp6cGhCN1lCempNNUdiaG5oWFpENFpQOUtQTmdl?=
 =?utf-8?B?bzB1RFErMjlDWUVlZXNqcDZvVTRlWkVYalVjYXBUUUIvalRaVUR2OGxJSVoy?=
 =?utf-8?B?YXBFVFJ0U1JGaWpLem50bjBZYk84a2hmQ0xsOXNVM2l6NjdFbG95eWQwTzBh?=
 =?utf-8?B?RVRzNmlYTEs2QlN4SUNXaVY5b3lqa3BIdUxyWU9kbHMxK1N2elFENE94dk5u?=
 =?utf-8?B?b1lzeHhUak93T25wamczUzA3d2VOdkl3em0va2paQ3NMMWxOOGZuQzArbi9y?=
 =?utf-8?B?QjNyTXFXanhSVGJNWjlhOXQrZVo5OU9yOGZiUStNSTNUVW43aEs3c3VkU0lx?=
 =?utf-8?B?RHhWTC9BeXkyY2NTbm5RWEliTUlrR1Jpb1ZlZm9RWkcvYXVDV3RSWEg0aGs1?=
 =?utf-8?B?R0d3VG0vZ2ZoUGdOcnFIeEtFNnFlaVc2RG94ckFXbFRjK0RnUTJVbk4zb0xi?=
 =?utf-8?B?WENsazQ2UlYvZ2pFQVdBUW5NSHI2dWFlZ0ZRWExaUXY2UXZERG1EVnZDWE53?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d8009a-7093-4638-383e-08dc0e8c87cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 07:53:11.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg5Wd7PklQeINSWLZT+uA+hHM1LLyFwfFrDbJ9LmfDmjHVU9M5mCFmYZc7SmIwjW6V5+uEqTPAMoZSfqQkG/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3595

From: Jan Kiszka <jan.kiszka@siemens.com>

/usr/[local/]tests is unconventional. Better move the test executables
under the evl directory.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/meson.build | 6 +++---
 utils/evl.c       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/meson.build b/tests/meson.build
index b831725..140b862 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -79,7 +79,7 @@ test_programs = [
 foreach t : test_programs
     x = executable(t, t + '.c',
     install : true,
-    install_dir : 'tests',
+    install_dir : libexec_evl + '/tests',
     dependencies : [ libtest_dep, libevl_dep ]
 )
 endforeach
@@ -93,7 +93,7 @@ foreach t : test_programs_with_m
     x = executable(t, t + '.c',
     c_args : '-Wno-array-bounds',
     install : true,
-    install_dir : 'tests',
+    install_dir : libexec_evl + '/tests',
     dependencies : [ libtest_dep, libevl_dep, m_dep ]
 )
 endforeach
@@ -106,7 +106,7 @@ atomic_dep = cc.find_library('atomic', required : true)
 foreach t : test_programs_with_atomic
     x = executable(t, t + '.c',
     install : true,
-    install_dir : 'tests',
+    install_dir : libexec_evl + '/tests',
     dependencies : [ libtest_dep, libevl_dep, atomic_dep ]
 )
 endforeach
diff --git a/utils/evl.c b/utils/evl.c
index d14fce4..eed0d96 100644
--- a/utils/evl.c
+++ b/utils/evl.c
@@ -124,7 +124,7 @@ int main(int argc, char *const argv[])
 	if (ret < 0)
 		error(1, ENOMEM, "%s", arg0);
 
-	testdir = find_install_dir(arg0, "tests");
+	testdir = find_install_dir(arg0, LIBEXECDIR "/evl/tests");
 
 	setenv("EVL_CMDDIR", cmddir, 1);
 	setenv("EVL_TESTDIR", testdir, 1);
-- 
2.35.3

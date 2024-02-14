Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582013EFE7
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942371; cv=fail; b=BpF7Sy0B+b7KnoxDXI+3d6MwmANLCVer/jc7tozDi7I4Xlfj5aytrQ850cmMShFMHjdYyoDHes90qehysQZ/B2EF3CBrZ9fWhzRurVsQWNAtQ2MT5KYR56MSIQ3drNNs3UPc0Y67b2/gBGGl4ge5o5FdWfr4hQIK3MsXzK+F5jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942371; c=relaxed/simple;
	bh=stfdqXJU8YZqmh2VKlOIGhzKaeiN+K7VajdZLR8gxac=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=LsEyt185FVuFgLjRi9QkD+hU/b3sVU+N5aqjrR7qe4BLdhHiYH5ly0LdEtFUbNJV/GMkusOdjM1X4tDH9K/5VGOEvFKXjCzY4xTEtNmvvpH0IYG66IPFcOSNZ8BS6q88DRtNmmt03YGpAha4Np8c/vsd4oqqvkUBg4nlEHQJV9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZAY4FL5T; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZAY4FL5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJEc4bKtAc0ElXRa1Y93n65IwdV+tUYlM7PDrtjAV+JW+LCDSPLF45oKIN/NzAZSIG65iYE2zzipp9nRXiaf/j7glOWLvnEmbuVbnSMpZgLrvdE+Ng42DP5MjEVtV+9qrEsxc2HGCl6Jgp14i7TllagFd5Jt6lZ9gn7Y3AnLyTCMLVoejBQ2AkiRWl0OMYT1JcDxwqe4axLk7uy0zoIH3Omqn/Jn04jXnwuBXtTrzc+96MXMAF7EyPt70CE3ZQPQqNcQzMd0iSuC2mpvcuKvAdQkAOSkaKxP9aQIFGLI2akroLTrXYf9nHBJHCnZOh9JtR7m054ROJImiF79WZYIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO1IN/UwPVebMqGNw/mLZ7IZPk+jOmPNl5AK13JlnLw=;
 b=cN/REFymNKH3Ig7nij7Ptoc+43Vd6lBsqF7jjDGfvm2qGdSzBdxALzt9DoOYPm2wEVPDxwMxfEaLVre3dWLOBP5aUAmN4SkmupySYJO+c9I4EfjQMLgxHEqdy3LDIT0SsOWRLT9jafXMmFoUWGVef8UjOJ4n3B9SsxjNsa4NxeOgqfD054+Ksyrak/mqfb9nRZ1TXtVts7Vey1uMi4oeh+qEZ+wKO8AwkwEnzVTQoZN0Es9O3PkCQOthCiC+gCNz9Apj2aKoUT2Pt/IfBmeHXSzELyleBDMuIaJYnhADxKp6KmTgeYY/zFlUQl85OSipf1Ef3OJeo1cRl4DDgH1LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO1IN/UwPVebMqGNw/mLZ7IZPk+jOmPNl5AK13JlnLw=;
 b=ZAY4FL5Tk8lzwAYiqYjtNHnTY6KV6FIDczsVuBsQNDp22nruxw5zJef5NV1Q99H5Dk0dHedb6wZrPGNWZi6NLklhnc++acTTYSQ/KB2aU5iSw7kRQVDUSedmvZB8PvlqVq1La9zEi4TcfjdImlMF9I+5B3WT8VhNwPdN8cBt8Bb3D8weDIQeclk6o3aEXdlgkXXQaIPvjc8GeFb0EvCoIXa0KHBUbxxoCdhfwZhkbD6dmOaF70ac4H84QsYdgAOVQmGJx0aQuYWvV1t16MtlD1EMc6doQtUVCjEHRDLZCnBIVx79rA3V8kQxCXOQ/LIgp/m/dF17YR3EYjCHdtPUAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 20:26:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 20:26:06 +0000
Message-ID: <4f71820b-5622-491a-87cb-c53158b1122e@siemens.com>
Date: Wed, 14 Feb 2024 21:26:06 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Adjust filter rule to new job names
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b807528-95d6-4aae-f37e-08dc2d9b2c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VCXL/QGEcFHMu9XMYdJcF8X5ICoanScLHKlRFq48EcktYivFUhwuBKQgycwxetMIWu0ChxLJT4gsePZ0ZGdRqox+xW5hG4uHOgm7qiNaUX4XOvL5M8Q+nyFmlDWhINHUVqxxLPoF37MsIDNGiH2bmHorYhiW6oXpGJ+SKQwU887oidsNoiEEly+C2fPxM5y7CMDy609KC9kkVmtZlIu6BvZNJRg8aBZnZrJJmzekAcVxIW7qc55TzEqAYgAKWoQq4AQcJZoCIAiRzsZ0RvaOMpXVFbGombA55QCWDJ2PYHR1U2FajBftMlFAqEPE4528nbF7d2TgUF5cQuDfOJ8gTFy2155AyEaCLMc5BOgw/5nC9ZaF4JcSz0pps4T3qBmYhY47ZhIzYXO0O5I246kbtVc25UpMkqzmYcMafoRm+KO13wFu9FNVHKIo/UCRBLSu0qD/v++iFYhEhX1LKsuoeCmMPVD4lFufFtXXATkt6yp+r4kweYyk/nGHbwDZvDzRKyIy6fKxTZYCGrU/zl0xWSDjO+igERVnIVjg36TAYhTy8RPtWkZb3z+wHanwpXQp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(82960400001)(83380400001)(26005)(41300700001)(38100700002)(6916009)(4744005)(5660300002)(8936002)(8676002)(66556008)(66476007)(66946007)(2906002)(44832011)(6512007)(6486002)(478600001)(6506007)(316002)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alJydDB2STlxUElBa3FoSnNQd241UWVvWkRVL0RmZHdGeWRVNG1CR1BuOXg3?=
 =?utf-8?B?OGZHNlpSeXhwMWJIRDVvQXNrS1czbUJEWnBzRGlWNTA0c2dhUGhGZVV6Sys3?=
 =?utf-8?B?QTUzRXF6YXpvZm1nSWF0eG5xSko5U1AyaythQ2NtTE4rc2JGeTJ5V3NKMi8z?=
 =?utf-8?B?NHNGQTNoeHR1clQxemxadXVVb0h3bjBwZTVtbVUrNkt4OWFydzlURGowdlZX?=
 =?utf-8?B?TzBNc1VIbnJCTjFSV0ZxaWtoRldSQjVBandVcG5FNC9OSWlvb1l5YWNzZEcr?=
 =?utf-8?B?dE1NQlF2SXNVMTF5L2hjVkN5cW1VZ2ZTYXdKN2M4TzRCNENITU5vUGZaaGd0?=
 =?utf-8?B?L0JBVnYwTW9SaGxOTTFVejBoUjFqU1NTOHRlM0Z6bTZxRU5wN2dyUS80blJw?=
 =?utf-8?B?SktXU0ZlSkx1eGozQzI3UW1rejNtZGk5NGZTcDhlbG0zM0NwNXhMbGt0K1BQ?=
 =?utf-8?B?VVpBWmJaYjBkeXhySVVBTXl2c0NhZkMxWVY5RzVib0lsenlFcVVhaG50bjhp?=
 =?utf-8?B?Y3RVQkUyQVZTRXhoWHJJMEJDazNhN0t1WnpEUlhHSXZoSE4rNDBJNlF6ZlJF?=
 =?utf-8?B?anQ1MWtYM0EwdG4wazZoY3ljYkkxYlcyTnFJbWd6a0oyTnUrQjk4WFMvcmo3?=
 =?utf-8?B?S1RXajdHaVNOTjdkaTFFU1RSTVo1TmlneUNjMjNvYitxcDl6eGI1ZjI0TTd2?=
 =?utf-8?B?VHhVdWZ6WWkrZjhFWW5lYWpUM2pOdHB6ZDJYZmtORDFxV3FOYTFrNmNGWEtL?=
 =?utf-8?B?cThoRG9VaWJlbVEvRS8xL3FuY2VhZlR5ZVZJRDBKWk9raTZ4QUFxUHJmdzl6?=
 =?utf-8?B?Y1hVdWdGK051WWswR1JBR2Q5Y1g3eVNjdVJyYXU3OFk1MzhWSmFmM3I5SHp4?=
 =?utf-8?B?aUNTdWNDc1h5VG14ZXhaakVjc3RlcldUaFdzTG1NZmo3QXd6MDc4clZTVlNu?=
 =?utf-8?B?dnAwRUdkTGRrNFVreVlrWGRMUDVQQ2M5SnkwcDRUUlJmamxadGF6Nm5yZ0l4?=
 =?utf-8?B?dGtZRXB1T2w0TUVtOGhMZnl4ZTdDTHlyR0tkU0pIWnBlTTAyL2lhNTY4enlO?=
 =?utf-8?B?M2pJRlFEWFJRWGFha2dabW45L1ZpYmo2OGpJMnBNWE1ORkVyWXlRUWRZV2pC?=
 =?utf-8?B?dFBlZW1GZkdXYUczSU14cDB2cGV4Vk5rVjdFejJEVHhhRkkrL1BMcU9GK2lI?=
 =?utf-8?B?L2hGdmJtTktjUVdJaWFJMllrK1JYNXJMOGdOZkpVS0I4VHdlQ0dZYlhYbnpG?=
 =?utf-8?B?akZpQ2RvQUJ4eWhidGU0M3pCTDJ0Uy9TQ2NHb2FCdnRvSmFGUVJtNEd3eTVh?=
 =?utf-8?B?WkdmbUdjdGFTcHlaTE9GY0w4T25DM2d2UHJCR29qQVBLV2p4eXdaSTZUQXBH?=
 =?utf-8?B?OW0zbCtHekNlakdEZ1E2QjNvTVhodVNmM1lLV3NQRDYrVkY4MlloTGdpZllD?=
 =?utf-8?B?a2owV1R2eW9Zb1VRdDl2alIvZzNHb3lhZjk2MDhTS014bnp4NkxyS1RhanFn?=
 =?utf-8?B?WjFNVnVZRkt1OGxpNDJLUEdtVGxuMUxudXMzVlduVkJjREZZa3ZFWXhISjZX?=
 =?utf-8?B?S1FqY29hODB6ZTlGV1kzd1poZlF4V21hTURDSU9EemhuK2lnU3F0NGtWc3Az?=
 =?utf-8?B?azlUR2FkSW1ObVAzb29yZlNwQm1xWkZoWG1WT2FyZENRbG55V1lKa3MybkVQ?=
 =?utf-8?B?TlRWTWw2ZjBFRUlMR0V6NHdZNFNZUWxBOHBoeHl0dnBLQ2VjYW5CYU1xdGR3?=
 =?utf-8?B?NVpoeWk4alhuT0hOaUJZVXNOQVFOalA5NlhkQk9kemlSYjBqeHVKWEc1aVlk?=
 =?utf-8?B?aEt3VU1nRjJyL3NERnV6cmM2cWphMm00UlpSV2FUbzNVNjJHY0lFRGxHQUFj?=
 =?utf-8?B?SVBtWmxleEE0S3JjcUw3VVdGZVpla1hNRTZzemkzd2VVVmpFWjhjZi9LbnFP?=
 =?utf-8?B?VitlK3hndEJFTlNaemtpQkR4UjU1a1B2K0g5YlFLNDBrTWtRenpHNGJLYWlO?=
 =?utf-8?B?TjNXNCtPdVBtWkgwOC96WXZrbmNZNUhuZlorc2lPZUZxMFNDUmVpNzRFVk8x?=
 =?utf-8?B?SVVYckhEUjJWa2ZkVjhraDByME1UZ21JY29PcEJyMis3bEZXc2RQTWM5aHBW?=
 =?utf-8?B?UTY0WEMzbnk1VjFBbHAwOGtkMFQ1b3hVNTJ4NU9JeWUzMkNabE4rT3F3UUE4?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b807528-95d6-4aae-f37e-08dc2d9b2c3b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:26:06.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shaUtJJrxOpmR3yB5CEn5RC6bvb7R8U1DqUolhHu1t6jM2tfzgcSZd6mbMCXI7fYm62nHKpjGWNGU8XSF+puFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7330

From: Jan Kiszka <jan.kiszka@siemens.com>

'next' is now 'xenomai-3/next', but we do not want the stable/v3 jobs
to be prefixed with xenomai-3/ in addition to keep names shorter. The
triggering pipeline will have to do that, though, so permit this in the
rule set.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4c20c53..9edf635 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,7 +23,7 @@ stages:
     forward:
       pipeline_variables: true
   rules:
-    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
+    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
 
 
 stable/v3.0.x:
-- 
2.35.3

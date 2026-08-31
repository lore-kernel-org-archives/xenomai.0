Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AEB3BB9F1
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158322; cv=fail; b=r81Xg4bZ/uPyXkhrAPxkI1VVHsfafDqe3MUWSymNQ/qOeRZCo5gkPiXikXYZGjldbtoymN+FZjhk0sWwJeSQiI4q/QW7nV8mgI4vPqdkMU2hTNtjsbFQo34MP16ANldHbYo6tXiliklRbtyQtF8sc0aVLSxaThFMltelznqDU1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158322; c=relaxed/simple;
	bh=OFDVh7HucNNFlbEuWr1m0l2dfINjwh6JLjrGw9OoIs8=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=nNp4ZJSYcqnX5SK6yEGfrSVm1DUHezFEquY3skJvxALnY3hS4J16AVS9gzTP8kf4ywY+c/0UUCWVl3TiRfq2cH79Ce9Mvg9ADUpz1mPvldxncdV45aIO7DamPn4oNvB/7uXm8VfsNX6zftOt61rNvtofC+tx3rQjiVgKDY7M4Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z4pmPzwg; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z4pmPzwg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSTyR49tGDFjM6tzUBIgCC0FAPSPnFrkFx0c2RFrBq0kloY7Ww/72rw547+sMfCsAAFq52oYGKKsWwYYDiNzVDUudWf3AFwdvW1foQ5ho87copIe7hAx6k4RRf6i118RxuwlloM+w0PCzkHuXzIK6BP3Xe8H4TALhFSWCgH0Tc3afg3ZS+kzVF4loU8XckJrPWfUwxJSKBlHcdVgSALbSb/LCaV/wky0lCYdsftYe9GFrb3oIAylMtbxncaqKPKv8Dv19b1gQczZjk1HOC/aKYdY3VK7VFWfYq3yhe/3r3vpw5zFNuMqqrxky8WRZ+fSBk60WcLRVbnz7cIBndsrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SybvkHojXOtgmIHimKiAOONdF3WTTZIRgAAcqIjE0Xs=;
 b=CSCnjjJzea4QnMJG8oINGG9AVJEn8dMsgIZSpU/Mb5KvE3TLT6aJgeZMPPclVqVmAIBB1aTCVtYNQQAR2SCRx1d25rKViyy7Z4d4e8w1kp7SVq2P5sQhQdjoLmaykhK9l/nnrVvhd7WE5AhWKiUVNVhqzU7MEpwOXbUQbMyYVYXV86yNsk39y74B7nSwAQUms80Av/TQbvEG10KrV4lxVcKUgwUbI5uNBzMULkRaGCSTGjXEYbtVNvHkhgp+If5e3kfJ5fk4iMuqCDzDEKU6x105LPsXZd8RmoUEAT6/Tf60TPekEw2SdNeDGbmkxJSsRqVSrh8HVUZij/Y1coV3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SybvkHojXOtgmIHimKiAOONdF3WTTZIRgAAcqIjE0Xs=;
 b=z4pmPzwg0tA5dtspnb+YevU6lplP6ixHxL6DhnycrzVWXanjTCDcBVYfBrXSZAJpPbBNqFtLCwUhySFImlSX1hdpxPcMS+DX3tB92iNdogAachmMY9n93lgUW//89CBeeZnPsc9cgPdgtkLbKYovWTStUFQ7FvL7X6907yEz4ZN0LvChB/q0d399o2BoQ/fpHxaiZz2UhQLZinwgQ8OyJrcx7W71ZLD2Kl+wgShLwkrNIMthWJt5FfHGwXR9m6eFcR9kB6KAEmWK1eh05L+2Re/2X/DUv/C9dhpD3sWqI70iXFF+7lLmWfLdu+A51AUxQFS16z2S/LsN1V2cJ+07KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 06:38:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:38:36 +0000
Message-ID: <89b4cccc-c31d-4607-8e53-7f161d7cbd35@siemens.com>
Date: Mon, 31 Aug 2026 08:38:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH xenomai3] Add security policy
Content-Language: en-US
Cc: Philippe Gerum <rpm@xenomai.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cdaf7b-471a-4812-0b20-08df072a7c2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|55112099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	NGl/ujRegkd9wKUMGChbImSqUQefHPDZF5OGm9P1Go+UBF8xp3XrKbq6XYS+TAOYtjoESK/LXrdatNjQNyvZA+xDiMwvCIWxcwQgX6+XbV7/0WZiC2eXqcyR+WDBgLlgtPWBioPr+Qnoe/eb52a+sQhkRW2or+/mIgoOSYKVQXXdV/mgV/oaAWHnHGBNoGa4SSjxM3OKvXorRAn89mckDyzCGNOe5cn82yFQ0PqXlq8nYzBaGI2ZmoAGQVMFgga+sdYTQS1l5QdjYEaAjCfzYBAsg7oKO8N3/5Iwf2jTzwFPiyf+LebzhBXLfSUa9EhMQ4fYAlfTwAta7USeYC6fcFUwGBD1vWxhsjtEcSDMh6bZuPrnLhok5+XggfNbiB0gh0aUAt3Nh6Wg8zdoNqr1VSif8PJZb643OgL1/r1VSLT6mXTz9lRwheuGhKB0wACon8WnGGNYh1d4uq5rl7V3Vy/zjGqmZfFSmGU+RP7GMGlPzwfiCanJIOaqLkWd1+lZy1r2f5gP7RfAhC9mxzIHhne2bkeEDm5Nz/lTkEwhnFxbY4khEKPfTRWoYjT7UUx3LTAla2XQhtwi3cThgdOsje5erUF6Kvf0xmbvokT3ZF8Yk19Pg+STvtLEvGgFhm5CdGMMqVeaP3h0XtmGEtOdhbCU9J4GAWh/MvJeZQfOP3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(55112099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MklyQXowTjNEeEliQ3BrRms3dHNwMklyQ2tTOTBjaW1HcTJGNlVIc3VlV212?=
 =?utf-8?B?UXh2Z3hiendtUEw3K3RWaHVlTkFBQ1pmNGxkVzFzQVZTSy81cWN1elFDZkFR?=
 =?utf-8?B?aFlueFBrUWsyWVQ0MFM3UW9DYmN5SytjTzV2T1FSRTJ5ek8rRVVWd3prb25V?=
 =?utf-8?B?NWIyRmcrOWZWeFJadzUxUHBrNmVCN3pVeWYya21WSTV1U09DYjUwdkxWaEZw?=
 =?utf-8?B?NWQyUThMVjNiZ1BKTE5iS21pRkllVThQVGs0VlhuV0ZiQjJ2TFNZRXVoUW9I?=
 =?utf-8?B?MXJJWlFPY0F6REpqdm5NTmdwMFdVVGpsV08rWGl5R3BhRTF5MDMxWWR0NEFG?=
 =?utf-8?B?QWovQVBtZkdsdFROcHk1K3gzODhBVFFkeHF1ZUEzTEtSZDNuS0lsUzh0aHVx?=
 =?utf-8?B?K0djUUhiNzJaZEp1WXV5eldSK1VMVVpoV1BoQ0pjY3J6cEZJZDlYT01NREZn?=
 =?utf-8?B?UGlJaUhmN3c3L1dPbVM1elloL1JodktBS1lwdmZyaFBESWlYZXhpZFFpM2tl?=
 =?utf-8?B?QzNSc0EwbVhLUUcvREEzTmxES1lBUDZLZ2doemNVdjNqRDdKdTU5NVZxUUh5?=
 =?utf-8?B?bkdKMGVZN1FiaUZ2azh4QU0rbkRLVncyZFNxWDlFV254U1laOXNMeHNBR3J4?=
 =?utf-8?B?MUMrK0NSV24wMEtDWE9VdnVkTFpzM2E3dFRnQmJwUEprRmZUaFlIdGtjRitS?=
 =?utf-8?B?OUlPWUZwYzdSMGNHNXhlMTlpQ2RnOEMzejVmRlZoQWlYTUYzWFpUbnRoVzZC?=
 =?utf-8?B?UzJaU09FNmp3aS9ocGhtcm5mcHcyRXBXZnVEbTBjWmJWMDBXT01Xek5ZNjdK?=
 =?utf-8?B?OHBPSEt5ZXlhbXBpNDJ2UnlHNTdqRitqSVVRaCtMTCtiMXJNWTNlVHJzNHlQ?=
 =?utf-8?B?bjNZclFwR3BZWW95TU9ESEZIVTRTWmkrSjV4UnowQ1IrTTc2aEFDZjEwS2FH?=
 =?utf-8?B?V2o1ZjNkcVQwRFcxZWcvNjlTanlGKysrUE5idmdrZUNYNUp0RCt6MlhpTmt1?=
 =?utf-8?B?UEY3aTlTWXBySjRmRlBENTN3SVkrc2xPU3RlTjJ6RDN5dENwV1FGL2h2YWtt?=
 =?utf-8?B?MERtVGpQK2dYMHpSamZzV2pnSDZoMzhrK1I2SWJBVFpKa1hJeXRld0N5MHRB?=
 =?utf-8?B?L09HRHRkZ1NHUEdDakt0Z1RYL2g0cWFFbkJqSURPemVpSEtWZEZ0VVQ1WEFG?=
 =?utf-8?B?SjY1WFMzVFJ4SlBCekc1WEVuUmxaa0d6U0J1YUU0QWtDMmpoc2k2V2cyMm1R?=
 =?utf-8?B?cDZzMVE1RDM4VFJhbkxwNEZyNUh2azJqOWxqSldxMGFQSVI5V0dZQTA2b2E1?=
 =?utf-8?B?VVZxNDZoV1JrZzVMQm1mSEFIK3c4b0FsTWFYbVI0VlhXY1NoRnNoZTNOa0t6?=
 =?utf-8?B?TTl5eWJUK2wvbnh0OXd4UGd6WStkZENWT2wxeDRWU0ZPenYzbUdKdGNySzE5?=
 =?utf-8?B?cVora3BoNzN2WUk3K0gxamgxSVNkU2R1UERoMWY5eUI5bFRXa01rUXlGL2lw?=
 =?utf-8?B?UUJWSGc3NGwvR1Q2RlUzVDVjbEp1WTJLZjFzTVlySEFvaU1pdENIY3BQK2tw?=
 =?utf-8?B?Z1RhM2pQLzlPMHVHcHoyRGNGQUFvSkFGalVuM0IvM1FMT3JnTFV4eTBHOXhG?=
 =?utf-8?B?Y3ZZQmd2YkF6VVFmODRGMk9OajdyUTAxd0EyMDJCUU5Lbk93eHVPVnVPSy85?=
 =?utf-8?B?ZnRlL1V3SG54MjZoQmdEZzRjNVdKV3ByY3pSR0FWNGVGa3VaUXBMc2tqTVI2?=
 =?utf-8?B?UTZNM2o3a28rdTBCYWVlVmJaSnFKZC8vVGk3T1FYYkdPTExqZ0w4SjAyVDl1?=
 =?utf-8?B?ci9VQlIzVkpjMzFUN2V2UlZjKzljYmpFbUdqZVQzZW0wRkZXWmlETElYRDNP?=
 =?utf-8?B?Z0lvK2tNSWtaNUc5RnVPQ3ppUHlPZ0o3enBBRGc4RlpmSGVERWhraFoyaS9U?=
 =?utf-8?B?MHNxc25WVXE1UTJNZDZWNy9MVTlZSDEybTdUVFlYVkM5M2V3V0RNSHVaVktM?=
 =?utf-8?B?ZkMvRXpwS0g4SDdacUxubE5wYyszcU05dEIzOG5VbmtOMFFSMGkyNnFWa21j?=
 =?utf-8?B?elBjRnJHRk9laGtDbEJBdkV5UUpibWpwUGlCdGxvRlZ6L0hvbGg4NE1YQXFZ?=
 =?utf-8?B?ZjlkODVUbExGd3NYQVN1S211WitDNHZXeXYvOVVSYUNYTUJSc1ZKMG1OS2o2?=
 =?utf-8?B?Z3RyQ1M5S2QyTC9LbFBlRVBhbVlXM2YvTkZNRUlwZHRhVHBhQ2dkUXNtNVVV?=
 =?utf-8?B?T2ZhS016K3RJdFgvdmZIQmIyN0o2ZlJWd0V1OGxRdUFyc2EvTzk0R0F1RHYy?=
 =?utf-8?B?WkZ6c1gwNUs4bXBXNUJGbUlCdWp2YWdkejdTclB6Z2ZIY0pRNS9SZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cdaf7b-471a-4812-0b20-08df072a7c2d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:38:36.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaA6Zi39ZLOP/6nJKp0rZgGP3DfMzROUh1wnyLGX0wrW06kVJXYV55HbPmNKlnwnTyYDfocvWynhmQAERxBNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831

From: Jan Kiszka <jan.kiszka@siemens.com>

This documents our official vulnerability reporting line along with our
definition of what the project considers to be a vulnerability due to
its security model.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This targets the xenomai3 repo for now, but we will likely adjust and 
apply it to others later on as well.

 SECURITY.md | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000000..a2a08abfdd
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,38 @@
+# Security Policy
+
+The Xenomai community takes the security of its code seriously. If you think
+you have found a security vulnerability, please read the next sections and
+follow the instructions to report your finding.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyond
+what it was originally designed and also secured for. Therefore, we describe
+here how Xenomai is currently expected to be used in security-sensitive
+scenarios.
+
+Access to the real-time core of Xenomai is considered a privileged operation.
+Therefore, typical real-time applications are running as root user or with
+otherwise raised privileges as they can, by nature, dominate CPU resources via
+the real-time core. Xenomai does not provide any secure temporal partitioning
+mechanisms but rather expects all real-time applications to collaboratively
+use its services. While the core foresees granting non-root users access to
+the real-time core as well, there are no guarantees provided to isolate
+different users from each other regarding theses resources.
+
+Still, the Xenomai real-time core is designed and implemented to maintain
+isolation mechanisms regarding regular Linux resources. Any violation of this
+would be considered by us as a vulnerability.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public channel
+(mailing list, public gitlab issue etc.). Instead, create a report via
+https://gitlab.com/Xenomai/xenomai3/xenomai/-/work_items/new?issue%5Bissue_type%5D=incident&issue%5Bconfidential%5D=true
+or contact the maintainers jan.kiszka@siemens.com and rpm@xenomai.org via email
+directly. Please provide a detailed description of the issue, the steps to
+reproduce it, the affected versions and, if already available, a proposal for a
+fix. You should receive a response within 10 working days. If the issue is
+confirmed as a vulnerability by us, we will request a CVE via GitLab, publish
+the fix and give credits for your report if desired. This project follows a 90
+day disclosure timeline.
-- 
2.47.3

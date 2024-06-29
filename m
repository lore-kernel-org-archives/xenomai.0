Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CE1CFA0
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719650497; cv=fail; b=FHuEcyjFiBB5hRu19HS+gJyhFMP5aXWrFjz6MdU6dGFXDN+qtN2cZ1RMHyXHvP1FOzLP1HF7X2gQvlFj1g28E73EDsHxh3FgLpFLzZaJX3LzvIlf5CDIJJE0nG0RNw9CXHJXQ83PMr+6hnGHss73zWB/SL2NX2kw4DCo41gW0WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719650497; c=relaxed/simple;
	bh=mosWREnPCsPOOrL7m29blsHH3pi161cOFPnGXj1brBg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Cm+7PMfUWWSTFOxXd5n3GY3XK3kyQnTOMWMD8W0geWKmjoHgn28kTgEtzqp1JgCqv0QrGTIz8Q8/foFdrvaBarfAPG7bpnDO+NpgX9yz6rFDBxGDno68ebMvMg3bxO8R+oAkzE93esmtlyj0HMC44QoG9rt67f31Nmvpp5k2JTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LxJcHjw2; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LxJcHjw2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5qlpqEMlnRpifhEEqQOYE9PVuBuawjzUMlKKuNS9yU046oWufKiyIq22kTrIaOQ1haz8+Zv8u5eeItOT8eetnFmgTLzNt7CxkZOi8m0PoS9NHuyC+KwdJxz+gNaFG1LW0uaggdw684pvfwwhd6AIUzR1zDXoNCT4qlkt2fM5nhWa2rMrCLnU5oEgTIhyQGiCeCTjzpJNgLRDj3bDYhXkIofkGc8Ljc5ORnHgusYU2XZKwyfeaU6fqQkxhq4c0STZ8zRc6NuiqDkiZ2C4oJ9mfenNNXRt0r4vFNx3ENia3HUyp1eBODnbml9XJv5+H8BTsrUhW8l25UwFdKikhhlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIpiYMxXPnUnX0sQhOzVAHTOEYFhHQYKCtAchcqn1Bw=;
 b=BoSOwHt+BVSsLk+yMlfkMU7GBu79J8F2GWGEfvalPuPrWEsE8tA9dE3Azx5Cv7wmvLkmWaIC9bjR9+sX+bnwLYHN70fnys1Z7OcEhUt1Et8GfNA0Nq2BBu9IbkOz4+3M3KTRpbZcoqvrAlKsbNfp0A6++I6w2MxW1FKzf3k6m+ZCLrTYqvtqkL2lPIpNJsHrryPE864cWZ0e9Ah451lA3/+qoyziIsN2VMVVVFXgI2y7r61vutbRjB/TSDOQU70Mr697TVqwKosn2BBM3lxdnrugOTq05ue5NbQyvYH7Kn5FtEm+ZdXUMoEwkObBskrEDPa801EBA3MObd92mcbxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIpiYMxXPnUnX0sQhOzVAHTOEYFhHQYKCtAchcqn1Bw=;
 b=LxJcHjw2Rr8WwQvW/F827WfkrWDP/UoQMI4RamAZPri8Tg7+vBb+/0fxOQOPSAUUve3tpr8Q9F7Tf357ol80bAibnHcPqfwe/yqMrBSpKvkzzjfgvLWM7/ITedUxB8iVV42wxYuw5ue8crSbOO/Oc6LK40PfVIFI1aKFIKMgIvNSxJoj9mxS3n8ao4qP6sUzHlfJJHqsQtAVRm3I1QLBXT6NStXixVR0qBDJJ+hILMGSrIaWxEAp0k/Z0WFIQ6ytPaRB+G3KALtT/LKzjCE/QxutyAR2OfkzTAdaE6RRf2YvPeYlqE7mSpauqu0LT8S4t3jab2lzPS7343JNyz58dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Sat, 29 Jun
 2024 08:41:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Sat, 29 Jun 2024
 08:41:28 +0000
Message-ID: <b2104081-55d3-4a48-92f4-bb07a710171d@siemens.com>
Date: Sat, 29 Jun 2024 10:41:26 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [ANNOUNCE] Xenomai 3.3-rc1 available
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf62f7e-d875-42f6-18e7-08dc981744dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEpkeTFYeVpyVWNiZ2RzSElGZW5vQjlJUVNwYTRDYkcvOTIva0E5K2xLQ2cr?=
 =?utf-8?B?M3ZWMXVRSlpKTzZjcUszeEdQOUtUTGh0a2FpQlpOVUoxOUQvb0ZuTlhVNFJK?=
 =?utf-8?B?ZnFaSWZWZWphRTBXWWpyUTF0VER3RmhsS3FWRHFwZGlxYUpKemRYdTZlSEc5?=
 =?utf-8?B?bG9SWCtLdVh3cFVqNlNMNGVNNlo0cGViZ3Bqak42eFRteTBVSHluUnZ3ZVFv?=
 =?utf-8?B?TmN3MEltbU5iQzVqaWwvYkQrNTBvMEVUbWRkdWNRNDJqQWJYdXZsK05ENlZn?=
 =?utf-8?B?dDNLNEFWTCtlTFRzdks3dnIrTmJPS1k1dEU4QlhOWVZXV1dNMTVGeGdKRXMr?=
 =?utf-8?B?ejFFVUN2bm5XTDkzTmtiMjhaTmVHYkU3QWZLa0NDY1A3aVJOVUlnTE13NXg3?=
 =?utf-8?B?REEzUnlyQnpTd1h4YXI0ZUFMUjh2STVLS2VwcTRBQWNwZFNId0VTRjVtWjcr?=
 =?utf-8?B?Z09NbExvNS9HZGI2NFlUQTZhT3o2T1hmb1pNYWxPYjFDdnEzUDNpdEFuY3Uv?=
 =?utf-8?B?WnowT0FvUTlKTzBzRExZTVkycHEvbUJ0N1R3cGNQakhSWmJzRWJUNFFXcFZK?=
 =?utf-8?B?Z1cvVVRyTndob1VrYlNPOTRkUlJjRFIxVGFxNGhCTjV1cEJDYjhId2pSaHhh?=
 =?utf-8?B?YVp3Y0hnTDFpdFpsUWF6Yno5UExMQkpiUHljUkJZOE93RjlCeVNJYit6R3d5?=
 =?utf-8?B?a2tnYUhlQTRjZ014L3JScFUzWVN5SEtueVU5V0svNTE0ZUNRd05oZWNmZk5H?=
 =?utf-8?B?NkVzUTZVclVFWEI3K01YUytMUzVpaFczNkNiT0FQYlVqQVBYeVlMQ0ZiZkxX?=
 =?utf-8?B?VW10Yms5eUNidmNHUVBSd1J3Z1QyalFGUDFycGxWNXJtem82Y01xaHkzdU1E?=
 =?utf-8?B?YUYwOWJsTDdxaUR3S21RbzFseXZJR1ZMZWxmKzhjcW5HTTlLOW9DTXpUN3hZ?=
 =?utf-8?B?QUZUZFArc3VBRnBGUnRVRi9OWjdVYzRLQXdLeUxOT1k4cS9BZldVaFVJYmVr?=
 =?utf-8?B?VXNWRXFYN1VRRHVMZXdIUmZ4NFp6dlVzR21uLzNCbktkOTRpaTFUUkpVZmpN?=
 =?utf-8?B?dzdONEswU1Y0d0FodTVWZmJ2N0c4aDI0bUpBTHRtK0FpNjdxS2V2UElMWWFG?=
 =?utf-8?B?YnZ6bWtjVnRPaW8vSFdsc3lCRjFvVk94enhqNlNUSFFHRXFiWitYR2VNUStN?=
 =?utf-8?B?cUl3QzhHR1c4T0hOSW9nV2lHMXVIM1E4LzRNSlZOalR5ZmFCdmxSaDI1Uno5?=
 =?utf-8?B?ako4bGJERE8rRlM3czdqbm9samtzdjB5OVNUTllTblJHUXRKQ25oNlFFVFdD?=
 =?utf-8?B?OFNyZy8rbUJBaGIzYjVWbCtGbVFHak5rQ3R1TmFSd1ZWekpyZE5UOGtwNTR1?=
 =?utf-8?B?OGNid3NPSzg4bTdFMWhYditsdk10UnIrQ3ppeE1DMkUxaVVNdDkwVnlFSlox?=
 =?utf-8?B?eWpsTnFwK2k4eGlLZFoydUl0L0FCdTllbStDbmFBSk9oRllPUzh5SDZNaHRz?=
 =?utf-8?B?Q1lQdHh0ZkxUR3N2c3pDTC9zODRNRFNNODhWeG9YTjk4eFUwWWNmS1Q4RUZp?=
 =?utf-8?B?L25Ucm00a2JzSHNhZW5IN2lDWjVwb2J6QU1hYS91UDlhNm9XQzNSaDdzd3By?=
 =?utf-8?B?WnNRbFlZdmlBVUd4ZlJkZFczaFNXYVU0Z2t5OFpKc0pwbFF1VFR2ODFtZFNv?=
 =?utf-8?B?d1ZhMmRZbGExMkFFalVKQ21OeXN3b1hhYlFtTC9ZNTRPdnFBdTJxWC92WldM?=
 =?utf-8?Q?1RQRkxxjm347iwmryU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVRSWHZuS3B3eE5qaXd5VUgzWTB4VDZUSXJ2ZW9BN1lTSU53NStkbWNPWkY0?=
 =?utf-8?B?SERQREZIUXdZaFFWUjJ4SDVSOXo5MVdMSnEyaStrY05keDhPcXBQVnlXZTc3?=
 =?utf-8?B?d3VzUERhRzdVZ1BIeEd6dWZmSStSS2I5VlJhcHNocmlNeXRkaHFkT2pUU01u?=
 =?utf-8?B?NEtOdVR1aTRYZDZjYjlQNzI4WXpxVjlaTnhMbUtkWThUTmJzaGJjNmE3RHh3?=
 =?utf-8?B?WldtMUVQTGpaUHI2ZkZvV1NQY1hJSFUzU2tjbTRzbGYwQ29ZM1dJdWxOZnBN?=
 =?utf-8?B?QlROOENrK0JOa2lLdUk1RDZzVmJXSlpUaEYybVJLVWNYa1VvSzVYMVoxWVVw?=
 =?utf-8?B?bmllemI4bWhNaWpIRnVpYld2ZnE0UWFRN1RabFd1OG1PY2UyKy9KMndab2lM?=
 =?utf-8?B?cmNHQTV2TTFDSi8yZDVIcGE2M2ZZbkw0S3dEQXhFY2ZIa2ZUTW5hM28ySGQx?=
 =?utf-8?B?TDZpNGk0SllMM1JQM3EzYk9qRi9JMVRtb2tCRld0V2pubmdxK1UzUnQybENN?=
 =?utf-8?B?b2xuOVlZSFVRS29nRmR0aW95QlFZNk1yMkVibnFheUlONFRESGh6KzdPaTVK?=
 =?utf-8?B?OUpmSklFQ3RsTWlrQ0NDWG9OMXFtbmFXaHlUMGdINFNwZm8vNXMrSTM5ODla?=
 =?utf-8?B?M1BBWEExNUpxMmRCSlU3RlViUlZjZFpJZzdzYmo1QzhXaWkySzZrU0FJRFI5?=
 =?utf-8?B?N2xwVUZPWDE1V1NtZEd6cCszL1NBbnh4VmJ2WVUrMHhrM0VHekkwaHlwWW9y?=
 =?utf-8?B?d2x1TWlxbyt2YTkxdHBZUTZldUdIcXlnY0pCVEp2QmNUbTRVdktnZjVvWnp4?=
 =?utf-8?B?M0tKaXZzRWZRbFFmekdZeW4zMGtFZlRqOW90Q3dTV3B5TTVNN1hXNUNPc2hw?=
 =?utf-8?B?TUs5YytpajRidzhFcWFISmhBUUZHMkMyKytzRUl1SkRVcHJ6SUwxZTlsQVZm?=
 =?utf-8?B?NG5mTnRQYUhDU0R5MmU4WHc5a2ZRa3B5MGl1SUFhdnlYTXZ3R0FtSlNsYTVH?=
 =?utf-8?B?cGZNcHNnNlR2M3Nodm42dm0vVDRsRm9Gb0tBWitzcHg3UzZOZ1dUOWkvcHVM?=
 =?utf-8?B?b1RjVXFJcUZnTU5CNEhxWDVFYUU3bzBjOVJZWTBDd0YrWHprZWRNdm1ya0hj?=
 =?utf-8?B?dDlaNkVBNCtFOVdzend5bEQwWDlhN0x5aXdpcnkybUJxS01ncVd0eXN4NTN0?=
 =?utf-8?B?SUEwamlTMFg1cGUwWFZKUkFqYkJyeGQ2UFdnelRMNndYaDVMWlY3VWI1dmhy?=
 =?utf-8?B?TGQ0RCthYi85UDQrUWdmU2xjeDBQMlBZdDY5aC9IYzBVcFNXeFJHM2hSV2k5?=
 =?utf-8?B?aDl1SnBkTGp5Y01uaUlrN213eTh3U0pRZExjUFhYVzRwNkpXN3MxYTlNbUwx?=
 =?utf-8?B?dlVjcXlPVlNodExveStkOHJzZWQweXhRZzEzV1E4OWxGZnJ2bklsOHFCVTFW?=
 =?utf-8?B?WVZVeVFBTW8zUmpIU0drTG5aWmxpY3RvTjZ2TDQvU1lSaVNJNkUyMHhRZUts?=
 =?utf-8?B?TFNBcVBwcGplVjU0RlRYa2RsQ1h6WGQ4Q2pESnMvaEpuSFp0ZVd4L1dwNUdu?=
 =?utf-8?B?UFhBZlUzS1JoN29uN2dRYzkvSis2MlNMZTRmUzltOC8yVmUxQlFZZS9MbEQw?=
 =?utf-8?B?M1M1dWZPdUxBTW9pYTZWdTdBeUdDMEZuTTM3UnFwdWN1aGF1U2d5V3c1djAy?=
 =?utf-8?B?R096ZlJEY09raXROS3pqNHpLTmhqTXF5dm5pY3ZrVEI2cnUxTWNCV3d1K2Zk?=
 =?utf-8?B?b2U2cmxOZ280RUIwWWRIY2tHMUVmTVE0ZzFReGZMUVZNL1VIUjZOdEpFWmdF?=
 =?utf-8?B?a1hiMitlQmM4VysxckFITmUvVGN6ZTRxYndOQnMvS2RQZ0Y1KytvRUlFNVN4?=
 =?utf-8?B?a0JKVHdMdDhDckJPK2xEcFVuUFFScGZvR1JHM3Q1T0hyeDBxUVVXam85RW5v?=
 =?utf-8?B?WDZJdlBuVEwyamc4SWk4THNkazR3d2NFZTlPNE1jUExKN01pcjN5OEkxUFBS?=
 =?utf-8?B?ZkptZ3JaWE0xc0ZqSGtKQ0tzME11b2I0SWg3VFM4Si9YdXhVWVlVWWYvWnhj?=
 =?utf-8?B?enhHakdBSy94eEhEUDd5eVdSUVlCZjNVbnVVSTdMVkg3ZERhU0Vvc3kvWjZv?=
 =?utf-8?Q?5qK1zEB3oSZ3gcY80cedLFK9Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf62f7e-d875-42f6-18e7-08dc981744dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 08:41:28.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mr5PZDuB1APHWYfgvbDiDwwB8msJbq33JJLRgMBUjA9VOMZ24gRq+Z3eHHJhP+m4RhwVzw6HksAQShBDGlS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6749

Hi all,

finally, here comes the first release candidate for the new Xenomai 3.3 version.

https://source.denx.de/Xenomai/xenomai/-/archive/v3.3-rc1/xenomai-v3.3-rc1.tar.bz2
https://gitlab.denx.de/Xenomai/xenomai/commits/v3.3-rc1

It officially supports LTS kernels 5.10, 6.1 and 6.6 but should work up 
to kernel 6.9. I-pipe is no longer supported. Please test and report 
back any oddities - but also successful validations.

Thanks to all contributors already!
Jan

-- 
Siemens AG, Technology
Linux Expert Center

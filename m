Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847571A38E3
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658816; cv=fail; b=kOJyZjTldQiox/gNAwN9FvxIJ2MY1iL4057gX+haQUw1D5lYgOvGlwcY5hElyAiZYLea7EtpfbLRiyYa5gvCkRqeSMHtHhbJS5nv6Zf7e/A56AwobMwI7A59Jyi94ZCEsLOEi6h3j5NDAb5ci68n3Ioo8mX1TZyoknVZ96yivYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658816; c=relaxed/simple;
	bh=lu3RLIoJtG3Sl4NdaSnyLkuSrClXPUV35CrJjUfv1ms=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=U81x0MGbRf+X+/dbClFOHbSplgu3kOUPkTbxXwuC3mMxsCdj9BRlD4WwHDRxgVBz70R+Zquha1EpaBKoPx5jjiHNV2eCjCu5toTl0Dqe1Y2/iNWg/KY/bznfTbRIAJb+2l454BwJM37vAznZa9Vg7EU2CD39KoPkX8B9Yh4Qhk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dBAa71UY; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dBAa71UY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdmNbP4EVkP1xdtdXyKBX+7H31yJZym76Mx6aMb0tuJoEKt6PtA0Zzm2V6cL7KBbvsQ7wyybAfj6CQbYpVQCHm1JPhDr+PJhqa8IwnhwIgw0c+/TdaPilLkXfdlbU8a6zfo3ceDtv7vB1qSOQE1sNQHuz4cvFE8mxEtg8CfqdkVZ0vW6i3chdt1bxRvNAm/vCOeiXs622dCIoHhn6zmb4WATPRrbmpWlRKRtpUovRn7Os7L/MBHc4rXyz8KltdAvjISWPzHChUimvigew1n814HMTSFuI/gvk+SX1h3Ceddwm9AB4QBxUMzuGKf3hEIG/SsCWhW9ma22DnHtWY3u+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OWeL9cbTjBBwQh5QnMjHf5na27fqRzXevfQnr3KwgI=;
 b=b9COIKWEhOWE0u28XYQ9qWg0MxImnBdbivwKPq+/UqMyD9Z3kbQ2xsLrZ23DQ0GRYconwhAJIiG54A5BGq7x4fDq7sxF0rDnnW5kDFxIbS5fRFoUpKdz2XpV1SSvo9mQhfWjMX1My9jL5zaJHHXU0+gfuEFME3B6evO7140dMo3wKrc5AGz5pGgBMGKPouadXPaiw2ymChe1n1YeD9VEPuV7iH0ybiByP0c8py3rCs+0vUePFXbJ3V+nIeFBy63Bq9PWg12VwKpLt53EHdIYmaBym0qfZZaYXXlAsUNjgVoo+PzYCzwOf2TneVJIG2OwwgHXWadVmpb75H1lKUdcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OWeL9cbTjBBwQh5QnMjHf5na27fqRzXevfQnr3KwgI=;
 b=dBAa71UYh1uFWzOX/Bh9ytUM1DrUzcnAHCKOVM3A30WkscxeLPvXKe/8xZno49T3maGcm/ymPrmTFCjUD4HOb4V/qZX7/9j9toNG1owGNXhXkhiQsas0cqL4IshmnGqe8xLGlrMrSRoo6lV3C+3ldvIOHsfvDrULANolqk+CjsZo+wBrS5N7dPjZqVh3uSPFwOPwYHGifWZZObSJ15MrA96mW8NEW6cJlIWIDPpRh49LAqndOg5fOCGbyd335sAkNiFgk8pN+WtfHD4yq5kWn5wie9j4zY2s3K0RK6hHUY7mINospEwFAVL08m0LXY50kSQ46FZ1MIs+MP2s+qoFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 16:20:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 16:20:09 +0000
Message-ID: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
Date: Wed, 11 Jun 2025 18:20:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH dovetail 6.1-cip] igb: add missing header for oob extensions
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d75657f-8f8e-4c25-4bf4-08dda903d5e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnppS0FDNjNmZVpwaU9vanIvWUc5em0xb3hJcTdaTXpSOCtlRXlxNU1vcnpi?=
 =?utf-8?B?UnRFZlZrZG1WVS9TYWVoUG9xNWJSZ1EvcnMwanFHZG8rTHZpQ0N5T2ppZVpK?=
 =?utf-8?B?ZkpJZnlzRFJPVTVlU0RGb2Z1eTZhdm5JcUFXV1E0T1lZZytHSVE4eC8zZVYw?=
 =?utf-8?B?VER5d2hPTm1kT1VEQWZ1TXorNmFERzA5L0pkdTJNUCtyN0tWeVYwWHBPNWdR?=
 =?utf-8?B?ajlySkJXNGI4alJVbkxqZ1A1L01XR09iZmYwVVMrT1NUbW16WEUraWVVRWlY?=
 =?utf-8?B?UlpkMEdWUStGU01NWDFIYnByZWQ2V1NGWnhNdXFscjZCc09vWGdqR1JlNE5G?=
 =?utf-8?B?RU1yNnhJd2hHSVdVR3lQVUN2bEhxTlg1aWwyS0dPVFlnSkovaTd4b04xWWVt?=
 =?utf-8?B?SzFRVXN0dVhaMm1UTzBDeDhneSt4RUZ5RUh2VFlHUGg0a0JWOVZKUnY3eEhv?=
 =?utf-8?B?dXd6UnNKR2lWaFA4UnNPYzJsYnRoNEdjUDNmZk9nY1JYbEZQeitiZCtZVldq?=
 =?utf-8?B?Q2svSm8zTDlRQ0VwWTAxNW1qU2UvbUo4bXNFZmY0aW9YNlZRaHoxWTlsc1VE?=
 =?utf-8?B?WWhaeE1PRE93MGhzVWptOWpzNEJKYnd4YkhsMFFGdEhNekJmaTNkMnF4TWVE?=
 =?utf-8?B?SXdtK1o0L2pwZHJpUFk4Nm9vL0EvU2lUS1ZHT3BFSGh2YXFZS3Jod2lzWENY?=
 =?utf-8?B?SnZlMWtZV0ZRWmRJdzJiVGk2QWZVUGVyd0gvaUZnS1h6eHlSR0kyTVR0N3Jk?=
 =?utf-8?B?NmFSZDdxSWhSajVsTUIvZkk4bjJBZ1BhUnpTN2c0a1hZc1l3dnB6ZkMwY0lh?=
 =?utf-8?B?MVZadjhGZmZxck90bDFlajFzcW1FMVdjZk1EVnBYMEtLWXJFZUp4V1NnbGw3?=
 =?utf-8?B?WFluY21mQmFBanNBQ3BxTDB3MFlaL0V6Uml6MXhnV0ZRTTk4YXpsUE9sak5j?=
 =?utf-8?B?RFdkc3NRRTdZU2JCM1BFa21MSXVyKzIzYkozdEFFdFdZVkJMSkJIcU1IRWZm?=
 =?utf-8?B?ZEV4S0daSkNWK0g0ZENtVGVCNCtsUXZaMHc1WlI2U0hKc0dLdlI1NlRxdVFJ?=
 =?utf-8?B?SWp3TWxxeXRkSFpBenpmSExlSk9wN2Zhc3BHSmJ5RUZpMVp4L0R0YU9iWGg1?=
 =?utf-8?B?WGVnaVkrdFNhN0EwRVc5QkRaaXp6MzBRN25wMCtmYnFEMHMycDZRQWxLWmdt?=
 =?utf-8?B?Z2xkSTg5WnpLYXg0NjljbnMvQ2FLZUhmY3ptdTg5eDREcCtpNW1KMk9ZN0oz?=
 =?utf-8?B?cjZOcjVWOC9mMkJoTm5VSnBDL251a0xqTmlFb01UVHZPWmlEeWNSL3dETjY4?=
 =?utf-8?B?RTFlYUtHL3dkT1EvbzlVZ200ZVJxWWNIRXZORDJTMTFhWUNIdVpSV2Z2d1lm?=
 =?utf-8?B?UmxxcVBFTDZ1a29yYmErdUFRV2Noc3NJM2pWQ3RDYzY2TSt1eGl1VDU1MzZs?=
 =?utf-8?B?Q3N5U2R4RDV6OEtjbmpDK2E5a2RvRVpmRmZ2b0psUjFiOW90bGZlZDZ3c1NY?=
 =?utf-8?B?aER4MWJGdENFWXk3Smgrby9zQy8xNlZXL2Z4WGE4Z0FOQ01TQ3pwb3l6b3pE?=
 =?utf-8?B?QWN6RHZrOXZvbVhDMVlVUkd4OW0rM3VSYlFyWDRwVFN5N2lEWHRLNHpXSnY1?=
 =?utf-8?B?ZzJrcnN0TFZ5U01SSk5HYlNWUVRGS2NQRWZ6UU9qYmdNV2ZYM0IyRzJSVmF0?=
 =?utf-8?B?NWlteFkza1lOL1lWSnExdEFwbkFTb09JVkc1eVVseUp0NVZnaktiVmVrTWhw?=
 =?utf-8?B?M0EzTXFqc3cyeUlqK3hNSEtDSFdhTkM0aHN4TEY3OUhWc3UyZUs5TXJjUTlh?=
 =?utf-8?Q?GB0aBWO9m5j5aRG8PVk296gK9VNnt2GdF8Mcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDlQRlRTRVFLVlIvQWR3d2NqOXFFY242MCtJVFRTS3E4bDllWE1Sb1ZtVlNm?=
 =?utf-8?B?dHJCY3ZQTFpqWitJN0EwaU84Z0xSWTdFZUJsZFpld2hxSVAyUENIc0FSYVZN?=
 =?utf-8?B?QW9OaVlDTzRjL0cyYWdIdTNDSDJpaGVLV29NWWFSTlZkb21WRmZLbzNwRkh1?=
 =?utf-8?B?RDlMOUVCYjE5Y3ZIVkZXZDlwajBiY2hhYit6NFJJZm02Zk5KUFJkSmtQSjVV?=
 =?utf-8?B?d2Y0VUxiZllKMEJDZDIvNVNyaGcxV3hnbTlQZjN1RnF2cUd1U3phY3NJRVF5?=
 =?utf-8?B?b1Z6bXVnd0tkL2RrZ0JFSlprYkFLbThCUzJZWExtUm00ODFjZTVsM0p3M2FO?=
 =?utf-8?B?SEIrZGVqT0pKYnFxV3BLVmRVa251LzkvSzFwMndreGFJYklHbXUrejMyV0E0?=
 =?utf-8?B?WVkzVzMwbUhNMkdpWjA2YzF4ZUpVc1htRWI4em9kb1Y0dFJ4eEZGdnVyWTJr?=
 =?utf-8?B?ZjZnMXRiNXFha2lOLzJ0T3pEczRaQlNYVHBBd0ZaMmdBaURmL3pBYWQ0cDM0?=
 =?utf-8?B?MGdwNUhVZFJSZE51TXRlR00zS01mQUVzRWFhazN6UGxkODBaNTlyc252Wksr?=
 =?utf-8?B?aDF0Z2Ryb3pDWitXRlp3ZVpjNjZ5VUF2eE5rY2lMeGZjR3Zsb2piTWVLWXhj?=
 =?utf-8?B?cHNUVVlMTzB0SFdlbWZqSVI1SU5xd3ZITFJ0S1JEc0VmWFpUaVJhK3puMTN6?=
 =?utf-8?B?dHViQklXMEp2M0dIS2tZcVgvcDZXYWxjNTF5c0YvNkYrM3N6TzNyTUNjMVJs?=
 =?utf-8?B?QjdTcVREcStvaG8zejh1L1pMOTdKTW1pRXFMbDNlc0MvZlg1TlNpUnU4SmJT?=
 =?utf-8?B?aTdwWUF3L0FTc1NhQkFDN1d3dFl0V09QbU95WTZzd1Y3cTNEUVY1QUNTVWVm?=
 =?utf-8?B?bGl3UWd2WWI5U2t0a1V0YkpibDFHc21BbkZKS3o0QzJOZHJnY2xhMFFxZVQ5?=
 =?utf-8?B?QldIMTFZYXRwdktRRDR4c2I1T2Z3VUFpNW1FVno4ZEVlei9sSGc1VS83NGM1?=
 =?utf-8?B?VTFjc3loNzBDL2JVdUxmRW1XRklKdGJ1bUwrRjkvUEd1aS9lWUJDTzFuSXo3?=
 =?utf-8?B?eXZRWml6dGxtU2lod1pUQXNlSXpFYVVKVXcvZXZCNUFxTm1DdzVVdm9TMGVZ?=
 =?utf-8?B?M1ViOGV0VFIwbys4eHl1cE5Qc0xGc2k5QUlNSmtRdFMvODBKeWp2VGZkRlVl?=
 =?utf-8?B?UGIwYzliZnh0Lys4QjZlVGZIK0RuTkNWWUpiSkxsSWRLK1liMEkxWHlnZjB2?=
 =?utf-8?B?MjFDNm5qWG9nc3VqUjJ1UzAwMGRWdUNybE5qdEFjS0FTMkprcnhtTDl5eVdH?=
 =?utf-8?B?dFdBYkRVYXMzMlBWVU5uclNQTVJlYzF4bVVzWFg2ZHRGeDdiSHZmYTFYS0Rq?=
 =?utf-8?B?aDRWVlNveEV4MUpDc0tLNkFRMjNlbU1UMnlUNnRNeE90Z3lXRGxVMjNxQVJr?=
 =?utf-8?B?ZkNTZVY3L29RYVpQclYxMG85WENpQUdVN0xYUUVDbC8xYWM5MFhkRUpqOXBt?=
 =?utf-8?B?TjJYQVMxbHMrTU1rNkZjNUhZNlBFL1g4Rk84blhKY0tZemZzWjg5M0I2b0E2?=
 =?utf-8?B?OGRSRC9KYjR0emplc0RycXhwSTN4WGx0WUlKbWthQXl2MTRRcnlhOE1vbXRs?=
 =?utf-8?B?SkpOaXpRc1JEZW9aZ2l6Z2dBV3NTQWJOZVQ4ZHoxdUJlSXluVm9scjBIZW50?=
 =?utf-8?B?SmdnYVVuZmZNOXUvSitGN2hTNzB2bm5DdnhoRTFiaGhEbFh3UHVQQ1BqamxB?=
 =?utf-8?B?RXI4VWJDdzQ1NElRa3daV3p5ZWM5SlFWd2l4VkVhN1RRQ1BLU2l4UzBtbUNK?=
 =?utf-8?B?TU5Ca0tMQmR0REpBMUJKS0NQQTdWdTNXVjA2VXBRczJWRGZmY3oyd296RUxY?=
 =?utf-8?B?eVFDSUVmU0NMcGgvL0RxbWV5SGJyVGQzbFhwSzlqN1FhYkhCMHF5Smd1WWVG?=
 =?utf-8?B?dVFFOW9BSk1YUkIzVVpPZUc2ellxSG9pYzlRemhGNXgvNkF2RkQ4SjV0Qnpz?=
 =?utf-8?B?cVFVZWRSSXFDeUp1enJsUHAySVkxbjVZNjBERGh6SU92cWgreWR4c2VZb2Rp?=
 =?utf-8?B?N05pTXBVemZSZjRvQkJ3S09XLzRHQXlNUktsY1M0dVpIelZ1U3h6aW4rSXE0?=
 =?utf-8?B?d1JPVkU0d1Z5a2xGMWlmKzJseDFWcDl3R2xjeEdVTXpTa2JabzZKT3B4M0hS?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75657f-8f8e-4c25-4bf4-08dda903d5e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:20:09.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX4tqKbMMiQEBDxRhnUisajWV59/N5gCzIUwozgFyp3JVtstCgiuDPAMDMkfpleh1ZyzR+zit05xQYU42PO/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5714

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Not yet tested, but this should make our pipeline green again:
https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309

 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c0932a3cb220f..26be743f2a6cf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -12,6 +12,7 @@
 #include <linux/pagemap.h>
 #include <linux/netdevice.h>
 #include <linux/ipv6.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
-- 
2.43.0

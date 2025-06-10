Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0325B2E1
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561298; cv=fail; b=OIHQH/psggGrTkZaxHVEq21NUaFXx6iWI8BjjVCb2bNGxTw8V98+m8II56uNvOwEev/WlVMGFxMMfNEGKEPkiYNgVjeTcqgU5AdxkQET89YlTCPLoAxqHmGEm7oJaqaOBmzJ/C5rNFn2qFTpmRpdOLffloQc7EF8xoA3K0eJmog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561298; c=relaxed/simple;
	bh=q1w+SmdMkm8Lyn5mQAZFJqXyv8Hg8osxnOsRDba6C1E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=guJBAzHofT4V36AIMlHTGwRqX+PH+LiCjCDgvXKL9JHi3VnEsuM7ECwmdGVlgA250ZNt23dVVddqEHffBCxLKXxoeTJCl0YAmUaULZWdI6amDEhF/zQ0R+8T/T+PV9wdxeBBHIy3mJUhum8FCwMqTYKehox7c8NtQlioc90RsI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FU2mKvi3; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FU2mKvi3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjjmvbvn5kC/0jqI2tfOB2zpM6Jay5Gn7NrJ/pm8q4LCzN69gre02rM9dgkpkGnU0EnbkF84E4eJRMlm6rveoiErCZfiFPmBKnDmUnLVETEI1uTC7soUR2f0B5AEN7SOlzG2T2k/Oks3yhn0eCuqkaoxE/Odk4FE17u5M3r19o0/xCHM6ZylH/FQTxMb22dOfMqaSMfugfI1dhi4QHdW8466n4fH5JecHBHtjY3sF01RzsGCbcHRoPAzErJw912CTwprmiTQIH5QSBf+/ryWluQt7PYrRSPWgPledRYx2StheAj9kB2UY9MJEkq2KeiGrWZkRfTWTpDo9O/OJaQkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHK5Tiw+JvA3Uiqhjgn2Xi46qkx+yGgxO5WU7Ow6dDw=;
 b=ilkjF3FW0kfXKfPZBlZuGyUKLd9oIXF23Lho0+PDat4FI0xfbzvkslkvc5hu2U2gKcp3+RbCOqChJ88ESeiAXebJA2ZtdfEhuXOtcUd8/8l0IfioJK6WDwkCq91qYOtHkRa/R14mFHtnEGUgFdGtSpIKibmZiXE2tCj784wGKWV+6AgJ8Ku/r2VroWN2zWr6eD6lwJw5Pp42JwzVvltlPZtwLNVgl0zwOi7aECB+lgD53EwzDGCYoowruz7iBpGBMJf1rZr3GS3PLEOcc0kuM41rsut9vpp+eL/8AFmq3f2KaFf5tPnyMQIB/TQ52LFyi03p5DqxubUP+0JLgBczgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHK5Tiw+JvA3Uiqhjgn2Xi46qkx+yGgxO5WU7Ow6dDw=;
 b=FU2mKvi3VGONHLE/xrJ+E72x/js1ygu/+uifNYKcXSjQXnPmqPp9s802I/9JVVmsFsY8+jwTDb0bsiFaNqJkYCwYA6n4RX5Fx9kr54gDgteFEQq9xXIVuwtZyiuS5Luk5IFDcMMrC5GW/qRHbyk3bI996zF+MAK3UXK72rg5m6RyYtVEbRJHUkwL1Cmp0qmyX+bXpJTOVFZifxmXm6s3r3qE0XBj5MxphvIwYi/2vrx2s+gFz3G1DCiXlnncmqBhdoJajFhnvDAE8tc86aMRA4Za//gEafiBTHwnv5ZbYQySk/j7WELq0hesH4orQLHhmyC0Yx1n/cXf/srTBHD79g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 13:14:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:14:53 +0000
Message-ID: <7dedd353-3b3c-4ab5-b556-121ef3acd013@siemens.com>
Date: Tue, 10 Jun 2025 15:14:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] lib/cobalt: Fix cancellation issues over
 pthread_cond_[timed]wait
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: 851c1ad3-2341-4648-489f-08dda820c9c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEJFaGpnMG0wamx1ckJqdDRFQXJ0N0xHV0luQ0wwaHJpZy9qRDlWL0FaRFYw?=
 =?utf-8?B?WkRKMnNkQ05yVU5SU0NqNTdJZjJCYjdpNnZLSTROSmExa1YvYloweWlla3Zr?=
 =?utf-8?B?Q3dPanNhZ0RvRkUzWXNjMjNwK25SeG1oaW5ZU01ySFRKVU9iakZ0Y1RrSGJ0?=
 =?utf-8?B?cDhmejRhdEhuYzl6NHhuYU1hVm92b20zNm9HQnljc3VXOFRPc3VyVElLYjJq?=
 =?utf-8?B?aWpXenJuNVUvL1VYMW9lWjA1OThYWVFMK3hkUE5hSm96ZWtjTTBRYUlBMTV6?=
 =?utf-8?B?Q2NrNVBEcDBLVm1BaHdpOGszV00ySWZqNnNFRTFCT1BSOWZhbW5ETjY2MG5p?=
 =?utf-8?B?VGJCbFc2OWkzdHdDTHA1NCtRQ0REc24vRjZCendOaGVIWWRZZmVVNURxZlFr?=
 =?utf-8?B?clJWR1FhUXcxZC9LemIvY3R6Q2dzdnQzY2NmWkVPd05yWFcxNCtUTzZsMEVi?=
 =?utf-8?B?akM5Y2drTEFRNXFZTmFnU0MxeVMzQUVFYmdzWkhKZmxYQjU4bkxBWWExa2l2?=
 =?utf-8?B?NzVSKytzY1F2U1ZSTHJqWWt2enVwWmswR0ZoVWhLNEQ0T096OHdOMWtxMHFw?=
 =?utf-8?B?Q1M0Z1FCT0JBTUNXSU8wcUc1TW05R010aWhQVjNTUVRJb2VVdmhRSUZ1cmdv?=
 =?utf-8?B?UUI1T1M3bERjQXVJakN3bmZ5Zk83VWE4Z0xiYllwMGxUb3NTTVVXcnVxSlJt?=
 =?utf-8?B?ZDJjOU15N0M3V05qUkJsNERjVE9TZEltZjhQdHEvMUFydFY2aFNBdE1tUC9p?=
 =?utf-8?B?ejhUeUhROGt2ZlJNbEVGUGpFRVk5UTUybm1MMTBmUWJUUWUxOVdIL3IwVjJm?=
 =?utf-8?B?ZVlpOVhINmVRK0Y1VVVRY3RFbExPeGlrczdBYjJuSUhCalczTjBYQmtaS2dE?=
 =?utf-8?B?ZmhxODdIaG1aVmsySUlJa0FKa1Z1cEUwZzJPRm0wUHJ2SUVZR0kvbUFCV0dX?=
 =?utf-8?B?Rk5VeDN6QVEyWSsxN1FXN3ZWUlRlOUhsYnF4QW84eS9TOUFyYVEybjRGV1ZL?=
 =?utf-8?B?OWFkcVRVWm5rS0tUZE1IaG5UYy9TMjJyalBjUDRJWS9nelZkL3FmejJReHM2?=
 =?utf-8?B?Y2tqZHJPOUFDNTRvQ3Z4QVJDLzFLOGNHN1gva0tDTTdVSGxFK2pESEd4ZjNZ?=
 =?utf-8?B?VDBjWWxDay9qZGh1eGovalZ4eU1DVVRvek90MlB0NlRzVmxtMkI2MnJzMGtG?=
 =?utf-8?B?S2JWb2phTDZSM3VNQjJrT1Y5UFZTUDFubjkrU1FZTEkwTGZKdlFWclVNUmFD?=
 =?utf-8?B?OHE0VmNqWmFmOEhpbExIZDNpWkk5Y1RFeS9sUkxXOXpTVE5lQ25uOTI5NTkr?=
 =?utf-8?B?T3E2NE5oOWNIME13M2pLYlRMQklxb0gyTVlHZ1VSeFdRY2lOYmh0Z0pjaTFz?=
 =?utf-8?B?Yko3MWlBYXhBNnJWYlJ6VDdPeVNOUFdscTFaajhsQ1F6N2NVMnpET2pKVFkx?=
 =?utf-8?B?UnRBdWEvdEJETkZMaHhKa1I3UFJmU1BONDRpd2hHeXhEVkhVclhpZGJjcS9r?=
 =?utf-8?B?V0ZPVnRWSGRxWkhldy9WT1QxMTh0bEVNanRycTBpdHZyeXoxYUZ5ZXZNeEVw?=
 =?utf-8?B?ZzJBcm5JMkU1VDdiZXVjdyt0UWRiY1BZdnpCQ2g2akUwcGFKWmNhWXVZaXM0?=
 =?utf-8?B?MDA0MGJ6TTRadUdEUXVGdGJxc1h4NFpMaTFXbm5iTFhpNVp0MDNRK3hYZzl0?=
 =?utf-8?B?by96dityY25JQ1JHNXVYUnZxRDcvUStkaWs4eFVPRFFVeTFYQmdNb1c2b3Ur?=
 =?utf-8?B?enJNanN0bnlURVhyTlBqbmFqOFFTQXFpTERJTnZvRWZtYUZ3c0pCRkF1UjhR?=
 =?utf-8?B?bHJkWnMrajNmeVk1c2RWS3FKblpXUHI0MWswVkpzSFpOTW1mdTIyd2pheXFH?=
 =?utf-8?B?OGh5bVpjQWh5OUxSTU1vT3NQUU85SmVqd2lxa3I3eDBYUk1OQiswU0k2QjhO?=
 =?utf-8?Q?nBon11pDKBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGhpcllCbmlBdmt5TDNjUXIrWHltQ2Y1ZFJaaGhzWk4xZXMvL3dhL3JGOXk0?=
 =?utf-8?B?a1UzMWtQckxOTS9LYzZzQ0tYVW9GM3ZEUUhUV0xSYzJMSHI5eVBqb0JPSVox?=
 =?utf-8?B?eFg0cGNpY1Ixc0hoWGNUNHN2b3lnanJ1bUFFZDlkOWo5ZmZ2NzB6eDNERnNC?=
 =?utf-8?B?cnFPKy96aUV6UmxYMVlmaElFcTNlK1dDUWVib1c1Z3dKZG85YjJmd0xpRmFl?=
 =?utf-8?B?c0txV01TenNYQVZXYk9aVW5tY1YrQldyaHN5S1hMZVlqVDh1N2JMRGtnR0Qv?=
 =?utf-8?B?RFkyUHluelNWeUtlYjFaTWZCVzc3RXpoRkhrMzRrT2k3alNRc3VjcFBwS2Yv?=
 =?utf-8?B?V25xNkNuT1R6K0grdnpRb2oxNnNYV3lzK0xoTjhxcDlxbC8vOS9Va3dMU0Vp?=
 =?utf-8?B?aW1RS3JFUDZuSlZiVU9ZV1FraDVoZ1pPV0hXV2NnMHpWWTRHWVJJc29oM0h2?=
 =?utf-8?B?bDRFamp4VXkwVVRJUFJkeHlNNkl6ekdjdHlNTFNDcUVyTUhrbkVLVHBMc1ps?=
 =?utf-8?B?Y0NMcU03bHZEYXdTZVd0RHl6NTh1YWthNnJNQXhaeENGaEdIN01CazU1dnpX?=
 =?utf-8?B?c3YrOG8zYktXOHROdldxeDliU1RGM0VSSHJmbHlPbGljUUE4NUx2TSswSTBQ?=
 =?utf-8?B?NlJWZFdma2l1SzJNSk5IQnIzN2E5RDB3TVhlTTRUZ2hrSnArUUcwQ3R3d1RW?=
 =?utf-8?B?RGRnbWJtWTBtZU91TXlGdUR5enB4U0Q1UUEyelQrQkgycnVMN20xZmJyLzNQ?=
 =?utf-8?B?N1prRVhJRmNBb1JLRXIzQlYxT2RmRC9aY0paV052RHR3Vk1nVVhCUGI5SndX?=
 =?utf-8?B?elBUNW9aMHc5MGxFRUgzWm1ZSCtNV1hNVGhOeHh2UUljd3V5czhsYTFsYXRr?=
 =?utf-8?B?UnhnNU1seE15NGxUWWJnaWhFK08rVG1NcnczMTNsVXhvbFdTQ1lwRDZ4ZG9s?=
 =?utf-8?B?d1EyVkRIUGRnaXVSejRDZ2NRbiszN251Rk1UQ0dZT2h1WUZLS1BDMVBPU2pO?=
 =?utf-8?B?V1M1MEE0d0gwTWRPcDk3R1lzUDNxRjk2RnUyMDdJalVHaml2eTRSNWtZNWZp?=
 =?utf-8?B?OGtVdXpDOWNQdVMyclJtN3JlUlZrbEVpUmFzWHF5QVllR1U2bFBiZEk0eHc5?=
 =?utf-8?B?SXhlZ0FXQUd3S01DZi84clRDQXpaQnJIQ3I3ZldlKzNrSE9wY0JSZXYrV1Ix?=
 =?utf-8?B?aWpEUzlpRGRGRGZuT2k5dWU1bzFpam5WS2V0UUZ4QVpVTWkwRDkyb1M4QXd5?=
 =?utf-8?B?NzNnVEhNdDJTTG9JY0lRT3oyRjdzMnh4UU5rMCtBS3dUeGIxSy9jR09iY1V1?=
 =?utf-8?B?K2xRa0dQa2kvOEtDWittTzc5NEZJME9tUmdXWHFnSzhxVFl2S0NXYVlMenJp?=
 =?utf-8?B?U3FvVnRUUW5VRXpuSUZkaFNaOFNtTjVvZWFueEdCaXBOQm04NFYrdlhIL2hL?=
 =?utf-8?B?ZkQ2S3pFVjByVDAzN04xVENNMGlOK3h5NWRJUHlHampVNno2VzVjVTljOGZu?=
 =?utf-8?B?U3RTMGlZaEJibXlBNG1pbGY3dEV3RlhROXVTVVVTVU1OK3p2aTlhYjdaL2Q5?=
 =?utf-8?B?a0NPQy9BdEhYZWJzaExOQXBXc1R2RllXV0tpMys0c0M5bUNmNHUwMEFrL0d6?=
 =?utf-8?B?cTAzdEhSd3JkVDRSSGdDdVdFK2JrMkx2aWt4SXlIcTU1aW5DQWF2SEgvWElp?=
 =?utf-8?B?dlJUU0crY29hU1lFZDR1N2NkSEJpaWc5Y1EyakxQbXd5c3FSdzhUL0hrQ3ZN?=
 =?utf-8?B?bWFINlpZaGxKMEtEU3ZTUG13eVMwQ3gzWTNWNmRBOHVWSnNzeGVMakdScWRK?=
 =?utf-8?B?TU1FWjRUTVRXNk5VSW51UFloMGZHczFIWGRHc09vWlFRUEhMdUpPVDBDb29P?=
 =?utf-8?B?SXZlTzcyM21zcnBDUlhOY2xOcDRpdUpHNlpTRDFzaGRjUlc4ZzhJNUZFRXh0?=
 =?utf-8?B?VXJRa1daMnBIR045UURLdFlmRkRUVkN3MVltd0F4SWYxaXlwY0RHejdBQ2Zv?=
 =?utf-8?B?L2F3M01VM1g3OGlJVTFXclFiSTVodXhWRE51N2EvZEs1Ykh0UFJlbVVDdmhJ?=
 =?utf-8?B?MVJkbTBieGFQaGIvcmVqMlcxRVp6T3hTTWdKTFVjVCtKNVRNTXkyUUdCYXo4?=
 =?utf-8?Q?MyakqvmDVuzZ2WYA8XiCknOs3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c1ad3-2341-4648-489f-08dda820c9c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:14:53.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04Wntc0Br9FKM3GZWGvhwgQOCqP4WxEX+4BvbEpajLsb8bpSkN++FZhF7tSN51qyU5zoIFjVHCZ6shH+CBFlHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432

From: Jan Kiszka <jan.kiszka@siemens.com>

First of all, the usage of cobalt_cond_cleanup_t::count got broken long
ago, leaving this field initialized to 0 rather than the actual state on
entry. This could have corrupted lockcnt of the associated mutex when
triggering the cleanup.

The second issue, and that was always broken, is that cancellation was
only checked outside of the -EINTR look. But as cancellation actually
triggers an early return from the cobalt syscall with -EINTR, we never
canceled and just continued to block unless async cancellation was
enabled.

Fixes: a90f68351124 ("cobalt: more mutex and condvars cleanups")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is sensitive code, reviews highly appreciated!
Additional test cases may follow later. Found while making [1] Xenomai-
aware - which is kind of test case as well.

[1] https://github.com/scheduler-tools/rt-app

 lib/cobalt/cond.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 301dabdcae..7de4d38cda 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -300,7 +300,6 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 		.err = 0,
 	};
 	int err, oldtype;
-	unsigned count;
 
 	if (_mx->magic != COBALT_MUTEX_MAGIC)
 		return EINVAL;
@@ -319,9 +318,9 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 			return EPERM;
 	}
 
-	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
+	c.count = _mx->lockcnt;
 
-	count = _mx->lockcnt;
+	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
@@ -331,12 +330,12 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 
 	pthread_cleanup_pop(0);
 
-	while (err == -EINTR)
+	while (err == -EINTR) {
 		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);
+		pthread_testcancel();
+	}
 
-	_mx->lockcnt = count;
-
-	pthread_testcancel();
+	_mx->lockcnt = c.count;
 
 	return -err ?: -c.err;
 }
@@ -388,7 +387,6 @@ COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
 		.mutex = _mx,
 	};
 	int err, oldtype;
-	unsigned count;
 
 	if (_mx->magic != COBALT_MUTEX_MAGIC)
 		return EINVAL;
@@ -407,9 +405,9 @@ COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
 			return EPERM;
 	}
 
-	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
+	c.count = _mx->lockcnt;
 
-	count = _mx->lockcnt;
+	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
@@ -419,12 +417,12 @@ COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
 
 	pthread_cleanup_pop(0);
 
-	while (err == -EINTR)
+	while (err == -EINTR) {
 		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);
+		pthread_testcancel();
+	}
 
-	_mx->lockcnt = count;
-
-	pthread_testcancel();
+	_mx->lockcnt = c.count;
 
 	return -err ?: -c.err;
 }
-- 
2.43.0

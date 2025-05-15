Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013005.outbound.protection.outlook.com [52.101.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA652749C0
	for <xenomai@lists.linux.dev>; Thu, 15 May 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294722; cv=fail; b=i9NCgksckpc62gMbE4rQ9giqs1DIYkfKqdVeMT2LZgb2beqlOQnhB8lr4s2mL7u2luIce/x/h34cVDETzBXJUCV94H3yE4jvGLnC05CfSViDxIwCnWdEfMq+dU6rE/aiOnHAeMjz4aTY3Dgew79tfI7WcUeI/us4xuvsOiNrOSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294722; c=relaxed/simple;
	bh=2ULsyjxC6GZDQKYSPL7a2GQX4cw/jor59X4BQtU4wTU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=BzY2DPkKAsd+ABk8yANoo0QDfzP+Lk3FFL9g2bpE6YjUiAfOrRzIikldb+lxhPUAPP2Uc9X7F8BJ4Dl2CYDLTeIZZ4LrYXt7v9Vgg56GVSG5w7qy3zDw+mIWLzFNW2J7C1fIy1HCoJqzj91eFZxBa5n43FcF1UKax1JcvAhGUPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JI+JX5XX; arc=fail smtp.client-ip=52.101.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JI+JX5XX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srSaO56tZx0Jss0pLP372BpyM2aEIyAl8uu1ZZAXkCeeMplN8jHoX9y4sGBTZVSolQkrWKrkEDztJzzhFYJy1g/MQnajWQMloC3zVPhzTtMvOzD2zZwa+02JNJsYaQrFcVEdJ+yGGaqBk0493m50xinjtKq/ARZtw7jLGlfgHZbh2iYYjMuoAJYOW8Zl9/TdOuF3j7ObY1qeBRY+u5aWcHWA0QaUkVjtI4zQS/UrF9yIgOvffHcw69dMLwr7dkvWV8Gpq3xJzOqri4YuEGUq/FQHlBlo8rVqDBw/H0mMd+S79Nnonws7Qnz/gqVevSsLzMgEuUrEXxjExeLceYcLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5FSB2lA9poh3gB1wEP1x09HggFKSyJGGvObnkd2hJQ=;
 b=SGLx0fMacFapxcEZ6xU9QG6yxdM+Nv8P4/xFgPidHI8JNBjbw8q3qMPH2tjqPNfGC5UADPDa/OrVAXV7qige0WI03hAwunu5+JuC2Nm1EjplrQnpVwT9WaL64Qb4jRSPshjIJpaeF6eV5M4hY1b1cckKl1q7vAVzYZ7TbwhxAY53hPqTtA16h8j6Q/gQP+AywvVUBOBQi0CWO1pjNDwt5Y7Qh6bas5YDIW+dIio9NNzTGR8FhsX5z9tDeLJg5m8Wi3uksr+kKIwB8AUVKeLPi8l1jDR7PyNIXXAmp9tewVRJx2JqTWHJHua034F4IB37U14KwWX/bcLLKNQ1efj2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5FSB2lA9poh3gB1wEP1x09HggFKSyJGGvObnkd2hJQ=;
 b=JI+JX5XX+ypcvFYEyWOq9O79e+1TMutS8iSdFmru+pPY3hLdHSnjvlZBTOpXKK+Pf1nZBhrJ+BMqjlTTHjzsp4OFCUqkaXQN5Xub84aOBsnRiQTgeNKAA9cBe+TIJ7sHA3OF0lh7GZ7k8DeAgVCxugvFqcfusBb285AKOoc99kJzx2yLe9hoy43SrdKF08Sw3wPAryTbgDOlLq7GKCA9KNL2teSTbq1wOfofHEORspWWVUwErLSPMp9t/DjIwiu3Bbs3OYXOaXIVx2uZ3TP4WY2giJO1Zs2fJIk8SLJObOUpC5kV5UO2nfXdmXCWog2Sa2JFdDgx+kkG61oLwLgcLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:612::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 07:38:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:38:37 +0000
Message-ID: <7bead4f1-7563-40d0-87de-73f852de5eba@siemens.com>
Date: Thu, 15 May 2025 09:38:34 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH stable/v3.3.x] ci: Limit compile tests to 6.12-head
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b3f9c5-5aa1-4e1c-791f-08dd938380fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWdtdDVuMEJlUUk3cHFkNC9SNWZnUWk4Q25YUGdTcFYxQWg2ZXJGbDh0VnpH?=
 =?utf-8?B?T1BBREMrS3c3dUMyVmxXempzUFQxd09nREd2LzdZcnhWdmNscVJlZVlqQmQv?=
 =?utf-8?B?UFUyTzR0d1JxOTY3ZEJNdWdaL2pYMEJmdERkV0NQQUNsbDIyUzNFWWFqK3Rn?=
 =?utf-8?B?VXIwenhZVWNVcXNZOGtWRHZnaEx0NFdsbU1GZTJDa2JOMWZSbkpuejIxbEUv?=
 =?utf-8?B?ZDVYa21qYmdHUklLRTlYK25sQVF4cXV5cUVZN2pqL3o2aW5yUzlyZFdZUUZo?=
 =?utf-8?B?WE1jRkxMb1MxV1RIcGJhNFQ2YmJla292VlNjVnkvaVBaRjdNN2twRVNoellQ?=
 =?utf-8?B?Wi96YUhkQUtTajI3T3ZzZHE0Q1dDUkZKT2dlNVpObm1WaVBJNUs2WlhxbStz?=
 =?utf-8?B?WGxRd1I5QVc5WE1JdkpXTUltNkdiUXRzN29ZY2oxMGJwdzVHMjlOdGFiRzhs?=
 =?utf-8?B?d0xMTWl6KzZmdXVoSGtSYVh1YTZFWUNhK2MxRzE1dVRRVEJKMndjYkhxZHlK?=
 =?utf-8?B?NklmdlVxVlFNaDF2VTJJb09XVDRuNlpSVEl1WEIvT2lyeUtnNFJGaHJEVW5i?=
 =?utf-8?B?N2trVjQ5ZXFzY2RFRlhBZmtENCtYcXRlZkNUaGJwM1FxRmZtUkxYSzVKL0NJ?=
 =?utf-8?B?QnNaY3luTVZZa20yQ1p5eWpTdGhKRTdPYitzWC9UblZRYWNrNXZndzFLdUdt?=
 =?utf-8?B?SHA1LysyVTFFRmhvSnJVQm9vNE9xUEMwekI2dklHeW9ZaXBVdlJKbDhDUFZB?=
 =?utf-8?B?ZnF3VVNhYytySnBzL1FqcUNyaWZ1QS9QdTN0eHQxRnhvSEp0ZXFpdXR4RUdv?=
 =?utf-8?B?Ky9KbHRJSG1mUDJ3Q2IxdGZWM3BTcDN4a3dVL0U0N0RIQTJRQjlOTVFuREI5?=
 =?utf-8?B?RmRzbFk2Q252d3A4NUk0Mkk3M0hweVFrbkZpRGlBb1lQMEkxNWtKMGxZLzAv?=
 =?utf-8?B?THBGRFVtOEROQjB1cVh5YTMzVjBHZ2huaDZTWDRjU05LbG44cGkrZFVqYnJm?=
 =?utf-8?B?Q1o2cE4ramgzaUJaZ29jSncxYm5RUzJzcVVLNnd2MUVwNDFLN3A3VHpPQjVu?=
 =?utf-8?B?ZkNWOTVCamU3RXhJSjdCZXhyL1FKWWo3UE0wR1MxUm5MZ2pwUFVpVVJxQmtE?=
 =?utf-8?B?V3l6anFHejhnMkZUcmRoMGFaMHlKK3FaWlpuME9aSUsvdmczWDVHb0o5aUF5?=
 =?utf-8?B?MFFGbmR6ZDNObm82cDR2SXNrdjJueUZiOFV4UXJtT3gyNEw5K2lLZytTdEJY?=
 =?utf-8?B?dWtOdWhMMWl4alE2eGZqbENENlNXZm1VRjhoeUNQY1l1dmd5dWtBS093SmVq?=
 =?utf-8?B?bWRJdm9GNUkrUVBwUzRIdEphTHhrcEh0UmVHZ3N1SFM0RVJicXhEenI5TzIv?=
 =?utf-8?B?a09mc2F5TUVtdDdWSWZpRi9GeHNUaGYzdE44QU5lM3ZQQkdJVzkybXg4NVZp?=
 =?utf-8?B?Y1o3OThvUFZYbDkySW1rQ3dnVlFCNkROa3h3dnhmVmZHS1IydXlYNk84eVlu?=
 =?utf-8?B?andEcG5tNS9HSFl4bERacWVOR3QybkFObzRCMGV5VXY1N0RQSXpaMW9Fdlk4?=
 =?utf-8?B?ZHU1VmlQaSt5cUFybEMyUVBxSFQ3RmdueXliRURsVWdCREU0bUlrZ1hOc3Yz?=
 =?utf-8?B?R25UUjI2RWdWMVBCN0FDQ2NrejRkQWF3M0VEbWxPMXNOdkJKQURlRXVkb2Nt?=
 =?utf-8?B?eXlRN1NWVE44VjV2dktjSG52R2MwUkVTanlHbGNYSk40d1IyZmlEUU5BemUw?=
 =?utf-8?B?VzRPaFJNV1FwWGRYb0VsY2p2bC9idW1KUlJCaXlONGthZEVRc1BwMmV2WVRJ?=
 =?utf-8?B?SU9aVE16SUhrTXJnT2pHcG92N0ZVV3JHQU1FeWxERGdGU2dZTUVWM3ZYOW1N?=
 =?utf-8?B?L0FFN0pxZG1BdENMQ1dWTTJQUVYwNVBZVGtJcHNCNEhIOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29WTVNZNWRzRjRCWnVUWituUmx2eUdBT0RVbTV0L0xYaER5eWFSLzd5ODU4?=
 =?utf-8?B?UWlWaFVsVloyaFhuL0F1RXM5U00xTWdaM20vUU1sWEJqeFFjbG4vejhKOGNR?=
 =?utf-8?B?dks0bnc5Y3FxUmFLM0dLY0k4cTRrbmJhQWd1cjdOK1VHLzZ1bVNpVGRGd3pT?=
 =?utf-8?B?cnRDaURvVVM3TmV3eWRrbGp2OE9KR3JLU1pkUDdiR2pValBFWUVrVVdlUldz?=
 =?utf-8?B?UTdsVmt4OHRodmdxUVJMRHFDTWFGenFwVlJXNUh5VWt2cXNLYVNGWExSNm9M?=
 =?utf-8?B?S2gyTUtzSExwUExzU0FDTlhYMmN1cHhZdVFGT3lIOE1TUElHMWU1Wkl2WDYz?=
 =?utf-8?B?bmI1VzNwZFlXRHU5MENPTTBqZkF2SzZxL0JkZXdwcXJQUSs4Nk9VcTZIa3B2?=
 =?utf-8?B?QUJQbnREQlVqNG94SGVGR2hNblA4RDFLQmNVR2toWllBTXQyVGNtSlZOMzBy?=
 =?utf-8?B?TGpMTStlSnlHd2JRWTFBQ2FlRHJCejRhTGc2VWdKbVlYNEJrc2laQktMQjht?=
 =?utf-8?B?eE8rM1RTc0tFeVZYb1VpTkxyeXpDeVVQbHlZaEJKZnQ0Y2Z5WEhNNk5GVG1E?=
 =?utf-8?B?UERoWURSR3daVEp2V3pFRU5CQ3hTeSt0R2l6ZmJBa1BzYTErZVo0QU1nU0xw?=
 =?utf-8?B?WlkvZkFhUGY0Slc5cXdrQmR1aGFsbnhjalN2aFJaWjdYV3V5N3ZTQnh3bklJ?=
 =?utf-8?B?Tit4cUdmM1pXOFc2YlFGRUozMzBpQnVqRE1FTTY4bjZDamd4VDBxenVMaXFW?=
 =?utf-8?B?TGJMQm9MdmNFdHltTVpsUkN5OExOQStzaXFpRkFOYXJ4Q3o3ck0rR3VpbG5M?=
 =?utf-8?B?ZlN6djFrcEFJVjhpYko4NHNNTVN5SnFlbGtaeGZPc1ZhZjBwT3JJZ3pWRFJr?=
 =?utf-8?B?cHF0aGlCaHVySGdmTXdpVGU1V2h2K3VOU2hmRGNqUEVCUzhvOFh5UVRPVXVi?=
 =?utf-8?B?SHZXYTV5a0ZqT3FPRkdRZTdGbXRsSHFZUzRnNDdMN0hqZ2V5WGhYa2h0K3k1?=
 =?utf-8?B?UkNLbUpiaVFGSU1oS0puanNOa0UyMThXaU13Y0hFUFI4RUViTnNWRE8zNGJG?=
 =?utf-8?B?cUhVOUloaExUc0JYNTlUNWlsYlFvYlp6MmJRc2xTdENXdUlBcDRtemYvdUZ2?=
 =?utf-8?B?Z01Ra3VDQmFsUjNOL0R5dlZ3cGVoNjg1SHo5SFBsUGRGU2tTam1zdWlOeHdF?=
 =?utf-8?B?NFpZVTJsTGRjc3JnWEcxN0NkdXFjbUU2RUhpTE4vREdlTDlJQU4yK25UREM1?=
 =?utf-8?B?U0ljU0RmV1JlR0lVOFdkWlFiU1luRi91TDNVMmNWTGppUlhvMnU1NnlsN0Qr?=
 =?utf-8?B?R1NjY21KVU9jVDBUWTkyZ084MmJEejVrVW10YU9EM010c3B3ZTBWVzVOYmNW?=
 =?utf-8?B?emswb01ub0k0MkRMR0hyck93aWxkS2grYzR2TTlBQk9LdWlJK3dqQXRac2E0?=
 =?utf-8?B?Y3o5VElSQzFqaUc1SVg0dlFLRnJsbldLeStza1ZZSnZ2WFk3RnVPUGxtQjRr?=
 =?utf-8?B?MmpNaktzKzM1clBxMEdxWGZrczN5N3haMzMzOTUzaG9TMXZCMXhOcDFIRGU5?=
 =?utf-8?B?YkhVUHY3bWYvZUhwTW1qeTc5bVVxSGNEOXN1eGpTL2hsanJ2RzlPTDBmNFVr?=
 =?utf-8?B?SUt6RGNsWHRlUlp2ZFAvQVY0aVBlWTBmRktXbmxZVjVjVGlBUk1iS1I3Y0Z3?=
 =?utf-8?B?ZFArVDV1RjZLc1BvalQ4d3piMFVuemw0bDRmaitWTGI3UVY0L09hWXRlYXhx?=
 =?utf-8?B?eWkvWFYzaDBIVE1LL1VqR3pleDI3OHdFMm1OT21iL21ZcVdIWm9zdCtQU0Jq?=
 =?utf-8?B?Wk55TkphalhycU9xWmxWWXlHR2dWV0pEVktPWHVDK0VGODRGZHZCWE1lNTZH?=
 =?utf-8?B?NGN2RXNEd2ZidnZEVWJRQ2NkbkpjT29HdjdsRWVMOER5UHlZeG4vOEhIY1k4?=
 =?utf-8?B?a1ROVi9oVG9IVWZnZEM1UTJNTE9Ea1c3ZW9HdDAvemwvbmc0WGhNbEorTGJR?=
 =?utf-8?B?OGs3cmNOaC8zc0N2aitudWo2NGs1NEtMTnVObm1xcS9TWmpsQ3hxaFdKQzg1?=
 =?utf-8?B?ckxRbzk0VUkxaXhzM0c3M2tOeGRIY3JIS0JLMHhXdXF2VzVITUhXU3dLMTNO?=
 =?utf-8?B?TmlTRWg2SVNmd2RpMVo1QTdFZVNXWFhDZDRpUlpXTmxEY2NKM1lKWjdIZ255?=
 =?utf-8?Q?Eynq1FESJPS2scGSokyWY9RcMbTWPEFbDP7gra2d6PKc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b3f9c5-5aa1-4e1c-791f-08dd938380fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:38:37.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3avkxxpI+sZD7c5z+Oks+Ol7ngZxlddNBRcBs9zOQRvCxbFWZxNe5Ko/vD9f0+dH1nrXYJ9E4NexuJW4j8nBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7133

From: Jan Kiszka <jan.kiszka@siemens.com>

Stable is not guaranteeing to support always the latest kernel. For 3.3,
we are currently committed up to kernel 6.12. Encode this also into the
smoke-test builds.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7e1e8b6415..6b8ddd6861 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -187,11 +187,11 @@ variables:
     paths:
       - .ccache
 
-arm-6.xx-latest:
+arm-6.12-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-6.1-head:
@@ -208,11 +208,11 @@ arm-5.10-head:
     PIPELINE_REV: v5.10.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm64-6.xx-latest:
+arm64-6.12-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
 arm64-6.1-head:
@@ -229,11 +229,11 @@ arm64-5.10-head:
     PIPELINE_REV: v5.10.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
-x86-6.xx-latest:
+x86-6.12-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-6.1-head:
-- 
2.43.0

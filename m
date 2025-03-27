Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D011E505
	for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057481; cv=fail; b=YG52TDb938BDcULeubmX1E7WE3iWCQw1Xo0MmX/qTpAFIQuxBhDBxW0tc2lVEkT1JeAgqT50hVDOqYySigvy1MOcXW2Yuegr3GD2KF+hTpT5xmyK8Fz/tyhdwTq4azVEQAth+jEwjcnjfqM4qTzJH0dYZSvF6K+BNeX4qHhvSFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057481; c=relaxed/simple;
	bh=6i245KZGPVO0HrGdBOs9f4WF2/Z8pd3iaUhs2FYYSLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlriNiXo0afphncy0heM6VGv7/+Y/Iugw+H0XbD60I9dQsrs5O7v7EhMb+GSH/hZ/TQQrDhVLz2yxgEBZB/vmxyjwGlE1vPMGG37rKV5wo87Md2pMdPoWWHbVtvL/N6RA1TpbdRnxnIvVqaRxMznJODR8rqBmVY7R3bBoByYvaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KjVADnWh; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KjVADnWh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoJRtONzeRDH+wevTQ342nPwlyre9hmEUfnXKae5dJQV0FVFtZ1ZiFoN7YlyvGfOcAG7yIvg5M60Tdxru/4zIPnsIsrXtMBInvlxejiNQsSw5hW1L7gsf+OeovidKFE0FPvogxYnA0UhKAH2/bSitGb4GcjQKV7ARJl9o3NSriaKCaVPNAfAs58tTJOqLif8XzoMKHuDg/j8vHsIfGi/gpIo4FRfBQYsN3wW5owcJIEDPhb/JDwnExAx9+7sklYChTScdSrgh0zmY4eRFNp8CA4EtKjfewDOL0t6xVNDTYNdkwPcf/OYI/wEQuSQpi5WzFxce+T0gekQZfLEC0Aw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxehmXyc1q1JVpmUek/Xt6rk1LbZpL0SfdO1UUHa25I=;
 b=c7K+uQvp2rN9sIp4ru6o1925ast+KSHzFya1Zq7DvZseHuGR/k/4UoPfAU1tYqr49ACmJ8ALE6dg22lj7zN5IBktfTR9IfAIE+84gyaqw22ORsjJaPiewlm/O14ZSCvs+a+9aigLLpNbAsEuAmp5ttQubRpZB71XNXCBSHkT6j85puKNw+ogob09r5pVHwj7CvupT0rA2YV8KHT5TnHiuBT0QziKhBUWS+V8a3Cra4DCXWZQVg6i9NAHnS4HAlSupDtws4+XkofII6++61uzY/u4q9tS0eA+zq/IyOAW2+a1JYzgdSTpWZ/PzOrW3KXVeQiqszM2cAgdn9rmCxRYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxehmXyc1q1JVpmUek/Xt6rk1LbZpL0SfdO1UUHa25I=;
 b=KjVADnWhKZ7htZF5i+dYwGZE9o1xxV8Qg5xI6D1IKPls7nZWwANXHGW4Y0c3Wt4ouHKcpV8kBMJkXzdTjUe7ChzkUljeVhaclW/RadFdsvZKudmHlibon73uWKGrUNQDrGCScAeW6x6MUswAAkp/o1gRm532AM46HWAE+NYSKkWSaH6EajWjhqxQAi+Kv4F11Cd+nwEDz3TCewustg+8NHDAjQJv7OwZ59vkxdQBafZVKz2rqPiXuiZAh7nODjBuTbnRQMXOnR7MWpio0PjrOUvPq8XQ2m9mnGnIvj4h2QxQoFaGWbRV43SeVvESt/1dkylL3MUCCgXXT+EwkXbLpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 06:37:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:37:54 +0000
Message-ID: <4f386065-d4df-4818-8157-a4adec856a6a@siemens.com>
Date: Thu, 27 Mar 2025 07:37:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/y2038: replace gettid() function with a
 wrapper of __NR_gettid system call
To: Ethan <aspirestro@yeah.net>, florian.bezdeka@siemens.com, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20250327063439.248120-1-aspirestro@yeah.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250327063439.248120-1-aspirestro@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: bae61cd8-c2cb-4a36-e44e-08dd6cf9e769
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTgyOXVFczF0R2ZjS2plV085Z1FKUDREWTF1OVRJQ0Z2T1gzcnJsSXpWZXhl?=
 =?utf-8?B?K1QzOHhwSDdXRlV4MklvSmRWMFh4aTRJeE1UckwyRTQrRE0yOGxoWVZwakRR?=
 =?utf-8?B?bVFIRjFtZldpK0lKR0pZYXIvQ2pwdmZ1aUdXQyswUXhBYjF6NkR2TmtIa3Mx?=
 =?utf-8?B?OWdDb3pvN0t3KzRMWUdRc2dPbHdxaHhlejRwcjgzM3E5cXZtYTd2UmdUNzdu?=
 =?utf-8?B?RlgvZDFBbjdwRzBWTEYyWVg5UWg3WGFHQmJZNzJ6RDNDbW1iSkhmdVdBbGNE?=
 =?utf-8?B?RmtjbEsrdG9MeFQ0bjRGc01XKzZuMUlqQkIydEl5L3dRaGdxYnZtV0Y4Wmxj?=
 =?utf-8?B?WmVldWZlanlEWlVrOWYxZTZIYnpjbmYyTURoNDhPWE5aTDNQVkg5eEI1K3R2?=
 =?utf-8?B?R1BNWE55RGZNbytMdGE1bGt5a1NrdnlwZlJaWUZNY2VWdi81aks1NVZqVWE5?=
 =?utf-8?B?d3BrRVFFZmRNNTBhTlBSQzBoU2RnYXRLUFplcFgwSzcrTkNCRHl4S3p0TWZp?=
 =?utf-8?B?OVpNUUZSbU9oWEVzWHFTQzBWK1pRUVZ2clJpWFp1R0h0RDZycnFoZFNublNx?=
 =?utf-8?B?Mko1WmVhc09lYXRPZERwVHFxRFdIelFUSDRJcnlLYXp5OXFkc0E3Rm9wVDBJ?=
 =?utf-8?B?VDlDMnhydGZWK1ZkT1ZqODJkOEN2bFkxKzYyMzlYbGdnYy9TeU5aRWhRMElT?=
 =?utf-8?B?OHY0Zk1hNWtPajZySGNsakxycnRLOE1kUWdjbVRPalVnU2RaM05HckZNdStK?=
 =?utf-8?B?bEsxdnNSeUNveWFDMFMxOXZtQ3IyNzhMbTZVZGQrQVZ0d3pmN2l1aXdHellK?=
 =?utf-8?B?MGk2OFRuYXp1QXQwbGlIaWRCTmthMnhwYU5IUVA4dXBmbWlnQzdkeHpyenpR?=
 =?utf-8?B?RDZLZlZrS3Z6dENJMTl0Mk8yempSVndaZzlPT1A0WTJtK1dlYy9TY1RxZlpk?=
 =?utf-8?B?a0puS2tvREl6QUNNZE9Md1NFbnQwK2ozNUVNQkVPVzlrbDBNa1pmV1ZBV1Fz?=
 =?utf-8?B?b1N2TmY1a2VQU2VTQzNMRFdpMlc0S0dyUGhVUXV0OWFyRDBFK3BDR0hNdVNL?=
 =?utf-8?B?Y2E5aGNOT1NtRWVIeGs0OWU1d0krR0N2TEJKbjhONXpZZG1VMmtZaFlpY3pE?=
 =?utf-8?B?VWkxMDVPczlxVGtQTnZON1V4V2ErSzZ3NDU0SmlyclZUcTMrTjB4OWNTYnJ5?=
 =?utf-8?B?UW1XbktpK21PNEtwT2FoUFdtbGN1R3k4M0pEYWtWWjV0eU82ZE9STDk5RlFn?=
 =?utf-8?B?d05NU2dWTCtFZUt2NGJUelY3U0pYb2lEQ2U0eXFxSjY5dGFhM3dreEVuYURT?=
 =?utf-8?B?MGdpZ1pBeE1FUWNrV09hNzRBeWc4cWkzUGljWEhIdStnOUkzWXZyVDI0OVJO?=
 =?utf-8?B?K3ZOYk5IcW5BV1J6RFFwTndSaStzTmhaYmVrSVhXSlRpaktUeTJxSXFVQlpL?=
 =?utf-8?B?QlZ4L1hJQmViNmxrYUh5OXNSSXZCRlhVajhhMjlmblZKcUlUdTdNQkFxbXRu?=
 =?utf-8?B?ZXlhUW93WjRMLzRPclJha2pzaHdHbWlwUWdrSHdreTJEOVJTV29YYUZKWFpy?=
 =?utf-8?B?RnY4cjFWYlI2MGZPSzlXUlNVaitOVEM5QlU3T0VkN21RQVE2SDNzdTgrRnRI?=
 =?utf-8?B?NkJOUVQ2Y05kaDduaGk5cFA4RjVXaVQrVjhQaHArTG5kWFdPaGQ2MlJ0Mjc0?=
 =?utf-8?B?TytUam53dGdkUCtHM2NLWmRWeUZmQmg0U0NkdWU2eGF2aFQ0eDJ6ZFBFc0o3?=
 =?utf-8?B?Ym9RQXlPVWpqeVRQS1YyN1ZqM2FsY1p0REdXT0ZwVUpyTDZrUTRGWjU4K1ZH?=
 =?utf-8?B?amdjMXgvRlJKNW1PWDdBcFFUTi80NkhpdXkxSktMckMvR1lONm9rV2QrQk9i?=
 =?utf-8?Q?kYsxeAKucam+4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0hBb1I3R2liM21LNXFtbld5bDR2YWdpcHNaVGVhZWNkNmFodkZDRVNkRWxI?=
 =?utf-8?B?Skc2blM1TUFhNDA5TFBmSldhMnlyMytCcHQ1dnBLVTRXak9nTWE2WlF5U0xk?=
 =?utf-8?B?SXBkVllhN0ZVSkdWSG9adWxnQlFiZXJ0eDhiMktxUS82VENGYnE3RU9sMkdU?=
 =?utf-8?B?SWFxYnRyY2ZzV2lIRjY4eGd4aVpPOE9jNDlOL01WUXJ5TDdPVUh0Zm1FNWsv?=
 =?utf-8?B?UHIwOXNiSkhnUnRiL3Z5bU9CQkRHLzZ6TzRQQjFBMFdpbHVQT1Q3bVR5b3ZH?=
 =?utf-8?B?SXllaThZS3NTc1JQMWtUbW9YWU1wcGovOUg0ZkczQTV0YlpaU2RDeW5meGd1?=
 =?utf-8?B?YWZWbkVyUHlsQkZ1eXc1bEFZRENOcjN3ZTIxbVZIZFJmT09qTG5KcFJOR3li?=
 =?utf-8?B?Mi91NTJiNTZBM3NlTG5jeHVzZUNYMjl6dEhaNUlhR2cvRTlmblJySk0wNHd6?=
 =?utf-8?B?a2hRWWp1RzdPcmg4T3lzckh6STYyMnhBUEYyK1dMMURudk1kdTdJcmJwZklQ?=
 =?utf-8?B?UUpHSm5lTHAvZkNiZzFzWkhXSk15NGh3aFpjU09Db3RsZ1RCeGFJYk1ZRTZW?=
 =?utf-8?B?WHRXU29mdWw5S3hNT2pLQk83clhzSGppODB5VlpiTkw2RWUxdnVaZWhHOFRo?=
 =?utf-8?B?TW1aWWxCSW5KQjM1MjA0YmY4emFUVStUUXJPYkJTaG1PenIrbDBRYmpEaG91?=
 =?utf-8?B?d2ptbjZLMGQ4bkIyZTd5eXBVbUdKMHNITyt5bUFSd2h4U25WQjM0cFcwbXht?=
 =?utf-8?B?Tmorc0ZJbXlxUXhabHZhM1NjMmJQeFoyWlc4dFRnNHdQZmlyN3pGd1hWTHRq?=
 =?utf-8?B?UzgyRkVwZGU2Qml4UEdZQXRsZDI2aHBNalpIOFZTUUdjWUM4VFZHNEY0cDNH?=
 =?utf-8?B?cE1Ud0l0RWZqYkphSm1FNUVMN0d4UmpWVmkxQUVFc0RWSW9CM0VFSzVEV1Vt?=
 =?utf-8?B?eGZrTHYvR2d4Mk9WZjdzc3lzSktwazFUQ251QmFnZGEyclkyUDBUYWlFRlNX?=
 =?utf-8?B?R2ZXWDJObnFQQmVDYjE0YXR4eWhXYVg1ZWRMVVVrLy8zVHNJZ1haZlJSYUxC?=
 =?utf-8?B?bFQ5TlRVRVVQT3YvWWQ4dGVOZFc0dmQ5czRTSHAyQ0FBU3VXQzdTZlIzbnhn?=
 =?utf-8?B?UGg1YWd3YjkvN0dJb1JiUW9uK1FES25tZHpRbTZldENLNnhPd1lvTzhEVjBl?=
 =?utf-8?B?U2JHQXFJeHJYZ3JhblJSVFNlK3dTRzFZMENLM0FGOE83czg3S3NDK1BOZ3Uw?=
 =?utf-8?B?S3I3aUpCR0Z3UDB1cDUzbm5EN1luanNDa3duUVhmSXlYUUZQSE1QRy9vMndV?=
 =?utf-8?B?SEdGaWFQZkJCb2xnZ3hYcEMvUzBTTWd6VHB0eTUwL0Mwa2RQaEVpMVFkM1pU?=
 =?utf-8?B?Q0VlVnVFSmZKcHpRZ3Z3VWVxNVFPYjZRZU4waFhSQ2hRbFVCVG50a05lTlVl?=
 =?utf-8?B?N3YrdU54UjlOcmI0b2VzcmRMSlBRSldPdmhYWUZoK01ybXVOQkk0QTJ4V1hv?=
 =?utf-8?B?ZUd3TGlWOFIvbnJKZXIyNllyeTNtajNlOFozQUliSmg5TlBqOUlGWnFGcDV4?=
 =?utf-8?B?emI3TnIwMFp1TStiSldzMnlod1NKbzZFd0orL2lEMzNST2piVFg4ZGc2QUFv?=
 =?utf-8?B?R21wMjNDcGxUWWJ0K25mME1oS2s5eE52UUIxOVpOVUNoOG5xZjNtQ2pZb0NS?=
 =?utf-8?B?azA2QVAxdW1ZSEJWRXdBMHN6LzZLSXQySzFNck5zY1BCTGV1dGF2ckRaRGtY?=
 =?utf-8?B?OFRNYlhTSC9aWURSYkV3bkdaNEtaK0ZoVE1tN1RJMVRjajE0WnNlQnZKOHBQ?=
 =?utf-8?B?WktLZ3U3ZHErclR1MHRPZ0Z4S0hKREtMV0hoU3JrS1dTdnhmV3FFNms3ek9L?=
 =?utf-8?B?YkZSSVM1bTNWbk5zTHZ4bXg4aDNLMFdTWkpGQmZlMy9ieUhmV251d1dUa0Zo?=
 =?utf-8?B?YzhIZHAveWg0cjFsT0dsSmFIeGt1NEllS0x0S1dMeHltVTlXbDF5R0g3ZHda?=
 =?utf-8?B?OEZEdjJFQzhOcW9KdEdjMHNoVnIxR04rYzE4SjYvK0xJQ0tpOFpSN0ZUMHJP?=
 =?utf-8?B?cHVmcGlScSszdVUvc1FFL2NrWU9PTWxwSHcwdUcydWxERno4VFduekhGMEcz?=
 =?utf-8?B?ODBBTVlKUWJIeXFodTBtWW1nZXhUamVmaC9meTU2WDVqd2hYazFIbC9ab2U0?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae61cd8-c2cb-4a36-e44e-08dd6cf9e769
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 06:37:54.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3qNZ0bKO7mbvIqCFGP+1XcKAUZiDBgKKu5FIay4BYsVngMZLvUv4FTHGTNxrJDgZBs7Ny++5cbXWS8dIqZSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8839

On 27.03.25 07:34, Ethan wrote:
> It fails to build testsuite/smokey/y2038 because there is no gettid() function
> in earlier glibc than 2.30. The commit that added gettid() function to glibc
> can be found at [1].
> 
> The following build failure is detected when using glibc 2.27 on Ubuntu
> 18.04.6 LTS (Bionic Beaver):
> 
> syscall-tests.c: In function ‘test_sc_cobalt_timer_settime64’:
> syscall-tests.c:1211:31: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>   sev.sigev_notify_thread_id = gettid();
>                                ^~~~~~
>                                getgid
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92
> 
> Signed-off-by: Ethan <aspirestro@yeah.net>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 29e9c66c0..717957829 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -12,6 +12,7 @@
>  #include <smokey/smokey.h>
>  #include <sys/timerfd.h>
>  #include <sys/utsname.h>
> +#include <sys/syscall.h> /* For SYS_gettid definitions */

I guess you mean __NR_gettid.

>  #include <mqueue.h>
>  #include <rtdm/ipc.h>
>  
> @@ -1208,7 +1209,7 @@ static int test_sc_cobalt_timer_settime64(void)
>  
>  	sev.sigev_signo = sig;
>  	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
> -	sev.sigev_notify_thread_id = gettid();
> +	sev.sigev_notify_thread_id = syscall(__NR_gettid);
>  
>  	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
>  	if (ret)
> @@ -1271,7 +1272,7 @@ static int test_sc_cobalt_timer_gettime64(void)
>  
>  	sev.sigev_signo = sig;
>  	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
> -	sev.sigev_notify_thread_id = gettid();
> +	sev.sigev_notify_thread_id = syscall(__NR_gettid);
>  
>  	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
>  	if (ret)

Makes sense to me otherwise.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

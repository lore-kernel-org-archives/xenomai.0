Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09309BA4B
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196790; cv=fail; b=rQ+y8VVmrsiRoqjv08GOD1aJEoElNr8ej2nMMQbFyAjHMNNn1gshYr2oXwtzsTboE8725M4h1DZjFH/Y8CqIoo3RMZEaNdg8b1BymDNyrKo5/P5RrbN+X5lC4PF1uCfGM1rRuyWqiOnjkP1iWPmsHCeXp5urLJbKZJiopiHdji0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196790; c=relaxed/simple;
	bh=13h2tz2IARHCaT+b9FkXC10RcoQc9VyWwhWNSQ9BUdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AiOz/HuZZOkQS3j2KSJ2k72Qhaxd4a5JE2xuNGtzA6t7nHFD0VzsJpD0YnB7Oe0MwHWemu8Q7Beh+dDTwAKinhTdXBrpbLW2Ruf4+GDtHrMaONRu7afqvNZuCFXStMTqcCsf77O02Fq4efOKM8rbjxcFJoopFvBv79xvtH0xKTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=swaYRCn+; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="swaYRCn+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrAhxmGLAKlumr+3O3P/6BRay/SWYp1p+KwPZDjVoALBJPSpbK2fxGEHR6IbgX1eP+pzNueNyJ2DNhGacbbP+l3Bj8BjGgj/cYk2WQbj3LWIOhHMehQGDQR+1rbtnW19q0Zz1yGpWJ2Xn468rAdazZETFR86Tzqug64iYPlR71SUyCsSrj4jRuTJ5LkmRFwq4UmwUgdAOZphSRx3kfGPh4IXWRFN8a2zvPqUwiThXFHZLTadSzBX2fapXqOuUgk4vZsFG7bwLjTO4m1HwvQMO4sIveSFZKlIVcGCP3WWvgYa6LiYL1ty6X24jYOEr6s/h+jbA5EvUkYrgpcp0/9WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWgvuAOqCtU0B9coOE2wPqC34uKj349E6IsA4ezDIek=;
 b=sonuV64H1CM00J3AxT9COKfBvmE08TzeU1GJyyIRR3951vsyeRKc2fv+xoHZHKH2ZLjvVPZFFXd6OzFA2wU9R/6pCAX6ekAR6eA0WCVUStT6dBlHd/s2OWz41Pk2b6AM2Prlkqr5hpKXlYbuE2U50Xi1PGzOLeTsRBtHomhmO4IVPv9vE84E8y0OJ3SCvyuNboKRQG7ycjDujB1PpBEWUAGPCm+skFEidU62GOct+/dRAJH14jSAdzt3//9+9pxOqUohYD0zonC7Lw2s/ZviFJoKjqbC+LDUdTrMMUKA5H/qinjxv+LOyqypbE7+VfEGBdkK0NF32GC7vcQx5zYI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWgvuAOqCtU0B9coOE2wPqC34uKj349E6IsA4ezDIek=;
 b=swaYRCn+zackbaiqqOkLXOPw0t4TA5zKRjil1lDACetoPu+e4LkknGV404jJvKLtIqtiNaziS7ia9soDg/eETOCi62oVVKwPCVMYZmCCMUNxF0YcJ5Wg522SSw6cu1zhORq0bnpN6rPjjvuJtBNtkK39AN9NcZN4gQdkkPrpLJqaaEe32LFL4sSYHz1aMSO8UoiEDz7cRdApdY8cGSHDyQBB5vEKHaQmkaez6cWVAPh/i0IMLy1ZDzOgGJ8PTSHWI7yvkaNY76HmujlYRXMgFA2O+czSp+OQSE+uK6IbaG0I+Ndq4/E9UnEzG0q4L4qyV/bcaryfASpdYxYPhOyzNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 06:13:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 06:13:03 +0000
Message-ID: <7440756b-0479-4d03-9d84-4e77d1550513@siemens.com>
Date: Wed, 17 Jul 2024 08:13:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ci: let the lava job fail if xeno-test fails
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
 <20240716183326.1432379-6-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240716183326.1432379-6-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3739:EE_
X-MS-Office365-Filtering-Correlation-Id: ef974b28-4940-40e4-3b7c-08dca6278409
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2RUR3ZOSVk4Qi9jaG9XVUNvZVZLZjNidXNrdFZVNGJUTWZxVDRsbEs1NlJq?=
 =?utf-8?B?ZUJReEozYVBGVXJnS2prbG5IWFk3Wko2Z2c0QTFnTHZVNWpsZklXN2R0ZnNR?=
 =?utf-8?B?a2pFYkg4MlJ2UHpDcWtnZnBhclB0MWZQNW9NYk50a2taWk1CejZ4U3JYSytF?=
 =?utf-8?B?VFN1NG1NU29XSkJjRTRSMGcxc0pIcDRqODlIVWhxYlFJSVRXQlVhN1EyYkZj?=
 =?utf-8?B?RjhscFNJWGlCRXZrQy9CUTBIL2VhRDVWZkdNWC8wdkUwOFYyNkwxd01iMXQw?=
 =?utf-8?B?dXNMSWQvM0pwUHJWQmw5U084YlVDUEVKdWRUdWxnSDFjRmVMcm95SVpuN0Fh?=
 =?utf-8?B?VmM4bU1zeVZxNVl3YUg5WXV5bzM2TkEvWm1iajBDNllubWVwWStPcmNERmkw?=
 =?utf-8?B?ckV2eTcwdW1zY05KRElhMk9KNHBIa0JEelhtMzhndzBpUHFSYWJ1Z3Nxbms4?=
 =?utf-8?B?ZjNldFZoZTlhR0M2ZTdIdFBQbmMxWmN6Ylg0eDE1VnRjY3c3SGVqQ2o1ekE5?=
 =?utf-8?B?SFhzaU1HcTNGbDZGd3RwTFpETWJKQXp1emc1SHZjeG82ZEV1MkNhSnI4QlRM?=
 =?utf-8?B?YWRieEVrV2FicVlEZ084WUNCb1pvVFovU0s0U1ZEdGxLLzBoaHBRak1QK2pr?=
 =?utf-8?B?dnpjVVl5ODZvVkxwd0prUHg2L3QrclI0U2JDL0dpWHJMN0drU1BMU2pMN1pI?=
 =?utf-8?B?TWdGM2lmSWdVeWtCNEU3RS9zZ3FTOTF1b2ViRFhxYm55aS9ES1MrbWFsMkVX?=
 =?utf-8?B?K0E5dGNYbTlFbTZkbFhqSTF0TEtXUDEvWkkvOGZ5QnFqdTZoeG9JVHcxMDhC?=
 =?utf-8?B?RFE0djBza3pNdFJOU1owQUJtUDJ3M0U5ZVIwcnd3ckZUQm9KUUpEemh4VEhl?=
 =?utf-8?B?c2VWbUYxRm9RcXRONDZOWmF2em9EWGo4TDVMMVJieW80RUdiRlFmQ1ZZR2w2?=
 =?utf-8?B?Ry9NNE9nRVVQVVA5U0ZqWk1VUjBjT1VRTTVXQ1ArUnhDNDlpclFaeWJqN2Z0?=
 =?utf-8?B?U2R4RVQra1VDMmRDMmUwN3lDWHBJY3NHY0wwYmNuU2RJUkZBa0gyb09tQWcw?=
 =?utf-8?B?ZzhWSWtFeWRVUThzTVdWbllvaC81L210OWJnODNzU3QvUVViSEdNamwyRFdL?=
 =?utf-8?B?dzVkVTFxdHVQQ3FIdk1FZVlvTG9wNVBnQjhkNmltSEMzSmo4UkIxbXdjTnZI?=
 =?utf-8?B?QXA0djJZZUs5cTZXenlTQmh2R3lRUVFWa3Q0U3VraXNRUzUwQnFxRHdpeXFt?=
 =?utf-8?B?d3g2VzRTd2NHbUNhaU1Nbk10cFowcGxseGlxakY4SWFkZGl5MjV1eWIxSGo4?=
 =?utf-8?B?MXJLWmdkZzNJZVU4VUh6M0pKa0MycHAwZUNCUFpsa0xxRUVlNTdFZzQvWThQ?=
 =?utf-8?B?c1RvN0xWbGl5T2RoaVJ5TllaTlZ6ZGw2S0swOFVZMDBEUEhvcFo5Skd0NW5I?=
 =?utf-8?B?UUZZWkU0K1pPL05jM1lLM1ZKeWZXdFE5bjB3MHRpZFFyNnlsQ1dUMDJkSGxG?=
 =?utf-8?B?SlVxWXdSYXZCK0I1MGZKQ0ZQa1V1OUVaRVljK0VLaHNHRzkySVN0dlZFeDJz?=
 =?utf-8?B?dldkUjRPZ1ptUkRyTU1xUFpqdjFCd1Rrb2xGY2tIVWlyYU51ZVRobmdZSzVY?=
 =?utf-8?B?Zm44WnhkdlFUR0NDV29LSjdNTUkxZkJQVDV3TTdFbi9wQUxjSHNkdTR4dTQ0?=
 =?utf-8?B?M3pWT2RRcVpVYWtGVWxCazBranJCeUNYd05WRFp4ay9FdTJCNTdFY2QxTEto?=
 =?utf-8?B?MmpkcVp2bGdjWEdCcjBEL2thRnRVTHY2V1FqSDlBYlJrVVpQS0ZsSWZ6TEpO?=
 =?utf-8?B?M3JERkxkaHk1djJTMFh6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdMVy84cWI1RWdib1FqNjBiaGVMRkp4d2RwbjNHSGtQdlh0QmFpZGo1WDQz?=
 =?utf-8?B?U0R4Y291bStFSUJXK2FJZUdBdFd5b3lEd0JESnRPbU0xNjVyb3RhSmlETm9O?=
 =?utf-8?B?N2tXcFNNVFBldGM5MnlCMkxZZEtMM1JXTGZFU09VODVXa1ZmVVlaVTNPdm1s?=
 =?utf-8?B?Tjl6S0UzRzI2WW1PczIyMHR5RlMyZmFmK3VGSU5lVFlMR2RSVHgvY1hLdTFE?=
 =?utf-8?B?di9DaUFveHN5OXgrQjdhTzh4Q3JvZVVYKzdpaktKdkRVSUVra2RYT0tuekhU?=
 =?utf-8?B?R29YbDdSRkwrOUpVQjcvUHV0YnlCVlgzNFZzZnZwN3VhYXUzMXc1T1RkS1Vy?=
 =?utf-8?B?UTYzVGZaRnVBRXRqRnJaWmNva29QRGxPNEw3cmR6dVAzOHU2TmZvY0VLK0Jt?=
 =?utf-8?B?eHJ3bm5pK1VmcFpPbURmZzlraXEvNWZaNnloY1p3Q2JId1FBeHg5aTRpajZV?=
 =?utf-8?B?cDIzUlBxN2tVQituWkJheU8veUQzR0o2MHhIWitsRmo2bXJ5bGRJQTZ4ZmdX?=
 =?utf-8?B?SkhaRXkwQU9YMkMzZEV2WHRSdFRidjV2VjJGdXp6UFFoandXNWdidEZuOUs2?=
 =?utf-8?B?MjZFWnljTXByWGo4NVFEMWlxekU5eCt6cjdFNDM2QWFxRnNSaGorK1hJK3Zp?=
 =?utf-8?B?WE1hellKeFlnV0dkM051OUtTeXRMWkJ2MUJ0TEJYaGFZN1pkanl2NDBMakFr?=
 =?utf-8?B?aVdUSDBFMjB0dVQwSnQrNVpBSnlaOWVGYUp4a0xqUEhLQTUyVHE2ZDlVWXhE?=
 =?utf-8?B?ZnlLUFZ1WmgrN0FlSzBBdmdlaFRKd2xPT3NQTzc4SERUSEx3VERQUjdMZi9k?=
 =?utf-8?B?NXZRUEdoMnNwZzJKaU5XQm1scGYwZU8wbVA3KzBxK1JNRi9BTFBlWStKWGo2?=
 =?utf-8?B?R1pNcDdyczVMK2dqbGdjcUI3cUZsR3lVSVFjb01jZ1NrOUwzNHl2QmxMUlRF?=
 =?utf-8?B?bjlKV3dhT3hYaHV2WE82K3RDcUMwWjdPNnZIMzIrUTN6MGNreFlaSUp3Rys2?=
 =?utf-8?B?ZlJiL3ZiNnVaWldIUHhyUHBybkc1a1Jydm5iV0pBd0NqRlFpMmxIWnZseGlZ?=
 =?utf-8?B?MDhOb2NUSlpCazMxOHpUbjAwdlN4OGt4eDFucHpJQVpPYVlMUEt1UUFBTnNE?=
 =?utf-8?B?clc0cjdTMWJqT09lb1QwbHJtUTg1TUh2L291Z0dMaXd3WXoxVElLb0Y1YnhQ?=
 =?utf-8?B?MXhtRjJsb3c4aE1YYlJMUC9PcDY3NjlQUk42YlJuNHd3djZXQ1VGQi9KbC94?=
 =?utf-8?B?bHNFMjljUWRpaHM1Z0JFOWVLSzhQVTNtMXhEYUlSZm0zZnpiMldUN21xMTly?=
 =?utf-8?B?VDNEZmhYOHlBSFdVblhCbE51Z0RvWXk3V1lCb3RBaXRxTlhWQkJoZ1lHS3I4?=
 =?utf-8?B?dytwRUtLUWhMN0tjcWVpMXZ3dmd6a3RHSnlFYTludnlSdm0vNHMxSnJmbXc5?=
 =?utf-8?B?NWxjaE9RVzdZejZpY1YxT3FGZ3FYSDF3UmRVYU4vUWdvSzYyK09VV0hKaFdr?=
 =?utf-8?B?cFdVK0VtRENEblZuTmF4SWcxc0x2WTh4ZFk2em1JWWxTM2ozWHd1WEtscDhv?=
 =?utf-8?B?V3FwSzBRQ2J2OVhvbGFXMjYwNTdWazVUVHFZTUFQUlkyOERVbGQvVWd3R3JM?=
 =?utf-8?B?Q250REIvbGVrTm8wd0I4ZGdqcHFrVmEyTys4ZnRSa2xQOGNxQzlJSWJqZFlj?=
 =?utf-8?B?TmZVNXJFYVlFSjUzUGJQNjZ3UDdQbVE0Z1ZVSU9COXk5NlBzQ082SjlIcTVY?=
 =?utf-8?B?UFM5UTY0SGt6eWNaNUdCd2xFY2JVNkw0RXFrUnlxL3JzUUlEcyt6cHMxTzBS?=
 =?utf-8?B?bnV5ZFo3dmF1djdZbDdQVVltWnVHMEFSeWtCVkRuOGtuRXlxazREbnZROHJo?=
 =?utf-8?B?Vy8xc2xUSTQ0MEQydVVmZStmMHZUbUZzYXhxSUdEcGpHVm0zcSt2K3dvSG52?=
 =?utf-8?B?a01XVVh1Qm5QNnNlZXl5dGdXTzFkdXFCWERHbFN2bVYwaDNLTCtQaWRaZXov?=
 =?utf-8?B?c0FrWlhWemJGdVNWREVlY0s0K3ZvN0RiQXJ6TUs1VlJaRkQ4dzNUaldzNk1j?=
 =?utf-8?B?WEdEbVJxMTdpMVpNYXJrNnBIbDYyZjF2ZUcrVHBlNmxVVzhUbndvMWJlSEhw?=
 =?utf-8?B?SUpPR3liYWMvVHpaZFR5ZWlBWjVhUW1xRDlFWHAvQytaV0lTenRtMG1KbzlJ?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef974b28-4940-40e4-3b7c-08dca6278409
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:13:02.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3gwHhgh7Xaeu7uE2bZDAwIgD5l4KZ30g7w7dZjY2+Fkrm5lkh5ekBabh3slIzsdlefmPwdnvvwa8u8T2k1uHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3739

On 16.07.24 20:33, Tobias Schaffner wrote:
> Use lava-test-raise to let the complete lava job fail if xeno-test
> fails.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  tests/jobs/xenomai-beagle-bone-black.yml | 2 +-
>  tests/jobs/xenomai-hikey.yml             | 2 +-
>  tests/jobs/xenomai-qemu-amd64.yml        | 2 +-
>  tests/jobs/xenomai-qemu-arm64.yml        | 2 +-
>  tests/jobs/xenomai-qemu-armhf.yml        | 2 +-
>  tests/jobs/xenomai-rpi4.yml              | 2 +-
>  tests/jobs/xenomai-x86-64-efi.yml        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
> index f7966ea..8e47dd6 100644
> --- a/tests/jobs/xenomai-beagle-bone-black.yml
> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> @@ -63,7 +63,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
> index 67c35b9..aaf8949 100644
> --- a/tests/jobs/xenomai-hikey.yml
> +++ b/tests/jobs/xenomai-hikey.yml
> @@ -62,7 +62,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
> index c20fbf1..cc09205 100644
> --- a/tests/jobs/xenomai-qemu-amd64.yml
> +++ b/tests/jobs/xenomai-qemu-amd64.yml
> @@ -79,7 +79,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
> index 8c15026..2e9d1d4 100644
> --- a/tests/jobs/xenomai-qemu-arm64.yml
> +++ b/tests/jobs/xenomai-qemu-arm64.yml
> @@ -85,7 +85,7 @@ actions:
>              - quirin.gylstorff@siemens.org
>          run:
>            steps:
> -            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
> index 9560a85..0bfed71 100644
> --- a/tests/jobs/xenomai-qemu-armhf.yml
> +++ b/tests/jobs/xenomai-qemu-armhf.yml
> @@ -79,7 +79,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
> index e8b9a7e..50ff9ee 100644
> --- a/tests/jobs/xenomai-rpi4.yml
> +++ b/tests/jobs/xenomai-rpi4.yml
> @@ -62,7 +62,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
> index 4aafccb..4f1a7d8 100644
> --- a/tests/jobs/xenomai-x86-64-efi.yml
> +++ b/tests/jobs/xenomai-x86-64-efi.yml
> @@ -63,7 +63,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite

This should come first as it "Fixes:" the regression/limitation of 22db8c10.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


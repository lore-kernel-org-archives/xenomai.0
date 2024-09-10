Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAD18C347
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967660; cv=fail; b=NjFGsy/5yTA8YKDXPuSz5Xxnr/Vb0GKnV1quGTMfy6XkvNqCJP3D/32lYoFpymzHD54QUu4lmOmHGEVpyc7puDK9Xe5AOdVehHwwoZw54kfzZZkFznOuN/xuyQjEw9OBeilujiRspYzcEFcNx1gNxerTqNhZ7E3msx7isx1JHE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967660; c=relaxed/simple;
	bh=qsYDuag/TLEAgT2J/QWDyhK1FTHHKmZR47b6JUBniLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVCMVtH0J6BrdvWEnpDIWagKHaCuxUoULTSdLn2+JBRpwygedATmmTrqEVoQgsjs9z78Z4pSRL4oagBV7+8ua6WCTr8V9gXBe3K4WUABlb2fky6rpobjZV0vmr5uNApXWEWkWu1Ha0FOpK0igj9wuP5ufrOwfevUfw02Sn0ZKCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NoS2TYAq; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NoS2TYAq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlOLwzX4UlpypUJ3Cf8nEgKebieZbPIgLOZX4YN4wzzvax4vGwKrsO4XCOXMkYY738Bup1J8DMxMvcz2a/FqLG12SEZMIuxJmweFMEiD54ibkxDTqr+eEjT4ZMsIzt/14lno0bwy3EAqr0hRs7ncqkQMkMOKahDpYfGrkCli4WYpJoP7tfXkIFbgAGQsSYP9fy+ezy3IpUFAqLQXVgcM1oWHddXzQNducxiBM01HNeoLyFkMaV0sqKpoqlGSNFQn1Lfj0MCsDe7vEXttwcplkeHozdKpCHk9OMczDjmtbDJW40vdbE6tBEW5DLPrVN7sUt654HGMqYecehyXt/oixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERsPa1/6YXfmSVtuC6TmYLZ28MqygrlRf5T6UVfauQY=;
 b=QUyNFvkGAVQL/reUgtwW/5sIsg7nZbz2FEuZRjjVXldVN3tUwivd0pAu+Bkssky+/1+Vl+dGiLoI7kiA0fZX2WrwesnLn5A4njF7OCgNKlczzrslnN3+APiFdWicfnSBOmv/PJW1v8/9uVJEeKD/Q6ItGjceOKxah93scSpMLGK7WfnHanggUiaZHNiM1db/K+0FuxciavIEKemPwSWOw13Vwh21VwymN2bbpDyI7EL1rO7GCHEdmigPa+K9affO6zsn0jFD3YizZJuX4rdM204g7Vg/dmz945R9jCNxjqSlziPOdNkrSxdVtlwXkPPUlvdCSFYknBFmjs1cG1XgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERsPa1/6YXfmSVtuC6TmYLZ28MqygrlRf5T6UVfauQY=;
 b=NoS2TYAqcLn6vYNoZkm/LbPCyU5ONosnaxaIgTMjIbGZPfpANdWCYUw1B7hqazdBtIalSJGDe/UJs/o9v3THT4+ji1w5gVDQwDLyrL6KoTX0kRalSrg7TgDVaItkNcjFUT1rwQ7Q1TRC2hKEqJneDJEFutAfURJMwtY5JkAIG9vNuFMH1LX7IR99WjVSC4zFWreiYmIc73762y63rFEkSqmukPx3liyXOV9A4qnWdyXD/SH6JBsR/5koi7XMd/3JJiSyjhJhTfyu6Ggy9YNMT/eLN5F+GnncPPUT1gyBjHSqAfFzpHer1X6TEah1SC4rDip/uQA2QiKts3AsHaaO2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 11:27:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 11:27:32 +0000
Message-ID: <82a7d428-9166-480e-be11-43ff61371bfc@siemens.com>
Date: Tue, 10 Sep 2024 13:27:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Freezing test with I-PIPE and Dovetail
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
 =?UTF-8?B?6rmA6rec7ZiEKEt5dWh5ZW9uIEtpbSkgLSDshoztg4DthY3svZTrpqzslYQ=?=
 <kyuhyeon.kim@doosan.com>,
 =?UTF-8?B?Tmd1eWVuIFRoYW5oIFR1bmcoVHVuZyBOZ3V5ZW50aGFuaCkg7IaM7YOA7YWN7L2U?=
 =?UTF-8?B?66as7JWE?= <tung3.nguyenthanh@doosan.com>
References: <SL2P216MB2274755998FD757C16569E24E09D2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SL2P216MB2274755998FD757C16569E24E09D2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:610:50::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d82bc9d-6c4e-40d7-51e5-08dcd18b8fb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzEzRXVjUlA3d0cwSjN2cTZ2d2J0VUNZd1psNC9mUURaamtROHhZb3BUMEs0?=
 =?utf-8?B?aGFXSW1veWNMVnBLN3JnSCtxMFhIeDVuSEF2MzRkWlJ4QnIyOStYeHZOU2pz?=
 =?utf-8?B?aEY0ejVtNWgyZGRKNnpGWDEyVDN6dWViL2YwVjhmSXlwZHY1Z2RmVnJvTlYw?=
 =?utf-8?B?aW80RGIxOVd6V0pLSTNacThvZHdmSWhRZEVKc2xScWlZTDBvaVo0T0FvMDNB?=
 =?utf-8?B?cXR6L0hiZWR5aFhzRHlWY0tXVzhzR1M2VDJ4czU3d2FKS0JWaUF6TUs4RHVn?=
 =?utf-8?B?RXlqK0FxUEtKZ2ZXQUdkVHVCODd0d29PVDV4cHlRTUhwU2ZOTmJPUjJaL1dj?=
 =?utf-8?B?NHlqYW5TTWZRQXprbmNMV1RSQXUxY1ZCMDVOUWxFc1hMNEdrSkkwU2tTTW10?=
 =?utf-8?B?Z2pCUHo2UUJOblFYNithczB3ZGlWV3E0L1ZHVW5CZlE3R2JRYXlHOFMyZksv?=
 =?utf-8?B?NUlHUTdML2tmeVVreFhMVTU2N1c5UFkwb2hxYXlyM3pMZEtXSy9Tc0lUb0pZ?=
 =?utf-8?B?OGxmSnFDL1VsYjlWY29YeGRsbXZka2NZSS9aWlpwY2V0R3hVTDYwQnZQZ1Uw?=
 =?utf-8?B?WWJ3RFYrUjUyNTNZTk9DaFFYN1p2a1YxYk5CYUl3bG9aNDFMLzhET1pOZXZM?=
 =?utf-8?B?UUUrNGFVN1VSSzRRM2V0bTR3blJheUxSYmJldXNENjBIVzhxTzltWnI5dk9R?=
 =?utf-8?B?bTBYTy9JN01CUTQzWDBzU2JPWGJWTjMvbFJudnFQZ1pnVVdxb3NLYktGd05o?=
 =?utf-8?B?dktwUU41RUhURGxZR0hZKzFBZ0cwaHQ3eTJVdjQ1dFU4TFRGSkwwcjlPNmE2?=
 =?utf-8?B?YzVLMnQvY3RlRmdabThHeWV6Z0owSi9LbjJLNEJ6eXJJNmFXNmRrdDA2T2sy?=
 =?utf-8?B?NmdTdHFsZlRWM2ZXdld6TWxlYTBXK2lmVGJYMTBlMGxScFRrMWsvZ3pZaWN1?=
 =?utf-8?B?UjFzWER1dkp4V0ZWM0FjZ1AwOWhMVnV0NjZpNE5FNk9PRkxEVXlad1ZuK3FY?=
 =?utf-8?B?M2IxbUtYMkMzTW1NVjFnL2VLcXFNOURTV29sc1djcklRb04xazhhdDdXaW1s?=
 =?utf-8?B?UklZQWVibFJxa2lZOE52OUdwazNwK3FMTDlrOHlQZVVjclFZMk5lT3g4eGJK?=
 =?utf-8?B?NStzOFRJMjhvN3VlMmNQYUdqOEt6NDhFdElFTFBjU3JBY2JUM3R2RFdXM2Zh?=
 =?utf-8?B?OW5KRE1ua0kxUE54OWJ6akZvbmpiV1I3ekRNRFJnYWpOUkNydy9SdllFRnl6?=
 =?utf-8?B?NEtFdzZCVDB5OGthaTVyRkVOSWJXMkdDSFFwdzQ4c2dOaU9YbFo5RzlCcExY?=
 =?utf-8?B?STFKMlpWRndZN0lQY3REWnE2T3NsZEJSR2s1bnoveVhkL29iZEZBS21reHNr?=
 =?utf-8?B?UzZaNGlpZzJwQ21kOU1HTnNKYW4xRGo3aXZxOVdhNlVwS3NVSXl0T1VEcVRG?=
 =?utf-8?B?ZzU2ejlPV1kvUjZtZE54VUZvUVJnRlc1S3FCY3Y5UHFiUXVHN0wzdEJjaFRv?=
 =?utf-8?B?VklZbU1tbWZWeDkrUU1FT1lQdGRWcEVES3ZkVUtLM3czTnZxbS9BWERML25B?=
 =?utf-8?B?bnRsdjJ6K2htM285VDlEbnVCb0lYNk1qKyt2L09LMUU1K0xDUG9YU0h2YVN1?=
 =?utf-8?B?RkFoZFZoNFZMcWJHeUpxMktJbklaKzlDTEU4OTJrVDRydHBycWE4ZnJvLzB4?=
 =?utf-8?B?cXlIaXBmeDlEbE1iQnRvK1VDTjVPWTBIU084VUhTUi9leTVvRnZiZW5GSzhO?=
 =?utf-8?B?aDgwaG42ZmZIRHpMNVdNYlNjSzU1YUg1TWhhTXdBTEhaME9ubzZpQnhTVWpJ?=
 =?utf-8?B?cU5heVJKY3JqRUI1ZWFiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnNuNjZpOVY2eFg3MzZobCtxZ2tMTGh2dnlqd2FtVlNFc1dWRXo4WWN2MVQ3?=
 =?utf-8?B?T1FWUnJDbGVZZnppREJPSXhhTTAybzJLb1hLL2hyRk9ScjlkM0JrZmlNbjNr?=
 =?utf-8?B?RXZEaWZzdE12QjR3M2xaelJmUHJ6YjlPMGdDdzNJblpzNWlyWk9Vci95aUF2?=
 =?utf-8?B?SDZyQVFuMFRiVjNWMVI2WUl0V21XRVp0UjREdytpUktiUTZFK2piTlIwRDhp?=
 =?utf-8?B?RGg5dS9wU0laM2xKRy8wTEd0dkJwT3FGNTA0b0hnM3Y0dlU3cWhtbzI4Mmsr?=
 =?utf-8?B?TTdDeW9aclNpSThUUEZYVjR2c29qdDlsTHdUM3ZJVEpITjg0UU1OTHlIOEFX?=
 =?utf-8?B?Uk1nL01lbE5pMWh5ZEtqUm0yczVTYmxia1gyemRVdkhYdW9Yb2JNSVZKYXJn?=
 =?utf-8?B?MVJSbVBGbGVGdGFnN3BndnFwZWxJTWxiWXRENHlsMjdBUG8zcFRpZ3E2ZlQ0?=
 =?utf-8?B?RFZTcEJHTGNXN2g5STNUZGZ3WWtZeS9vMFAyZFpobUtaOWtXVHBnOC8rV2Rm?=
 =?utf-8?B?MHJjS3RjWjVUeEhKZi9ucnlJRVNZLytxTnEzU2NXanpOTTdYdmZmL2FUeEMw?=
 =?utf-8?B?Q3UrQnJLZEpnUXIzSTZaVFNKK3l3eFVwVnNVQ0c0eTlvYmdreTlKWFhjY3BI?=
 =?utf-8?B?ZEpEdEZYaUNtbmtEU0tnR2p2cnV6UGJoSG13UDl0SjdxcXBvMzZIZEJuVGpH?=
 =?utf-8?B?dUtLTXJzQnV1NXNpSGQ2SlpkL2YzZFhsMS9pNzRjcjlmNXJBMzVVK1NJOTJo?=
 =?utf-8?B?bVA1ek1QMU1GbVBEcnpXQjZ4VlRpbThsdlFuTHF6a3VpcFQ0azZ4M2djemxF?=
 =?utf-8?B?Uzc5ZXY4VXk4Y1g2UXVHUFFSMzZSR0JGTmgzYlZ5ZVJjMUxEZk1YRVZ4MG1u?=
 =?utf-8?B?U1dDbGpuQ3JMaStWaHc2TFFXRDFnWHFwejJFa2Z6Q1NuR1hvNmNHSDRVZlc4?=
 =?utf-8?B?amdUTHZoSE5Ma1VobFZXalVqcWNYclN1NzF2b0d6RFJxbHdpQmQ1KzJaRXhP?=
 =?utf-8?B?OGF1akJzNlR1QUhGWmRiaTAzdnV4cTZkWnlwUjBRU1ovaE1WeGd2TDczeklT?=
 =?utf-8?B?cC8yTTFUR204RWdteEtFa0poOFA5ZFc2eFRKRVV2SUNpRzRGdG9XNHZ2VCt4?=
 =?utf-8?B?d0YrMUhIUTZWNzFlWHlKVjhMZUUxNEdKS2dpSzhLclAxSy80ZEtiWWUwRnZU?=
 =?utf-8?B?ckNjSmlpMDBPcVdkZUo2YzZvOTA2ZGV1NGNCMS9WWjAxZU1LTVpDRldrcnRI?=
 =?utf-8?B?TlJUajIxVzhlOGZlVnB6ZkY2aXNOZTg2VEJ5QStQelZIaDF1dHNwWUpLYzJz?=
 =?utf-8?B?enQ0ZGJNRXRHUmRKbGxub21xSnB6UnRXbU1CdUpYYmFFaVB3a3JEOUtzYXpK?=
 =?utf-8?B?WGJqOWlFbTdpSWJYeWhrMzM0NjY3bCtHNGFkc1BYSThDWlV6ZUVvZUl3SWhR?=
 =?utf-8?B?SU9GRUt3aG03TVZoQ3ZWdkR0bW90Vi9kVVZDK2ZUSENDeUYrdVUrNFBOV0tU?=
 =?utf-8?B?U1pYa09KRnZBRnIzTS9UR0dxYzJVbG92ZzVIRVFMVEVPZlc3M0hjWkRKOEZr?=
 =?utf-8?B?WTVSRTgwNUZLT2QvODdEWmVFWXdDbXh0SnVKMWd0cS9vdUtzRXJuNTlzcjRJ?=
 =?utf-8?B?dm92UW9xb2I2QmMxTk9xL1V2NzFmb0xJaFlXR2VqKy9IamV6b2phdmRKRTd5?=
 =?utf-8?B?bnRJdjZaVGduMFpUZDZoSnV2YjgvL1ovaC9RbDdYdHpMTCtCVk5MNGZXWkt3?=
 =?utf-8?B?dUtIREpMSWlZWENJVnNhNWNjVjNsWlZ1eENjenRvU1VUclgxRWlaWW9IUFdD?=
 =?utf-8?B?bzdRYUhmMndERnU3OFF1QXBBczV5UkhBdW1heXM5TDlSUmx4T21zUkhZa3Bn?=
 =?utf-8?B?aG9DN21taEd6NEFFUUo2L3FCRXdJVHhDeUZEZE9OVlVwM1pMR3RXVlhvSkcv?=
 =?utf-8?B?YTlaWENSaEdqQ2RDc2M4a1JNUE01VTZuRVRjYW44czVqdU5TK2tvRTVPd3Iz?=
 =?utf-8?B?aFEvcWk4Q1hnMEZ0YkFkYnJwNWU2SkRJSHk3RlNyQ1ZhSnJYOTUvemV1OE1H?=
 =?utf-8?B?ajVNSkJMTXRYcDJ2M3l3UGdXQUxmayt5THlUcHFZeVJrOWEvdWcrU0JVRTU4?=
 =?utf-8?B?WmtsMkFDL2lUa2RVKzBRUlM3a3k2TE1HNWJOQ0d6Um54dS92a1RkVlRVQ3l3?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82bc9d-6c4e-40d7-51e5-08dcd18b8fb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:27:32.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TWcFLOqBAXcEQhse3PSurFby+900r7zPKoRvoFUjAWAqYjVZTRsFZmYB7w5O5DyxPGx8S6pSi/oXH+5Nmi0QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6934

Hi Junesoo Im,

On 05.09.24 12:39, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
> Hi Jan,
> 
> I hope you're doing well.
> I'm reaching out to inquire about a freezing issue we've encountered during the rt_tast_start and termination (kill command) of a test program below, which happened in both Ipipe and Dovetail:

Is that test case also causing a failure in one of our xenomai-images
reference images? If not, we will first have to find out the relevant
differences you may have on your side.

> -------------------------------------------------------------------------------
> #include <stdio.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <alchemy/task.h>
> #include <alchemy/timer.h>
> #include <math.h>
> #include <sys/time.h>
> 
> RT_TASK cyclic_timesync, cyclic_ecat;
> 
> #define TASK_NUM 30
> RT_TASK noncyclic_task[TASK_NUM];
> 
> void cyclic_task_proc(void *arg)
> {
>   RT_TASK *curtask;
>   RT_TASK_INFO curtaskinfo;
>   int iret = 0;
>   int ctr = 0;
>   struct timeval tv;
> 
>   FILE *null_file = fopen("/dev/null", "r");
>   if (null_file == NULL) {
>       perror("Error opening /dev/null");
>       return;
>   }
> 
>   curtask = rt_task_self();
>   rt_task_inquire(curtask, &curtaskinfo);
> 
>   //Print the info
>   rt_printf("Starting task %s with period of 1 ms ....\n", curtaskinfo.name);
> 
>   //Make the task periodic with a specified loop period
>   rt_task_set_periodic(NULL, TM_NOW, 1e6); // 1 tick = 1ns , 1e6 tick = 1ms
> 
>   //Start the task loop
>   while(1){
>     fgetc(null_file);

You are aware of the fact that this will kick the task out of realtime?
It's no excuse for the machine locking up, just to make clear if you are
testing what your real application will do and should do.

>     for (int i = 0; i < 1000; ++i)
>         ctr++;
>     rt_task_wait_period(NULL);
>   }
> }
> 
> 
> void noncyclic_task_proc(void *arg)
> {
>   RT_TASK *curtask;
>   RT_TASK_INFO curtaskinfo;
>   int iret = 0;
>   int ctr = 0;
>   struct timeval tv;
> 
>   FILE *null_file = fopen("/dev/null", "r");
>   if (null_file == NULL) {
>       perror("Error opening /dev/null");
>       return;
>   }
> 
>   curtask = rt_task_self();
>   rt_task_inquire(curtask, &curtaskinfo);
> 
>   //Print the info
>   rt_printf("Starting non cyclic task %s \n", curtaskinfo.name);
> 
>   //Start the task loop
>   while(1){
>     fgetc(null_file);
>     for (int i = 0; i < 1000; ++i)
>         ctr++;
>     rt_task_sleep(1000000); // tick
>   }
> }
> 
> int main() {
> 
>   cpu_set_t cpus ;
>   char str[20];
> 
>   srand(time(NULL)); // seed random number generator
>   
>   mlockall(MCL_CURRENT | MCL_FUTURE);
> 
>   // Create cyclic tasks
>   rt_task_create(&cyclic_timesync, "cyclic_timesync", 0, 99, 0);
>   rt_task_create(&cyclic_ecat, "cyclic_ecat", 0, 98, 0);
> 
>   // Get number of CPU cores
>   int num_cores = 4;
> 
>   // Assign random core to timesync task 
>   CPU_ZERO(&cpus);
>   CPU_SET(rand() % num_cores, &cpus);
> 
>   rt_task_set_affinity(&cyclic_timesync, &cpus);
> 
>   // Assign random core to ecat task
>   CPU_ZERO(&cpus);
>   CPU_SET(rand() % num_cores, &cpus);
>   rt_task_set_affinity(&cyclic_ecat, &cpus);
> 
>   RTIME delay = 1E8; //nanosec
>   // Start cyclic tasks
>   rt_task_start(&cyclic_timesync, &cyclic_task_proc, 0);
>   rt_task_sleep(delay);
>   rt_task_start(&cyclic_ecat, &cyclic_task_proc, 0);
>   rt_task_sleep(delay);
> 
>   // Create non-cyclic tasks
>   for(int i = 0; i < TASK_NUM; i++) {
>     sprintf(str, "noncyclic_task%d", i);
>     rt_task_create(&noncyclic_task[i], str, 0, 60+i, 0);
> 
>     // Assign random core
>     CPU_ZERO(&cpus);
>     CPU_SET(rand() % num_cores, &cpus);
>     rt_task_set_affinity(&noncyclic_task[i], &cpus);
> 
>     rt_task_sleep(delay);
>     // Start task
>     rt_task_start(&noncyclic_task[i], &noncyclic_task_proc, 0);
>     //delay
>     rt_task_sleep(delay);
>   }
> 
>   pause();
> 
>   return 0;
> 
> }
> -------------------------------------------------------------------------------
> 
> Freezing kernel log at rt_task_start on Ipipe:
> ```
> [   74.644748] ------------[ cut here ]------------
> [   74.649756] hardened thread cyclic_ecat[1723] running in Linux domain?! (status=0x248042, sig=0, prev=fake_DRCF[1720])
> [   74.649910] [Xenomai] lock 00000000ef845048 already unlocked on CPU #2
> [   74.649910]           last owner = kernel/xenomai/sched.c:1059 (___xnsched_run(), CPU #-2)
> [   74.676940] Call Trace:
> [   74.679544]  xnlock_dbg_release+0x132/0x1a0
> [   74.683984]  signal_wait+0x356/0x850
> [   74.687756]  ? __cobalt_sigwaitinfo+0x20/0x20
> [   74.692386]  ? __ipipe_migrate_head+0xd1/0x1e0
> [   74.697105]  ? __cobalt_sigwaitinfo+0x20/0x20
> [   74.701686]  CoBaLt_sigwaitinfo+0x8a/0xe0
> [   74.705908]  handle_head_syscall+0x1a6/0x530
> [   74.710390]  ipipe_fastcall_hook+0x18/0x30
> [   74.714705]  ipipe_handle_syscall+0x4d/0xb0
> [   74.719142]  do_syscall_64+0x31/0xf0
> [   74.722902]  entry_SYSCALL_64_after_hwframe+0x61/0xd6
> [   74.728214] RIP: 0033:0x7f22d03f0ca0
> [   74.731977] Code: 10 64 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d 74 24 04 e8 2f 8b ff ff ba 3d 00 00 10 4c 89 e6 48 89 ef 89 d0 0f 05 <85> c0 78 2c 41 89 c4 8b 7c 24 04 31 f6 e8 0e 8b ff ff 48 8b 44 24
> [   74.751890] RSP: 002b:00007f22cf7c5bd0 EFLAGS: 00000202 ORIG_RAX: 000000001000003d
> [   74.759847] RAX: ffffffffffffffda RBX: 00007f22cf8d42d0 RCX: 00007f22d03f0ca0
> [   74.767370] RDX: 000000001000003d RSI: 00007f22cf7c5c00 RDI: 00007f22d041e800
> [   74.774883] RBP: 00007f22d041e800 R08: 00007f22cf7c6700 R09: 000000000000007c
> [   74.782380] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f22cf7c5c00
> [   74.789876] R13: 0000000000000000 R14: 00007f22cf7c5e80 R15: 00007ffc585cab88
> [   74.797437] ------------[ cut here ]------------
> [   74.802314] kernel BUG at kernel/xenomai/synch.c:207!
> [   74.807620] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   74.813089] CPU: 2 PID: 1723 Comm: cyclic_ecat Tainted: G        W  O      5.4.255--revision #6
> [   74.822480] Hardware name: Default string Default string/Default string, BIOS 5.0.1.2 01/25/2021
> [   74.832005] I-pipe domain: Linux
> [   74.835516] RIP: 0010:xnsynch_sleep_on+0x2cb/0x370
> [   74.840724] Code: 49 83 cd 02 e9 6c fe ff ff 49 8b 46 28 48 89 78 08 49 89 84 24 10 12 00 00 49 89 8c 24 18 12 00 00 49 89 7e 28 e9 9c fe ff ff <0f> 0b 48 c7 c7 80 03 af 9f e8 a5 12 97 00 0f 0b 48 c7 c7 70 03 af
> [   74.861041] RSP: 0018:ffffa5b3c28f7d20 EFLAGS: 00010046
> [   74.866700] RAX: ffffffffa188cc00 RBX: ffffa5b3c0c62640 RCX: ffff95a8a6400000
> [   74.874428] RDX: 0000000000000046 RSI: 0000000000000000 RDI: ffffa5b3c0c63f60
> [   74.882176] RBP: ffffa5b3c28f7d70 R08: 0000000000000000 R09: ffffffff9f426608
> [   74.889927] R10: 00000046feadfb30 R11: 0000000000000000 R12: 00007f22cf7c5c00
> [   74.897640] R13: 0000000000000000 R14: ffffa5b3c28f7dc8 R15: 0000000000000000
> [   74.905326] FS:  00007f22cf7c6700(0000) GS:ffff95a8a6400000(0000) knlGS:0000000000000000
> [   74.914055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   74.920275] CR2: 00007ffc585e90a0 CR3: 000000025f7ea005 CR4: 00000000003606e0
> [   74.927998] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   74.935693] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   74.943383] Call Trace:
> [   74.946035]  ? show_regs.cold+0x1a/0x1f
> [   74.950221]  ? __die.cold+0x5c/0xa6
> [   74.954012]  ? die+0x30/0x50
> [   74.957111]  ? do_trap+0x85/0xe0
> [   74.960591]  ? do_error_trap+0x7d/0xb0
> [   74.964658]  ? xnsynch_sleep_on+0x2cb/0x370
> [   74.969126]  ? do_invalid_op+0x3c/0x50
> [   74.973213]  ? xnsynch_sleep_on+0x2cb/0x370
> [   74.977710]  ? invalid_op+0x48/0x60
> [   74.981472]  ? xnsynch_sleep_on+0x2cb/0x370
> [   74.985986]  signal_wait+0x229/0x850
> [   74.989851]  ? __cobalt_sigwaitinfo+0x20/0x20
> [   74.994557]  ? __ipipe_migrate_head+0xd1/0x1e0
> [   74.999338]  ? __cobalt_sigwaitinfo+0x20/0x20
> [   75.004051]  CoBaLt_sigwaitinfo+0x8a/0xe0
> [   75.008409]  handle_head_syscall+0x1a6/0x530
> [   75.013038]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xd6
> [   75.018715]  ipipe_fastcall_hook+0x18/0x30
> [   75.023097]  ipipe_handle_syscall+0x4d/0xb0
> [   75.027630]  do_syscall_64+0x31/0xf0
> [   75.031479]  entry_SYSCALL_64_after_hwframe+0x61/0xd6
> [   75.036931] RIP: 0033:0x7f22d03f0ca0
> [   75.040822] Code: 10 64 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d 74 24 04 e8 2f 8b ff ff ba 3d 00 00 10 4c 89 e6 48 89 ef 89 d0 0f 05 <85> c0 78 2c 41 89 c4 8b 7c 24 04 31 f6 e8 0e 8b ff ff 48 8b 44 24
> [   75.060970] RSP: 002b:00007f22cf7c5bd0 EFLAGS: 00000202 ORIG_RAX: 000000001000003d
> [   75.069179] RAX: ffffffffffffffda RBX: 00007f22cf8d42d0 RCX: 00007f22d03f0ca0
> [   75.076867] RDX: 000000001000003d RSI: 00007f22cf7c5c00 RDI: 00007f22d041e800
> [   75.084614] RBP: 00007f22d041e800 R08: 00007f22cf7c6700 R09: 000000000000007c
> [   75.092343] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f22cf7c5c00
> [   75.100074] R13: 0000000000000000 R14: 00007f22cf7c5e80 R15: 00007ffc585cab88
> [   75.107787] Modules linked in: xeno_16550A snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl_msr mei_hdcp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_seq kvm crct10dif_pclmul snd_seq_device snd_timer ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper rapl intel_cstate snd atemsys(O) soundcore i915 drm_kms_helper i2c_algo_bit video fb_sys_fops syscopyarea wmi sysfillrect sysimgblt mei_me intel_pch_thermal mei sch_fq_codel ipmi_devintf ipmi_msghandler msr parport_pc ppdev lp parport ramoops reed_solomon drm efi_pstore drm_panel_orientation_quirks ip_tables x_tables autofs4 crc32_pclmul r8169 ahci libahci intel_lpss_pci i2c_i801 intel_lpss realtek idma64
> [   75.189143] ---[ end trace 0e0aee69b5a6c08f ]---
> ```
> 
> Freezing kernel log when killing the test program on Ipipe:
> ```
> [ 6432.683272] BUG: unable to handle page fault for address: 0000000000205500
> [ 6432.691709] #PF: supervisor instruction fetch in kernel mode
> [ 6432.697584] #PF: error_code(0x0010) - not-present page
> [ 6432.702914] PGD 0 P4D 0 
> [ 6432.705559] Oops: 0010 [#1] PREEMPT SMP PTI
> [ 6432.709910] CPU: 0 PID: 40164 Comm: noncyclic_task2 Tainted: G        W  O      5.4.255--revision #6
> [ 6432.719381] Hardware name: Default string Default string/Default string, BIOS 5.0.1.2 01/25/2021
> [ 6432.728489] I-pipe domain: Linux
> [ 6432.731845] RIP: 0010:0x205500
> [ 6432.735019] Code: Bad RIP value.
> [ 6432.738378] RSP: 0018:ffffa84380003e38 EFLAGS: 00010096
> [ 6432.743796] RAX: ffffffffb1a1c100 RBX: ffffffffb03d4292 RCX: 0000000000000000
> [ 6432.751196] RDX: 0000000000000000 RSI: 0000000055555554 RDI: 0000000000000000
> [ 6432.758598] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 6432.765999] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb1a1c100
> [ 6432.773400] R13: 0000000000000046 R14: ffffffffb02afda4 R15: ffffffffb1a1c100
> [ 6432.780793] FS:  00007fb5ac2c9700(0000) GS:ffff9afde5c00000(0000) knlGS:0000000000000000
> [ 6432.789174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6432.795136] CR2: 00000000002054d6 CR3: 00000001e1cc6005 CR4: 00000000003606f0
> [ 6432.802520] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 6432.809913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 6432.817304] Call Trace:
> [ 6432.819845]  <IRQ>
> [ 6432.821945]  ? show_regs.cold+0x1a/0x1f
> [ 6432.825922]  ? __die.cold+0x5c/0xa6
> [ 6432.829548]  ? no_context+0x16f/0x3b0
> [ 6432.833353]  ? __bad_area_nosemaphore+0x50/0x1d0
> [ 6432.838153]  ? bad_area_nosemaphore+0x16/0x20
> [ 6432.842682]  ? do_user_addr_fault+0x28b/0x470
> [ 6432.847199]  ? lockdep_hardirqs_on+0xc0/0x210
> [ 6432.851721]  ? __do_page_fault+0x2a/0xd0
> [ 6432.855805]  ? trace_hardirqs_on+0x5a/0x1b0
> [ 6432.860149]  ? __do_page_fault+0x7f/0xd0
> [ 6432.864229]  ? do_page_fault+0x31/0x110
> [ 6432.868207]  ? page_fault+0x59/0x71
> [ 6432.871829]  ? irq_exit+0x14/0xe0
> [ 6432.875281]  ? __ipipe_do_sync_stage+0x2a2/0x460
> [ 6432.880087]  ? lockdep_hardirqs_on+0xc0/0x210
> [ 6432.884614]  ? __ipipe_do_sync_stage+0x2a2/0x460
> [ 6432.889406]  ? xnclock_tick+0x217/0x2d0
> [ 6432.893385]  ? xnintr_core_clock_handler+0x27f/0x490
> [ 6432.898553]  ? dispatch_irq_head+0x12c/0x1e0
> [ 6432.902998]  ? __ipipe_dispatch_irq+0x208/0x2b0
> [ 6432.907702]  ? __ipipe_handle_irq+0x79/0x2c0
> [ 6432.912148]  ? apic_timer_interrupt+0x12/0x40
> [ 6432.916670]  </IRQ>
> [ 6432.918853] WARNING: stack recursion on stack type 2
> ```
> 
> Could you provide any insights or guidance on this matter?
> 
> Are there any known issues or fixes related to this behavior that we should be aware of?
> 
> Your expertise on this would be greatly appreciated as it would help us understand and address the root cause more efficiently.
> 
> Looking forward to your feedback.
> 

You also only show I-pipe cases above but wrote that dovetail would be
affected as well - is it?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


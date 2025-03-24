Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476726280C
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836714; cv=fail; b=gaMn/oTlcnj5T4C3TQoMaU7pcOn5QzSTFiLNJZfdfwX9Gc/AlswQOfmvjuRrIg8cRgEEMpH7B3+qnJITSjkJBGJfyXsqS0yqOZgZhmi5oQ+TcXwvwWZQVfsZu5aQSkBbVipsDKj4N7wXiX+yG9A7dYs21Iw/ua8wmqKO17Dwz0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836714; c=relaxed/simple;
	bh=baTUjDTKoqH8wLFY1lYJvfPunvSSYGdD2Zp8c9LAJzY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=Ve3cP0WOBMsM7N7J9Lpk0yWP/D0Te5p1RgaoN6ycVyMjo37CTkaMoiASrarpmRE9Lf4QlL+sShu5TeMnLbIZm5usxc8IglQOcRYVsdMmex6mMEW7rXD7ojCwuf/1AGzi6CvAARhqCIP9HYBt5sL8mwPCPexlLsjYSR1UE+9XlvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ehmSahAb; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ehmSahAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gybc5JgknyXIKGoYy+ypEEQKSuVmQP9LkgwPT3N+kJs+EZ0GoNe01wwjKgo76iF9mSy4n0BRThK9GCh/VS0YGhryBrRza79DU0AdvgPKKBUUBOGQ6u1vnvd0DInLRBacYtGIHuPTT2puzM2Jm4031LE5QNnDJg9DYu/WRN0X7pXI+YWXkwSgdumoQcNVNU2M0z9daz2Owlso3XAgQTrmzQ1o08nHnwMn1jX2u8V3FtquJIqqJJr8UY+A11qtQLy98c2N6ZOVDB7pLj3WntUeQvSsY7DY3sZINM9NviKRWY6ueqRNxwRqcee2NU7t3iwcsJRQqWHvUMT7EPjN0R9P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVZCJ+qa2Iwblu0c16k9M/WiRnwHMBUK+MMdEcQQr9k=;
 b=QsibTsu3Oz4ArCA/nGUHp4J00tE0XE/VC8XSGoe/dhYmdvk6f8D2CriMJEZa8xxItMlCimx9GknjWMmOQdn/so/MhSTfoQHs+b07nNxaGFD3opfAuREsnuFPZH3LXtLrbpH+7LYK5qJj4AM1Jx/DX17Vsh4cdmYo+w+Z1zDJzkyRFindYKq3B88rXkHIeijeefvnHHoM9eBPB09AGBp2kEGZoLx5NNxWDMLHx1a2qjBYPrsr1bi0m3ztWqjQyga1OtsT1FX1cA+H8j4DMoZKDrbFQJVWJSU2ieyZzcRIVrfZEZIPLLpKJL2Mz3/wn/oeQRpYiNMQ4xk9d/L9IHxQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVZCJ+qa2Iwblu0c16k9M/WiRnwHMBUK+MMdEcQQr9k=;
 b=ehmSahAbNx1VQoQi70wwRFCqn+Kgtm4mxZv+EifbpnLW+gI1HEmxbKh/7scXHBsTqbcHdCQqp8xosEASx/Oh7X6fyJObQoSt8ISgfc9/ylVsENAbVWo6n0WE7tggFxNR72UC+q8yqNm4oQNs3THVEELOyuFzIH0ohEocctqhqW483n1LVCdL5cU7IFcFR6H8fyQ+xETQ081NRCC/hBNfRirPFgx/srZV6VndezwjuUhTTJhor+TOUCvlDi0D5rdmeUv0XqPG/VSVfO9zRC23EvjQ3b4nvDn+b2EFI3yBDAK+7yneB/zCRlE78ehSSxhCOas3x5Naw9ed3epR8KypYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:18:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:18:29 +0000
Message-ID: <e9a4daa3-7a28-45b3-89cb-76c6484a44af@siemens.com>
Date: Mon, 24 Mar 2025 18:18:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: dovetail: Fix inverted debug check in lock_vector_lock
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 861d5841-5181-4843-bbfe-08dd6af7e56e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHFzMUVFNXdydUk0OWw4bzFHWERXTUdBTWdHWXRqZHFLVGVWa1VBS1lSWnMw?=
 =?utf-8?B?T2RLaXZoNW1YYnlKQmZvRXg0Wloyb3lVS3Fqd3h2TTNJNTZGSE4vVTFEcW5Y?=
 =?utf-8?B?NkpvOWZJUGpMTUtOV3NVV0RLSU10cWZndkI0dGFOcmxBVGt4b3JhZ3BHMGFG?=
 =?utf-8?B?dWNBSFRlT0czZXpMK1F4KzBpeGxmb0ZCcWErYnIwMWVlODVRajFVZ1FSMWFF?=
 =?utf-8?B?K3pMSnQ2SlZ2UnBGczdHR2hXZWlpWmI3V2YxZHFQYStuZHd4M1NsVU44Mk5i?=
 =?utf-8?B?cW12MGNDWjIyK3lvdkx6MmJiWmtxUnVvZ1A1aWNONkVtb25hdTAwaFd1aWdX?=
 =?utf-8?B?U0JoRVZxbEdVdHVZVHAyUDlWUUJzSUZKN0pDZDUxS0JxWG9vR24rREpMZ3Mw?=
 =?utf-8?B?YlNrQnNYY3BKenNxUnN1UVcxM3E0bnlGNVdVYXk1ZWFGRWNCdnNrTFUvS1Vn?=
 =?utf-8?B?T09kVTJYeE5sSDhYQk1mUUt2azZlSWNVRUdTcEtnTmxiTWxvSXhLWXhZNGox?=
 =?utf-8?B?UlRBejF3MlJGTmM3RUU1c21pVUZmMitaWmp5YXI0aTlzWXp4VDZNTkx5eFJU?=
 =?utf-8?B?NHMxR2J4RUdyNVFaS1hyZUJMMGVIdWtnT2hRT1ZYZ3pHSGkwa2xXYzNnZk8z?=
 =?utf-8?B?YjNmcjZ4OGI0M2RxaFYyVjViaFRiemNiQXpvZ3F0ZUtUQ1BVK0xTa1lTNU9L?=
 =?utf-8?B?U3A4Vkt6MVVKeUUxbyttcTREc2YwbWNaSExaZTJ4MnBTQ3NTZGg2bHBnSGxG?=
 =?utf-8?B?MWpwYTJkeUIrOVVZRzZINDZZK09xcWZMTTk0TWFFckx0a2lrSjBrK0t0cEpT?=
 =?utf-8?B?UStPK0h2M242SXF0YTZHSG9WejhkNStxU3EyTVZtYVFsQ2J4OWhtdWUxOFFn?=
 =?utf-8?B?VGcxVVEyWDhBcDlBeW5Fb3l5ejB1Y0FmeWpxUDdKdjJTS1haNU45TmxIKy9T?=
 =?utf-8?B?OTB4WlBOQlVIQng4SUZDY05OOXdwM1orbUxnUHBkRThCTk1WTWltazNEdWt1?=
 =?utf-8?B?cVhlWUE4Ty9RMllrNFJBb2lqTDMzUXdIbFBVNEZPTGtPUlhNcXVjRk5aWkdQ?=
 =?utf-8?B?YjBvdnBaNDFnQ0MyT2dvMzRPcCtJMVBZY2srYWgyeVRFRmlJNmxjS29YZmFu?=
 =?utf-8?B?NXl6clRsQktKUnlyMGx5QmNWcWprNDNZZW8zKzc3Y2kybnZGQkttZXVRWDBa?=
 =?utf-8?B?c3lZRHV3TVQvajRpODNVcVZ4aUtZWkJZNWlPaW1hcFBYa2pXbHEyR3lRVGky?=
 =?utf-8?B?YWxKc2FvNVZBQVAvU0VYT01ZVlpxbHdBMk84U0pwWW5rNHpXVGlyL1RmNVp1?=
 =?utf-8?B?NVlzT0F4bkhZOHphWlNpVSsvQkRFMGZLc1JpUEJNTk15OE5sV05UVnYyVjBi?=
 =?utf-8?B?R2JWMWptNzA4MXVHbmFLSnoweUpHWE5MaVRad2p2NWExNDlLZTltMzlhTXpj?=
 =?utf-8?B?dmlGb2pldzB2czZKWkFlMlIrbk5YTTFYQUh5Y3EyeDhFUXlHT2V6eHMxUXZZ?=
 =?utf-8?B?NDhmNUJvU2hDcGpWR1hjZzJ6Y3A0QlNQSWFFUjVRTjZpSjRCTzJmTEcyemZx?=
 =?utf-8?B?WXJ5b0VISTJxVllFMHhFY0lySTRsbjZaYjJKM3ljelFxRjBYQ2YwaC9rZGFS?=
 =?utf-8?B?aWZKVW0yNCtkUHlqckQyWFRIaFVhVE5FSnQwdWxWSSs3VHVVWGZyT0c2VVFj?=
 =?utf-8?B?Q3BtYmJNdm9WSTdVQlp4OGwyS25DQXpPNTB3ZmRIYmMzMVRoMjF4Z1hZcWlp?=
 =?utf-8?B?ZXl5elZIbmMrQ25QR0hmT1Jib1BYcjdpKzVta3R4YkliYTcvazVUSDdYemtm?=
 =?utf-8?B?QjhmUjdHMFQvbTdZSWhENUs4RDVVRVpobU51OEEwa0NYRU4vN2NmeVZGeFNC?=
 =?utf-8?Q?HmiHz9g1vgOd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGlsb1M4SE1GQ3JZc0tzS0ZxbDNmQWJwRnhqalQxRm9YbWlrdWVXZWhYZFY5?=
 =?utf-8?B?UFBWOU1IUnVJdEpGUGcwNnNtL0RacVRxVlRIRTBSdEdVbjdoakUwUkxwcUpw?=
 =?utf-8?B?QW5nOUwvRno5ZHZMLzJmR0FiRW9lTDVFMURyTjI5WG9mUmZiMzlqUWVhT0JC?=
 =?utf-8?B?ams3V3l6dmh4ZEhERnNDdGF1VGk2aGl0d2pZa3FEUFpPU0lOM2pwakNBL0xO?=
 =?utf-8?B?TUhES1YzRzQxblA5KzNGTU45SW44NTJ2UGFEZzZvZUd6a0JBbXM0Nkkya0sz?=
 =?utf-8?B?b1hMdG9ZN2hIK2NKMlF6d2FDM29Dcm5ScDh3UDExamFHaFBzNjB0ME1xUE9L?=
 =?utf-8?B?dzd5ckpON0tZS3dGSU9hMEJoRmhYQmVOWEw3N202YjNicFF6alVJRUNKM2hR?=
 =?utf-8?B?Q1hRc2lzUTl5aWtRU2pMSWVld0VXVlI3TE9lV0VYNFoyUjFIYUdiam1WMmVq?=
 =?utf-8?B?ckZZalRxaWc5cVdNdnhkcUJCN3FRUVpNMGtiZEIyL3RZdWFSTHhNOSs2Y2xt?=
 =?utf-8?B?WUxhYnhTRnRjR3NWVGNGMzFVQURtMmJnMmxhSGRJRE96S0NhMzBvQnFkQWdS?=
 =?utf-8?B?dEJmZ3pBRlIzSHhiMmN4WVRYOHZvRlpFeHAxM05iNnoreXNSUVZUR0V1aW03?=
 =?utf-8?B?MXJLR01tWXR2UFd0NzRjWHZxUko5T1lLSUtKM0dUb2dOM0EwNFRLNHpmS2pE?=
 =?utf-8?B?c1B5Z096MlExTzBhL2RrSjQ5QzJOUUF5azVnM1E2SWwvRUhQMnhMOHVqV25l?=
 =?utf-8?B?dEdnT3pJNExiTmI2ajYrYVowa0tndW4yUno1Wkc3SCs5NzlSSDcwc0xSOUZV?=
 =?utf-8?B?Nzg0bGgwSEZqMlhocFcxZUpYbDNPNEsrcDBseGV1REhhNG5MRytVOUs0SUNT?=
 =?utf-8?B?NDg3cW56TnE2aWo5UlM2T0ZLKzZLNWpBaWlvWXFhWDdUeVFZSFI4Z091Z0Nn?=
 =?utf-8?B?T2w4c3dMUmNQek1ydnRaY0toY09UckI1QXVjTzlhMVUvclY3bkxCdzRiNFBZ?=
 =?utf-8?B?M2IveGloKzFzcU9lRjNDR0NoN3d0Uklld3Y2QVVGZG5neXVoNDdjRjN4NHNE?=
 =?utf-8?B?MW5tT2pwQ0Z5SzV4enJxS3Q3ZVlaeDY0c2NOZzVPSlRVTm5zUXZyd2lPTVk1?=
 =?utf-8?B?bGRBM3d0ekFrMVFUOW9ocG1JTzhIVTZqMzNtejh1ZytOTDZOa1NldFdSMGhk?=
 =?utf-8?B?Wk9LeFlFTU9WaG9GN2ZueVJLTWluRFErQ0paZitkY0xEWWRVbGI3NFNDTTdR?=
 =?utf-8?B?ZVNtUjhhRW4venBiQkQ5TkhXaUpHcStDaUYrZjd2NXJnS0FUWTdLMGxDVlp5?=
 =?utf-8?B?eVlZWXZFZ3MzMVNVQlZTVkFxWFRPMFFiZHIrUUVFeFdoS2ZVUDVjNVZpN3d1?=
 =?utf-8?B?LytVbG1uUlNsZzFwWkFTVDhVblFzcURIcmFzZVQ2V3VnL0YrMUovT3Z3Y3pn?=
 =?utf-8?B?WmtUZXV4WldpRDkyVnNacWRhN3B6Q2NQbDc5WENqaWJNM1hFVTJ0RFhCdTlH?=
 =?utf-8?B?R1lRei9xcStGZ3g2djFERGUvZnUyZTY5SWFnR2tSTktyWXZvcGdwckt6L2E5?=
 =?utf-8?B?elgzSjlIZVd1d3ZmNGZlMThQZE9Qcjh0RnBtcU9pZ2xHVlRucFAwaC9wV1h4?=
 =?utf-8?B?SWQyWEhOOWZDVWlRUTdZeE5McjBac1hIdllFRUhqcFlBY0tIc0FpaklXbTRp?=
 =?utf-8?B?R3JPVVVwTm54dnhiUUJNWDV3NUdMOFR6UThrYzV5TnhvMzdHSmZwaHFZN0hw?=
 =?utf-8?B?b1VCS0R1bVUvdFE0K2pwNDRVT1VpNnZrSnRSVGdlZkFmMFV6SDNiTUd6VGsz?=
 =?utf-8?B?WE1EeUpkZkpVTTA3dFh0eUJMSWRscUR4akRCMjFhYjV2dmd6dThRbGd5a2ZC?=
 =?utf-8?B?T01kcDMrSEhmT05Nak5aUEJYaldpMTZFTUE5VXZ0TUV4MVNnK3gzUmxJNzZU?=
 =?utf-8?B?Mkk0MElKT3JncGpIRVBldlBycW5Ma2NURWlZSWhoRUZCd1dkMURUUldHNWc4?=
 =?utf-8?B?TmwzL0dWY1hVZ0VLQVRFMUpzN0ROMllnRnFveFlBV3JGK1F1T1F6WDBndmps?=
 =?utf-8?B?eUcyVmlpemhWaUY4ODhDZkkweXZHbEwrWHNVMUt1b1dwZGhhVkRpdnl2My82?=
 =?utf-8?B?YjJsa0s0SGk0aENqNG1UU0VuY3RLamFvVXNpdk5HdktTK1hza2ljcVRHMkdY?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861d5841-5181-4843-bbfe-08dd6af7e56e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:18:29.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMKTq7Z8ojCQLxnL+MNdFr6AL+aibysynKOxMRP2m0H0RrTpW9dPtuT54QYfpRpOkZVyIh7uWtqSGH5RT93eTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7197

From: Jan Kiszka <jan.kiszka@siemens.com>

Code and comment were no in line, but the comment actually make more
sense here, given that unlock_vector_lock will unconditionally reenable
hard IRQs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a08b0dff066ac..af60f138d590b 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -142,7 +142,7 @@ void lock_vector_lock(void)
 	 * entry. In addition, we assume that hard irqs are on as well
 	 * (which is the regular case).
 	 */
-	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
+	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
 	hard_cond_local_irq_disable();
 	/* Used to the online set of cpus does not change
 	 * during assign_irq_vector.
-- 
2.43.0

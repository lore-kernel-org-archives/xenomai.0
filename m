Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86214214221
	for <xenomai@lists.linux.dev>; Mon, 21 Apr 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745230102; cv=fail; b=C6uHVkGD904kcMYoPtal2/UH2IUySNx1jPyMt8k54PHFPvqv2dFZZm7nryJ0fJZ8iUCWvKGbp4Ppvdrk+WF2UVEmw4VvvQW6jJy+vV0gVXsPC6o4z+qHpz18OXuY5XmnRShq+qWkDxSVSzIePFUUrq8UaiwkPVHEpKQln4zk+PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745230102; c=relaxed/simple;
	bh=GeryViEOgVc7sBEpJqwR1O83tNArE8Rv1a5gQNZvfOc=;
	h=Content-Type:Message-ID:Date:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=P5ld8j0Ln64yRb6o1MoUiLzcv7JB1tR+bRmfFQhv/KIhI7mQbvAk/i/oOvNv/6GRJPACGmQu1hOOxbBpVv1TwtJq3J+lEyACJIERGi4Qev01xd26AoLG3ChabkC5Qr41IFaIhyLmYAStSDtPNgUWVThd0TQbLwJ+82Br+zUuorQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UdM086sH; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UdM086sH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv0DTFzG7+QsKsV/7q1rbI45FhE65Y+lp8gb626mj646l8bQRzH+VurpbFEfZThHkSV5lMFV5/kH9SOvlbSPmZbEG6XDntKmQ4L+RBpnBarGkY7Egxn8N1v97sQBTKSoxHoHHM4c9dA4nS4geo8LZ6mNxz03xksYEl+3DhZmOApuWE/l57mhz/4ayXIzVMyOwgJarbtoKbcC6o/bC6GpFiiei4SIcuASBwh0HByprfDl4kzbyhSbR5G13JKYbzdVv6UDWlUIIPW7zfBzoqwg8uggTHSEk1zRt44FjIjycYaDglZX4UyncAh37uKdwcnKVRcjN/zFPSi7M/sse+cJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j2Cz2wSZkzw6sf5XTl6gst7pBevRAWBJrRnsHn5Eks=;
 b=dHy+tFFC0jwi4YTjLN3BLRyoYBY1iw3cN8IqU6HLm8K6Js8PznkltQYxnMlGcyMQZJED3tO6WvDgxPaEcS6JsJO4lernvAIHP73MnvU0XCFXoaeUcej8xu/H0naBEKh3wWV1UTuaLMHpPCVL87GJU5l5kfK7vQ4pw5tnoncsF0IR5XkzRUdXvMkEcML/dl0BsFyGcEwW34CapxNuYdaQ8HdeJmStyHIqKn+6bNhCLxF5+IpHwcWewKxFjBjPAS3tsHvTi6VQNUeEvkHXdpL6smTufHl+iVn9rCvvx5pCaC0IJ1DfxXZ3dA6vxLyMRdGh0vIiQZ5n35QusaOfeChPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j2Cz2wSZkzw6sf5XTl6gst7pBevRAWBJrRnsHn5Eks=;
 b=UdM086sHMqzS1WWNv+9KqCV/ktciXyDAGR+TAHBiPjwL6KXJROfA7rTKiCL7V8CK1S/DMgKLe7h8NyF5xUVR7TnlWmOGD6AaIHrKpRQBgBo/qoqvrudA6qLrLW1Ij298HP+tUNaJLe6yLlr9mMJjqh4Q1ALh765Ags9eMI/FjhHtLjvnp8X9LLnoQObI5f8forQ6cy72R4iADo9R2Q4X8nJbpK92EbHQWecGYshvhsg4EeNhhBDxVGU0z73j7bUQFUOHY14CPdZuieBiLjn5KBu7aZvLzdxQ/v3oDyoUAzSkl0cMvLgSuXM1zxpEkz2DcJI5JJa3v2c+FVx0HAi0Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB8023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 10:08:17 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%5]) with mapi id 15.20.8655.030; Mon, 21 Apr 2025
 10:08:17 +0000
Content-Type: multipart/mixed; boundary="------------XQFljIbPUkxkN0lhiAgon7dz"
Message-ID: <b1f7b09e-344c-4320-a02e-24ea498a518d@siemens.com>
Date: Mon, 21 Apr 2025 12:08:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Build error of kernel/xenomai/debug.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Pirou, Florent" <florent.pirou@intel.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
Content-Language: en-US
In-Reply-To: <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DU0PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c9d4db-96fc-463a-6d67-08dd80bc6f9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|4053099003|4013099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ang5bXd6alFlc25pR2NnNGliZVBQVzNRbmovclhsdjZ6WU85NXM4VDV0SGNx?=
 =?utf-8?B?YTRmR1JlZUk5TFlqaTI2cVZRWFk2U2tGbWJaYlBpVzJBaFZYMExXQjRFUHox?=
 =?utf-8?B?VVBwdVdsWGlJNmIrdG5WSUZWVjBFaXlGS2tvOHU0VVBhdXdsckhraTVOd01y?=
 =?utf-8?B?ZXNkOUc3elJpMHpPR2QwVnlMWGlXV0cxZFNrWFN6MVRzUHZ3d2E4QlZVMldn?=
 =?utf-8?B?QTJoa0JFbFRKZDZpUUhWdHpsRFJKNVZGbGZBS2ZybUF4dHM1ZUVuSWFaaDVH?=
 =?utf-8?B?Rm0xc1dTRmkvN2ZoTHBTNEhXQm14T3ZMNUtsZXJQbUwrUWRTN1lXR201Ymln?=
 =?utf-8?B?c3pGZnhLN0VuSlV3dEpabUdCV1dGWmFiMDhoaVlZbzJuUWlaemZmVldEdk9G?=
 =?utf-8?B?VGNmZlFZd2tkaGx6TG5lM2ZCaXRtckNtdWlUNlEzZzE4VW14RUZkYjRIK3dj?=
 =?utf-8?B?bzZjN0k0ZUM1T2hhbSt3ZnRUKzhobmJOejBaSVFXTHlOZUZxeDM4UlVTUmFT?=
 =?utf-8?B?d2x1MFhJUmYrZ2hCS0hSVGNNbDNidkVFMHhWbGFiWXVjRjVmVXRkWitLVkRL?=
 =?utf-8?B?WVA4Z3BTWm84anc2cytIS25zdUtPaVJNYWJacFY4TUFwd3dMeVdiYzUvSFhB?=
 =?utf-8?B?aXFCSDc4bVN1K0NFUGNocmJEOFc4K0p2MXgvVzhrUDB1QkhyYVBxbFlmai9m?=
 =?utf-8?B?bmh5MVdnelErcVNEMzB5dFc1SU9XOURZN2FqU2orZmtUTStYNGlLQW5nMk1Q?=
 =?utf-8?B?SVBVRHo4dnBZekFtUnlCNjZWVzQwUjVtWHNVV0dGL0xaQ3lHVmo5ejVFYVBF?=
 =?utf-8?B?NnhvTW5VSU1PcjhMaGRuWUM0Mm52V0swNTNLdzFDcmtySW1EcVVMRzFqTE5V?=
 =?utf-8?B?cmlaaGtYSVhHd2F3RjZRbUJYVVlsK3lqSzQwa3JMNGJ1RG5yd1ZnT0tUTDA2?=
 =?utf-8?B?cVorRXhVblBqMXAzczZDeFkySHhMeXU1QXdzYlFsZDd0SFhaRFNpd29aUzNT?=
 =?utf-8?B?NW9VdHREZ0NxS1hCcGhYWVBSTmJaYUczMXpZYVMxQlBCZitNamlvQ2I1Mm5m?=
 =?utf-8?B?OUZabEEzS05xYk14L2JzQTBmZUR4WENZWnlqTC9QQ3Q0ellxSzFaZnJMd21B?=
 =?utf-8?B?VEdSRWF6STRmQWs5N3lHQ2JUWlBGZkFML1duQ2lmd2ZZeVBEaUhETnJhL0Ew?=
 =?utf-8?B?Z3Y4Zm5CS3lKdS9PZ2ovVkJYdFJ6blpHcXhOTzB4MGFZU2FzNytxU1p4ZW5I?=
 =?utf-8?B?cmlXMU1mcitwbExPWjRuT2x4RTVSSi92YVk2NUZuTWlPMzZjSjhsNXZiVVZP?=
 =?utf-8?B?VkovTEExRS9wWnpVTkg0VFFZVUFBdFVaRXdnWXNtOG9Sc3M1Um5mdlFkMktF?=
 =?utf-8?B?NGZzS2VQdjZnbXdtN3BDUkcxeXp1UTc1dTRCUmxEMlo4akdZN05tM3FCcThn?=
 =?utf-8?B?ZjJZWWRyN1RDKzJmRXZYS29hU2M3RWlJNTl4dHZHR05WcWRwZkZ1Rm9zUmFr?=
 =?utf-8?B?VHFpazdVNjJ6QXdmZ0p5aG1NOWRtS3NNMjMzVEZGbTRYYkI2RUVMekFWMTZr?=
 =?utf-8?B?WEhzTkIyeFUyenBzTFVyc09rcEpHUkpvYlpLcDd0OTZvRHJGTkd1L0VmUmFZ?=
 =?utf-8?B?WVR1V0xueUpPdVJraUUvRElMUXV0cG9hcGsvWlJEMm4yNHYvU0NEWllBa0h0?=
 =?utf-8?B?dHpUQ0wzTzVhekNSQU9Wd2F4cEc4dW40YWtYNXRjdTRya0RYRnUrY3BMQnJ5?=
 =?utf-8?B?cEUxNDlxWVd0OVFGMWdBUDVRbkw4YmR6YUhvR2RLam0xRUFsZEk2aUxYYVVD?=
 =?utf-8?B?cURhbmc2b3BMaGhuYWhiQ2d3OUlqN2h4MVdHYnZPQnJxYUx6Z0thc3dNKzkw?=
 =?utf-8?B?SElsM1dqVFRpWnFJWml2TEQvdWFjZGRVMTlQeG13RS9vZlhXN1BLUER1cWpP?=
 =?utf-8?Q?/tAXMVv6l5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(4053099003)(4013099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZuOXlGRFBXdEFYSS9xdmdJcEh0ZHFsWHFtZmtkcHRLa0gydW9vdmV5Y3Ra?=
 =?utf-8?B?SFQyWVliZUhUaHgrbDhFRTRSTXlVWWhUWkozWVJGcGUxYXJpckxjd0toV1p2?=
 =?utf-8?B?NTZpSEYrck90bXVpcUFVbFJib2JWSS9EdzJuVzBsS0VNUzRrNzIzQlBwSng5?=
 =?utf-8?B?a0VRYWNoTVVNOVVNOEo5YWd1SUpsYXhHSS9RK2xQVHBUOGltS3RxdnpLbTI5?=
 =?utf-8?B?ZjFqb0JudDNiWFFBemxXMGp0OG9SUWZTRTJWR2lqM09WYStnL3JPNVZoOFBQ?=
 =?utf-8?B?TkpsQ2lCV2c2MjlPTlArQ1BZV051RXBnci9IWit3SkJFMHZVcUdUYm42VUZz?=
 =?utf-8?B?UWlWYWVXcjJqMTRJQi81Sk1lL2k4TVNMdjlheXBxL2YzdUM2cUxOMm5rZ3Yx?=
 =?utf-8?B?TjNYSkdVUlVwMGJ5UkNYMnVzeU1WNWFKckJyajJHbm9sOU5mNHc3Q1hzdHRs?=
 =?utf-8?B?NXlqdlJCOCs2dk9IOFlXeFhBN3krTXZJVVZpYm1zc2JhN01JNGdob3g1Vk5v?=
 =?utf-8?B?Q0U5aitXeWg4RW0vYmEzOE9sL2FBV0d0MXl1OTlTVytFYnBBNERYQ1lrcGsz?=
 =?utf-8?B?V28xWXV3SmNtcnJrUDd2akhxajBXWHhWako1dDdITnduOUR4UEw0am44cFRh?=
 =?utf-8?B?bEIxSmVMRmJ4eUVWOUxKTEpzaVlYdEIvbi9WWll0WW1XRG1XQUFKYjlGc1VW?=
 =?utf-8?B?YmZFYnFHcDFkazg1L3ZWNGsxRWIxb2ZwTzhDVHhpM1EzVysxc1JCZVJRK0VG?=
 =?utf-8?B?RDV6SEJwVGI2bjRjb3ByS09CM3B1cFpCbVBpZ3JSMGEyS0MvWVNNSTZ5cUkr?=
 =?utf-8?B?OUV6YzRGc1FaS0dGOFVPY3RLSlNwS1NocDFKbCsrUTV6WlhSdWR5eFRwUHc2?=
 =?utf-8?B?REN2U0N3bWovajRwVHp2NU1uckVJL0lseElsTGJkbWVQeXlMOW45dVV4YzV3?=
 =?utf-8?B?Q0RsZm5qU1RjS2JzbkNXNnZlK3J5M1VWaklpZzR4bG9qbjNMV2dnU05VR0Vj?=
 =?utf-8?B?MCtWbk90ekRXaUNhUXY0c211MWxmVmEra09aQi9MUU9NUmNRMkxHK3lsVjNr?=
 =?utf-8?B?UDdtU1NudDdYM3RGbzFtWEVVNHlWd1M3MGdOaXdZbEdUTUYwUkdENUphYnVH?=
 =?utf-8?B?SzVwM3VQTjZsKzVoNko1Qzhhd3U3a3FjelRSalhLVytWa2Y0cUw1M2ZELzcy?=
 =?utf-8?B?dFhqMkZxVmlsa1FHZnZsSlVqbit5OGVDdlMvMTNQVkNscldqNU1zY2pwYXNF?=
 =?utf-8?B?OWJwQ1h5VnNwUVpHRXUwdmxWc0owKzdHWE9ycUljeE9PeXVFdTEvUENab013?=
 =?utf-8?B?d2VtZ2Rvd0pqYVNvSmplNVRqd2Z0dHhoSkVpTERYMVo3aWdNa1EwdWR2U1pV?=
 =?utf-8?B?R3ZVMjVDTG5pYVVNb3JYaU02bVh1VDlqT211SGt4cDllbUJSNVlHYzFSaHZV?=
 =?utf-8?B?M1lKbFlhZy83OE1PeDUrUDl3ejFaelZ1YWE5TFBwU0NJbFJCTFBUbExuVkF4?=
 =?utf-8?B?Q0pmZlRrU0NYQ25pd2NVUXJST1FoM29tTWVodTFudHZzc043aGlIRTBNdU00?=
 =?utf-8?B?dThkQ0Zac0M5eXZZazdvNmlMcit3dkhBbWs5MmpTa3N4d3JKaGREckgrVzdE?=
 =?utf-8?B?c08vTTRSa01peWJuMCtXRitqUzlMWDRzYTZDckppRDJUZVNHbXBUL0MxK0JD?=
 =?utf-8?B?cGkwMDZjSmNIa3AwdzBxYXRFSXE5T0lpMmNHWHlTRTRVQ3ZOcE1sQXl0YUFy?=
 =?utf-8?B?TUo1L0daeHhqTnRZMnlFNENHSFRZdlRaSjE4NS85RVJtNXVvTDZYVGZXUWZP?=
 =?utf-8?B?YXhUQ29STHlpZjhoRlBEcXk5Yk1VWlJFeWZ0UGpWU3lJT0hhTlBqMUMzNHFC?=
 =?utf-8?B?V1JtMEtaZHJpUTVpTFV4eHFTU3kxUUhpYjNqMy94ZEViNTdhRGJ0WUcwL0tN?=
 =?utf-8?B?Q2dJTExZNkJlWDArREQ2TmszUjArNVJLbUNMbkxQNy95VjEzV0ZLV2RSRHJZ?=
 =?utf-8?B?Mmk1dFh3MG9SS1RuTktacHNzOUtVTmJlQ21ZRWFWRjY0WXdSVHVnYW5UR3U0?=
 =?utf-8?B?dndmUDlIQVFscHlWQnZGVGhMQ1B5cTdYZTFheUQ4TWw4OExNM1RCb1M1TWhY?=
 =?utf-8?B?Y2NBUUdqZStPUXJsdFZqSVNmK1VEZEpuMzJqemtTOTYwNmUxRTdJd3c1MlZ5?=
 =?utf-8?B?Tzc2NzhHVStOcUdrblNGTkFYQWd4ek9udnUyRjFNdjNLQmU2ZndnSnQyUS9i?=
 =?utf-8?B?UEVCbVJwSUo1aHJNU1pRTXloZ2ZRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c9d4db-96fc-463a-6d67-08dd80bc6f9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:08:17.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpULa5PAsBhPcoT96vvAdQBZElSQKQYZ5hrtPxz+8xCDytBT0cAbKSJVaSRt6cZWYQ/+ciHuAM0DLQTwQyx+dSu3sDMdCI3/gyVxB7sMxIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB8023

--------------XQFljIbPUkxkN0lhiAgon7dz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.04.25 11:45, Florian Bezdeka wrote:
> On 21.04.25 02:08, Qiao, Wei wrote:
>> Gcc verison:
>> qiaowei@wqiao2:~$ gcc --version
>> gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
>>
>> Kernel: 
>> v6.12.19-dovetail1-rebase
>>
>> https://gitlab.com/Xenomai/xenomai-hacker-space.git
>> tag: v3.3
> 
> I tried the following build configurations, all worked:
> 
> - gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)
> - gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7)
> - gcc (Debian 12.2.0-14) 12.2.0
> - gcc (Debian 10.4.0-7) 10.4.0
> 
> The default gcc version of Ubuntu 24.04 - as provided by the gcc package
> - is 13.2.0-7ubuntu1. Seems you installed the gcc-13 package for some
> reason.
> 
> What happens if you switch back to the default compiler, does that work?
> 
> I can't tell why, but gcc 13.2 seems unable to derive the object size...

Typo: 13.3 is unable to derive the object size, 13.2 is unknown.

> 
> As Jan mentioned the quick fix I posted is kind of an overkill.
> 
> As I don't have an Ubuntu system at hand and all tries to reproduce on
> Debian and Fedora failed so far and in addition a lot of different
> compiler versions are working fine: No further investigations will
> follow on my end.
> 
>>
>> -----Original Message-----
>> From: Florian Bezdeka <florian.bezdeka@siemens.com> 
>> Sent: Monday, April 21, 2025 5:47 AM
>> To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.pirou@intel.com>
>> Subject: Re: Build error of kernel/xenomai/debug.c
>>
>> On 18.04.25 07:51, Qiao, Wei wrote:
>>> Test pass.
>>> The system can boot up and work well.
>>
>> Which xenomai/compiler/kernel combination are you trying to build?
>>
>> I tried to reproduce with gcc 15 - the latest gcc release - but it is still building fine.
>>
>> You mentioned Ubuntu 24.04, which should ship gcc 10.5, which should be fine as well.
>>
>>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Thursday, April 17, 2025 4:59 PM
>>> To: Bezdeka, Florian <florian.bezdeka@siemens.com>; Qiao, Wei 
>>> <wei.qiao@intel.com>; xenomai@lists.linux.dev
>>> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent 
>>> <florent.pirou@intel.com>
>>> Subject: Re: Build error of kernel/xenomai/debug.c
>>>
>>> On 17.04.25 10:43, Florian Bezdeka wrote:
>>>> On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
>>>>> Hi All,
>>>>>
>>>>> If we build the kernel in ubuntu 24.04, there is build error:
>>>>>
>>>>> from kernel/xenomai/debug.c:23:
>>>>> In function 'strcpy',
>>>>>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
>>>>> ./include/linux/fortify-string.h:787:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>>>>>   787 |                 __write_overflow();
>>>>>       |                 ^~~~~~~~~~~~~~~~~~
>>>>>
>>>>> This is because new gcc version has stricter FORTIFY_SOURCE( =3 is ‌stricter‌ than =2). Please help to fix, thanks.
>>>>
>>>> That is the flexible array story...
>>>>
>>>> You could try something like below (completely untested) and report 
>>>> back if it works:
>>>>
>>>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c index
>>>> 25b194c26..d048dc757 100644
>>>> --- a/kernel/cobalt/debug.c
>>>> +++ b/kernel/cobalt/debug.c
>>>> @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
>>>>  
>>>>  struct hashed_symbol {
>>>>  	struct hashed_symbol *next;
>>>> -	char symbol[];
>>>> +	size_t size;
>>>> +	char symbol[] __counted_by(size);
>>>>  };
>>>>  
>>>>  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS]; @@ -91,6
>>>> +92,7 @@ static const char *hash_symbol(const char *symbol)
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> +	p->size = len + 1;
>>>>  	strcpy(p->symbol, symbol);
>>>>  	p->next = *h;
>>>>  	*h = p;
>>>>
>>>
>>> A bit of overkill, given that allocation and access of according size happens within the same function. No smarter way to tell the compiler to stay away here?
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Foundational Technologies
>>> Linux Expert Center

--------------XQFljIbPUkxkN0lhiAgon7dz
Content-Type: text/vcard; charset=UTF-8; name="florian_bezdeka.vcf"
Content-Disposition: attachment; filename="florian_bezdeka.vcf"
Content-Transfer-Encoding: base64

bnVsbA==

--------------XQFljIbPUkxkN0lhiAgon7dz--

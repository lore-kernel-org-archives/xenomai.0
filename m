Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A693644D9
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233702; cv=fail; b=azYJpHPGc1092pYo8A4eSBWB/BxmIW9Nq+zaRStfAqia8gvFpCsUFVSOhjeYkBERE/T+WSV8Pn4A36iQJqZlNRjOK1mQCmjTZaTFgGTV1/X0hVKezHP1dzy2P3FF4zrG1gQBlwVrkXqoXLTQ01932KzwfDiGQ7QgRv/xwHbmaNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233702; c=relaxed/simple;
	bh=89D3EzXk0e5k6X0T3nutGENAAQeeyoQGyshWip7dPds=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/tb2pNSS7BmnW5eJ7E9VsE/dC6XKY3T4/OAw8zvG4BOviuMkik4U02u5mm6i+7IksI3IYAkR/TZTEXZ7v3NKCSE6QlNuOY08wMW/xEjhF/t4vw2DXG9t6Lnu/idb+Z+v5NLLh8MkE2EI/RVpzSVE+tlHYNJ3bGoaibW0AMq0vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IBeVeueY; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IBeVeueY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChJIukFtLUyyXOPo1Nxzdn/MwXW8nrkFaIAkvnJQjjPAjNIGSYKXEdCDMGI0z3mVfcP3wPvFJFDUEFEu0uGUbYcm0v4UxzK5TiRt8s9BHo72DpmqtHZmO5AAUyqT6OL4/NU8hKCPYXJmNo1TDVhDqjTXSslAzMzplVb82+118Xza3AQ0gET8xwHTcxHpMB/TCnONLQi9nvLdBUZwHJ9lHDYHWBpy1msgjaDrNZhvMUpvbThtdCD3dX++8BcyonRswnnRq8xLiA/f/N+bOckc+NobQXvH06pmvtQm9XXv4mNlh9erEXN/4lebBSbyftwEJ+tzZ+V3g5er6XlId8iHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcIFctiUFO/wzPM/zvyqLUo1YAyppFHtAzn2ldwvCLI=;
 b=uoX6iuTBTowtq/yMD7Y2YW/d7yxfaBavdOAL8iAPQhOOdrsAGqexcqoQIwsk/bN4tzUjA3tfxwWpKi75DUt1cOT/hnGx8EyXziAjIAuy3Z8Z+ryHxjYEQMuc7BsHm3/2TUKz+quPp8+sqWnVo7C9Hupap9UlqapcVOTSM/Ezx4u9yCHZgLYSdTPd/1eR2OAWaWZ6FLVidKGhAJeWoEynEx5JCto+OL4wEFsNkSI+Ibiaj2A9ptEZvSB2a3mQBCVgk/lXcSX7tjgPvJf1dJhPvtsPopDvM18qsZBFVKkhuFlkTuSaKQSt95dbd9ct2Arar35F3+k/3ZcjG0lUfLq8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcIFctiUFO/wzPM/zvyqLUo1YAyppFHtAzn2ldwvCLI=;
 b=IBeVeueYWxKiwm0MDsoLEmCWifMxJzd1myQUDjClhVVbICfsN6GFNh1kIgBzRQPuoDH5ZlbwQMn3MLtidPnwcTig04dfZmcqzE+CDkssFqKGTqhoCYNaEbmbo5BAGX+RhdWztpnfowVOBuDfJaG1/FhXoBkqN0EuMFv4IeaU3qUMtklw+pmLXxo3hewutsR35F3bhmxSEPXth2lMYogJpddYkuXWVw7a4ylUQYrLIgfkCxzKADPYD8qSLBVzz8a7cGMGP2Iqli43kQKO3YnV00B6EJ3THENsTTcyIqJ9sROX3UD79M17n62ZMsaYBpRFRZwIa3m6Ai+b59nJ9oEAXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:01:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:01:37 +0000
Message-ID: <0d89b51e-be92-4a21-9ed9-6260c3da0d54@siemens.com>
Date: Mon, 12 Jan 2026 17:01:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
 <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
 <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
 <b7273fbc764ebe2c5b40b2c1285a0ea56324caee.camel@siemens.com>
 <6bb6c04c-bffb-4f9b-8ddd-0d713d180bba@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6bb6c04c-bffb-4f9b-8ddd-0d713d180bba@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 53717027-3371-482f-a973-08de51f3dda7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3dxd0ZianVUb1VpOTdpNEpBdnZkWGo2NEtEcHl4TWxuYkxNQ0xZZHRHQlNH?=
 =?utf-8?B?YTdvTk51N0gzTnR3UEpheUV4djBtbDZJQnhmQ1poVUNiSTRodVpuSWREM082?=
 =?utf-8?B?cXVUTkJ1aTBJUk91M21RWUZIMUo3SEc4bFlJcUh4WVZTUG5JSkIxck1XK2V0?=
 =?utf-8?B?VThDVS8yNGFHRTFvY3NUTURuZUQwbEtFMmhXUm5LYytXNXVSNG5ydHZaSGcw?=
 =?utf-8?B?L1pHU1RzZkFhUnMxWUdVZnhWL3BqUFdoci9lOWdaQWV3dzZENi83OS90SlRa?=
 =?utf-8?B?N1ZQbVhMV2kzS3hRSjR3cWdtN254QStraStUTDcwRGxjcHQ1aXRXejhzV0Z1?=
 =?utf-8?B?UCtmVFRibjZ3VllydmxBQUtaWVFSM3I1K1QwTEl0NjgzWVdQYjRQSUlXajNt?=
 =?utf-8?B?WUZUUWwrd056NFVJbjQ2dDJLZ0ZqZkhPbHo3RlhaS2hwQndoaGRaNGVzbmQ3?=
 =?utf-8?B?M2s3RDBORE1yUHpCaFdVVGlyQ01FaVFrc3ZkcFJRSzV1bkVwaFBaM3dVTXZW?=
 =?utf-8?B?b09La2JqN1ZXaEltYklFekYwTzA3SlJmcE9EWlVzV0llTHNSQ2VDRjRTUG9R?=
 =?utf-8?B?U0dLMHpJSnBKa0RGTzY1RjA3MVJJaGV5NXVPakVYa1dQZGJRR1JTQ3Y4QUsz?=
 =?utf-8?B?ZFhKNXRrNXM3TXo1eXB0U0xQUTZ4eFFXbDNVbmRiUSsxN1RZUCswckVHUUhp?=
 =?utf-8?B?amFxOFBFWkllMEFGQ3AwQ0RPRHU2TGZ1SzhuYVlYREZBRStXSnFHNkpLZGk3?=
 =?utf-8?B?bVJqUkp2ZGdEeWg4NHV5TERXTHRHdFJlRFFyaFNiK3VlMm9Yb0wzWHFISnZQ?=
 =?utf-8?B?bnhpWFVPckVlUldsT2VORmt4UWNsWmJzenhhcWFrcUVuNTlXMW0zV014UDQr?=
 =?utf-8?B?Uml6QXQ3bXR3UWw5dU8zODJJSWpOdHNWa0x1WnloZFpzMTJzVUtPMnkvZkZa?=
 =?utf-8?B?QzNTeXFFM2I0RTZ1U1RLQUZ5eHVINHMxNEZmdUUxMHZOVDQvTXp1Mk1WZ2Vl?=
 =?utf-8?B?MkZKNVNsd01keHJzamR3OW10eG51Y0lXbWRLN3BmWGlRRkpkc1NuN2NjQ2dC?=
 =?utf-8?B?Zmp6Z0dPeWpjRWM1ODlSWUFScnlnUGFXbXlBalVkekxHaUJDdFNmZnJzdk5t?=
 =?utf-8?B?SEVwbEx2VlRDbFJXdmJkUUVTTGw1QzdUZld3TTRRalF2M05RTGVPdExQZEdH?=
 =?utf-8?B?dkRsdUl3RWJMMDNMaFdKS09WZTJWblhQdVNiTWdQMEFwNG5kUXBKeFNUWnlO?=
 =?utf-8?B?cmJuU3p1UVg0ZmhHTXp2SDljcUY5QzdCVko1d2Y1ckNMWUtjRzdmWkcvRnAw?=
 =?utf-8?B?cFhPM2Iwamg1OUFmMTBJbTVGditLaDd5NE8wS3VlRHBLeXVUelZaVFllNVg2?=
 =?utf-8?B?V2NzcWJSNlpIUW9kWi9zMXNyVUFkWW5pY25zODNLaTlBV2VQNExsT1o1NCtZ?=
 =?utf-8?B?YklhdEVuL2RTRS9XMHQvVHV3eG9YejdBRFhSYjI4dWdVTVA0QzYxcHNRelRk?=
 =?utf-8?B?TmNzdzA3VlI1NGoxYWFVUGYzRlZyWWVUVnBTSU9kSFp5Z2JlZDRiVTRSaWk5?=
 =?utf-8?B?Zk1OdFlRMy9NN3RXcWJ1bC95Vi9Na2twaXlUWWRHbHErNHc5RTc1ZXMvT0Rj?=
 =?utf-8?B?b1JFejZFazR2SHpTTWVKcm03ZmVGZmJkTFpPZzRwaWQ3S25ERHR1eGFMMXNY?=
 =?utf-8?B?akU3Yis4SG1QTTh6dDNpS2ZDSjB4L2RvMnhkbUlTWkdsNlVvM3Nydm5vd3I3?=
 =?utf-8?B?SThhci9rY3R4TU5pZ1VlUjZoS0N1ekhtQ1VrVGR1UWpTSWNQZnc4c1ZNcDV0?=
 =?utf-8?B?RWllZmVrVUxvZlkyZU5zeHVUdi85eXdUMGZSTUdJMkM1ZVEwTURlRGw4QkpO?=
 =?utf-8?B?dk1uMTlCSnptaXEvY2VDL1h0MWRoamkxNzk5MUZGaWNENTJ1T0o5ajk0Q3pr?=
 =?utf-8?Q?Y/50OwH5Pnonb9aXSOvqiUAuT/+C0N6j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVJVFRYTkVGN21sK2oyek9lUExVZUQ2cVo4bUZyRUlzNFEwRms0NE9GRDhT?=
 =?utf-8?B?UFFDSWFxdzJuSEdrbkFpdC9VaTBubk9BMXk1RC9iUjliOWdqekFvOG03bUlD?=
 =?utf-8?B?SXZaQWJmUHdUdnI3cTJ2dWRlN3l1eWwySkY1MG10aEN4R05GTVplR2dIYmJx?=
 =?utf-8?B?TGNwdk44aTlDMlVOK2pRTnZ0R0owSkQ2TldNaXdUaFgyc1RCR2hrWWhzNnV3?=
 =?utf-8?B?NndpMnRaNGtRK2dGM1RVbnhDUHlvYXFmT3hrdU9NUEJ4N01wbkQ2cE10QjMw?=
 =?utf-8?B?M2lNMjdUOEduN3J3cjVlR3ZGYy9jbWxyam9vSHFBUUcxY2h2dEsxR3FLelR2?=
 =?utf-8?B?S0V2S29XL0l0QTRMWWUvbjl6YVNMYzBrVGlrY1J4cGNxejYxeFJtZ3lrWVdU?=
 =?utf-8?B?S3ExYkpsZlIyQnFjUDRJYlB4dXhCczQwbFBWd2RtSG5Fc0N4azgxc01nakEw?=
 =?utf-8?B?VE0zVXcyMXBDVmlPeEJJMC9mZDc1TFdxc1B0dnhmWC9HK2tINHc3VUF1U1Y1?=
 =?utf-8?B?ait1STduZDh3UGFhNkZKSm9YWGtyc0prVG4vZ3Bjd2gxVVZWUjZ3WEJKMFZi?=
 =?utf-8?B?VjFRM3FEZktwakh1a0crQjh5cHo5cUZFYkpGZlhHNFlBTE9SZm5vYnJSY2Zu?=
 =?utf-8?B?U0EvTHMzMUJ5Wm4vSEtCc0NtdWR1bnpKN1FycEdUYUkydDZmSkNWYkl4UWVq?=
 =?utf-8?B?MFU4NGlXZzdVZlFBRFJQb1JEeTFnd3RlYm5RaE5JOXZiZWZLUncydGZWdzdz?=
 =?utf-8?B?WXFrdjZPTDNHL3BFc2dZcTgwaXdOd2NKbzVIUjRHcEZWTkhDSzFSODdQUjBG?=
 =?utf-8?B?UmFPUWFjK0xCTzBnSTJzWlpDcmkxUy9Iak9seHFhT3ZwVWRpV1FlTGxDU3Yx?=
 =?utf-8?B?VVoxQ2JrYUtua2tqQk5lYnl3M3RUczNmWi8vSi9qSmJrQitsLytid3hFNDcx?=
 =?utf-8?B?V3RDbUxiMDd4SG0rcU44Z1V0UHlsTG1keTJrL0lJR3JySGdTL1ozQ0JOZUtC?=
 =?utf-8?B?TzlRdm1JbDJnaDFnUC9uYjNTN0cwZjNBb2VzYVlyOVM3cStvbXNWb21abzVx?=
 =?utf-8?B?cVYrYnVLcTcwVE5QS2xCZ1hPRlFXUXo0dFp5cDhBTmZnY1gvY2ZzM2llSWQr?=
 =?utf-8?B?YWdPRUplWTRKK0M2YzcxekZTMHlDaTRSYm11cThtQzZJUWgyaTZZVU9abm5v?=
 =?utf-8?B?YTJ6bjN4MURNRTY4bmM4eHVlK3ZSV21sVnhFVTRlcVJxUjlCUDZFWGtZU2tH?=
 =?utf-8?B?NlBmRGxKL0tIWTNkU2dUbEVnZWVLN2dud0Y3bGl0SmJ0eTVKYmJoWE1ydjlo?=
 =?utf-8?B?TlE3c3RIMkR5V1JtS3l1V29CRGdyK1M2Um1naE9rc05HRXdzU1VlM0ZsekJN?=
 =?utf-8?B?VE1rVjRDRXJpU1c2NjJTbVpNYzJlRkNVQ280cHhNcGl6NHVnMGJyN1FXNnRy?=
 =?utf-8?B?ekNWRDdtZnZyaXR4V2pOZGMyNjlQaTRPamFRV0pBWG5yUGJKazRtRWJGc0Vi?=
 =?utf-8?B?YkVxUDBUbXdLYXNFbnJmUGZLWlZXQXJlbWthdkxsbnlic1JGQUNZcWlQM2tI?=
 =?utf-8?B?VnQ1dVc3NGJGdVZPMXY1c0xtb3U5NEUrclA1MU5QRS9wamw5Vlp5allCMFo0?=
 =?utf-8?B?c3Ivajc3cHIxTmFTVW5MeHN3Y1IzSG13SzIrT0IwSVhLRm54bDBaK3FYMUZv?=
 =?utf-8?B?dTBpQXVSSWl5TlJoencyNFp5OGlKQmgvTGxDSUJjZDdlUVpIcmd4cU9vVytO?=
 =?utf-8?B?Ty9yZWdvWnBWYndlTWMzdlFnNjRFMXEvNCtVbVpGa1REVTNYTUI4eEhCN3RE?=
 =?utf-8?B?MDJoUTcwamY0QXcvYkFYWExGb2NCa00vV1RlcGdFaDVxYXBhZnRhYm82K05C?=
 =?utf-8?B?MjVkaXZkaHR0TXJNZ3FPaVZjNy9obFRlK3JrOExyZmZiL1RGbVVrbVBIQ1lF?=
 =?utf-8?B?SjBNWno5ZGM2WWFPazM5ZThLQ09rWE96MTNiWXZ1MXZWN1pxUUFEc3daSDJJ?=
 =?utf-8?B?NDArQTBzOEpOTjFvQW9wUVFYUGVTTnJncWFrTnNzWHQ5R3BjL2RuZmFxVnNU?=
 =?utf-8?B?YUNPTmU5dTBvYW5RY004UFBRVUJ3OGFjbEtrRTZTVEJ1ZVNDeTc1WWYvamNG?=
 =?utf-8?B?WmxzWkgvakd1V1BCN1BPYWxJaFJEZzU4Ykp6VnVjMEllcTVmZ2Y4SHlqdk1Z?=
 =?utf-8?B?a0pkUnFoQUVtanZHRUo4dnZxZ01NRDZiU250YTdDcFpCT0hyTDRDaGtaZnUv?=
 =?utf-8?B?Mm9zYXhlWWRNM1Fob1FaUk05UUY1b1J5QVJ1bGZRUW03QjVRSGdjcWtvZGs1?=
 =?utf-8?B?L1dmcCtnNGZtWnlMMkg4c3pBaHBBdjI4OEU4SXBmNjNIZ29qY0tGZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53717027-3371-482f-a973-08de51f3dda7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:01:37.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcyy+gFFK1u5yElpkw6YJ40/IQ6FvKZTuRMUXeuYwxVrSUbyfIQLmcm8zpkzEwO0BlQnY5Evnw4DEFzSIg+7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5146

Forgot to comment on the second part.

On 12.01.26 16:51, Jan Kiszka wrote:
> On 12.01.26 15:27, Florian Bezdeka wrote:
>> On Fri, 2026-01-09 at 15:52 +0100, Jan Kiszka wrote:
>>> On 09.01.26 15:42, Florian Bezdeka wrote:
>>>>
>>>> I'm also unsure if we should really move that logic into the xenomai-
>>>> images project. Seems a bit overloaded already. Maybe it's time for a
>>>> xenomai-ci project?
>>>>
>>>
>>> xenomai-image is so far the project driving the main pipeline that also
>>> does on-device testing. But there is also CI in xenomai3, e.g. A
>>> separate "xenomai-ci" project would sound to me like all CI is handled
>>> there - would that be your vision?
>>
>> To me the purpose of xenomai-images could be split-ed into two parts:
>>
>> a) Build reference images. Images that get you to a working starting
>> point within seconds.
>>
>> b) CI. Build all the kernel/arch/userland combinations that we need.
>>
>> The b) part is getting more and more complicated, which might confuse
>> users - especially beginners. We have a lot of bitbake and gitlab-ci
>> magic. At some point it might make sense to split those different
>> purposes into different projects. 
>>

I would agree - if changes to the CI infrastructure would make the usage
of xenomai-images as, well, image generator more complicated. But I'm
not yet seeing this, maybe you can point out some examples.

At the same time, if we removed all CI from xenomai-images and xenomai,
how would that make the (granted) complex CI setup simpler?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

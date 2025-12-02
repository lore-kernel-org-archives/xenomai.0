Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB525D208
	for <xenomai@lists.linux.dev>; Tue,  2 Dec 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667091; cv=fail; b=YWBFuN5Y6P5TMSAj9NCFVUhxKdwGbbyX+GdcUd8qe+SU9bpA4k2nQEBoSjrSiC+x7FyowtWl/EZj/9rOQqveyVspdUSqYFbL1Bm7jZ6kR4gg+dZ5zQKT6Ci55Eb9QYoPVLklUh80XvY1x9I6sA8Yu5C+9O3m2yvKWGbEzUHHz1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667091; c=relaxed/simple;
	bh=4T5m133MjM/zAhyU9JW/LRBzY6MF+TfnmoEKionOqKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nF6i0TsHmvBDCu3P/VwxLfORnPUDe7Xi9wGoi6UlyJIh9fiErSVgQRLpSpnRLIjMLvaOtpUNXinni7xm3AgjlMpKab3xhhloHhOCcrm2w796VA88vSQwHFDEEtG9Z+hawScbZwm1AVHhXtPERZdZdhrAbH1G3JrAkteQu5+KigY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M0LuuEkl; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M0LuuEkl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBtIngo4XLR31gXtMiBE3ULcdxtpuayinzjMm+7tKmI2znhSLqK6tpnBpKJFfPUjRcV41eJlsuxGWNxDWHqprjcvrDRcRvVq6cM4EeWHmA+A5s4U++dByKSBT8BIRxTlpikow7MjeVTqzqmM/Xf/hunHhGvp5huMd0IRrP0SIdgjR2VoV0+209IppSHs1G7EDxuxyzCBNDH5NLRvR1+AgJv1yMQqIHsHF+R4cKNO5K5xy3Fb/WFIpw56C7ov9AjYTp+mOnSGsBAijrmyQRkb2D32y5Mm+pNcj4u0ssZ3RacjZCqEx3iQ81wJU87b4/z2M32E85wsVIwC7dAbeMuHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dq9Ubtagd0cNyF92GzVBJGliepmff6wI4g7LcSSMfA=;
 b=iwcnq5J824t+Pocc8a8r21u2EtL7K7ZET4cwwMCnxVw64W5RvHTCYUPzWd2709U41xjqF5kordbgt83NMonQ4J0fX8erZKr2ecbutEBCE+nnQm9HaTh3ks44/YS5i7MpockXboio1EUE2LQF6nQlCXXUfVGR1epp0K9tIDtS2a1VguWGaZikM+fCyQQi61KSx2WYzWLVtKS8UYUS2mznLK81RSHQa6tW+tBNlf6P65CmfLD9MaLy/ervKjhlMz5JK9wAXsg2DzKxmsv/Hf2pIvlpN16yde1/SGS4oLepMPIuCVr4VIeMMsM9z22CwIrCBuBctjaVUuc1wvFYtzosMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dq9Ubtagd0cNyF92GzVBJGliepmff6wI4g7LcSSMfA=;
 b=M0LuuEklGDb66rZf6K8/FeUX9V1IuHPrV8/Q+Ue5II7scLE4Cw919Q2LE1nVjShDk4A0vbwSlStpbtKU+cv/xNNQJo5hpAZMBauN+xTgilkjgxHMILwMezkQiEiXd/7Z29R5WqBHUwyZ5HrJsIwp92aKx0rMBtf+ChzWk3FeT/4DcrfKyeefmqpPXTS/Wj6EznLc46fm4qaTDztxfp9RlEc8uZXFeYXFJjmECoHhWDoBcJBUgTV6lVBQJG1tjZEFMQuOlLyL0iK+B0ZEgmG5yb+xHJ5JR00SS0p65MKauwGjXOyY8QOG3EHwYKDQnFekPiHnjTqlzwrCCxpgP+s0kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3980.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:18:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:18:06 +0000
Message-ID: <e01fc968-0ed4-4eb3-8839-1e125c259440@siemens.com>
Date: Tue, 2 Dec 2025 10:18:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3980:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6113fd-8030-42ab-94e4-08de3183b3b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FBbmoxZTlPTERsd3B0L3JLTVBSNDV3S0w4OUxmTWJ2eHVEZWgxRUlaUVpn?=
 =?utf-8?B?dTZUb1k1U1RrYkJkTGxvMGJxcDFKdXp4dWRXQWtBdVNUOW5BSVNXbDgreWZU?=
 =?utf-8?B?V3FHQVg2dVJGSWpMOHRtL2lWTm1YU21CRFZkbEwrY1dIYkM1TUZqMTF1VXda?=
 =?utf-8?B?amhWMlVtU09aKzEwMmRwdkVRUW93a2tTdmdCbCtyeWcwWnovM0RFM3B4V29E?=
 =?utf-8?B?MmtCZjEwWUhxL1l0RkZsK3dFbFZQV2Z1NEpKYU40TWtQbG1rVjVSQXp2TXYz?=
 =?utf-8?B?S2ozbjFjSDRianNFd0JFTjBvRFZZZTNMZTllZjh5cFhCaU5Lc3ZJSnBBTmtK?=
 =?utf-8?B?Wm8xSjFuNXRtbC9QdzVOQ0wwUWxDL1FXNzZTYVh6ZUc3amtVYWtMalZ5RXhR?=
 =?utf-8?B?KzdRWHh2c2hIeW5Xdm0yL09ZeHRnRUk4SFA5ZUV5cUs1TG9WckVSblB1ZWdM?=
 =?utf-8?B?Vm03NER5Vnppcm43NnpZWjEwZGZNcUkrK1BwTXk3NmFKNEkyQmlWTUcvSzkv?=
 =?utf-8?B?Uk43SUJXTU8yNVBkOWpVTlpRWGl6M0JnWVVxcFNOMjlzNFBxSjYrV3duS3RJ?=
 =?utf-8?B?N3ZsN0ZGNnRTcCtDb2haTFpja1dJWGRlSkQrY1NJR2JTWW1ONVNLdm81YkRp?=
 =?utf-8?B?ZVFrUDhCcDlPQ2l4Zy95UUZkRG8wcWlYdGxTVDRlNWREejhVVE8wV3ltVlhD?=
 =?utf-8?B?emd5VHFMYTdzL1lBanNTMmEwOFh3cHdMa0dVWE1lb3hmUkVLSGk0TnRpV2hp?=
 =?utf-8?B?dElQbTBFeW9XdktZUDBGNEdpMlN1aG1ocTJWdVc5SnhmclpsMWNJNElsRTFG?=
 =?utf-8?B?dUFZcXdHOG10eTBhM0dSRGxMY3IxaDZqWUlpTHErN2ZuVVRYMWd0aDF2M1cw?=
 =?utf-8?B?NjRaci8zbUVuL0FJK2RGQlVSMlRraGNJSWlRZW9HQmttSHBGYVF3ZHBpc09l?=
 =?utf-8?B?YW5vS2oxSzVNdzJBNllQZlR6U29VMVBhelJqNU1NY0NxdWEwVndPRkZ4c3pi?=
 =?utf-8?B?TW4xcWNNb0x0bU1HWDNVZVYzbDZGMHBWV0FCQ3dQL1AvdjRQOUpJQk8wR21x?=
 =?utf-8?B?bERQWUNlNmttd1BRa3IvblJ6RzBwLytEUHQ4dlZCT2xPRzNLUGVnSVk0bmUv?=
 =?utf-8?B?QXowOGpoQ0Z6MGtzNXF4b21BenNMKysyQ1JmTlZxWGkvb25vVGdEclptVDlK?=
 =?utf-8?B?MzljVGhDUXU4RFQ0a2V0Sk81UjhkVCtpYmdDTU9nQkwxUFBweHJwWVQ4UTBD?=
 =?utf-8?B?dnVQcHhxWWR1V2ZaaldWZmwrbEN0N3A1Y25ra0h1UGZHajJ3WTNXL29yWUs3?=
 =?utf-8?B?SGp3K1lTNENKWlNETnpHc2E1WUc2T1AwSVlpcCt5TytkNlVuNXIyM1B1eW1z?=
 =?utf-8?B?aUd5N2xNVExkT25mQk01SHhYejFFUXVpVXg4UEZnYjlickNwN2ROYTV6REw0?=
 =?utf-8?B?VkREb0tEbnIwYThrdXNRSVJON3dEbU1FaUI0aUlRdTM1RWNmNXFwUGtxWGJq?=
 =?utf-8?B?bllaSXk0eHRqUzNvQ3dqQmk4NW1HZjY0SzhXMXM5dERVZXFKOE9FZXRrdGZw?=
 =?utf-8?B?eDJJUDB3cmlOcitBc2UycGRjK3JYclJ0dGVlcXdKaTYxam5hekNobWJHZTd6?=
 =?utf-8?B?RTI0bkFjNnhST1NGYm9YTFF4N05UdkFkNWQ1NGZWek5iVGQ1Q0Evenh6eEhW?=
 =?utf-8?B?b2ZaUGVaYWpWNjhvTEQyQjJDYTU1MVAyakIySmlPdDlOakVPQk0zOEFZMHhi?=
 =?utf-8?B?cjJMejFuRkZwdHAwZHFFNmsrQmh1UmF3MGszSmNnWDE4VU04Q2g3SEg2L3lr?=
 =?utf-8?B?SDkwOUwrS1ZQdmdKZVVPN2l3MmVqcEtrK29JVkI1NWNtMnJXOEk5U2cyQ2FJ?=
 =?utf-8?B?bVNibFR4STRLMmExTHNmWjhSNVhJNlptbnpwMmc2RW4vRFpiVzVPa1NKL3Ir?=
 =?utf-8?Q?FQVbsSBaTiWEsUEGjsS6u8ZcPRTsE5jk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkd3RmZxWGVEK3c4alg3VHJrUEFvN3BpUjlkcElaRGxKd1Vyb2JERVZJRkF6?=
 =?utf-8?B?SHVURFlka1M3eVpZRU81TDBsT1RuTHdmWWZ5SHRzQmtkQmFzaG5xOXN3dW5Q?=
 =?utf-8?B?cUZ4R3FLTjJRY0hQaHowZmZRWlVuNUNKV0UxaUhQclJBRmRDendWU0JJTFgy?=
 =?utf-8?B?NU9mL1BlNnN4Ukh5VzhyMk9TZHRaV1hZL1A0ZFVFUE9PSHJhbVNoV2ppd09u?=
 =?utf-8?B?bnNvQUtXUnc4ZjBpYTFLV0o2UUxVMWRBTURFYi9OUVByWWRGTmFNN09oUEpV?=
 =?utf-8?B?aTREYk8xdVpBcllIZXUxWGNITTVVK2lrUkp2b0VQZEtmR0NJTGpBeGZlTERy?=
 =?utf-8?B?SFgzU1NuMHBBaUhBUjF4b2ZGQWZ1UDhnN2ZieGtOVmdLMDhiaCtLdnFPRk5l?=
 =?utf-8?B?UUh5NVRiQ3RnVDI0bHZkU3VvZ3FEenJGZHc0cERzM1VIK2dlOE5YSkdpbWVQ?=
 =?utf-8?B?dGtMSnk1bHZpQS9wc0JNMENSVWFMczhyYjF3WFd2bnVYYndvMlRQclkrRDZC?=
 =?utf-8?B?akxZbkhsRmtrTUxGZGk0RmRxK2RqRVduaWRrMEhrMmJoa2pFYkRPSHNLMXdE?=
 =?utf-8?B?a3EzRVVDUlIxdUhCeG9tYWwrajFSV3ZybXhISS9FbjY1aDdzM1VhbjBYNUdp?=
 =?utf-8?B?Z2RuSm5nb1ZWbFpoMDd2RkZCd3pHTitZUUVsMHY0WWFkblVmWHduOFp5NHpO?=
 =?utf-8?B?NEpEV2o4TEFnREh6M2FvaU1yTHpvdGQwMDM2cjBYRnNpZXRLMjAwdEpWZFZJ?=
 =?utf-8?B?Q2dOSUk3eHF5UzlYVHpXZmpwUWtLcmNBd2lMdmcvWXgxeFFMejRNcE1icXps?=
 =?utf-8?B?VTdqS05UN1R4Mjc0c2tSVS9JYWJtWnlqdFFiWlhDOVVTTmN5Q2Q0MDU5akgx?=
 =?utf-8?B?R3hGUzYwUVdaNUt5R1dWd0oyVWdHMFIxNzNIeDBiRWdrdE1LT1FqSncxMVlr?=
 =?utf-8?B?RHY2bGs1UElVVUxoUVFpbVducUFXd1Zvc05rZVljbUwwazU4b0I3bzJKV2Ny?=
 =?utf-8?B?L3lKZmdXTWdUSGRIb3FsZ1NoYkt6UndSaUNZNDQ3QWJtbjhid0Y2WlpKZmFa?=
 =?utf-8?B?T1NJZGZCUkZvUWptV25PbHJRRDBpUFkwQUlkM2c3K1ArOGE1cEVoYjl1cXJ0?=
 =?utf-8?B?bFJRd0VOSUhQRVhVWlYyWkcrc25NNlJEamhuMUU2SmFBMldzMHYyWTlHMVZo?=
 =?utf-8?B?NWY2dTZXUDkzQ3U4V2lnalBJZ1hqUWFZMjI5a0lhbkd2Q2Z1M3pIVTZybENy?=
 =?utf-8?B?ck9qSjNpUlBNcTBoWlRoM1pOWGM0L0lucE5MQTBQOEVmdlBPWlZmVHprNFF5?=
 =?utf-8?B?S2lFTFY0UFRqclZnVjUrVisvS0FiTnNWbktSMUFnTTBVcmZyT3hYWm5ZaTZy?=
 =?utf-8?B?SWZkdmZFZFRUVW9KZnZjTVJCSzhiL1JPZVRXcCtERG9tREdKdGtscVlXWXJp?=
 =?utf-8?B?TzJqSGN0WHRxNzZiSGFBS2ZwRVhOWTBkN3oza1hacHRxQ2ZrSmk5bDBoMnBp?=
 =?utf-8?B?OUJQKzY3Nk9oUDFWSmdkY0szanlndXBiZ3IwV2xWSEJRQm1INXRkRE52d0d0?=
 =?utf-8?B?cW5DM0JOTWtXdHpUVWQwT29GTHZkS3ZJWDRxNHYzM1UzNlJZZ2tCOXJKN08w?=
 =?utf-8?B?SC9qOE5jUkt6V1dQQ1hsaE5oOHh1YjYrNXNTRVZ2ZG5zd1BJN1Z1M0ZJUWxv?=
 =?utf-8?B?S3p1cm5JWjEzZ3huWlpvMUF3azliMVJzdWlScEVJM2pnN05VeTV2QkRFSVJ1?=
 =?utf-8?B?UWRsYTdaZURRQ1p3MFRvWlZzN3FpbjU4TDk1V3FrNWxCOG9kK1o4NEZDTERE?=
 =?utf-8?B?V3oyQTdZTUE3NWpYWlZDVlRBZWNCZ0dLUnNERkQvZGZCLytST1JlUjU4V0VP?=
 =?utf-8?B?VHRDNUd3a1NoM0VWNnFFWVd5TVVycWtWWG93R2p6VVM0MDlBUm5rci9LRzRh?=
 =?utf-8?B?Tm5yM3hSYWNxdGx4YzlyeklnbGMrUi9XdkJzL1h4dGN4dENQUEpUdUlpRk1L?=
 =?utf-8?B?bnA2NTVxL1F0NmJENGJDcHNZNGl2T3RROFhDUW9Yd0xSSWhmWnlKNGxsN21x?=
 =?utf-8?B?N1RuMUdXb0JTcW1DeDFhd1N3djZJc2VBYmlXMmJpaUhkczRlUjREYU4wTDRP?=
 =?utf-8?B?SnJFMWZMcTZnSlE2UXhmQ2V2RWNOeG9GZm14L1g5cWx4c1VhMzkvbmgvVHJP?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6113fd-8030-42ab-94e4-08de3183b3b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:18:06.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2YpPgvKFC/F6F8yK6+4jwwgtIvhrSenA8hDHpSW5fERJ2Yxvxaau+sPdNvZ7VZCjGIC/2Z1JrqrY1vpJlcWUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3980

On 02.12.25 09:56, Mauro S wrote:
> 
> 
> On 11/26/25 12:50, Mauro S wrote:
>> On 11/25/25 17:51, Jan Kiszka wrote:
>>> On 25.11.25 16:10, Mauro S wrote:
>>>>
>>>>
>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>> nasty.
>>>>>>
>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>>> Target image and toolchain generated by Yocto.
>>>>>>
>>>>>> Please find attached test case code.
>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>> tasks
>>>>>> that immediately suspend theirselves. After starting tasks, the main
>>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>>> Terminated tasks are joined by another task, that was launched at the
>>>>>> beginning of the program execution.
>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>> joined
>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>
>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>> task is
>>>>>> resumed.
>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>> the same
>>>>>> of the terminated but not yet joined task 0) has been resumed when
>>>>>> the
>>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>> resources
>>>>>> should not be usable until join is done (at least this is what I
>>>>>> understand by documentation). I expect that calling
>>>>>> rt_task_resume() on
>>>>>> a terminated-but-not-yet-joined joinable task should return an error,
>>>>>> not resume another task. Am I wrong?
>>>>>>
>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>>>>> problem obviously does not happen, but as I said I expect an error
>>>>>> instead of a wrong resume.
>>>>>>
>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>> problem
>>>>>> on your side. When the test detects a wrong resume, program
>>>>>> terminates
>>>>>> automatically.
>>>>>>
>>>>>
>>>>> Can you rule out data races on the shared TaskList structure? Seems
>>>>> both
>>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>>> concurrently and/or unordered. Or does this also trigger in a uni-core
>>>>> setup?
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> attached the modified code: each access to a TaskList element is now
>>>> protected with a semaphore (one semaphore each element).
>>>> Strange behavior happens anyway.
>>>>
>>>
>>> ...would have been too easy. Ok, will try the other day if I can
>>> reproduce and maybe even understand.
>>>
>>
>> Hi Jan,
>>
>> sorry, I should me more verbose in my response.
>> First of all: no pressure, take your time.
>>
>> Then, a more deep explanation.
>> I added semaphores to avoid possible concurrent access on TaskList
>> elements, but I already verified that code should access them in an
>> ordered way without concurrency, thanks to "joined", "started" and
>> "exited" flags.
>> In detail, TaskList elements are accessed:
>>
>> - by main task
>>    - under task creation, writing task handler and "joined" flag: this
>> happens only if task was joined before
>>    - to resume task, reading some elements ("started", "joined" and
>> task handler) and writing "resumed" flag before resuming the task.
>> Here, "started" must be 1 and "joined" must be 0, this can happen only
>> after task creation and start
>>
>> - by sub-tasks ourselves: during their execution. Variables written:
>> "started" (at the beginning of the task) and "exited" (just before
>> termination, after task is resumed and did its sleep). Also, verifies
>> "resumed" flag when got resumed, to check if resume request was for it
>>
>> - by join task: this happens only if task is "started", "exited" and
>> not "joined". This can happen only after a complete subtask execution
>> task resets all flags and sets "joined" to 1
>>
>> Printf sequence seems to confirm that execution order is OK.
>>
>>
>>> If you would like to understand a bit more already, you could catch an
>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
>>> study the task interaction (trace-cmd report / kernelshark).
>>>
>>
>> I'll do the setup to trace events (I don't have trace-cmd on target, I
>> need to setup a qemu image with it).
>>
>> Thanks in advance, regards
>>
>> Mauro
>>
>>> Jan
>>>
>>
> Hi Jan,
> 
> I made a sequential version of the test application: instead of having a
> join task, join call was done by the main task, one subtask at time.
> With this code, tasks does not access concurrently to variables.
> Problem happens also with this code.
> 

Thanks for this. Still need to look into it - ETOOMANYOTHERBUGS ;)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

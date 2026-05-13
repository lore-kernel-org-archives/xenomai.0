Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950F34A3BC
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683610; cv=fail; b=MBFDAQWotp/n+uUQE7uNVo+dFbQTKZnjV85B65TOaujv4thAmPa7H23Vwok38BjWp3jxOFXbj36JkLjdvklX0PWtOgt5t28faTTG9SFtaGHydd3jkFL7FG8wkeC4Qoliwc/pQZEM3BalNykJzWwUq+p5cARspQJAAtBOgFGAE0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683610; c=relaxed/simple;
	bh=+2ltwjqAGvEXBJAl5unpEgfgAmZ2T0NaPNGh35sQqN4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BssxOyw5yWFeiNYZwHf8AsxV1YtzsfqCJaYxRH0TKxYetax2j1Dsp+vK3IJLfXuQSUNXGorUAkU9wgFFZ8OsLhn+phJ00RgWF36sAfY8D3IPCvRKd+i8mz8Nmqi+ElLF9An9IHWxsSyL2wyLhOH33WLVyWEWWcqi/YmW3wPA48c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k6CLNYTt; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k6CLNYTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMnnnrY1XoglaBkDPWZNvfcBqaTKMdr2bdLbjJq0CxLGNKVoarqJB3Xp/9pTYwKMPkkrryHigVd7+t8orv96UEGYwVHGOu6e0rocD8EwDt1kT2rzJBafQDzCY7RgeckLxk9q3HrJcjieNyjOjdqOT7F3x/sz9O0FpeleEtPjwTw541+yfLChIwY3Dztw904XCGx3y18RQwjW1HKuTMLlQl3wfbaiiThMNfEQgJnySKrBUTzHqHGHTL2cMVivdBda+qoECe23s6p5SLSnq4qXkIF8iP1KBvXubQ59JPG/y+pyeKqnW1cY863b2yhUHtBgLPI9qJR3ifQfsz0khY4uYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olCU/LPRkxE1uF4IldMdXOcvP7RgzIPS1pLJDiA4iMk=;
 b=qna7Vxg84kWbA5rFywlYMY95ftzzmszbUPSC/KG9l/AuKALIr7m/fJO7/JY2/LPiHjB5GK1jDTC/OERNGgfP2GWCs5UXRBvyBrqyZoG8sc1zBhd7ToQ3fIFM+ncYoTe6wwx+D+3goa5cXYbxeFePqlpCjvUsULz1p9tqlzwz6+9x/KN8ofoaQq4cTEUtqlBB/a3MWxbi+3SEb98j2pAgMBLVWzSUH1f2IyWB4sSs51BCJmEmHvUpULVpZVHOm2ZThnPklnvZ4JMnFTCzXIT20lmQE8JSQv8eO1GoI86J/L0uz8aHLhg6etsxbcl9P3QZhaNdMND+yZcUj/U+jZqbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olCU/LPRkxE1uF4IldMdXOcvP7RgzIPS1pLJDiA4iMk=;
 b=k6CLNYTt401+IgfNS3PrL/2oy45YJARmJEhOjTjCZy0DX3s7ylVmSJjAAU5POI0YeWkVL7UnVk/iyZGpx1IIIWxTgopC+QUEXdzNWUTe94bRAGJEgg37nFwAjzh4s0sw55KLkqo8AJ5E6/RLkmDfgAfAf/+FkzudLMJxD8aObFhTUzNNC9BZU0LHkbmB4VuUGdPsSS/PUg1gN245Ri/Udsdu3jwBJQSWHkqPYeyJPf6Ut9I1C+ls+b4KZK8EdGsEd6zgoQ+QQidzb2pB8Hf06juZYST5yQnXnrin+irBB+blS2iNAVv+o59N2uYThfYgmiuekIlvGOCg/1Vs7eUZ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 14:46:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:46:46 +0000
Message-ID: <91a94997-44ea-4685-b909-cf5df7729ad4@siemens.com>
Date: Wed, 13 May 2026 16:46:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
 <699a6f2a7dfa0b0f33f4d330fdebd7b2bd0f7e72.camel@siemens.com>
 <ad18a6c3-2040-40e1-b72f-23138e58f261@siemens.com>
 <d1413d87824e5febfaf54400e941ecbbcd1c61ee.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d1413d87824e5febfaf54400e941ecbbcd1c61ee.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:408:f8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc2f168-ffdb-4be6-f274-08deb0fe74bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	unS/naoev5JOcFrVZCPawPZI/V4bd8bRi9guGUNZXUVN/lhEod/V0zWZS4NUUJtXA9Ys5QsfDfApJQ2IS3DqR8JL3UQEYDmFqTvE6N8DYjfWeBzp6lwK+TStKnO/w+mUfqnFy8Vxf0ZMFuClx3mScnXllPbaROWdF2KlNI7LOOhatdsXY7d9sYM6ILexCjFT2lra0gE7XFtlDDpydPsy/MXvs4FJOOQVVh8sITuyjqaTC2h8SFseh1Quv3xMgpEA/lTn2d7BEu6noDQ3qpryF8qWvm+OCGRNww1fwQtipkzjAvA2uTCtQaRBXzHT3vptXOsxPtgQPTrPf5/1LCLSEh1WTPQ/++mhSCi8WoK71XXO0IQtM/QBu4SKvjSRveNaMd9LwwCwF1uVpJmBsA4dCKRuD+Gz+0wnX3SKLLoghZ9cAhOQdUXFo3dQWZON1fjPPtl94D7l0AkA6ujoCvyhcYWpBnSlGVU9IC4Gk22sDR0jjqyVicOtToKp3u7SLJDnwXGmcHHw/MfJW6AhvgtCZoxl9gihXOeS6ILmvoyWGKtmWb6Ly1ntxvbntuRJiqE0aSLjYq/Xi7d9tvRniOu53TxBs7DYQNE6Iv9ApykXz17K/oyw/adlR7ISXrwv+NuirsraVL0S/r85t0AoIQ7i9gItguApcw6/a8QsY+dLcdlGDlDmQyyi+TaI3z0QLsm2Dcf9e+vDbNXgGhasP6bUtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJ1V3lBZnJma0NjK2tmelM1a1FHd3pla1BtNlRGaGtJeEt0LzJBeTBBZVNo?=
 =?utf-8?B?TmNnV0ZFbU1SV2trVHJ1aUp4LytDZFVma1lOdmR2cy80YnJlZlRJV00zd1Ji?=
 =?utf-8?B?RGNmU0xyalByUlVVR0dkNllYUlhWejF4a0xXWVlrTms5ek1qditwa3ZnOEJh?=
 =?utf-8?B?Y05zNTZFZnE4NS95RjBJUEtYcnpiL2Z3UEJtd3cyRlRoTkdBZDBkcHp0dnFk?=
 =?utf-8?B?OUhuQ1pUd3RuNkwwV1BDRmxldFhoTTdCNXkyWlFjVzIvd0tCRXBPd3VVb3J2?=
 =?utf-8?B?d1NEd3E1WDRsN2p5WXF5bEJsVkFrWW9rdTB0clB5bTAxdmQ5YUFXOWxGUGtm?=
 =?utf-8?B?RzZwTlNYNGRyRm5ZWXlLOThERkdESm5yeTkzNGFLd3ZRL2pTRzk3RHBKQlFz?=
 =?utf-8?B?T29NNzhqZlByNDVMaTRibENldTQ0TjFINVhKc1pnVVNJSm9tWVlwQVpKMzJW?=
 =?utf-8?B?bC9IbE01TGh2RGFiQ0NTYjBXTFZsUEZQTnFsanhZN052elhwNjRSK3ZIRGJu?=
 =?utf-8?B?RjZ0M1BOVGg4VWNBM0Vva3c1NGROcXJyTXd2cy9hdnJSbDZIeS9WYVA1WUJD?=
 =?utf-8?B?M3ZCUS9TMjdaaEpLUXFOSTZqREtvTkY5SWZpTkdkekg4M29OMGtTQVZja2l3?=
 =?utf-8?B?VW1QQUErUXdLL1YwWFpCaTgyVjBaM2UrTkZzOVk5OWFURDUrcnl3VTFUYkN1?=
 =?utf-8?B?SEZGN0tQeW5NM0YyM2lIQVlsTlRORzBjdmhidEx3MnprUnBnUjJOZmI2aFla?=
 =?utf-8?B?RTZSeVBIbXNpTEdZZThrSTZOZzE4VlBVQ1Z1Rm8rN014TEgrelQwbWYvOHVY?=
 =?utf-8?B?c1JLbTVwb0xtRWlscnRhNGYveFZDRTRLY01IWEtSRVBQdXVBckJ0OHdweHEv?=
 =?utf-8?B?MEhPdnI3dWpvTjFjRFlMY0RpKzc3SENVc0d2cHZTNUxvd0doN1lMck9Ea2NG?=
 =?utf-8?B?ZWVCZ2VaQzBRbVVOb0FCcC8vdGpjOVdCNTJsSHZDalpXQmtPaW16WnNBSW95?=
 =?utf-8?B?YTBnSDh2OUFjeE05OHhQWURhN0Q3dG9hd2tEREVqUFRjbGVEMTR5V3RQZzJa?=
 =?utf-8?B?MmtZWXRjcldIK1Noc2RUUkNtNlhLZ2hwWlpzaXpvVTV5RTJqNjRkNCtVREhP?=
 =?utf-8?B?QjNYOTAvR0I0amwzekI0a1BzY3dpWVVta0VFOEhJZ1dhUkN4TTg3VE1LVHZk?=
 =?utf-8?B?RnRMNnNETW90cUlKYXhYendNMmF2Ujl2MTZDUG5PMkh6ZjVtRUVjcXlOa0Fz?=
 =?utf-8?B?aEExdzczbFdSUVVIL0xraW1VdWZoYk5nQmRLZHRHNTd5ZThyT0NMcWhZamg0?=
 =?utf-8?B?SklVcFNLWUp3TXl0QUpoeGFOZ1ZobzZ2ZU9sNkJBQytvTFJjaWVMKzhmWi9K?=
 =?utf-8?B?b01ob2NQVHBFOHl6RDBrNkxDT0RsODBqVExWdGlyNWlVajVXemo5bVVjaEF3?=
 =?utf-8?B?UTFnYjJiOTlQOE54YzBNZWIxSlZOMEJkdVlUeWk2TlV6OEtPYTBKUkw2ajFt?=
 =?utf-8?B?ZnJFRmkxaDJhYVNDSG91RjVaNGNoMlVhZk1VQU1jWS9iaS9pK1hIUHhOdnhW?=
 =?utf-8?B?V2ZtUHM2WU5ZR2x6MGVsblBETlZxRE5yYy9IUTdldmZFS2VuQmZrQ2Y5M1dw?=
 =?utf-8?B?Q0NwSkEwd1FMQm9RSGxYMUpoQ09hZTVMTFFDQWpkUjltZjVBMFF5YmExNDE5?=
 =?utf-8?B?Z0FSOElDcUJVQ1hnaEtpNE13V3NucURlbGJHSlBoc3dkV0NsODFoR3lHb2tN?=
 =?utf-8?B?SUxlZ1JmYnYyRGVIbUgzWDFLYUMrMVdSTkhmb0w1ZEU4Rld6cHA4WDFhaE5X?=
 =?utf-8?B?UFF4b2s5RGpYOGxTZ1BwYndFWVFpQUtxK2xQU0JTS1NSSzFZeTNna204NWQ0?=
 =?utf-8?B?ajFvQXdURTBaaFppWmpUUXQ5QjZYdkJiYjZuZ2dLUHN1cFpBWUF3OTlBUUpD?=
 =?utf-8?B?cExQUk1BblJxUkl1UnFIazNRL0dhZnROblZEMG55cVZVUXFpUXQ1bWxMSTM5?=
 =?utf-8?B?TTRmVHBwTWptT2tiYzczOG43ZGJiaW5ZbEIzR2Z1U05kVnZXVUNkOFVPWWlX?=
 =?utf-8?B?MGRUUUk3aUg4WUhxSGtzWFZpdHZKdXVRQ1VJQjVBRnV1a1JGZFlvdURYc2p3?=
 =?utf-8?B?SlFPa0puMHhPUVpET0FUSHpoTjFBU1pGYmhocFNDV2MrZG1VMmpuNGd1WlV6?=
 =?utf-8?B?blp4d0N3c0Fnbm81MXlmalJSZ3B5czk3Vm1UeFFxV3BraG42TXVZYzZCSlY2?=
 =?utf-8?B?LzBiK0dEdDR2L1h0UGwrMlMyQVVPempDR0ZHTjdrelZUa3hyTUp5eGN2UFYw?=
 =?utf-8?B?b21iSE9BMzVrMjc0aHJZbzdJOEVkSXlVR0lwQVIzdUFkcExLeUZPQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc2f168-ffdb-4be6-f274-08deb0fe74bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:46:46.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ktfzw/aUZNRJ0rI2UQZbdpamjCHbcfVFhPLkYIO6S7FWg6hmmYCmL+AHgh5mdPhZTtWwxabke2q2aZJVEr3smA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3345

On 13.05.26 16:34, Florian Bezdeka wrote:
> On Wed, 2026-05-13 at 16:04 +0200, Jan Kiszka wrote:
>> On 13.05.26 15:52, Florian Bezdeka wrote:
>>> On Wed, 2026-05-13 at 15:46 +0200, Jan Kiszka wrote:
>>>> On 13.05.26 14:50, Florian Bezdeka wrote:
>>>>> Hi all,
>>>>>
>>>>> Trying to compile the codebase with gcc 16 revealed some minor issues /
>>>>> compile failures. Fixing them up was quite easy, so here we go.
>>>>
>>>> Is this gcc 16 generically, or are distro decisions involved here?
>>>> Primarily out of curiosity, but also to consider reproduction - did you
>>>> use Fedora or Debian forky?
>>>
>>> The build system triggering this issues was based on Fedora 44, which
>>> ships gcc 16.1.1 as default compiler. I'm not aware of any distro
>>> specific things here.
>>
>> Maybe try out gcc-16 from forky as well, just to permit more precise
>> motivation description.
> 
> forky doesn't ship gcc 16 (yet).

Not as default but as option (https://packages.debian.org/forky/gcc-16).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

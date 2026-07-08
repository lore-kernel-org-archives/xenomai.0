Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38701282F22
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487838; cv=fail; b=bRczKnbNFenDHw9Nr1+WK/6qlI/gkkRerhOo7ClOW1ixZiqTit7CAl75bC7rIZuDRxxh/KKiA8pkKEdxM3f45tty//X2FaTpiB1hFOGFqkoSK9TkKjxmBhpfdPWnhFHJv8yY6NbCq1TnSAykAekBGLuqjQQK4VYQeWmh7CccJio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487838; c=relaxed/simple;
	bh=KMA+6NMzjAXUYamDLOas3pqyYCCf+IyVpH10W+XqRXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MP5a+wdQjU5e1MHM9Y8A6z0O8rjOSuprJXQnztKI9dSSxTBZ+iNE6Kbo09N+PCutIy4V8o9Ekv0j3/HKiIxnWa738nUm2I8QRBw9Pl/ScGK9xoYpBOl6AGFuw848bpGEV7qjBaUMwn6VPPcPdC/E4Zr325PIXDypY8pu3W25yik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qoOQbm+V; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qoOQbm+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLqucs133Z48g01H+IYmhM3ompMYRen+J+0udrYB7jYYOnDZSKh6ToGtmPsVtiouWTA1prqHxLpio6isTsyJMU5necudyQPCnnoB1D4csynYBoEspMhd1AE17IG9JCkNC8Px/sWyafxjtqEf/T0EFT08EAlEPqnZeFYnnyuGtjJ5FB6C9hN9G2W2U076lPUjbLMJqF1EQrBIbAMjw9q2nRDcaYKmxcjwme3HuHxR7MXJycwnjzFKR+8lBvU97eSN7DD6kh20n3AZzieWkGQZ3flLGvYqmFcCBEHwwPJuQwAtqdiD8gfWL2thOoEM2IlgxTyPzYMPe2V0MnQLDmUmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dFWABrP7toJkH53/mhaZ78w+6GtEve7ZhOE9o0XD4w=;
 b=Rfc0qz9aqq3jJS5hm8VwF2E44/leOalUr/0e2Ljs6nQ2emOcHjKk7FnfUuYA8XQHIRbw/smIgQpd0LKmSjo0hjzyUT6nL4WvFqbSpyC6UmVZddNyPlh/3stv+90lb7W9QJAlQDQZP4AxaDu50x612u/T6gUYO4jzDPsRKtjqSBOQYmaOEOfNkuTutaAzuxbAnnEnijlak7AKSql+tu3n7wN6cCj2TPf7QL/XUupmSi2B1aFniSoibrmUxfgc/rm/L/pRp7jIYOfxmqI3RYxOLzeN0LuK9wEMSvf+WGxYyg0/tjOgIpvUock/htSAgYwThZ2c/5FgVWduADDJvOzh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dFWABrP7toJkH53/mhaZ78w+6GtEve7ZhOE9o0XD4w=;
 b=qoOQbm+VDdB6u8yobDfB5V74gVk2sivNdTmHLE15jXo1wW049/G4vLxCvqVVeCjloz21S9Qhp+lpy0iSyDiJE5/YnkE9f5zy3Mx9fknN2+MWZ5yaNzAxO9/9mh8cD1dZiQY3x6U3LdbNNtb3trGY/vTJKugrrvhOVNxuH4JEFymghnPsbfJ0ATlc8Y8NhR1TVPq4wlWuo+y3zC1ZrWJE2H3Vp2jhO0SfPP42rUdzBnmzlM2HqzeQFZUj+S1ganZ1m78QFJzB+sZraPDmGEY8UrDmtdZhKwefMDd3fFrbyJeKSNISlsdw3lIhZMziN8MOaYc1v6BcQ/CGaaplGtSdhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by BESPR10MB9268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Wed, 8 Jul
 2026 05:17:11 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 05:17:11 +0000
Message-ID: <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
Date: Wed, 8 Jul 2026 07:17:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|BESPR10MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf1a5ce-6342-439e-b86e-08dedcb02a51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|55112099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c7JzclO1PgppFOGUaH78Fr1ALR5U7LctxRzILlckfbenZAmKnXSlohh360V483H/h7Syz9HhPPs2tlh9LbshuxHSh0bNdoTNIkeuynjoTM3OXACMa091yEqfuBrUvAAT5Aw7625ZFDzE2K5DkY7Olj7tscpfI2U3DfnspKUIiUWSmUXRIPDatBQvgaq2CPXqw6v+bMgNcM+9UmrCOfxYPwD9qGvJ8zE+rUcoadr19JpfACeF+NVf9o3wwUwejz8VKqBsJGWJ+feAGvqZj38XT17PbWDhvJJmiRIbkzE7cn0W8Nyd+LuTQIUGEWQAc9ITPpifWZ4VaEkZAJJcduSSoJh31RK9yr05T0l0K0T8r7327SoDbRdopv8PvWhWF9W92ac8PZfEf5Z+OKhh/EXGyEqefiwLkS/IZyo6nZam5gx11+cONJXPtbtDp5afkLAuyiM8GBLA4AYEHrnrxt1ZCtRao1F3/OORwSiYft3jQfVb6Ewr9LbqRaKNHGi86jBnZ+7N553HASE3w3eg2nUeorqLdqK7qNisPDtUYoacDBNNBSYD0GM5+YMl6BKMam2jQbqMiWfb46ejSikiHA5t9wYa6SV06ffTqLJpZCWIzTRnJEdY7v+U7PLFsZOrEdu/edMfrclrY6mEEtejoyTgZIx3+tXS8cLlTUxsoU8yuGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0lmMEVmSXczUnVONFk4WnZTTitJcXNTUDdwYlY4VnEwZnZ3dXpJREZjZWN4?=
 =?utf-8?B?NVN4Q09sYmF1eDNBNXVoQ3ZkQ3N0MCtpVjM2aEhSOEsvZnZKRXpGR01MenRZ?=
 =?utf-8?B?dGh5NkFSZEEyRlkyZjllWk8xbUM0ZGk1ZGxNa0lVbGNRU0tORzlRZDM1UXZa?=
 =?utf-8?B?eHdPR3ludmF4N0V0MXA2YXBJNXY0ekx0d3ZNK0FaTlBLU016THVSL1RVMjI1?=
 =?utf-8?B?RG1xVFBnSXpjbjF5ZU9kRkt5NWNsWm5sS1dOYUxSQUtIOEZsSllXNk1rVjZD?=
 =?utf-8?B?ZEJHUTJ6cFI0OUlicm8rNzJzZHhUdTRGRTNOdzVUdE5hS0lidGZxU3lmeDg0?=
 =?utf-8?B?N0VVTXEweFBSOW5RdlNBV0pXYmdZLzdmdmpqcmdRL3pDdEdieExwYml0dnVl?=
 =?utf-8?B?b3ZrWktvSUdReW1UZi9mTmdOMkNYV0ozY29RSmh0L2Z5dmVROXpUcHdaT051?=
 =?utf-8?B?RUg3ODBqaDBoelpTbndTTVo2cTljMGR1cEIyazhiNENFT1NHK0NSK1hJa3pi?=
 =?utf-8?B?TnZla0NjSHNpUkJVNlpEZS9PMUlQOXZ1cWx0cEd4dkw5TXgxelpDTWs1Zndw?=
 =?utf-8?B?emRQZFZmaWNUVXkzZEtVdWNhdVMxVXpjMGNubmNyTnNybm41ZmxZQVhLMTJC?=
 =?utf-8?B?MVVhS1Z2SkJWQlJ5anQxWUZFN3FaMk8rdkdKV1FFbG44UWhDaVN2QVRXS2cw?=
 =?utf-8?B?am5EZWZCSDlPNkE3YVdmeVlpbzVNb0UramtCWWVPSmJuZXI5SVhDRUVaSnlk?=
 =?utf-8?B?MGtQTjc1L2lGMmZnSXgrak1MWWdCdXhMUWw5dWliNGhtSUpZT3BGM0x0NWht?=
 =?utf-8?B?K0FpVG1ZejltQk9FdVpjTE1vbVVMT0NsV2NIUWdGR1R4US81VVBGOWc2QTJZ?=
 =?utf-8?B?emtXWW9lOXFWYUROdHEvRW42Qm4zV0E5eW1GejlWYWp1MFo1aGFIQjVQV1hq?=
 =?utf-8?B?eDJoV0t3UGJBdHNxdTF3blAyaE1FZUNLZkhyWk8vWlFxLytzTnMwVVJ3cldU?=
 =?utf-8?B?cit2bTExcUhzK1ZEbVpQa28vQVVqbHY3TWZMWVVSQ09UZmJGK1dzNEh4MTFz?=
 =?utf-8?B?TEN0MDRlczhJTTJDcjNKRTZsUndUZUxMUkFOV1lteWRwVE1wSFZHTFoxd1hV?=
 =?utf-8?B?ZlFBRmp1eVRTR3FVWnZkV0dNbGk1cTNaUzF2WkRyMjBMeFBYTjQrcDRRVG1N?=
 =?utf-8?B?RUZ3YmFLYjQ3Wk8zMS95R3dLWW1BTUhUTzhYYWR2Q2VjSFFrV25MM3B5U0R2?=
 =?utf-8?B?ODNmYXlrUWRKdGVNMDJWaUxLdDBWemlTV1FwTVFHM1dLSk03Y0ZJU3UwbEh5?=
 =?utf-8?B?SG1vaTA0Mnc5SXAzSkw0S00wVTJDMWdub2tZaGNCUFgvVitkTE5zekY4cEVD?=
 =?utf-8?B?VThqd0lVYmFKMTJ4L2NrVFNvWlN2d0RRQjdMVmkyTWVidVcvc3R0bTk5ZDJ2?=
 =?utf-8?B?S2tFd0s4NUV0SUZsellVWk56RzFxeTh0d3ZrallpQkJnNE1zWDJtaUx4SmR1?=
 =?utf-8?B?bE1sSjVCeFBUdXV0VWtTRkNRdDlidUJ1bnJTYzZPeHpEdVpMUGY3bGVJc3Bk?=
 =?utf-8?B?WndkeE9DbVdvb3k3VUh4MWQ3SHdWa0NIUVBtTUZHV2FrMlcvRGM1WWRCTVhx?=
 =?utf-8?B?dHJjVlFVaC9tSkNqUnRqWHA1a2JLQnlsV3loWnVzNU4vLzlrWUw2eEJEay9v?=
 =?utf-8?B?TnlYbXZSNmFuSWZzQWdwblMwcHAySGNERnllNGRJSkFSUzFHdDZGRVFRVXVl?=
 =?utf-8?B?cERrZ2pvMzVSZFl2MnpPRTMvTURZRGpuWXdhL3lUN3dSVGRxaVZRZXUwSmkr?=
 =?utf-8?B?akQ3KzRPa0duVWd5U2Qyb0QvYTVQT0xkQlJYOTZBOXRTNC9idDBKU29lSFBD?=
 =?utf-8?B?V1J1SnRnb1RzY0F2N0dXWmdpTXc4U3ZMRkxSZHdjeWUwWTlYYXdhQjRBWEEy?=
 =?utf-8?B?ZFVlb2xnbGltZlA5alhsZ2xMOFpqMEdDR29vT1YwYVB4bVFFN3JpN2xGZlV3?=
 =?utf-8?B?UVVaaW9UdEQxTmdiZVVucUt4d1g3QWNwUEI3M05jZjdrNzZWazh0U3VDaWgy?=
 =?utf-8?B?YXgraWIxaE14d2ZEN3VxNWdUL3hXa1JnR3BHL3pXdjd1czNhZjVSSnJqaXho?=
 =?utf-8?B?RGNWa010dTJZb3FiOFBWMG8zbHBYcW1kRWo3aklYaEZnMkg0bkhPS2g3K1My?=
 =?utf-8?B?a0pheS8xSFRnSFpjTVJDMGk4MExCb1ozRTZXTUFSYTFZNkVMUHN2SGlVSFlS?=
 =?utf-8?B?WVBGNm0va2draU9kV2h1bS8vS2sydTNKeEZXdStlMkdvdEpHZVM1WXNaZXhi?=
 =?utf-8?B?OW9NWGdnT2hsNXNzOTVDSEYrYTRvREhsVlNVVjlFekJkMWJoaHdsVG5mb3hi?=
 =?utf-8?Q?SMo/YpS5EOlGkmC8x1z4WMJzw6vrFoewBzCv4RKCDQDtY?=
X-MS-Exchange-AntiSpam-MessageData-1: MHYGek9CgpAzIbxMQFDEvBCi0Q8twl6JQ/M=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf1a5ce-6342-439e-b86e-08dedcb02a51
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 05:17:11.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIB7aJ03jPqerugwy2Cb8iPqRNwMKfWWFuP/Xt64IkLp3lDPMALpNz2xIKOqXpwXsW8LCT3lI04KWY70rRwoNvJu2xXrvf7x0k1kuZNRmxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9268

On 7/8/26 00:30, Florian Bezdeka wrote:
> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>> Hi all,
>>
>> this series introduces an initial EVL port for RISC-V.
>>
>> While some tests are still failing, I’d like to share this early
>> version with the community to gather feedback, reviews, and hopefully
>> some assistance in refining the port.
>>
>> The patches have been tested in combination with the Dovetail RISC-V
>> port on top of v6.12-evl1-rebase.
>>
>> Looking forward to your feedback and suggestions.
>>
> 
> I tried to apply this series today, and run into the following issues
> reported by my tooling.
> 
> Patch 1 is fine, patch 2 has some checkpatch findings.
> 
> A couple of debatable warnings like:
> 
> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> 
> WARNING: unnecessary whitespace before a quoted newline
> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
> +
> 
> In addition to a serious one:
> 
> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
> <shanmu1901@gmail.com>'

I did not get any responses from this email anymore. I can try to reach
out to him one last time, but what do we do about it if he will not
reply?

> My perspective: We definitely need that.
> 
> Best regards,
> Florian


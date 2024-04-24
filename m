Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19D13A401
	for <xenomai@lists.linux.dev>; Wed, 24 Apr 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992150; cv=fail; b=V0/IZ+UncGiRwCNIuaocd8Ewy2vFTgvKA1KIU1vaPn22O53LhE1HSapSZxR08cV3dhK3QexuMeZNMX46Yw7cZ7/zWvdM9NzadVIFQKaRn0MS7MEvIyvgpGhC5k4iuWQegvrI1oGSE1HAMt3U+SD22zyQ+fh4xuFQLT7L5qwiolI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992150; c=relaxed/simple;
	bh=DssDBUR8isQs2tgLvJqBfu/1Eo8CYVcyPENgkB7IdDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn2TFaBLcpMwY5HxgN+K74Q6xIFitbD0E29RrGAwnV3/9qBfH5W+PmI/syRdRohHX7oB1FmU5xTQkAYPMYrvK/53E33L297R8NvgyW6ZUJVMzahJQ/qFkt3TG9XnonAOVeDBgtQ8rB+ejfFf+AAX57XSO+lNy7OxO6z2Zh4C464=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=weJgXe0G; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="weJgXe0G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB2RPWNRuurtExo9UrscsqO6L8t/H+Mfvrlhe9URN6fQnTJvkn4pECycLYfS8HZpKfA5BQPHEVlkBFEMV6Tk5S5Lbrtd1gVB9nD9ODPRZfSX4duyBWZrQvk/789YywP2qPp8URrSTDo57EO1VHfRQAeUHgSbqfuoZZpNlBrq0qqxr1QrIB5JnLLjUMS8i38h/T5e8x4skneD1uo3Zg2oiccUBJEjK6oDcOsMVOQiws0azfjPrGbiDFGYTqk5/WwNVXZuDea+Akd3jY6fsx+eMqMFw8CQIAVpFNr5n56WSTeIbzgblxDl9PEoyUHylB+dsmeZx33foNpvk+6lDlzpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WNJbuupROdgxldOJ9LOIRVpmAIGhVtDOdvaETZ1oOg=;
 b=WIODTT1Fob4FurqB3eNjUDMrKMzs5ReyI5H6Yh2+Qk6zyriv9ZhR7o22MOFeqm9NdNK9iBKdKj3Dme+CCP8zzZXC4GIZRsPOKLEx9wu9YuLRpzwk4EVcizlNpGrAgxOG/xN9uQlIc5zRPNo2oYIhmS58YgEfT30ZOET1TfBbDkvqeien9BRleccHJ7PXyB3VK6ywvPqaIGQDVHoL5ynS3BXhYQFuhxqys9WzMqvQw5TofsaAxnoR5f4BBkTSrAPre5msmvp/RqpnUBvqdV7qfqKSsF8dmVnHekmkoDs4qrOCojPp7Sl9thBaV5zJ1eH5VJ8Zsu2RIijpQp36+5R8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WNJbuupROdgxldOJ9LOIRVpmAIGhVtDOdvaETZ1oOg=;
 b=weJgXe0G0KK6nwRxptCasp6M7/duOuZ/HxRZYuO6vh/JgOyYz6qjjhvy+WHRQ3+jvVdS678FpyQaDC4C5SbhbDkeUkAki31lbC1QsoANOA7norGocYnc61XFpS/ZdzXHW/l0PwcF8RWNjDAPE4+5QBf6psxRoCi9v45fEFH8I88+BhoNH5G3URlCeYzzReFD5xVN2YxpVnnw3xuB2QepvleCqF/YYytQ4Lnx+uo5J1qBwU+EjtyFVe4/CUzPn9dQNcQR1Je5GLoyMqJHliVX014XeFldOiQxjQEABHF+5rPxhx696ae6T+JA940z8LJ8VcTdRkA5QWNFBrhx7ygyVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 20:55:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:55:42 +0000
Message-ID: <2627ecef-2430-4c3d-8410-87053b188e79@siemens.com>
Date: Wed, 24 Apr 2024 22:55:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: MSI NOT pipeline-safe & Internal error
To: Yao Yongxian <yxianyao@126.com>
Cc: greg@embeddedgreg.com, xenomai@lists.linux.dev
References: <61031e69.8c6e.18ef0aff82b.Coremail.yxianyao@126.com>
 <6644bcdb-5867-452a-9c11-c82014e50b7d@siemens.com>
 <6c251ca.986e.18f0ff71ba2.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <6c251ca.986e.18f0ff71ba2.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c07f4a5-4bd3-4a3a-5199-08dc64a0e7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3VWNjY0NHB1SGo2bVRQaHA4YmJwN0lvckZaQjJMaVoyMTdHenlnRUU0WXkw?=
 =?utf-8?B?V0VmV0ZDWE9MUEhDbTVPeWhxcHByQ2RhWFJZMFNMT0J6VGpIRHg5dzhJMXZS?=
 =?utf-8?B?OU53WmNKQkVpOFhLWndIY1MraStkQXlDZE05WjAzdkhpeDRmMllsVDYvY3RW?=
 =?utf-8?B?M0RINGM0RTZINUpDbU5lWHAvekFQdXY3NEsxckxaWHdiWnBtbHByaS95R20z?=
 =?utf-8?B?N0dtL25Cc2NId25kVHVMWlBCazJEUEg4akZQM2h2SXY2SXpFMU1zekdkWG5D?=
 =?utf-8?B?YUh5aVVaQk1LdSsrNnM1Sk43VTZjMFZSUnkrbG1TZy9uZ0FVcy9ndTczM1F4?=
 =?utf-8?B?Snc2dDlyemUyeWhWMEY0ZEpHSUt6VWF5aVVJOG9kYWszWnNRTTFHZTJRK0xE?=
 =?utf-8?B?M0F2aEFURENVbzhBYXl4bmE5VXE2V3F6aUZSN1g0RkpqS2JMNDBaWVdGODh1?=
 =?utf-8?B?K2ppWjRWdnZjSllyZ1VsSXBVSlBkcERJNGhscGxFYTc2VExVd294NUVqdzRq?=
 =?utf-8?B?cENIUGpGMllJdk5RRVVBTTZSektQYlpyUzAxS3lIbWQyVnpTTkUxdEJLaFRX?=
 =?utf-8?B?V3dPNG5BK3pyQ0RoL29SQzZJUEJ3TEFTaC9PZk5MdGYvMDA0MkpVWkVXUHBu?=
 =?utf-8?B?blJFT3VadjNKbW9JQTk4ZWUwQWVpcmtzeG84TFdJQlJHU045NkErTnN2ekdB?=
 =?utf-8?B?VkhRSmVra0piSkhKUG9UN2xhU241K1IvUHZnbWVDZHRWZmsvVkdsbXEwc2xT?=
 =?utf-8?B?UnNhbnBxR0FaRWNlaGFHVXp6R2VPamd5czlRaHUveFZzRmM1U0d5c2dqemV4?=
 =?utf-8?B?aGtMRzdrZVcyN1F0TCs3ZFpPTWRSMW81NHFNQkxJekM5U1FpRlQ4VE13aDR4?=
 =?utf-8?B?YVNCR2Z6YThSNU4yeVFGenBCNDZZQ0p4VHpocHhmQWZnUFNDYmlPcWxWUDJo?=
 =?utf-8?B?U2VGbE5rSWVoNy9tcitVU1BVa1JVbWxiZ0pKSWlOb1VKRnNUWER6RmhpZ2dy?=
 =?utf-8?B?dVFQcUt5aGJNL1J1SzlYMVdFKzZGUzFCSUtUaEdDMmloY3EybjFUOHRTTW5x?=
 =?utf-8?B?Nk9oV1NGUm1aVTFLK3ZFaStLN0RFdEtrNVBaTFBGMkJ6Nmo5bnhqbUFBeVdj?=
 =?utf-8?B?dHBuNk1RVlNpdTBUSlBBV0FSK2lQMFNLN0RNSHl2ZzhKa2pRaTFJNG85WHBL?=
 =?utf-8?B?a2JFL2NRek1xR2U4eE51dW55V0ErVWYvOCtBWXhJMkM0Tnh2cmdxejdSZ3pH?=
 =?utf-8?B?bXhmN0t3bGRXLzZCci9IL3h5MitQTXA2YkNqclpoSC8xRndXMC9Edkx0WXow?=
 =?utf-8?B?V1Z3SDhyRkpRUmUzUWp2aHZBWjY4b0RjTFh0NVJ5KzBTU2NQWHVBa2lKeDgv?=
 =?utf-8?B?UmFmMG5RUlpNN2dNYXEyRmh0VWVCNmlIR3dhRUpIVTlkTzVkWk9BNENJNkUr?=
 =?utf-8?B?aVRTNTg4dmRFNmJJczYvTEFXVHIxUFh4a1RLR2RxWkpiNWhRMGRib25sdDdX?=
 =?utf-8?B?QUlSak90ak1UQUdHT0Rxb2tXbk9pd0lvTFpoRHNoLzFyTEpHMWsxTnlSWTdT?=
 =?utf-8?B?RjR6R01Gd2RGVHVsSjRuOGdpUTZyRWlBU3JaMmp0KzRZVmhzOGFPd2hPeTFY?=
 =?utf-8?Q?rnCM68swl2XRUjDPsvftkyCoywI/jzzSYBsXzWor9qxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVk4U2dzOFRrM1VGbi8zb2ZycDZkdmJjUUwrbEN1VS8vVTJjK05uMWpZOWcz?=
 =?utf-8?B?YWFuYXNlY0hacDR0Z1dlbWxjTVZ4ajVqbHZWYkMyakFXTzRwTFNjQjZJWHly?=
 =?utf-8?B?TXpPOXBLUXhCODFDS25RazEzelNZeDZqNlhHeHY2Z2tqZzRTZ0ZKOEsxVitl?=
 =?utf-8?B?b2ZISGhTaTlnN1AwcllkNTBwWkpnaFFIWXpHbVRaQmoveE8rRjNCZjFGOVMv?=
 =?utf-8?B?bk1kblNNZU94MkxNcHFNWHlJNmdHYmV1LzBTN3djbGl6VzhVWHRLankweFNi?=
 =?utf-8?B?RlJOV3NETWMwUFVMMzByVUhhOUs0ZGY1RXNBSFhQVTdQZXVnME1Sd0RVQ0V2?=
 =?utf-8?B?dDlJM2xtRmwzS1R5b3RZQTQ4clRidGY3ZUdMZWxxdXpPQ2UxTnRoQisyUEt3?=
 =?utf-8?B?NWgzZS9CWStUUDhNbTIzSGo4VzMxc01zV1ZXOXBOR00rTllzSHVMeU5lOXFM?=
 =?utf-8?B?Njh0RVpYeWtMY2ZqelRYWkRhMEc0d0hRRmhyRitXNEVsa0QzZnliTFcxT3R3?=
 =?utf-8?B?Q0ZBQU1mSmRpVWY3VHFXMFpya3Z6dFdVOStQRFFGRWV0UnVBUHNDRlBIOHpt?=
 =?utf-8?B?ZUxDS0hXZkJGMXhxbFZvOVdoWE85MW9LVWUyMlVjYmRpTU4xYUtZTDdXUmRl?=
 =?utf-8?B?Y2RveXBmNStRUUFBclJPVGhhZG93ZnVuZVFZOUh0UkdwQy80Z3FhQXIvMlBy?=
 =?utf-8?B?RTdXL1Y0TjJhZ3pJZXBYc2FGSDdVU09HS3FDVFpmU0paZ2h3YUVZRmM1QXBM?=
 =?utf-8?B?UmpJRjc5c1B3Q2dPMmZoeG9QQmxtbklOTURIZXJrZ0VMenNYRDY1VlpDVjZP?=
 =?utf-8?B?YUM3cmdtRENialEwS1IvQXltZkdLc1c0cERuNVcrQUY4QXRUT1l4eE9Mc1Fq?=
 =?utf-8?B?T2hxd216YnV6ZFRGUjlERTRnQjVQcWc5alhoV2tnT1BBdVRpSmNiVHF1WW5o?=
 =?utf-8?B?RUd4ZEdrL21oTU9SdThPYXBEaXVFT1AyR01EWHNVeGc1NzZoTFpGaE9rTDNp?=
 =?utf-8?B?M1hnNzBqcVh6eFdoTy9CaSszQzhmV0FOZmdJQzNaOVdZNXd2amwwc2hXNGkr?=
 =?utf-8?B?dmtvTnV1VFZ2K2JBYkdkek9ScDB1QS9rbVVXNTJkdm5kbUVzT0hMeFBTcU15?=
 =?utf-8?B?N0x5d09JLzgvM2tBTGtaMVhhdzhsOFZmS0FmUnE1TGQ3b1pTMitGRzVZaGlG?=
 =?utf-8?B?RFY4N3RzR3A2VnVmSkNNaC8zZ3JQQkhNeVhkalltMVpuUzZ6dmFwQ2M4UDBB?=
 =?utf-8?B?NmJuRit0WjJhY2FTQk53SHc0VDgzSlhXRzVoOU5QbENIMUFFZzhFZUVWWnZZ?=
 =?utf-8?B?OEtBc1k3YzZxOGpuMDNIckxnUFBPUVEvOUhSUzAyVWdVVHB3UlVuYmw5ejRl?=
 =?utf-8?B?aytPYklVRHJwanR2TFd3NG5XY1c0OS9KSmhWZ296N3creWJJdERsMzRIa3Q0?=
 =?utf-8?B?ckF6UWRXVTd0bVZrWlhPbjYwYTBVSXhjZVlTSnc4QWZacFhvZUJpK0NNYXJr?=
 =?utf-8?B?WjRRMDFzUm9rL0hGWUozV0NaR3dXeTBwVTBHR0tkdnRkdnNzazhYZDFpb1pL?=
 =?utf-8?B?T0dyWmk5Q1luUGkzSCtmclVmQTl0WG1QUTdzK1FtMTZRcjFWL0hGQUZRV0xi?=
 =?utf-8?B?M2hvRzh5QXpFQXNwV1l0YWtPUjFIekpsOUF4bzlnNkMrMU1xNk1pNjFqM3Bo?=
 =?utf-8?B?VzZYL2ZWTzlPbmpUQk9GNHlZbnR6cVhIb0d4dE03ODh5MFc3ZWl2L29DVUlK?=
 =?utf-8?B?dksyY2RlL1ptbERNR0F3amNxZ3lwbXdReW0vS2cwQkN1T0E0Z1FJWjR5aWVn?=
 =?utf-8?B?KzZPVHNPRVQ3eDdIb3NnSC9LQXppQ3VLbzEvNkdDZmU4aE9acHQxTmpvRnNS?=
 =?utf-8?B?aWZmWmV0UlRtTmxHenpzTzdaUS9RQmNBMktvbTdsMTN1aXFHN2wyWkdJOE9J?=
 =?utf-8?B?REZxVGNrQUxHVWhJRWFzamxjL0Z0ZUlTT3g5ZHVWQWY3K1BJWVRieDltVXVW?=
 =?utf-8?B?QlJEV1ByQjRYOWllTGRMUkdkOHJSMjNUdExUT0RuZDhFdU9qREtucVpvZW5D?=
 =?utf-8?B?S1E3WjRlNitYa1dHMW5xQU44d1cyUzNLMktpdWQ3anpjcXJyQzZPbTI1aTlv?=
 =?utf-8?Q?r3Vwpu1hE1qp7mC76/JSOUVmJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c07f4a5-4bd3-4a3a-5199-08dc64a0e7b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:55:42.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfSG0NK0NtcQU3x28rsZLTSCb+uwFH9kD+F4h2cmfdhDeMLS52uQKRZaoJt42KTgh98K8g/uDReToish7AiG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5754

On 24.04.24 13:56, Yao Yongxian wrote:
> 
> Hi,
> 
>> At 2024-04-24 04:55:46, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 18.04.24 12:10, Yao Yongxian wrote:
>>> Hi,
>>>
>>>> On Mon, Jan 16, 2023 at 9:44 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 16.01.23 09:40, Yao,Yongxian wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> The following exception occurred when running the kernel(Linux-5.4.180, xenomai-3.2.2) on aarch64 computer.
>>>>>> Attachment is startup information and kernel configuration.
>>>>>>
>>>>>> What caused the exception? Please give me some hints!
>>>>>
>>>>> Maybe just something like we have in Dovetail already:
>>>>>
>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/42f44cf859e3525eb26dc090fffa97bfc35e870c
>>>>>
>>>>> Jan
>>>>>
>>>>> --
>>>>> Siemens AG, Technology
>>>>> Competence Center Embedded Linux
>>>>>
>>>
>>>> Have you run the ipipe on this platform before?  It looks like you
>>>> have an IRQ source that isn't ipipe safe, it may be causing issues
>>>> when the IRQ is trying to be handled.  I'm not familiar with this
>>>> platform. Did you port it to ipipe?
>>>
>>> It runs on Huawei Taishan Server(CPU: armv8 Kunpeng920).
>>> Does xenomai/ipipe/dovetail not support this CPU/server？
>>> Does the community have any plans to support it?
>>>
>>
>> I'm not aware of anyone having tried Xenomai on such a server. For some
>> in this community, it may even be... tricky to get one even if they
>> wanted to.
>>
>> But I'm sure that any patch written to enable this support will be
>> welcome to the dovetail tree - provided that general support is already
>> in the upstream kernel.
> 
> The upstream kernel should already support this hardware platform.
> 

That is very helpful.

> Using the upstream kernel on this hardware platform is ok, 
> but applying ipipe/dovetail and xenomai patches to the upstream kernel is problematic.
> 

OK, but then it still takes someone to enable the missing bits in
dovetail (ipipe is in maintenance, no longer taking features). You can
have a look at
https://v4.xenomai.org/dovetail/porting/irqflow/#irqchip-fixup for
further hints.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


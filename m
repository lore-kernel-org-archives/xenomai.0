Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116C6AB1
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 09:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MchsBGyokMxXv9LrFyrd0zrrny4jwMy3N1d4HWbcAI4GMi3wCxwmEEcc7+CGHL/sKLwX20qf4JRaAy7q061bF7V5IvYyxm6KcKWg6AdbvVrN1l9O/96R5j7Pm74aRgt30HDWfS5vAmXoGuGn4kxvS81Gq3H1XPzPK7Mp33JwL62Xwpg4kTq7QDWoUxDYe7NzP9lsCMlMv9sm+QRO4zJU+gz3wdFCnQeKRiAG7heBY5t+yLCGx1WQL/npQ1pNbY0aPZ5gzQ6uidOpkZHrZ+PDU+Hb40iiFQaSp3p4b+h3gAt9uHRC8C2hqLtuysNCQ7PHytQ/fcTpeJs6nUah3YZXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8Y3VcdpQwZ3pc79O79jx1s8E0p/bO2vQ9Q1+U6IoUo=;
 b=QzI3lu3G1cM8E0mQDDhQlmClTNMUw/udZIXClR3/q/NeSrNSCjB2SIKqXjSJMokfxnSfSorANaBk6YpybPS6DE+0Hlh6+fK6jYVD/n+ws653KYlcBUp5DCMCX3adgDxJ9rPNjTAEPwcmBxftu5WNEJob+zfI0sLDZNRs/Nz/ECUHgZWUAox2yhu1ZgLxn5lbo12418TLqbUcAphtGmTbWWHnkcZuXr061vp1Ck4591lTWJ4FXhzcMta75ooQn1q/LQ/xry+DKrEMErGxmwQUQJfBOOfN5l1v79rgG1i45tq4iSz8/HbHKk73m5dHz7Qa7DNTD8V6v0nacS/yPlov4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Y3VcdpQwZ3pc79O79jx1s8E0p/bO2vQ9Q1+U6IoUo=;
 b=mgQNFYfNZnV5UYV8cS94RDjRy2apD1ISysO3tYzmbGEvkmTx3Mubj0LCZyj0hXZWDI37uvoW6lrpUKw7tHhzKMoasNQWwsX0UAKVisWAsLaxYvEDs3iblLHxM3Dd9OSy81HaRv6zYFQ4/ZTWvyOLisXTJv8tg3a1Qcw/5ZnihdVMwkXuGC8PZ0Z1u0RojIvjemtfn2opZkFsTMo8QYyeiZPAXkqCjQZynVuviU3pvByxi+VLuCOk7zwPWdsLw/1pWfuceIAlIZBaVHSCYgPmaaylA1EKYpE716HTIGyl8UAWFMaF0GNgHp4jap5uF7gtrSK6t/Jw01MCGE7LALS8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Wed, 9 Nov
 2022 09:28:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 09:28:05 +0000
Message-ID: <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
Date: Wed, 9 Nov 2022 10:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 Richard Weinberger <richard@nod.at>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d48c18-02df-429c-36a1-08dac234b4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Du8sqgbYL2EDOS2AUPcZoG031Wqy45aPEqeNDwxrXYe1kxEx2qAJIbyqoPQdC9lfslNvTIGUF+nOqCHGSFL/tFjrd6BY1utwDR7tdZFfYtuv2QyMVUeL/hOx+TD0CPVMe9lgoIP9cp8Ka1gfLo1b9mLEW7tWrvXzhU+U+IYQpvOyxG9xRJ9oSrmQ6PqULr/Mglh/PLEEmjFz2dtXSQHsXyNKwqyVHTlRpxhqhGkDdpAMWi0Irs/6QV+XLVctPRyfXuHCnjj4uOqxXFb03ypZKSReHcRktapa7s7vVAlF303GMglj+K2zVUiOeSmco72lwIzlEnU5SDg84ZpQnhVhvj8m/dTxK/QWibLItuWP7ntUG7RfwZLFJStUQSExEalcNv43Ayvd0gITTO66RbqLI5g/n/F75nUoHEn09WfIRzWJ/BC6cjfuEIbfnnIijqsz7P2jki1GkuaruT5bNxMWpkVKhRyOerKfDU4nzT0ur9YbFUGNhBIdgm1D3R0GbHKnHZZZgR5fjp6NXJRZOkyFjpa7BfdDRBgIy+T67NJR4sEUJA5zMAa6T/ljdDlq962J05ZdRHyE6PzhK+hS0Ha+909jRrpyqd+lgaoBuzpkcSTR/kmJRGt02Hl0V/1C2U+VSQ7PBfTYsZUlmI2WTAV5HA9v7diAfP3OtWamOhAwz2mnSoKCrEJJqfS2hBlUmJnYXqIz3U4+UeFVY/6xUnDD1u9YQVxSHN9N/6OYDV524ZvIagBbvunhwq8JCKu4r84Uch44Ve3YptoQWB6UkGDPzZlExckKFDrmI9/SrPpAcAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(8936002)(31696002)(8676002)(66946007)(6512007)(66556008)(6506007)(478600001)(5660300002)(86362001)(53546011)(38100700002)(186003)(6486002)(44832011)(66476007)(41300700001)(26005)(83380400001)(2906002)(110136005)(82960400001)(316002)(2616005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZhemtKWDZBc1prajdlbjgyL1JZN1c2KzdKQkZnekVnVS9GK3VCZEFxWkNj?=
 =?utf-8?B?cVFnemF5T1l6cGdJNHdIcC9PaWtPV29nZmJya1hhWXU3dGZWOFNjWWg5dzJO?=
 =?utf-8?B?ME5HYTZaSjBiTDlLcFhnK1pWYUVvVXVld2JUUmVMOUFsVk9LNGxSU2N2bTY0?=
 =?utf-8?B?NWVHU2tDZWpVQzd1VUswNlg1TkkraDJYY2x2ZXVoR1FRWmI4NXEzdmlYbkRE?=
 =?utf-8?B?cVZOTDRRckJHQm1Zc2lEUGY0MzlOZlh4RGNoVzdwUjVKMGo4SHgrWk96aUgx?=
 =?utf-8?B?NkljaEwxdDdITThjM1JmbWViS2pGNGRXV1Y1U29DeHlNUTVjODh6YVMxSjNx?=
 =?utf-8?B?cndyNHRmem5pY1B6RUtvSGFoV1NqR0VGSDFwbmd5RU1xSTFBanZJcjAzVnU0?=
 =?utf-8?B?NEw3aXU1VDROWjIzNlgrZVJhenZvblFadTI3ZVpuQllNcThiUW05RU10YVJz?=
 =?utf-8?B?QTFGd2hjcXlmRmRQM29zMVFLT0V3SFRtR0dGY0c4clRLcEpOWXhmbDVQNXVk?=
 =?utf-8?B?anpidGIxc2xYdWdtUjY1SlBlZ0NoNVkxdGJINlU3aENVTWRXR2c2RWZaenkv?=
 =?utf-8?B?SkNxNWQ3ZHlqeG9Ddno3LzBwT0lzZ3VKb3M5YktxVlh5ei8rdXRjOHJSMSt5?=
 =?utf-8?B?Z1g2a2NjMWdxaTF1L1lna1o3VTZRdGtObGxtcDZsUms3bGZrUmowTktGS0Rq?=
 =?utf-8?B?ZU9FQjluU2JQMXo0cUpTWHRBWmNPb1oycGE3ZkhLRDRkTjYvVVl0c1RPbzVX?=
 =?utf-8?B?bWV0ckl1UGV6ZjNwbS9Ma3ZwODlHQWtPM3JrOURadXhwRHRLdCtSeW9lZVhx?=
 =?utf-8?B?S2dkaTZGYkRsWGNlSmJVZGJTajJUWWdoZmxhamFwMFpkcWpPQnNLclJMenc5?=
 =?utf-8?B?Z05YTFhWR2pEMkc1cHV1VW1wWHFabGtXY0RLaGtOeGpndHUya25SZVdNU3Nl?=
 =?utf-8?B?VURFTUlMcmhpSEhmSVR1UzJOMmpnRU9qZlFVR2UrdHB1RklpMDFUODFnb3hL?=
 =?utf-8?B?Tnk0MXJvR09memZxY2I2cm5EZmJldE4xa3NXV2NFRFRBZ3FuaHJLWDVYWmdr?=
 =?utf-8?B?cWhJbU51ZTd0OHo0RW1UQzAwN01jcUhwTTJCMitCaFp0VVRXMVBuRXdHU3pC?=
 =?utf-8?B?Q29HQnFlV1cwdGNGTEZkTWd3anFTeVovR2NQQ2c3M2w2MVRvQzNpT0tqTGlR?=
 =?utf-8?B?eG40Ri9od3Y5bG5QaTZwY0VKdmRRWVQ0eVdPcDBrNEgraDFkRnhLL3M0RGxq?=
 =?utf-8?B?dU42aC9EekRCRWFSaFZMbk1uclg0NlQ3ajNMa2h6V2NQSGh0aXQ2MSt0cEJW?=
 =?utf-8?B?K1F0WWtsSHdLWTMwenN1TW9uYzJ2QVBVdjdHd1VoMFNKTytJWktCcGhNRkph?=
 =?utf-8?B?KzhlV0ZWMmFQOFpIWXR1RmNCczRqMXdOY21IeFNWRE1NbjNjRmovUm9JcXZv?=
 =?utf-8?B?RGQwalJBSEVld0N4YUhaMENYNWRuenRRR0tkTytPTTl5VnVWSHU1MkFIQnVz?=
 =?utf-8?B?bXcwNXN1Um9RaWxFbGZnQkhnM2FTcE5taU5kdjh0NGw5NWNoSzY1TlV6Y1dk?=
 =?utf-8?B?RFI0VGdod1I1S01hKzUxbzQva2NCTjFCUThzbk5zejNwb3YwdWx6aURrWTE2?=
 =?utf-8?B?ZzZpODM5b01xazBEdDlTUGRKbHNmUDRxd2U0NjNJdXh0d0tKTXZaWkg1ZlZ3?=
 =?utf-8?B?RDhRN3A5NU1aaXE2UUNkQ05USnpXZEI5K0JCZ1F2Z2xTdWJqaDloSHM1MnV6?=
 =?utf-8?B?TFp2T2hkWUZGa21ISWhnVkl4YUlFVHN0SGY2OVNWR0gyVkhERnJSOUt2REh2?=
 =?utf-8?B?R1V3UnFkRFB0dGJtaFcvQldPR2ViYXdrdGROUFQrUklYcmdTNWd3SmZUMTdE?=
 =?utf-8?B?d1diSCtyUzVxc3dkRFJvaEZNdVZNcWJCRExlbHp2dWcrd3BHUlJsa3lrR2lH?=
 =?utf-8?B?alh2RXdTUitPTzl1NGgrdlNpbEt5bkovV1VNRnJqSFU5cGVyTjZ4bUZNY1hy?=
 =?utf-8?B?dzZqdlBpQlM5VHZXNGUzdk1odUxmYkt3V3ZqQ2ZoRGFzdlhhWnNyMk1JSVpI?=
 =?utf-8?B?bDdUMkdjMWRiOTdVZE4xazhyV2YzbkZlL1BVSHhsejFKeG5VUTR2RGJBSG5m?=
 =?utf-8?B?V2ZLTytJczZFOXdZaU05ZStoRlo4aGh6eE5MazZTVXFiM0dDTmk2NlQzSFND?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d48c18-02df-429c-36a1-08dac234b4e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:28:05.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnPVCC9j3cS3mcxYiv4S8+iFRNBpmi2Zoy4XJe4grzme4+Ae/6gCJsgFqEgtJHeJE765gmKhMubtwQapJWgavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7811

On 09.11.22 08:31, Johannes Kirchmair wrote:
> Hello all,
> 
> I just recently found the time to test this patch in the context of our rt_signals.
> As a matter of fact it works quite well for us.
> 
> So is there any intent/possibility to bring this upstream?
> 
> I also did some similar changes for arm64. As we also use imx8 boards.
> If there is interest in those, I could post them.

Yes, please share. Then we can continue with proposing it for the latest
dovetail port (6.1 now).

Jan

> 
> Best regards
> Johannes
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 8. Juli 2022 09:13
>> To: Xenomai <xenomai@lists.linux.dev>; Philippe Gerum <rpm@xenomai.org>;
>> Johannes Kirchmair <johannes.kirchmair@sigmatek.at>; Richard Weinberger
>> <richard@nod.at>
>> Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
>>
>> On 08.07.22 09:11, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This allows to skip reporting a trap to Linux when the OOB handler
>>> resolved it directly. The handler can signal this condition by returning
>>> "true". This feature was present in I-pipe as well.
>>>
>>> By intention, not all spots of oob_trap_notify are enabled for this.
>>> Debug traps are left out as well as asyncpf in kvm - no use cases from
>>> OOB-perspective.
>>>
>>> NOTE: breaks unprepared users, breaks non-x86.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> I'm happy to add non-x86 support as well if the direction is fine.
>>>
>>> And if we introduce that to dovetail, we will have to add some kernel
>>> version checks to Xenomai so that it does the right thing with the right
>>> dovetail versions. Feature flags are out of fashion there as far as I
>>> understood.
>>>
>>
>> And I forgot to write that this if for v5.19-dovetail-rebase. I have a
>> 5.10 version locally as well, the one we use in a downstream deployment
>> for some months now.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux

-- 
Siemens AG, Technology
Competence Center Embedded Linux


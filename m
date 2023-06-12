Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C61FA5
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 07:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ+YfVN0R5rzCAimnWBruBp9TVtTv2PWspEA3vQygcH5OpqKuPnFHODVpiDqJ8SqIdoQYrT15KjYrVa/u06q8Jf5OBIQqd1roageJyxTqIN7OebWHGtpIopO3zAgYnPeGh7OhzrtHDqpwksY2xEzXnoUJDULsyRBNE5CHqgEukqj50aRIhoCzgHLEweDMkZ5DdSiOjOGvbWWsXNvQrzajwylCqDDtBWl2Hqiu7yiDi8WTExWbISM6UQFDdqC970NbQy5ZkWHlPrOW0lL0OwgaX0JoPQMW83ij81X3L+WGaE2/JdGjWSxKChPpgIxAB+HIgA3ALiYXe3FtwcPkCmvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsvP+IEjQoNgOdA7Jp6k15Gm86BiZYdmazR+PZMSqq8=;
 b=fAp+bOgEFDAnhG3MPBBf2x47OwKp6GOxn3fY7GgbTwT0eeZgrcKvc4Ui8VBOG8WKIO5b8vaqbkfFNo2efc9Ym1X9YhNuawA0fBto0+AdnxE36ooxRICzuIZvmqu3AiQ/2tjdEZ205c1Qjlvex+P6lZBwTMKoEpjtGYy9j2LcJ5WbasW9NJ6PNTa78+OcNWYag6mYvEyGAbdq+JKfhtcilfQN6Jnfe55Eu2z++yo4O6yLb4O3bSq+qFqFPboiRcg3tDMOng8clN1Uh40UDSbsXzqMsnpbzDu5KiwF69uqa0r2Jky4MGT5ms4VP/e3cdHuzEP7pyOh7LIIIX+C1DGbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsvP+IEjQoNgOdA7Jp6k15Gm86BiZYdmazR+PZMSqq8=;
 b=SNQb35ul2Vzx7psnotdoivWMZy56HFvfGSwFx6gbp4igWbLdUT0jI3vXqtq5hc88d55i/F9ACsRJlFJ2Bh0F68knB1M1kRkLv9zfwNKiX8y3r6pGsc5bVH9+0/ah3KUanF+3O20IDvEV5IDr77hwAmAM8BMdo+nr3br5D+ePH67FT4MgLO050JiV0Wy5Nt7G8WhxihBvppTplJWlSQaP+mdvsxUMXQyy3kRtlH3TKTpC2qU4FFvWY3VOVcz8vJMvutAEFK+yF4n20pdzGGHslK1oR7xjW+It5YHGyUZP7fYCkJLM/Ls6ExGIJ5E8cKyuRG/Ng6cBNNqa6SgyitL6Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 07:54:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 07:54:30 +0000
Message-ID: <28fd5233-3dcb-8860-55d9-5eedc0b7e4ca@siemens.com>
Date: Mon, 12 Jun 2023 09:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Set irq affinity from a user mode task.
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <CAH0t8y0j9zdJNo6X9SfsYGAJx2WJiGtvw866EgqMnRQwB0pOvg@mail.gmail.com>
 <MN2PR11MB4285E1DADCE543CF4966F4D2F254A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285E1DADCE543CF4966F4D2F254A@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f3e8b1-00f9-469a-d8c4-08db6b1a40be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lxxDrJIarKz7gRayuatpH7tHnbw1ZbUbbdD4u/hNH5ETRt/p0GzlvZfWYoDCragL6QYl8RqKG9qZzTTyPwvaUBB6sjFSI2SKGdUNz5ctt8Cr7gn0KUZV0L77H6/tbNRpK+7+l4AVDsP4dkZnfUWiSjtZBwKH4cpIGddx+KJGqCk3yL0kQUlcS/Toaecsu8vh0eQ/NFNDmyMT/If0fnusoTFqAbhrRw5MiMf04+/PdlsIm17Pr/7Z6zIEgIXOm9TGAft1Q2L9DMsNXPfUcMVZstso/WTZB47MfE8Spca7J8F5KN36I8nexm0vyEx4nl7ngHgkQ0nyzsWaO+wCnHgTaKV98FTE/NKENPKCS7c7IBoqSlVEiog9asD/IRPi1OdkgpD3XGeHU+d16mhGtRw5SGkL10xmeW9LZ2zuQtI/Z105/VYXmDOt1gTICTtVypsVp+FunMjJvq+ZWINGUu612ylWobWXTSed4E8Frgt5RmWjQDSitektVbKUQYG7Y/Tf0LULYV5aT+NLzASAPbga61g6+juXundVudFq3OhevStZAYdodNJregwWHE3cv4gyuEBc8g7K7y+XfbUe4qBNUxI2Bx0FSdvcOLchZdBY0IaUivxh1NTGODCOx5m/pnw6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(6486002)(6666004)(966005)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(82960400001)(6506007)(53546011)(6512007)(26005)(186003)(4744005)(2906002)(110136005)(316002)(44832011)(66476007)(66556008)(31686004)(41300700001)(5660300002)(66946007)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q09XWURyb3hFRHJYbUZSdzRPQXQ3eUtuMmRpYUdXOEdwcGpGanVQRkcrSkJt?=
 =?utf-8?B?aEw2Y2RtOHI3dncxODhJdHUrWmZjeHcwWUFPVEVBUHN1dFkzMDRQanovRVAv?=
 =?utf-8?B?ZjRJNkVwMUw2TzN1TlN3RXFyOEpvRDVTT1hBcURXK0JDRWREMERENytYb1Fr?=
 =?utf-8?B?cDBtOWNzdDFNNXlGVURDN25sNVNuL0piVDlUY3JFK0pMRzFKZ3ZMMS9XUFgv?=
 =?utf-8?B?TTlmL29IeUxvdm1UVUt0OVBjZGh1YmsyUFVmTE80dDRoaDljZStTdGFjNUNa?=
 =?utf-8?B?ZnYyNkpYOWpjSzZzRnhlQzRGNG5Md0hkUWd4bm9vZWRJbEJZQThHL2FRZlhO?=
 =?utf-8?B?US9YRDdCNk94Yk9BSWo3dzZucGNlSVlQODlpTVpRQWliL2V1QnpkVlNKWTkx?=
 =?utf-8?B?NGFwL3VTaHBGd3crcTZMaFFBdVVzeDZkd3dHalhJamNsWlF1RjhaTnFUU3cx?=
 =?utf-8?B?VGdPRGUrTk5wTVUzb01XaDFtNmhpUTVwU3kyNUpQN2VSMncvalhQVTZsWjFh?=
 =?utf-8?B?ai9qcTB0bHV3OXhBMmpJb0FyZHRpb3MwK3JzcUdNRStjUFBxL3lhZCt6RWFT?=
 =?utf-8?B?RGxYem13VFAza2dCUjg3cWNKb2dHRy9Jd3Evd2EzZ2J5bnRiWE9rMnFoYXdJ?=
 =?utf-8?B?SHM2cGZ0OVVWeHpsUWNGYWY0QkdQREQxaE42Wld1L3ZzNVFDOVJNN2tUMWxz?=
 =?utf-8?B?WUtJaGtsNnNWZzd0aVAzTnkwSlU4Z2JKNlI3dTdZekJweEVCaWJOQ0Z3T05z?=
 =?utf-8?B?Z2Z5Wm41U2plNGEzMENmZW9pWEVPNHprbGlDTjBQa3EycmdqSFYzNlRhcktX?=
 =?utf-8?B?TzRZT0pXd1JMaVVFUlZxSXpMVlJ0dHZYMnZhWFplSmpEMm5EeTVqOW1vbDVr?=
 =?utf-8?B?U3ZlcVdLeEl1RksyNDhJSkJVS0VTd296UmM2ei9GSmh5d1VwN1BiOXo5ZmFm?=
 =?utf-8?B?dHdiVS8zQjlBelYzV0R0WkVXZDQvbitvWVY1Z0RaeHZnSkZKZ1ZkYmlmWDZB?=
 =?utf-8?B?UmlJekpPZTJJTGF1WUZzOVo5MEs1Q1l1NFZwNHAreGwrZmVxa2RHV1JnVm1y?=
 =?utf-8?B?L3JQc1gxZ3JzMXdJRmdTWEJYYWx4Ukk3dGs3blpYTGFLa2FraXY0UDlGc3pX?=
 =?utf-8?B?VTkzNEZNaEpGR3h0N2p4Q21qa0Z3cmRpZW4wZXlJVkVBK1ZCRkVzbVZkRkF1?=
 =?utf-8?B?TVdWdys1MGNuVEx0V0JsNWREV1ltekRjRmYrMEpjSForYnRueEtMdTBQMmNE?=
 =?utf-8?B?TDJHcDlNU3Y5OFJjNEpYaEpGYURBSFhWN0RWMDJpK1orSElCQnJISFhoQjJX?=
 =?utf-8?B?SVg4T3o0cVlVNlR3NExOVDBxNFVTMm4waHBteWtOQTFSWFQ3Y253NHN2L1c3?=
 =?utf-8?B?WjdwWHhQRVJDYWhQbHdKclQrOWNCTlNuVEtORytNVEttTUIxMi9UVU1ySFNG?=
 =?utf-8?B?NUhiMUVOZGxjNmJERHhqUkxaM2xRN1JrNmxHNk9HeWM4RG5FQkNZUEFLNlEv?=
 =?utf-8?B?T2pWNTdvSEh1dlFpNEdsTVkvR2d4eVp6ckNZN09LK2doNHRiK0xBZkxWa1RI?=
 =?utf-8?B?eWxST0d3N3NodWp0US9ubjVNWkxHSFhyL2svOEE2ckV2Q1Q5SFJBejF4TFp3?=
 =?utf-8?B?TlhHQURXOFZ3UmJmeTJDRlJaZEkzVlpYejZpZjRuZTF0NXN2VXNWN0NFcUtk?=
 =?utf-8?B?U2dSZkJhcHlicXRxZ1dlZVh0WTh2cFZ3c2NzL3EzQk8xdjlTcVdvVC9GYXBl?=
 =?utf-8?B?V29LQnFlTW1PVnFXR280cFpScEFUOVpUTUluZkxweno2Yzc4b3p4Q09PaTB3?=
 =?utf-8?B?N3ZTejFvV2dIa1pqLzJDZFAyZmcrYkFvUURZemQ2OFk4bjBjYURCMStRS0Nz?=
 =?utf-8?B?bmNoYy8zZUZlOHN0UWVXK1NnRHJFdFF1UjA1Vk0yNkhBRFVQRVNHckdXQ1hj?=
 =?utf-8?B?bkpzaFN1aWRadldTZHFwV0lIcHVGRTMvbzVsS3RXRnc5MXVqU2hOYkdNR1ZW?=
 =?utf-8?B?dXdTU29QUWE3RGtyTTNVYUZDQXZ6Y2ZCeS92MmR4SUx5S2tRS2xvMm53b2Yx?=
 =?utf-8?B?SEo3WHhuZlVuSmlHS25aa0dFNDgwbjlCUjMvWko2TTQyaldROERXa0E5L1pw?=
 =?utf-8?B?WFZlSzhpVGhCNmozcklJY2l4QUJnckcwQkJ3b20rREFJcDlpYTZhNmVNWXlq?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f3e8b1-00f9-469a-d8c4-08db6b1a40be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:54:30.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8htsEv9sAR24XTex9OZbWnxjjGpF5cjnMA4HyMJL4/akvC6O6jUqFNENC1roZwaAhLdGAq+h8oDXLJL6UZLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5705

On 12.06.23 03:28, Chen, Hongzhan wrote:
> 
> It seems that the community  discussed such thing long time ago as in https://xenomai.org/pipermail/xenomai/2017-November/037914.html . According to discussion,  it should provide generic API to set irq affinity for CAN, rtnet, uarts, SPI etc. But I can not find any code
> using rtdm_cpumask_t under include/rtdm/*.  I do not know what block its implementation.

Someone has to take action, I would say.

But I would rather suggest that we check if Dovetail needs changes so
that affinity is tunable via proc, just like for Linux IRQs. Maybe that
even works already, don't recall ATM. In any case, IRQ affinities are
generally not application topics, rather system integrator tasks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


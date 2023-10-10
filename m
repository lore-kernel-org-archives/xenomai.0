Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352F23A0
	for <xenomai@lists.linux.dev>; Tue, 10 Oct 2023 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="V3b3p8S9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omrao3jHQDggdeDwiNCRVuXmunQmcQD8YHQAubTmai2CRRCdAnu+JgElliItpnn0Iw2cHzEGpeArwiLTUkDJhPQ8TDHn5mOr3+mVUJvps01i47eUbuwI9myKOV7WLFZViXAnyA8M0b0t2Ep2JE/hUzK5XQsrZcFdcFs1AvDzojMnJ2jLz/wQIbXZMb/01iVBFID88bZyk0MY0qe0s2atId0Q9FdaoUIJA4j0/R7l5yuzMb1fYDnKdZbVcwmPYxT2+I+t6pXiNNyAOuyLoynpRSkM5XCkDnk9FEbdQX7LVl7VAUikz7ekuarLqN8oU9NpmSLW3E0Vox9+Ur6/WEVtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWO0itzHcNd/bGbN/BC0nzjVA2FoRiD2CxGg9iUpGa8=;
 b=gxoLXaYV/S5j2FLKFZZLCSk27WSCgRn9xpNxp5hhS2C0vSBU0Z4Y1LaIm3ch2Up6ip6v0GZSMdGeddJ6BpgZ8wq2fvVMUZU9s1ZdhmQj+udb+d/TiiWq4Ci3CkWXZ8zunJQIvLNmOLxglej/Q9VTT7GcLXInd/dbUY37eL1WasmZknzSVsB0H+QHcoBWm3G6Rf/mQWrjC66Iwa36jjiDFe32ibfwGR5fGq7m3FnUudwev7WF7L9SVVDwrOdPXLwtayQVr5XP5XE2b94XULawkZfec+pbfjStuco8HXQj1uabMFHv7fsR2zFe3shXZJvpSxNXUbYcyj38ucRFrd32iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWO0itzHcNd/bGbN/BC0nzjVA2FoRiD2CxGg9iUpGa8=;
 b=V3b3p8S9Cvhg7ZHSQNfHV9Lhycun2NmTUhSx7dLnut6G+VgRddkotxiLTAVZOOvVeOUG13Qefl/5iIiGapEcuQVnhZ85KcxhuSAYPQsA0Kez8+oYeZz3cu+YbvCvN3isDhlF7wcMh8vf2QIpTV41x/193RzFR5JWud6ITGTIz+qg0HXLg5aWPRvUFEDKuUX+vaqgWidxxltsoMUw496MtwHvx25qINXM1RK3ekwPKaeBsMXmGwp+bR17aoKT2Q97nq+Q9WmwGEhTU5INA7CY7YbX7O9QFFUq4wjaUbYU3eO5twAmo4i6XOYDiObBBekBEvg6H4Iv99SylsFBNRCBoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 04:26:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:26:02 +0000
Message-ID: <7c71c982-a3a8-447b-8d1b-2f01cb506759@siemens.com>
Date: Tue, 10 Oct 2023 06:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Sep 20, 2023, UTC
 7:00 AM
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Richard Weinberger <richard.weinberger@gmail.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
 <MN2PR11MB42853939B9B762880D88439AF2CDA@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42853939B9B762880D88439AF2CDA@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9531b3bb-5499-4449-26da-08dbc9490304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1tJ01EA+bGbV/EMkitkINFv6MTx+SAdlDMHjNnGwOjGNV7YyRbp4conrFboU/BhbAqxuRiItPnOL7H1I15zLYHdemUp20K8PJPsfCm2VHg59AotIBHSev10Pu16IG2YjltNYEXNeQzm6dmwLv9I/DamIwsBxCewFRqGoVQD4kF65f7czUOgKxs8YPtWkUITPBPnen+1p2iphECMcYHUW6pp5Hz5RWepIvRAG35lSSB8rnJxcxp3nmTyfLiWYqhfKRbLVrjbn+xd4KKEsY3omnjSRc5dsn4jVbJ/R7SXFgfWruKdNtMTVmjJAgcsJXVl8+SRixPZQIHPT6wSghdcVyhPxIBCsqTo5CfR64qCdjtLvnMdyzl2+82Q2az7UZXQ+oU+aAx1Qcwk9/3451rJURD/nEEtUoDOCGPDiGohDvTujRS4Attnc//q+w8Ttu/qZLl55oZi4buqykTMBoCVC9LDuvj1WbC8ysi1az3AHUdVQBxE2KYWmFJwGmDsBHTEq4+FBfjgdimKDQYy3PpvFBsHyI0q9/UU+kAMJLkV13qnvjN1NQjZgP+8WCStl5Q+WYPrpx+V91R8ufMIkRkz55Cs+kehdRewT9mdRr+/pzVhH0Azfru+OywGYnYVfsLOcMQXSUCa0GF2N3s/MwpVZ4nLmUvJpXGPiPmHrz0FFfepupnBRVQ6pwE3AtNWoymDB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6506007)(6486002)(478600001)(6666004)(83380400001)(66556008)(26005)(8676002)(110136005)(41300700001)(2906002)(316002)(8936002)(36756003)(4326008)(5660300002)(44832011)(66476007)(66946007)(4744005)(38100700002)(82960400001)(31696002)(86362001)(2616005)(6512007)(31686004)(511114005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXBMUXQwSkgvV2wreWdaZ09DMEwvU1hteFc3cU50bGRnUkFKQkp4d2wxcVBn?=
 =?utf-8?B?VWZlamZQRTVJRVJlUHBHb1JWVlhha1o5Ly8wRFdibGRoUmsxNDkxcVZxT1Zv?=
 =?utf-8?B?V1BwNkcwa2dRRitmbFQyWXg5eHRKUVlWKzhXU3NUZWJuaDZ0eFJ5MkVYOXAy?=
 =?utf-8?B?eHpVeWRZeitKbFJ4N1B1K3RqVi94aHNGcUxDMU9oaEJPMW8vWk5CbkhWalQx?=
 =?utf-8?B?RkdtTWFIVkxMUlJpK2JXRmt6Qi9RZFhzWXpLUXArNWhXUFNPY1UzekV4Y0Uw?=
 =?utf-8?B?ckIwMi9NMU9xU0llZVRxK1JHUEVIaTdlZC9WUXh5QVBtS0FYcUN2elQyUE1r?=
 =?utf-8?B?Q1RTMFF1ZUEraGRTWXZqcWd3dDRsalNmYk1JZGZZYUJ5T1Ura1ZXL2JXeTNo?=
 =?utf-8?B?Nm4rMlVwTmU1TnZvVHNQVmtPdndLV2NqblpUamtWT3NKTVFxcm5YbWt4OXNi?=
 =?utf-8?B?Tm5nUFZ5NkR1RG5zVkJraVZpMThPWnBLRzJMQ3JFdm1KZFcyYkl5U3o1NFo5?=
 =?utf-8?B?bEZjVTFMYzVxM1orRW1xOXhwYkI4dEwyM1Z6SUsvNmtlRGJ4R29iVUkyRS9t?=
 =?utf-8?B?OVRUQnBNZGtiM2NnSUZ4NC9yWXU0MlRQSTJSc0toUVd0emRyK2F3aXFCNmo2?=
 =?utf-8?B?Qk5NTjd0d0RuQjVCMlUxUHM5bFk0V3haRGxLNkRua3p6TG9mWDd2d2d2Qlp0?=
 =?utf-8?B?Z2hQZ2NVRjJ1NHRJWGppV0pxMFJnNHUyVjVuOGozcU5aWllXYVlOM2krOWNM?=
 =?utf-8?B?MVpRb25PSDN6blFxTWdsTTF6S1RkT01JS3VDUFJacHB3OFl5MHpSYjFZMVN4?=
 =?utf-8?B?UmhKcGM3c0NYWWtJblBJb3VhTFVSZ0JJcGdwditoL1RPc1AwNEVaSC9FTFV2?=
 =?utf-8?B?ODJjWHJkVDRrRkVrYWwyNjhtZmhjcnlOVXhmSklJNHRMaVR6OHhZVGdQYzFx?=
 =?utf-8?B?cDFLLzhscUJoMGtFWDdwTFlseGY5dHJpQVVwbXh1RVR5V21QUWw4VWlHcDNP?=
 =?utf-8?B?bHlzeVJhSWxLbkpIKzd6SGRTZ3g1OGdFSGY4NHYwTWJwV2V1UTlSb1M2RDRI?=
 =?utf-8?B?WWoyVk5GcDExa1BvYUZZRmpnZVFDQmJ6dkxqNzZZVGZtY1BJdHorakNNd3Bl?=
 =?utf-8?B?U1pvVDRuOVVBT0pxYVhvZlFGRk9vMUJ0VTNrWFlNenRtcjRBT1R1T1JJZUV2?=
 =?utf-8?B?cHYzbDZBWkZqMEprSTJ4a3A1NUdOYkl4T0FoOUtEaktidHdTbWo2OWpac2ZG?=
 =?utf-8?B?cXB4a3lLMFFxdTA4MU81OVVVYTVidmZMa050bkdBR3R1akFEM3UyMmU4a3hR?=
 =?utf-8?B?clVSQ09YTWNiNHJvWWNjdlZ0NmlqUkNWSi83RHI0TmNEdXBKblFEcUEvNi9P?=
 =?utf-8?B?ZE1XNDZxVWk1bHJhb05lVGV6aUhuSzRsQjNnZXVpTHZSS2Y5OUxHa3lZTU5v?=
 =?utf-8?B?eDhPcDNhdHFNQ0dkWGxnQ1hzVkM1ZGRsVlZQbm9CTUxMWmIyVldkRGVzMUxW?=
 =?utf-8?B?cnFycndoRE1DZ2J4a2ZWaGVaUTFXR2VIaGU0SzBIOUxoRHllRG5JOXZFbGRN?=
 =?utf-8?B?THAwMkd4ZkRUSnBqcHFUK3hDMXJXeU1TWTdFYkdKWUtoS0VuTjFPZEFZalMx?=
 =?utf-8?B?SXg4bSt2VVk5MWZZY0FxYnJ3Zi9pWVl6YmpqZVJETEVIKzdWelhZOThKeERv?=
 =?utf-8?B?bzRyM0t3VUZqblBBaVU2SWtiZlVyTkk0UCtsSk0wUnU4eHhNdkRjT2wySmd5?=
 =?utf-8?B?YUk0dG9PQ09zaDEzMjFkWWQwZ2hueDJmbUFBYk9JUEZ0STZUM1o5cWJhUFZG?=
 =?utf-8?B?UEVFN0F1SUw3S0Z6emNrWkhJWUlaZWl4MTRJZGNpb2hhbTZtSWt0Ykl2cGx5?=
 =?utf-8?B?cXNXc0J2emVuUmRhaEFMYXNtU29VdFArZmtlV1V5WlVSbGdKdVFuQmpPTTQ5?=
 =?utf-8?B?ZHhLNjY5QVBFYkZuZUhOL0NPbHRLSXA3T3NwS0FDcVdsbFBBU1pRaGFPVE5I?=
 =?utf-8?B?cklDQ2ZsVDZNRS8yYlRSMEJnamlLNEZMZWNJU3hPcTlzajNTbEhFRTV4Nkcv?=
 =?utf-8?B?VWVOT2xEdnlMRXBLYmI2bDlEdG9mTFl4ZVBMUmsxU3dlV0FuRWtibE5jQlBS?=
 =?utf-8?B?UnBaMlR0dFVjR28zcEtobGF0L0pjSWRmeWU3SHp1eVQ0YWRQOStDYXpITEZP?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9531b3bb-5499-4449-26da-08dbc9490304
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:26:02.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYpkPQZ64efwBZj2m1QZMiL7ghnxuUR6uDYj8IQUzL/UuQ70veGWtErYAQPvw/JfQeAaQo2u3G/9EHCQsJAI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5305

On 10.10.23 02:36, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Richard Weinberger <richard.weinberger@gmail.com>
>> Sent: Wednesday, October 4, 2023 2:54 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>> Cc: xenomai@lists.linux.dev
>> Subject: Re: Reminder: Xenomai community call on Wednesday, Sep 20, 2023,
>> UTC 7:00 AM
>>
>> On Wed, Sep 20, 2023 at 4:17 AM Chen, Hongzhan
>> <hongzhan.chen@intel.com> wrote:
>>>
>>> We have the Xenomai community call today.
>>
>> I'm lost. What is the current community call cycle? Shouldn't be one today?
> 
> Sorry, I notified you via email address Richard Weinberger <richard@nod.at> about the meeting cancel.
> I would notify you via  email address richard.weinberger@gmail.com next time.
> 

Go via the mailing list, just like you do for the reminders. Then you
don't need to worry about individual addresses.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


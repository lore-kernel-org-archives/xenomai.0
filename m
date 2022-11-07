Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC228E8
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 08:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+SNW77MEUMDzqFM96hzaG0BxdG20unXA0OJkvEYqKPGVdaOr7gc0y1H36lyYyYibilSOZu0ioQ+CGnVhQISHRlJbzydt4ta3KG2uv/z65Zc+zuTWifPPVcd5BmdaVsTqU5Kl3UAyH92ElfkHN4fkyL2nWaMO1152Zpl8ZBkxK0CARwe3s72dFzuyelwHjxM7gyjg2Cl9RTLw6jb/IYXzqkhF76V42fLfZuuGHDlu6/TKA77CSY9T+TLKANcD1pmF94l7A1TpUsz2LklxT+NVlK0XY8NySZnPrXdvfUpp5PWqBF4IbKQg+YGfIu3U2LOUpoxJ9UQsmF0SO3346Ryhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK4ESOtB02yKTH+j4P3Ka8FRf1GMYG+2MHXM04fFu84=;
 b=S8eD1zobj+WJHJyrN+jzvnLkFiF3n6z9YPawhoPaan3jIiphEhiRbLMQ1tc4WhdZ/pXpg3s9Chb47rej2cQPjM8TbndZLp+IXr4naJxJ39na6smPXDApB3dZzcb3uCVs+vYLrrgGbRLHq54k/hamRPyPm+yfTB8USqe+Jm0ySbb67bUY+9thoDXDFGp/JHvyQc0QI4K4FG2fZJdXIX39E3seoCzjDDDPEENVY76sAcDjvVX12DO4lwALQAPSg8cbgbeFPArycl0Nx6JAZongKZeFJT0kq0ysYH3G6bFvX9Oo346DaA135dCkuDhloQ5KIHHNytdKJC7IoBSeBfTYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK4ESOtB02yKTH+j4P3Ka8FRf1GMYG+2MHXM04fFu84=;
 b=ljeEI4OXmvUJwA89RXsbjrKYvx1PqLeepEq5aHcuV4DnOLEWXI9ysCpWEbiGeRB7oYe15cSOxE+SQy/InR6jPhsVzssnCwUXv7O/m1T4oo24bDV9J4qL/e4zPI6TRuTFhhc2tYsP99zCxWQOQEqjXSMPrmEIERBakpdfYLXJ2adIsOQXq0XSJIi57x2fI3hAnT9RILjVNAI8KaGDwHGO503Ot5q+29TpPM9ON63dEG4ZPARc2xwwA5lK7g1NimT/zr9CxW+P+tDUDjmjs8X35NqXGL6zneNev5yh/1FMRrKPXb3FI2tf8DQ5pPQK6PwzafxzRc90B0LoeJdlLfWcLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 08:42:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 08:42:40 +0000
Message-ID: <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
Date: Mon, 7 Nov 2022 09:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
In-Reply-To: <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a734f9-071a-4050-d354-08dac09c0781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b84Uqg+6xmQ3LtnAZV9eZac4kse8OQ96Jaxe+jIAcFOJp9sKaPWcXpDSsutD0KsyDAlhRmLE3J0ROuz6edOOkCx+2P9HHxAEilizGloRo3WAs4dYRGP++nJFb6ZZYc3ycfybpITQamAQ+rmzD8fHcbIXmCM9FlvTZbss8GHzW4QSYbOE0hhRAwwUjysmtv63nbrs+PVdGGZujuBgKXpVEA3s6IyX20FOM31qqnhNQWKlfmYmAUXYxHwB4OKat7atOgUaj7kjifBcJzmUiE73ni4JedxTNpn/AAAssu3ZtZ67HnmzB3CInP1SvK0ujO5tEZEzACiW/qJj88yd77Gos8aAZW4vBSfi1gLmeOc/Nl0xTv1bbVPoE6n9UICtaPffalTc12FPJNcbpLXGjwZl5bjjeF9vVuMFQz77vGRe5Ang9F2Bq4lcj98o+TXZqOc21Zm/D/jKSI9rfhu56Bzv5bfbKlWK43gSj89rjCXMMfRUPC3kVl5siSfJFI1a72lREBetIZTwtRdBZpMWdmEbiLZ8EG2uBCnvRZaInqVkDmavOI/+ZdWyBhZZSW8FlC+LR2TbMZjuKSLGqSFmBLWyog6DoVgiQEHyNIyEkPh93cDdze9HAFCd6v/aBJcSAt5Slygf1mpcT3wtj5OvQ6DoA0XUC/zVz4O6+tkjDx/yOfLKuWNYERLjS4LwO50DOfvSKqoiLSQo3g31AfHJ7XdcHyxy/yGq7z4LUDVgwbbagcglxvSlLy6dcajYqihqZdO2Oba8M2HqOmzCaybbbGA6/6ICVvidMqqCwMxP4CvLTpg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36756003)(31686004)(38100700002)(86362001)(478600001)(41300700001)(6486002)(82960400001)(83380400001)(31696002)(4744005)(6666004)(6512007)(26005)(186003)(6506007)(44832011)(4326008)(53546011)(8936002)(5660300002)(8676002)(54906003)(2906002)(2616005)(316002)(110136005)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJ3TWVKM2ZoSlA5eVZSb0hONXExeUVDUHBhYjVsOFVEdFhNeWJvcGpScjFw?=
 =?utf-8?B?THQwNUp0VG8rZDc1ekpFOFhveGpJN0NpWi9QMUZYR3lLdUl3NWp1T2dYWTFP?=
 =?utf-8?B?SzJ2NFJqTG1DaUdZRU9LRUkzU292RER3elBEcUtzVkhaS0pzNGVmVWFZNG4v?=
 =?utf-8?B?NElYWGtCVE15UmlLQ1hhVCtyc2NmeG5BRjhrbEVDRUNCdC9GYndBSm5RRUJk?=
 =?utf-8?B?UThSaTgvVmx0bldISVIwRVhSVmtDRXllVlc0N1JPeEpNYjJTaVFlWDUrWjVy?=
 =?utf-8?B?emVzTGxhM0FhdjFqbFc0L2tyRSs0TGo2KzgzN21aWTVkeDFmQS91NlpjQmox?=
 =?utf-8?B?OXd0NlYwK2NoMnhTTURjVFlTZlBxSmVSUy9ER1hqMlNxeitJY0JFSjdwUXJl?=
 =?utf-8?B?YWo4YmZiTkVNdFdFTlZQUVZKbm1pc2FVUkpiTUIwaXNwSmtHZHNINkFDcVlN?=
 =?utf-8?B?QUtGWm9uaWdOSVRSU1krUjd2U2FrQXkzUHV4YXhnWDdEUjVrc2REOHhCMHdJ?=
 =?utf-8?B?SUEzcWtBRE1KSE1YUU8xMUpwbHkwdHFHMGVOU1ZLZ0czZGw4RG1EaVh4QlBp?=
 =?utf-8?B?d2FKMG1OS1RoMjQyZmlLVnBlTFgvREd0K2VqQnRTaFpMa1JCNVd4NEpYdTZ0?=
 =?utf-8?B?dlBzK1VXeDdBNmhCb05XeXprdTU2VTFkdVBHa0h5dTk0YXl1Q0FEb2Vwa2d4?=
 =?utf-8?B?SG9ScXAyWTBVVThWNUFRb3VERVVYOGFDTG4zOTNsaGJoa0lmVXFVeWxvMWxQ?=
 =?utf-8?B?M2c0aDNQRW5vd29ibGVFZzNSbEQrT0E2NFU4K2ZPUksvb2gwYndpYW1nNCt3?=
 =?utf-8?B?MmFsRE1vRm94MU0yRDBrNUVmK1FlbkRIdmdMd3g1WUZKRUtRUHk5NENiMFJF?=
 =?utf-8?B?L1hFQ0x2ODF0UUtUUWZEOE1qdzBWTlZXVVcxT3d6b2lrdnF0MWYyR2x6SE1r?=
 =?utf-8?B?VThXSGp2MDZzSDNQeXFYNVZsU2J4REJzaVRLRG11WVQ1K09hNWRsb3QvT0k1?=
 =?utf-8?B?TXRoZ1JBbHVpazRrc2Nmdm9rVmQxdHVyR3gxRE1yVlFVb3N0VzdBejYxZVVx?=
 =?utf-8?B?eFpnM1dYMWVOZ2hLcE1VWnNobGxRUkllZEJnNzV3SFRiUnFDOWMvK20rUDRE?=
 =?utf-8?B?UFQ4Vkd1MklXcnFPZHRWc0g0YzlwVzVlUDg5TkhTSnJFZjVIMFVoNThla29M?=
 =?utf-8?B?dVNsU1E5dlIwUjdWZG9nSjVBQUVoTWErcWg0ck1VOWVUek1ycmp5cE0wYWxD?=
 =?utf-8?B?dzlBblkzUmVXYkpVV3BtS3p5cXpGZkYvR2Npbk9wTGRZb0N5aWpmOGFqVVlL?=
 =?utf-8?B?bnBZajc1RUNac2VMSHJKYmdQTXNsdWJ1Q0R6MmJnZ1FOZkdmbTFIU2V4RG5y?=
 =?utf-8?B?WVFOemJtVjhJaTdZR2xHSnNmSG1nbGNDVVNZTVVJcGd2bmNsNTFPcG91MGZ6?=
 =?utf-8?B?clkvSzJSd2h0ZlZIT1VPNWlXL1JodjFKbklKSSszMlFDUHkyYVpoMHlsRWt2?=
 =?utf-8?B?NUg1Q0c1MFF3cFN4KzBCSDBMOG1NTFZic2ZmTlZqVG10SnkrL3hFOUI1OVUx?=
 =?utf-8?B?Yy8rdVRrSmJCODJmVG1qTzhyUUVuaE00UmNvOG1aNmdmUFJYYjdWbTBDNVlq?=
 =?utf-8?B?Z1A5a21lR1FxWFZvNjZDSEQzQnpTZENwRDRUVkNLM3haSXdsL3JLend3RTVv?=
 =?utf-8?B?c0svdExiLy82TFVtenBqcnRoS3IxVGNUcUcvaUYrNWpXZWRLb1k4dHBHM2ZC?=
 =?utf-8?B?SExqWDhuYU1CYjdvVnRBVGl0Rm1pOGJXL01jUFhUMWlnNllZcHZWZW0xdjBV?=
 =?utf-8?B?RkVFMUxKUnVWZlo0elpEOVVOdXRQWndEeG0wOXBWMjhPRGNUejJJcVNEZ1ZL?=
 =?utf-8?B?MkNocmVsV3RPdnVJTGpiQjJCM2FIODBrR2hhS01ZN2ozUVAwRUplc3Fkejdx?=
 =?utf-8?B?RGlTRW9ISlI0bysrQmFCTi94QmQ0YnBEcnZMV24vYi9OQUYyS2dWMDU0djVB?=
 =?utf-8?B?dEplMHIyTFNLMXhGaERFbWZaY3NhQUNNdDlFcmpIa3hBL2o0NFZLSUFaa244?=
 =?utf-8?B?VW4wSkFGaHZhYndxeUIrZHhldVBQQ1ArQWNoRnp3bVRZeDM1R3ZqUjFMWnlx?=
 =?utf-8?B?SmlMd29iQ1FwWEdCWWpMcEljM0NDSTBKUkQ5OG10WWZUUXQ5SFFGakhnOFFo?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a734f9-071a-4050-d354-08dac09c0781
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:42:40.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyy5MTDTPIxt8mX2TDvdSeDmN4YuBAIPntDo64szyqEoePTHKyLr3ScNUMChnBUgAOKn1SbRuN/kW6GPiLPn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7069

On 02.11.22 16:48, Jan Kiszka wrote:
> On 02.11.22 16:34, Heber, Stefan wrote:
>> Hello Zqiang,
>>
>> We tested your 0001-IPIPE-ignore-xenomai-FPU-operation.patch on our system (Linux-kernel 5.4, Xenomai v3.2).
>>
>> This patch makes the problem disappear with our tiny testapp on our system, too.
>> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.
> 
> The patch is surely no solution, but it points to the direction where we
> need to dig. Unfortunately, I still didn't find enough contiguous time
> to start that.

I'm starting to understand the problem:

Somewhere between 4.19 and 5.4, the kernel moved FPU restoration for
incoming threads from the thread-switching code to
prepare_exit_to_usermode(). However, this path is not taken when
switching in a primary thread, at least when it's coming from secondary.
Need to look for the right way to account for this now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


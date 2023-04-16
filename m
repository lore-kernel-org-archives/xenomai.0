Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231210FB
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 07:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VONZMBwBSRaLkYXKHB79OwSGwU54c5fIgabxFFWvw6CzpfUHaIjc/bM6PWQ/MxpKz95eP+OPDZHH2BvYVONEx1OBbZGRL1FFau38SF34DcsZ2cmnoig0hNKeIaZCtzUy0z6xdyHtKVRjk9FYQPXcK/kRyVqiSmCWIr8E4BpCPx7PiccbVaHkr9ErwJ4zv3vevjX79K+qLslLy7LTDlSxGv3rHVXzvgl3izwlpFdLu3WQqsPqng/mSPYCP+sTM+MSQSGpLC4Q7WmVvw2WCtzs7MTQLu8K+oCOn+u+puHSyghNDEMw544m2No3Po8BixAf1ACDSf1CFc18uNy4MmP17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfoctwuXTme5iyELKBcH6FH5pJouFzNSEN268zzaH2I=;
 b=c8lIsiFTzVwl4QxwgyeiVuP9uX+xnh3JAQAbBKSCB3XLU0eKAaF8NWDQ16mt+nX4BUje5LAWLCMsf2NHovS+GS05mTUxAt4MLvq2QGHhtpLrm1d54jPStvoI73rLDPU25eoPAiQ+7qmU1sieqjCIzsoaCm9056KeF9TJ/FpsxSgCjEvgz5ErfLQUjPHs/KVF4zmxcRNxOeF4CEuOtcrgyMxVOFjrHb7QZUn/ZAqn0WvStuBm7vImjFOEZjQLvAtmcq/zJ9XjgzhKourd0vlCpX9+sFbDYh70kcVRd6S/2CmoJr+BDnmtYQXtwBk5e6RwUe+cOaam77QBYBJ2H+DllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfoctwuXTme5iyELKBcH6FH5pJouFzNSEN268zzaH2I=;
 b=VB8ib391ef6hJq/X040LM2/NZEQ8ML5xd7IIOHaHu144JeQ++OlZlDKEtDO7nf4qxkWbkLmRzq8TnNXKh4jETo69hPjMS3HRMtMD8kdMTEy8op/+tOTZMRtlbjcgoilQeenFRjvwlfsV6zIyyj89Gxc1NQTbF67Yw9Xx1mnHcZV5eZoXqmDKouVD6jqgMfhAP/Kh4qV3yaECb3rcHELgG/mHviRwvLkcsAdUV2A2jKTbHS/k9CIL6dAzWM14lbg3J53FDjdHCredN+A9IStsV7BMjaU9DevqA/RaaGV3XCqd8sY02pH8hPMKvhAAxo8ZjFFhBvu0ISaXM9aovuZimw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.17; Sun, 16 Apr
 2023 07:32:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Sun, 16 Apr 2023
 07:32:54 +0000
Message-ID: <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
Date: Sun, 16 Apr 2023 09:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, florian.bezdeka@siemens.com
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c1602b-e860-48df-b0cf-08db3e4cca58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Go353ufFJ4P9hBPW5nhVbVE30jw7OYajp7+LRQeUYdLOcRpP+yk/DBR0pVgYOIG46685LSBwBQKUzfxbcKRUetSzbQ1C1dkM4Pkb7pq5vTAog9MJOx7I7iVOPKShoPhJ7P7Z+I7hLMC8JGpC6tXwJbVl+hK6NDCC7a1V39i/kD0aNgOBU4R/emRVX3OecS8PfJoO/6+1MnKqDfOJ7qV7l4EZR0dF/Jsh8dUMNBk5f6fjiIyeZPfVJhJEcGg8SDwfYKHhjuENLrmNpAr+WR4uHVA5jykkS/0/ufRYLWO9GJQty0Hsp4yRJl3sy+LtI8FJI+BHvF3W1JAK4xo3MBA2huPgi87vnyrwykKOfeR1QSRaZ1OwATSfq8oFq/Rg8L7e12sZCjAsBuy1A8BMkLnc20bj3Od8+0ihqSRZxRgbZozxa785Pw1togtlWqVUknDUANxk61vDTMwouFJJzjdKQca76CF2tBoA2OF3/aQuRNFlYrFpaBpAnDfTojSii2GVwXW+oOh/0Cz7u21V0Fugr+Kd2rHynLvKYziGVrawh6fh3wTEua7CsZZyZOEA6561hx0Gpr0DpzGzOiXcO/mIUb+Q+LOb9HdDC3jNYCYXJbxxDh+jAMb/d/pmuFOGBnCoPtJYh5v7Xa8GlgTpGU/eBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(31686004)(4326008)(316002)(66946007)(66556008)(66476007)(36756003)(186003)(53546011)(6512007)(6506007)(26005)(107886003)(38100700002)(82960400001)(2616005)(5660300002)(41300700001)(8676002)(478600001)(6486002)(6666004)(8936002)(86362001)(31696002)(2906002)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTY3L0orNlhRUFNZZVRDR2NwUnUxM3R4NENTcTZ1ZDZWczlIeWFjUUlMbi9C?=
 =?utf-8?B?OHNMbEZvNFZvbzcrWWJEN2hQSDdSVldpbSs2TlJtR2VXUGE3Rm05WTc1YmNX?=
 =?utf-8?B?Zi9FdTBDa29mcEhNT2N1a3dQNk15VlhFK2tnK1F1WnFya05YY0cwYksvSWdJ?=
 =?utf-8?B?OHhlOENpb3RGYTYwaDh0OHhvVVZzck5IVWxyTkZPS1BTSHhGVmtyRUFTNkJn?=
 =?utf-8?B?V3RCK1VDVFd6aXV6djF1dnhkeUxJVzlSWWFLOHRwdUlGVE9GNmUxckVMUU5y?=
 =?utf-8?B?RWtaMkxNOVZML2U1M1B4eTB6WmZLaTNVbm9mbS8rM3l4RXk0dXVPMVJXQ2FT?=
 =?utf-8?B?SG0rcExUY0Y4aHNjZW83TWx4anRHL2w3QnFQTkJ5WE9iRDd0THdRYklJYXNa?=
 =?utf-8?B?bmNkd1dkUFV0WitWWkhGNjRxZ2tON2Q1ZG9XclN4M1pyVU80SGw3cXB2eU81?=
 =?utf-8?B?Z1FPVU9MR2lyL0RCei9oZ3B0YVpWSGQ1R1d6Zis1dVZnUmo0NWtYUEhteE8x?=
 =?utf-8?B?ZDh6dGRyWm1NcHdRbXBwazVFT0lLUnhCZUlIbGN2SmF2dlJ0Vmh3WmI2U0pB?=
 =?utf-8?B?eUFoY09obVlqUDhtaGc1TUNIbW9DaUgwaCtQQVNINTBGbUJIRGR0eTMzWkFM?=
 =?utf-8?B?S3FJaDg1bkFzNWdwTmllMi9IcjJsaXlueEpVNS8yd3pqNjBkSmIwL2xmd3BE?=
 =?utf-8?B?MkhFcjRFVG9lMUlVMldzVkx2b1VkS0V1UEVZMVNtdlVzeEQ2UWF4d0U4RE02?=
 =?utf-8?B?UzNOZk8weXNmcVVyUnorSStlMHJ0ZTVYMXBFd2NQOWJFOVVoUFo2OUFqTkZL?=
 =?utf-8?B?aU5FL01jMzBZbmd3OTRJeVJqQWxxeFhNb0dmY0Z3V3VvMzRBYTlKZ1dCUE1q?=
 =?utf-8?B?Y2h3RTMxRFM2b01yWW1WaEVtK2FHc28vRjVqUllRaFFDekRZTnJGUFRkUzdX?=
 =?utf-8?B?amxhSk9SZW5CRjRjRnl1UXVVWXhpL1llajM0azIvcW1iaERRQk03Tm0ySVJQ?=
 =?utf-8?B?ckJ4V0Q4ZE1zRDQzYStuaVJpWTQ4RGJja3htOU1Jc1NqcEpBTTJUZklkQWNS?=
 =?utf-8?B?T3hWeU14ajJyK09xd20vVStGR2l4N2JBcks4cE53TjNxc09wTlpqZHptOUFJ?=
 =?utf-8?B?UnBIV1BpWHpjSzFJcXFZMThTZUNTZGtCZHgzVktnNzVzZWR6U0dNcUlrM05r?=
 =?utf-8?B?UXJVMUpNazdLSmVJcExiVEJmTEdlUmtSaUhhRHpCNklHQ0hkM3F6WUxLSEEz?=
 =?utf-8?B?Q3NYVllsOHFjRVMzYjJ2aUJTZExDSW1EUnFSbUZjSU9JOTk2dG9DRDJYd2dG?=
 =?utf-8?B?WlpVWTVBb1VHL2U0aGVoWUVWeWlmazVVVGQvS1YzWm5BZU82NC9acktETkZv?=
 =?utf-8?B?V1NLTkJjQzYzQk52bEtiVzc4U0NiMGdQUHFyWHpFQUZoR1IxelRwTUo0cGJp?=
 =?utf-8?B?TEJJbDV4aWlURDhPbk5OdVBscVZpMmlBSjdDeXBIOTZXdDQ0VDlRaVdjODF2?=
 =?utf-8?B?c1E4T0N6SzIrTVM1K0ZIR1A5eXE3ZC9wYnd2THMvbHpQQVhwRDBqY3crckcy?=
 =?utf-8?B?azQ0QWl4bjNZbXloT3FyNk9XNmtDS2gzRDRsc0FxOGV2MFM0L1hxR2x2YkFU?=
 =?utf-8?B?b1hCV3dpak85NkcybzZrS3FTVHpWUnBGZ3J4OUxjTkZvQXdlQVhxRWp1c2o1?=
 =?utf-8?B?ejAzNk5hdk4yYkwreXhEQ1dVN0hlV1VtNWFKUzFjWEJvelB6MndoSUJFQWN4?=
 =?utf-8?B?NjZRZS8vUTNYUnVMYkJEVWtGcVltY0hTZnJNcDQ1M3ZxUExGZmNUaWNOTmNr?=
 =?utf-8?B?WURsRWtTVUNQNEtGSmpIZnAwZkFyRk1EZkVXaHFEcmxLZlBLNzN1dmNrNTZE?=
 =?utf-8?B?Y2pESmZpVldaM3doYlZCVUQ1VmRpeFFuN09FbnBqKzYyNUcreVBKR0RQZTcy?=
 =?utf-8?B?akZ4MHJFZW15dzdkSW5VbVVYZ0JWSXdvT2VSZDVjeWRuUitFRTFqTGk3MWJH?=
 =?utf-8?B?N0c1Ly8wQzhDanQ0Qk5CcUVSVmFKYUNMdURHZDdyTm12OXRlWUZqV2dEaUg2?=
 =?utf-8?B?ekp4NXdPcDBpK1BhUlpTaldXS2s3aXQyZkJLZmkyVXhPSUNZQ3FaTGFRNTY3?=
 =?utf-8?Q?kLqJispXq2aTpF/qLRNmCxKsV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c1602b-e860-48df-b0cf-08db3e4cca58
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 07:32:53.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI37pk+zr+/Qdd1yREicp1R1x7GGbt1cLkjT5MVxLAOkWdqvDYudgD5OyjjFEdBLUWqDFiGsnVpiy22ehm/VJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5313

On 06.04.23 12:33, Aaron Marcher wrote:
> This patch series is an attempt to integrate the currently abandoned
> alchemy, pSOS and VxWorks tests into Xenomai's test suite.
> Since each test assumes running as own process a test driver is needed
> which executes each tests separately.
> The driver makes use of the smokey framework.

...but it does hook up with smokey, thus will not run as part of
xeno-test and our CI. Please fix that - after either resolving the
remaining broken tests or disabling them for now. It should be easy to
spawn the new tests as separate processes from a smokey instance and
visualize their results as part of smokey.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


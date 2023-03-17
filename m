Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E973A34
	for <xenomai@lists.linux.dev>; Fri, 17 Mar 2023 12:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odN3FtSDp6AvXB/D8fdLXSLN7eSlUbRdqy+2We/uZK0L8qqxUqBZmHTgMBtzFc1aJCNcuhp0F416jOob69ErQU0aya881mDs6oxpzB1Qku5++Do0sXh//f61pF0T0OF0kvrubTA2rnuxpa0I/y82VSeY3mnuOUQ2cZXCGEn2oE9dvH28lTJZ9Ni4iWEQiZ0lpCjL3Z2RJTVjqC2aCLV4jZaAAbPjSspdkwt3+Pmswr5QQr1ZHF1TQzd+6+ak/davw3Rcro+X+JAaetpd9N9SgMGtRZt4yKkpsNqYo54BIkOe8NzpjTXltdiADYgknkFaqUCAn/KWCE8f+D4/Bm9d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXB46V8eHTBcS/uLAjImPhKJZXO1FMG8k+IAjLtYK1g=;
 b=mX8uCJwGlM75US9Z5tW5ZNfrnAdjff88iOz6eNV+ZYSJdmPorqi2DrN7rhV4OnI5rwbJS0j9gWTmq6R/O1XLjrBu+15/W9u8Y6ykAvBMy3tywZutwECDQtIYfNfoSDQQxq8klSe8HIggAe3xWOLuk/13FdZm55FvsMLJ46grqRmAFrYhuZG3tYqzuGlL1FlsTQqafd8yg/+76rNVx/Sx6krGUgP2NAuKr521abjxc2nk8P90rwCrwLK+tYnaJMDTSr8o3ZydrT+ogpmPHrZCdAA6Fl8fxys0D6J7gePt2uJJRFgZbSpvvCKAoXkUjXWL/upf67uf5dzAQjIYw5fDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXB46V8eHTBcS/uLAjImPhKJZXO1FMG8k+IAjLtYK1g=;
 b=z+DQmyxZNy4JjIA75apdDrXbUTnGHZCqkvwCcP3dXMAtWPHlczydeBtcHzfA3G+CJUTS64E0jbZDOIEwom0oUU2i0NNqKk60IQaJrmlR4wLv4rrKBpvwn7p/CTX/2PYBmhC6YbyathTQSaW9I9kwJTYLngvEMcN/64joECRh3uwS/a5f1cAclCSo9yUH0jFkNwPGfbSR7CrNg0MJ+Owrwy6miajfyD6Kn9UpOk7ngiG8uRzYfUQljNSlpRt8gP1vqpDbK+eUvyUL8r7ZPDzOPbnNzmqWlU0HA2rkFmw8B65AmjJskvN0ZU+MIY/lVRsdvws5XC4eoNR39rGjyOkFDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 12:53:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:53:19 +0000
Message-ID: <7d613388-9300-1265-60b0-2efe18167d0d@siemens.com>
Date: Fri, 17 Mar 2023 13:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [xenomai4] Sharing information regarding RPi4 demo
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Xenomai <xenomai@lists.linux.dev>
References: <20230317133249.38756e92@wsk>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230317133249.38756e92@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d681f-aed8-43db-b87c-08db26e69510
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YPtFwZPcZj51r9k10mKeiDbU8FYOvJvYxFT1VtjtBpUGulheVIlvP/nAF5ymoiqINFfr8dAfRoxoHwcdasrNbOvWoxohTkOhS+I28ZGebrrzm3Sh3p1zxsoxBK4VzxMaZrvGG7K6hm11/+BoKnDXhO2cDdtUqvm+YHUAgm1a9rNZ+TpbBIm0xtAxJa1Zg6H5Harbu8I6GPCnKLcWwoXiv99Zgzju70E1FaNNQB14ZoGGIaGPLjB//mMZHnFuAlqS0mzH9gL42wGXwy+nkpnSxFJNHedhtTcVGjyclTNqeE9jB8GnFiJZxFgmDdCItloVriEzZTiS32blCA1Tvc89/XH9B+v/eSCkQQlMetn0RHOVqNlC8t4c1+R33IW9rgy1xaTnqF0hv0znPOee6CI5uk7HayvwiyrnLFp3XwMjpPp7XjJ+NJ8VJpxeiPj/vJKNuq14IhTLTun/yte+/2EyTl1hLioqxscaeeyI24X0D7adh9gFRz07cFSKtIbTegLZjOfs/uMVZi8X7WfeuPg0Y6sezWmW3facD38oG9fkQuQ8t8t+82FJsmSxTl/nru+vrslJpAAcWpF56PrmJqSRqJyL35IiIHOXC7eDyKUXfTJIAzjoOEATFwSun+rv8c4m09MOqc7eUequXYMngqGOAU/Q3UBvczdtkJL4qpbVTAp2dv5hsrBlJ2ZpEsMa9SgTYeGjGGvLgPqQQfW3XGSv5hmll6jQn+aOf+Y2u3d8SmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(5660300002)(4744005)(44832011)(36756003)(31696002)(83380400001)(478600001)(66946007)(2616005)(6486002)(966005)(53546011)(6506007)(26005)(6666004)(6512007)(316002)(38100700002)(8676002)(66476007)(110136005)(186003)(66556008)(86362001)(41300700001)(8936002)(31686004)(2906002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZUVUtpWkpuaDFJUlZveTA5OWVIaXBMUkUvQkhRSXdLbmw0UVk4UVYyT2ZT?=
 =?utf-8?B?N2J6eFdUWTR1S0RkVUdLOVpRR1hvZC94VE1TS05sQXFrSHF6SmhvaVFoeFFn?=
 =?utf-8?B?aGtCNEkxQVUwNGcrd1FiWjFQTDUyb1diejZ1WHFVMTFUQXVnaWJRNmFZS082?=
 =?utf-8?B?Y2M4UnBndm5lM3NDc1VteTFjKzhacDRlb2FlZDVYSEpKY3hpeWo5UStuaFNP?=
 =?utf-8?B?UC9DV0tPYXZTV2JmYjVsY3lEaWhtWS9nM0NUdHEydTliY29OdnBCVk5kc2pJ?=
 =?utf-8?B?eVRmR2cwUXJOMlBDUExGQnBuSDZnSUR6SHIzQndzNHBYTEw2bUhLV20rYXJM?=
 =?utf-8?B?SStUa09qWm82Vnc0WTFlNzFzQ1Z1VklYNVNtUGg1ak0zWkZvcy9JS1FFbzAx?=
 =?utf-8?B?Wk5LUHlHV21ta2FOQTBhNGJTMWZURTdpa21hSU1xY1dFNHdjakxRSEtiS0JZ?=
 =?utf-8?B?V3BaNFdOL00xZWNOSGxyam16ZDdjQzAzY1pDdGJrQ2xOZlBjT3NsNGl3Nk9T?=
 =?utf-8?B?UFV6NUswRzc3YnV6SEdQWEs5RU5DVWgyenJLRlZuRjZTSFIrRkxDV21YVnVt?=
 =?utf-8?B?TUJjaG1zNWg2R0pDdGlzT2ZLU1hnNGZlQnZqcUVrWFFUK0xoUGtPN1JMSjdp?=
 =?utf-8?B?K21LdHBvVGdHY212dVFCdzJKb3k5Z2ZHZ0NzUm1oRWp1ZUd4YWpZS2MzNElm?=
 =?utf-8?B?WkJWK3RhaDJYeHZpc3drNDQxQUU2NWtiMWtxZkJHWWl2b29TWDFTaG4yNDRL?=
 =?utf-8?B?cWkwZWdMVTQrdTdRQUJiNGNGaWpsSElnMmNsTkFYdDlFZThxTk9lVjFOYyt3?=
 =?utf-8?B?elprQk1HZlR3NmV5NmRnYU8rTXZidGJjYTBVdlhCOGZSUlc2WEozZmpxYUx4?=
 =?utf-8?B?emdOditpUTRNZ3NEdEFkcEtLaFo4RFhjZUt1a2VNSmRQWUxjeW1CZmg3Mkpo?=
 =?utf-8?B?VVllcVdlOHJmRFFncGk4MFN2WkU1QTFZS3ZDMVpGbVZGL1JlSHJldzNDVU9m?=
 =?utf-8?B?VVlLMmpqZFUvdzVKM1pwRnRmR3E5M29NeW1ZY29HN3FRUHlxeldzbU9KMSts?=
 =?utf-8?B?NHppNm5tTXRBckZPZ3luYTZXSnVyWnhDekk2Ri9CZlBzdGd0OGFaTDFIWUhF?=
 =?utf-8?B?RFYzZnphYjZqd1RYcCtCeTNvT0FnNXVraG9NNGM0VlZ1WnZrTmNBSWZMQzly?=
 =?utf-8?B?K3pqWGFwdFkrUVRXYzNyMEFGbnlMdGpiczRhMldVa1FuSTBpWXVEV0cwYXV1?=
 =?utf-8?B?aHZHTlZNN1FhdjF1Wm9lNnpPUHR4aW5UcHFaTm5meWxkOWNVNk1XV1prS3Nw?=
 =?utf-8?B?dDVDajhEcWdUY1o2WURRUGRzRXI5K0Y5bGdaTDJva0owTG5PYi8zMk5lMW5l?=
 =?utf-8?B?N0NUb1NLbjFjZTJZaU93OUxzZkhEak0wMGU5TTcrUFpYeXc0UFdPOVIrb3hV?=
 =?utf-8?B?dUpjaTcydTZwdXlHOUYxYS8wTS9oWk53WkVzQzBIZVA3Y3BKdGwrZllUSC9L?=
 =?utf-8?B?MGlSYllsNHJ0a0hIUnVrbS93QlNodFoyOEJlOUp3d1E3SWxUb085QWpvb1JQ?=
 =?utf-8?B?TnRXL0U0cXUxTzF6MWZjQkI4dXduV0ZGL2dqVjVhZG8xK3FPOUg3eTAzNUh3?=
 =?utf-8?B?dUVtTlVPQzYwM1JuZXFDUW9zNDZxOGhoeG9rNHAvRHJvaGNWR09hR2ppWkdC?=
 =?utf-8?B?R3BoWUZZZ09xNTJEdVlkd3pYVTJXN1lETUk0SUVDWkt3SnBadEpyZHpWNHR0?=
 =?utf-8?B?dmNqZDlVVVRkNllOMjBPRG00K21laVY1L1JWSW0vbzJqZWdzUThzYmYvc1Mx?=
 =?utf-8?B?Mnc0eUg5VXhQNUJiay94YWhHdzg1WDdPWFZ4S09PZkpZendWV1MrTXp5b2l0?=
 =?utf-8?B?S2NmdnlVcHpvNW9iTnpEcjB1cFE5Q3c4ZEczWS8vMitoaFRCeGlSWFJIZEJn?=
 =?utf-8?B?QVNWczBoa05ZS2FTWDEvQ1gyMVNzS3RKeU5wTWVzVC9QZjRpS1NpK3BlMHlO?=
 =?utf-8?B?VHRudE5hSHhrdHRJWDRwNjZ2ek9rSm9iTCtNdHBuUkRMaWZzakNpMWR3Wlk0?=
 =?utf-8?B?V0lqdlE5U3NFeGlQUjRnRVNlVHVyZnN5YkFFcDNJOENDQ0RXQlNoQi9qM2p2?=
 =?utf-8?B?OHRKemM1aVV5VXdEVkdmdXZYV3habHJUM3plSU5xcU56Tnh5N0Y1cTBadXB2?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d681f-aed8-43db-b87c-08db26e69510
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:53:18.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmJ7YHkuJ7SP9aJaehm41TEeg2nKAubrHALdBhKjDXGuVC2knxjl2yJMMI0HLGsO3YCiWH8IGZsmKWEqpSmEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6435

Hi Lukasz,

On 17.03.23 13:32, Lukasz Majewski wrote:
> Dear All,
> 
> I would like to inform you about available Xenomai4 demo for Raspberry
> Pi4 (model B) board.
> 
> All you need is to build the SD card and connect oscilloscope.
> 
> Please follow guidelines in:
> https://source.denx.de/lukma/meta-xenomai-demo
> 
> Full Yocto/OE setup is possible with single kas file:
> https://source.denx.de/lukma/kas/-/blob/master/rpi4-xenomai4-demo.yml
> 
> I hope that somebody will find it useful :-)
> 

Thanks for sharing - and for showing this to me live on Wednesday! :)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


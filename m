Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7B1108
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 05:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6/DpsCd/HzzYKv42MDfpeCgtCTST09JiIgMiSDSH456h1/0UL1SSP7tnL5luZhBrkVuS/dMC7R8//aqh/IV1QDJCeWYK4Nhad+Zu+oJWCCG5j1NGGksfNw8VgDIhUlM3SYJPtHdWyd+aMUvGKi2Sr6kd1cF8pz7hYLwJvMHQ3arSUBEhN5dV0CJ/GCAFeyLrvaGYbGaOMx9eLNLez3ufoSCVKb/rRcrQfWqaM6NJuGdiy1p9NIJVLcyp59t4He10wtTyDPl0VjOFfyajM2byQIOau5Ije9YD5Ebt4/ht+4O7FVb0hQK5H+hgUMpm2qbtKigQZXE/q4Aeqly6+SClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ4UlNFDlymx0JLXJCQTEXp1YQolZ7Ke1ruvJNbp0+0=;
 b=S4Fuc/F8MSKzWtWo4cc9XgcjYfcdR/PS1Xef/rPZp+mxVsjZ1FVlrTLeiPn6Ovc8xi4Vz3ojbIaR0IvucGztVvcBpXWzK+d7yICogMnAbc444On/lQmGx7n8xPehGzG8+M2vDQx1kXaNdHVreMAE2FnyEDjg9p2z82keoJDwxDzSCRCv/XDJ7UyA8A0XWrgiOowmcJJ6uN5eie7f1g1ZeLx2LFbZ24SWLjoCSaW6df9pU+bc+hBNIEGAT1YLAN0lskpCzDU3qloeovbFQbaAGmoYUolgGOKPo7fxUS95CmKlm1yqXsN9RGD2aGtfl2PF72ftRdCC19DXeubfqts9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ4UlNFDlymx0JLXJCQTEXp1YQolZ7Ke1ruvJNbp0+0=;
 b=Fy+kn6Bh0jz4bqVU4/JXHyjiKK0FUBTv1nJFiHdVUlGm5MNZbSHtSoRtKj1lb3sKHltNIDcIILCeGQ6Gt/st8kbImMyHRtE2lFshfb2T49U81+/6A2gXszuoA86Zrrr0C0KbhdKUuQOuTgjinhJuqW9sWgdL5Y/vsiO+43/iYQHUJyvVFOnuwXNLLGKdvOtHeB1Qp4SXuK5cd5J5DkWlPybHBRFSauaKneLZPClVDMgj0XsRiuLf6COPCC6C8J9BtQIHgketQmFvafqooPFIOfWFj7SM1erk4UAF+7AaO8WHsfqczz1JELwx0kAGe783S6EumC1nBg4wjbDYsSmdag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 05:16:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 05:16:54 +0000
Message-ID: <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
Date: Mon, 16 Jan 2023 06:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: while loop in a multi-core cpu
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Yunjie Gu <yunjie.gu1@gmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3133:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e24f40-2c90-47fc-8978-08daf780e1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eab6N9BJF/3jWDluLX+VFwe6gSiEx1Cgi+5c3/W9aDWn+UxQ6WEtZpidGIptlONWT7QKYPltKm6vBMsR1XPHg/RRqQA+ljwd5KB8vsPnhjCVDl+lzUp0CQqAzKEb/bcAkavNcv46U+qwOikxLSmZUPOajSwulzoTqnhR4PEsfQo/HFY7k17Wv9wb9Wwcc5l7VlFqJGCx/q+3wV4M+pweDTqPTkmLxLy64EnTvvFYHGSBMnMWAUaZrpaVXJ3/0i4PSR+1GdY/KLTmpppPG0DEQ6ap8CVKVELdi//cEo7AkR1VtV4+pAGW4XGCu5Sgyb3wpaMMDoPUyfjd4DQm82EWhfF+SLZyR9u5/07VdYDWnsKB6VReBbGY6OLJILfM8m7EsPVbRx/tPP4DEJu3b/81n/Uq6uaikc/v2DVQlHc7GWjiCBI1hl4IObCy8alXK2VVwNfkLC6eRnys6NQcoaKAjVKw4cGOVzZ5Pj0PbQniVtg5lAbd3evIfax9KP0Hv5xQbGNpG41lFNbXn05dqXeyNeqq37rFyukBNbLFoVh1nOLPAK01wh2UT8NOJ5F8sNWawXJAro3hsmT2v8u8n1FtjI9Sp/zpogo4TbUSaQ7rID7y4S8cEPCwI438/euverhCPluywnsnMEnjuSQ5b7mvw0QG8d59+RXv11VAyt2tl3xgrb6hYY95jceurDGq2lV2FMmvuvMsAud9JIQaIADc1ZmlgKUN5b2gmz/SnnPnj2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(83380400001)(82960400001)(38100700002)(31696002)(2906002)(5660300002)(44832011)(8936002)(8676002)(66946007)(66556008)(66476007)(41300700001)(6512007)(186003)(6506007)(26005)(53546011)(2616005)(86362001)(110136005)(316002)(478600001)(6666004)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXRMc09VVzhvM3dEVjB5UVVVUjczQ3RiUkpBU0RHRUx4VjRYcVovQTYvanJu?=
 =?utf-8?B?UHM3ekpBbnhwK1UwMVg5S0tSdkEyTXpGV3dEYXhBZVJSeW5nUlFYUExDRmty?=
 =?utf-8?B?dVlYak1meXNlZVFpdVVUSzdraE9qSW5aZmRoSGRkL1o5V1F5NW9BdU9WSkhj?=
 =?utf-8?B?Nkh5S3ZDMU5zQkswMmhCQzVWVUVOVUFxUUVoNHRDNmJ3SWRJYzFOVTk3aXRo?=
 =?utf-8?B?S1FxNDlPRjE3dFg3KzJ6VWY1QXdCYlB3aFNwaUhuUXNvQnlVallnTnpQcnZ1?=
 =?utf-8?B?OUhOWTdZQm1IRlVhYTc5Q2IxMWU5UC9OVmlEMTdxbWgzQWg5UVpPQjRxeS9m?=
 =?utf-8?B?d2Q4RmxMeFdjL21nYlNxbytzOU0vTXpFZ2ZYUi9DbHVrTlJnZGZUNjVXbElX?=
 =?utf-8?B?dGhiZUdmTTUyampidTBsZjFOdXJ1eVdwUlVPWVowQnNxdjQ5YVZ6b2lWSWIv?=
 =?utf-8?B?Y3ZveEk3TSt4MnFYVFhhaW9KUm9RbTRrb0pGTVlLekJPK3BrdFpNRXhPYkNJ?=
 =?utf-8?B?eHpTdFdVamw1UFpxWmlRdWxETldDVFJVN2RBaUdxS2w4L2VKQmRUZ0JSMnVL?=
 =?utf-8?B?Q1hmeFBtR1JoajE3NFNxWEJTOHArYWFKeTdrenA2Mjk4Y3duOEt4MG5LNXZy?=
 =?utf-8?B?d2p3TC9TU2FUMHRzS3pYbVJ3dnd6TXdWa3l0OGRpeTArdUY2eitiZ2t5djlI?=
 =?utf-8?B?VDZzVnc5R25IVnVzZTNLakxoSUVPakMrWDBCQi9UR0c4RU9QQVNsU1J2eUd6?=
 =?utf-8?B?cnZRSk1tOHlxSmtxMjJBK1dwVnRWL3ZyQkFLenNscjhFQks0M1FQVDZIMGlX?=
 =?utf-8?B?NHk2VHhCUnNLNmlBK3VQZlVjMTEwUXZJMEllL2drTGZ5RTlVNUROOTUyY2cx?=
 =?utf-8?B?bDRTbU80TG9WbWFSUzV5RWN6YzJVSnYybFV0ZTRERUV0M2QzQ0NQWDFzTWJp?=
 =?utf-8?B?dndkMENOOGlNYXY4QUt4V0xxRDA4dFJDN0k5dUsxMXkybDV5STdRT3ZweVI5?=
 =?utf-8?B?UEJrVU5QYk95WncwcE5UK3Vva0FOQ2lZdDdhZVFpRTVFeVpybDJwcUVCL2Uz?=
 =?utf-8?B?K0dyOW91ZHJ6ekliQnpBQXFIZEF5dit0UDJpdzVBS0tndGpvUFBtek5uTG9x?=
 =?utf-8?B?OFZDWFcvVEdQdUNpbUlhdm53VFJHQWFMWjltV2VMTUpGc3MrWE0yUXRHQ2cy?=
 =?utf-8?B?MTM4a3ppVklxZytvQWI2SkIrL3ZnTlVoY1lMZHExNk5Rbk1mSVZkRnFIcTli?=
 =?utf-8?B?WDlrQ1BYcUVIU3J6b3lBNWZtMUluc2xmVUJPc1NMZkg1bUI1NGxBRi82UVZT?=
 =?utf-8?B?YWVGblNiVUppTkZzdUx6dEZubml3dzZyYk9Nd201WHZQQmxWeXhmTjU1L0lH?=
 =?utf-8?B?KzVvWmxtU0UrbkgzaFdheGZaY3FNNUlvMVVBc2tZSmhiU292THU5MWt6bzdV?=
 =?utf-8?B?bDRpRHQ4Z0ZUK2JRSmdXUFlRb1VOWm5xd0NSaDgzZWRybkZmWVh4bW9TQXlV?=
 =?utf-8?B?TFdzYUZXMjZsRG1YbE9rU2lBaTNIZ1FEME5zbEJFRm1XU00yR0xUbURseTZr?=
 =?utf-8?B?VURiWCtXUVdtSC8wYVAzTEhWU2Nnelhpck96Nk43TG0vc3JFRVlObUZ5bmND?=
 =?utf-8?B?Ykx4NExIdmoyQmRHTHlhSnA1QW02WDgzR2hPVG5EMWpGdkNUZ0xHY1ZzbU5Y?=
 =?utf-8?B?OEZCc1JBZ3VYZG1SWFNwQ3pVd3QrVU54aForVFFhamtod3Y0K0JKcUUvSllH?=
 =?utf-8?B?a0xud1B2WUVLaklSMTRwbFE0Y0VXbS8zTGxRM2E2ZHY4STNsUlZuZW13ZHpi?=
 =?utf-8?B?dEtsUmhzR25mZm9KRzhVcy9UY0NISXgweDR1RExGRFp2bHlpRlRGeEVpdHhr?=
 =?utf-8?B?V3VTN215dndCcEsvYlkzb0UwdHp3TElocW1FaEw3YkF3TGg4MHJCSGhNbmN2?=
 =?utf-8?B?blN5ODdzWi9mWHNoc1lrRjkrZzMrSjY4ZlBadE1UZGE2bktsMWt6akJMSlEv?=
 =?utf-8?B?L1pLa1ZNbjhOa1Voc3gzNzFsWldQMU9RQTFvdDE1Zm1IR3dwajJZdHZiZkZS?=
 =?utf-8?B?Zi81NTV3UTFNVUpJZ0JhZnNYeXFhbUcyTm9LQTlMOWw3WDRoU3lxWXNtcndh?=
 =?utf-8?B?V0tERSs4Nkhnc1FtMERnLzlLU1BjQnprRlZMY2ZEUjNJVlBRaWx1bzA5OFcv?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e24f40-2c90-47fc-8978-08daf780e1e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 05:16:54.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbRWMTVwCyaxeiWYlvnCvQaey7R2ZvDvMwf9QHVSb087o2+xBeDn7JRZat9nZ6sSmFOPij5+byWIxhPOOpwXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3133

On 16.01.23 04:05, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Yunjie Gu <yunjie.gu1@gmail.com>
>> Sent: Monday, January 16, 2023 12:08 AM
>> To: xenomai@lists.linux.dev
>> Subject: while loop in a multi-core cpu
>>
>> Hi Guys,
>>
>> We are trying to develop a polling mode thread to skip the delay of
>> the interrupt response. This is done by a while loop to check the
>> hardware (say a gpio or a timer) continuously. When we did this we
>> found that the system was frozen, meaning that the other cores are not
>> functioning when we run a polling loop on a single core. But if we do
>> the same in a normal Linux thread, the system is not frozen. I'm just
>> wondering if polling mode is allowed for xenomai, or if we did
> 
> Xenomai threads should not dominate cpu too much time in dual kernel configuration.
> When xenomai was dominating cpu too long time, from Linux 's view, cpu is like dead 
> and Linux can not handle it correctly in such case.  If you enable CONFIG_XENO_OPT_WATCHDOG,
> it may notify system to avoid such thing from debug point.

Theoretically, a stable NOHZ-full setup should be able to tolerate on
top a Xenomai-only schedule with full CPU domination. However, achieving
that under Linux is already not trivial, and I haven't tested if Linux
is actually entering the right state when out-of-band Dovetail/Xenomai
takes over.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


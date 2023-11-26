Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D912E69
	for <xenomai@lists.linux.dev>; Sun, 26 Nov 2023 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ocv8v+dZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrPaxGzdbEZlzfhDw0wPEIouDNSud5wcS9f6b9JnEndq2ErJl9aT4pSiG0iwqsVLKQpOz2ntPmg+Jt5fkFZY66Z2NTz/XbNMpFU8Hud0a3yd7A/N+ZBlbKH9orAii4kYFUv4N5tPnsxwxFVGK2Xf7KFvWeplbQovwBlFyEy5Q+qfBPWibn2WOnH5hk4icEaXADZht7moJCii1HwSWPnostrsByH6QI2DWcDe8301DlxmjcXW63emuJmoqXyNWdIM6QsACVBTD+xoS1ukH2uqVPzcYgmBxmwc4oTE44ueVcy9FfnWJ73dFbH7ObR4zEEahblLURNhVz7Ooo6UXuMG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X0CajyjfOJNCP3pdb8VJU10245qtO5VGAtKaI8qSUE=;
 b=TSKMyj0doCt69P9PkkEXTsv67ni30T0PJBORN4zB7twqHxYcKcc2ePAeWKvTI1o56TNlyiPMlABdztJGQ1xWLIRWZKjmO6NTJsWGMbk1DaqvQKoA/7IHAPlCVgWfP/mPVXMoBlyHr0hpdzH34RkGx1rCk8EWlveqtCJtw7BufK7ZMbF9E8RL1UICaTEjfhK6zMQdFn45RqjlQBawMRmR/+CI7gbXcbqVX1sFQwIeGnoz/arA9iy2BdBdCEA8b3GFCVOMB+4bnN7UL6BR2BC3tActDMXb+rPEmSwTBQwGMFNZxVyg/SiSTq8cTJONhGqx1rNe2cjh7dYQc4erzztl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X0CajyjfOJNCP3pdb8VJU10245qtO5VGAtKaI8qSUE=;
 b=Ocv8v+dZ9iCH0iBdtxE8wRVd4c/sQcsoKGwpN2TnhUJAQJYht6ut1hIuExb3Sm8/0ijJIMErUaqcEsNaDjwL7NZVyBHtOkAJsGxQCLleh/maH1sM38PdzPEWPqjjmNTJY1hYDcS04HEzdl1Uo805BiSJIiR4nIKGpvlndSxzy8qUWGuYS+WYybounY6/yDcefPYSqgPom98Qx1yG1bjV5iamDv5Bhs+EmtN+fVUNKdF17Krsd3wkDIPP0lHV2wLeFAcgeJWPAJGcY7Uf2J67yRBC41HYcp6tcFmEsx1hQivZDg+Rj/GMEtbFtzIFlCE5nZ/ZXFSlP08puCE1aOTkSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 23:36:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 23:36:44 +0000
Message-ID: <ad69fcac-f255-4942-91aa-acf77656bafb@siemens.com>
Date: Mon, 27 Nov 2023 07:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: evl: Problems while trying to build up a debianization 2
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
 <87zfz0tnxp.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87zfz0tnxp.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0070.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cf8b09-7d86-4cb5-5528-08dbeed88c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tCXMv7pfHY4IK5Uu5gdufSLudLx41AkpbpmUq7OjVjSoAL0/N3IxNrZfB9LH+TagEAKx5CHTT16cruyWUNoqSgJke73vkCube066+CV2PTXt/1s0sZa+tDWQgAxYALsKN00eGMsGMMsBRRQNzqJFHeMPu+lmFCSesflYPzNwiA8cQCyXyWzHxVe46iyH2bVfstRIY9xMZRy2YDPrbagP/b6y+zAZvCYBXkOD5R7pgAGsKxmEDpD1fQ2JO/uwVANeRu6jiPzDcky/91ywOn4vXu1Z863HCjNadNiVcpvlT2NkyTNU9Tt0CeCWnuezS8V7wurEs/Ohfc00C0f29mnqRL/oaWrMj7zeNPqRtpfxdXVUbDVVXCPC+ltAGCMXrlohn1tVvm+GkQ8gQdtgK30f5ptEfyay1E7Wjd/QI4U0j30aBBYqtK0EZZ2n8UnAMfnBrLKD1pK5G+cjqUKIMlzjCWhESbOI9883+Ujw1J6JocLUB3efkHZq4oUobK79jEq5hNAw+m97uJeODETX1os9038SaROpcphfKE7z3lY6/7ZPErK/hpziqsxw30ydkIokTNT9iMSif04ZXEYQrrAcY1aNH/L3GnI2L2AhQTl7vTB6SxNsumaJ6YcL99sJwSp9+QI3REu33T0GuJjjJY0iYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(31696002)(8936002)(4326008)(8676002)(6512007)(53546011)(6506007)(6636002)(66946007)(110136005)(66556008)(66476007)(316002)(6486002)(478600001)(2906002)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(2616005)(83380400001)(5660300002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE56TUFWK0lCOExzSGRjZGExeUt6RHRGTThMNHFFdGZ1M3BaYStCdkR1My9k?=
 =?utf-8?B?eEh5elNWZjBmb1BRUFFORk5XMFQxbHpOaDZCSjV0VjZ1K3VSVUxzT2hPdFpE?=
 =?utf-8?B?aEkyUGtvWXpUWndZakVsTUJlWm9pVzdCbmNEaTRiNFMzRXp4L1l5cU4xc1lj?=
 =?utf-8?B?WnNaamtDdm9hY1E5QVZ4MUVkV001RmZtRVc3bXc3dklKcEUxNnU0WG9KM3NP?=
 =?utf-8?B?T0FkQUNuamZVQkIrSk54MDFFTUVNaW0ydGd4U042QUtwdDBJcm9MVnZlTjZI?=
 =?utf-8?B?aDlMZnRHa3cyNjBVWExMN1ZrYm85UDVWb2d3MVRUTWRQWksySzVpdU9tb1FR?=
 =?utf-8?B?NllTNTdYQXYxVTY4MUZxZjZoNUxTRjMyQklpRm1KcEx4V3IyanZFTEVvWk41?=
 =?utf-8?B?eUZSMVdzdTFWY25KSkN0TVFRaTFzSFE0RTQrOTVhamVVSElLL2dqSnhTcEJG?=
 =?utf-8?B?TXY5Z2JMQVV2dWpFVDVUV3h6UzNaSGlJZTFyT2w0TUpNaXhVeXd4eVNncFhm?=
 =?utf-8?B?VFk5cEYyUnZqYkx1eXpsSkpCRUJ4aUdNRWozM2ZlUUZtajN2aDA2dzJnSkNJ?=
 =?utf-8?B?bjkvNlFBT1BsK2tjb0p0MkZRSUU1R0R1VHozcS8yaFhyekc2VmpxQ29pYkdk?=
 =?utf-8?B?cTl3ZHFpNndKejlMVVUxaVJydWpJVGNoWEg3VXAxemF3bEowSXhUV2QyNmdR?=
 =?utf-8?B?c21jbVVjdHg5cnpsNEE4bEliaFRMSFVWQnFJQmFyYWZYSWZjL2VRWXk5Tm9s?=
 =?utf-8?B?ZzNDczJJV3VkQ3IwdjFzdndTREFZOGtlZThEOGVvRXpQV1JPWmphbDl5d0FL?=
 =?utf-8?B?UkxwTmlWL3FNZnI0c1JzUU5PZ0htOXE5R0VUb1MzK0Q5ajRPdk5WUytlKy8x?=
 =?utf-8?B?WFl5cG04N29zTEg2dHdNR1IyTC92U2E4V0NvY2NKK091NWEveXRNYXd3cElw?=
 =?utf-8?B?RVA0MVduemdOdEJUdnJ5c0RGS0d0R2tOdGk1bTRvdFZRR0RGeDNJb3R1M1Mx?=
 =?utf-8?B?T2kvSzh2eWNhVFE1cGdnVkRySXNXRzhLQWkzcFk3R2l2M2xDQU95TVNNMnNv?=
 =?utf-8?B?NzdHZTRTbzFoU2JiM2Y2a2lpQkFweTlOdTczUHhuUmo1LytYbkd4bFJhem1J?=
 =?utf-8?B?QldXVDJLRHhEeVNzdDlrdnZyTmNvYlpwTzRzS1l2aUYxWWpUaTdHbHEyMW9Q?=
 =?utf-8?B?OE8zV0hBY0NKenB2VDl4UmdpQnQ1YjN0MXNLOHJ6WE1qeUNkRFdxVGtML2Yw?=
 =?utf-8?B?eWhlZWE0QkZ1a3JUNXgvdFVtd0Jnc0FoQkVJOVRNbjBCQktHOGVkRmhxVVVt?=
 =?utf-8?B?b3d4aGE1T0tFM2xCSFZ5SWJocjcrSUtPUXBDdHcrOU1GOFBhSzJ3MDVBTWNB?=
 =?utf-8?B?MjUrelJEcDVnMit4RGFaREx6Uk5iditialM5WWtIdnhoNFl0aFFXamJXbHdp?=
 =?utf-8?B?MHJVbDZoSHNkZFB2SXhrNHkwYTZKZGRXRTh0b0NYbzU2ZmE0MjdKLy9VSVk2?=
 =?utf-8?B?bnhLZmhlOW1Cd2ZjUVNoL01DRlZST2g4d0dJZzdBR1YyNkdqUEFWczAxR2ww?=
 =?utf-8?B?Z1RqL3VIZWZjNTlmaGRIMEN4WG9JbEs2Y0ZFczg3Zy9GdXFCKzQ0WUtsL0lC?=
 =?utf-8?B?a3piclFWa245R2hDdE81cXZmaGU2bWVibGpnRFNDcFk1WjF2WE4rbkdrL0Nv?=
 =?utf-8?B?WnFHVUZoSjJ0MHJCMkdxN2dCeTRvcmkyczVXUDNCUHVxU2kyeHhHZ3l1OXJ2?=
 =?utf-8?B?N3h4a2RDdDZaU3ZwcnlnaEdLYmJjTzNtZXhrWlBLOHR1SG5pN09meUtzbmRU?=
 =?utf-8?B?b2h5Rmo3RnZVajFXdG1CaTQ4THUyRUVqL3dOL2doaC8yb2RWb3BZNnl4MWZK?=
 =?utf-8?B?VlNCT2Ric05kOUtsNWNJWXI2MHpJaWQwNFJoMnFMUHIrcE5VZGRDS3QvMmZH?=
 =?utf-8?B?SDFuNzA4TXNYSnlVNWxiU0djSEJzb1ExVXRqRVJvc2FoL24wYllDYzdFMEdp?=
 =?utf-8?B?Zy9zVUorVGlHanZhQjFFckpqTVdoRGp5Yk1CVHBjSEwrSE5rRkpnQWt4MXVU?=
 =?utf-8?B?bnVlSmtsNThRang1cUVpSzBFamNDMHZaZzdiUUViMUZuQWtsMldNb21UYTZu?=
 =?utf-8?Q?AJRheZW+7yTRr05Wu008nHFA4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cf8b09-7d86-4cb5-5528-08dbeed88c3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 23:36:44.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRQ29auIzRE87woae26Jw9W3mHXJjTUICsA2HYqkJOjTWWM2v5DddGn21r9LsjZ6Ix1lrJFbaWGPhdf0ICNxmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7352

On 27.11.23 01:36, Philippe Gerum wrote:
> 
> "Kowalsky, Clara" <clara.kowalsky@siemens.com> writes:
> 
>> Hi Philippe,
>>  
>> regarding the enabling of xenomai-images to generate images for EVL, there are still difficulties.
>> When using the linux-libc-dev package produced during the linux-evl build to provide the kernel headers needed for the libevl build, the libevl build fails. 
>>
>> The setup-uapi.sh script throws an error because it is missing the path to asm/evl ("/usr/include/asm/evl is missing"). The other two paths /usr/include/asm-generic and /usr/include/evl can be found.
>>  
>> In fact, the path /usr/include/asm/evl does not exist in the linux-libc-dev package, instead only /usr/include/x86_64-linux-gnu/asm is present (Debian multi-arch support).
>>  
>> The build works if I remove the $UAPI/asm/evl check completely. Then I get an image in which the evl testsuite runs successfully. Is this path still needed for other build scenarios? Do you have an idea how to solve this problem?
>>  
> 
> We currently need these bits only for testing the fp support
> actually. I'll have a look this week and let you know.

But I wouldn't drop them just because of this. I think we are just
missing awareness for the Debian multiarch layout when headers have been
properly installed into a system.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


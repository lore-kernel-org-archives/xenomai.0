Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD759321E
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 14:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzW8BUxcCJvKCGQHY4MYbneRAsHym5OalRDaRm2+Ke3noDOTskAdnvlzlXeIaRnOPyowKbjZBmPd9hmFnwLRLY3dOFNJjhcNn0inMKuV22iUVgrwN1qqpHtnDwc/q0VVN3utgfT8ofiHFmJL18QyhPK30NL3LSyrt9jfx8XmcRMattO6OfBXQAfTeVNkOJm+V5UCy6CrENtvAOlKpYAf3ukv8wOWP4FHhK6Li447arVUb6aYY8HwyDp8hst+ol/SxrjKrbRBiaV6TE0SUydROlNUCcNdrVXovUGrBJSXTAXOYixGCmxoCpuYbybJ+bse7YXwnsqRtC5F2OvQGB0/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVf/2H8KbemUL80656C86fbvIcL7o8rxlAjpwt9E8ww=;
 b=LyKQJ7ix1mVSYC7Vn33PihXwqGdlpIESZX7pgbK8HuEwONjSNH0H1jvZZI2jDMWOdFjtRH26Dg50pe9IiZ/9YMVgHaaj5Cct5x8VkiBmW6cuYlSWFZuC9UnpGQLYNxnczl/hrcWOYqHWSB0kfqZtdg7RquG0mFYTKbTL4Uw/4k12E+FSoo8xCIrxtkvUFCEWvfIBEeo7VafHVhXoLAB/sg5E5dywLq8w0vt/9uX4Z6KhwA3Sk+7U88sXqyC41X9BUkbQGWeHKp5z+lX+3cLJb+hHDOY/zp9X3L6x3VJlETuXWywQK73ODhfIApZ81nAYtVqPmKrydrrlZJg2QxhdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVf/2H8KbemUL80656C86fbvIcL7o8rxlAjpwt9E8ww=;
 b=hp/Bf+j+Fn4IGxDiMwKYUqR8W5Jo9XIZKBFTye59427XLUS8rO33/X8ZkZYHcT9ePcnItOpG203+kQLPspa4av+OjhJ6Jd39L7pG0oOK3+25z2ts7SLRsgUUrapAtX5UH4zlFsTZ6sQcCmveOy4UXz/jLDp3IU3DqI8+JYF9kHR4eSPxqpAFADL4XiTmDqgSR+Nr7YZB82W20k+wLgZ7AGy8mjSn/Te2pS16v4X77dpaVl81KL2FRXDBSlj+8A8hkgmv8tsvHQvF64jt0hN1xvsRUSEcco0QnaAL+z4HeKwq25xb22vAsoybgydqGjWSYzFOZwffNynZ0QjVmULebw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 14:17:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 14:17:45 +0000
Message-ID: <fb3c2fe7-4558-921c-e83f-bf494cd4e25c@siemens.com>
Date: Wed, 3 May 2023 16:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH xenomai-images 3/4] customizations: Mask
 systemd-network-generator service
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
 <20230503-flo-debian-bookworm-update-v1-3-6a4aa9e4d95f@siemens.com>
 <87725da2-1d9b-83e3-9822-da38db11f7ac@siemens.com>
 <549fb46b2327ef762fc9e7798a07e2e890081425.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <549fb46b2327ef762fc9e7798a07e2e890081425.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:208:55::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d29f7f6-397f-4cf0-a2c2-08db4be12a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbdVv8nF1EsIAFpFbyWJCRkZlyj1NjePREfwn1TyUL58OHakCN2HKIVLmmwNDhctWoiPZHcWTOtTw33zEYo8n6g3sKSHDdjT5LC/+Mqlvy1Jn2Juf5HOR9XVRzk2u2rz4mUU8oyb2vozUhpVNBkfUmVpJk8SgDCx43iKtO++kKJCdnQBgMis01EwBayBC3+IIlHl6lAZQeO0f0kBV0aZvnB9UGoP6X44rWaoz9CK9P0yOAHxmo4GUvQzkXPY/eVJ4j6yU5jQjgfu8BdxM7gdysXC2vL8Tlyhp4IflFGfFS5saJjWQpwvfwsCFa5QMvN0e1WIzK378OmaPGXseSaut9oai+zwCsMfGATPafQHSHO0TV+R5EtXw4c7S3vrCY+5pgQcuRKQOS0UXv0LiAZT9WHG4WZZeBOEeEbX0vK+ehdEhIX0/JGoFcLIPXKD4tJpr3mT2RyaqaWMs3EZiQFPdFRqtw4Y9daa4SBY8+XpC04b3xy+FGpN6IOnmsJVMbs6i9Q8AonC4lGBLx0jvq/0OcZonWvG3Y82LCKjI1+xCXYiVAAE9oqjaE4lsPjvnNB38jdpx5mWjqQusIm0jt/MWPiGwSRlteSz5U3y3lv0970nVoT+SpjqexVGIyOQ2bO61W6vH6MjTzj0xh9beh+LWcF0Plv0ZcZ+E77bsrLh5sY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(31686004)(2616005)(83380400001)(66476007)(8936002)(66556008)(6506007)(38100700002)(41300700001)(36756003)(8676002)(82960400001)(66946007)(316002)(6512007)(6486002)(53546011)(478600001)(5660300002)(31696002)(26005)(86362001)(44832011)(186003)(2906002)(6666004)(3714002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNvU3FXbjYrV21FMVJWT2RUSDB3YVBvY256VGlaWkRiTGdLUTFOaDJ1YTBm?=
 =?utf-8?B?dnkrTW9ybWJOL0ROTlIvT1NTYUJOUitQeWFQc3hoMDVNa0o3Q2RjbTkwODVj?=
 =?utf-8?B?UC9tSHhtUXBtUWh1cnJQOU1IUm9ySUowY3VOdUtPa2hPRXJSUEsyYUd5MjNX?=
 =?utf-8?B?UytieGJzOHhNTjhkY3FtSmE3QlcyTVZDRjdCZ3lGRFN4bzVRYS85aGcxczdj?=
 =?utf-8?B?Z1NzRWVQNXBRY2F6aWJnQTA5ZGNHVUVTNldrOHpvMFFVUDQvQWNSWGpmakcz?=
 =?utf-8?B?b002SVkyNFNjV1N5Sm01S09aV052RVBxS0FRa2tZQkVFSlozdUt6ZkdYMWc3?=
 =?utf-8?B?cGdsU20wbE5GaFJJRUZySHpMUG9seXprVnlSc3JINUNlNzBIdXZ3LzdxaDQ0?=
 =?utf-8?B?d2FCZ2pwYjFnVzM2cTA1M2xrYk0rSDdWVW5PRTFoTklmT1hHU2V2b2tJRzE3?=
 =?utf-8?B?a2JLaE42eUlkTHJESXlvdW1sSG9lNUhKYUJ3ZzZRNjllSC9uSkxQV3FIcUw0?=
 =?utf-8?B?Mmtqa3ZPbFVpMERFOHJ5MW1QQ21ZVkhSeE9YOXdzZEJSTGkydUViNGpuODkx?=
 =?utf-8?B?cUtZK01mRUo0Yk45cVZldkJDOVR2Z0hIMm41dE9VUW0xT3dCaUMxVEZ4V2Zu?=
 =?utf-8?B?VnhpOG1wVXl0YTA0RW5MYmh6eXpsR0RNYTNUWWhmMlVTNHliaXdoRTdSN1BM?=
 =?utf-8?B?d3BUOFdrelRHY1VOdGlLVWNVb3kzNFlXYzYvY2V5WW5wZUFQVXZqdk96Vjl0?=
 =?utf-8?B?ZDRLbUl0M05RQ2Qxak4vR2N5V2ZjVG0yZEVwTkJUWWVWTmZzOFpNWWpqUDBz?=
 =?utf-8?B?L1lLMGhiTWk2SmdxdmxId0hsV1VZM09NRTArQ21WWmhiWFl1dGdic3R3NFgw?=
 =?utf-8?B?S2xYS01LdFIxRFZGM3oxVjBzd0pOYXhreVlrekt2clBUMklxUzRFRWdma0VL?=
 =?utf-8?B?Q1NYbWNzTTJTbFdWV25DNVd5aWtGeWdvTTVCckl6cTJWa1pDaVJmWE43YWpi?=
 =?utf-8?B?b2Iyc01XTURYSU5uSUVOZFFHNmxKZHJ2WUtodzB3d3lBMjFRK1YxNXNZZ3Vl?=
 =?utf-8?B?UUR1MDEzNjZMWXZrSGNzK3Z3Z2o1OWRqVTNqd0x6VEhheHdQNHpMMGlHdHZP?=
 =?utf-8?B?WER5RG5LSEQ3ZVB6VnZYbEZKcGFMTm1YWWY3cjlwYy9KVmRzL0U3YzQyM2NK?=
 =?utf-8?B?aXFyWlRjNFJOVnY3S3BuSDZUMW1oN2NWdkt3VXFFZGxwWU41R2dpYWpqdXBm?=
 =?utf-8?B?dkNsM1duVEJlUzRMZ2RtWTJoY2NoVE01c0MxejBsUXUrelloUEtTY0ltL2dv?=
 =?utf-8?B?YkVSdytHU0xLMVVLWllUNWhjeDMzZHoreFh1ZVBMZi91ZWFLcGZySUFabmJ4?=
 =?utf-8?B?S0VNUTh1SmVVTVNWMFc5K04rUlF4eml1SzkrYXZoY1NoejVNcThvT1lLaFJv?=
 =?utf-8?B?NmRCTlVtU1NScnhyY1V4QmkrVW92a0VhaEhCUDVrUFZMcG52OE9zdmJNQW0z?=
 =?utf-8?B?Y3AvazFyamNhNUYzTzgzMzBiU2xPZFVQK0FPdGVyT2owdlowV25BZDI2ZVg5?=
 =?utf-8?B?UlVOa1l0a2lTekU0YjJmKzVNU0FrQzlDZEU1S1RRK21KY0hRd1RHN1RKWlN0?=
 =?utf-8?B?UG5ERGdFTFl5Qm40b2FJeVdGeGgxMXBHNEVEdWxlTnZIcGl3a2N2ak5uRHkv?=
 =?utf-8?B?dDd5bzF6cEJTVWtDT0xiQXMrMXg1YmloVGhrbmFxWXpncUdWQlNzYkpaWjlG?=
 =?utf-8?B?UldBcitiRUVraXhHL0R4Yy8yTVRFVnBrenZ3aXZ6VWpySUdvTGVTTzJoVVJD?=
 =?utf-8?B?ak05d2U0QkZpMmh4eTVKVTV0QVA1Um9VUHFVY0x3eHB5QUNYUzVQQkR2M0Uw?=
 =?utf-8?B?d1FpRHNldis0aUkwV3dHWUpScGVvYWRHMitWZUczY2Q0TCtKaXQ5U05IYVRm?=
 =?utf-8?B?ZXpqYytvT1N2bGNLUUNFMXNRU0hBdURjUzZwdXlLVC8vcisvQWh6SmVicVlh?=
 =?utf-8?B?dGFsLzFtak0reDVVQmwwV21JSGxvSjcrSlBjTmgrMmhLOEZrTzFucnNKN00r?=
 =?utf-8?B?TFhtc2dkUWVEYVVWa0haR1lDZUZTTjF6ajVUS1RSL05jZFJ1U1JlQWZ3UkR4?=
 =?utf-8?Q?6jylixnS3YWI5OELbTpbxN3Q+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d29f7f6-397f-4cf0-a2c2-08db4be12a2d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:17:45.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co5uhB2EqN2HbZmePuVJi3wIi6ARAdzzibz3Bl6eGydB8T2MGGmgl29XIqKTD1qTDTwaV2b/DL/zQkP2X2V78w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3341

On 03.05.23 14:54, Florian Bezdeka wrote:
> On Wed, 2023-05-03 at 14:47 +0200, Jan Kiszka wrote:
>> On 03.05.23 14:10, Florian Bezdeka wrote:
>>> We use ip=dhcp as kernel cmdline option for most of our CI targets.
>>> This cmdline option is now taken into account by newer systemd versions
>>> and a network configuration generation in userspace is triggered.
>>>
>>> WLAN interfaces are part of the generated network configuration and
>>> might trigger a complete system hang. Especially the HiKey board in
>>> combination with 4.19 (ipipe) is affected.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  recipes-core/customizations/files/postinst | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
>>> index 691988f..d8d141c 100644
>>> --- a/recipes-core/customizations/files/postinst
>>> +++ b/recipes-core/customizations/files/postinst
>>> @@ -15,3 +15,5 @@ echo "Xenomai Demo Image (login: root/root)" > /etc/issue
>>>  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
>>>  
>>>  echo "demo" > /etc/hostname
>>> +
>>> +/usr/bin/systemctl mask systemd-network-generator
>>>
>>
>> Shouldn't this be patch 2 then, to avoid a regression moving to bullseye?
> 
> Valid point (assuming you meant moving to bullseye).

Moving to bookworm, I meant...

Jan

> 
> Let me spawn a pipeline run with the changed order to make sure there
> are no side effects on bullseye (the current distro).
> > Florian
> 
>>
>> Jan
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


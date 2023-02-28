Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995A2583
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 08:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsVRDcwuoZvfbrfcR3AA5YjMaMN0bONkDcSpSAbdZxLuc/kI89pQ7fBZhocRlGBJR+KnOLCDV9ZV1JgROWfRsZnpgZn/aecTzPv3Euuv3Rlija9uuZ60nbAxXjiipdPyS/FpvuWvyNdpCZV+QICK0Mtd+YWeZLtKyKSmUlJE32ZIxSK8coxAxWVRj9+SY+8XkQoFANw/ub40fEIWItSAv1YKNAL8Y4xPr8b21t+bS+cQsGZpWjqbp0sOdRAGJJ7zRSf5JFRIW+v+RfaSuuzh59w+xtLt7Fo0ZvlhReaQc3NiaBfjFCiFLfFzsTvfcw03PTJ7osAUi7JbdKd/UrqC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GBFneEOOY/2yU8hrjmNFvQRu5gwXdBDteF+F9QxvF4=;
 b=LsUGfANXGE8kA6ewsLenWlHzHQOvsfeEI7CPNlzI+PCblbHj0JGohQQDbvyo+2VoWP2SxBll5uarPjMbRZCbNrtAVi0iAV7s/yHXT2RnHjyJylEqtMpEeRbBJqur7M9sR0FkzPAGnD7a7SUzhw3kzf45/yoO+lP12s3ciljfsBTNt6CJ2ZUKiPrpJkcUDpDY8QjlPuNQtmfQXgyDjixRbiFbjrxot+gNehf9zu4GGwVAX2YpBQmKwCm6E6/6MH1O8zvh+MHgYRmqaODi54ckC4GRi78W61/GxcQRw5WKHCy16LQs5Ay4+Wcg5YrayU1aeyrInhdJdsG9n4Gm4FvckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GBFneEOOY/2yU8hrjmNFvQRu5gwXdBDteF+F9QxvF4=;
 b=X4IgBvKQ/0EcaGbOc1dKd2pk0Wg/zbHEpoVXyR87+ICLbWAEdK68NjGtych0qRctCs9MQ4NsRY+wf38zWTmZ7Q3WltMxIheALnVqmdT0vro/YE6cCPZDrE4CgXPYJqKl4focS1KhYz8oNOHuLi7NpYVOmjTQomx02AMTwrygF4VHxT/tTR+52+t4A899tTKiIytpdRgyNIFKX/mRRHJ5HFCy+kdb9BLTnJRolq/p3G3ujOKoyqy3Ejq/2UMZi2HGOzqGfHvZQ39THbXP80xzDN7fDt60zoNalGxvBtEC+NetKx/yNYkCgfnyr0rFu/suyT3yZIA8QdOEn3jRKWxv2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:12:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 08:12:35 +0000
Message-ID: <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com>
Date: Tue, 28 Feb 2023 09:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: arm/arm-64 ipipe release
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
 <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
 <954672f9-5367-603c-1721-1047a4e18283@siemens.com>
 <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d28ae2-d5fb-41e0-e6e9-08db19638c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QUDQ26kwoeygkOSnq4FLJM/2dOByu0lCe+gQOnxg9IWDjOMYw3+RRTIgl+XMSmb/aNNJY8Jq22NIVQ+INiD/jdbWebuxVUDE1/6WwmqxmxSg5egqWzTDlVDapR4S0MwFg+IdNb0psih7A5sk6ndgl2jPSPZFQGHtPrfPGqKIXWQ+cGJSFECMHOEW4P938mNjCjXttz+C2v14BsB6W5seVEPU94iL7AzV8GFwz6v+YnbLQtpi/XFn5Rra7yjo03IzSjmDIFvehwhhyJpLOmn4KGMdYAl91DVIoRzvsm5BxQQ8BDNo9xozTLpMC3zkZNmzN3B7pXCpPW29jHlFMip0qlPb9nIKyg2+CAyqOSt/l0CirxQkZWvmLYMa9xb5P0LzF38A5k4Ycx1FnhzMqwYkzM5LFgWxdZIwQmvKUN7crDfbE6Wilh0qo/UzcH2/UirojopuQh0XBMeJP42ZUbXxpbROv0MQ4MYp1CD2yS2GK8NliSy/GUsgIyENw/TS+tROy7yd4gyCr3Hu3zHGBIKJlrjR0OIMJA/K7aJ/lOSW3JVe1ZRKuR0dljwu8qG5P2Fb2dYY3KIVaFIQdChqRtH2+/z/C9Y1KeIiCiMYrpLb5pk2vv2HqGyg3NovXJIzcVXiy3p9Q17HOGrmDpmSZnHcRmH14VsRBr2IRQnW2adIVmP/pMKA8DTr9TCC1CO5hhOIe4u+oBo8+ei3CxV1vAsWUlZkXSiSOpJjmHyWk+qa0Dm6A7Z8hNzVN1kCIQSSPWfE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199018)(6512007)(26005)(186003)(6506007)(6666004)(478600001)(53546011)(2616005)(66476007)(66556008)(66946007)(316002)(966005)(110136005)(6486002)(38100700002)(82960400001)(86362001)(83380400001)(8676002)(5660300002)(2906002)(41300700001)(4326008)(8936002)(31696002)(44832011)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWVtK29odmFLZ0pYd0FIUXpjUUNtZmdOQ1IrM0R4UHM2QnJYWW4wTmdnb2Z1?=
 =?utf-8?B?bmNPdHp4VEYyRHMyN2ZpdENhcHd3MEhWTmkyRXpUQ1FyYlo2ZUVHVjhBdTNX?=
 =?utf-8?B?Rzg2a1pJTm1VOTNhRnlGd0pRQ2N2SldpQ2hRUk9COC9jS3ZDcjhPV3NIWlJS?=
 =?utf-8?B?dDg4bm5IWlFSekgrWklFUUkyMUU0NkZJUWJSaVBBTDNHM2wvSDRxSHRXTG5z?=
 =?utf-8?B?L0VackFwbnBrdXM5VlN2WnoxWlRDZE5CcGVWcGIwc1k0NHkrcGFuVVA5SUxU?=
 =?utf-8?B?TkZFVnl2c25WL01rL3BHM1Fpa041M0RQRzNKRFBFMVc5VHB1RmxiN1AvZWk2?=
 =?utf-8?B?OHkwOGZqTUtHQ2pud3dCNVJDUUlVT1Iyem1COUVYeHJaTnZFd2V1RkpjRXZH?=
 =?utf-8?B?U0sxOHFxOU5IVTZOV09nRVlJb2xvL1JiMHQwcGMybGNnbVB3OW5acUxVSDFS?=
 =?utf-8?B?ajdRd3BWTWxDNVFxTjhxQ290Z2QvQVJxZzhSUDgwWG5BdGFhcDlTMm85VXZx?=
 =?utf-8?B?TXkxbDBjT1JybVU1UjBpNEhMd2c4QlFYQnYrTEZyNDNOL1ozWTM5REt6VVRH?=
 =?utf-8?B?TjB6TlBZMU94b0dYUXN1b1RlRFJFYTVqbGhuczNjbzRSTU5waWlGV1pRTTJX?=
 =?utf-8?B?ZElmRWdCbEtPcVNMaldWQlpFU1VZV3VZYUFKQTY3SStEZTlDMytqUWhLWk9q?=
 =?utf-8?B?bTRoY1lhSGpoRVlOeXhpeGZEbjFoQ2Fkd1BGNENvRlUrSDhqbDNtMXVPQjAr?=
 =?utf-8?B?QmUzMmlUWWlJRzk0VlI5TERvMmI3eEgySzk0ZFRGV1pXLy9vaGo5Ujd1UnNU?=
 =?utf-8?B?SUdtY25Yb3YrM3o4M3kyTkxFbkU3ZzdkRTZCYlA0S0tHemhpTFVtQmErQ21M?=
 =?utf-8?B?b2JZbmlpa0ZSSXpmYm15SFpvZkkyM21GTjJ3akNwVEY0MUF1VTIyM21tK296?=
 =?utf-8?B?UDdZNmNmUFZWTmZtUFJHU0lGdUg0aXlGNVN6Z1VNUEZZUFg1blpadldRM2VX?=
 =?utf-8?B?cjhEdUdETFY5SkVrS1dlYVRScTFFbWxYZEh0YlpreExBZ0NsN01MUCtOY1lo?=
 =?utf-8?B?RUgzWk9wL3h1Unl6VWxZUnE0N3FxMlBEVjNFRE9FQUxTWTRiZ3B5aUcvNXNJ?=
 =?utf-8?B?VTh3WmlvYXM2c3hpcXI1SWlXK0ZodVpjUXUva0pkb05IeXRkV1FtMTJwdEtK?=
 =?utf-8?B?bnFYaXdsL2VrMmgzUjJST1F6a0pjdkZ4WkpVdjVFMy9nOWQrSFNtZmRwbjNL?=
 =?utf-8?B?NC9zOXRXTUpuUXJ0eDZHZ3owRHRqaXh5OEdDVklmYm16dTRrSXdYOXE5c3Va?=
 =?utf-8?B?S0RraUJuNXFmWTJQSC8vT2JZcU11RC9aVTNiek1DbUVEdThybWRSMnV0OGhh?=
 =?utf-8?B?dzVWSUlTYzk4dXJOOG1vOXg2NUhob0ZHNUcvRXdSMnY0YVpSL0pNUXM4cVdB?=
 =?utf-8?B?YnZhcG5MZjMvNGU3WWh1Y3FkeVpLR2tCSitoRTVON3pzYXdkSnAwQWM5MG5D?=
 =?utf-8?B?WmsxMjNJNitXbkJRbEsxVUwybVhWUkxidGoydHZ0YytqOElLZm9xQ0pBMjN6?=
 =?utf-8?B?bEJoTUcxUFl6Tk5BSTFWMTFVcWZJT2V6QTlWOXVXWmpyVXpzZXlkNFFBNFcw?=
 =?utf-8?B?WU1EVmlra2xONklmdFIyOGQ0di80Qy84dS9EM1FYaG41U0RNT3krZHRCV0sz?=
 =?utf-8?B?blg5cHA2c2Vmc3dDM1RyWUREWXJJMDhCZWdwSVJKYVhrckFzNnYvTFo0ZWV4?=
 =?utf-8?B?eDg0OWc5cTJTY2N6M25JUmtCcFVockd3dVJWcitDRjUwQ1ZGeGViOGdDdFVt?=
 =?utf-8?B?TnJ5ZWZDclB0d2FySjdRdUlITDM1SlIwekh5OG94dFdGMGM2NGNDQ2Q2QWdY?=
 =?utf-8?B?eVdHc1M2RVRseURLNzA1QmJXV1ZGQmNvd2xrMm9NNytlUmxHSFdOSUd1b2l4?=
 =?utf-8?B?L1ZUYXdvSnVma1J3UXZuZ2lpYTR6djZxbU5EOCtRSTk5eElFaTR6Sm1HSHBh?=
 =?utf-8?B?UkpKb3JKTmZIY3dEVVlkbk1LTEVxMEduazR4bGxDejFPMjhITHByUFdqWmd6?=
 =?utf-8?B?K2lYc0RYaENRdHpVZWxoZEJoMjdHNzlnM0tMOHE1R0VjSm1YaVd5eU9jbGR6?=
 =?utf-8?B?OFdKcHI1aHRPaGNGNmplRWN1SnBMZURZRHZJTVlyOXBpd09pRXpTMU5qUjcv?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d28ae2-d5fb-41e0-e6e9-08db19638c53
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 08:12:35.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNUTG8gA7BIltPTRIoPZjzuiLXuqzj+PlleYh6Wqw45z7FymwQvkNZt5s6qEWRd/cj2yP1hMI7GKBtHEC1r/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7632

On 28.02.23 08:49, Florian Bezdeka wrote:
> On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
>> On 28.02.23 06:18, Greg Gallagher wrote:
>>> On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 20.02.23 06:27, Greg Gallagher wrote:
>>>>> On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>
>>>>>> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
>>>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>>>
>>>>>>> Hi Greg!
>>>>>>>
>>>>>>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
>>>>>>>> Hi,
>>>>>>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
>>>>>>>> working on stable release 231 since it contains the patch that
>>>>>>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
>>>>>>>> with using 231 let me know.  Finishing my local test this week.
>>>>>>>
>>>>>>> Thanks for letting us know. If there is a chance that you publish a
>>>>>>> public available -rc somewhere, it would be possible to tweak our CI a
>>>>>>> bit and trigger a full test run in our lab.
>>>>>>>
>>>>>>> That should help us to identify any leftovers upfront.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Florian
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Greg
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> I'll get -rc releases out this weekend.  I'll post back once they are
>>>>>> done and the -rc tags are pushed up.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Greg
>>>>>
>>>>> Hi Florian,
>>>>>    I have the rc releases ready to go.  I'm going to push them up to
>>>>> the ipipe tree with the kernel update (5.4.231).  Does the CI system
>>>>> pull the current ipipe release based on the tag?  Would pushing up the
>>>>> new point release (5.4.231) break the current CI?
>>>>
>>>> We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
>>>> ipipe-arm[64], see [1]. It just takes manual triggers so far as there
>>>> are no ci files in our kernel trees (unlike the xenomai repo itself).
>>>>
>>>> Jan
>>>>
>>>> [1]
>>>> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb
>>>>
>>>> --
>>>> Siemens AG, Technology
>>>> Competence Center Embedded Linux
>>>>
>>>
>>> I put the beta releases here:
>>>
>>> https://github.com/ggallagher31/ipipe-arm
>>> https://github.com/ggallagher31/ipipe-arm64
>>>
>>> Branch names are the same as gitlab, once CI tests out the branches
>>> where are the results located? I'll look to see what debugging is
>>> needed.
>>
>> Anything speaking against pushing to the regular branches directly? No
>> need to tag/bump revision yet, you can do that after CI passed. That's
>> how I maintain the other repos/branches.
> 
> I can tweek the CI a bit and trigger an internal run. The test runs
> will be visible at [1] once build stage is complete and we enter the
> test stage.
> 
> Pushing to the regular branches - and a failing CI afterwards - means
> that we already "released" or at least deployed something that is not
> working. No?

Released is what was tagged. I do local build tests for my branches
before I push, but CI is doing the rest of the qualification. Then I
bump the revision, add a tag, and push all that as release.

Jan

> 
> I will let you know when the test results are visible.
> 
> [1] https://lava.xenomai.org/scheduler/alljobs
> 
> Best regards,
> Florian
> 
>>
>> Jan
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


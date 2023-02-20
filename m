Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C644EC8
	for <xenomai@lists.linux.dev>; Mon, 20 Feb 2023 06:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPtDp3zF37DIfk1V58DQmF37MsqmbgSE3vGIANyIzJsuovQVOhGHv8keGA9hyYIrZH1a8Na/DvYEqwKalCDr8Pdw7Fs0Aq4h5ktndNPda8F6mt/xDP2gIRusrpc2ku5IIILt1H4+a+iBEsypcIn8J9TjayZP8FJrh093BDXBpX80iELpG1Snef0B5EUTy4jSmVmta3+pZcjX4hi0QwemsPDlHRd6clEE2Y+Yl8LqOz88ZUomjkxWqRxIRz5f7cAqR3mAtT6gj68n2W+3JUCIXFMlr5ueacXLvzCa8S6RM40aZcf6mfW9kS+7yNq100afF4kqBZ7Mp1YIl+36F2p8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQXE6gUKYNAb2twr7j2WLqTYDm/YkyO/S3pZ0Dd4q3M=;
 b=T8IOiAj8q2whZCGKdVI8brGH6AgK02MisTxt6Cu7WZgHFIXI+sBgT1bclM6F4aYqVXO1c8FbCjw2apePRVxjtfEbE2bIFcrd/QPReMDnCwVGaGTotWGicyJQXSgvcUhOfui2F2qHm9qKU0w+lMVIZnEpwRuXfBX8cMl1h/iPwqQ+nMX5tUt0IH+3Ia5Vf7aJVuAgXS9VXyDQlr5DTR+td0cbjJ+nQnBcfGLMARtp/DBK8qD/Dut/JpMC3gxA4L5G1apDe+tCQq6gqlPLTXAOQ9RVk6gdqqsqqBYBhTGz4FLNqRHHEumDw6oem/SGVRARXYd/BqsUBsM6n+Iqhb5bfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQXE6gUKYNAb2twr7j2WLqTYDm/YkyO/S3pZ0Dd4q3M=;
 b=ZiHrrYle5irUQn2VRE6F/HldRjEwB3yOU2rhd0HBdrdPU0Gy+PC1ZsUv60AAXieFPQBJJQifeQXw/oXOg6f1HPHb16V8KeY5/o0czP+LXIKiRvgzcyG2VRZarVf3ERDXSBaYHxEuZhK1YcK0mUSW26r9sg5zvly4kca65JsoPe2P5X4CxFSxgVeqACbCgHfQY2ky+AP+/stFsw534sr1W7YBnVa51MbwXzCseEdJx2ismSCRwQ4pHD0/JsMaD8176oPl3Jt8QuaOuiB8Ziyge1Apa+z9Iazg0JrLHx+bKmok1rYx9uK82q+Z1Pt+8NLufU955kVAB7GiMb8xqCzaVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 06:42:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 06:42:38 +0000
Message-ID: <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
Date: Mon, 20 Feb 2023 07:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: arm/arm-64 ipipe release
Content-Language: en-US
To: Greg Gallagher <greg@embeddedgreg.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: ead7c302-438e-4831-d657-08db130da825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lrSlVOMbzlfxa8AJgJ1SAx8w21l+BejWK2kHRVKz5bmEcPw8YytMf5xKWXyxCxqwq7/f0tBJiK/AMut8z6pj49LQtqyDYgkrE7hUPD7XemQtmPSqswP6/7yvnDGKoi+2YE9XfJQWMOeXkEBLMRAkvv6FN34mv/md4+q/jxdlCuRec/Lo6b0ofTCA2caStaRB9C5JDLi1SHauCpsAG3ZEfalUMQyAhFsJBJJ49/jUrT96kvZNAobafh0EIGoCA7NIeGifN8C8JEDMI24lbNs7Wnyq/96GLRrfcFarVAnXoeDI4pKaGXzZvFC1PYy0JndMHUiHx9g2JD9jjelZi9aZDgESlPLKZQ7FzcQoJ3Bno1z3o0bZQ47gTaiGDZmctlWcrtbGKgB943JCtxXiV/hzOep+uRhsFzJ2Z9y1QbIXAOiZD3LrKQhmo71toCy2RFDHR6DUw09iQMH8Bm5gnhZgDcg0dKDBSWtLwlawUjiUnMNn+hmptqV91TAyh55rNcyUns3U31WCqVoZNtyU3MdZb14Tu2CUWgIZBQU8b4jS4e5xZfGNd9sPezLYrT0IAjZOw63xkD+58Tvtc26u4mFsNc17rL1B5oRjMYX9InxXTl8sLp7PQjPjQWpU4Q/hy0e6ZiWWM++kdqYkyEd3w47iOBpcALhM/mwE+VjSRm5EUhBeGznnoSlFOs/JMhTZNxLnAwof3cz8qNj+48s1t8KNxrrl3Rr1zYXjhj4S8efeHhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(8676002)(4326008)(66476007)(66556008)(83380400001)(41300700001)(66946007)(31686004)(316002)(110136005)(8936002)(6636002)(44832011)(2906002)(478600001)(6506007)(6666004)(6486002)(966005)(53546011)(6512007)(26005)(186003)(2616005)(5660300002)(31696002)(36756003)(86362001)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUVVOWI5Q2JQcFV3YnZlMHMvRFRrOFNjOGQvZkxHZVVvSy9QbGdOWTBTcjIv?=
 =?utf-8?B?RE85K3luYUl1M1JRNmtBbEc0UVo2OHlNMjUzcG4wQjlsR1EzYVpVSGVkWE5n?=
 =?utf-8?B?dTZyVVhOYkM1N2hkYlN5VlJ2ZnBkTnNJeGZiU3Y5TWhMZitHeEJZRnpMRzRZ?=
 =?utf-8?B?d3NGY05LbHMrOENWNU16YlpKeVVwKzBGWlRteTIxUEZOQlp1V3ExWXNuajdu?=
 =?utf-8?B?djI0ZVl1RE55OWZZbjBBeWhOdW5LL3dVUFZ3Y2ZmVExUM0ZPd1dTZHhZOG5q?=
 =?utf-8?B?NTVwSGZKL0N6aFlOLzJHZVZwWE5iSnJzRmhkRmFVa3V1d3NoZC9Tc0lxVkN5?=
 =?utf-8?B?STM1dTAyVkFkYlFKQVY1TXpOQ2VaRXlLOEhobENjVVpJNDNCMmNZYzBBTm1i?=
 =?utf-8?B?YTBIWEJwdTMvMGlSU215azI3MjF2NUFsUG16RncrK0NMTTBheGxLMlJMZUpC?=
 =?utf-8?B?UmhYc1k2dkg5L2pFR1gzQVZyM21oeFZKUXF5aTkySFhpb0RuZk9OcmdrQm5q?=
 =?utf-8?B?MnI2RStVcHJ6bVZkZnVxU3BEQklJSzY4ZmpZc1hJUHBsRDNpOUhCZ3lRVW9P?=
 =?utf-8?B?UnVrWW5tK2VXM29sN21OdzdDTGN2UERXZkhINzJjT3RTOUJIYWZqeUZsYTFj?=
 =?utf-8?B?U3BVR3NkZ0l0UWlrTWcvbVBrSTJqMlUrNzdEQjNUU0g4WkZxY09kRkRSNGJS?=
 =?utf-8?B?U1hzeXllQ0FuZXdlMG5MSm5KWFNBaW1IK2luMC9hb0dHdzlTR2hBV29NY3Rs?=
 =?utf-8?B?U3J5emM1MVl6TythWjA0WXV5L2FuVzZKQ2lBMUduOHpBWWNzYndyanlZNFp6?=
 =?utf-8?B?M3JaVWR0bTNRR1NsUmI0MGtKckd6TnBQa1I5ZjFxUXZKTm5qbkdwcU5CNzB2?=
 =?utf-8?B?OTlCWk9SSHA1WWF2MnB2VlM3TG5xcnA3VmtBVGE1V0d3bzhxMUVXcldNK2NL?=
 =?utf-8?B?NlI4SjV6WkhrSnliZTFsS0VXOFZJL2ZqLzd0UzZ2Z1grdlhWOHdwOWJpTE1E?=
 =?utf-8?B?amJHQXRGemxGYy9CNnJtNnNzQmpJakpJeUY4aE5NcVBiZFJKSUE2U3JtOU5h?=
 =?utf-8?B?Tld0WEVmN0M4MXJhckdWTkxtWTdxc0tSVEttMXZHQm9aNkNyZlVIRlRuakJh?=
 =?utf-8?B?QnNXU0xydFlDenpVN0dHU0ZBeXhibjlFcUs2ZExtUlhuQzlyUjJwU05IMlNS?=
 =?utf-8?B?Nnc1eU9aQ3ZIdGNBMUhPUEJsbXE4R0p0cnA5dFF6eXVWTGhLdVl1ZGt4QnlX?=
 =?utf-8?B?VkFmMU1WUU9KZGpHU3FOUHVtMHFUVWNyTWFjQ2Fab2tOMGZXODdXd28zT200?=
 =?utf-8?B?c3pKdnhSY2VvQjZTYk5Xci9GUTluME51a2lJVWUzYWVxdlZMOU1hR3BKcThS?=
 =?utf-8?B?RDN3NjFvcjFLTEM3eExnLzNJTWQvWEVFYit2SVVvZDM4TXpjNDFOWGJYeVds?=
 =?utf-8?B?WE5BVkJuckRSYlY1dnNGOHZYZVMwdnhmN0c4OHo0MnhyU2pSeHpmanFoV3pS?=
 =?utf-8?B?TlhzRGl3SlB3bVJCaG1haTBtOGY4ck41UDlhckQyWTNaT0lyM0xMd1FSMmlK?=
 =?utf-8?B?WXQ1eDlrTkV4WjdnODVzVy82bk1qUmttTlA3ejNwSURhSHpjQ3FseUJFK0NH?=
 =?utf-8?B?UTR2Rjk2TU1IVndtQTdacU95N3NNZDQzamxrbmRDMFhTWS96SXpzRG9YU0xC?=
 =?utf-8?B?SThINFZKeTVtdSt6bFhDM09GdDdtTHJLOEhEVURWUEl3WXFsY0lRb0dwVVV0?=
 =?utf-8?B?WC9tZ3JZMjZIZG5Qb2t2KzFsWVI1cDZyYVJzVGZBM2U5cTNRVHEzbHhsOFRD?=
 =?utf-8?B?UDdXUnhCWGVDdnhRRXY1K1FtWFBUMlQrZFE5QS9NcU1PNWp4amJqU1hQZ2tG?=
 =?utf-8?B?UExPdEo0bDlVK09IcWtaSTB6TklsenNOOWxReWxGYkVsRDcwM1l6ZGU2VnVi?=
 =?utf-8?B?d1ZYOHJMVDRVSU4wOXZyU0gwbW9oTCtkeGlQMDNaaHJJWGE4Zzg1MmcwQVpU?=
 =?utf-8?B?V3dZenpDZ1FMQXlMTnNGZ1lQRkRESEw4UTFsR1NCYUFVOW93ZmkvTkhHK1ZE?=
 =?utf-8?B?WlhxUWFDTGxHRHZmVngwVkdVekxCV1BpMXlsZHBMUm9OYjNUZ3BtZDRmOHg0?=
 =?utf-8?B?MWpjMXVkMHBsRDUwNVRMTEZ3bmt4T2R2VHVWbHh6L24rMExmKzIyYW9jMm1u?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead7c302-438e-4831-d657-08db130da825
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 06:42:38.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdDnMKJuQTevteAcdWMtauxALUKxC8k4WTgR9dRyEIKYan/8Sso2Jg0ngN1qrhjcaH0mllXpY5TBVZEg2P8oxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

On 20.02.23 06:27, Greg Gallagher wrote:
> On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>
>> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
>> <florian.bezdeka@siemens.com> wrote:
>>>
>>> Hi Greg!
>>>
>>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
>>>> Hi,
>>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
>>>> working on stable release 231 since it contains the patch that
>>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
>>>> with using 231 let me know.  Finishing my local test this week.
>>>
>>> Thanks for letting us know. If there is a chance that you publish a
>>> public available -rc somewhere, it would be possible to tweak our CI a
>>> bit and trigger a full test run in our lab.
>>>
>>> That should help us to identify any leftovers upfront.
>>>
>>> Best regards,
>>> Florian
>>>
>>>
>>>>
>>>> Thanks
>>>>
>>>> Greg
>>>>
>>>
>>
>> I'll get -rc releases out this weekend.  I'll post back once they are
>> done and the -rc tags are pushed up.
>>
>> Thanks
>>
>> Greg
> 
> Hi Florian,
>    I have the rc releases ready to go.  I'm going to push them up to
> the ipipe tree with the kernel update (5.4.231).  Does the CI system
> pull the current ipipe release based on the tag?  Would pushing up the
> new point release (5.4.231) break the current CI?

We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
ipipe-arm[64], see [1]. It just takes manual triggers so far as there
are no ci files in our kernel trees (unlike the xenomai repo itself).

Jan

[1]
https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb

-- 
Siemens AG, Technology
Competence Center Embedded Linux


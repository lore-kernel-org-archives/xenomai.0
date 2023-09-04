Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3200442D
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 12:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbZWm7DO0Kkyk9E7+ziao/x5J/GdBcDrY1G3i7DbmmM8VHp2OpojmcU1uIhSZKTIammwqWfklr2CNyJMqLABGNECub1halCd1V7FNR1Cji7Ei0I8zg7gQWxUhnVG3hyCyx3Mo3CIkZ+hsphfKUnlA1lP++jjOwR3iaeOh/lLhx4MCNxXkzZU2YfLmrn1d8R7cDSdJnpu3RjlJV0eo3rn8xhTu7ToJhBfD0MNoMen24WFRLhE2iGdmNqN/NKDR4a2zthtzjPtF40cOBJ1spWgE9HphvbjyBCv7uWCKMRVYvvTXhXNzZijWjQXHtxwxs7jIQg3jtFtL88f91sp2xk2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMaA3nB3PkghsZspkv+rDu9Ktd0bRXQpS4sXMndnWUg=;
 b=NCBRn0nUsgHuc2YRzKQ7KPP64T8YrtkVhG3hvLOx5ticLdmz4wBQIAESA93NwIpt5U6rf1YVOPTfhcsqB9hQH0U8kBMPIcre7JpiBP/OUr2mJElcFeYTt9N2z3UbnEy5dnEetuCx7leHzOd+1jDlhp/SvYqusVM18xscmK4RWDuJQJDQTZ+Frw58UtN0BVL1mR7FUAyWmVqp+yQsISQpHHrY6fr4IDj9gALGHDk0V4s3RgodqWCiAMqqj9yvxM0kI7VmhcfgLaNDlc13RoAW0heI4GsMRdAZ4jI3IlOcHGDTXcUmBMzuBa8innxtqkCNwpQTFoWUBEXZhe7MJlzAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMaA3nB3PkghsZspkv+rDu9Ktd0bRXQpS4sXMndnWUg=;
 b=QQbf7eiec6B8DSFHlGtE6XuLhDzcV55OPkXA7lukX68LtJfWmOwGWck6gDeNexcVAvE6vttW4F0P7xjauRD5b6ut+kvp/K6/K92Q/6awJ9sKZzZwiwBMMDoxC6t8tkh0gXGF7biSNTs5xVld3vyRIYxEG40/yNcH2aFJ2okZvMuslSV9PjeJ2JXnjcG0LdpKgBBesgufI75X5Gn90qIKQahufpb28NoZX0YTQZLJzQ5YfGENMvTWi+VgW2r/pVHC1a86K3xtoU79Z4P0ZVa0oyxyK7NJ4U0CO8bYNcUBNmI24qLb57ab7UqhNQzOdi/15Zsg26uy/buprusShBpfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5767.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 12:20:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 12:20:59 +0000
Message-ID: <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com>
Date: Mon, 4 Sep 2023 14:20:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Wiki updates
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 248f1785-3a64-4b39-9278-08dbad416597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h+zGL5NqvbkhIYOsLHCUVX+DEg5zhhxGapxRuttOcUWmQqJhYTRK7kyA3uVNlJijz46+UduE7GIwR4JwDtlim9JHTz/FCIahSdpJqSu1ZSItiJUYuPI7XNJYv2zWH0BWufgPpifqi4EvQI/1pF9VGAGCOBl4SPvu5WjkDVB4XSpMbE3/fDjPIKLa8AhrYra8/yoChGhu/sJAd43RWuNgG+4dRFglvGpk5hzCxaAezuD0altrUg3Fg+irqelq2yKnKiSJY1Z+INsFA8D1UAu2Yjn2g2UsgUkdKpEqS5mT0vLQw7t9Su0TCVwWxR43wJrd5VR/iQGO1VsDmUl8GGqxn1M1NHrY/nCugfm5clixLumfVybpcERqEOsrvJaLfoANhahN52VrvE71lD8xIW3fJpZdtveyiyrs/D5uOBn3PqGjzLN79UDrit7n0rIvaCORLD0gYisE+tSbekS1/RTAbxyrNrL0ZRdTOL6oSEZZ5dNOG+uHLnrr7E+C4iwZFSHsO93Xt7iOFzV9biTRBH3J4HrlOY31VbCtxo1EyCcWHaBEzCzlWWYkf08rBlhh7b4HE8gjI8WKsHUEfB8yNkeJkbNhzXUYqzsJxwBj/vg6QkW++JMLK9tW0nbxjFEuNgsmfypCYLutji7HfGZ5fvtdUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(186009)(1800799009)(451199024)(41300700001)(82960400001)(38100700002)(86362001)(31696002)(966005)(478600001)(2616005)(83380400001)(26005)(6512007)(3480700007)(53546011)(6506007)(6486002)(15650500001)(8676002)(66476007)(2906002)(66946007)(36756003)(316002)(66556008)(4744005)(8936002)(5660300002)(31686004)(44832011)(7116003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkY2UitmNURTL2RSMmFDdGZlaE43TGFWZlZrVzI1NGJUc3dSZ3BRN2xzMVZU?=
 =?utf-8?B?Q2tFUzZqSVBiSnlaKzdiY2ZXOU5MOG1HM1c4d3ArNlYwdVFIZ0o4WTd1MFJL?=
 =?utf-8?B?LzIzY2hXYzhnMUxZVHhJdElKcE11bTBhNTl1M01vWUhqVjZYZUVjSlRYT2Nk?=
 =?utf-8?B?ZTZGQTBOQTdhNGpCMkZoVEQrUUhPTW1TNCtjY0l6SFJGMzcvd1dGRklCTUxs?=
 =?utf-8?B?Wm50RVJOZWJLUXN6Y3ZrLzF5Y0pHaytSUVN5Y3ZxNTFaSUp6citzRDU2SHZE?=
 =?utf-8?B?SFZsdmhnaGFYaW91aUpwNW4zbjZMRytrYWdDNDFWNEM4STdORVMyRk1jRUVl?=
 =?utf-8?B?VktlTDA0bVJXdGZGaDhEZlZqRi9KbTVpZFpXNHdPeEY2L3NnaGRwckEzc1dX?=
 =?utf-8?B?RVJKNGp2SzFhbDFhZWRXZHpNNmllWUcxV3FjL3FSS3dyaWd6RmpUUWdwQWxn?=
 =?utf-8?B?ZGdTTjFmYm1FR3dWZ2FlSE41MGwwMVdiNTNTRHJYajdhRS9UM3FjQVJGYktR?=
 =?utf-8?B?Um4xb1JtUGpJTm1JMXV1cGZNMXE3U2kvTmVJTlJCVW9ZeDIvVjFlKzZXUXA1?=
 =?utf-8?B?bUQ1cVZGTmdETnp3SkdqUC9jOFgwRlkzSVIyTGxqaGlUZmhXeEh2dCttMnU0?=
 =?utf-8?B?cmlrM0t2aWh2RXY5Z0dXVGQ1Y0J3WUNGbVk2TEtuWFJnUXlmMENzZlFJUnBV?=
 =?utf-8?B?Nmk5dWpNcmQ3TlI2VzFrUEJTVlR1SHFsV0tXcGdXRWo5ZkV3RkN1Y0IrLytM?=
 =?utf-8?B?MEZnb3p1MU5nMDU1SzFMUjBiM0lvRlZSSmVDS3R2ak5INmUrTU5sWmh0QTRJ?=
 =?utf-8?B?aWlmRXMzMkZZNjltdy8rUmlXNVZHNkNhQW0zTk11Y0ZMOVpnTTlvY3hLSGdX?=
 =?utf-8?B?UzdoWGtWVjlnRjUxVkpMajVCSHB1MkdTOTdlOCtGa1dreXJaZ1BocThBWTRr?=
 =?utf-8?B?NDR0b1kzRzdVKzBuZ1dOKzdLcHhzNUw4amoyVmpLTS9qQzdFckJmSUFZcE42?=
 =?utf-8?B?dXB0WFN3ckJYai9wSmhCLzZKSVFTbzRsSitMWnFEd2l2MXA2WU9JYUZURGxC?=
 =?utf-8?B?QTh4Vk9uQUloY29KZFlUY20ranlaL0s5WlUrcUF1bTBVUUFhclJrMVJnSnk3?=
 =?utf-8?B?ZU52NE9WUW16NE5WSDBnc0ZTZ1RJL3ArSlZ6dW5Za1gxbjBmRzVYaW1QdWtx?=
 =?utf-8?B?N21RUW5FM3RscHhlc1dHZzBjbXZKYkVKZ0J0bXBNdjF1Ym9aL1pqLzlNNGdm?=
 =?utf-8?B?ZUR2SzY5VHVoelRrblR6akV4M08zbFl0L2h3WEszTktuVXBiNFRJQkl4SUc2?=
 =?utf-8?B?QzdOc3JCdjU1MFhXNWpOZjNUcWN2ZEJEZktMenR0QUF5UkR3K042d0JxL0Q0?=
 =?utf-8?B?YVUvaFJYZjNjN3pjdk56SHNKcTNqWVVSTExqb1pVcUFjbTZtdjVxbHdzZ0Zk?=
 =?utf-8?B?NmVqWnRrQnAvbWlmOWIxL0VnRVR2WEVibW5QRExlemY0ZWZzQ2lkc2FHVkNr?=
 =?utf-8?B?RUM4cHVLYU8rdjB4TzlCN0RYd2VoWW1VL0JVM3ozNXpmczkwaWFJTDNDMTNL?=
 =?utf-8?B?SWRFclNWK0ZnRDQ5Z3QwRHg0UnQ4YmY4djFVbEJybjh3TzJxVmRBaklOYnNl?=
 =?utf-8?B?VWJVUnlQcjFFK2wvUVNvT3dsTlBWcGY3M3pYZFRjOE0vNEFKcU93WjJmN2pL?=
 =?utf-8?B?ZU5zNyt5dXVLWCtBTXI1eWt3cElEZFoxRllxKzdPTm9BRCthL0FYbjRRcFVz?=
 =?utf-8?B?VDI4UUpISmxZYVZTZkJ4MmJRQjVmMU1KTEMvQ0lQWndDM0VsUFhCYU5yQVli?=
 =?utf-8?B?bTNyOHBIN0k1WitpUEp3TGZ6SzBPaFVRUU9uM2t3U25HWGZ4VnlSc1UwUHhJ?=
 =?utf-8?B?WUduNWRrcytnZXg1MHBQTWYwTkhiRXU4UkJNU1NzK21PY0NKd0Juak1jSUxH?=
 =?utf-8?B?eUVhZVJJZmQxSE9kR2tGMVFMTmtXNjBvMXNvWElPK1dzZHhjTEhIQk9TcjAw?=
 =?utf-8?B?V2RieXEzdFJjYkxiZUxQSWtSUVluWlV1azJwZzFoU3dmdE11NmdHaTJjY211?=
 =?utf-8?B?ZjZydUgyWDlxeXNNZGRucjZNeDlsWVlVYjZFdWxCZmppZEJDRjRFVnFnaE40?=
 =?utf-8?B?R08vbmdWWlZkSDRybEFFbjYxeWlyaG1wM0hSd2cvTjVBcmpBcUV5ZnZ6Y3dt?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248f1785-3a64-4b39-9278-08dbad416597
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 12:20:59.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVgAzjLdiaU3gG5eonggrPqBpoYZJaLAtv/X32lRBdAbbp2ydFOfigGbYGDMlpwkFcbJ7cDjeT8I3oGxUe6+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5767

On 04.09.23 12:14, Per Oberg wrote:
> Hi
> 
> I was looking at the Xenomai Wiki and noticed that there were some outdated information.
> 
> E.g. : 
> 
> * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
> Dovetail, kernel git trees and recommendations are not mentioned. There is a section on the powerpc part which I seem to remember has been deprecated. 
> 
>  
> * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
> Embedded Linux distributions & Xenomai points to ELDK which seems to be no longer available. 
> 
> 
> I think I might find some time update some of the stuff. What are the guidelines and procedure to contribute to th Wiki ?

The landing page(s) are being reworked right now, and that will widely
replace the wiki-based homepage. Will probably surface other issues. If
you like to check that instead: https://v3.xenomai.org. Feedback highly
appreciated!

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


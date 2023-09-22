Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794641749
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 15:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE7PMM2KamAG92rTWJVlqvwyMtOyTDI7y3SnbumH1eJ5vY4ChJ1Ef0uL36YUubeS3YxaS2uAnmBokVDFOtQdXVww4kX3sxBxoKGhsOFiLApD33gUjyapIPGqKE7mVYfsR0kRpAPNrt5wMHaHiaQFKIfgW0QkEfQ8SBgqKiMtBEaV/KUn2TEx8x1LQctgJ6Prin6q092yyHanXXWkjSomt/ZTkwLSqRmRc6TwDrLRqL9lZeBuvCTbuKLwz5w7/Rw01IWX0FWvjWzV8wB51rDTixM8E6024NG42J3PVPWHznRDj8oBdOrA4Vp6ph0EXLlqe+pnV1w3OCu3Gc61EyE4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBpAZe7IWwE85ySJ6T42yoJHyv5EBDaN9IZno2iTbik=;
 b=E7JSII5gnapOZML4ZjvGA1tN2y08r9bKiPf2g5OfpN+mN0JOC54sSKz/f3VN5+7A7fWOmoCH8AtYoqCdby0fHadeAYUAx1QVAQ+GLX9ygd4C+bvc0wAnJbHLX3R9h3BuAewmBp7J84zNbd/kkjPQWYN5nZrp6h7dJhUNwErd2u38B7IOuAlziBXoj3I/p8HoETMq6GPImm8U3UkABVIxuApwHvxTOXJcXZZDCG53eeWhywrXl64ZMWBXz4uYDF9Jbg9G72kzJoWJkeZvZJ4CnJqgSJ6vZfwoqrBKQ7dytvyf4Wytk/gyjn9z43n35VRQjN4miFnPwRK3em4vOeTrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBpAZe7IWwE85ySJ6T42yoJHyv5EBDaN9IZno2iTbik=;
 b=OP8eqg8IBDy4aPanbXkh6JF+lCQ/cNIu88ETNX8bRBb6cbIFOIXLOyrhpI2ttwXmFeF92wcmcHMJra7aD/+IUm2V7cCWocXRejSuPVm1lkkp+4izmAjh9rS369WgaFs1N5FkAidkXSWd9NqMVc1mmb0ReGAgbmlows4l4WDi4xJDzqV3tlEsB+3aC4tCrZ8xwz4iJAeucl3UxZXWnqLIOEjMeH0evO/KLvPE4bHNpC7iCS/ORLY/RTiCJrO+By6Jzl93DbCYmif8OHcxkm65ueohv9TZE4ukXXOAB94uOQC+QbJqyWCXvE9o99muzjOSnlTpGaUizBBdyXumUPVfbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 15:52:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:52:30 +0000
Message-ID: <877f5165-0b98-49a6-bc58-d46998c87768@siemens.com>
Date: Fri, 22 Sep 2023 17:52:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improvements for smokey skintests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
 <20230920135253.5842-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230920135253.5842-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e9b216-3ac3-4939-109e-08dbbb83ed8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dWO6uv3picLMSrqiO4jkwVi/1JzhUSZrGCkmNRNfTfVev8NAwXaktnCbJjimWBPg4IgHcv00kFLwk0miUaH1EUGWx4e9ehjYLVlyJ2u1nJsNFRS8TGrfUOj/plF7G0ftOOjsbKTjSPnRZpvZepCkrSM3tAaJFM/0vVg4spRwnagsGxTjszVwqxRDN2J1iJdOtIy6aQ/2TbidCg5X51THKoggMNT4fUim+PpvugyezPYmF7I+ZvqMwyZXX+Gs4JdRT9CeRQlryyXsYc7MfO/mKwwS/NBcF2nh0b2JWoAy2793VNmr30qEYe3HmXmwCRkPZg9FiTgG3jFzERl7pIJamFMbt89NoYpJNkKz0o+uH/s99lhGueT58CfCn6R2xW/XmQ4Wv7HR2IuUvrW942dVdgJCsg+xN8J/nN5Q2Ol7IOIvU8YmisYHC0f7ajQcS3rU07Wcv9j5GuCwZPUSaxsKAq8qquxkpjP6eyWDEW5ibsaG4H+6EQS8bMTTzkuq+yXHu2MK2VZt476NF2LL5S3hRAQ7ITzVkYxXpqFkHkN/lgj3QfKi4Xa6sPfCw+LD93PRoH+gMjq1tTamrYUMamn4qnkC8QrGa8a9n9zM8iMfdOELjvuEYSRAQKvIL3ssQ1ZONjib3b6U8LqVDhEoi/+r1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(186009)(451199024)(1800799009)(26005)(2616005)(6512007)(36756003)(86362001)(82960400001)(31696002)(38100700002)(6506007)(6486002)(53546011)(83380400001)(5660300002)(44832011)(478600001)(8936002)(41300700001)(66946007)(8676002)(66476007)(4326008)(31686004)(316002)(6666004)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVCd3ZrZUlFek1LSlVVVTdPQzVZVDRVTmNnSkpPU0Rrd3dYZ0NEVjZVNytZ?=
 =?utf-8?B?STZSODdhVTRKTVlhbkZzanVEVEdTeXpBRVpyNnhlZFpsZEMwQWsrSlY3YXFz?=
 =?utf-8?B?NGZlV1lGald3bFYrTzJFVTJIazdTWTFLck80VWlkMExFbG5xQkhjbHpYTnNn?=
 =?utf-8?B?OEtESHg0L0g1cDdLb2djdzJVbVZraFZMMGlZSERJOElDMUFjbElHVnJGQnp3?=
 =?utf-8?B?YTE2ZVBlK2poRlRBbzBWV2loYVRzR0xaTGY2RXg1OXUvM0MvSnM0UEpUME9Y?=
 =?utf-8?B?MUthSGpxbVFrdUp2TDhBWDJELyt4NklxRUU2V2I3akd0ajhIT2Vaa1B4Y29s?=
 =?utf-8?B?SmsxQzRTTlV1dE1wV25WV2xyZHF3dy9xd0k4dFdmWWp1bkZjSW1oZ2Uza25z?=
 =?utf-8?B?cWxaNFJ2YlZNMmVia0xqeWtRNUVqZEZBL3VzWms2cVM3VHNtUUhYMzlJM3JX?=
 =?utf-8?B?NEdDSXV6RlY5M0FialEza2FsVTUrVkpqalZCOFBOc25YbjlqSXJ3UkdHUzM5?=
 =?utf-8?B?MTRKRWRKbDg0ckJqUUpCVWEzYlhlQk1HWkFDN0J0S212OG1Bay90SjN2OHJp?=
 =?utf-8?B?UGhOVVFLSnAyQncwcHYvTDREeTk4MFMreEFrTW9IbkdIKzNoMmdXZGhOdU1K?=
 =?utf-8?B?VHEwY1NQQWs2c2tmbE10Zm1ndllvSVdsR1VMMVB0WDVPektzOU5pdWVPWFd1?=
 =?utf-8?B?bmwxVXord2MrQ1lsemZLSE5jeEFUeC84SUo3blY4M3JLbzZsdFdsSzczL3po?=
 =?utf-8?B?RTZKY2ZJaGIyR09yVVV5eDRzNGJSUnJSNUFOUm1xbUVacG0xanJJcW1nMHZE?=
 =?utf-8?B?TWpmVHA3MVdRRzQ0aW1OejVyU1R6eU9ORmRjMlNnVHBBZXVuOGdEOCtsOGYx?=
 =?utf-8?B?aHhOMUhiS1JLM3ZCa1JOenhqMWFueS9qRWU3dGxZUWpwbjhMaitnaWtvR2RB?=
 =?utf-8?B?VGZvenV1KzZqcC9MWllGV3g0MHNzZ2RhNCsyUWFpV0VheFlMV0ZXVVltU2hK?=
 =?utf-8?B?UlVLb3pWVjJJLzMvc1BVYUJaZ2E2SjhDb1lpZWhnMHFCTTZ2dXZSV0YvN2lO?=
 =?utf-8?B?K1hreldSejRRdlFVQVNDMkQ3dHlyc2xnT2xQNTRwWERBUHl4THE4VnU1aHNM?=
 =?utf-8?B?Wm43OXl3WitWbGtwT3djczNOQ0N5VmQvM29lNnAzOXpxb2tMQ1BqczZjSERI?=
 =?utf-8?B?aEhFZVVYbkVUbEVDOURhZVZmNlFJSk1obFZQYXYyeDRiN0R5VGZIMGxoS21I?=
 =?utf-8?B?VXhZWlNFMzdndDdQbEdLSVdhdHBEL3p0ZFJPS1JRNHQyMGhKOWNsT1Y5THBr?=
 =?utf-8?B?UnFnUlFjdnhKbTNMZjN1REFxVFhRbVZ2dHJSTlNWdEdIZExQYTFzZGhhSzZC?=
 =?utf-8?B?emZ2clVnVFZVdG5SVzRyUXZEWXc0dG4wRWxCdnh5c2JnVjRFNy8xK2xRd1Vz?=
 =?utf-8?B?ekZ6Z3Zab0RUWlk0YkdFNkcrVjdyYktPYVNVNW1jYkZBb0Z0U0FxMXFXMkFj?=
 =?utf-8?B?dXdCS3NJRk1pbUxiVjhCWk1Mc1lHNHdmQU5SZXUyVjVzYUovQ2pqZzk4QXNB?=
 =?utf-8?B?SXI0aVdLdEtlblB3K0ZxcjVOUU1XdXVnN3l4K3ZFMHY2Q2RmTkthdDhob3Rp?=
 =?utf-8?B?MFV6K1J6Y05MaWRCdC9zSmRNT09pVWp0aXEvQnFkWURLaEpjSlFaYXNkTitk?=
 =?utf-8?B?bCs2aDhjaENXQS93U1ltV01Wc3ZOeWNOYkd2MkJpWWpUeDNna3ZzdHZEeUJL?=
 =?utf-8?B?TXZ1RE1PWWw5MWVqSXBNVmYvSGpPc0kyTitaN0ljNHczQlFyaE55QTYzRE5V?=
 =?utf-8?B?UmRLclllWVJFRFo5dWk2UW8ySVQxM3A0Y2lvYjJtdC9GU2pLMTNQK2xRYjZP?=
 =?utf-8?B?MTBsM2hpZ2pmQUtaOW5IaEsyam5yd1ZLRFZlTWh3TXM5QjhpYWFVa1pOVGpH?=
 =?utf-8?B?c3pXVGNudDh0TDlycWttRUdhNDBuTUhBbVRIeWM5SmVCbEhoNTM4WGFnQ1Mz?=
 =?utf-8?B?RE16eXJmLys3Y2lVaFRDNzE0REYvVmM1d3A0SGh0bmtSVURweTJDam1OallN?=
 =?utf-8?B?N2lLWjZ6eFlxZmROUDAybURBYXE3YWJaQ2xyQTZINFlqMVZyb3pkOG43bzB6?=
 =?utf-8?B?Q2dNRjVPaXgvbDQ0VnliVnBlanJxS003Q0xtMnBFcWJUcGttbklmclBBK3Nu?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e9b216-3ac3-4939-109e-08dbbb83ed8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:52:30.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o99I/mrDVOluglo0H1Fetcx5ml1PHNXbSsAP1Lw3kXQdrNyi+DVDoI0J9yXCghAwkl1jqFvwFD/YuESHzq0B7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7734

On 20.09.23 15:52, Aaron Marcher wrote:
> Merges all skin-related testsuite parts into common top-level smokey testcases,
> which in turn spawn all the related skin tests - as discussed before.
> 
> Additionally cleans up some includes and more.
> 
> Aaron Marcher (5):
>   lib: Add smokey_run_extprog as helper for testsuite
>   testsuite: Merge alchemytests in single smokey case
>   testsuite: Merge psostests in a single smokey case
>   testsuite: Merge vxworkstests in a single smokey case
>   testsuite: Drop skin test "drivers"
> 
>  include/smokey/smokey.h                       |   2 +
>  lib/smokey/helpers.c                          |  15 +++
>  testsuite/smokey/alchemytests/Makefile.am     |  12 --
>  testsuite/smokey/alchemytests/alchemytests.c  |  85 +++++++-------
>  .../smokey/alchemytests/alchemytests_driver.c |  33 ------
>  testsuite/smokey/psostests/Makefile.am        |  10 --
>  testsuite/smokey/psostests/psostests.c        | 111 +++++++++---------
>  testsuite/smokey/psostests/psostests_driver.c |  33 ------
>  testsuite/smokey/vxworkstests/Makefile.am     |  10 --
>  testsuite/smokey/vxworkstests/vxworkstests.c  |  66 ++++++-----
>  .../smokey/vxworkstests/vxworkstests_driver.c |  33 ------
>  11 files changed, 150 insertions(+), 260 deletions(-)
>  delete mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
>  delete mode 100644 testsuite/smokey/psostests/psostests_driver.c
>  delete mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
> 

I'm giving this a spin in 'next' already, but I would still like to hear
an answer on my question on patch 1. Maybe that could be put into commit
message for that patch later on...

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


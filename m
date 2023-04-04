Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2827C
	for <xenomai@lists.linux.dev>; Tue,  4 Apr 2023 11:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ownqitr5Lq/CByW+YQi7KIpJUS8nTb8EPVcb/AZ6injYNH6LiWn/01Y9wCT5tf4XEFdt0uubC1TgCi9Ojfx5RtZv5lTRE9LoQ9rrX/CgahfNzJsT10NgM/RabKgoW58Kzg4Iui5Hpzskb+U4YP3HO5EtkAtUuKRbbwVQwhVVKYYPqJDjXHjyUTnqvy+7//S+f48l78ubvz6DT5dyFBC9eFir/8chwahL/y+S5lLLQ7yd6vjGgOLycQg3B0mV06cWeBlQlBLODP6/WDmngHbD7qzw8beI4zN64AoxZIaisstTiHYHC/dS7jvrzGX5Ta7kkh/IhjMfoeP8DwBoYAZptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o2ym92sTPjY/MR/aRaOg+4mzvJJLTLLfMSnX/Q1k+A=;
 b=B28Uonvu55bDYy9ntb77VTfWFZAw/vJekgvZhID1Eh+oGCq+rrmak24c0BApl4/Oq/aI+pclZjCDRuYtvfSh1x/rCtQK701Uo96zM07ZbRKARFNF3djD/OGqWtU4VyGfKr7UKF5o5VPwiXrj8VMdZjWIrG3sXp3zBZv950WSNbACD564uD12qId2Akfc/rQlYXj7q1iIvkC6To38VkRhLfhPiD3MIvon2anJkC8ifuKDMROtJ8XvaTfpeINZrVt4pB0K5E6//P/2N/s78B6hj31xK3zz3dN8hzoR00dpxj2EEr9YC0H9B2rS4fVXdxnEj4arZCvPeIYqWCg9liOb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o2ym92sTPjY/MR/aRaOg+4mzvJJLTLLfMSnX/Q1k+A=;
 b=deGvbWkP88zhdTcvIsCthIQsn+D4YwKrJ+Csr5cE5HPdSA6jv2aOmDhQEJ8DL5tFtByOEkbCznd4vTTGEE1TrFGY2Yefoh5uwW37/pjAxibh1hJn3aAKiFGBlxtESNuC9kN5SBGRO3/JsvwzTSelHh+GpOn09SGoHYa93RRDiy2nsTPXsa0TbbIyzrtay0uNEft8x3CJJltb+kX4JyF+lySpI5AjiRuzYcFyqmOhdGG/TwzYzP/IgzZ7/f+CgiSncyEB+qhca19SHwRJpn1qPTysvnV4g/Nlw4qgW0PhWmshUG54iYzqXyWwcgQ4bfnPI/VdX3wJWtJXDO+djhg1QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Tue, 4 Apr
 2023 11:17:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Tue, 4 Apr 2023
 11:17:10 +0000
Message-ID: <0f0763c3-c37f-2c8d-2581-c070c112b27a@siemens.com>
Date: Tue, 4 Apr 2023 13:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] testsuite/smokey/gdb: Skip test if gdb is not available
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <2a7dce45-185d-419b-2fad-5ad20b6222ed@siemens.com>
In-Reply-To: <2a7dce45-185d-419b-2fad-5ad20b6222ed@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fcfb31-1aeb-4f12-28b4-08db34fe221c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VIHRC4iDeyEShoNE6RzGjG9ykGxhnLSP5n5R4u5uevU+JSJBY7d61CCntTivNdGQ7c/QMIV7x3OZPUYJ+O9qAwRpwpN2LOJzuGONSCP8x5EOhH0IF26Ez0qCvqRpWBsbH41d9zxrTJKOaKOlVr+NfzkN0UKyFfFu9bhg2brATk4k2kwroEINGOUcqlSBbyx0t7DdtdGojbzGgASG66sHMGgso93MzMFScRhqmvSx9ToTskEQn9UteMMwayy5K3LAkekqN1+Z+1wPZMKuESyBQWr2P/zU2gfM18LG2UeJQKmOA7KF1jiog0kGD3NmSCyDP/eH6EXhGuSDgxK72HX771fzvy3vj8m3xeIO3OVC1lSnNLSBKWq7SvkmvK9uUEAdJYv9PD5OsbHILdBX+bPJAHg7YGZDhRb/b16nv8MbFmN9GD/Ud8Mu4A5a44Vbbu8xtcVzWYtn3ADdqBTg6JfRbDy9JeFilV8fknUzwFzPXMnamBroJBykBoe4KJIcvOh/iI/f30IDWMOaheO3SJ41OVqTII0FpIvpMwkcIk4NfB/L7bf67Qcw4wuszWbr0sUH06ckdQbw+afTbFArtrWOdF4pz6cVMoQ4nq11bsIPfhpUaiV/5RkTegEt0H4en+/mntOc+Q3D7LZqn0ZclR1fbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(38100700002)(82960400001)(36756003)(86362001)(31696002)(31686004)(5660300002)(107886003)(53546011)(2906002)(186003)(6512007)(6506007)(6666004)(6486002)(41300700001)(26005)(316002)(66556008)(66476007)(4326008)(66946007)(44832011)(6916009)(478600001)(8936002)(8676002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHRnNjNKaU0vTXU1Zmh4WTZJcFFNblRoaGJNcDg1VHQ0SEFBWERoSkJnSkxT?=
 =?utf-8?B?UzVWY2lMWUNnYzhwMjlGaHd6LzY1UzBjTDVpZm9QaWNSYytnM2Vmdk9ZOUNo?=
 =?utf-8?B?WHNsZmZtUXA5d3V5NWxTc1EwOVV1YkNsTHArK05hdklOaFB4a0ZFbkNmNW9s?=
 =?utf-8?B?YmhMZVpXbHBQUkl0N3UrSTgrbktHZmNyclRDNFVnbDB4RDFLVHljcUpmRkc2?=
 =?utf-8?B?QUorbTg4Q1RWVzBheUJ4S0xrVitHRzd4Ui9sREErakQwV1k1Rk9TUU1JQk9m?=
 =?utf-8?B?Vm5zTE9yMFlNbWMxcnB1Yk1SUEE3RDhVRlFaZ3pic29CZmZUTTNobDRxUVFK?=
 =?utf-8?B?M01WUEdUSVZpN2Fxc0dYZGc3ZnljVzI0NGxMMklBckoxSEVIZ0x0bDh6SVJq?=
 =?utf-8?B?cC9wck9VSWNnT1JuMTZSS1E5MzRLdmx5RmFOeUx1Q1F0UzU4OXBuS25mdkVB?=
 =?utf-8?B?cUlTdVlKeDVZeWxoWnRRckxBdC95UWRMUzJRaEc4bnVrZWJiKytaZG1NS2NE?=
 =?utf-8?B?Y09FdTI2QXl2N2JsUGlPZEFHRkdjcXlxSW1LSjhIK0hMUHlWTG9kYkk0Nk9D?=
 =?utf-8?B?dWVqSVF4UzQ2M1NOMnhtRDk2ZFhRaHVIK1I1c2JzR1piMTNlalJjVlZ0alpT?=
 =?utf-8?B?Nk80bWMrNHV6SGZibW9kNm1IdUk2V0xDMkZPQzFzUDZyaXZsTDNudlN0em1P?=
 =?utf-8?B?YmU5R3E4Y0k1Y3pzNUVHZk8wdVpIcllkUkZKUE5rblE2Nkh6WXl3MStQU1Mx?=
 =?utf-8?B?QjJCaTdMMElpSmJKM3JSRldCV2ZDdEJQSFllZ0VuNlNLSllKQm1EcDRvWHFO?=
 =?utf-8?B?TjllWWpoMkFzYUtwMW5NWnlTVGVPS1g3aEtFWjQ5dHFxTGRCcGlrRFllRmE2?=
 =?utf-8?B?VWtvWkZid2hkK01XZ2VqejJINm00bFlOaEowTVFCd3BwWGE5V2RaN3d5SSt6?=
 =?utf-8?B?Z09nSU5VdEJyazl0NGZuT3BEd01oV3QycjZwRDNQcEMrMzI4M0xGRkhWcnFM?=
 =?utf-8?B?QnhtYnRGQ1pDaWNXL1JrRmUxTzNTVXBqeGNoeHJQSnVodEt3TG5KQTd0Z3ZJ?=
 =?utf-8?B?VFNKVjEraGlubFBnTFVmNVYvZ2R3TEpySG1XSEllaGVKSlk3cGp6REpsZUtm?=
 =?utf-8?B?NlF0d3hpTkVMVnRYTGhsRyttMjNYTTExKzRYUkgrRzY3RmIwYUtpSXpVYVBQ?=
 =?utf-8?B?Q0ZPRDhnL2lVQTVIZndBdk03VWkwaExFRW83RVhkSStrMEpYVWplRU9wcEd0?=
 =?utf-8?B?ZUtsQlh3bmlXcEV2RTBON2Q4VGgvZVk1alBBb1RlU0F0K1dISDZkUWc2b2Ex?=
 =?utf-8?B?Qi9lbEZBajlscUJPMEYxeTlaUWxQUTFJMGFPQS82UkZvcS9yQ2s0VEtUaTNE?=
 =?utf-8?B?Q1lsaFhZOSt0bFk2YkNYM3IveU9TOGNPTXQ2cmxVN1l0cm5KY09qRlVlYmlp?=
 =?utf-8?B?STMxcWMwQWRUTlUvRThDdUFaME1FaVlIb1ZIT1IvTXJmTEh0MXU1S2xNQ3Bn?=
 =?utf-8?B?S1ZqTFpweWdqWmhnRTdZTVRTTk5uOU84WERsT0FpNU1TczZmWkdHZGREQ2VD?=
 =?utf-8?B?TkhIWXFndVZJdHhENWsrWGI1MVR5NDgvWDlWYW83WEFUb01oODkwS2ZQaDJ1?=
 =?utf-8?B?VTRsMWo4SHNOZXFQRG1xb05RWkUxd2p4U0t3ZmNnV2tTeGVLZC9pRWhLSFp2?=
 =?utf-8?B?UXJLY1lGSFRCUEpIS2YyUktUUVJUcEx3N0phcGRDRURJZkZqREZ6QlFYQ3lo?=
 =?utf-8?B?V0JJU0hGSTIwb0hDWTNSaHZ0bWkycEpwM0xJbk80T1lCczZNTUN2QzBMM1Rr?=
 =?utf-8?B?MmJFT2lNaDB0N3Ruamx4Yi93dGR0OEVGZHB2SlpmQ1ZXRk5XcDNJNUJ0aEg5?=
 =?utf-8?B?aWtVZEZsaEd2ekRFUUl5QWl1a2Jab1NnWTA2YVFOVjBiR1h1VGVHWkhYSHU2?=
 =?utf-8?B?dlN2WHNuZ2dNZ2xpeitzN0lrOVBKd1RsMjkyWDliangySnpSUU5uNmp4TVNo?=
 =?utf-8?B?a1FGNUhScWdSWEliRVNaSDdEMDJhRndaWElmWEJEa2d3RFZUbDl3UVlMUDNX?=
 =?utf-8?B?M3NGbnpaWEsvaGF2b2svRnhQMXZsUHNqNm1yTnNqa1gzWmJEQ295Z2lyTExH?=
 =?utf-8?B?VU5OTmVrT3NzSTFGbnNQN2ZjbG1OOEM4OXRIQk9tWXBNSGxMRDZOTktoREZK?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fcfb31-1aeb-4f12-28b4-08db34fe221c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 11:17:10.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIa9p0/5+YHIA5J9/IxvJ7DOaSpGV3Ux4SnQwYzm+i40zB2GPV0IrtdpBGWi14a9f3bJhScenzYKbrf17EHMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7555

On 04.04.23 08:35, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Make gdb optional so that we do not need define it as dependency of the
> xenomai-runtime package. Can be changed again in the future when
> factoring out a separate xenomai-testsuite package.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This could go into master and stable for now.
> 
>  testsuite/smokey/gdb/gdb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
> index eabf75e6a2..ff15dadf8d 100644
> --- a/testsuite/smokey/gdb/gdb.c
> +++ b/testsuite/smokey/gdb/gdb.c
> @@ -75,7 +75,10 @@ static void handle_sigchld(int signum)
>  	int status;
>  
>  	wait(&status);
> -	check("gdb execution", WEXITSTATUS(status), 0);
> +	if (WEXITSTATUS(status) == ESRCH)
> +		smokey_note("gdb: skipped (gdb not available)");
> +	else
> +		check("gdb execution", WEXITSTATUS(status), 0);
>  	child_terminated = 1;
>  }
>  

It's broken, will provide a v2 later.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


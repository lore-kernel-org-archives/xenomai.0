Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6D10E0
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 14:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek41JmmQwW3EzhwUX5wJtEQMat1GD7CGx8oPL7CsFd14gNDqDPtGJVNSkMiJ556psE58DBRpjY5ARbiGuvwedn9d5L94j+8XRsuvCC4S61a8D3nK0/iEHv80blgC7Aihr+Vk5VNThifZMNd2RkqpBTSys8WZJtC+C3lTFRMnPUUBfKwqhaOiU+iZL9GdPPsb5D2Y8+cpamUalVqCuanh8/E1MvODsHN7k9jbHjILN/SwVb1RG8Kshfj135V6IDZ4ZQMlwHJPlW0pY0r0MckyEibvPmS7jXE+A2WyM2WeCAbyosEbQ1/3J4Bp4jakJg+nMJJ06TKME29aY4/Dq8P0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L10rSe6Rk0MLCV9LlkDIaxaphJeoBD2+eBg1dDFkHYo=;
 b=kTwErhhc8m0omL2nMgqbhtSXC4RxcdHnLdWcATHT+F3Wzej8Q27ZJGG8Rpo3kgQvVk+VpyiStI8UdwyrfAmy3Z7BDGbRyCsB6zHLepz3prPKzGiXrpgVCAiDy0YafkN9g50vCHmtrj3sAkLXcdwJtSbn/HOQXAxn4swal0H9Own8BxyvOSDtfM4h8zmrRSzgz4hK74Qdb9z1fh8lKAfdKmRLQrCyVZTBCd1fnzv2IyCov9WWOy4DGgH62/RWvoh1dTUK2GE/qxPca2LSe6BW/T1OFcu9S7VKyH3hGBh5fTBS76GEBgupp1vLkyqHX11NaPdYUwxX+YtEn0CL24BUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L10rSe6Rk0MLCV9LlkDIaxaphJeoBD2+eBg1dDFkHYo=;
 b=YQ/U4Uc/A6SDwnSlqS4Tg5Lv1ijpcGEDRT7QTxp133BahuKJ3CIWGS59eTDECOAZ6ua0843jQLJC5GVcNbleXEp56MuWZdcVsKzoFm3QF6al+lqp+kxbCWZ2CK1S587yT/0SrM1Gq/a7O/CG78GCFiiLAlmWBq0UBV6N+NTT1aduW9NGJNX2+1UGF6e4HBXa5eyfVwNQhXBb3KwcSu15TY0i0mx67pdhoqeJZ0Br9n2OrUx4yYLFzMGD9OdECnpvEce3f9cG0eDkBetTUSilbKLhEHeIDrWCqrPZ+vwb/haZxip9+m3NZdFkmZrPN8x0QMglD3aJSBkr178fju77PQ==
Received: from DU2PR04CA0336.eurprd04.prod.outlook.com (2603:10a6:10:2b4::15)
 by PA4PR10MB4382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 14:06:47 +0000
Received: from DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::4e) by DU2PR04CA0336.outlook.office365.com
 (2603:10a6:10:2b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 14:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT049.mail.protection.outlook.com (10.152.5.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 14:06:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Fri, 5 Aug 2022 16:06:46 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 5 Aug 2022
 16:06:45 +0200
Message-ID: <f9c1d35b-6bf6-d056-bbe5-e0e67b8cad53@siemens.com>
Date: Fri, 5 Aug 2022 16:06:45 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] fix build with clang
Content-Language: en-US
To: Norbert Lange <nolange79@gmail.com>
CC: <xenomai@lists.linux.dev>, Norbert Lange <norbert.lange@andritz.com>
References: <20220725084231.8584-1-norbert.lange@andritz.com>
 <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com>
 <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
 <2e3d458a-65ff-6465-9f9c-7fa4ae44c5e8@siemens.com>
 <CADYdroNY6izikGnjnfwba8T84n6rhsj3x9PqODmbYt8__C7Fyw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CADYdroNY6izikGnjnfwba8T84n6rhsj3x9PqODmbYt8__C7Fyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--23.829500-8.000000
X-TMASE-MatchedRID: MWBePzxHDOwepAyha3ctZsU8jBVxKY1xPg9yfk4YC0YHg/3jhUF469dJ
	Rhy28lIuLX3qyf3ewG9N6CjTVr8dyrwXBELJxfx3j0IvV7jlqDhyPzMTUSO1JPzTlJK+gA836Hi
	gDLMyLuaFTK6KCpk+DNI9YVIwAnUKeeD0uelq9duuyvagOo6URo5dVuh2ywvhXmFVlObh0PxBfk
	JWKY0KaWOMyb1Ixq8Vg4daSG/gsBQXxDANc7MuDiFvIo822GyY2mNWQRnjOjo4hD0Y/Y/a75nZ3
	QZNYH8lSHUIAogzvCtAd9sp7/hgkgHllvfPk9TMeNX5Q7eqIR72dk05BAeD6rzgL/eLACDE5GNm
	5cTRaUcjIzpupoCXKxvMZwo+tRxc4vM1YF6AJbZFi+KwZZttL7ew1twePJJB3QfwsVk0UbslCGs
	sfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.829500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 70F62B2481AFFD19FE46FB4E3B403AF40EBF312BB073301CC700763C3B3364072000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32636a3c-8794-437a-dbcc-08da76ebbbeb
X-MS-TrafficTypeDiagnostic: PA4PR10MB4382:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aPWhMQdTkZZdQquihMRrqPMUYCawtNfqr/ZzyCX/O35oNi233QSmdqUYnXrRVswKCXLtKLzF6h1V/5lxAcXO2fRiRoMvlh8jaKMdI9X/NgY2KoA8RgFoeJveVwcT+aIq5dyiCJORTmirWZq4rS+efUlslltsxL29fPUvzSWSKQLrVSfm8paYNnhDSV4Ie3vBQAE+0xoMjawr6dDUlZc+LYdZUPhAJDTqFeOE9t8W2OpC/eRm9TQYp1yODT1O7wdHZ9uCM4TR1SdbBmWE6hzkyaY2ZLBdT0rbJvGWXb584EN5HAyN6fBNFurD44E9GthIScUgv1SFdC+yipqGZo9YAfYe7J+s7h1qyMUjV2rHIeRc8Q6Ovc6uwtJn5RF7zr5JCu/EOrK+aSS0DZoeDNLoWVO+0bWPzUYzfVUPpTS3shRfVVLu/hqoI694ToRlPYwuy7zaRXzTxzMin8lp/DHZQ395OunhSeXr2kvrJIIynzOdnp9StG81GL8MCP+L9VidGYa0nbBXplmNTdEm+u6IMytHMt9PrWiV0BYcAyCZZm4SPm5BRgQqr4oifjO1Yv4aULnbdHPc8I6Gbrb0WA9/qF8W6ZnM8E3F33P+ub7Pjzbzl2VKyRWs3Ltl8Bl5Dk9q0isM+ijS9cjLzuAgZoVJXd3vPjzRDbzMPW1sRuufqHX9mlFmbSP7xAAtslLtMzTggap8zPrINNWDz+3fej3iL96kJJ2zDpMDs3lg3NDShRxKNi8A2AFq5g2SjF/mL/DdPYg32dz7W/R8DJwQJuBqWsO8zVePOWgVH672b0nMQgz3E+7Z/8Da85NUDlx9nv22zB9bGE9R+xrZ3pC18zvy3KG0igpSXyErZjWRoTLrj0khlzMrbE1V8Pt20tKjb50+sVTZnZ+eECQc7gQMlfb8Nw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(356005)(478600001)(81166007)(41300700001)(36756003)(86362001)(31696002)(82740400003)(53546011)(26005)(31686004)(186003)(336012)(956004)(16526019)(2616005)(6916009)(16576012)(47076005)(83380400001)(54906003)(70206006)(40480700001)(70586007)(316002)(8676002)(4326008)(5660300002)(36860700001)(82960400001)(40460700003)(82310400005)(8936002)(44832011)(2906002)(6706004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 14:06:46.6513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32636a3c-8794-437a-dbcc-08da76ebbbeb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4382

On 05.08.22 16:00, Norbert Lange wrote:
> Am Fr., 5. Aug. 2022 um 15:45 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 05.08.22 15:42, Norbert Lange wrote:
>>> Am Mo., 25. Juli 2022 um 19:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>>>
>>>> On 25.07.22 10:42, Norbert Lange wrote:
>>>>> clang will never support 'variable length array in structure',
>>>>> and there does not seem to be a reason for this weird construct.
>>>>>
>>>>> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
>>>>> ---
>>>>> v1->v2:
>>>>> *   fix algorithm
>>>>> ---
>>>>>  testsuite/smokey/memcheck/memcheck.c | 6 ++----
>>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
>>>>> index a33700f49..b11d2babd 100644
>>>>> --- a/testsuite/smokey/memcheck/memcheck.c
>>>>> +++ b/testsuite/smokey/memcheck/memcheck.c
>>>>> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
>>>>>
>>>>>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>>>>>  {
>>>>> -     struct {
>>>>> -             char x[size];
>>>>> -     } __attribute__((packed)) *base = vbase;
>>>>> +     char *base = (char *)vbase;
>>>>>       unsigned int j, k;
>>>>>       double u;
>>>>>
>>>>> @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>>>>>               k = (unsigned int)(j * u) + 1;
>>>>>               if (j == k)
>>>>>                       continue;
>>>>> -             swap(&base[j - 1], &base[k - 1], size);
>>>>> +             swap(base + (j - 1) * size, base + (k - 1) * size, size);
>>>>>       }
>>>>>  }
>>>>>
>>>>
>>>> Thanks, applied.
>>>>
>>>> Jan
>>>>
>>>> --
>>>> Siemens AG, Technology
>>>> Competence Center Embedded Linux
>>>
>>> Could you cherry-pick this commit to 3.0.x and 3.1.x aswell please?
>>>
>>
>> I can. I was just not expecting someone starting something new with
>> clang on these old versions now. If you change something as fundamental
>> as the compiler, why sticking with that versions?
> 
> I am trying to setup a build-server which uses clang, for using
> sanitzers, codecoverage
> and code-quality. We wont change the compiler and don't want to change
> the xenomai version.
> 
> I guess I could just use a newer version of xenomai for the tests
> without adverse effects,
> but so far I only have one xenomai version for everything.
> 

Ok, point taken, 3.1.x updated. 3.0.x didn't have that testcase. If
something else is broken /wrt clang in that version, please send a
specific patch.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

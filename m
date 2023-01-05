Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6080F
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 06:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9N90W1czrWfhUhe9qFvya/mNMNVYouethtJM4OvLjWUolyU+t5jEOPDfiKrC9HTpuFU8s+UmSgpFJhstt7GvH0Q/Y0fREOxocinFgTLejq03JVpK6/A2upxbxVfTBK88wCLql3ZVCnc1hso+yaRDXdrRfpykuKPeHs++i++zMeGwapwV16A4RnIFZUIhWKh85cqDo0ZG9yuHGqfcKN1tGNu+4McbWueNZQXqY9EArbAVCSCUlBlEBNKWfxL9hrO+a8YjoVSPfIUOfTxH7dIpKBcqjuY92DFcSfkb01FjejqhY2aBem8auq5PhAxlJvpKTrSy9yD+WABTfy8nSmd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrlLYm4tORRX92LP1a4kgk3j8DtAMIOOuiSHVm1hKHQ=;
 b=Vrhi9R3i8R9KGu+W9DN3CQ2ojCyVOf9mZ1jqECRMrjpTOYv59vSjACu071wcqL+KNwF6E5+2tvNweb2yGNh8+dwRkhfcVH3+vjCzt1IAEB/M1TNYwLS4oSyhHkLK+CYbWCFauqO/mDtHwerUa+RzmRgNOgu/88KGybcZCGqAyNlfca5D5S1xYag8gah81PrQFiVdbhhh/utJqcyJnnPN6BI9/c/WUC6m57BjCULhlp4TC8NxAg0wT/oCMLyrEO2u7XFaxdUXWrSRoqx2tfYRgdJ9VJms4D2zTIbI7IUuQajlRQDTI17s4npLa2rcB3mLIbu6IEu3RGaCQk1EpNaKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrlLYm4tORRX92LP1a4kgk3j8DtAMIOOuiSHVm1hKHQ=;
 b=ZntzMAkiuNZgZC9IbhDtF8UDiYvZ4SvqhkCCRpoNYzKoaFjRKeezYIaNpqj8wQTvKNhuWCmGf/wycGmmBlvrK8IdxB/Wf2fktD7E/2OQhPi7BZOHAX8nmOxet7w5whPWqVIe4gmw2UFqBMkOehjzSS0S9vwD6FLGeWBZ67WNaHa6o7xnmNgDVrxULcD9UT1vnkv8jPyERD9omly04xu3IAanuSGm3VPudDOXp6onubepjoGGVNQlCF9qwDUitqiuzql7BDB0FKgcoZEBr1VXMfpHrhIN3blOHSP8HWZvmCOLmlE0xiovum6ilB1pDzvnfCyNWlnC4Mlh1nWXdwwltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:59:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:59:33 +0000
Message-ID: <68351de3-9b3f-9132-157c-8bb7cd5e3676@siemens.com>
Date: Thu, 5 Jan 2023 07:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/net/freescale: Convert to adjfine interface
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>,
 Gunter Grau <gunter.grau@philips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5920a7-ae55-4637-50e8-08daeeea6614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TvH4rojIF4Qmm3MmfZdD5f9r4Ba6Sux+b4oqE9cTi8UzwrxRVZBA9HFFhJr24KszT/9F/OB5BoX/QraX41uKqznR3yMgUpzllAB3qvfKl6yrsRK/HL7ihSW9OoJNkWggNOMcS/oMccTQxxGRpeb9U/kPJSqOZQhDlatlT+rxnaeuMDndsw2P0btNyBk+U1CzozGJb2g74fpt0z0KUR/QopwFo5FOLHEpBAUbI72l1X9TI12ka0x1p9bsAieq2Le7tJ7YKXB5DYkz0G2Azhz5nMzWQgfghox/ZZb/wK1mOzCe7j5+l8a0ZV7cGsBAlbutkkXQEemDnTpRFpb/GoO++fyfhtOOnmkAUSP9xVChFJVsMqn+WhcxaTmqYo3cch+7rXF1o4jO8jWYWKvP+05bEc5h5E6wI9TPQSkYY2/QEy4Rjzl6scydThTPBreOSHyOc2o05hXJxPWoPWjJLlP5VleNoCp6aiTYH/DNxKbjUL4kgPT8+etIAAcfEOMjE6IT2HycN36OZa+cGwWzbqwbu9WfUmIiBw85awiIk1ul272/ORFfrur1JXO/ZuFmImzY5Rh+iaDRjFJsTDYT3YStuqJskl+v0lKiZOVtY02SSlaBuBhqKh9/+CU1pSszC4RR4LlcXORxdbLZL4NGY25pbx+ASarXyo8qDGW7xoJI2m4VMDLdyUhnB+M9j6XKjsIGXS4W1OP/96hWmjCXQXMrapZPYamI++llfZhxbcp/Q2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(36756003)(6916009)(86362001)(54906003)(316002)(31696002)(478600001)(44832011)(6486002)(4326008)(5660300002)(2906002)(66556008)(41300700001)(8676002)(66476007)(66946007)(8936002)(82960400001)(38100700002)(26005)(6512007)(186003)(6506007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVhNTTlJMnl1VUVXam9YalBIb2cvWWhHN1dCNlFweUx5SjFybGpDS1Ivclhl?=
 =?utf-8?B?SDUrQitLYXdBQXdqNXRGaWorV0hTd1I4Ykkwdmg2S0xJT2VIUk0xdVFGKy9T?=
 =?utf-8?B?cWZzSmwzNXQxRmxlVDM0bU93VjliRno2RDFiNkd2Nkh4N3FmQWtjZEJua05C?=
 =?utf-8?B?dzdwVE12OFhqRGRJYnZ2YmlibUxRZ2JDSG5EK1MvZ2FQRDhtcHlGbTdtbE1p?=
 =?utf-8?B?YXluWUVqc3kyY0hJaXFIRGNweWJSMnNJNFhoMzBMRGg4eFdxRnZrWTVIaXlk?=
 =?utf-8?B?Rys3ZFBwMXVYNjJpUlBrZk4zUnplbGFWa1NpQlFKYkpSUUNQNUNwRVRCSlR3?=
 =?utf-8?B?UXZSRmlJcWpla3JrcUhQc1hVYm9VRGoyRmE4U3RPK3ZNKytkV3EwN1pNRU5k?=
 =?utf-8?B?NGU0bTNvYk1rajJPQi82M01nQUF1bmI5MXdTWUhPSVZBbFFVU1hkK0hmZDh2?=
 =?utf-8?B?Z2xXbHYrclAveENVdk5vV3RzbVJoanhNZlV0QmtKcDY0emxDbFRHZFNNWFkx?=
 =?utf-8?B?NFdHQkQ2Qmo5dWlGQ0pmRVBEdlo1T0NDbmlCeHRaaWwrL1NyWGhqWFlKaUgy?=
 =?utf-8?B?RXlFVm9xM2UwWVh1R2pHTUNzM3I2QXhZcmRmU2x6Vi9tUm1YTFRnUk5lWFFV?=
 =?utf-8?B?bzdxbzRDOFZhZlN4MFcxU2lFaHd4Y0dBaEQ2QU1YaXA3RVh2UzNWWG1aS3Zq?=
 =?utf-8?B?dWVORFNFdFFpeENRK05ONCtPT015R1ZGb0hpNjVyYTV2Tk10WWZMMUhCWFk1?=
 =?utf-8?B?ckNiN2liYVVrM1BBWjZZNkc1SnpzekZqVEFqTVM3R3kyMVMzUDREUDV2VVlq?=
 =?utf-8?B?VElHUEpVNTRTcE1BMjB3VlhGbGhBSlVFNXdzdHhxUjEzMTcvNjZubHBSRkdC?=
 =?utf-8?B?L29LNU9yRDFyMkZGK2w5VGNvWjl6N09CQTgzV2lsbCtpTW1mTk4wd1dvKzNp?=
 =?utf-8?B?VjVWSTJSVjc5OVhGbnpmSTV0a0dsUUo5bVVQWmROc0pFZUpxZTBxOFJ5bjFm?=
 =?utf-8?B?dkY0U3BITHhlTFpUeUUvN3NPQTB2NkJ3QVQ2YklWWlNnaXpFM3JsLzQveVhB?=
 =?utf-8?B?T1pEV1BpTitsOTVab2M3dnZwQ0NnU3NoL05BTmlzNTFlOEhiK2dnSCt1NTdh?=
 =?utf-8?B?Sm4rY2ZhTi9LUDF5SWd5WnNoUDNsQjdEbWZpTml5eHhvOVpLVEVQb3R5Uk1H?=
 =?utf-8?B?akJ0QzVueSszaE1Ya0g4ZXF2b2RrOCtCZS9LTTZQOVZsb2FkTTZsRUF1Ym1y?=
 =?utf-8?B?RUsxVVpLTjVZbDZEcGUvcEpQT2ZhRDdBQUcvT3pnVTVIbmU0RXBwYmZMdjRH?=
 =?utf-8?B?VGFHSGZtMjZMNk42bC9IYTdxbUxaQ1pWUXFMejllSWdVT2VLWTlQQjBvUHpl?=
 =?utf-8?B?VVFtOGUwZnAzcC93NDRHdURDSi9Bd1JSU3FRamNUZEJsVEZpRThUeDhvd014?=
 =?utf-8?B?YWRVUytRUzhjTWMxbXhsbTQ3RWczZmhieEU4TmREeUg1TUoybXJLTWM2MlNL?=
 =?utf-8?B?TGlIT1BvdC9LTmNEZnV6V21PcEVwRkJOYzJyV1JHZnFtWi8yN1Q3dklrYXJP?=
 =?utf-8?B?SGJBUnpKazhTV0FDNFN1NkExZDF0QzVTTThWUmtaZExGRW80c1VEMFdPZ20r?=
 =?utf-8?B?ZitMUUFqaTloRFdmNU1RR0FkaG82cjNKT0ZrRzJsVjNrSnNhS2xDeGQ0dm5S?=
 =?utf-8?B?aTNhTGVzbjlLbUIyMUtHVGVJVyt6anFhU1E1L3FjaU5YWnlITVBDUk50eE5o?=
 =?utf-8?B?cVV1Z09oZlgrZXQ5LytTSktSWjZTU0tSUG1jY0FVNFBRVTJrc2ZxTXFYS1A5?=
 =?utf-8?B?cE5EaWtWbjhFREFPcFh2WVpCK0ovVzdpdWRTRzUvazAxOXhXTlN6Mm5jOG50?=
 =?utf-8?B?bnhOc3c0OUpGUk56WmhpdUh5NnNHL2hMRTU4QXZKWkJ4OTFHUmIyQk1KTCs3?=
 =?utf-8?B?dWszb1NJUytOWXdMU3BtMGJtNGZvdTdJTno1aU84VzY1YVE1WnlUU2dWWm5v?=
 =?utf-8?B?aUZmb0lGc0ZkaWF2bndwVjlFZjMvdktIYnVrVjl1dmdvbk5FUXlid2xnNlBG?=
 =?utf-8?B?YzlSRER6M1EzTTUxaExqcDhhUzg0Z3M2aUZ0L0JDZXIwRVg1NjN0Zmtta2ZI?=
 =?utf-8?B?aWRubzRhUExSRVlSQ1JBVDFxQ0xkeFh0RVF4bFhPVktadit1ZGlvbUtJTm1S?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5920a7-ae55-4637-50e8-08daeeea6614
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:59:32.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+CnsIwhfvrv03rHDhpKfvQ0495o7S6PEMyTfb5h2wLbcRERcBPqha4fuugwytcfSQkMmT/jjjTNgrI/Z65RLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6017

From: Jan Kiszka <jan.kiszka@siemens.com>

Extracted from upstream commit e2bd9c76c89fbe25df351fc5902cbbcca6a7d372.
We can apply this unconditionally as the adjfine interface was already
present in 5.10, the oldest supported kernel here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/freescale/fec_ptp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec_ptp.c b/kernel/drivers/net/drivers/freescale/fec_ptp.c
index d71eac7e19..e7ccf7d676 100644
--- a/kernel/drivers/net/drivers/freescale/fec_ptp.c
+++ b/kernel/drivers/net/drivers/freescale/fec_ptp.c
@@ -268,18 +268,21 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 }
 
 /**
- * fec_ptp_adjfreq - adjust ptp cycle frequency
+ * fec_ptp_adjfine - adjust ptp cycle frequency
  * @ptp: the ptp clock structure
- * @ppb: parts per billion adjustment from base
+ * @scaled_ppm: scaled parts per million adjustment from base
  *
  * Adjust the frequency of the ptp cycle counter by the
- * indicated ppb from the base frequency.
+ * indicated amount from the base frequency.
+ *
+ * Scaled parts per million is ppm with a 16-bit binary fractional field.
  *
  * Because ENET hardware frequency adjust is complex,
  * using software method to do that.
  */
-static int fec_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
+static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
+	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
 	unsigned long flags;
 	int neg_adj = 0;
 	u32 i, tmp;
@@ -595,7 +598,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	fep->ptp_caps.n_per_out = 0;
 	fep->ptp_caps.n_pins = 0;
 	fep->ptp_caps.pps = 1;
-	fep->ptp_caps.adjfreq = fec_ptp_adjfreq;
+	fep->ptp_caps.adjfine = fec_ptp_adjfine;
 	fep->ptp_caps.adjtime = fec_ptp_adjtime;
 	fep->ptp_caps.gettime64 = fec_ptp_gettime;
 	fep->ptp_caps.settime64 = fec_ptp_settime;
-- 
2.35.3

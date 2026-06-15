Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2733F9A07
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533802; cv=fail; b=n9yv3jAU5XaipcVPt34trPA2aShdS1JtdxwFx1NN+0Ue3bPmI/dpxzwayATbb90Oynol+pgCJbNTaitupns4TAsUP2IDy2Qfmk0Lr6VS2N1Np84UmbrtceYqP62EMb5m02AFmRRTiAaambphdlgr+9h0sEoGW450rjZ6YYLK41k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533802; c=relaxed/simple;
	bh=idBP+vatWa9dKfeGn4m6Z9FAovXgD8R1b5I5I1ry9eg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=i6Jx9/Xfw4vz6Q5s8Mzdctd7zKEB+uBtsweh37r1F8dz+JriNISF9k/zlFnykURdyb8WplvVEPZwKUyHGmzOVMD4hCVkpBKzfvZg8p+YCtA7oQRQePck5ANk0OsJdsVNBq5HbXlBp+7gtf7K905i+culRIPRbeWvXWSjmkgjlA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XT0z15dr; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XT0z15dr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTcuA+bPG++GvaN5t+5DVZTn5jWjjO3i6z1L9TklQYfiqBQR6hws19mpBE+sogyQb3zRm1/6T5ajq2dpzH+DTgYLZkkAYXQSppvDv5TeyXurvGvvlIci4/T5j8YLAHFpnzOjLHxN8UEQ1Jlt1VA84cejIZH4mM+Zez4eUbRPbp+5bOz1QqhXWBdwUD9qhCRad8CMskoLt2tBD6ck6UgdXpuH8jPxuxQemDPS0ERfd3el7+mOCaGuR4CVaWd1Wvu1Yn30NsBrlGqeXr5W9oM7STMPUNMPqf5wi75Ce1TJ3WnzZz7QRQVSfTGMqXkBTuiAe7X5uc0Oq0SFjKINT1NGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r942/Up9rzHqyn/Han6VtuOa+JNCpn19+oZnrRUhsI=;
 b=qy1dUe4GkLO/N4TerRK7KqOusJFwanPkSJMR0MZcOEezcIY4A4xkLYOMkIbrdlvHbrKUUcucxrQujVQqrIEliNKiKbCVdcIbvA8+YLBDIfhnGeqeY0JUlpow1obZ3htfmaRac3aenOGJwGbDgMhBGEqee1Heib12DirvFZzmboLeSyrRsB+DHHc0I3X5VPuWV/uy1b2olzL2nJbyt0fd3ZpJQGCIUp9pIyhbAifHplfP3JLM87gWzxM0YKYH22pt6DK5Z7xpsjUEYUEGeKppul3m5ghJiu9HFe3AKJ4dj+jQNK1zlylKlxnRn5in5kBQlm7DbregxFt2jXwziVWSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r942/Up9rzHqyn/Han6VtuOa+JNCpn19+oZnrRUhsI=;
 b=XT0z15drreHim0IMKYuA+KBe99iB+la9CTKlw3ZQwnMdcOIp6MNdKhGFHcLn33oaEz7U7STeb2HUqL9d3Cm2lqAf4dj+hETMgIAhJpZNOawfNqstmoMrqSE3Z14xJYGF7Guo4ppkqTVFHST6Cmkz5w31JuVaOxqQwHPA/lDACam/sq0Cft/6HAsExkh0dD8ibW4z/SHtQiF/cfXBTwNPJyjp0MJ/wZmIf9uNttNBXdwUqZeFLHfJDBaVytYIgaPktoE/ETOPGwfaxhrH5nOSkP3hoKe3AfMQv9TacrQXGaMc4SeLHVLiGAXLSahsbh1/wS749vNeGdNwHTzpZUpITg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:29:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:29:55 +0000
Message-ID: <6e6b8111-48c9-483e-83e3-f6f6ad62f033@siemens.com>
Date: Mon, 15 Jun 2026 16:29:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/net: Fix long-standing next shot calculation
 mistake
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1616ad-b273-4a7d-fab7-08decaea91f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|23010399003|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HX1CML0Ak9O441decEdrizMVRCtVPaMFmZZOA14q80ES1GBkhueOu5HZT7F8UvG+h2fTgT/BVxUN+G1FkPeFkWBtB1S0g+f1yz8c4UWpA6kU/XJauWgyn37mGK9cJYLitvaTXCDp1xkaStP7aQB50kV7I5d8mplaYFRgMNDTiv7JPoT76H9/oPBl/l672Wu+1TrSqYhf4wqmWX0ecrkqsB3CDQ0C2ppDdW2MXBL/40Hd7mcGH7j97bD6Cd6nRjRW1GReRedhUXaDE2q3CyyT/6IRSueJZH7JfyzzIVHF3jIKR6bc31qkHpP9HtZVTPCdhK41K7Mwe6s8S6IeeHZ374FzZYqneq/3EK+Ob1BfAnWsXZo/XVM1Jr6w4WvmdvAlxNkVC4VMXSUtu37OQvGcgM39NS1gMTzvZ35mo4fpQD6rOJNsZXDd6Iz7rwZfJyt1GvELurr0t5sqJa+TDldAhC8vfD5r8dnPs2XYbH4GCevdZECSq113A6QQ819vLBbNZtwIhGK87xFcNjZJKCatbrDzH+1LtcklYSIGf3Hb+b5nz8c60fAaqwhRN1bh80beRK4QVn41URowtahlnGi9OJOl//jkDOWF7LGVX+Yv1LkYY4JXxs/u5yRxjLlV/j15hMPqKvxMlYDILUtPXgRHiqKRLOMCul0i0QYljVn/oOt9GLwvxd2YApUfw7WE/Lj/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWMzbmJuOE94SlJ6R2ZvMXZKUm5yZEw0ajdSRU04UFpRUDdQV1ZiVVBHYWRi?=
 =?utf-8?B?M0dQTWJaOXNwRXlqb1I4Q1k1MWtJM3FiRUpSam5BTDV5TlRBMDB0eFZoR1BO?=
 =?utf-8?B?ODYrbTRVbVlucHV3T3hoVDdjem51Uk1LSjRFaTlFOWFVa05jd05TUXZkQTBv?=
 =?utf-8?B?Y3FPQURUbFNUR1I3Yk52VWI2ayt2TUZtSGJ4NFRGdUsvUVNiOFpUZmdZcS9a?=
 =?utf-8?B?ZTFuWnExYUZqd2czSlRHL1grSHVzY2lTenQwUVVxb2YvV0svMnNuTnVlVGN6?=
 =?utf-8?B?TEFNcm9Ic2wyTjFWaVdabE5JSlROZlpWMG5sVm1pVmxJNklSaE5JdEJJTzln?=
 =?utf-8?B?YXdmOVVleGI3VHRrUmpYaU4vSlYwMktaYVhvZHJleXJKb0RQOXRCaC9OUU5i?=
 =?utf-8?B?U2ZmWkF1QUVXQUhzV3ZKSGV0a0V6Q3F3K2xQek9oQjdsUCs2YS9EMXhmd2tY?=
 =?utf-8?B?YVprdkNyVWhvcDdld2VlZFo3ODJvUEphMXFaZ3dIUlBhWXZ2bmN4d2x2MldX?=
 =?utf-8?B?YlRlQnJTdEwvNlU1bm0rRHpQNW1GemJ1SzNDMFhxbjhROUJNWG10N1V5eUZk?=
 =?utf-8?B?WmZiRXVBYmJDOEtnN3QvSEFRL09WRTZNNWsxbVRrQ1lINjdSeG1wTzdVNnMw?=
 =?utf-8?B?UERpcjVRTUViQndVWENqVVNWNWFGVlBpVmFmUGJLM2VEOEtRUm5qb2tIZlEr?=
 =?utf-8?B?VTNoL3h3MnNFNi9HM0s5UWZYSTd2dkZpQjJIVzlwN3dGSzEwNVdOdktjZFZH?=
 =?utf-8?B?YlpXdHc0QVZDZEdqaEMzUWFDczVDWmV4NThnK3pweUZteXhIZ3FPb3VXUHhs?=
 =?utf-8?B?cHdrN2dQMDZHYVFkcm44Um9JZkZnSkdLOEZlbGJIa0JQRVFKSjBLd1RVUEpl?=
 =?utf-8?B?R3kyOWxudGNXZStpQSt2YWQxUXZzWFVidUV3aVBDSGxvRUZqZ2t2d0pmbTVj?=
 =?utf-8?B?dEdsSi8wUmVyTUdPYWVnK2dPRkQ5aUNJQ01xNm5VaWFHZWQ0ZWovVUdqU2h5?=
 =?utf-8?B?MXgxR0d6S2Fhdmtwbkpod0l5a2RsQThpOVhUNG5SN3A0M1pBelVvaU1oaUxl?=
 =?utf-8?B?cGdMUXFBVUltdVhPQmZ4WVF5R0pjOC9KNVM0K1JDNHNmcXl1UkN3cnU5M29j?=
 =?utf-8?B?bUpRa21vWitZc0UzVzM5UEZxeDcvWkJhVVFRMlB5MVBHYk4weHcwVWEzYnNQ?=
 =?utf-8?B?WXVQc29WOWRBb2ZJelhVVzlveUxHQm84QUFhcVAzalhGbE13ZXQwWXpkY1Nv?=
 =?utf-8?B?eGFMclNZN1dnMDRxeTU5WXFhU1BVN0o1anZRVTg1OHl6WjZOSndXakZkcE1m?=
 =?utf-8?B?ek5saGgvM2pXU2VKRFhnaEpWUkZEOFdtVC8ybm8rVjhOSkd5SElmZFZUaDcv?=
 =?utf-8?B?d0VSVEdrK0dzRkZob1ZBQU1ueWhySFAyZjdnZmtrbWFqU1hnT0tEdEdmZWFZ?=
 =?utf-8?B?cVJLZUMwNVRKcUdwWlowUUE1T3BCTExvK001YmNDelQwUGdUY2lRMy9VSXBL?=
 =?utf-8?B?NUJrRldMb2htTUZ0ZzBuWE9hTTdRNEdCL0Z6d3g3UEUvcGVnZ3drRENwOG52?=
 =?utf-8?B?bUN1bFc1cVJQVFVIRXJ0VE82cDBTbk1sQkU4WVp4MTBaejg2UjVhV3Yrd2JV?=
 =?utf-8?B?UUxjZ1dQVmhaT2dya2FHUnpVcGQvS2U4OXpCUklDTW1JSkNudHNqSE4wc2dW?=
 =?utf-8?B?cUY2YWxQWXNYUU1oSENmNjhzR3J3TWVHRGFja3hnRkEyTFhCTEIyRnBrOVlz?=
 =?utf-8?B?ZEtuWjN0Y3F6V0pVUFFDQWFEcWRmZTc0cmM3WFRLTVVzaFZpems4MXpJVERr?=
 =?utf-8?B?YUZITCthdGd1eHZTSE13dnliaXZ3WVVqeWlUdlgrRm9iN0NsT3ZuMFdUOHNz?=
 =?utf-8?B?MkhNL0luaVRIMkZrVmFhZ2E1aFdlLzZoK2FJb2l6bVN0NFFDMUp4ME10RFNa?=
 =?utf-8?B?aFBJZXhCRndFcGlCMHF0QVlmUmwxNkpUMzcrOHlLdVFMU2hxTU1nN3paU3VX?=
 =?utf-8?B?ZGJpRGJGUnI3N0Q3YVJEVFErV3ZwSzB3UGlUNnNEY0UxOHhuRnp5TFBldG11?=
 =?utf-8?B?WXFYaDZRR1ZhZ3E3Ri9vRFp2dGN3ZVV6eWFjM1NXcnc5YWY0WldNanZuMnRa?=
 =?utf-8?B?WFh1Z1lXU2tIRkVVTW5yR0xHTk1COUNTRHFicUxVRTlZTmJSMWZJUWkwNzlT?=
 =?utf-8?B?bE9UQk5kTFg1RDBVKzlSeS9UNWhiNkZGdnF0ZnBOd2pEUTFXS1h1SlJqWE9X?=
 =?utf-8?B?TGZZMWFtSkl6NlM5WW11WjQwS25xeDRqeUd2UWxCbWZzQTdKdzhxNmIwNWYx?=
 =?utf-8?B?Z2tNM0UycGxkZjFoWlNROGhlZEdrOGV3TGw4S0FEOXM2SUdhMkMrb0wwRTUy?=
 =?utf-8?Q?u4lZgEc2OfnORGM7vMwYOuzcI80xHn2GkcGaEw+DnYsHd?=
X-MS-Exchange-AntiSpam-MessageData-1: SE84n0dm8sSmyw==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1616ad-b273-4a7d-fab7-08decaea91f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:29:55.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3p5LnglFEkWc9yhSei/QITzPSyBtNkxiU9LpRGsvBq3F+62m7Q5uVe1N7Ni3ydXzhLErY4HHutyVaAlVwKGObg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8254

From: Jan Kiszka <jan.kiszka@siemens.com>

This was off since day #1. Fortunately, the impact was zero even if we
ever hit this case because rcv_packet is converting the timespec back
to nanoseconds, not passing it to any API which expects a valid struct.

Found by the AI while looking for reasons of sporadic lost packages. In
that run, it attribute them to this issue as well, slightly
over-confident that everything it found is contributing to that.

Reported-by: Claude opus-4.7
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/net_common/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index 914bda4a49..9a17e413bf 100644
--- a/testsuite/smokey/net_common/client.c
+++ b/testsuite/smokey/net_common/client.c
@@ -176,7 +176,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
 		unsigned seq = payload.seq;
 
 		next_shot.tv_nsec += 1000000000 / rate;
-		if (next_shot.tv_nsec > 1000000000) {
+		if (next_shot.tv_nsec >= 1000000000) {
 			next_shot.tv_nsec -= 1000000000;
 			next_shot.tv_sec++;
 		}
-- 
2.47.3

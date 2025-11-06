Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBC30E826
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439682; cv=fail; b=nCVy851X6CjCfKO5ArubwWfUbBPM+yFIWD3apbz4960o7XCgu4XtoEuJDIk3XDoWCUk87Ov5bFDqHzk08JC61uJQ0l7e5TgM5solzyz3mGyFK7b86ZPEYd8qH59VBmtETZXkUn4Ma2hx6rUPAsFQPMYUvP0ftZIFm7WUOHamPOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439682; c=relaxed/simple;
	bh=iz4kA4dVf8fDNQDdvJmGSLUmie8jJWIuhz1/MglDJyE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eVi5ZDi4iztATEm4ydBTZE87IKFCT4UitthE5p7deoVQK8Ookd9sqE7/jJq3R8Q36qa9uIi9+mfyQNuaS3pgd6rZJemOSweNUpFhjGrPe5Qm4IabE7AI0FBNBn0De2NLUaDiT7tEUEACs0ByzzfDdjJpwD8KHyEGmw/eqz7wTl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DuCj6ZzC; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DuCj6ZzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuKUH6slYNBk03zK9lY5CSXs/0HCtUceB9DOPCZBOS0seNqj79jPs3KqmwYW0F0OI734LkGIepUf0fuAulPbm0EVJQ0U0vxqzMKCfQZJ7iMjQ2Va8zDC2xYqyjBAS2Rf4WVuLwVQjJCL9xPOkN73GNz40oChz3cYruJ1d1VGa+scDTpDHlVZyxMu+Olg/D9xGeU2JuvQOTGf1FKCjQ8y9UMjPTjr/fqIgZAOyYmJrJdw52dX+BG8HRbsOplyB7JlbUuVs69PqbChgAc0TKo39EGSZMyUjQZKVCC7B9zqnU/IrWWAc2fQSBi0qMnSldVKOZDL8AcZGVxmMqPvMstFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBmPtFytHWpQ1KAS1EkwlIjnuZqO4IAwmi2BtjbdDRU=;
 b=c7uxLUJTqxp+yO8TH5i8uaqgS/l7DsV5fn4qROFGOB5ICdJoBftfWU9krIdbtmmzlcjce85U0EPo0xOCivVayPEXfJxVO4V8+Mcv1dCf7snAIYhsaACCWxnhLzCOTlAYDakOZtwqshc4kZk0hrbXanciW5T/RdbK2N2tAEiOUQMMp71SYGep7ubaMcATXH9guzms958LZ2naWsximcMqS51aYnfkWkdLBDAWc9qc5Gw+zDybo4ooRjp6ugw6YbgFqAqVgwPSEeQmIwC9luwTYavBeP5qOQwt6xK4uEnkrQ+/922wE/BwXbMpZrwkXra/zvz7KsV8rm0A/WdpC40E2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBmPtFytHWpQ1KAS1EkwlIjnuZqO4IAwmi2BtjbdDRU=;
 b=DuCj6ZzCDvWns8YmkrxquCSILApIfiDQrNJ/rAc57vHk9RFPnlDAz/3mAaB2Bmh1BKK2C0Axv0PSrKF6KZVS+ZUNKvdAcMNXAZa0i4DHtJMBQzThySY3Qyi+2fqlcOHxpUlAeOb335uvY7QWOU88LG7ZR9Cq/np7D6teMC1yUdIB9Y/mNxRiNgO5ZdN0jvxwaU9+r5QzhK4yMRiath/0wtZTbrK0NGBhiCdMPfV9CfcYD6BKToqh42OkOFObqS4GUU7sNlEeedjWu9Pn1p3kIDTbTsCcxG39L+9/NYw1o/BtQKgXdx4VQK29E9lkcd+p9A/a7vpBs4AdP7Ad9aeCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI0PR10MB8335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:238::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:34:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 14:34:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] ci: disable tmpfiles clean timer
Date: Thu,  6 Nov 2025 15:34:32 +0100
Message-ID: <20251106143432.1185102-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI0PR10MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 70128d61-75e7-40b3-5b12-08de1d419cee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oceQV19DYWJ8Sj8MUuj2ytDq0LUyWlNFpdlHINm6AXkHCQKPMnTPv1ZktNa/?=
 =?us-ascii?Q?aKpsr4FdGd8TFFxpDu6TtajoeGeI06KVoU+nSBQJyo2bi91PCMJQLMgN/lw3?=
 =?us-ascii?Q?F6NR6ZXKYpEisHsCH/qhXpYcYm4Bbp4PN5EO5fzS3WUEBT4AaNyDgsPcQ4pi?=
 =?us-ascii?Q?FZFhfZ8z3C/S+bO7W+JIkX8HZLNpHPwaZafWxYhUHHxpDAWbMvYqlrtwDd6a?=
 =?us-ascii?Q?Un0zDVEzpkvZsgbsf+zgvEXUn1PAOvtAY0gvI94q9Alwvft70fV+wkNHKXQF?=
 =?us-ascii?Q?ygHQUiERabbl/SgXlx8gknMG8cHxNygYJ8FGnI9Qv+v0glWL8capKPRDmoXl?=
 =?us-ascii?Q?kRqIBCMfPCBib/WfQIVZrwr8CSKs2edxdbrCd3i1a+TQRW2bhagKGQH2Inuk?=
 =?us-ascii?Q?q28UPaeHPpMSiJkYUNcC0aTVHj8SIxRHKFT+dxrZFpLrfgOrWgt9Vi9jnmNO?=
 =?us-ascii?Q?k39I61GswEpvuojeD07M6JZsSV+wC0NYAnKFC58cvmdQvmQnSimt1/4+EVVm?=
 =?us-ascii?Q?SfIaajgZOm0agyi5tJbu13VdMWXDCHHfIiayU8NtVThy+M5pDt2+gJ9BY96Q?=
 =?us-ascii?Q?hxVr1OX65LCtqHv5ROkam+s29TbjP6RZe48zCt8r6MtdXgo8b1x8AXNfAF4Z?=
 =?us-ascii?Q?k4JEQR78lbINtQ2BUL7/aPPLn4W0NCBw4wRQSe76Ju2epOYwZf/bP/o/rI+W?=
 =?us-ascii?Q?4vLCuhHMSAq/yjOeOFmPOgCmL8fuissgfoZRL4VUORO5yY5gkJrJdrDQoezU?=
 =?us-ascii?Q?1OQfAVbubLwH2vyDvZYI9Zixj5Lm9/zm/insI+nxM7wefNa11TMRDutmTPOb?=
 =?us-ascii?Q?hCbmaLAb2Vca90z2RGNcwGA+0H0sgOJ7UK+4vF+Q7MQyKWjVYOAmqifcwOnH?=
 =?us-ascii?Q?pGmeo75WiwZbSTOr9YLi9jKz/xXruRSJo5LeXe5Y2gxZJWjyaDeBgfGIFDZw?=
 =?us-ascii?Q?pd6Ib8fvWsMm8V2PAiv46VYxkHN6HgFqG0x5nKTuB9sB8IcdDQJ5PUfBG0OO?=
 =?us-ascii?Q?qNqFHwUAKMmQkxYB3ljprSL7SG1Vgd+Dly3nx85vSmt6kBo83kXzcLt7FmgG?=
 =?us-ascii?Q?jR9BUH876zq0hEvDI2kjLSucL6aoograf7vLE5i8QkuyXBN0F9stzSqCTQVk?=
 =?us-ascii?Q?/DFvcaY7N/WD5MEqj0aYEjS9AoCXOwA3WDfVm3m8uud5eOTge4Rmqq159mKK?=
 =?us-ascii?Q?31y63Tn/8XHWsyfr8knzidMGyyqOrjQ36W8tCmUFaNCqgmSJ6HbhsmDwQ4IS?=
 =?us-ascii?Q?c/R8s545GC3IBogxQFZjgYfhn+XEB50t/69Qhta9H2DqbVv14htBMrAjpTnS?=
 =?us-ascii?Q?XL8nBJZCWtvJUdkZ9zBuDbx5oeIF5VekCy/Js7qXLqFuHR/AiLprqzNQFW5e?=
 =?us-ascii?Q?wS0fYzi+125/EYGu3SeTxtWieDMsOkb8zGdZPreb7bRjsaNM7pmY8lcq86Hq?=
 =?us-ascii?Q?yPcaOgTGut/H1DI2EX7g3u0+tC+MVI9t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?949h+crLtHgHYzLZY0h5S5qeckDk4S0I5rHQPrxJvN60Hl6PJLLJ/VZJQi5F?=
 =?us-ascii?Q?+zmxAv9HtNtFxYNCc1LBfbiyOFMF9Bc9Jto3Sc0RgNzSf9N9mhmw2zRWuqOW?=
 =?us-ascii?Q?NeaBXzbv8Oe2QI0xt6PCSeQVFz8hN42Sw+q1p5/82XpxwmtKF634HEGOlM9P?=
 =?us-ascii?Q?k2zvSAMsLExOslmFLHN9D+fszKwIvpRAA/uitaHtEpMqE9fxmnp5mBmkqq3l?=
 =?us-ascii?Q?hmx20y5jv4ZfzvM3dr7pCpACNl3BFe2KYsfhH5QSi5b7yLOXWky3iptZMYUQ?=
 =?us-ascii?Q?OOMj8DrV6zFsAkqOVkE6roQ0ETHHQcxOg0peWUXJy8OV7pcFD7wqYHSuSQ8B?=
 =?us-ascii?Q?weznOpSpHVNPZ25pB8990/j47wIJisEdSTiF2NlnZ0KZPXhMPNIpmUmJhwuv?=
 =?us-ascii?Q?ei1w6rQJbjocms+WepUTxlEsCkqH9t0Zn5nGNhiB2sdOCrN+0HIS8lV+7mTE?=
 =?us-ascii?Q?QRGtNZwguBBDYVEmMV/+Hq+sGzQkDdVANhNlVh6UneM0gF7ntzAXSGiqHm6e?=
 =?us-ascii?Q?yHcVnxAIrK9GQJyu0INYYIkZGqzVXpbIlUBrMmdCHtymynY+UXCxa6qyG+wl?=
 =?us-ascii?Q?6ez2Vaaw1pcr0ojQ2iuYJ41AT/peue8Tt4w8/Ae/+tLE72fzK9uMzPepITvR?=
 =?us-ascii?Q?ABCtdjG8K33q1KvjDAwv4WAEu0ouTRQCMq4yRkudryuOxCvGPeQrkepMLXoh?=
 =?us-ascii?Q?/cfIE+5p3EqsyuxFBDjznQbN7O0vh3StW9Zdv/8jYC5JQ2y9Va1FviebJhwh?=
 =?us-ascii?Q?scn5ZUZ33VTJcPsHJcfuEb13OOmNzf332kCSgdXkA6lCAK92jWwqh43B9g1v?=
 =?us-ascii?Q?0fU2wvQwR2UkrP8Vn5p0CRYY9dKpvsH4VXXdxp/+rEMRMetzfQFz61WWyTpF?=
 =?us-ascii?Q?ZKXoBGWdVVkqGSPEoY07t9TfFJF7AdRLjD7/0FPYm2P2AZfU5SWzNmdmRoX4?=
 =?us-ascii?Q?yOY6Aw8XDfGTaun91jGNnPWZFMBznPnZYXT6GjFBai57OcJeZM1BSRHOu/n3?=
 =?us-ascii?Q?/THdp5bJeqX/n4Wul5N7PAQXoI+U/Abj/IhFjzfaWVnyfZRSEzaQ2263z85F?=
 =?us-ascii?Q?iVLQJnvO/wTHIW1+A5SwmiA1UPAiZPHzO1hfm5iWDAeLr3r1X7EKI201g4cT?=
 =?us-ascii?Q?QZ3uUmTGXhzsObkTYj+U8NGKx05ZxbUS9Jnav0AgGECMMHk8LmgY1qJp5dH0?=
 =?us-ascii?Q?ULregCJaRd9uJjW/Fy7SGgdaT7r/xOYoieOESCQkt5NHr0+C63qf84awiTgP?=
 =?us-ascii?Q?2N2YreTAodbiaZeO3F/S3vuw3LJIWPW3vAmK9J6PFfv5FBikTeLAA4nNAOYR?=
 =?us-ascii?Q?wVkMZg5ImJv/StoP7BGoW2l/rzXRVI+bWSH/vRwj/M/5iJmr2FqaTQCS156b?=
 =?us-ascii?Q?TwBS2ltjYUTyajF6/UXtGVt8/5amWKuh6kriF8kuYBwQb4joGS8ACbgG77aZ?=
 =?us-ascii?Q?z8k61LAyE6z374h26bCXswY7bUl97pTjmfpL6wtrD80Gdc5ZZvVd+EN9e86E?=
 =?us-ascii?Q?Vchx6aJHBaUJrFJx0zPZ99E1sCcBek1aFKsmINXa65ESiu24r7BQV2BN5GRS?=
 =?us-ascii?Q?atvZYbvM1oX2yUVNBzwSSmmjmNVOYVkQIw5NZjTiTN7DHhFlzJB7AJ820MlQ?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70128d61-75e7-40b3-5b12-08de1d419cee
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:34:37.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1odDZ4KOfIJUCUiXSWIrUuafU8aU2wiQ4VCEqLGRbuVG2mKyF9OjOim0R1AhKx5xTBb6tnyvs7nMSSlxxhsakqj/XNmL8THeMKq3ygQqm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8335

The systemd tmpfiles clean timer may remove runtime data generated by
xeno-tests during longterm CI runs, leading to failed tests.

This issue can occur due to a timestamp gap caused by late NTP
synchronization after system startup, which makes the service consider
recently created data as outdated.

As we can not wait for the NTP synchronization to finish because this is
undeterministic we will mask the timer in ci builds for now.

Moving file locations away from /tmp should be considered when
introducing non-root users tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-core/customizations-ci/files/postinst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-core/customizations-ci/files/postinst b/recipes-core/customizations-ci/files/postinst
index f89d9e9..9cd0c49 100644
--- a/recipes-core/customizations-ci/files/postinst
+++ b/recipes-core/customizations-ci/files/postinst
@@ -11,3 +11,6 @@
 #
 
 echo "bind 'set enable-bracketed-paste off'" >> /etc/bash.bashrc
+
+# Disable the tmpfiles clean timer to not interfere with xeno-tests runtime data
+/usr/bin/systemctl mask systemd-tmpfiles-clean.timer
-- 
2.43.0


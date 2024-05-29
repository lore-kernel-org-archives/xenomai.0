Received: from mta186.mta2.hdems.com (mta186.mta2.hdems.com [35.78.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFFDDC3
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=35.78.62.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965783; cv=fail; b=Gnfg7Zt2P4WvKi8Iz5P2CZPIdySDwcVynRxa8JdyBt6KLtPsrKK63NEHY7/Dytn+vtYqbIgTWdqalXoE/tBQAB8wjLe011MjwRISFXvlIT8FeZqhNI6CDhIbte74zKtOPHZSx5aVU0rwt8CNGOu5QUTCkPaoiMvktLDbg05XRH0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965783; c=relaxed/simple;
	bh=7NSwueXFf5xhUFWoTa+xakLFVaaLeD97pgJhGC8to5Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DxlKBPHrel6PubRguXrSMR7BMz9uQGyiZH47ysWCJeYU2weoLz7f2w3DUo7UUvtjPL96C4EbsyqwaasqRm45OO217/JSK5JYAWawp6PugYmWaxUZksWHp4/JFn21ukYw0Omh34Jvw95nO4aX+iYG+b0P/5ODPVOYgiv2ETS8GuE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sodick.co.jp; spf=pass smtp.mailfrom=sodick.co.jp; dkim=pass (2048-bit key) header.d=sodick.co.jp header.i=@sodick.co.jp header.b=EUXnY7uI; dkim=pass (1024-bit key) header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com header.b=LZPgjVig; arc=fail smtp.client-ip=35.78.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sodick.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sodick.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sodick.co.jp header.i=@sodick.co.jp header.b="EUXnY7uI";
	dkim=pass (1024-bit key) header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com header.b="LZPgjVig"
Received: from mo.hdems.com (ip-10-5-85-157.ap-northeast-1.compute.internal [10.5.85.157])
	by mta186.mta2.hdems.com ('HDEMS') with ESMTPSA id 4Vq0Kn5ygnz40gC
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 06:46:53 +0000 (UTC)
ARC-Authentication-Results: i=2; mta.hdems.com;
 arc=pass;
 spf=pass reason="matched ip" smtp.helo=JPN01-OS0-obe.outbound.protection.outlook.com smtp.mailfrom=ruman-ahmed@sodick.co.jp;
 dkim=pass reason="Signature is valid" header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=mta.hdems.com;
 s=arc-20230313; h=Date:From:To:Subject:Message-ID:DKIM-Signature;
 bh=7NSwueXFf5xhUFWoTa+xakLFVaaLeD97pgJhGC8to5Y=;
 b=BZ7+2LJKKrY7u35XHRsrbe34psWInc/xCHdbpv25WiUym8TrmjH7soRgq+wODYENhwVMVKIZygkf
 nKtQW9ABM9v5uLzXWNY5A+toPfAn8FGfuwD74WjeVy2sPh5ZFM2H47hLHs8MxVbkclXFh2q7n8Zhy
 hUkUfnQ2nK92b8aeXQcvgVOiDAHqNeZb3eUlsImfmJ4VjXZuax9EPEPphyUE2b1nJLSzGlsrRmSCR
 64rOq3w0Gw10r+IbsjZVZV3r5AhuPjg86bzZXbcUhmkZndWs8kkTKYhcYhgvi9yvplhFySNnqwD3t
 CcKzxYma4hxRnxFxQZ4zDHobgRIDAqnouaA==
ARC-Seal: i=2; a=rsa-sha256; d=mta.hdems.com; s=arc-20230313; cv=pass;
 b=2AX7Vwk49oRLqm81VgjCjMw81bwDK5IzXliMPeL5Otgx4DuNNpI9bTCCedI0hkwRciuF3t7Q5FFK
 AQ4O0iQEg+KGVen40WjD11XxDQrYvH5RpFndaNf4fBgOlMkzIfpFttPlkR5zDshG1DVvITB/Xqk0F
 7frhrSo1srdyhPirI3ZvmcRBAUfkjza72+UpSe0lfLD70uwaoKRXHDv4p3Xs95CFF5bVgzzC/ZJjs
 6bU00Z9zLXg8nPLKayfF+SMPTMIEJzBFD0NFXsBisilqRpENw0CIiJGbPvVVLRljS4X0EMFE/zuU0
 fsQ/61DZTHCK3bxiUARdFb9u/kVjhzrdkUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sodick.co.jp;
	s=HENNG20240201; t=1716965213; h=Subject:Message-Id:Date:From;
	bh=7NSwueXFf5xhUFWoTa+xakLFVaaLeD97pgJhGC8to5Y=;
	b=EUXnY7uIsuu7usgq1RXWh0VUsgvoUNoQ2lG/h1y7y2aaailHNJWBINY26bapfvP2HgNolwCgf3
	 mqVNozfb9QLDM4rYotKe128MwKGGAvvKukcjR2h4eQvsdVyA6n8FrQG7ehwQIG6t6NOGKbrBzvWP
	 vWn3xk7+ctuerSm2/s4W0V1r26bxumROFn9eSwGma1K7puHR55G/n8lvB/xK4t1/U7ZWVziXRD36
	 4lBnu+E7E1E9grMH73JmIFHTxMDErJEh5mk848ZJtDUCkt8mV/oQBmmq98ctUnE1ELA+PZS9K21f
	 ao7G9wdeFpCU/Wimymso2CCCCXWGv/cImq2g7Z/A==
X-HDEMS-MO-TENANT: sodick.co.jp
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2104.outbound.protection.outlook.com. [104.47.23.104])
	by gwsmtp.prod.mo.hdems.com with ESMTPS id gwsmtpd-trans-d94fe730-2851-4453-ad23-09bd6d1cc051
	for <xenomai@lists.linux.dev>;
	Wed, 29 May 2024 06:46:21 +0000
X-HED-ARC-Validation-Result: pass
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQMQcpk8mIuk6xT22CHWbsDXJcEcChVTEJJjftWWhDhLvc2V9JbT/iZ2oVAbkUBzASfZZ87pJLqXDVekKAIr2o4jCDTYQFMHyFpXKP6kderRCv6zRmAubkPdrUDm4Zyfj5cvK14mzxueLTkRDS0FzvExyefoRNalGE0Nz8z9vqBMaDu62B2o1Lad8kRZH1Amen4qrtAOMLD7T44iFVKyJ/VhHeqUyN14XnWACHqybgWR9a4SSeq1+XUhzBsBuNpeeoAHiLt7lDviCU5Q/9Xg0iQ36Saj39uQNoIbti9Vq6Mdm6R5T+Es+Qmfhu4H9JnlwvAzhkRJrdCKxY7GHfkFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NSwueXFf5xhUFWoTa+xakLFVaaLeD97pgJhGC8to5Y=;
 b=QMEJAURghJT15UbGCG1pjpWyxYfUSr1HdZAKFLxb9H6QibEI0NguHYC63ZsFT+RdYxV6XE+qNcp+/H+WooEhbxUgfO0ht3cRAlgDFKz4IZokrvBZSxiBRENiex0LYG7SFFyL1k+Gy9Sg/eLt9KJ5plokK//d37qXiL3kVp6dAuHgn+mwgEToTDGz+HY6NhoAwwG/84jd1iOWGjOIS2U3eVLcmf7hU+e78q9sDyEpqtg0AAx3caGMpMzTO2I4e6RmPHt4Za28zBQIzbTpQ/Z0KKGp9XiZRKQskVLwxJRE298IBNq06S9zHqu6GNoI/3VgeCyy8wntxF/AbnXbEbySvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sodick.co.jp; dmarc=pass action=none header.from=sodick.co.jp;
 dkim=pass header.d=sodick.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sodickjp.onmicrosoft.com; s=selector2-sodickjp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NSwueXFf5xhUFWoTa+xakLFVaaLeD97pgJhGC8to5Y=;
 b=LZPgjVigcoAK4h9L3rbz7hrktV7X7PWZNmnJxSKO1zRdSbltBIi3rfeKakPfk5lamyhkZnD8lTu+kNhAndavSbJ8W6u9cgXWKprmp1Fg0tcr8BzsegRSR9aoP7pS+KjUJ+MGonrDOC8K6Cfc2o9FEfWB9ilkLut7scS9dIO3Q7I=
Received: from TY3PR01MB10966.jpnprd01.prod.outlook.com (2603:1096:400:3b6::9)
 by TYWPR01MB9525.jpnprd01.prod.outlook.com (2603:1096:400:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:46:18 +0000
Received: from TY3PR01MB10966.jpnprd01.prod.outlook.com
 ([fe80::3d84:2efe:89c5:5452]) by TY3PR01MB10966.jpnprd01.prod.outlook.com
 ([fe80::3d84:2efe:89c5:5452%5]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 06:46:18 +0000
From: =?iso-2022-jp?B?GyRCJWslXiVzISElIiVPJWElSRsoQg==?=
	<ruman-ahmed@sodick.co.jp>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Request for Patch Files for Intel I219-LM Support on RTnet
Thread-Topic: Request for Patch Files for Intel I219-LM Support on RTnet
Thread-Index: AQHasZPA3ReVdXDsLE65NUPyQI9Dew==
Date: Wed, 29 May 2024 06:46:18 +0000
Message-ID:
 <TY3PR01MB109665162DCBA2BF61647F87ED8F22@TY3PR01MB10966.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sodick.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10966:EE_|TYWPR01MB9525:EE_
x-ms-office365-filtering-correlation-id: 4dc7d2d5-59dc-483c-6925-08dc7fab0b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eTl3K3N2dFc3RWpLUFJMbjFEMUpiTVBCY2lTWTNxT0VNQ0pyOXNXZWhp?=
 =?iso-2022-jp?B?RjJYRHNmcTZtOU9xSDhDOEFQWStoYmdqRHlZT1JQRUpZbGpEQXlxTkRZ?=
 =?iso-2022-jp?B?TTM3UzNmbUh1RktmS2NFVkZGMjYzOUo2L2JJQmppMWd2NXNCSWN1Wk1E?=
 =?iso-2022-jp?B?R3F5TG9EcVF5SlFKalNwM0FrVW5YczJpSHhPcU1uZzFuREtEZk0zdGpO?=
 =?iso-2022-jp?B?VExiZmZ1S01oUGJHMk9ybWxFTFVLYVZhY3NlOVkxSjBKdytIT2F5dXg4?=
 =?iso-2022-jp?B?UTJPYjNHNEdQdGczdFdONlRoU2ppT04weko5VE1iUGZ2TU03bFFTUXBq?=
 =?iso-2022-jp?B?d041ZDFnRmpIb2Q4MmVxbFQzbXdrOVpSTHdvT1pGa2hvMWhJZTR2ck9W?=
 =?iso-2022-jp?B?QTk0SUVwYVJqYzZadWhZdEE4TW82LzlQK1VPN2p5Nm5jSkYrWmh2VkhC?=
 =?iso-2022-jp?B?bTBJTnJMdW14Rlh5ek4zRitQdnY2cXRGbnc4UW1xTVRwQllNQjYxNkgv?=
 =?iso-2022-jp?B?aHh5Snh5NGF0QzBoeWljNU1VYXptTW9Wckgrdlo5eCtDNEVKMG93VW5s?=
 =?iso-2022-jp?B?NlRTbzNvTm81OE04SDY0MnM3LzNEQ20xM1FZeXErU2Q3QWFERG1lYysz?=
 =?iso-2022-jp?B?M0hmQm9JUkhNV09TL0dLcWZBVWNQSjNpY0ZraDVFd0kxTVpnSVRyeDI1?=
 =?iso-2022-jp?B?OWg4dFVZSW9hRDlGWWZ5ODdNZVdLSHZFS09TTUVaRE5SemZYODBnNFpM?=
 =?iso-2022-jp?B?NEJ0UHlubFV6MFFzaFhKZjNHcjZGaEpHUlYvTTRXeFRLL1djV3hnckpK?=
 =?iso-2022-jp?B?NDY0enI1dEp0djY5WHViMVUvRXJwRkRTeXJRZnlMVDA4b0RYbURBcmJz?=
 =?iso-2022-jp?B?clh5U2I5RFBuQ2wzdXV6cmlEdkF5RHRKUWk0QWR1cGpZZTBqZDlXd0tm?=
 =?iso-2022-jp?B?dm1oM0lIbFkraDNZTFM0RmZzTTlrQ25LK0lmSkZRcERMSE9kTG9wLzFu?=
 =?iso-2022-jp?B?bUx2NlV5VVFDUWRzVFZueGh4NHNCYXVVT3MvcVpqOTByU3RhT0tXdjN5?=
 =?iso-2022-jp?B?bUZIekg5Qk1ORkNSVHAwU3J1b1NrNXRLRXZWN0tlcmQ2UDJ2K01pajFW?=
 =?iso-2022-jp?B?OFEyVmRTKytYRjFaZUl0TnRFZlY2cVBwQ1RHN3NhMFdTK2tTM3drWmJs?=
 =?iso-2022-jp?B?NDdQOUNKSitlQlRkZnJGcUM0b3VTZnJBMkRMYXZhMUhxSncrZ3J6eWg0?=
 =?iso-2022-jp?B?T2pVZDRhOTZYQTVDSzN3SWg1bTBsQVVxRFBrZk9SNld0eXRvcE1RNnUw?=
 =?iso-2022-jp?B?NE4zcGc5M0lnWmdOeXlUM2wrNUJyT2tIdUJmSlBSdTcxVVUraHN3aDJ4?=
 =?iso-2022-jp?B?YTI0cTZEM0dhNFpoMm10WjdJa2szcFVNa2Y4THhFdHJmVndrVVhUZkZX?=
 =?iso-2022-jp?B?bnQraUFBdjQxdDJFWXM4aERNazMveVZBT1FNaVo5WkY5MU9idC96TE1k?=
 =?iso-2022-jp?B?OGJHTFBLRUpCR0xMWHltNXRsRzE0Sy9Od1ZDZnl2cElQTkVjYklHOVNx?=
 =?iso-2022-jp?B?VXpNU1llRXRwVnZkYWNrN1ZGN3FISUZqeDVpQ3hYYmU1RTVZSUl1WnVt?=
 =?iso-2022-jp?B?WlZRREVYY1h0VWZ4OURhMEE2RFdtTGdBeTZRK1FJc3hNdGFVWDhmZlVt?=
 =?iso-2022-jp?B?TUxRU2pxTXdpeWJDZlB5OXAzeENCVjRMcjRDZWxrM0thQmQ5Zmp6Y0Nr?=
 =?iso-2022-jp?B?a3gxQmNrN1pkRFo2c2RYUFdaK0pXaktsNEZGMHhJemUwTFVySVhReG5N?=
 =?iso-2022-jp?B?dmhjVHdXRzVtdmNKRFR5WFdDeTQwZHl5Tm01MnRsWGprM1ZPMFB5Nkk4?=
 =?iso-2022-jp?B?aWhZdzNDQzRjeGZDM3JQNjlmdkZYUFpPa1BSai9EL3RnMkVGT3ZZRDFZ?=
 =?iso-2022-jp?B?VmNVSFVNbktOdEliMUNBaWk4WFl3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10966.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RlJMYVh4R1UyV3NiZzlGb1V4bGpqbzhvOEZkVlRaRVRVTmF1dXRrd2h4?=
 =?iso-2022-jp?B?WmwxN0paUU1HaENRTGhSUDJhOGVDWU5wc0pBMFIxLyt5RkVGQS9tOWhX?=
 =?iso-2022-jp?B?VVErUlIwT0hTS2g2Y2gvNlcxVVZya2Q2Y1dPR1hFVlZ3Y09PYk5KSnhW?=
 =?iso-2022-jp?B?RWs5RHJNZkRGaytmL2VaVFoyVE9oZzAwL3RZNGJCQmd5amQwWW1RZ0Vj?=
 =?iso-2022-jp?B?Uzk1OTFNeDBsRzdvWFB2aHZmNnJQaU5XM05oV1R6eVRFZUZKSFh3SEs1?=
 =?iso-2022-jp?B?OStsVWNBSnNKMzJXU0FpeDVyWWpzcFBjWXRsMG9pUUhyd3NRR2k3Z050?=
 =?iso-2022-jp?B?MHowOWdPTSsvMG1mVFF1VVFDUUlrTmN2cVc2bnZxWDJhNURoR25iREJ1?=
 =?iso-2022-jp?B?QURyN3JEWjRNeEx2UkZzVGhpWDcxMGJtRDlLYW92ZkJORE84K2JPM0RF?=
 =?iso-2022-jp?B?cnJQYTJxb0VtR1hGVDZUOWduNUpUc0ttVTNYSFpkZEI5dlkybERmdWJI?=
 =?iso-2022-jp?B?Skh6WjhGRXVGWnl1SmxsVW9FTXJSTDVEWStrM0lsM1gwNFRzdjhYYXA0?=
 =?iso-2022-jp?B?ckl6T2srWUFUNzNwT3lKYlVYU21VZXkrKzNKMlZhSEVHb2R3dE9MSUdx?=
 =?iso-2022-jp?B?ejFOSUZycTJlSGR0T0lKL3BvaE1nK2RLZUJOQ3cvTlVQTHNEdnB3Rm9v?=
 =?iso-2022-jp?B?OWF1SWwwQ2lVTmF4NXpZUTJVQkw0ZjZiREp2anUwQzhPNEt3cnlNeGt2?=
 =?iso-2022-jp?B?cDF2QnNUZzlVNUxJS1B6NDZiR0Zmd2xlWWZ3TiszTjZiTnFUU0JERHUy?=
 =?iso-2022-jp?B?OXQvSmtkMXVkRit2WFh0OWpZbmNMVGJWbWJYQ0hPdTN4Ym5tUjVhaDdE?=
 =?iso-2022-jp?B?T29TVmluVWUwMWZZSnlmNklXMzBveDZtcFZwR0UxcmxWWU5yVTZXQXN0?=
 =?iso-2022-jp?B?NEtFYWFxNmg5dDVnbHJJVGtTNTQ3bFdPU3VHZEVWd0o3OXJUd3BoVUM1?=
 =?iso-2022-jp?B?SHNVRDBWVE1LaWJZc0UrSUkwWnA3eVNOVzZIN3VEZW5kb2pmQmRYS1Na?=
 =?iso-2022-jp?B?NHlraWFNb0VqVGRZM1F3Vk9uelBvSHh6aVdDOEh0aWFGbi96RjQ2Z1dG?=
 =?iso-2022-jp?B?RnA3Y1hsMXUwTFVhOFdGd1VycXhEdzdvTU9HSHROV3NiMG00aUVUWUJR?=
 =?iso-2022-jp?B?c0Z2NU1GdHU0amZnbVEwazRxYkZKYnJnbUJOY0c5bHhLR1ZIeG9lZUZV?=
 =?iso-2022-jp?B?UWVlMDhuaHRjbk9ndTB1ZGNyMTJRNkFPTTg2MXZOYm5WTUJySGxLSE5P?=
 =?iso-2022-jp?B?OWVTRUZzRTIvY0tGZUFJSVNVbWZwR29hQmV1dncvelhHS25RbFVseXZI?=
 =?iso-2022-jp?B?RVJhaTdaVCtEaVpaOXBCZDQyNXJ0VitXdnhiWENWMlNRWklaeFRwQlFw?=
 =?iso-2022-jp?B?RVp1RTBKNGlqU0hyU0VOWER0dUxGSlJveDh5VzI2LytQMGxwSTZ1YkhX?=
 =?iso-2022-jp?B?ZkFzb1lCb01hQWhMY0QrdlIwaVZheWNkV0NkZnJCVVQzWHNGTmxrZHA4?=
 =?iso-2022-jp?B?NmFEejFWS1FyRnVkc0VEQWVtT1Z1S2wzOVZGVlZ3blIramhnTWFOS0JJ?=
 =?iso-2022-jp?B?a0ZCeDRXeTVKcnVjM05MSmtjOFd1WVpRN0Y4MGlNR011NWxITjFnYktZ?=
 =?iso-2022-jp?B?MXlGWnVQclR2a212NERIanNXWTh2L1R1OS9qMlE1dkp4Y0VXYUhYZmda?=
 =?iso-2022-jp?B?K25HUkhEcUZBcm1mQUM1YkZFcElSOVpnZWVFamdpQkdWTncvM3NleVhz?=
 =?iso-2022-jp?B?UnBVN0FqRnBsSTJDMUhRcTcxcm9TQ01KWkZTbVNicVhiRlI0bG5mN091?=
 =?iso-2022-jp?B?Y1ZuWER4Wi9OU2lJMy9SKy9BZU1MZ1FMcyt6WHhzUWloTC9mTmJKVnZJ?=
 =?iso-2022-jp?B?L1YwUWZ4c2RtODJCdERZWk9MVVpmKzFBc3lROUh4MG5oODNVK2VYRGIx?=
 =?iso-2022-jp?B?WEF0MFBzYzJxYnBsVmlyRDQxZ1VHcnlHVTlkbHBlc2NQMzhsK0pEMWVO?=
 =?iso-2022-jp?B?Z0U3OXVJMHg3d2ZFS1E1VHgxMXdKNUJ6WXUvY25jZHU0bWQrQjhESkF2?=
 =?iso-2022-jp?B?c1JUeVJZNFlXOXdvYkdQUnBKbTVnTjZPVXFsaHFPZTd3cWhQd1ZOUjF5?=
 =?iso-2022-jp?B?K0Q3ejBualhGZnZFeG9tcWJ3eXJCQVh5OTZVZVU5Sktkbk9aUUo1a3NX?=
 =?iso-2022-jp?B?WElycXk0NWRJRGY4UHVtZzhyRVR6cUpSc2tvQzNqNmNtTEZEbUVGTGQz?=
 =?iso-2022-jp?B?cWFIVg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fUN48SOqL5yJHv6HC0fQfvoyrMICA5eqbk+i6b3ssxbjOk8Gts651FmdhulJ+SmoSRjiNxqKXUd0PMkhmfdJLbuCe+PQRf5nYaMLRLJnd+gb0MjxjGk+nt/xMHmJlwdP9qGrVFugA7nYAn6cYjpQEabw/3PBwvmUVJjiGKVt7Mds7qdIX7zn8/2Hayg9EcX6UNOMGYHWKb/eH2gu/b9wQbBbrD+LXG7C7/rOS1kml1sAqaHTtdlnbH3jTmFLaK/lLmSB4Y0p3xWsW4Qdg2otZZgxzEr7AWnQIh1dg5GqDWjhWsEEbxECIgAtWofOb6BBCSfniTg66bHsaPsBanIagxieaaT4aL/jwQD/NdTn5vuEmVxmnrT0O0zQPrcc2+s7mwdHogjdS4tUvMIFuj11PVmbpDPzbVJz7XHLGgB09NteQ8CxyWbVMs6LwXX11po6aWRkrnFhp3w9P0VSUUN1SXJ8h/ix7701DbFJoWk0XgMF+p0iScIfedIyTJqgaGcFCQj4ZaC0ayLaJfwcdsO0ZdfjpR/RmPmFaZOtSS1JHVxRV6jQD+ivRXdpuKN6lnMxkfq3vj7RJN7IBR8SYzAyCSUXXFqv80AgBavIj3SfVw2lvHNQpwXu+4msSBOTY3lghjd8C3cqL8vBoPdu2GDW3H2Uz6I1YCWuXvZLotCvT7zMTGgGQHR0hPdpj2QHwruLBCpaVwdLHu67I3KBlX8KdA==
X-OriginatorOrg: sodick.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10966.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc7d2d5-59dc-483c-6925-08dc7fab0b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 06:46:18.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8e5116d4-d5fe-4e04-acf6-0f71a8c9ab1c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLVHLLc0s1mYzVOpQrw5ow0/PCsV2nKhvgbmoUf9LoDtR1ypAXQzpRYVhnJq+DXgkNebG9FDqzVNygyAzvRKkNnV78dN79n25UFa2GdKXIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9525

Hello Xenomai Community,=0A=
=0A=
I hope this message finds you well.=0A=
=0A=
I am currently working on a project involving real-time networking on a Lin=
ux system and I require support for the Intel I219-LM network interface. I =
am using the following setup:=0A=
=0A=
#Kernel Version: linux-dovetail-v5.10.y-dovetail=0A=
#Operating System: Ubuntu 20.04=0A=
#Network Interface: Intel I219-LM=0A=
#Xenomai Version: Cobalt 3.2.1 =0A=
=0A=
I came across a thread on the Xenomai mailing list which mentions patches t=
hat could add support for my network interface. The specific patches are re=
ferenced in the following link: =0A=
https://lore.kernel.org/xenomai/1cda53e1-323a-add9-0a21-d6b843fb21c5@siemen=
s.com/T/#t=0A=
=0A=
However, the URLs for the patches are no longer accessible:=0A=
=0A=
0001-rtnet-Providing-rtnetdev_alloc_rtskb_ip_align.patch=0A=
0001-rtnet-Porting-e1000e-from-mainline-4.19.57.patch=0A=
=0A=
Could you please direct me to an alternative source where I can obtain them=
 if any?=0A=
=0A=
Thank you.=0A=
=0A=
Best regards,=0A=
Ruman Ahmed=0A=
Email: ruman-ahmed@sodick.co.jp=0A=
TEL: 045-947-0740=0A=
Sodick Co. Ltd | Global Development Center=0A=
3-12-1 Nakamachidai, Tsuzuki-ku, Yokohama, Kanagawa=0A=
URL: https://www.sodick.co.jp=

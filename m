Received: from mta185.mta2.hdems.com (mta185.mta2.hdems.com [35.78.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B5382
	for <xenomai@lists.linux.dev>; Mon,  3 Jun 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=35.78.62.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373781; cv=fail; b=Zeb+laKGBofPmEHB6eE+tZsIYR/ravonePC7oMclHM2T92XBmQLMHlUfc+qqUk9IJQR38WhbpWEr7k9ptOVhk+bj2IXRuKOsZDPh5pE2W+r2gI9GZLifalcVxV9zNXtEeLi+smHGzt0yOAIFOwMBgaf0j2fGrXpSP4lpN5kFER8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373781; c=relaxed/simple;
	bh=7Oj++V5V0mUllnlGJkiLFE4uARxAk8daJwvi+ARzRYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxGUTGvY/DI740ZbWSFmTE4dB1XNjscBpC4Fl6iU1qVgk4y++//87GgSOtsR4gA91EhK+3b1mvFSWrrjYiiQgYcroUephyUbdkWvPCp65gr6pb9mGnEBY1M5KZ6Iy0kvM06ugByoWULLlh67sGPP44qaaJLsxvkEl2rrWuDxwsc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sodick.co.jp; spf=pass smtp.mailfrom=sodick.co.jp; dkim=pass (2048-bit key) header.d=sodick.co.jp header.i=@sodick.co.jp header.b=Xbz+h0yh; dkim=pass (1024-bit key) header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com header.b=CJjPI0rK; arc=fail smtp.client-ip=35.78.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sodick.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sodick.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sodick.co.jp header.i=@sodick.co.jp header.b="Xbz+h0yh";
	dkim=pass (1024-bit key) header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com header.b="CJjPI0rK"
Received: from mo.hdems.com (ip-10-5-21-90.ap-northeast-1.compute.internal [10.5.21.90])
	by mta185.mta2.hdems.com ('HDEMS') with ESMTPSA id 4VsvGz0Y5lz40gf
	for <xenomai@lists.linux.dev>; Mon,  3 Jun 2024 00:09:31 +0000 (UTC)
ARC-Authentication-Results: i=2; mta.hdems.com;
 arc=pass;
 spf=pass reason="matched ip" smtp.helo=TYVP286CU001.outbound.protection.outlook.com smtp.mailfrom=ruman-ahmed@sodick.co.jp;
 dkim=pass reason="Signature is valid" header.d=sodickjp.onmicrosoft.com header.i=@sodickjp.onmicrosoft.com
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=mta.hdems.com;
 s=arc-20230313; h=Date:From:To:Subject:Message-ID:DKIM-Signature;
 bh=7Oj++V5V0mUllnlGJkiLFE4uARxAk8daJwvi+ARzRYg=;
 b=uuZrg8ztSnBqxviZ/FG3LzAC/MBpdzOSM/LeG7rO81FaR3jDumHaQk5f8uC3q9S1gv/KHw1X2S2k
 +5A4amljB37VRneil2TpkuYeobNyNQhFcBRhwEPvozZUp7yuYMRnVxJie015rLlg+q8rRpx3/ihDR
 YvSw7/OY/CbObhtQDuCS2yCzrb3GiZFRbVXdnnJ6iLOBSbECbi3IO3VxfazIj38pZxbTmuWdqAUml
 91u9SdawyisAn4mccqfHuFVJ8Fuls8G3Bc3IcbdeHRuQVFDt4MrWvrNHkuMlnZEMD+G5pb3hgbk6C
 FzHbLC2T17T/MnJbbGoWFke1wKpRypYhWeg==
ARC-Seal: i=2; a=rsa-sha256; d=mta.hdems.com; s=arc-20230313; cv=pass;
 b=ee/PzseYXRxMEI1x0V7hepk3k2WdHs+eGRUTcAU7Iapbx1JMWdSiKoY/55ziChWG4k4aa1l7wutA
 +vZooNdO4SdHe6Ow8PSno8DlS+gD8QJjvI+QoCD4wWLYmtYj+zmm0CXFWWILub5SslmC+hyjCS5IU
 gTqnImd+ak5cKbPJA8NQ36tV+sSOOLA2wCcP/UPf8G76xjZ9FnnuALS2RptyadDZ018UGovLDNzHJ
 8GeRrAaE3UQNOwKoq4z/HfJxVXv1NRDey9muEcwlh2sv1EYfRviuROgcwAgoXA9i0WNVAy9MTzhuh
 ZQy/9ybsZwDw3QUf5ta56ZDHyZzMORaYlAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sodick.co.jp;
	s=HENNG20240201; t=1717373371; h=Subject:Message-Id:Date:From;
	bh=7Oj++V5V0mUllnlGJkiLFE4uARxAk8daJwvi+ARzRYg=;
	b=Xbz+h0yhH0Ef0gT7B1/StJw16A8hjKOE+odHvaV1s+7aTKpRAXtPXSELKhemQpO152V8FNfWfS
	 3SR/G6w9ObWPH74iplDnnAp+sMUdVzThDIUJfhgusRdIMlTijnoIRKuC4AIeoQ/ORPLoQymlp3hp
	 tEtWt2u1EDFQGwOTlAPxF9aT+7e/2PmEev8kglYFmM71Ehmo2E/ym2pgzi0x+ja0+dQPpFmsWaZX
	 EHP8gRUMHVF1/vnY0WcdBoD3RIfCmPPXtRRS4KVVmfMUbDfJV1f7JVy4SAN0yskXDirlvWA9GJXP
	 v8JU1UEspzsZvakn6wr7sKhi2ao3OUbBuiu1zvYQ==
X-HDEMS-MO-TENANT: sodick.co.jp
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com. [40.93.73.0])
	by gwsmtp.prod.mo.hdems.com with ESMTPS id gwsmtpd-trans-c9981e8a-1873-4023-bedc-d13608d4ea2e
	for <xenomai@lists.linux.dev>;
	Mon, 03 Jun 2024 00:09:17 +0000
X-HED-ARC-Validation-Result: pass
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd6pI0oU/GCWmc2XFr+Ddq2PUP7x6W3JbRbDKu/Q7bkS+ZbHeveTv12nm6lQ6VKIOkzbc1u5bZOPUoqfiE88PJQm7nzjfSYVPZ7VXxpRWQceJg9iFPMCaKCyZ8JRODbHrymN5TmcnZQ0Vuj8aaaVnayJ2CE8rgNakXJ/5NuePmTtSUbxm9+ESwrj2t7oCe2h1x6K6waTda8d6IGZdn/ZlEmp1fLGBeFcI7USpk3wkpnbedxda+/UXIGHAKpGbR3c6VvYvtzsFANdyIMPLslSEHH/Zm6J+r3uZNRhmM32UWAAzEIFzjLNaS9HwFbbfJHH3cxa6M7GuRuESMZSLHTS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Oj++V5V0mUllnlGJkiLFE4uARxAk8daJwvi+ARzRYg=;
 b=lPAFe3gSnFKf0hwyTj/M/+Is0URqjWEFUvFxZxbVL40bV9iL0IsRUt2R3A9mB9D22LvBFcmwGMU5sv2z3yMAJjwfUbnIww7sbA+3fMXHJYP7Gi+ipoMyneo9QIixOHooKt5c7X34f1NV7BDruPVEEOE9K4r+qxLE1YP5YNSG3RE2GBlgqcqXwq6czHjFWL37Q4cBtSGMm2fO2C3VPIjbBCH+nrG4doae9qI5Dm4qqaEKvGe1XCofStJyR6WtnMGmlalr86IJEoLxdGdW/nN2r+co5LSqLN4u+FvCyzstMOmqUvHBND9z4jpsOERMXyxLlKcUO5g7BIXPPxRpwh9bVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sodick.co.jp; dmarc=pass action=none header.from=sodick.co.jp;
 dkim=pass header.d=sodick.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sodickjp.onmicrosoft.com; s=selector2-sodickjp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Oj++V5V0mUllnlGJkiLFE4uARxAk8daJwvi+ARzRYg=;
 b=CJjPI0rKFZi+O2NTvFgD9rEBaQ/Cuoq6+sWOlqwp4m4xR07Ma4virlxttgrAaBM4FYp/KUbwpvDr1yfsfkChVITmc71HJ3+HA190xPJjCYvjcOfrxmIFIrJQMnV3EpqaIlYCC3VqS9N2drYO+ku81W2vrJltaYtNOnDJuf27R+M=
Received: from TY3PR01MB10966.jpnprd01.prod.outlook.com (2603:1096:400:3b6::9)
 by TYBPR01MB5423.jpnprd01.prod.outlook.com (2603:1096:404:802f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 00:09:16 +0000
Received: from TY3PR01MB10966.jpnprd01.prod.outlook.com
 ([fe80::3d84:2efe:89c5:5452]) by TY3PR01MB10966.jpnprd01.prod.outlook.com
 ([fe80::3d84:2efe:89c5:5452%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 00:09:16 +0000
From: =?utf-8?B?44Or44Oe44Oz44CA44Ki44OP44Oh44OJ?= <ruman-ahmed@sodick.co.jp>
To: Gino Strobbe <gino.21.strobbe@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Request for Patch Files for Intel I219-LM Support on RTnet
Thread-Topic: Request for Patch Files for Intel I219-LM Support on RTnet
Thread-Index: AQHasZPA3ReVdXDsLE65NUPyQI9De7Gy0b0AgAJaKdKAAAUwVg==
Date: Mon, 3 Jun 2024 00:09:16 +0000
Message-ID:
 <TY3PR01MB109662F0AD38B6EAA5E7FCDC4D8FF2@TY3PR01MB10966.jpnprd01.prod.outlook.com>
References:
 <TY3PR01MB109665162DCBA2BF61647F87ED8F22@TY3PR01MB10966.jpnprd01.prod.outlook.com>
 <CAFCNAPBUT9W_X=Y_Hm4uOzE_3ZHK=C2M4oD4KwHA0TmAAH5xSQ@mail.gmail.com>
 <TY3PR01MB10966CEDCC2D63CE7BF673387D8FE2@TY3PR01MB10966.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB10966CEDCC2D63CE7BF673387D8FE2@TY3PR01MB10966.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sodick.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10966:EE_|TYBPR01MB5423:EE_
x-ms-office365-filtering-correlation-id: 6ee34dc0-4a6a-4622-19ff-08dc8361682c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDNKK0xNRlRDQkJnUXh1YkhHOGdqbWpmT0tVbmxGKzBTOVgxYjZHZ3BPemJn?=
 =?utf-8?B?WnJYdnA4aWxTblM1RjhNYUZXeWtsWS9LWUVYZjNvU0d0RFhWWVpjcmlvdjBn?=
 =?utf-8?B?SjVxRWRBa1hFa3Y3SWl5ci9TaCtZQVNnZVBNVXl3YlVzdTgwaEoyeSs2a3FZ?=
 =?utf-8?B?WDYzWlBDV1lKa1p1SVM3a2duU296SzB2WEdJaVhhUDdXaFRDeGFlZlRoL1dh?=
 =?utf-8?B?ZllUbExUTGl2M1lvZUxudXo3VVJXVHhMcFg1ZmFxUm52TlRpVzdyZjBZdHNG?=
 =?utf-8?B?TDllQ05ZbWpuTmgyNlRsMFdWRWw1ZWtkV0RmQWEyb0pkTlMvVk5aRlFrRkd0?=
 =?utf-8?B?Tnk5NFRiZHpyOHl1MjFjSEpUYkJycnB5VFFkT3B2bVU5V3VvMFdVMzM0bklW?=
 =?utf-8?B?M3VzTHNUNEtIQmxXMEx5VnNxTitFUmtwVGJ4dlpGMjZPNUtOVE1ERTBEbzZh?=
 =?utf-8?B?OWRrdkNoWlg0N2JhWXVqOFNFRXpPd21EQkJBMnpSMS9aa2RyQmp0VTFPemRL?=
 =?utf-8?B?Y2gwa0dxclVSMjBiSk5FRlcrMVEvbzRoYjVGOWF4WDRiNHRVZ0JCRDAxSWY3?=
 =?utf-8?B?ZGZqQWFZSGt4aUlzMlVSeUtkbTgrUGYvdGw0enhTdGV2bmxEK3RrOHdjaGRn?=
 =?utf-8?B?WTY5OWFLK3dSVHJzVjNPTXBLdk00aWtJS0M4ZlpJaVVOTmdEUDZWYXUzRG1L?=
 =?utf-8?B?eGNmeFJsTW1scUVlT1llZWRSaVdUY29RODFkeC9FKzNyYnlQUDMxU3JIRjhX?=
 =?utf-8?B?SUc4b0VCbjYwZ0dnRGlyY0M3eExPeldUY1JFbDUvVlZ2NjF6TWdqL3JucTFW?=
 =?utf-8?B?WEZUZGZ4RWJ1djI2Si82U3RKZlRmTHJaeXpYV0tHaWlFWHNzaTNqeFlxSEJT?=
 =?utf-8?B?bGtSV2thdVVKb1oyM3l4UGtqSjNYQW00T2UrS3VzWFpRVXhMTWNQS1UvOFdG?=
 =?utf-8?B?SW5BK1ZzUmVNWTY4YXVTbkZLdHp3d3VCTm1ab2hUZThJdm05M0FtOFgrWlpQ?=
 =?utf-8?B?NG5PR2JxUnlQd21rNmd0OU9ybnhlSWM2MURVMllDR25jb0Zrek9ndS9XVEUz?=
 =?utf-8?B?SDhYL0RyWFFmSjc1amJsNzEyWjBFTW1CZjA0QzV0Rk51WFBMTmt6NGdzYWZn?=
 =?utf-8?B?Z3ZXNS9yOG1oaEZXNjA5ZWlCcTl3ZFVuMytiZDZpTGxUTFNVT0hQOUo4cWVr?=
 =?utf-8?B?N1N5WXdDNlZ4cjExSndNcXd0d2t3eHdYVFMxSFZ4Q1F6TjBRampYd0ViRXBx?=
 =?utf-8?B?UHBjV3hUeW4wRDB1V2pDRXRBNk53SnJWaEdiQkRMUmpvSzZSRXA5elNMd3JQ?=
 =?utf-8?B?OWV0Y2JQS2JwOTJ2aWtZelg1dlZLOTBNRmtYWnVKTXZXYkN1RjVHbXB0RXZY?=
 =?utf-8?B?ZGVYUWJJQVFqOTgxakhUNXl6OENUcFlkMzFxVjN4YUxYS3lLelRleDJjNW5S?=
 =?utf-8?B?QlJVZ2U2MHlnSGZXTDFQaVpuNFZkU0VHeXE4cVBwRFhsVXZSTDRJTUo0aUtR?=
 =?utf-8?B?SnJQMktQYUZUK2xmQmgvazFiYVR3eWVhREx1dFdBeEczT1VNZFBVbG56Q285?=
 =?utf-8?B?Nm5XQ1VwZm9ORFNsckNTZGxNS1pjU0t6OTlTQ21ueEtRaS8xRW5xUlh1akNq?=
 =?utf-8?B?QzNmZWpNb2NpRU5DNURzSG5oT282aVllajBPcE1vTXl5SmRCYWhCWlVyaGww?=
 =?utf-8?B?RmppKzc4ek4wTGhRc095VlIvTkwzL2lFMFg2b0p0eTh4K0RpRVozalgwbFZL?=
 =?utf-8?B?TUdwOGlNTjE4NGxJYkJWcnBSMlhHTzVObElHV1FUQmZwTzYxTjZXUFlDZlB6?=
 =?utf-8?B?ZXFaOEVKVFl6N24xbkQvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10966.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVZDbHdTVzhURHgwZzdJeTd3ZnMzbytzMVorSEtqYTBMVFpsdWEwSFB1MnNQ?=
 =?utf-8?B?bzV4cjYvcHF4czJIaERGOHk4eWpBSjY2LzZVMStiMlNKRmxnUDV0T0t3NU0r?=
 =?utf-8?B?OEQvMUZwdkhaN09CQ1dLWUk4NThZendIQmptbXVYc1d5bTJYemdtQ0JCM1Vl?=
 =?utf-8?B?U0NGdUJlWFdwMlM3YnRtbWt4ZC9wYmNJT2JjM1V0aEs0Rkl1akd2NzM1d281?=
 =?utf-8?B?TTV5WW5TbTBoYjliU1VJRlhZbDdtYXBWcE53V3lETDl4am83TjVCV2ttZWZB?=
 =?utf-8?B?MzNnN3pYc2JKOThEL3pjMTRubmJyQ0dGcWVvc3BLQ2N5ZmZjMjlpVWtvaHlx?=
 =?utf-8?B?NmxJOHJoQzgvRXdrZWtCSXV4S3lvZTNQZDJxc3VZcEI4UElKTnM0YmVSUm1k?=
 =?utf-8?B?ck4rSXdqaWJvU2xacXV4MXNQTXFWQXpYS0dja2ZEd2dCUDNQRWpyM0hSUTZZ?=
 =?utf-8?B?RUZ5WnlGc21ybDRkVnk1TjMxbndIZGc0Wkl0V2g5T2hlelFVLzBWOHo3WlpZ?=
 =?utf-8?B?bm5pQ1hLeUttQzdjVllxTXZ3dEVrNWQ2TXJ0VzU5SzVCNDdVQVRCaWIxYjBl?=
 =?utf-8?B?TnBlcFVZYnNSNWVyTVg2L2pyRHRNckNmZ00yd2NKdnhVU0VBdW01b3JtT3FE?=
 =?utf-8?B?WmdHaS81czZuNGVnQ3YrQlUwV3JaTmdpQ3B4dFp6aFdMWVVPR3diYTljOEpm?=
 =?utf-8?B?anBrVjc0eDMrZUE1NXpJWXBzSW83Q0NMT3pOMTV6NTZuU3prcWtMTG1wOVVu?=
 =?utf-8?B?R1BJMGVDbkx2aU9vR2JZR29hTzdZMlExeGFZUVhRdEtLbm1HNllxOHBwcCtS?=
 =?utf-8?B?c2x3M0wzdXUwTVF6aTBnMFEwdUlVYmxaVlp6RkZEMGdVRytmSS8vRERCYUYr?=
 =?utf-8?B?cEIyYU5vRlRId0FPTnJRYWhRMXBISzB5a2tpZEU5T1N0bnJSbVVHWDF5eXFl?=
 =?utf-8?B?M3JUUDlPcEdwSDBobHVJTzc1dk9UdkFKY3pVVkMyRW9IdXc1TmZFNnN5RXZL?=
 =?utf-8?B?U0lOMm1Fdjl5cDd6bG14Zm5kb1dONjdWYVkwc21oNWxldjNQRVlBaHFBZVcx?=
 =?utf-8?B?bFJSZ2tOWkhLM1JyeWw5Y2ZGNlZ6cmxvN0RVSTY3RC90M1dlSy8wQ3BMVHZY?=
 =?utf-8?B?Y1VHMllzcVAwcE5BY1BKaUZpNEFjUEY5YitMRFlOQWdRaWdUeHZYNFJPOFVJ?=
 =?utf-8?B?NE5vQmRaYVhGMGtuSXovMHNPRzJtdFUrZkJoOUdxQjlWR25KY1FvOHkzdnpH?=
 =?utf-8?B?SVZ6ZWZ5ZVpaTzMwRlZGNmhHOG1wR1g5d0dVR0FFa3hXdGxGclluU25OQVFv?=
 =?utf-8?B?aWxOeE9wUGY0QjR5em9NRzJFcTg3bEJCVEk3WUlXeTcwTG93ejdZemVRYWN4?=
 =?utf-8?B?WHNNSHYyQ1o1S1NmZ0dXdUZabzdPZ0I4V0gzdWtuTXV1alNTSkVvT0xsNW45?=
 =?utf-8?B?bENVWnNHRlR3bGIvSEVwUVh1VGpYUkdIY29TVWtmNzk2eWs3REFlUzVmUEln?=
 =?utf-8?B?aHIxT3VTNHppQ2RNSm1CR0JKcTJlbDhjNzJYSytaSVhQOWpBUTdOK0tORncv?=
 =?utf-8?B?Mk9kaEEzQnlhVkFZNVk0U0V5NGUwckZiRG9GeDl3WC9pNHB1dHRMbEVBYzZp?=
 =?utf-8?B?UDRWeHNndXlGOHJCdVFqSVNYUlF1SUxYQWEvUXFGVnJtMGQyTURvU1VyaXln?=
 =?utf-8?B?dmNwaU9MaXkvb1ZuZjZjanZkMFB1YjQrNE5QZVJPVTVWR2lWejJjR1pkYmNt?=
 =?utf-8?B?dnVTenB5cWZhN01tenJmNlpMUFJOYThQR3J3WmNmOUdGSkFyTTJwRUlIN2Zk?=
 =?utf-8?B?VG96L3FkV1ZlK21QWnFFVEFQTWlaL3BBTHhXdGVBY2xoMnViQzdVVC9DUjJn?=
 =?utf-8?B?enF5QThQT2E1RzdPQWN0YU1SN3FqdmhXblEwMUNITWNUeFRaVHZuZFVmMmhS?=
 =?utf-8?B?TEozcHhUcTRtMW5HREMrdUFScXI4aXN4YXRUMFBueG1kRDRtejVBeTRVWmpL?=
 =?utf-8?B?S09ta2ZhRjNoWWFTSzMzUnIwYzdVcmVCWVdPVEJyZGswUzdvcUlLTHFnY01o?=
 =?utf-8?B?d2RNaFMxYU9zSVNPT0dCYW9WRVNZaHhFbTBvTjZGSVI0VnJ1WlNsekdYUXhu?=
 =?utf-8?Q?rplWmH+RaY9o4O0ldFkXLChwn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3qCDSPtyrHxwIGzsRBmbJkpB70mWq8wzF4AXs2/C+0FcA3UEBux39BtYW/bCwJsJ1vcXqvi/UxYJM09kd2oogbYYNvCztCcUMwicR0SSPwqjaOt+WGkqyCWMtqnieRVGGCkyXl+VfnbukzGxF7zdHr4DurHP5A/RejdbT5qP89k+atuMbC7LO2lxVGAFLLhDuO4ujfNxQ4KXfZMv1ZvK1PbXDORpKIuHDDuVFe3Qa6PRAjvtKyCcXHd3p65WAxLEwvb5Ri69j2uoFzxaOXJ/gYkz7bUzVMLgYCRvPuRT8cxnWhoSXqxKCT/yjqnGUBdCTVPFuWX01rnD7gG1ZEwiHfk914h6UULfE6umlQpJO5SrtL6Gom/Cnbm9qFeTx/xG1vGqod6JFC8+x2b8tMlNPGpjlO3ye50djNqEXrjEHa0xZWgUTMroybr0s12I7CrgPZ/QI74/uhd2dKk8/r+IwklXSN87tItIaqG0t6ZgaXEsRo5RJv+V+wN9Lsk/GrHZaeKaIDj+M/gRXzmPWsqvOr72JC1pRqNVBC08cxjOTRhsJmlcNLg/AybveOrQqPevYiFne8v2EAWxCerWiPepX5K85SiKpcqNZ+FOcdAIMh4PtN5k9loOaPaJGsmIYfkj2rl5bHmQsn6SQShncvPc9cHDhoCQHe9txleVpjZhmI1qHzykXR+ouNWDYoxkNDRaoDnClq1Sg4XkMOaY3F9kjw==
X-OriginatorOrg: sodick.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10966.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee34dc0-4a6a-4622-19ff-08dc8361682c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 00:09:16.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8e5116d4-d5fe-4e04-acf6-0f71a8c9ab1c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wm8GONf7lc0znX7/u5MdHhg3eMkku0AsGMWN//o9dWHGONp+s2Z0WqAM7Q5M2ANpCwsffmRe1oPc63hGkFsg4/FPiLFU1G7y+IQOswyImO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5423

SGkgR2lubywNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3Igc2hhcmluZyB0aGUgbGF0ZXN0IHZl
cnNpb24gb2YgdGhvc2UgcGF0Y2hlcy4NCkkgcmVhbGx5IGFwcHJlY2lhdGUgeW91ciBoZWxwLg0K
DQpJIHdpbGwgaW5jb3Jwb3JhdGUgdGhvc2UgcGF0Y2hlcyBvbiBteSBlbnZpcm9ubWVudC4NCg0K
QmVzdCByZWdhcmRzLA0KUnVtYW4gQWhtZWQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KRnJvbTog44Or44Oe44Oz44CA44Ki44OP44Oh44OJIDxydW1hbi1haG1l
ZEBzb2RpY2suY28uanA+DQpTZW50OiBNb25kYXksIEp1bmUgMywgMjAyNCA4OjU5IEFNDQpUbzog
R2lubyBTdHJvYmJlDQpDYzogeGVub21haUBsaXN0cy5saW51eC5kZXYNClN1YmplY3Q6IFJlOiBS
ZXF1ZXN0IGZvciBQYXRjaCBGaWxlcyBmb3IgSW50ZWwgSTIxOS1MTSBTdXBwb3J0IG9uIFJUbmV0
DQoNCkhpIEdpbm8sDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHNoYXJpbmcgdGhlIGxhdGVz
dCB2ZXJzaW9uIG9mIHRob3NlIHBhdGNoZXMuDQpJdCdzIHJlYWxseSBhIGdyZWF0IGhlbHAuDQoN
Ckkgd2lsbCBpbmNvcnBvcmF0ZSB0aG9zZSBwYXRjaGVzIG9uIG15IGVudmlyb25tZW50Lg0KDQpC
ZXN0IHJlZ2FyZHMsDQpSdW1hbiBBaG1lZA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KRnJvbTogR2lubyBTdHJvYmJlIDxnaW5vLjIxLnN0cm9iYmVAZ21haWwuY29tPg0KU2Vu
dDogU2F0dXJkYXksIEp1bmUgMSwgMjAyNCA4OjU0IFBNDQpUbzog44Or44Oe44Oz44CA44Ki44OP
44Oh44OJIDxydW1hbi1haG1lZEBzb2RpY2suY28uanA+DQpDYzogeGVub21haUBsaXN0cy5saW51
eC5kZXYgPHhlbm9tYWlAbGlzdHMubGludXguZGV2Pg0KU3ViamVjdDogUmU6IFJlcXVlc3QgZm9y
IFBhdGNoIEZpbGVzIGZvciBJbnRlbCBJMjE5LUxNIFN1cHBvcnQgb24gUlRuZXQNCg0KSGksDQoN
ClBsZWFzZSBmaW5kIGF0dGFjaGVkIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB0aG9zZSBwYXRjaGVz
Lg0KDQpCYXNlZCB1cG9uDQogIGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS9saW51eC1k
b3ZldGFpbC5naXQNCiAgICBicmFuY2ggcmVtb3Rlcy9vcmlnaW4vdjYuOS1kb3ZldGFpbC1yZWJh
c2UNCiAgICAgIGNvbW1pdCAwYzczMjE4ZGFmMDYyNjg3N2I5OGNlMGQxNTZlOTY4ZDQ4ZDhiM2M4
DQoNCiAgaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpL3hlbm9tYWkuZ2l0Lw0KICAgIGJy
YW5jaCByZW1vdGVzL29yaWdpbi9uZXh0DQogICAgICBjb21taXQgMDA0NTRkNWQxMjdjMjliOTNm
OGMwYmFiZjEzMzZiZmMzNWJlM2I5OA0KDQpCZXN0IHJlZ2FyZHMsDQpHaW5vDQoNCg0KDQpPbiBX
ZWQsIE1heSAyOSwgMjAyNCBhdCA4OjU34oCvQU0g44Or44Oe44Oz44CA44Ki44OP44Oh44OJIDxy
dW1hbi1haG1lZEBzb2RpY2suY28uanA+IHdyb3RlOg0KPg0KPiBIZWxsbyBYZW5vbWFpIENvbW11
bml0eSwNCj4NCj4gSSBob3BlIHRoaXMgbWVzc2FnZSBmaW5kcyB5b3Ugd2VsbC4NCj4NCj4gSSBh
bSBjdXJyZW50bHkgd29ya2luZyBvbiBhIHByb2plY3QgaW52b2x2aW5nIHJlYWwtdGltZSBuZXR3
b3JraW5nIG9uIGEgTGludXggc3lzdGVtIGFuZCBJIHJlcXVpcmUgc3VwcG9ydCBmb3IgdGhlIElu
dGVsIEkyMTktTE0gbmV0d29yayBpbnRlcmZhY2UuIEkgYW0gdXNpbmcgdGhlIGZvbGxvd2luZyBz
ZXR1cDoNCj4NCj4gI0tlcm5lbCBWZXJzaW9uOiBsaW51eC1kb3ZldGFpbC12NS4xMC55LWRvdmV0
YWlsDQo+ICNPcGVyYXRpbmcgU3lzdGVtOiBVYnVudHUgMjAuMDQNCj4gI05ldHdvcmsgSW50ZXJm
YWNlOiBJbnRlbCBJMjE5LUxNDQo+ICNYZW5vbWFpIFZlcnNpb246IENvYmFsdCAzLjIuMQ0KPg0K
PiBJIGNhbWUgYWNyb3NzIGEgdGhyZWFkIG9uIHRoZSBYZW5vbWFpIG1haWxpbmcgbGlzdCB3aGlj
aCBtZW50aW9ucyBwYXRjaGVzIHRoYXQgY291bGQgYWRkIHN1cHBvcnQgZm9yIG15IG5ldHdvcmsg
aW50ZXJmYWNlLiBUaGUgc3BlY2lmaWMgcGF0Y2hlcyBhcmUgcmVmZXJlbmNlZCBpbiB0aGUgZm9s
bG93aW5nIGxpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3hlbm9tYWkvMWNkYTUzZTEt
MzIzYS1hZGQ5LTBhMjEtZDZiODQzZmIyMWM1QHNpZW1lbnMuY29tL1QvI3QNCj4NCj4gSG93ZXZl
ciwgdGhlIFVSTHMgZm9yIHRoZSBwYXRjaGVzIGFyZSBubyBsb25nZXIgYWNjZXNzaWJsZToNCj4N
Cj4gMDAwMS1ydG5ldC1Qcm92aWRpbmctcnRuZXRkZXZfYWxsb2NfcnRza2JfaXBfYWxpZ24ucGF0
Y2gNCj4gMDAwMS1ydG5ldC1Qb3J0aW5nLWUxMDAwZS1mcm9tLW1haW5saW5lLTQuMTkuNTcucGF0
Y2gNCj4NCj4gQ291bGQgeW91IHBsZWFzZSBkaXJlY3QgbWUgdG8gYW4gYWx0ZXJuYXRpdmUgc291
cmNlIHdoZXJlIEkgY2FuIG9idGFpbiB0aGVtIGlmIGFueT8NCj4NCj4gVGhhbmsgeW91Lg0KPg0K
PiBCZXN0IHJlZ2FyZHMsDQo+IFJ1bWFuIEFobWVkDQo+IEVtYWlsOiBydW1hbi1haG1lZEBzb2Rp
Y2suY28uanANCj4gVEVMOiAwNDUtOTQ3LTA3NDANCj4gU29kaWNrIENvLiBMdGQgfCBHbG9iYWwg
RGV2ZWxvcG1lbnQgQ2VudGVyDQo+IDMtMTItMSBOYWthbWFjaGlkYWksIFRzdXp1a2kta3UsIFlv
a29oYW1hLCBLYW5hZ2F3YQ0KPiBVUkw6IGh0dHBzOi8vd3d3LnNvZGljay5jby5qcA0K

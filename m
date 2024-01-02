Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487CFBE5
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wvGnOvll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFW5Q6dRSe2GFrO3fJoxTlNGn58VQcPQfKLfq8sf1eyYae5j5BMudu8jQOj/uYENYQUTDtoLkdjolw3y/l0dBpIAiYHAmeeGmis0Z5cHItMAj+VuRy5OfBFL1Jo+Cms3WgrfhbGfPUlm/ZOaXF4MN99dKOborIud9p/M3DJ+HemkI5sARN5yt47u9bJk4y6iZAHT/HFcMWHCEyMEPU4yFWu5IvGA3YGKOfZHBBuW6r+3KqMApAHGImOa5o2cGuOh00eJW0Jip789VWsmE6Ct/fIeRMedxI/TbAzbWZSOTGXVz+Ny0CzuUVnqZEpF5jYl7lXXtn9Gkctp4As2Yq3uOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKc7P9RGPDgBC4aFsnaIhnFgj83D+3o2lhxvI5/siLk=;
 b=OokvPHgZE4bMBGd1wdjngg0PjoA55KZxmE9/a5XaLVJENubDPX2VHrF2iS2gRDk7S6NLavOHk2uSs0i1zAIPHTsE1hG1KX2WmrawnkPD8T/tsBYYLhBO/t+6XjFDXltlMrryzpI7Ypdm9Rfepumguyb355Lo0YnKLOeNejGb5tw+3G4EQxOOdtJ5+Twc+Q8p/GVivd/8WNwWzr9yz1XCnPiYxdCblxFChXjK0WFUM3GLY5SDk35umq8GYTw2SdvjDmxkIWtUAebrHSrmyJ6scwlgk8+m0qz0uilq8sGv3cvjX/Mk6xT5SUFtLbBEEnvyNagGYLydtkD1vyd0VYGIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKc7P9RGPDgBC4aFsnaIhnFgj83D+3o2lhxvI5/siLk=;
 b=wvGnOvllA9U/wjRmUPtQkPl2wSoivZj9sIhlDTa94T2dOTIC1ZmHdn0g7+0TlKCtDStKH0IjfUbAm+kXgEO1awqgmbc291pQId5eRrLj2b1sWQkDLnmsMcv2Hn1UhSJIdXJLapPL2APGCUubrHdw+FIIaOQbMdJA9NoDGUgmwjnhI6aOlPGaEqPR8RCy9HXzfriovZ6BVRFbYFiA8o8tvBvdvl35th74Q+s5bFbmDSM52u7MIyaduPa7Ul3QffRHqCPdqT/j4qMad9Y6aifqjTlA2e/KpyUxwiYkRakTX99qDCmaI1XPIV2yqarSHORQmUnW2rVzuPAwdsdjTzimMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:01:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:01:21 +0000
Message-ID: <2f68d6bd-a3f2-4602-a72a-9d9ba5ced50c@siemens.com>
Date: Tue, 2 Jan 2024 14:01:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [libevl][PATCH v2] meson: setup-uapi: Take Debian multiarch into
 account
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 56685f54-dfcf-4c2e-4004-08dc0b92eae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	loV597ro/pSnu24Hby/yaxJd+dNmB/JGmNKRcvmijcF9DGILsk6sYjhA0tT4ucZLWab1X26k+kSSzLZ+jO4v4xQ3HNVYi3BFdKqICllw4/qjbcngUALnyoAp5XQd/ROxrDpuTJN/7xj8FVrqjU7wQ8CXYhEW0ASYn5EuqDritW29MgPaou4evH4awAjrveXqbOYeS2mQVVdgkOSlSFMoOi60Sw+G9n+3hmVrZBsW22uw0vvr9G5q7gsNY2RUoxATupxzQbO5Oyxp4D/UNyZrApTkJjk3Oj+vhshEqabxFYSCY2PlMBPw8K0Ile/Uu8lwhQyBfxZ/i38uH9/p/LjTek9lXOXW29l9b90FuZLi1Lc4l/Pu+MlYKFtthohkGouvDrSj+Yr+Rb2nB3HZxfRKR4EO7Vn1Ia7kzB2KpTxk3DIAKNRADdgu7JvoMbfK7YUHaMJHi2t8MkBVVOBfdDWO+aA9J98GKVibdNHiKRupWMaTpBHoFrTZnoMnFVGbd09IQEFsypk+66zEDE75oNeU/C4D0y6sOD+xdC31z7BQVtTV9jCD8Io+EWs3jSqL1mJq/N3mxwYbhX09z/YSXGr0KCxpWhknssYk2aNExOhNES5PFZH+UGSrfguC4eqpfXgbAPidQnsCx8i2f8iSDsnQSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(66476007)(66556008)(66946007)(6512007)(6506007)(6916009)(6486002)(31696002)(86362001)(82960400001)(38100700002)(83380400001)(26005)(2616005)(41300700001)(2906002)(4326008)(478600001)(44832011)(54906003)(316002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1CbmRFbjVKRHFTaHhFbTBraFovMU5PMEQyR0JITEVCblAzNVVnTVI1MmRm?=
 =?utf-8?B?V09NNUErYnJzSnRtL2c3YWZhSWRrZ0dtbTN2aFZKNWlNVEc3N2NHMzJiQmMw?=
 =?utf-8?B?Rnl2R0c1YzFwQWcwVWlhNVNBUllFNHNHSFBzOUoyQnNWOGMwRE03dmJpckFh?=
 =?utf-8?B?OGcyZjZnTEptV0R6WkFvbFE0NHZuL1pwY0U5L2pQUWRQRWRiN200UFVLUmJh?=
 =?utf-8?B?cEtDZ0RncTZpQlJYalY0NXBFakc4d2RVanJFbjlZL2xpSFlPUS9WN0M3dHRZ?=
 =?utf-8?B?d0VSWms3NFBBd3lucGhmWjVVUU50eE9WZzY0N2srVmwveXB5YjlnV3FNa3E3?=
 =?utf-8?B?UlhQN3NyQWpFTHhIVm5DeVlXRWF3aFgxMHN6dmlCazBEbUpySXBTeFI3Qzlp?=
 =?utf-8?B?TnpvekRkUkZqRjBoMGl1UmQxQVpFc2Q0ZW9rRGhrT0RhcXdwbjZJTUMwMmYv?=
 =?utf-8?B?Ri8zejZVZTlvWEdwSVQ0ZzFMbFlwWi91QnhWUmVpY1VIT0V2N3Nna1VoV2NB?=
 =?utf-8?B?YlRVL3F5OTRFSVBlRmNwWmdJaG1JSGFXN0RQbCs1Z3NvK212Qlk3WkhEd0tC?=
 =?utf-8?B?clYwMjZrck1hVTJsYVVpWFpLMnZldnpVZzZXdHIyUHpkOVd1am9wRS9YVWZj?=
 =?utf-8?B?UTFYNFVIc0pQQnhaNkFZOERIZWtOeUNQem9YMk5pVnNvbWRmaXJEa3RwSDkw?=
 =?utf-8?B?UFMwVW4wSHhrWm5Ud1Ntc3pZSWNSM3JzdExZNjVUaURmdkEzdkZuMmpYY1hH?=
 =?utf-8?B?TXdISmZ2MUtkdCtWVE9UOUhibDl3V0E5bzRGbHdmTk0rd1p4Uy9PNEhpcEFH?=
 =?utf-8?B?WTg5My82QXczNGFpT29OL0xaam1YZnV5M3VRVU56K2lPdnd6WTAyamNTY295?=
 =?utf-8?B?b2ZZZTNXOG5HNHdoL1JjMFhKNlI4bENJNjlCVk9TNFRBdlZXMjNacGVLTTlo?=
 =?utf-8?B?ejZrc29ObzdZZlN0cHlYby9BU21xQlhnVUVOaHRLeHZrcXg0TFFGT2xSMUp1?=
 =?utf-8?B?M0pQdWZEUElIV2xXMUt0QWtWREhwUXVJNXNleDZyQWVOZy8wMUh1eU5QMlRV?=
 =?utf-8?B?VS80R0hnQ1hyOVhXRFo5ejhsTEJRZ1ZOejg3VUZvWDMyMTR3YnZUaVhmcnlH?=
 =?utf-8?B?Wm5xZWhRdnl6bTNOSnZuQ3BucS9OT2FNUnEzZ0FHaHdYT0VTRHk4RUcxL3Vr?=
 =?utf-8?B?clAwRk9lSW5xZXRQWkJZVFJQY290Qk9WdTE3akIydVM4Vk56STFiZ3A1ZHFB?=
 =?utf-8?B?UEJQU1lLTFQwNi96WHpCT3JVTU5WMFBGczVTdEloTlJKOGFCWk1xYzhCZVRn?=
 =?utf-8?B?dUVYeVgrZXBtdUViMVp4a2g0Q2VIZlBtSEtiSE9USWVDRk1VSnRLQlVFZ0hr?=
 =?utf-8?B?UlQ5ZEo4ckxMVmd4UEt4aFJmWEFJTk5tTGRzbUdhWXVQVmV6MUdCNFZtcmpV?=
 =?utf-8?B?cGtEQVFpZERiWGg4MHl3K0JJb09BcTVyTHRKV2d2VW84RmU4Y0VpY3VhMnE3?=
 =?utf-8?B?aERvaE02cXlNMzFHUmRUeGVjYVZVZjBKcTNBS3VXTEh5UEhNVEtGOVAyODVn?=
 =?utf-8?B?YVNISkpiVXBCZ1F4dG1IZUE0Vk8vYUxHeDd4Y1UrM3QvNnpVU2hUdEFIaEt3?=
 =?utf-8?B?ZGF0bmNaTmZOK2xDbm1ZUE90MnF4R255RmFsMU9FQ1o3Q0ZvTkpwb1dTQzMy?=
 =?utf-8?B?NzluN1hPUnc3aFE5NWdiclI5T3dTVk44b1ZlNGFET0VoQjJ6R09DM3hscXkw?=
 =?utf-8?B?a3lDVHVYUmVuSzN2RFRSZC9tTEt4TmlPcE83TWg2SHdlMm5Ed1I1RG9jRlFx?=
 =?utf-8?B?V0ZhbDVmQkxRYldKNzFBUUNUT2FqdDhpZm1ZR3d3QityckQ0aWxnaU1qS29h?=
 =?utf-8?B?Ui95YnFNc2hHZWdlU2NnT2U0OEwwaElGUHREOGwvaG9JTTNHKzlCUE9xN1Vn?=
 =?utf-8?B?K1ZLM3hGbmFibnRkTjZvVG5KdW1oT2RCdDdsR3Fic1ZIMFk1SmtwdTBMc2Zt?=
 =?utf-8?B?S0h0L3ZsOXpHMVgwMU1HWk5jY08wRzVrcXZtUVVRV0FSUFlVWSsrN3g1TXhk?=
 =?utf-8?B?WXBVL0tpbXdzMEYrSXdFUURnNlRSOFUxb0IzQU1hZXJMYVI1dE9jRFhZaElB?=
 =?utf-8?B?R1NQY3p3N21Kb1ltMys3a1JCZGRibDVNQ2g2SDRhWVFxbVRYL253WThUaFFS?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56685f54-dfcf-4c2e-4004-08dc0b92eae8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:01:21.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw+UIJuoQxrUJgitftw4OXVz0lntKxqKZzfiTxUTe47hfl9RElx0YSiOCqXOFNevk9uloynRIgjNAd7Du/aqiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4043

From: Jan Kiszka <jan.kiszka@siemens.com>

Check also the Debian multiarch include path for the chosen architecture
so that we can support (self-built) linux-libc-dev packages that contain
the evl headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix typo in DEB_HOST_ARCH spotted by Clara

 meson/setup-uapi.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index f2d0774..633c5ed 100644
--- a/meson/setup-uapi.sh
+++ b/meson/setup-uapi.sh
@@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
     link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
     link_dir $UAPI/include/uapi/asm-generic .
 else
+    DEB_HOST_ARCH=$ARCH
+    if [ "$DEB_HOST_ARCH" = "x86" ]; then
+        DEB_HOST_ARCH=amd64
+    fi
+    DEB_HOST_MULTIARCH=$( \
+        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/dev/null)
     link_dir $UAPI/evl .
-    link_dir $UAPI/asm/evl asm
+    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
+        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
+    else
+        link_dir $UAPI/asm/evl asm
+    fi
     link_dir $UAPI/asm-generic .
 fi
-- 
2.35.3

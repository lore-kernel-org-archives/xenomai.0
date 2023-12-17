Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46145BE4
	for <xenomai@lists.linux.dev>; Sun, 17 Dec 2023 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="d/8Qh3MY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4oSdF3QwS3RS637AsDYqGJpCSJTEDixk0HEQr24PhkGk9YugK0pxr6jN4EZ0I22dg5lOUWlYmDwt3+TUeqfD/U5qM+WI/7VpScST7scOjBlXWP8Qdd22v1VRoCZvUIb2wPW19LkORbV3U0qy5UZrlDhMndK6c81pdmbFaxx2XYLwk7u08AEUzNP7TpAsn8G7/9e/gvdPFfPHeH7HQboXQlYlNBPuVDzFW77nOaoFwJD3BNXfm5cQhp0/jVh6XPKfiozRBXM3Q9OdnCkAaX05AYlFQOou4HKPtQ/2vetLnICaUobgoJgBfzt1DsjCgy38IZrNo4WDDuPp3WF2wlySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELndLo3aFlVpJyp0TvHEAA/5jmJEDc2NM5JCbtvUYnI=;
 b=GHM6xhrnzY01TNMxTTPCmgvlHBklzsKbJQjdz29iUN0w23/wxwpjedOK4vScIev8kTm42qCwPjFXAIWnS1lB5c3bKzTYNi5A+Retcb4b049RGcEfDUH5s2GVAjex6q6hJ96t8Aadmk9cIQhISBoZQs2zvjqrL/3d/8JC7cr3L4/2rHfmhJMWaSAKoP8+YZvFe5R/JJZ5nwv70zHOC2JylnMdK9+Q5iDDSaxAxVX8/5dEe9UD3HoBtY1ILC29zY8h0gLR5iF/8wvrynGVbbD6rLvyQczAxTIMEDpKEkweJqDhqeunOeacP+N6VudFYVHL9RPkxS5aW0WAWpGfWyZZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELndLo3aFlVpJyp0TvHEAA/5jmJEDc2NM5JCbtvUYnI=;
 b=d/8Qh3MYECulQm0Icpuj766QTTjjTVzVS6TmvadqFlXNfO75TUe6FwP7nTlZuBsM08rUovcXlVuyhNuTVB1zJ5JBMuPCiqWc8sPMzNjvJxVrJwQwdsWBIWRpwsTEhK4TaMZc/L75c7ZTNzfmQRtikyfZNCtanULNzh0H3gadRPNqdxvMoyNRtUAq6NE+kdQI2UJPEe1/08sJR+bWJcf6wqE4vp57pr8TG/qUHKsLFojrFO4CXfXOs1BL9sYTDdZaQrdMpjQowYdnCFNRfwDDqFz3CW0NgR+oFENWxaxqMG737+j23fOeXQNml6am0tKbxkrdl9ZGcGk9WD9nbjuPmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 16:24:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 16:24:32 +0000
Message-ID: <d5c7f346-1137-40e2-ab24-958d7bbd339f@siemens.com>
Date: Sun, 17 Dec 2023 17:24:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [libevl][PATCH] meson: setup-uapi: Take Debian multiarch into account
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3617:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ee19ce-b4d2-492b-1048-08dbff1ca6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6lH6dAC5udKD8whOJKbMIvKOgmV4UBvilden7L1BhGifINmKtAX75B1Ux/oBmsLoM35PfQmSS31JiwUgFlS3gfRq1WfLr18WEGu8RThTdUT8B9P2gtPIikbpRQIkk5PNB1UjUk9rPMVn0HkZRp1keg3zIPmn02N4jbeoZi5WorOsnx1/5dKAVILUvJ22PZWmdhCS1yxSI90JcXfL5kU7zfP1r07KelDCq6+eAVEtlxLhnAKxtUzy8LzDsWqJ2aU89EPP0lQ/GVw59G5K5+FXJvIsmHPpK9bEinZxm7e6l9ve4l7t3SgZvAIZAD/ZNIaxuU9lMrvpRv7b9Q8yBHRkJIL+uLp2gc/vZEjQ0eGZywkiNLOCMOVgM6ZdgmBVwlNmgbz/k9E3gg9dcmUNrujd5zX8xuGw46UjG+0qY4AJbjQhpl9k8g0QRnC+pOAJAkE3aBgIr1mVg0p2bPocXjaS/tg1GmaCX7u79GJ+J0caJ8WSScmtl7uWl0XxhxcUyCmEWHXw4njs79nxhg8oNKtFabb0xGRMiO4nDEbCKpi1QI9lZOnvbj4fe3lwatOohFgPm88Cu8/kKCUW9ZgRvNg6R/cGekTWTQLhiQSGLHKUeAMWW/75Ndt7ch8ZVnEQNFttI3T+ooDHNki0ux3kRFuyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(107886003)(83380400001)(2616005)(26005)(38100700002)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(478600001)(6486002)(66946007)(6506007)(6512007)(54906003)(66476007)(66556008)(316002)(6916009)(36756003)(31696002)(86362001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXQ0NEtUT0h4STBPSHNtbnRzM3NGeVM5TlVsWFVPNm8vSlVqa0lLMWpsS3FZ?=
 =?utf-8?B?OFZBTnhZZndQR1VFWmw3S2taT1J3a2lsZjNSL21jQm5TRlBGajRRTlF5aktq?=
 =?utf-8?B?N1dPVkNaKzRwMWVaUyswS01hVW5kcU9GTVJ1bGlNUDZUbXdOOERJSzBnTDhU?=
 =?utf-8?B?MUpTUkZPU1dLK0lZbVNsLzFGbWZuUUNtRzc4UkNETEhnaFhYRU44T1pqaTZE?=
 =?utf-8?B?QVIrZS9QWis1djk3UEdHSStJRTJwTU11MkU3OGFvM2cyMzBkdHE1QzhVTTZI?=
 =?utf-8?B?d3pscHlXaEpXMVA4NVVYakhIV3U5MHpqSTkzVjNLREoxQVBBZEVWZmQyOC9l?=
 =?utf-8?B?eDVOTDUyZHl5RVZCYmVUVzlDVHNGenI2andFWCtUYVJSeXZrOUdnc2lTTEdE?=
 =?utf-8?B?YjI2eERmbmZCU1EwVnlZd1dYMlpGbVFsc054UGxYQWdpWTlnUUltYlMwWDM3?=
 =?utf-8?B?czlCdDlGY0Z4cUdmQkV0VE9NVlNQWFU1S1RKZlBKTGRWVUI1RUdKbzQveDE0?=
 =?utf-8?B?dmZOWEE4NDNHOFIreUM3TW1JQVl3ZXBpKzg1VG9UUDFPR3QyWDdTRWp1SlBw?=
 =?utf-8?B?aWs0aXkwZDlhTEVrT2phWi8va1ZIZCtlTk1JTzY5YUJlQm52emtYS01yd2Jl?=
 =?utf-8?B?QXFuYzkzRnNyYU5SMkhFeFFIRXZVNXB0S1B6NDhZYmxZVkdQRWdZWEpPU3M3?=
 =?utf-8?B?SzFtUlo4Q3kzV3FHMEtXejI4ZmVWNHRiY3N2M1o1S3g5bGs0SFBPM0loNHNw?=
 =?utf-8?B?STBEeXBhUUZsS0RsVjlEa3Ruc1NkUnhZYllRN1o3SzlzY3g0MzgwM0Vjei81?=
 =?utf-8?B?RXZHOUFjWGxlR0lPSlJDakhTdDYyU05XNFVJU1M2SDY2NVJ1NUpiZU45b0ph?=
 =?utf-8?B?Q3lvNytERE4yTER1cys1UW5zYW9OR1BWVzlJZkdnTHUrMEpya0orZDNrdnRH?=
 =?utf-8?B?R21SK3VmR2F4NktKWEtrTG13cnNydG80RTdlZG02dXR3WDVSaGQ5WXcrMUJU?=
 =?utf-8?B?WS9qSHg5d2twNXdPeUloWWpFcmZZR2M0dWIvenkrdmNTcmNrL25hYkRLS1Za?=
 =?utf-8?B?c1RTbHBZWG15SW5TNXp1OWdEcm1FS0c0b2FWOVM1aFhmZmthNzRRUUVicmY2?=
 =?utf-8?B?VnljZnJ3dWszdzRZOGVyQ3BuTlNRRGV0aXFrYkZ5SXBZOWppZFk4RVVWSFl2?=
 =?utf-8?B?Sm40N0k4M0NGZ000KzlIK2E3b1dyUngzUEF4REkrSTNHNWgyenJGS2hCbUVm?=
 =?utf-8?B?YUpYQUlBSEwvUmlLeVVvaHRmc2hDOUl0ZEF3dHR5UCs1VG1sYTB2SEFZcDdC?=
 =?utf-8?B?cHpNYnNGbzd2SVlhY3gzUlUrclBLWXJpSDUvcHNDaGE5M3lTa2lrQlBjQkxY?=
 =?utf-8?B?T2xsSWxaSkRsY1ZVdVBXemwrU2xuUkxtdndGV1MzVTZackFFbDNFMDdkMmZF?=
 =?utf-8?B?RGJDc2luamc0TmJweEI3NjM2Z3M0SEZveUsrZmtmenN3UFFsUGxZUGIvUDZl?=
 =?utf-8?B?dDZkRlM3MWFwT3RHekJlWlNVMUdlNlNMWE5tOWprMlFSYkkyTGM4UGl4dVZC?=
 =?utf-8?B?UnZLaHllVjMzbFhPOEJRUVFlOUlnUlVOOHg2WXJSMEpNUlgyMTh6QmtkOStJ?=
 =?utf-8?B?U2crV2RUK0twYjNzZmdsNlhPNUxtZHdFV0NtekNCeEJUTUpsZkp3YW5QQVpm?=
 =?utf-8?B?YkExZCtreDhEYzh2dGdaU2RudGdyNDRXR1lkMzFjS1NZdjdmdytxMTNYS0s0?=
 =?utf-8?B?bzk4b05vVEhmajNpUkZydS9hNFdQVUR1ZnFsd09MRzg5UE1KQ05ZSmVBd01Z?=
 =?utf-8?B?ampPMFdPUmsyOHB5N3Nsc3ZqVnc0dGsxZXpuWlI3WkY3TVlHUnlLNGVxZTFl?=
 =?utf-8?B?Ny90d2M1dmVWOEtMY1JGZ3AvVm1WVmNHWmpwVXF6VnQ1YzgyYnYxYVloYW1Y?=
 =?utf-8?B?andDMzBYUEs3R3puYTI2NXdsMW8xT0ZNREppSSsvRlBXdHhCR0F3VHhDL2Uw?=
 =?utf-8?B?R0M0Kyt3b2c3c0NWK3pPL3IrWDZoam4wTHc0b2FDTitMWWN4VmJ6dkUwZlFz?=
 =?utf-8?B?SzNwME1oaGgyWVVqSTl5SzUxV2J1L2ozZnZhc1llWVFkUURMREZjYjRiMlhK?=
 =?utf-8?B?dDZudVNRVXBXZGtQOExySHZnUWYzdDVJVzNLL200N2ozakZ6K1pDYmVTTW5o?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ee19ce-b4d2-492b-1048-08dbff1ca6c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 16:24:32.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kmE4LuJVmy4G8BjU+X6IS7x/k1zRbVEPKwHZ5Iqu9bDBONenoVdDAIcnnqvjgA43dsTnQzrIl/htG+CV0IdQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3617

From: Jan Kiszka <jan.kiszka@siemens.com>

Check also the Debian multiarch include path for the chosen architecture
so that we can support (self-built) linux-libc-dev packages that contain
the evl headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 meson/setup-uapi.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index f2d0774..c939254 100644
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
+        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEV_HOST_ARCH 2>/dev/null)
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

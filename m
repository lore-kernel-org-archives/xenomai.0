Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156391FAC2D
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068806; cv=fail; b=C6B1Sg9tTyrfpzYJhiUgRkwkUJN6t8kSFT7G1LQo10bei1/zSrt6A5n7Rb5umAHpXl0qkZsM6pAAG0x+Jh440RdPpSn3b5zVKVmw99ukSrie9iGfjlG71fdsDbaBCckbXzKMCYwvrjdkqSUAuNnbu6YaOeq0x7PBk1jBMAeI26s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068806; c=relaxed/simple;
	bh=hIQDcMdscZpUZ8mlSfjTQOY21sWiiOxrO8Sw+GBGtKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnxLMEf1q/uD8IxyjF7J0tvj8+xkqOJ/1LgfrOZB78cCF+6/XBpHz1ACvutam77SCKFKlMwXHBmIell0uNobXq+wxZjhQ99KbRB857oub2xBksbuOLG8F4KjvUzKCi33oPXMxBu9gobBFwaXV434rNks/jqO3L8NygRlzRy0cRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Er5Q1ftw; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Er5Q1ftw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Jso6oZSQNoH9XqZvql8VIkaJ1YdMKKpmz7mOodsrYXhcEP3HfN9u4Y+AxKF4UHjavEwh9aJZAHc/T2VF5pxaZxU7Lp5jDxvnwLHcFdBoheEKZbpGqYMOS+HNbDwKyvulwg5Rzj5d38VORz34FhcduqEKP8dSGsW+S2Rn0G6h8N18SDp292upvmuFD2A18NhV97nF5UhmuD23wOL9+XPcedZ5/08eSbBWAn2i42N2LTSv+BmKm5lLAjszzM+2ake2Phlec+kKjMFaBDbuMvhg/nSXtxrMWQd6+F0bqe3TqJA+IZBCKyHif6xvnmz9uE9diYduiGYPn5/vqaglBQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTIg11pkyGX62HkJ5rrrMvYeY8zKMv6mgarLC3F+WLI=;
 b=o/uggwxVOzd+L+Pn7vVKwIy0KwoYsqoT27zTnK67zy+fDxERdAUPhKmZ6M1ZrZo4JDrD1W455F+OjyLk+jt7gXOb//Cnzlq7YrvbgnRLi8nwKlVEXOzKrD+HXsJ+/v19yEHOD1WCvUMZ0HfwWgJOzu8p8m6FKTIn9HrPFmFLmyFW7mJgQDN7XuWK2F/rgMpRwIWqSDCs3fc8sKcSL4N4aDB1Ci9lacDClPnGy7e63u1tgfLke+fi3ZdKV4Eg8ZxLLcFTLUc9fyG9SVpQ9HIObSdG7k1azj1PukaWyw+RjJVWQUpWI2GZ/pbtJWDkksirnFoJU3YU+x/lUYAK/KiUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTIg11pkyGX62HkJ5rrrMvYeY8zKMv6mgarLC3F+WLI=;
 b=Er5Q1ftwOZTRl2nvqBg9hyYaFgiyO3axZu6b0VZ5bFe7hBvDSet7U6UtsCa5q+PjaKtesIegfdqMBDU/KDkDqHDXtKTaZgLz8iySWOk+v6nHCWEoIObgYp/t7U+zh4CnNm3oSeKBXbqon/WJRCJCeRJiMKhqXbKwYXbiVLQOkGIQGyxnKJhVqFVsZgFZd/uIQo9hvjrIu0SX7xEcV2xv5bCQcp9h4QPztwbVhSZ9ESk8I5rRGXO+uVULaLoO7Pjni3b3vO6eVhb/pCgcVT11A1jR04KwdP//vkYiaHCSCkLmMSxBV8VHvJb1nnnso6Pegz6uZqCNWZFaDNumt26aAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GVXPR10MB8343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 19:06:37 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 19:06:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 1/3] dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
Date: Fri,  4 Oct 2024 21:06:31 +0200
Message-ID: <20241004190633.1814057-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GVXPR10MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: bb93ae83-7d15-42e0-8b18-08dce4a7abdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grOa8HDyDmUWixew47tm0Y7TmEIfD+OgpKzO24HKVyMeUuDo2huA9SS9n/AD?=
 =?us-ascii?Q?zuH5e+60X5OzV2WRLaRkw05bjSQXwtt0r3oRBEYKZPlTvghACIyyqcdJiRYe?=
 =?us-ascii?Q?4f+zXF0pMLNaZJ12gfyZ95KMKlPePUDixsL9NVKwmIiPIKR2FcNH6PJgK01y?=
 =?us-ascii?Q?vcuM+ma6858hjQccRQuibgnfAjplx13zDEbVGqaw+o1e03u/6WcQMpPPXPYu?=
 =?us-ascii?Q?rdy1fDeiuBq3qDju5cDyEhOR6FJTyAor9rz8zISNeTK3apETDYVORAWYctDK?=
 =?us-ascii?Q?PyW8oV/tdhPu+XO8U3C7YHZSre+GMigKi2O2p4UMBf5BwN6f+cTf+MvBOojk?=
 =?us-ascii?Q?ikyKpd+EQ9mZWf1Tj6sAbMYzbSqts5xxRuE2GTJJYdk5+yKlbFnzJHl0KPtD?=
 =?us-ascii?Q?sjJYgBO4cX06qvziCWC/Ck8v+/SY7OPIQdofZfGxFpHD7975/9y+uIGDtpIZ?=
 =?us-ascii?Q?LZs+uy3lJBOjFWROh655BEsdfGlEvygZjDgEV2i5tpC7kWoddOPrMGDNZhZE?=
 =?us-ascii?Q?2EhpE9t4ku0hfVuCZLRlfvAPMlpequUkbOlAH0E/iOBaJN6pJiemusrL3BR4?=
 =?us-ascii?Q?V8vgaKAdD2MLhQZk666vOHXFY23KmdDwZssCcRzF8ceL9weM5au7pk0G/xlm?=
 =?us-ascii?Q?5+I0hJpjA7yowmlK3YvfAl/xzOFCSDQopZsOzf01134/6cZn91ypZK5JcFmR?=
 =?us-ascii?Q?wiEMYJPWR5XZae++O2T9Z9a+8NqkxPV3uCRVCi+wRAQFgfUkwxPoM8D8bXUi?=
 =?us-ascii?Q?BdFw9tDYVRRb6Fp1UKQttiYjFAqwhp/2/MGrvBQxciyaj3b91KiCQmpbQ6AJ?=
 =?us-ascii?Q?jwilVbTujyJ5mP/k3PQVqwH1A5Ts1y6xFpiEZEzg7sUgeZs0xL2ZW9rxj3ra?=
 =?us-ascii?Q?ZCx5GXzdtDUqtfirTtxG5m8YhP0pICZRfbObByUUbZdTWMicjE8bwT5U7BSX?=
 =?us-ascii?Q?LlqNmov5Ha0DcKNyvetHy9Av4aoBfkiBz/a47/rGs2F5XWScYZy3cHvcEZmP?=
 =?us-ascii?Q?WkOl5Cx4bj+t7wLt02x8GPN26GzFGxQ9NS6acmeGc9DJjL1Q1LE76+BuUdSB?=
 =?us-ascii?Q?xA1smFFYgptr8c16uJSy+3Or7SMRCztJWOuHh0nSXQFm2F7mVp3AvRcyL8c3?=
 =?us-ascii?Q?4bF/9AKxV6zU7EdfkqAiWVg/4y7HIyGv8H/jNKp97k0awaYmMqZd/sc7SEus?=
 =?us-ascii?Q?/J2H03MhdYLonjRMdxLV0SGAICSlMw2thm41KngvKNa6LrMXYOIvjLIjlaW7?=
 =?us-ascii?Q?rbWfJZHzMYVEC3H7wbTDYR7pXtv3HNra4tcntwvdeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aP+0Qwb0rIDd6iiWzcd78K5W3DRSzr6J2FRUnPpGasc/p7RqAkpnJGhnPiBu?=
 =?us-ascii?Q?74KIzhdWNPzxEjBDQit3H8Kaa+cybUZ5JVicRD5SM3dZZlOs4HnE4ZCtnKSy?=
 =?us-ascii?Q?+cU5BNmqbJHD6pRFli0s2vIzevcorh92RYOe3EVfFAbEdr+TTgU04miJZUD0?=
 =?us-ascii?Q?+H0iLYvcNJbjjarErbv7lkCktKX8KDy52BPBI4sip681OWNTNk1pv/fEoe0p?=
 =?us-ascii?Q?sKeWpAOVyhxDZKrlveTAVnuif72emTdAXxrgIRGfRyiGk4jmPDWpaZDNYVDk?=
 =?us-ascii?Q?vHGAKeSoSpAEgWv7KwqqSNW41y6EKmwAIDigMbu5EZBovy8RhjXwEsatfvOT?=
 =?us-ascii?Q?szlL3JnZakmhYNMKJz2bvXcJSOaATa65ySw0ZskMewzXBS8ceEd6d6j20aCC?=
 =?us-ascii?Q?o//F+Pz5ZOopAmrSZN5iEeA/PUof8/OKbIRaRj75ue3Vp4YxBJ71ngr2jhA3?=
 =?us-ascii?Q?J9rWt2hRYeCnRHb3sz6k48lzh/48fKzKcgjzjnHFwzZVcVKZgL6cQCtalZE1?=
 =?us-ascii?Q?O9lebqT7p1t2Ph7hqcA2dybD9PkVspZ8UrDexzrw8KDE2xCtVZvu4ow0pe5H?=
 =?us-ascii?Q?U/wFmJ17ReKQKyu+dJRTkEwnS1p+uujailUedJQRSbQs2E+gZjXa3MTkEivj?=
 =?us-ascii?Q?EVrQTo1CUcMZtO8vcft3VaXXB9sPSNMslXEAz5hCyie5gAnnK9uf8epPwSbC?=
 =?us-ascii?Q?m5/szni//odSDDjSrymks4TBCEWE2KwZ8s0w72TWTwc8qau++GbMPo0KiYfT?=
 =?us-ascii?Q?y7gkEakg/tVrRb5spP7Zqhgw4LRZSGS+T4l4Z8IQV5UTrUk5UCWHtXy03d7I?=
 =?us-ascii?Q?Ydk9gARx06VG+fnEIC7vD+6bcKnuEOjOU2ygRsNSCMDbgHQ47aWGgl+irvEf?=
 =?us-ascii?Q?HdF3tyMdqYK1wquz98oSd0iBtmL6UprsNY2W0MQnYyT79UuFTuCMNfX1Zqmb?=
 =?us-ascii?Q?IvKzN+HkWCOjTMU7qHF/akeo9XbQoVuv5YZcScgo/WCF6afMlsnUY4pk/Y5r?=
 =?us-ascii?Q?UCXlnJpi49bH79jk+M41iSokQp7bygq06zhUmDCtb+xpsmUNFunksC1zEp9M?=
 =?us-ascii?Q?FwAAIXxM1hfYuXy0owQsJQxLc7bbwOb6XHOXo+kHOcUTm+CvsgfiTbOKtYDd?=
 =?us-ascii?Q?08/SSXtddbytteW2Ho+5fixFDGaM7+Kbv7RxnpiSfk1WW9PhSlWMJNqu/Yg4?=
 =?us-ascii?Q?ndppxa/Ef5tEd7exNACsMO+EB+LkRYgekFP/V1Pb7uGEXtuNfHyvsss3ieC6?=
 =?us-ascii?Q?MniXE7pduwtuCipHFJ62ELHb3bhR2PTURJx3z/1tW9eyZ1jmnN+kv9fo+Nti?=
 =?us-ascii?Q?hi0Daq0ssxryXE+gJ+781Mt+nGCiFk/nnW0EuH6lIM7ilelZvi828RQyHcE9?=
 =?us-ascii?Q?k68A6hNASSegm3od8LmkoBDzYhjeFtcPyEFje9OyapVHOMhZ4Q+7wUxwXEa8?=
 =?us-ascii?Q?taGrFHsahB+vr7nr5r+rfLsUuu111P6rKVW2rEXsh9/F+W51KnoxKqhVHQDe?=
 =?us-ascii?Q?GR+kmCD4XrlqYdOO3tJfUZb1OBt1b6yi77RzIhQQzMZTw5w7HleAHC9srM0t?=
 =?us-ascii?Q?R77x2UjAnQlG1z508dDTZbWnK9ZeD2ezT8mpAQN8GmrnR36s+Jf07H2zJAaR?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb93ae83-7d15-42e0-8b18-08dce4a7abdf
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:06:37.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP19E031MWJYmT63hRBCKxWx0qd7BeEHrqi48deOkgP75EpLEVLmWxJTEcxgYlfpBKwnbefncCwh/hIwLPsOsbuAcXXtr3QPgxpUlupkZog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8343

_TIF_RETUSER has to be guarded by CONFIG_DOVETAIL to allow building
CONFIG_IRQ_PIPELINE without a dovetail implementation.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/entry-common.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 900c6e303ab3..8a84f57bfde1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -350,13 +350,15 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static inline bool do_retuser(unsigned long ti_work)
 {
-	if (dovetailing() && (ti_work & _TIF_RETUSER)) {
+#ifdef CONFIG_DOVETAIL
+	if (ti_work & _TIF_RETUSER) {
 		hard_local_irq_enable();
 		inband_retuser_notify();
 		hard_local_irq_disable();
 		/* RETUSER might have switched oob */
 		return running_inband();
 	}
+#endif
 
 	return false;
 }
-- 
2.43.0


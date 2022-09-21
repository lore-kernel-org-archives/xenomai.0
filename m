Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547D7C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663751569; x=1695287569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gWWmjH8igdotT+EJRe5xlq4zJQKam+xeKLuqo8hD67Y=;
  b=EW7UTTrgDmtv4wKdWokV2VXyCX6IEY70aUBTjB9LdmvV5wpscUhK3opw
   hZMcu7tJBjGwUAKFAATdw3bnFk8ZOhogUDOXkROO9veRJXFP2mY+PI/ra
   7abQVFt5KcE52IGzsewvgLK16sgxIqXDhTfuv4v38KwTgIOA1rvM/4X7H
   H4FXnpbBtESYTTrfNu/NkX9ukqX/YviYwZeo9z2CND9yXkmAgfsh6Ipab
   emf0J7ymPFScW9jPBT1FN3hIViCInNiSqmqsfwWPdQ+Mp6FJkWUu6FENy
   l4fflbEd50zmiX52NYJU43f/ACGe0AqixRmcOY+R+NWM7izz8Yaa8bAks
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="386235169"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="386235169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:12:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="614734536"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:12:47 -0700
From: Zqiang <qiang1.zhang@intel.com>
To: rpm@xenomai.org,
	jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev
Subject: [PATCH v2] drivers/net: Make rtskb pool cache being an usercopy source
Date: Wed, 21 Sep 2022 17:19:22 +0800
Message-Id: <20220921091922.537574-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kernel enable CONFIG_HARDENED_USERCOPY option, since not marking
rtskb_slab_pool cache is usercopy type, will trigger the following
calltrace.

[  594.413602] invalid opcode: 0000 1 PREEMPT SMP PTI IRQ_PIPELINE
[  594.413603] CPU: 2 PID: 492 Comm: rtcfg Tainted:
[  594.413603] IRQ stage: Linux
[  594.413604] RIP: 0010:usercopy_abort+0x77/0x79
[  594.413610] Call Trace:
[  594.413610]  __check_heap_object+0xa6/0xc0
[  594.413611]  __check_object_size+0x136/0x150
[  594.413611]  copy_stage_1_data+0x48/0x70 [rtcfg]
[  594.413612]  rtnet_rtpc_dispatch_call+0x151/0x320 [rtnet]
[  594.413612]  ? cleanup_cmd_del+0x70/0x70 [rtcfg]
[  594.413612]  ? wait_woken+0x70/0x70
[  594.413613]  rtcfg_ioctl+0xa0/0x250 [rtcfg]
[  594.413613]  rtnet_ioctl+0xdf/0x170 [rtnet]
[  594.413613]  __x64_sys_ioctl+0x83/0xb0
[  594.413613]  do_syscall_64+0x39/0x50
[  594.413614]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This commit make rtskb_slab_pool cache being an usercopy source.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Adjust code indentation.

 kernel/drivers/net/stack/rtskb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index c9042db93..e92cb3c64 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -497,10 +497,11 @@ EXPORT_SYMBOL_GPL(rtskb_clone);
 
 int rtskb_pools_init(void)
 {
-	rtskb_slab_pool = kmem_cache_create("rtskb_slab_pool",
-					    ALIGN_RTSKB_STRUCT_LEN +
+	rtskb_slab_pool = kmem_cache_create_usercopy("rtskb_slab_pool",
+						ALIGN_RTSKB_STRUCT_LEN +
 						    SKB_DATA_ALIGN(RTSKB_SIZE),
-					    0, SLAB_HWCACHE_ALIGN, NULL);
+						0, SLAB_HWCACHE_ALIGN,
+						0, SKB_DATA_ALIGN(RTSKB_SIZE), NULL);
 	if (rtskb_slab_pool == NULL)
 		return -ENOMEM;
 
-- 
2.25.1


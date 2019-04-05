MIME-Version: 1.0
From: Roman Stratiienko <roman.stratiienko@globallogic.com>
Date: Fri, 5 Apr 2019 17:05:49 +0300
Message-ID: <CAODwZ7vER3+Jp1+-U8dfO2_LeZj=nS+PZPq0vDou5M2zDi6AVw@mail.gmail.com>
Subject: Checkpatch errors
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Hello Jan,

Let me share some of checkpatch findings after recent update:

--------------------------------------------------------------------
Commit 67549038b677 ("rtnet: e1000e: Account for timer API changes")
--------------------------------------------------------------------
WARNING: LINUX_VERSION_CODE should be avoided, code should be for the
version to which it is merged
#21: FILE: kernel/drivers/net/drivers/e1000e/netdev.c:2882:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
ERROR: space required after that ',' (ctx:VxV)
#21: FILE: kernel/drivers/net/drivers/e1000e/netdev.c:2882:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
---

Best regards,
Roman Stratiienko
Global Logic

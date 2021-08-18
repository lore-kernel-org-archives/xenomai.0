From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH 0/4] Export mqueues to procfs 
Date: Wed, 18 Aug 2021 13:24:03 +0200
Message-Id: <20210818112407.12264-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

this is another try to make registered mqueues visible. This time by
exporting them to the procfs, namely to
/proc/xenomai/registry/mqueue/<name>

Let me know what you think... 

I had to rework the existing export machinery a bit to get rid of the so
called "root" directory which is normally created. See patch
descriptions for details.

Best regards,
Florian

Florian Bezdeka (4):
  cobalt/registry: Make the root directory for proc exports optional
  cobalt/registry: Share xnregistry_vfreg_ops with other compile units
  cobalt/registry: Initialize refcnt of exported virtual proc files
  cobalt/mqueue: Export created mqueues to procfs

 include/cobalt/kernel/registry.h |  2 ++
 kernel/cobalt/posix/mqueue.c     | 35 +++++++++++++++++++++++++++++++-
 kernel/cobalt/registry.c         | 13 ++++++------
 3 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.30.2



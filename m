From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC 0/2] Simplify detection of resource leaks 
Date: Mon, 16 Aug 2021 18:12:12 +0200
Message-Id: <20210816161214.62995-1-florian.bezdeka@siemens.com>
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

Hi all,

over the last few days we had to search for and identify several
resource leaks in one of our internal applications. Here are some patches 
that were written to help us tracking the leaks down to the root cause.

In our case /proc/xenomai/registry/usage reported that all available
slots are in use but we had now clue why slots are exhausted at all.

Patch 1 adds /proc/xenomai/registry/dump. That allowed us to get a
overview of registry usage. We easily identified that the application
was leaking message queues after looking at the output.

Patch 2 adds trace events. These allowed us to identify the thread that
was creating such queues. The inballance of registry_enter and
registry_{unlink,remove} got visible.

I would like to learn if:
 - these patches are correct (especially the first one)
 - these patches are in general interest

I have backports to -stable available as well. I could send them out
easily if -stable is of interest as well.

Best regards,
Florian

Florian Bezdeka (2):
  cobalt/registry: Add a new virtual /proc file for dumping registry
  cobalt/registry: Adding trace events for
    registry_{enter,unlink,remove}

 kernel/cobalt/registry.c          | 40 +++++++++++++++++++++++++++++++
 kernel/cobalt/trace/cobalt-core.h | 33 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.30.2



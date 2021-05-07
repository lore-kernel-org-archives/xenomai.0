From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH wip/dovetail 0/1] Cleanup copy helpers
Date: Fri,  7 May 2021 17:18:29 +0200
Message-Id: <20210507151830.1260775-1-florian.bezdeka@siemens.com>
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

As already discussed:
The copy helpers for timespec/itimerspec elements using a temporary
element on the stack work for both worlds (4 and 8 byte time_t).

This patch could be applied on top of Philippes queue, as well as on
current next. 

Florian Bezdeka (1):
  cobalt: Remove duplicate timespec/itimerspec copy helpers

 .../include/asm-generic/xenomai/syscall.h     | 31 -------------------
 1 file changed, 31 deletions(-)

-- 
2.31.1



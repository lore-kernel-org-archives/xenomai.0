From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai v3.1-rc2 available
Message-ID: <4151508e-0c0e-1460-dca4-9479324ff206@siemens.com>
Date: Mon, 7 Oct 2019 14:43:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

just pushed another release candidate, this time hopefully more properly
formatted.

https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1-rc2/xenomai-v3.1-rc2.tar.bz2
https://gitlab.denx.de/Xenomai/xenomai/commits/v3.1-rc2

Changes since rc1:

François LEGAL (1):
      Make MACB driver compliant with GEM hardware

Jan Kiszka (4):
      Bump ABI revisions
      cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
      testsuite/smokey/gdb: Only run basic test if _CC_COBALT_DEBUG_SYNC_BP is missing
      config: Bump version number

Quirin Gylstorff (1):
      testsuite/xeno-test: add --vm option

There are some open bug reports waiting for further information.
Otherwise, things look good for finalizing the release rather sooner
than later.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


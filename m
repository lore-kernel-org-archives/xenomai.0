From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai v3.1-rc3 available
Message-ID: <36f42fc2-8f02-39f2-43b6-f4203d2405d9@siemens.com>
Date: Tue, 5 Nov 2019 07:53:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

yet another release candidate has been pushed:

https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1-rc3/xenomai-v3.1-rc3.tar.bz2
https://gitlab.denx.de/Xenomai/xenomai/commits/v3.1-rc3

Changes since rc2:

Jan Kiszka (9):
      prepare-kernel: Make robust against -rc release names
      Revert "testsuite/smokey/gdb: Only run basic test if _CC_COBALT_DEBUG_SYNC_BP is missing"
      Revert "cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature"
      ci: Name matrix jobs, update x86 kernel
      drivers/testing/heapcheck: Add missing MODULE_LICENSE
      CONTRIBUTING: Fix typos
      ci: Update ARM/ARM64 4.19 kernel releases
      copperplate: Handle errors properly in get_session_label
      config: Bump version number

Norbert Lange via Xenomai (1):
      smokey/gdb: search gdb in PATH

Philippe Gerum (1):
      demo/posix: cyclictest: prevent spurious WARNSW events on exit

Philippe Gerum via Xenomai (2):
      lib/copperplate: heapobj: catch invalid array-type init request
      boilerplate/avl: fix NULL link representation in pshared mode

Wolfgang Grandegger via Xenomai (1):
      utils/can: fix error handling, use errno instead of -ret

[Reading this changelog, I need to remind everyone: Please make sure to
add a "From:" line to the top of your commit body when sending patches! 
/me goes improving my tools now to catch those cases automatically...]

I'm optimistic that this should be the last RC. We are really in the
polishing phase now.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


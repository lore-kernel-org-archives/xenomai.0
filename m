Message-ID: <558D5FAD.3060003@siemens.com>
Date: Fri, 26 Jun 2015 16:20:29 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Heads up: some race condition fixes for Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

just pushed 3 patches to git.xenomai.org/xenomai-jki.git for-forge that
are supposed to fix race conditions while manipulating xnthread::state
and info (both need to be nklock-protected). Please review if finding
and fixes make sense.

      cobalt/kernel: Fix locking for xnthread info manipulations
      cobalt/kernel: Fix locking for setting XNFPU
      cobalt/kernel: Rework thread debugging helpers

Maybe some of the issues also exist in Xenomai 2, didn't check yet.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


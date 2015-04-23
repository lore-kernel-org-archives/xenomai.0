Message-ID: <5538EFB1.8080405@siemens.com>
Date: Thu, 23 Apr 2015 15:12:17 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe: Updates for 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

The following changes since commit ea7af9c0573dd0b33ac6ce900b4f91cc71224f43:

  ipipe: protect head domain while updating PTE range protection (2015-04-17 11:02:38 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki 182ec034409705315b828844f0cda163dd693d64

for you to fetch changes up to 182ec034409705315b828844f0cda163dd693d64:

  ipipe: Truly protect ioremap_page_range against APEI (2015-04-23 15:01:58 +0200)

In addition, there is one commit after these (for-upstream/3.14 head) a
merge with latest stable (3.14.39).

Jan

----------------------------------------------------------------
Jan Kiszka (5):
      x86/ipipe: Simplify __ipipe_handle/divert_exception
      x86/ipipe: Sync root state before leaving __ipipe_handle_exception
      x86/ipipe: Restore regs->flags on return from __ipipe_handle_exception
      x86/ipipe: Update comments related to exception handling
      ipipe: Truly protect ioremap_page_range against APEI

 arch/x86/kernel/ipipe.c | 96 +++++++++++++++----------------------------------
 lib/ioremap.c           |  4 +--
 2 files changed, 30 insertions(+), 70 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


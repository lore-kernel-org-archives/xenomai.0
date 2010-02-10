Message-ID: <4B72A621.8000204@domain.hid>
Date: Wed, 10 Feb 2010 13:27:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] Make xnarch_init_timeconv an
	uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit 263e81be280aede07242aca11bfa2f8e78d48f7f:
  Roland Stigge (1):
        x86 syscalls: fix __xn_get_eip

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      Make xnarch_init_timeconv an uninlined weak function

 include/asm-generic/bits/timeconv.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


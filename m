Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B3949D4.5030702@domain.hid>
Date: Tue, 29 Dec 2009 01:14:12 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: various fixes and debug
	traces
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

Here are some fixes and some insertions of debug traces which are worth
having.

The following changes since commit 6e016b0753e954664bf3ec4945bd6bbded218073:
   Philippe Gerum (1):
         x86_32: make sure CC_STACKPROTECTOR is disabled

are available in the git repository at:

   ssh+git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (5):
       analogy: fix a bug in the configuration of the debug trace system
       analogy: add a debug level threshold for drivers
       analogy: add debug traces in the attach procedure of the NI 
PCIMIO driver
       analogy: add some debug traces in the fake driver
       analogy: minor fix

  include/analogy/os_facilities.h                    |   12 ++-
  ksrc/drivers/analogy/Kconfig                       |   12 ++
  .../analogy/national_instruments/mio_common.c      |  115 
++++++++++++++++++--
  ksrc/drivers/analogy/national_instruments/ni_mio.h |    4 +-
  ksrc/drivers/analogy/testing/fake.c                |   13 +++
  5 files changed, 142 insertions(+), 14 deletions(-)

Alexis.


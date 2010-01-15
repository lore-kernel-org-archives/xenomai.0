Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B4FBBFD.5050203@domain.hid>
Date: Fri, 15 Jan 2010 01:51:09 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 963fc21168ca6b29ab7c7ea95d56a393c475bdce:
   Gilles Chanteperdrix (1):
         bootstrap

are available in the git repository at:

   git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (4):
       analogy: [NI mite] initialize channels' status
       analogy: [NI mite] add debug traces
       analogy: [NI mite] initialize the mite structures after their 
allocations
       analogy: fix a bug in the initialization of the user root descriptor

  ksrc/drivers/analogy/national_instruments/mite.c |   70 
++++++++++++++--------
  src/drvlib/analogy/descriptor.c                  |   12 +++-
  2 files changed, 56 insertions(+), 26 deletions(-)

Alexis.


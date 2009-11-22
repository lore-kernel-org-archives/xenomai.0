Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 23 Nov 2009 00:25:53 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200911230025.53738.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PULL REQUEST] analogy: doxygen errors descriptions,
	headers sources fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 76456b88f8fe8cf9885996f2c042df7d4b266df0:
  Alexis Berlemont (1):
        analogy: add error messages in instruction handling

are available in the git repository at:

  ssh+git://git.xenomai.org/xenomai-abe.git analogy 

Alexis Berlemont (4):
      analogy: add error codes descriptions for synchronous operations
      analogy: add error codes descriptions for descriptor routines
      analogy: add error codes descriptions for range management routines
      analogy: fix mistakes in license declarations

 ksrc/drivers/analogy/intel/8255.c    |   23 ++++++-------
 ksrc/drivers/analogy/intel/parport.c |   22 ++++++------
 src/drvlib/analogy/async.c           |    4 +-
 src/drvlib/analogy/descriptor.c      |   57 ++++++++++++++++++++++++++-------
 src/drvlib/analogy/range.c           |   21 +++++++++++--
 src/drvlib/analogy/sync.c            |   28 ++++++++++++++--
 6 files changed, 111 insertions(+), 44 deletions(-)


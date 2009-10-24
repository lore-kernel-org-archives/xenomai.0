Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4AE2B519.70504@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sat, 24 Oct 2009 10:03:04 +0200
Message-ID: <20091024080304.22784.46688.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/2] fork-safe rt_print, rt_syslog extension
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Oliver Schlenker <oliver.schlenker@domain.hid>

Please pull Oliver's rt_print patches from

    git://xenomai.org/xenomai-jki.git for-upstream


Oliver Schlenker (2):
      Fork-safe rt_print
      Syslog extension of rt_print

 include/rtdk.h      |    2 +
 src/rtdk/rt_print.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 7 deletions(-)

PS: Trying to manage patches by hand is doomed to fail. I can only
recommend anyone investing the time to get familiar with basic git
commands. It quickly pays off, even for managing only private changes.


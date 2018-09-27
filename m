From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <688c02d5-bcd2-f43c-7e7a-af4e586919b4@siemens.com>
Date: Thu, 27 Sep 2018 19:05:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [ipipe][PULL] x86 update to 4.4.158
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

The following changes since commit f4dfbe3f8ecff040c66cd13c49861bb4cb3a2009:

  ipipe: fix preemption damage in hard_preempt_enable() (2018-03-26 19:30:20 +0200)

are available in the Git repository at:

  https://gitlab.denx.de/Xenomai/ipipe-x86.git for-upstream/4.4

for you to fetch changes up to 9e6ffc487727f214e510c746ebc1a36538530170:

  Merge tag 'v4.4.158' into for-upstream/4.4 (2018-09-27 08:40:17 +0200)

This has been tested on x86-64 so far.

----------------------------------------------------------------
(removing all upstream stable commits)

Henning Schild (1):
      x86: make fpu switching eager

Jan Kiszka (11):
      Merge tag 'v4.4.109' into for-upstream/4.4-update
      x86/ipipe: Disable access_ok context under I-pipe
      Merge tag 'v4.4.120' into for-upstream/4.4-update
      Merge tag 'v4.4.126' into for-upstream/4.4-update
      Merge tag 'v4.4.131' into for-upstream/4.4-update
      Merge tag 'v4.4.136' into for-upstream/4.4-update
      Merge tag 'v4.4.137' into for-upstream/4.4-update
      x86/ipipe: Fix kgdb hook skipping
      Merge tag 'v4.4.138' into for-upstream/4.4
      Merge tag 'v4.4.157' into for-upstream/4.4
      Merge tag 'v4.4.158' into for-upstream/4.4


From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
Date: Fri, 9 Mar 2018 17:51:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe 4.4 updates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 5618f90d33b17ab0ee9352705610a5e9f00f9964:

  Revert "ipipe: printk: defer dev_printk() output to safe context" (2017-12-15 18:10:01 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/4.4-update

for you to fetch changes up to c6de6878f74e4b079066eddc373f3e8c125fdaa7:

  Merge tag 'v4.4.120' into for-upstream/4.4-update (2018-03-08 18:49:28 +0100)


I-pipe specific commits:

Jan Kiszka (5):
      arm/ipipe: Avoid open-coded __ipipe_call_mayday
      x86/ipipe: Deny JUMP_LABEL over I-pipe
      Merge tag 'v4.4.109' into for-upstream/4.4-update
      x86/ipipe: Disable access_ok context under I-pipe
      Merge tag 'v4.4.120' into for-upstream/4.4-update

Philippe Gerum (1):
      ipipe: printk: enable dev_printk() from the head stage


4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
repo.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


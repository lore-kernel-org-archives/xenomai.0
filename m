From: Romain Naour <romain.naour@openwide.fr>
Date: Sat, 28 Dec 2013 13:31:13 +0100
Message-Id: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
Subject: [Xenomai] [PATCH 0/1] armv5tej support in xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

Can confirm that the armv5tej architecture is supported by xenomai ?

There are currently some compilation errors like this one on buildroot's autobuilder:
http://autobuild.buildroot.net/results/e3b/e3b534dafb6dd7d788b0c3629ccc0b25702790f0/build-end.log

This error is fixed by the following path.

Best regards,
Romain Naour

Romain Naour (1):
  arm: enable armv5tej support

 include/asm-arm/features.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.4



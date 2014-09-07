From: Paul <paul_c@tuxcnc.org>
Date: Sun, 7 Sep 2014 23:37:47 +0100
MIME-Version: 1.0
Message-Id: <201409072337.48129.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Doing compile/install on a minimal system, hit upon a minor problem when 
executing:

 make devices
 /bin/bash: line 25: sudo: command not found

Small fix required as per attached patch.


Regards, Paul.



-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Minor-fix-for-missing-variable-reference.patch
Type: text/x-diff
Size: 707 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140907/fd967876/attachment.patch>

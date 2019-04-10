From: Norbert Lange <nolange79@gmail.com>
Subject: 
Date: Wed, 10 Apr 2019 16:25:17 +0200
Message-Id: <20190410142518.12791-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

V2 now also fixes the wrappers.

Btw. wouldnt it be possible to just do away with the ugly vaargs?
I tested a few architectures (x86, arm mips, both 32 and 64 bit)
and the function call singature stays the same whether a
function has varagrs or a fixed amount of arguments.

The wrappers could then be oblivous to such wacky special cases.

Torvalds seems to have that opinion aswell:
https://lkml.org/lkml/2014/10/30/812




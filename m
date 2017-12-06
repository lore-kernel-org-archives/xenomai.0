From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
Date: Wed, 6 Dec 2017 18:37:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


I pushed a pile of RTnet fixes in a WIP branch of the official repo
(wip/rtnet-fixes). Most of them address invalid direct references to
user memory from kernel space (instead of properly copying back and
forth via the copy_from/to_user interface), which are badly wrong at any
rate, even breaking the kernel on SMAP-enabled x86 platforms.

Most I/O calls were affected, ioctl, sendmsg and recvmsg. I'm still in
the early process of testing the changes gradually, which involves
running tests for all socket levels (RAW, DGRAM) and protocols (INET,
PACKET) enabled.

If you depend on RTnet and want to help with testing, you may want to
give this branch a try. Any help with reviewing the changes would be
beneficial to the project too.

Thanks,

-- 
Philippe.


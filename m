Date: Mon, 6 Apr 2020 18:15:40 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Xenomai 3.1 missing munmap Posix wrapper
Message-ID: <freemail.20200406181540.86462.1@fmxmldata05.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Everybody,

I just migrated from 2.6.2.1. to 3.1 and run into an issue in my user mode application.
The Posix wrapper for the munmap() function is missing. I mean the cobalt.wrappers file does not have a --wrap munmap line and the library does not have the function either. Why is that? 
The mmap wrapper is there. I need to unmap the memory before closing the file descriptor. At least I did it this way in my old sources. Can I skip the munmap() call in this new Xenomai version before closing the descriptor?

Than you,
Tamas


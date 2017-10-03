MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Tue, 3 Oct 2017 12:49:58 +0100
Message-ID: <CAKJ14NfjG5uVNEdmxPhqU39V3ADdnC9yCq+4eU7dov2aRixohQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Xenomai and libunwind on ARM Cortex A9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I implemented the debug signal handle SIGXCPU as described in the
Xenomai documentation. The glibc function backtrace() returns
backtraces, but they often are very short (they typically end at the
signal (restore) handler, and don't show the function which caused the
SIGXCPU in the first place).

I found libunwind, which is preloaded before starting our application
and replaces the glibc backtrace handler with unw_backtrace(). This
works fine most of the time.

Recently, I discovered that the application crashes with SIGSEGV
during startup when quite a few SIGXCPUs occur in short succession
according to the gdb trace. Everything seems to work fine when
switching back to the glibc backtrace() function though. Now I'm
wordering if unw_backtrace() is actually not (Xenomai) thread-save.
Has anyone seen this before [or any other clues]?

Cheers,

Andreas


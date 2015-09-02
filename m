MIME-Version: 1.0
Date: Wed, 2 Sep 2015 14:22:56 -0700
Message-ID: <CAJqUr7zJXoASSpTr=Y8ZOzDDhWruZU9BVTbQ3YViqm7Lf8kTMA@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] xenomai-3/arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pull request for xenomai-3/arm64, fixing tracing/syscall prints for arm64.

The following changes since commit ef3d72d9825eb5ce3a75b93b6b4b4104f7c41db0:

  cobalt/arm64: machine.h: use slightly faster ffnz implementation
(2015-06-17 16:09:20 -0700)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/xenomai-3.git arm64

for you to fetch changes up to ab0f4e2e24830c67600270789fd2ce2811c2ce60:

  cobalt/arm64: pc and orig_r0 are u64 on arm64 and 'unsigned long' or arm
and other platforms. printf referencing these are using %lx. On arm64, long
and long long (and u64) are 64 bits. Rather than changing printf format,
chnage arm64 macros to cast to unsigned long. (2015-09-02 13:48:36 -0700)

----------------------------------------------------------------
Don Mahurin (1):
      cobalt/arm64: pc and orig_r0 are u64 on arm64 and 'unsigned long' or
arm and other platforms. printf referencing these are using %lx. On arm64,
long and long long (and u64) are 64 bits. Rather than changing printf
format, chnage arm64 macros to cast to unsigned long.

 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h | 2 +-
 kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h  | 2 +-
 kernel/cobalt/posix/syscall.c                          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

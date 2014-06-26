MIME-Version: 1.0
Date: Thu, 26 Jun 2014 14:17:09 +0200
Message-ID: <CAEeRa+SS+Kwnf_L_zi5tWJ81Le8rVWbZM_hQWSdaBR-1TAcnwg@mail.gmail.com>
From: Stefan S <smarzlys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Safe to use GCC atomics within Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

GCC 4.6.3 (included in Ubuntu 12.04 LTS) supports atomic builtins.
I would like to know whether it is safe to use the following builtins:

* type __sync_fetch_and_or (type *ptr, type value, ...)
* __sync_synchronize (...)
* type __sync_lock_test_and_set (type *ptr, type value, ...)
(Definitions taken from
https://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Atomic-Builtins.html)

I know that in "asm/xenomai/atomic.h", there are some Xenomai specific
defintions but not for the first one.

My configuration:

* Xenomai 2.6.3 with ipipe-core-3.10.32-x86-2 patch on a vanilla kernel
* x86_64, Intel core i5
* Ubuntu 12.04.4 LTS

Thank you :)


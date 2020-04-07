MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 7 Apr 2020 17:13:47 +0800
Message-ID: <CAAvDm6bD0n33+qGDny57N54SABDaMBSU+4PyY05moy3Yxn+7yQ@mail.gmail.com>
Subject: =?UTF-8?Q?Does_the_function_malloc=28=29_uses_the_real_malloc_or_t?=
 =?UTF-8?Q?he_wrap_one_in_heapobj=5Fpkg=5Finit=5Fprivate=28=EF=BC=89=2E?=
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The source code url is
https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/lib/copperplate/
heapobj-heapmem.c  line:107

In the source code listed above, function heapobj_pkg_init_private()  calls
malloc().
I hope to know whether it calls the wrapper function or
the real malloc function which provides by the glibc?

How could I distinguish a function directs to the wrapper function or
the real one which provides by the glibc?

Thanks a lot. Looking forward to your replay.

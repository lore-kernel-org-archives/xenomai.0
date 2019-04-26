From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: having problems with daemonizing
Date: Fri, 26 Apr 2019 17:18:34 -0400
Message-ID: <44ftq4zcr9.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.

I have an application working successfully with Xenomai 3.0.8 on a 4.14
kernel. I use Yocto to build the system; when I tried to move to a newer
version of Yocto, my application hung on trying to become a daemon. This
is happening with the daemon() call (which is what I've used up to now)
and with fork().

I built a test application so that I could confirm that this problem
only occurs when I link (and wrap) with Xenomai. However, Xenomai
doesn't seem to do anything significant with fork, so I'm puzzled about
why this might be happening. I am not using libdaemon.

Here are the changes that I thought might be significant:
| newer (nonworking setup)  | older (working) |
| gcc-cross-arm-8.2.0       |           7.3.0 |
| glibc-2.28                |            2.26 |
| glib-2.0-1_2.58.0         |     1_2.52.3-r0 |
| binutils-cross-arm-2.31.1 |          2.29.1 |
| coreutils-8.30            |            8.27 |

Does anything jump out as a candidate for causing problems with a fork()
call? Is there anything else I should be considering?

Thanks.

Be well.


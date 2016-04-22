MIME-Version: 1.0
Sender: andret7@gmail.com
From: Andrea <andrea.schiappacasse@camelotbio.com>
Date: Fri, 22 Apr 2016 10:51:34 +0200
Message-ID: <CAMQ-e4_L=X+8Nn5R+LnsEgtz4ZRgz8KaN48qhV-4vFCwpkFt5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Assertion failed on "test posix_clock" on some executions
 of xeno-test.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

I'm currently using Xenomai 3.0.2, under kernel 4.1.8  with i-pipe patch.
I just noticed that I'm experiencing an error on some run of xeno-test.

The reported error is:
*posix-clock.c:420, assertion failed: diff < 1000000000*
*/usr/xenomai/bin/smokey: test posix_clock failed: Invalid argument*

The specific function where the assert is issued in posix-clock.c is
"clock_decrease_after_periodic_timer_first_tick(void)"

On multiple executions it is not reproducible, I am wondering if anybody
could hint me to the source of the problem on my system.

On two consecutives run this is what I get from the test:


RUN A (no error):
*./xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -t 2*
Started child 4475: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test -t 2
++ echo 0
++ testdir=/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
cpu_affinity skipped (no kernel support)
iddp skipped (no kernel support)
leaks OK
net_packet_dgram skipped (no kernel support)
net_packet_raw skipped (no kernel support)
net_udp skipped (no kernel support)
*posix_clock OK*
[...]


RUN B (assertion failed):

* ./xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -t 2*
Started child 3117: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test -t 2
++ echo 0
++ testdir=/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
cpu_affinity skipped (no kernel support)
iddp skipped (no kernel support)
leaks OK
net_packet_dgram skipped (no kernel support)
net_packet_raw skipped (no kernel support)
net_udp skipped (no kernel support)
*posix-clock.c:420, assertion failed: diff < 1000000000*
*/usr/xenomai/bin/smokey: test posix_clock failed: Invalid argument*


Thank you in advance for your kind attention,

Andrea

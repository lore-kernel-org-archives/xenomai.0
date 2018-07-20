MIME-Version: 1.0
From: Jackson Jones <jackson.jones@gmail.com>
Date: Fri, 20 Jul 2018 16:28:01 -0700
Message-ID: <CADXNiGUL514kD3+aHJRRcru8E8Lz3XUd3mDF=ng4xTm4QnoKFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Cobalt Scheduling tasks on a single core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are running against xenomai 3.0.7 on a quad core arm (i.mx6).  Xenomai
was configured with these arguments:

#export CFLAGS=-O2 LIBS=-lposix
./configure \
    --with-core=cobalt \
    --enable-smp \
    --enable-registry \
    --enable-pshared \
    --enable-dlopen-libs \
    --enable-sanity \
    --disable-tls \
    --enable-valgrind-client \
    --disable-assert

The main app spawns off several real time tasks. Cobalt is scheduling all
the real-time tasks on one core. Is this normal behavior for Cobalt? I
would expect it to take advantage of the multiple cores.

Is there some incorrect configuration causing Cobalt to do this? Any
insight would be helpful.

While running the application:

cat /proc/xenomai/sched/stat reports all tasks are running on the same CPU
core.

Sample output:
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          14173      0          0     00018000  100.0  [ROOT/0]
  1  0      0          69132      0          0     00018000  100.0  [ROOT/1]
  2  0      0          4306       0          0     00018000   98.1  [ROOT/2]
  3  0      0          0          0          0     00018000  100.0  [ROOT/3]
  2  8385   80         90         374        0     000680c0    0.0
xenomai_test_ap
  2  8388   10         10         49         0     000600c0    0.0  sysregd
  2  8390   1          1          2          0     000600c0    0.0  sysregd
  2  8393   1          1          2          0     000600c0    0.0
xenomai_test_ap
  2  8396   5          1046       1054       1     00048044    0.0  test
task 1
  2  8397   4          1045       1036       1     00048044    1.7  test
task 2
  2  8398   4          48         56         1     00048044    0.1  test
task 3
  2  8399   3          111        117        0     00048044    0.0  test
task 4
  2  8400   3          213        221        0     00048044    0.0  test
task 5
  0  0      0          120613     0          0     00000000    0.0  [IRQ16:
[timer]]
  1  0      0          142865     0          0     00000000    0.0  [IRQ16:
[timer]]
  2  0      0          46776      0          0     00000000    0.0  [IRQ16:
[timer]]
  3  0      0          37592      0          0     00000000    0.0  [IRQ16:
[timer]]

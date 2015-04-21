MIME-Version: 1.0
Date: Tue, 21 Apr 2015 15:36:09 +0200
Message-ID: <CAL5YyVa9ORXPocaRvJ_VJKk9uF7X8VdNQMNRev84SV6Z8tDM=A@mail.gmail.com>
From: ACO31 <alain.cordat@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] X86 rebbot when i use latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

HI,

In kernel conf, I have enabled oops feature and set 60s for panic on oops.
rebuild kernel and  after reboot on patched kernel, build xenomai binaries,
lib,...
But when I run: sudo  switchtest --help, the PC frezze without message.
But when I run (as root) latency -p 100 the pc reboot without timeout.
...
Other thing: in kernel conf, I don't find SMI workaround, in order to
enable SMI for USB mouse for example.
So I must use PS2 mouse in my test board, but this connector will no more
exist on the definitive board.
Thanks
alain

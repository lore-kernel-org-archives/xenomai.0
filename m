MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 22 Sep 2017 17:54:43 -0700
Message-ID: <CA+K1mPHs7A6GSh281Z6Tb2a3AZQ0vasTMdgX0hsj6Fkb01_Y+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] RT->nonRT communication (Xenomai 2.6.4)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all --

Thanks to your help, I am now using XDDP sockets for communication between
non-RT processes and a single RT process.  It is generally working -- I
start the RT task first, and it opens several sockets.  It starts doing
non-blocking reads and writes, and since no process is on the other end,
they return immediately.

Then I start one or more non-RT processes that connect, either O_RDONLY or
O_WRONLY, to several of the non-RT ends of the sockets (via /dev/rtpXX).
That works well, now the RT and non-RT processes are exchanging data.

The problem comes if I run one of the non-RT processes in a debugger and
halt it (after it has connected).  The evidence is ambiguous, but usually
it seems the RT task just hangs.  Then if I continue the non-RT process,
everything becomes healthy again and messages flow.  Or, if I kill the
non-RT process, at least the RT task doesn't hang.

I haven't been able to figure out anything about the RT process when it is
"hung".  The first time I saw this today, it appeared that a socket
sendto() operation in the RT process was returning errno = ENOMEM, but I
wasn't able to reproduce it.  If I attach to the RT process in a debugger
while it is hung, I'm not able to get it to continue.  And if I start the
RT process in a debugger, then break when it hangs, I can single step
through the entire infinite loop of the RT process without problem; but
then when I continue it goes back to the hang behavior.  (One thing the
infinite loop does is increment a counter in shared memory -- I can see
this happen when I'm single stepping, but then when I continue I see from
non-RT processes that the counter in shared memory stops incrementing.)

Any ideas, either what is expected when the process on one end of an XDDP
socket is suspended, or how I could figure out what's going on in the RT
process?

Thanks for all you help so far!
Bob

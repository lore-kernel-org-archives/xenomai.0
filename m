MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 11 Aug 2017 14:59:36 -0700
Message-ID: <CA+K1mPF52Gd8b1qviDH=KMpasF1E6CiWki0KAzY67BmCsZQfMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rt_pipe_* - must link xenomai and flush the pipe
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

We have an architecture with 1 realtime task, and several non-realtime
processes (other programs) that communicate with the realtime task over
FIFOs.  We have used RTLinux in the past, and are porting to Xenomai.  I've
had to do some voodoo to get the FIFOs working, and I wonder if this sounds
right to you folks:

We are using the rt_pipe_* API.  The process that creates the realtime task
creates the pipes with rt_pipe_create(), before starting the realtime
task.  The names show up in /proc/xenomai/registry/native/pipes/. The
non-realtime processes just use open() and write() to put data into the
pipe.  The non-realtime processes can compile and run without linking
against xenomai libraries.

The two weird things I find are that:

  1) If I don't link the non-realtime processes against xenomai libraries,
the non-realtime process can write to the pipe without error, but the
realtime process never sees anything that it wrote; and

  2) Even with xenomai linked in, the non-realtime task must flush the pipe
(ioctl(fd, XNPIPEIOC_IFLUSH, 0); or else the realtime task never sees
anything they wrote.

I've tried this with both blocking and non-blocking rt_pipe_read().

I'd appreciate your thoughts,
Bob

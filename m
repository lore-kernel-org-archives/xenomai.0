MIME-Version: 1.0
From: Virendra Kate <virendrakate@gmail.com>
Date: Thu, 3 May 2018 10:49:33 -0700
Message-ID: <CAA3JOdbY+p2yHyUEKmKDaug8hUj5izgxwfAYrf4BCgrx48-4Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Shared memory between RT and NRT tasks (Posix Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am trying to create a shared memory between a RT (Cobalt) and a NRT
(Linux) task. I went through the " A Tour of the Native API " document
which pointed me towards the alchemy (previously "native") API.

Currently we are using the Posix skin as it has better performance. This
link:
http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__posix__shm.html
indicates
that the typical posix share memory API was available for Xenoami Cobalt in
version 2.4.

Since the shared memory section is missing in the Xenomai 3 documentation
and I couldn't find the --wrap shm_open() etc. flags in the
"cobalt.wrappers" file I was wondering if this functionality is supported
in Xenomai 3 Posix skin.

At this point I am avoiding the use of message queues.

Any help is appreciated.

Thanks,
Virendra Kate

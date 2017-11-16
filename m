From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e1260ae4-8577-2410-ca75-ef5ee788073f@xenomai.org>
Date: Thu, 16 Nov 2017 17:54:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [HEADS-UP] Xenomai 3.x / Cobalt - critical fix
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


A really bad bug has just been fixed in the implementation of a basic
synchronization object (aka Cobalt monitor) in the Cobalt core,
affecting SMP configs exclusively. As observed with a real world
application, the bug could cause waiters to sleep indefinitely on a monitor.

Cobalt monitors are heavily used in all non-POSIX Xenomai APIs
indirectly via the syncobj abstraction from libcopperplate, i.e.
alchemy, psos, vxworks, so all of those APIs are potentially affected by
this bug. Strictly POSIX apps not depending on libcopperplate are immune
to this issue though.

All Xenomai 3.x releases are vulnerable. A fix is avail from the git
repo, for the stable-3.0.x [1] and next [2] branches.

This is a really creepy, timing-dependent bug. If you depend on any of
the vulnerable APIs, you really want to pick that fix. I mean, really,
no joke.

[1]
http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=3112a3f98feaa8fa3109f89013bec8674308ede3
[2]
http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=8211ff20e3380fffa0df4ba4bea5b62c0f4005c2

-- 
Philippe.


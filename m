MIME-Version: 1.0
Date: Wed, 4 Mar 2015 11:33:46 -0600
Message-ID: <CA+C+_XTfx6fAC3UvATJULBqogpvAOozwNkop=6Vj+jPYondj9Q@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Debugger and secondary mode question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I fixed all my toolchain problems and am finally back to debugging my
code.  Thanks for the help earlier.

It looks like gdbserver causes suspended threads to drop back down to
secondary mode, causing my rt_... calls to return ENOSYS.  Is there
anything I can do to prevent this?  I expect its unavoidable.

If I can't stop it, does anybody have any recommendations of how to make
code resilient to this?  I'm mostly just using mutexes and semaphores in my
main loop.  Can I mix real time and non-realtime functions with the same
handle?  In other words, what happens to a rt semaphore when the thread
transitions back to secondary mode?  Does the handle refer to a non rt
version now, or is it just inaccessible?

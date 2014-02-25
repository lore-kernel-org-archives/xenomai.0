MIME-Version: 1.0
Date: Tue, 25 Feb 2014 10:07:38 +0100
Message-ID: <CAKc2HpbgUU77_Y25KXjf6jHHLzmNX3PmOxqQsYK4dH0crk9--A@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai-forge: SIGCHLD to SIG_IGN in spawn_daemon() okay?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I noticed that when enabling the registry in Xenomai-forge (mercury
core), that the SIGCHLD gets set to ignore (SIG_IGN) in the
spawn_daemon() call.
I guess this choice was made to make sure no zombies of the daemon
stay alive. Correct?

This does however mean that the default behaviour of the application
regarding the handling of children is changed. Now I wonder whether it
is okay (as a rule/practice) for a library to change this behaviour of
the application. Shouldn't we look for a solution where the behaviour
of the application remains untouched?

Regards,
Kim


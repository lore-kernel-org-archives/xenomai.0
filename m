MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 13 Dec 2016 08:23:17 +0100
Message-ID: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] copperplate/registry daemon connection failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

Context: we use the Mercury core (xenomai-3.0.3).

in commit 880b3acbd876a65f8fbe8c27b09762b06c06e846:
copperplate/registry: force SCHED_OTHER on helper threads
of
Sun Jul 26 12:37:15 2015 +0200

The scheduling class of the registry threads is forced to
SCHED_OTHER  at priority 0.
This change is causing issues in our use case since our system
is fully loaded during init.

What I observe is that the application is not able to connect to
the registry daemon and exists with following error:
   0"988.361| WARNING: [main] cannot connect to registry daemon
   0"989.141| WARNING: [main] setup call copperplate failed
   0"989.369| BUG in xenomai_init(): [main] initialization failed, EAGAIN

As a test I made a change to the code and started the registry threads
in RR mode at a high priority and then the issue is not observed.
In our system all threads (application and kernel one's) are running
in the real-time domain so apps running in the OTHER domain will
have very little CPU left to consume ...

For me it is not clear how the synchronization between the daemon
and the application is happening. The daemon is setting up a
Unix domain socket to which the client connects. But how does the
application knows that the daemon has finished the creation of
the socket?

Thanks
Ronny


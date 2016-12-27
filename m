References: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e24d081d-456f-4c99-0105-0ddf688d2319@xenomai.org>
Date: Tue, 27 Dec 2016 10:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] copperplate/registry daemon connection failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/13/2016 08:23 AM, Ronny Meeus wrote:
> Hello
> 
> Context: we use the Mercury core (xenomai-3.0.3).
> 
> in commit 880b3acbd876a65f8fbe8c27b09762b06c06e846:
> copperplate/registry: force SCHED_OTHER on helper threads
> of
> Sun Jul 26 12:37:15 2015 +0200
> 
> The scheduling class of the registry threads is forced to
> SCHED_OTHER  at priority 0.
> This change is causing issues in our use case since our system
> is fully loaded during init.
> 
> What I observe is that the application is not able to connect to
> the registry daemon and exists with following error:
>    0"988.361| WARNING: [main] cannot connect to registry daemon
>    0"989.141| WARNING: [main] setup call copperplate failed
>    0"989.369| BUG in xenomai_init(): [main] initialization failed, EAGAIN
> 
> As a test I made a change to the code and started the registry threads
> in RR mode at a high priority and then the issue is not observed.
> In our system all threads (application and kernel one's) are running
> in the real-time domain so apps running in the OTHER domain will
> have very little CPU left to consume ...
> 

libfuse assumes SIGCHLD is not ignored when calling fuse_main(), this is
the root of the issue. Thread priority is not involved in this bug,
tweaking it may only make it less likely, but does not fix it (e.g.
SMP). The core issue is with guaranteeing that a forkee exiting early
stays in a zombie state until the parent can issue waitpid() to collect
its status, which add_mount() from libfuse requires.

Some details are given here:
http://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=4364bdd358e893b1f4f7f644a35191b3fc7f4180

> For me it is not clear how the synchronization between the daemon
> and the application is happening. The daemon is setting up a
> Unix domain socket to which the client connects. But how does the
> application knows that the daemon has finished the creation of
> the socket?
> 

It does not have too. Check the combined logic in bind_socket() and
connect_regd().

-- 
Philippe.


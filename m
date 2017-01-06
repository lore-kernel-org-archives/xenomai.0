MIME-Version: 1.0
In-Reply-To: <e24d081d-456f-4c99-0105-0ddf688d2319@xenomai.org>
References: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
 <e24d081d-456f-4c99-0105-0ddf688d2319@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 6 Jan 2017 10:21:53 +0100
Message-ID: <CAMJ=MEcz=py5s-BVBs2VX3pD-w3zNzcgLUePpifWx08SVXdVDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] copperplate/registry daemon connection failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Dec 27, 2016 at 10:56 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/13/2016 08:23 AM, Ronny Meeus wrote:
>> Hello
>>
>> Context: we use the Mercury core (xenomai-3.0.3).
>>
>> in commit 880b3acbd876a65f8fbe8c27b09762b06c06e846:
>> copperplate/registry: force SCHED_OTHER on helper threads
>> of
>> Sun Jul 26 12:37:15 2015 +0200
>>
>> The scheduling class of the registry threads is forced to
>> SCHED_OTHER  at priority 0.
>> This change is causing issues in our use case since our system
>> is fully loaded during init.
>>
>> What I observe is that the application is not able to connect to
>> the registry daemon and exists with following error:
>>    0"988.361| WARNING: [main] cannot connect to registry daemon
>>    0"989.141| WARNING: [main] setup call copperplate failed
>>    0"989.369| BUG in xenomai_init(): [main] initialization failed, EAGAIN
>>
>> As a test I made a change to the code and started the registry threads
>> in RR mode at a high priority and then the issue is not observed.
>> In our system all threads (application and kernel one's) are running
>> in the real-time domain so apps running in the OTHER domain will
>> have very little CPU left to consume ...
>>
>
> libfuse assumes SIGCHLD is not ignored when calling fuse_main(), this is
> the root of the issue. Thread priority is not involved in this bug,
> tweaking it may only make it less likely, but does not fix it (e.g.
> SMP). The core issue is with guaranteeing that a forkee exiting early
> stays in a zombie state until the parent can issue waitpid() to collect
> its status, which add_mount() from libfuse requires.
>
> Some details are given here:
> http://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=4364bdd358e893b1f4f7f644a35191b3fc7f4180
>

I did a test with this patch but it does not resolve the issue.
I see exactly the same error message as mentioned above.
Note that I added traces to the application code (marked by connect_regd)
and in the sysregd (marked with <pid> regd).

isam_app_wrapper: Starting background application /usr/bin/taskset 1
/bin/setarch linux32 -R   /isam/slot_1101/run/isam_nt_app
mLogicalSlotId=4353 noSMAS
app_config_file=/isam/slot_1101/config/app_config
wdog_kick_file=isam_nt_app_slot_1101
connect_regd (try 0): create socket
connect_regd (try 0): connect
connect_regd (try 0): spawn daemon
2525 regd: before changing to SCHED_OTHER
connect_regd (try 1): create socket
connect_regd (try 1): connect
connect_regd (try 1): spawn daemon
2547 regd: before changing to SCHED_OTHER
connect_regd (try 2): create socket
connect_regd (try 2): connect
connect_regd (try 2): spawn daemon
2569 regd: before changing to SCHED_OTHER
   0"867.727| WARNING: [main] cannot connect to registry daemon
   0"868.518| WARNING: [main] setup call copperplate failed
   0"868.753| BUG in xenomai_init(): [main] initialization failed, EAGAIN
isam_app_wrapper: /isam/slot_1101/run/isam_nt_app has stopped!
isam_app_wrapper: System wide reset triggered due to escalation!
ISAM application /isam/slot_1101/run/isam_nt_app exited.
isam_app_wrapper: Not rebooting (config flag 'reboot' is 0)...
2525 regd: after changing to SCHED_OTHER
2547 regd: after changing to SCHED_OTHER
2569 regd: after changing to SCHED_OTHER

>From the traces you can clearly see that the daemon is started 3 times
and that it is actually started immediately but once the scheduling class
is changed, it gets scheduled out and needs to wait until the application
has given up and triggered a reboot because of the initialization error.
Only when the application has stopped the daemon threads are allowed to
run and continue with printing the traces put directly after changing the
call to change the scheduling class:

+       printf("%d regd: before changing to SCHED_OTHER\n", tmp);
+       fflush(NULL);
+
        /* Force SCHED_OTHER. */
        schedp.sched_priority = 0;
        __STD(pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedp));

+       printf("%d regd: after changing to SCHED_OTHER\n", tmp);
+       fflush(NULL);


>> For me it is not clear how the synchronization between the daemon
>> and the application is happening. The daemon is setting up a
>> Unix domain socket to which the client connects. But how does the
>> application knows that the daemon has finished the creation of
>> the socket?
>>
>
> It does not have too. Check the combined logic in bind_socket() and
> connect_regd().

That logic I had seen before.
As I understand the code it just tries 3 times to connect to the daemon
and if not successful, it just tries to start it again and reconnects ...
I find it a strange logic just to try something 3 times and hope it
will succeed.
In our case the CPU is fully loaded with RT threads so my assumption is that
the daemon, running at nonRT prio will not be scheduled at all.
(also see the traces above that confirm my assumptions)

I would expect to see some kind of synchronization mechanism between the
daemon and the application.

Ronny

>
> --
> Philippe.


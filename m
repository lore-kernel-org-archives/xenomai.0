MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Sun, 7 Dec 2014 17:26:19 +0100
Message-ID: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

we are using the xenomai-forge implementation.
We from time to time see an issue that the timer-internal thread is
consuming a complete core. It is seen when we send broadcast traffic that
needs to be handled by the Linux kernel (ARP).

The kernel thread's priority handling the packets in the middle between the
timer-internal thread and the application thread's priority. All threads
run on the same core.
If the priority of the timer-internal is lowered below the kernel thread,
the load disappears immediately.
So it looks like there is some busy polling on a common resource that is
currently held by the application thread running at the lowest prio.

I see that the timer lock being used is a mutex with priority inheritance
so I would expect that the prio of the application is raised as soon as the
timer-internal thread tries to obtain the mutex.

It might be that it has nothing to do with the mutex, this is just my guess.

Has anybody seen similar issues before?

Best regards,
Ronny

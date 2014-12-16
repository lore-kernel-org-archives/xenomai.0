MIME-Version: 1.0
In-Reply-To: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 16 Dec 2014 18:36:10 +0100
Message-ID: <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Sun, Dec 7, 2014 at 5:26 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> Hello
>
> we are using the xenomai-forge implementation.
> We from time to time see an issue that the timer-internal thread is
> consuming a complete core. It is seen when we send broadcast traffic that
> needs to be handled by the Linux kernel (ARP).
>
> The kernel thread's priority handling the packets in the middle between the
> timer-internal thread and the application thread's priority. All threads run
> on the same core.
> If the priority of the timer-internal is lowered below the kernel thread,
> the load disappears immediately.
> So it looks like there is some busy polling on a common resource that is
> currently held by the application thread running at the lowest prio.
>
> I see that the timer lock being used is a mutex with priority inheritance so
> I would expect that the prio of the application is raised as soon as the
> timer-internal thread tries to obtain the mutex.

After investigating this issue in more detail I have the impression that it has
nothing to do with the mutex used to protect the timer but with the conditional
variable used to implement the psos event interface.

I found references on the web that explain an issue with the internal mutex used
inside the posix library to implement a conditional variable. See:
https://bugzilla.redhat.com/show_bug.cgi?id=438484
http://marc.info/?t=134688711000002&r=1&w=2

If this is indeed true, it means that the usage of conditional
variables is not safe
at all (from priority inheritance point of view).

Did anybody experiences issues like this before?
Are there any solutions / workarounds available (for example by avoiding using
conditional variables and using PI mutexes instead)?

> It might be that it has nothing to do with the mutex, this is just my guess.
>
> Has anybody seen similar issues before?
>
> Best regards,
> Ronny


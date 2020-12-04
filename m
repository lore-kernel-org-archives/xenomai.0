MIME-Version: 1.0
References: <CAMjL99LXt2oK+sMzhAiaed_FJj--CgaFRWhEFWT4j_yQSiz9cw@mail.gmail.com>
 <aa8ee28c-bf74-d936-0c15-1b424b781e7b@siemens.com>
In-Reply-To: <aa8ee28c-bf74-d936-0c15-1b424b781e7b@siemens.com>
From: John Ho <johnho26@gmail.com>
Date: Fri, 4 Dec 2020 15:04:57 +0100
Message-ID: <CAMjL99KuRaa8PD_Vfbyg6R++aLDphQAuHthtQ0Z4=W2k7BM73A@mail.gmail.com>
Subject: Re: Pthread_mutex_lock
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Hi there Jan,
Thank you for your fast response
I am not too sure if i understood what you mean by compiling against
Xenomai.
Within my cmake I have attached the Xenomai's config, Posix Libraries and
directories
I have also added in a line to locate Xenomai's Pthread.h .


On Thu, Dec 3, 2020 at 8:31 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 03.12.20 17:39, John Ho via Xenomai wrote:
> > Hi all, I wish to ask about this error I am getting from
> > pthread_mutex_lock. I created a wrapper for SOEM and was trying to get
> this
> > wrapper to check on my ethercat slaves, however after running the
> wrapper,
> > I received an error stating :
> >
> > terminate called after throwing an instance of
> >
> 'boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::lock_error>
> >> '
> >   what():  boost: mutex lock failed in pthread_mutex_lock: Operation not
> > permitted
> >
> > After checking through what it was doing in GDB,
> >
> > #0  __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:51
> > #1  0x00007ffff574d8b1 in __GI_abort () at abort.c:79
> > #2  0x00007ffff6140957 in ?? () from
> > /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> > #3  0x00007ffff6146ae6 in ?? () from
> > /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> > #4  0x00007ffff6146b21 in std::terminate() () from
> > /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> > #5  0x00007ffff6146d54 in __cxa_throw () from
> > /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> > #6  0x00007ffff734e324 in void
> > boost::throw_exception<boost::lock_error>(boost::lock_error const&)
> > () from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #7  0x00007ffff734d093 in boost::mutex::lock() ()
> >     from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #8  0x00007ffff734e8c9 in boost::unique_lock<boost::mutex>::lock() ()
> >   from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #9  0x00007ffff734e6e1 in
> > boost::unique_lock<boost::mutex>::unique_lock(boost::mutex&) ()
> >     from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #10 0x00007ffff735f474 in (anonymous
> > namespace)::heartbeatMonitor(boost::mutex&, bool&) ()
> >     from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #11 0x00007ffff736287f in void
> > boost::_bi::list2<boost::reference_wrapper<boost::mutex>,
> > boost::reference_wrapper<bool> >::operator()<void (*)(boost::mutex&,
> > bool&), boost::_bi::list0>(boost::_bi::type<void>, void
> (*&)(boost::mutex&,
> > bool&), boost::_bi::list0&, int) ()
> >     from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #12 0x00007ffff73627fe in boost::_bi::bind_t<void, void
> (*)(boost::mutex&,
> > bool&), boost::_bi::list2<boost::reference_wrapper<boost::mutex>,
> > boost::reference_wrapper<bool> > >::operator()() ()
> >   from /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #13 0x00007ffff73627b0 in
> > boost::detail::thread_data<boost::_bi::bind_t<void, void
> (*)(boost::mutex&,
> > bool&), boost::_bi::list2<boost::reference_wrapper<boost::mutex>,
> > boost::reference_wrapper<bool> > > >::run() () from
> > /home/john/Documents/SOEMWRAPPER/build/libsoem_wrapper.so
> > #14 0x00007ffff6eccbcd in ?? () from
> > /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.65.1
> > #15 0x00007ffff77936db in start_thread (arg=0x7ffff4f0b700) at
> > pthread_create.c:463
> >
> > Is there a way for me to resolve this issue?
> >
>
> Is your wrapper compiled against Xenomai, redirecting pthread_mutex_lock
> to the Xenomai implementation in libcobalt? Then EPERM from such a call
> means that the caller is not a Xenomai thread, i.e. pthread_create was
> called directly against libc, rather than being redirected to libcobalt.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>

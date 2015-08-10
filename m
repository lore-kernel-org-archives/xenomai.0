MIME-Version: 1.0
In-Reply-To: <55C8BCDD.5000501@xenomai.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
 <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
 <55C8BCDD.5000501@xenomai.org>
Date: Mon, 10 Aug 2015 11:17:57 -0400
Message-ID: <CAHoW4hFio_SG9knzKD5AG_3UOiNCf5KhrioZOAHOd0jVGVOrMA@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> Is this case (trying to create an event flag with a conflicting name)
> part of the original scenario with Cobalt?

This rt_event_create() with existing name occurs a little earlier in
my application's startup phase than where the segfault occurs using
Cobalt.  However, applying the rt_event_bind() workaround and
switching back to Cobalt does not change the segfault behavior (it
still occurs at the same place), so I'm not convinced that they're
related.

When I run the processes through Valgrind using the Mercury core and
checking event existence with rt_event_bind() before attempting to
create, Valgrind finds no issues.  The application hangs at a
different location (creation of a periodic task; I'm fairly certain
that I just need to rework that section of code a little).

However, my application really need the tight timings that Cobalt
provides, and this has to eventually run on an embedded system, so
switching to Mercury is not a viable solution.


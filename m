MIME-Version: 1.0
In-Reply-To: <55CC7C2F.5040805@xenomai.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
 <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
 <55C8BCDD.5000501@xenomai.org>
 <CAHoW4hFio_SG9knzKD5AG_3UOiNCf5KhrioZOAHOd0jVGVOrMA@mail.gmail.com>
 <55CC7C2F.5040805@xenomai.org>
Date: Thu, 13 Aug 2015 07:39:44 -0400
Message-ID: <CAHoW4hFqOT=o10R8w-qxoHti1=aE5HLOohQvk7xk-PGD+_=XKQ@mail.gmail.com>
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

Hello Philippe,
I have spent the past few days stressing my application and trying to
get the problem to reproduce, so that I could better debug it and
provide more information.  However, my current configuration seems to
be fixed.

I made three changes (still using rc6):
1 - Fixed the small bug mentioned in your first patch in this thread
2 - Reordered event creation logic so that rt_event_bind() is used to
check existence before rt_event_create() is called
3 - Increased the heap sizes in the kernel configuration again
(system=1024, shared=256, private=256)

These changes have me up and running on an x86 system.

> You should retry with the current head of the -next branch with Cobalt.
I'll switch to the -next branch and continue testing.  I'm also doing
an ARM port of the app, and was having some small problems with shared
heap initialization, so maybe I can resume work there.

Thanks for all your help!

-Charles


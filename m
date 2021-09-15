MIME-Version: 1.0
References: <CAJte2PCq9wdgeN8AA=dfRxewhe+61UgRY=ecqG-y_wXXQ+0c2w@mail.gmail.com>
 <87k0jnh8lt.fsf@xenomai.org>
In-Reply-To: <87k0jnh8lt.fsf@xenomai.org>
From: Byron Jacquot <bjacquot@cardinalpeak.com>
Date: Tue, 14 Sep 2021 18:33:52 -0600
Message-ID: <CAJte2PCS3F1nG1Exgqj9nJUw8SOKuY_h2R7e5H3JFb0XWO=rcA@mail.gmail.com>
Subject: Re: EVL Semaphore Open Question
Content-Type: text/plain; charset="UTF-8"
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

Hello Philippe,

Thank you for the pointers.

I've tracked down what was wrong.  Even though it's repeated in the
documents several places, I'd forgotten that evl_attach_self() makes an
implicit call to evl_init().  As the application matured, things got
rearranged such that resources that were previously created OOB were being
created by IB threads.

Initializing the library first solves everything.  I can tie together a
data pipeline with one process creating a public semaphore, and another
opening that semaphore, without the extra attach/detach.

Thanks!

Byron Jacquot

On Sat, Sep 11, 2021 at 1:30 AM Philippe Gerum <rpm@xenomai.org> wrote:

>
> Byron Jacquot via Xenomai <xenomai@xenomai.org> writes:
>
> > Hello Everyone,
> >
> > I'm working on growing some EVL proof-of-concept applications to come
> > closer to the end application.
> >
> > I want to build a multicore processing pipeline by connecting out-of-band
> > threads with semaphores.  The EVL Function Index [1] marks the semaphore
> > creation & open functions as being available for in-band calls.
> >
> > It appears that I'm unable to call them in-band - evl_new_sem() returns
> "No
> > such device or address."  evl_open_sem() segfaults.
>
> evl_new_sem() can definitely be called from the in-band context, this is
> actually the recommended way. You may want to have a look at [1], this
> is an example from the test suite.
>
> As documented at [2], all these services require a preliminary call to
> evl_init() in order to attach the application process to the
> core. -ENXIO is the sign that this call did not happen before
> evl_new_sem() was issued. The -ENXIO error code for evl_new_sem() is
> documented at [3].
>
> evl_open_sem() gives access to an existing semaphore, local or created
> by a remote process. It should have detected the lack of evl_init()
> call, and returned -ENXIO as well; this is going to be fixed and
> available from r27.
>
> You may want to have a look at the test suite in tests/ for examples of
> API usage. How to run these examples is documented at [4].
>
> >
> > As a workaround, the creating thread (an in-band management thread that
> > ideally creates and manages the OOB resources) can temporarily attach to
> > EVL, do the creation operation, then detach.
> >
> > Do I understand the information in the function index correctly?  Is
> there
> > a recommended best practice for managing EVL resources from an in-band
> > thread?
> >
> > I can cut code down to a brief example if that would help.
> >
> > [1]https://evlproject.org/core/user-api/function_index/
> >
> > Thank you,
> >
> > Byron Jacquot
>
> [1]
> https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tests/sem-wait.c
> [2] https://evlproject.org/core/user-api/init/
> [3] https://evlproject.org/core/user-api/semaphore/#semaphore-services
> [4] https://evlproject.org/core/testing/
>
> --
> Philippe.
>

MIME-Version: 1.0
References: <CAF06wtj2YM_Ue0Hzw5+LChWtve_3ta390aAu0CixsCQd+12bwg@mail.gmail.com>
 <04c0f132-1d4a-4c7e-c273-56d09da07696@xenomai.org>
 <CAF06wthvmQ6R=i+dsM2gnYQp74MJxmwgeGnk2LhKwFXCS88eUw@mail.gmail.com>
In-Reply-To: <CAF06wthvmQ6R=i+dsM2gnYQp74MJxmwgeGnk2LhKwFXCS88eUw@mail.gmail.com>
From: "Stephen D. Cohen" <steve@uscohens.com>
Date: Sat, 02 Sep 2017 03:43:56 +0000
Message-ID: <CAO460__UFSJ4MMGsMthASEmxWQZeEcoUkX9NkMfOGQiQYuOaqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Issues building old drivers under Xenomai 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Mr. Langston,

     You have to provide the memory block which conforms to the
requirements outlined in the documentation for xnheap_init. One place you
can find an example of using an xnheap is in the ipc drivers. The bind
routines in those drivers all use xnheap to manage private heaps for the
interfaces.

Regards,

Steve Cohen



On Fri, Sep 1, 2017 at 5:33 PM Jim Langston <jim.langston@gmail.com> wrote:

> Philippe,
>
> I'm looking at the documentation for the xnheap* functions, and inserted
> them into the code to replace the exising rt_heap* functions.  While it
> compiles, it does not work and panics.
>
> The offending call is the init function:
>
> int xnheap_init ( struct xnheap *  *heap*, void *  *membase*, u32  *size*
> )
>
> From looking at the documentation, what is the function of the "membase"
> parameter, and what should I put in for its value?  Zero or NULL doesn't
> work, but I have no idea what to pass to it -- is it something I get from
> another function call, a fixed value, or what?
>
> Thanks,
> Jim
>
> On Wed, Aug 30, 2017 at 3:20 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>
> > On 08/30/2017 03:17 AM, Jim Langston wrote:
> > > Hi all,
> > >
> > > I'm having trouble getting an old driver originally built for Xenomai
> 2.4
> > > to build under Xenomai 3.0.5.  The code won't build under Ubuntu 16.04
> > > patched with Xenomai 3.0.5 and kernel 4.9.24 and the IPipe patch for
> > 4.9.24.
> > >
> > > The problem seems to revolve around include pathing, and the simplest
> > case
> > > I can put together is as follows:
> > >
> >
> > <snip>
> >
> > > Does anyone have a driver that they could post up that uses the heap
> > > functions, a sample 'Makefile' with different flags/include options, or
> > any
> > > suggestions on how to resolve the include file mess here?
> > >
> >
> > The former "native" API of Xenomai 2.x is no more available in kernel
> > space with Xenomai 3.x, as hosting application code there is discouraged.
> >
> > With the latter, the only kernel space API is RTDM, for writing drivers.
> > If you need a real-time allocator in kernel space to ease your port,
> > there is still the option of tapping into the Cobalt core inner
> > interface, using the xnheap_* services.
> >
> > --
> > Philippe.
> >
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>

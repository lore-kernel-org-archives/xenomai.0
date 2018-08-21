MIME-Version: 1.0
References: <CAOuPNLgkFZ7wwBM2N3HXYSh0fkGce8GytJdKHnbsmBN4zfwcFg@mail.gmail.com>
 <CAOuPNLiXWVRRpn_39VfakbSHZH4K8Vc9wM8aRrgpwhAqtYZFoQ@mail.gmail.com>
 <CALLqZ8QVh2dtRe13PudQ2n1bGm2ZheO9d4Hp4TWVNrcXYrNyow@mail.gmail.com>
 <CAOuPNLipXN+iji4m91kkpegBYy_2q8BXyp2LRtLfXdA2j9No1Q@mail.gmail.com>
 <CALLqZ8QpWDnvGkKUGV7BYCXRw_ebxTq7+y7zGC973NqqFaYekA@mail.gmail.com>
In-Reply-To: <CALLqZ8QpWDnvGkKUGV7BYCXRw_ebxTq7+y7zGC973NqqFaYekA@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 21 Aug 2018 13:39:14 +0530
Message-ID: <CAOuPNLjHXLi6OsS9eqvqD-Fc7t7aHbA4kz31zoyrbF5KLVqxEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] message pipe stream test application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Greg,

For your information, I already implemented sample application using
message pipe read/write API over RTIPC.
For the reference I saw lib/alchemy/testsuite/pipe-1.c

But now I wanted to use rt_pipe_stream and understand how it work.
Mainly what is the real difference between rt_pipe_write and
rt_pipe_stream, and how to implement such difference.
According to my experiment, both behaves almost the same for me.

I have read the description about rt_pipe_stream in the documentation.
I tried to implement the similar logic, but behavior is not same for me.

My understanding is that:
Regular thread keeps writing one by one char to rtipc, and the real-time
task reads one char at a time. Then real-time task call rt_pipe_stream
which keeps storing all the characters until read is called.

Finally, when regular thread calls "read" then all the data from
stream will be read by the regular thread at once.

I implemented it in similar way, but in the end regular thread could
read only one char (first char) in the end.


Thanks,
Pintu
On Tue, Aug 21, 2018 at 12:12 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>
> On Mon, Aug 20, 2018 at 2:02 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> > May be both.
> > Specially I want to know how to use may use of rt_pipe_steam with a use case
> > example.
> >
> >
> > On Mon, 20 Aug 2018, 10:10 pm Greg Gallagher, <greg@embeddedgreg.com> wrote:
> >>
> >> On Mon, Aug 20, 2018 at 9:48 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> >> > Dear Greg,
> >> >
> >> > If you have any idea can you please explain how rt_pipe_stream works
> >> > with an example.
> >> > I need to prepare a demo, to demonstrate the usefulness of
> >> > rt_pipe_stream API.
> >> >
> >> >
> >> > Thanks,
> >> > Pintu
> >> > On Fri, Aug 17, 2018 at 6:56 PM Pintu Kumar <pintu.ping@gmail.com>
> >> > wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> I wanted to understand how rt_pipe_stream works and how it can be
> >> >> useful.
> >> >> I wanted to create a demo application using it.
> >> >> But currently I could not figure out how to make use of it.
> >> >>
> >> >> I saw a sample pipe application under: lib/alchemy/testsuite/pipe-1.c.
> >> >> Based on this I am trying to create a new application that uses
> >> >> rt_pipe_stream.
> >> >> The rt_pipe_stream is working fine, but I wanted to test the scenario
> >> >> based on its description.
> >> >>
> >> >> My understanding is that:
> >> >> Regular thread keeps write one by one char to rtipc, and the real-time
> >> >> task reads one char at a time. Then real-time task call rt_pipe_stream
> >> >> which keeps storing the char.
> >> >> Finally, when regular thread calls "read" then all the data from
> >> >> stream will be read by the regular thread at once.
> >> >>
> >> >> Hope my understanding is correct.
> >> >> I want to prepare a sample application for the same.
> >> >>
> >> >> If any reference for rt_pipe_stream is available please let me know.
> >> >>
> >> >>
> >> >> Thanks,
> >> >> Pintu
> >> >
> >> > _______________________________________________
> >> > Xenomai mailing list
> >> > Xenomai@xenomai.org
> >> > https://xenomai.org/mailman/listinfo/xenomai
> >>
> >> HI,
> >>   Do you want an explaination how they worked in cobalt or an
> >> exaplaination of how to use them?
> >>
> >> Thanks
> >>
> >> Greg
>
> Start here:
>
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__pipe.html#ga29521cc898afa0069963964955167aa5
>
> I'll see what I can for an example.
>
> -Greg


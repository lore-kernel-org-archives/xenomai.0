MIME-Version: 1.0
In-Reply-To: <55E60743.30600@xenomai.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
 <55E60743.30600@xenomai.org>
Date: Tue, 1 Sep 2015 17:43:50 -0700
Message-ID: <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 1, 2015 at 1:14 PM, Jorge Ramirez Ortiz <jro@xenomai.org> wrote:

>
>
> > This latency seems high for such class of hardware, especially with no
> > load. We'll need the tracer to dig this too.
> >
>
> Don mentioned that the trace is not ready yet.
>

I updated the branches on our server:
xenomai - arm64
ipipe - ipipe-3.14.44-arm64

These branches are base on the branches of the same names created on
xenomai.org (Thanks Philippe). Added are a few changes required for ipipe
tracing.

For function tracing, a couple changes were required to be cherry picked
from 3.18.

I can submit our changes as pull requests over the next few days. In the
mean time, the changes are available for review.

-Don

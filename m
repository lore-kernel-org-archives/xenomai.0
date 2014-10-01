MIME-Version: 1.0
In-Reply-To: <542C789F.4090309@xenomai.org>
References: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
 <20141001213611.GI4435@csclub.uwaterloo.ca>
 <542C789F.4090309@xenomai.org>
Date: Thu, 2 Oct 2014 01:09:49 +0300
Message-ID: <CANgF67TsCRkEsfior411TXfb=4bctx0AZa4jePPzNNd6mCX61g@mail.gmail.com>
From: agnes jurek <agnessjurek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] nucleus/sched.h: No such file or directory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2014-10-02 0:56 GMT+03:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On 10/01/2014 11:36 PM, Lennart Sorensen wrote:
> > On Thu, Oct 02, 2014 at 12:27:34AM +0300, agnes jurek wrote:
> >> I tried to write simple code myself using xenomai rtdm module. When I
> added
> >> "
> >> #include <xenomai/rtdm/rtdm.h>", compilation  was ok. But when I added "
> >> #include <xenomai/native/task.h>", I got an error message. It said that
> >> "/usr/include/xenomai/native/task.h:25:27: fatal error:
> nucleus/sched.h: No
> >> such file or directory
> >> compilation terminated."
> >
> > Xenomai unfortunately requires you to add /usr/include/xenomai to your
> > includes,
>
> Why is is unfortunate, if I may ask? It also depends on how you run the
> configure script, you get includes in /usr/include/xenomai if you passed
> --includedir=/usr/include/xenomai
>
>
> --
>                                                                 Gilles.
>


I installed xenomai using below page, configured same options,same versions
on there. Also I run "xeno latency",the output is nice.

http://xenomai.org/2014/06/building-debian-packages/

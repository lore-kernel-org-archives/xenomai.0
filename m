Date: Thu, 28 Apr 2016 12:52:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160428105236.GA10481@hermes.click-hack.org>
References: <CAJ2oMhL_wa5vNe=ujt7GDUM1q3GOmWsCUGv6t_pVfH+oJZkX7A@mail.gmail.com>
 <CAJ2oMh+1yKWqQXWHoQELsD731xDGWWjiYvWNSXv5Nc=1Ky5xSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+1yKWqQXWHoQELsD731xDGWWjiYvWNSXv5Nc=1Ky5xSQ@mail.gmail.com>
Subject: Re: [Xenomai] Communication between RT-kernel to non-RT kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 08:37:17AM +0300, Ran Shalit wrote:
> On Thu, Apr 28, 2016 at 7:44 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> > Hello,
> >
> > I am new with xenomai.
> >
> > I've made a lot of reading in the documentation which is very helpful.
> > But I haven't found how to communicate between rt kernel to non-rt
> > kernel on same machine,
> > Is there any example or documantation which explains this ?
> >
> > Best Regards,
> > Ran
> 
> I guess that there is actually no need for such example or documentation.
> In userland 2 applications, one using xenomai kernel and the other
> linux kernel can commuicate
> in any method available in Linux between processes (pipes, shared
> memeory, etc) . Right?

Not quite. Accessing a pipe from a xenomai thread will cause it to
switch to secondary mode, IOW to migrate to the Linux kernel.

The IPC adapted to communicated between Xenomai threads and plain
Linux threads is XDDP, see the API documentation here:
https://xenomai.org/api-reference/

-- 
					    Gilles.
https://click-hack.org


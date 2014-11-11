MIME-Version: 1.0
In-Reply-To: <20141111174147.GJ17476@sisyphus.hd.free.fr>
References: <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141111171242.GG17476@sisyphus.hd.free.fr>
 <CAJt3u5ky2PPjNrpsasy1FY3VjaHwkYGuW1FK=fH_x6uRD9eoow@mail.gmail.com>
 <20141111172750.GH17476@sisyphus.hd.free.fr>
 <CAJt3u5nCQbJJmPoLuQq-2U_1P6cPiQCpoROrp=uK7Jv0UCf25Q@mail.gmail.com>
 <20141111174147.GJ17476@sisyphus.hd.free.fr>
Date: Tue, 11 Nov 2014 23:14:21 +0530
Message-ID: <CAJt3u5m2qwSXJ=nORJjb5vSg_85LS2fgdGg3PDYs_LTbPi-Dmg@mail.gmail.com>
From: Madan Sondur <sondur.madan23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
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

Thanks Gilles
On 11 Nov 2014 23:11, "Gilles Chanteperdrix" <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Nov 11, 2014 at 11:02:05PM +0530, Madan Sondur wrote:
> > Thanks for the info Gilles, can you give me a start point if I have to
> > implement the driver for xenomai ?
>
> You should start here:
> http://xenomai.org/start-here/
>
> To understand better a bit about Xenomai (and answer the question,
> do I really need Xenomai dual-kernel). If you do not really need
> working with Xenomai dual-kernel, then don't.
>
> Otherwise, a good reference to start writing Linux drivers is "Linux
> device drivers", which you can find here:
> https://lwn.net/Kernel/LDD3/
>
> The book is a bit outdated now, so, do not focus on the APIs,
> rather, focus on the general principles, because they do not change.
>
> Then you should start writing your driver using the RTDM API,
> documented here for Xenomai 2.X:
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtdm.html
> Or here for Xenomai 3.0:
>
> http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm.html
>
> You can use as examples the drivers in Xenomai sources
> (directory ksrc/drivers in Xenomai 2.x, or kernel/drivers in Xenomai 3).
>
> --
>                                             Gilles.
>

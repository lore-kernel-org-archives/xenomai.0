MIME-Version: 1.0
In-Reply-To: <20141111172750.GH17476@sisyphus.hd.free.fr>
References: <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141111171242.GG17476@sisyphus.hd.free.fr>
 <CAJt3u5ky2PPjNrpsasy1FY3VjaHwkYGuW1FK=fH_x6uRD9eoow@mail.gmail.com>
 <20141111172750.GH17476@sisyphus.hd.free.fr>
Date: Tue, 11 Nov 2014 23:02:05 +0530
Message-ID: <CAJt3u5nCQbJJmPoLuQq-2U_1P6cPiQCpoROrp=uK7Jv0UCf25Q@mail.gmail.com>
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

Thanks for the info Gilles, can you give me a start point if I have to
implement the driver for xenomai ?
On 11 Nov 2014 22:57, "Gilles Chanteperdrix" <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Nov 11, 2014 at 10:54:03PM +0530, Madan Sondur wrote:
> > I am expecting a real time USB3.0 driver which can work at full speed and
> > with low latency in xenomai. Or am I missing something in
> > understanding. ?
>
> Throughput and latency are generally mutually exclusive. You can not
> have both. And with Xenomai on USB 3.0 you will not get either,
> because I do not know any USB 3.0 driver for Xenomai. So, if you
> just expect the driver to happen if you do not write it, you can
> expect it a long time.
>
> --
>                                             Gilles.
>

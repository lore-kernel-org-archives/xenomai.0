From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 11 Nov 2014 23:25:11 -0500
Message-ID: <20141112042511.GG24110@csclub.uwaterloo.ca>
References: <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141111171242.GG17476@sisyphus.hd.free.fr>
 <CAJt3u5ky2PPjNrpsasy1FY3VjaHwkYGuW1FK=fH_x6uRD9eoow@mail.gmail.com>
 <20141111172750.GH17476@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111172750.GH17476@sisyphus.hd.free.fr>
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

On Tue, Nov 11, 2014 at 06:27:50PM +0100, Gilles Chanteperdrix wrote:
> Throughput and latency are generally mutually exclusive. You can not
> have both. And with Xenomai on USB 3.0 you will not get either,
> because I do not know any USB 3.0 driver for Xenomai. So, if you
> just expect the driver to happen if you do not write it, you can
> expect it a long time.

Certainly USB defines high priority transfers (like interrupt messages)
which have timing promises, but are very small and have limited bandwidth,
and then they define bulk transfers which do not have latency promises,
but get high bandwidth.  So even USB says you can have one or the other,
but probably not both.

-- 
Len Sorensen


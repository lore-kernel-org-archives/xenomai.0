Date: Tue, 11 Nov 2014 18:33:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111173349.GI17476@sisyphus.hd.free.fr>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJt3u5ky2PPjNrpsasy1FY3VjaHwkYGuW1FK=fH_x6uRD9eoow@mail.gmail.com>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Madan Sondur <sondur.madan23@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Nov 11, 2014 at 10:54:03PM +0530, Madan Sondur wrote:
> I am expecting a real time USB3.0 driver which can work at full speed and
> with low latency in xenomai. Or am I missing something in understanding. ?

Of course it depends on what you mean by "full speed". If you are
talking about USB 1.0 "full speed", i.e. 12 Mbps, you may have some
luck with the usb4rt project:

http://sourceforge.net/projects/usb4rt.berlios/

-- 
					    Gilles.


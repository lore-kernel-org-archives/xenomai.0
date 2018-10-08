From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Mon, 08 Oct 2018 20:49:55 +0200
Message-ID: <29051082.nZQKAztGnQ@lenni>
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819FA9@DDCEXCH.ddc-ny.com>
References: <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819D8C@DDCEXCH.ddc-ny.com>
 <3016131.PUnFZZDcdA@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819FA9@DDCEXCH.ddc-ny.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Does RTNET supports TCP?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "steven.seeger@nasa.gov" <steven.seeger@nasa.gov>, "Hillman,
 Robert" <hillman@ddc-web.com>

Hi,

Pham, Phong wrote:
> Thanks and looking for your fix.  Actually the compilation is probably
> a trivial fix for you; however, since I have no familiarity of the
> code at this moment, could you provide the instruction on how to
> modify the code to make it compilable?

That will not help you much. Listening to a socket also fails. And if I 
would provide you also with a quick fix for that bug a null pointer 
exception will hit you when your application calls connect(). So please 
have a little more patience. Fixing all of those bugs together in a 
patch set  makes a lot of sense.

> I am still in the early
> process of establishing a connection so I can work out any further
> issues while waiting for your official fix (which includes several
> other bugs)?  Thanks.

 
> Hi Steven,
> 
> You wrote:
> 
> > Try SOCK_DGRAM and see if it
> > works. If not, then are you sure you have rtnet drivers for your
> > network device compiled and ready to use? Remember, the driver for
> > your network device must be realtime-safe.
> 
> 
> My current network device driver is actually working because it is the
> one provided/ported by Xenomai (even though I did have to modify the
> buffer size on one of the buffers).  In fact, I am able to ping to
> successfully (but ping uses ICMP).  I need TCP because our current
> application (VxWorks based) accesses a FTP server to retrieve files
> and I would like to maintain that resemblance in Linux.  What I don't
> need is the real-time functionality.

Hm ... then why don't you fetch your files in non-realtime context? This 
would be much easier I suppose.

-- 
Sebastian





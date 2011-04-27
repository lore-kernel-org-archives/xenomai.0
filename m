From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
	<1303849652.1961.7.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Apr 2011 23:42:38 +0200
Message-ID: <1303940558.1932.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dietmar.schindler@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2011-04-27 at 14:22 +0200, dietmar.schindler@domain.hid
wrote:
> > From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid]
> > On Behalf Of dietmar.schindler@domain.hid
> > Sent: Wednesday, April 27, 2011 10:50 AM
> > 
> > > From: xenomai-help-bounces@domain.hid
> > > On Behalf Of Philippe Gerum
> > > Sent: Tuesday, April 26, 2011 10:28 PM
> > >
> > > ...
> > > One read() per rt_pipe_write() operation, always.
> > 
> > Thank you for your answer. Is "One readv() per rt_pipe_write()
> > operation" supposed to be true also, or is there something special to
> be
> > taken into consideration regarding readv(2)?
> 
> Meanwhile, I found some facts which allow me to elaborate on my
> question. The rtpipe device hasn't a readv file operation implemented,
> so the kernel substitutes the readv call by a series of read calls to
> the device driver; due to this, under certain circumstances readv(2)
> gathers more than a single rt_pipe_write() call's data. (I can provide
> an example case, if desired.) Wouldn't it be desirable to implement the
> readv file operation in the rtpipe driver so that the guarantee "One
> read() per rt_pipe_write()" could cover readv(2) also?

No objection to merge this. Patch welcome.

>  (Besides, this
> would make the phrase "Operates just like read" in the readv(2) man page
> more correct.)

Having readv() operate like read() would not give any guarantee wrt
message boundaries, because it is the real-time write side which makes
the decision regarding this, not the read side. So you could have
readv() operate like read() and still have blurred boundaries in case
rt_pipe_stream() is used instead of rt_pipe_write().

-- 
Philippe.




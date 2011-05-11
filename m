From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF179C957@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
	<1303849652.1961.7.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz>
	<1303940558.1932.33.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz>
	<1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>
	<4DBFE062.3020902@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>
	<4DC03CE8.4050608@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>
	<4DC0F4E0.2070707@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174EA21@domain.hid>
	<4DC25C69.5020001@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174ECBA@AREXCH02.mra.roland-man.biz>
	<4DCA52E8.80904@domain.hid> <1305105644.2098.17.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF179C957@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 13:02:06 +0200
Message-ID: <1305111726.2098.30.camel@domain.hid>
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

On Wed, 2011-05-11 at 12:48 +0200, dietmar.schindler@domain.hid
wrote:
> > From: Philippe Gerum [mailto:rpm@xenomai.org]
> > Sent: Wednesday, May 11, 2011 11:21 AM
> > ...
> > Also, let's avoid constructs like these:
> > 
> > >                       buf = iovec->iov_base, count = iovec++->iov_len;
> > 
> > Disk space is cheap so we can afford a few more characters per line;
> > ...
> 
> Could you please explain what you mean by this? I can imagine to put a few more characters into the line above by changing it to
> 
> 	buf = iovec->iov_base, count = iovec->iov_len, ++iovec;
> 
> but this would seem to contradict your recommendation below.

	buf = iovec->iov_base;
	count = iovec->iov_len;
 	++iovec;

One exec statement per line, no comma operator, no combined
post-incrementation and dereference to obfuscate the obvious, because we
don't care about a few more characters in the source code: we do want
readability. Plain, silly, massively non-imaginative obviousness of
constructs.

> 
> > In short, one executable statement per line is desired, our code should
> > have nothing to hide.
> 
> Since the above code line contains only one statement, I assume you mean one assignment-expression, and will do accordingly.
> 
> By the way, what is your convention regarding goto?

Absolutely fine to use it for handling error paths sanely without code
duplication, and anywhere it would spare us weird games based on
obfuscated variable updates and tests only to control the code flow.

-- 
Philippe.




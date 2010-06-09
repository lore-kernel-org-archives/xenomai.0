Message-ID: <4C0F97DA.3050501@domain.hid>
Date: Wed, 09 Jun 2010 15:32:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilEKG3zHL2p7jqkZlTqBDKXs7gXApmcaNQDxHZa@domain.hid>
In-Reply-To: <AANLkTilEKG3zHL2p7jqkZlTqBDKXs7gXApmcaNQDxHZa@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Why are open_rt,
	close_rt and socket_rt deprecated?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> Hi,
> 
> Since moving to Xenomai 2.5.3 I have noticed that loading one of our
> kernel drivers leads to a warning about open_rt and close_rt, stating
> that they are deprecated and the drivers require update.  I am sure
> there is a good reason for this, but I haven't found an explanation in
> the Xenomai documentation (API / The Real-Time Driver Model and First
> Applications) or on the mailing lists (help / core), or anywhere else
> (Google).

The issue has been discussed at length on the xenomai-core mailing list.

> 
> I can re-write the driver so that it doesn't use open_rt / close_rt
> without affecting the applications that use it, but I am curious as to
> why using them is a bad idea? Is it just because loading / unloading a
> driver does not take a deterministic time, and therefore should not be
> considered real-time?

If your driver defines an _rt and an _nrt callback for open and close,
what particular callback is used depends on the current mode. The
problem is that this is unreliable.

Even if you think you forced the mode you wanted before calling open or
close, this mode can change due to an asynchronous event such as a
fault, a signal, or because you are running under gdb. There was an
attempt to make this working reliably, but it was reverted after a long
discussion.

And since having primary mode only open and close syscalls is not really
necessary, it was decided to deprecate open_rt and close_rt.


-- 
					    Gilles.


Date: Fri, 5 Aug 2011 17:58:22 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110805155822.GA15241@domain.hid>
References: <20110805133006.GA2945@domain.hid>
	<4E3BF8BF.6080609@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E3BF8BF.6080609@domain.hid>
Subject: Re: [Xenomai-help] Using plain old POSIX shm_open with real time
 threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Aug 05, 2011 at 04:05:51PM +0200, Gilles Chanteperdrix wrote:
> 
> Now the armv5 details: xenomai posix skin shared memories are uncached.
> plain linux shared memories are uncached when using fcse in guaranteed
> mode, and cached when using fcse in best effort mode or without fcse,
> but will trigger a cache flush when exiting the process where they are
> mapped. They are also uncached when mapped twice at two different
> addresses by the same process.

Thanks for the very thorough answer!

(Currently, I am working on a PowerPC project, happily ;)

> Shared memories are not really an IPC, since they do not take care of
> synchronization as other IPCs will do. However, for a fifo, this looks
> sufficient. A fifo without synchronization, however, will only take care
> of one producer and one consumer.

Yes, that is what I am doing.

Thanks,

Richard


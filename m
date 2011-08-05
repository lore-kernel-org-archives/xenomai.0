Message-ID: <4E3BF8BF.6080609@domain.hid>
Date: Fri, 05 Aug 2011 16:05:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110805133006.GA2945@domain.hid>
In-Reply-To: <20110805133006.GA2945@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On 08/05/2011 03:30 PM, Richard Cochran wrote:
> Dear xenomai people,
> 
> I would like to have a shared ram fifo between a normal Linux program
> and a xenomai program that uses the POSIX skin. Can I simply use
> __raw_shm_open and __raw_mmap in the xenomai thread, or would there be
> some penalty or bad side affect on the RT thread?

Hi Richard,

You can use shm_open/mmap, but leave out xenomai posix skin shared
memories in kernel configuration: in this case, the __real_ variants
will be used. The only interest of the xenomai posix skin shared
memories is that they allow sharing memory between kernel and user.

Now the armv5 details: xenomai posix skin shared memories are uncached.
plain linux shared memories are uncached when using fcse in guaranteed
mode, and cached when using fcse in best effort mode or without fcse,
but will trigger a cache flush when exiting the process where they are
mapped. They are also uncached when mapped twice at two different
addresses by the same process.

> 
> I see that the documented way for RT/non-RT IPC is the message
> pipe. Perhaps you could comment on the pros/cons of using it, compared
> with my shared memory idea.

Shared memories are not really an IPC, since they do not take care of
synchronization as other IPCs will do. However, for a fifo, this looks
sufficient. A fifo without synchronization, however, will only take care
of one producer and one consumer.

-- 
					    Gilles.


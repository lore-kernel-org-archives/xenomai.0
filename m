Date: Thu, 7 Jul 2011 09:31:24 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110707073124.GC3467@domain.hid>
References: <CAOiXNkDLimRNcf1xwnJoMCx=Q3a87Pp9=_bsuN5DizKoGs7Xzg@domain.hid>
	<4E144591.6010906@domain.hid>
	<CAOiXNkARoeBWpSRQtkh8OLye3AYGtX8qcD1-K-zNO8ooPW0sBA@mail.gmail.com>
	<4E1452E3.4010107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E1452E3.4010107@domain.hid>
Subject: Re: [Xenomai-help] Communication between RT and non-RT thread
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
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, Jul 06, 2011 at 02:19:47PM +0200, Gilles Chanteperdrix wrote:
> On 07/06/2011 01:42 PM, Andrey Nechypurenko wrote:
> > 
> > What makes me worry here is the IPC abbreviation - I have just one
> > process with multiple threads. So would not real IPC mechanism be the
> > overkill in this scenario? Or am I just misinterpret what IPC means
> > here?

...

> 
> I am talking about the ring buffer thing with head and tail pointers
> where each thread (consumer, producer), moves only one pointer. I would
> call this a "lockless fifo", though I do not know what the official name
> is, but you get the idea. Again, you can send pointers through an IPC
> instead of sending the data themselves, and you will benefit from the
> fact that the two threads are running in the same memory space.

In Andrey's case, I would simply use a ring buffer (fifo) shared
between one RT and one non-RT thread. No locking is needed, and it is
easy to implement. You don't need a library for that.

HTH,

Richard


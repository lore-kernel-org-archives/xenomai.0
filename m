Message-ID: <2ff1a98a0802220100x62fa0f15o25735f11d27ed296@domain.hid>
Date: Fri, 22 Feb 2008 10:00:06 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200802212145.31122.ngustavson@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200802202358.25792.ngustavson@domain.hid>
	<200802210944.56033.ngustavson@domain.hid>
	<47BD9763.1040304@domain.hid>
	<200802212145.31122.ngustavson@domain.hid>
Subject: Re: [Xenomai-help] writing from user space through fifo problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <metalninjadragon@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Fri, Feb 22, 2008 at 3:45 AM, NZG <metalninjadragon@domain.hid> wrote:
> On Thursday 21 February 2008 10:23:15 am Jan Kiszka wrote:
>  > That's good. This test will also allow you to check it against
>  >  - more recent Xenomai (please check the Changelog for pipe-related
>  >    changes since 2.3.1, I bet there are a few)
>  >  - some other arch, specifically x86 (IIRC, there is still some Linux
>  >    scheduling artifact left in the I-pipe patch for blackfin, but it
>  >    shouldn't make a difference here - well, who knows...)
>  Well, in the process of writing a simple test I kindof found the problem.
>  My user space program is writing and then immediatly closing, which appears to
>  destroy the data if it hasn't been read by then. Inserting a sleep between
>  write and close causes it to work.
>
>  I noticed this because my test program was working because it just so happened
>  to pause until the real time task ended before closing the fd.
>
>  I remember doing this before, now that it's figured out, but it's still kind
>  of problematic because it doesn't appear to be possible to block on user
>  space writes.
>
>  Opening with O_SYNC does not cause it to block, and fsync(fd) doesn't seem to
>  do anything. anybody have any suggestions on how to know data has been
>  received before closing a pipe after a write? Surely somebody's done this
>  before.

Well, I do not know the details of the rt_pipe implementation, but
intuitively I would say that what you observe is not normal: when you
write to the rt_pipe, the reader should be woken up immediately and
consume the data, before the producer can close the descriptor. Are
you writing data to the pipe from an RT task ?

-- 
                                               Gilles Chanteperdrix


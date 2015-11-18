Date: Wed, 18 Nov 2015 17:22:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151118162206.GA27240@hermes.click-hack.org>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
 <20151118135249.GA24942@hermes.click-hack.org>
 <CAPRPZsDn9AFciNrBESG8Tn8oWwEeQ78Hzrnd0E0rknrjY1C+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsDn9AFciNrBESG8Tn8oWwEeQ78Hzrnd0E0rknrjY1C+WQ@mail.gmail.com>
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 18, 2015 at 03:38:38PM +0100, Jeroen Van den Keybus wrote:
> >>
> >>    Is that realistic?
> >
> > This seems to be a lot.
> 
> It looks quite long, yes, for what should essentially be an RDTSC instruction.

rtdm_clock_read does more than calling rdtsc, it calls rdtsc then
converts the result from tsc counts to nanoseconds, which is not
negligible compared to the time for rdtsc.

> 
> Why not test without the sleep and compare two back-to-back
> rtdm_clock_read()s to make sure that you're not measuring jitter from
> the sleep function ?

rtdm_task_busy_sleep does not sleep, it reads the tsc and wait for it
to reach a known value. So, there should be little jitter involved.
Maybe the difference comes from some difference in the time
conversion routines involved ?

-- 
					    Gilles.
https://click-hack.org


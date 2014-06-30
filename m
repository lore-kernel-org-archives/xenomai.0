Message-ID: <53B13D33.6010207@xenomai.org>
Date: Mon, 30 Jun 2014 12:34:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdYQgAHFr0yH9jReFa5FS-dN2t2FLfng9=GAmktEBUuUw@mail.gmail.com>
In-Reply-To: <CAKKWdtdYQgAHFr0yH9jReFa5FS-dN2t2FLfng9=GAmktEBUuUw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about interrupt handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 06/30/2014 12:06 PM, ali hagigat wrote:
> When an interrupt is serviced in Linux or root domain, it is regarded
> as a non real time interrupt and the pipe line stage of root domain is
> stalled, so if another real time interrupt happnes  at the same time,
> it will be logged for root domain and will be delayed, I mean there is
> an unpredictable interrupt lateny for real time interrupts.

The fact that we have a different log for rt and non-rt IRQs, for each 
CPU, should be a strong hint that something is wrong with your analysis. 
So no, rt IRQs don't go to the non-rt log, and the non-rt stage can't 
delay the rt stage. That's pretty much the reason for implementing the 
pipeline.

On a more general note, people usually don't spend years developing and 
using a software, without noticing that such software does not address 
the fundamental issue it is supposed to solve. We may be distracted from 
time to time, but in this case, the syndrom would be severe and 
pathological.

-- 
Philippe.


Message-ID: <50FDD15D.2060800@xenomai.org>
Date: Tue, 22 Jan 2013 00:38:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABEhrWC5a+Mbj3HmLAeGw3ePOX-nj0yaoX5rHEYbCv8NrbXOHQ@mail.gmail.com>
	<CABEhrWDy6W1VN1qP=cpeGEqdyMypntbBUUBQn05tHPhgu7k10A@mail.gmail.com>
In-Reply-To: <CABEhrWDy6W1VN1qP=cpeGEqdyMypntbBUUBQn05tHPhgu7k10A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Help regarding Benchmarking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Abhimanyu Varde <abhi1561@gmail.com>
Cc: xenomai@xenomai.org

On 01/21/2013 08:29 PM, Abhimanyu Varde wrote:

> We are Embedded system students who are writing a driver for a PCI-DIOT 48
> card using RTDM on Xenomai.We plan to do some benchmarking with respect to :
> 
> 1. response latency  (to external events which will be serviced through
> interrupts)
> 2. jitter
> 
> If you could provide us with some standard experiments that can be
> performed to help benchmark, we would be obliged


Hi,

we have a few examples of code in tree:

src/testsuite/latency/latency.c measures timer interrupt, kernel-space
and user-space latencies, I guess you could rewire it to use another
RTDM driver than the timerbench driver to measure the same things based
on your PCI board.

src/testsuite/irqbench/irqbench.c is another example, measuring hardware
interrupt latencies (instead of relying on the timer interrupt).

Irqbench relies on a particular setup with another machine, which would
correspond to a "standard experiment". You can also look at the
experiments made by other people benchmarking Xenomai or other real-time
extensions, for instance:
https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf

Regards.

-- 
                                                                Gilles.


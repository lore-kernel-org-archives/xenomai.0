References: <CAC-NLwzELS71XpnoR24fiqnSVzCv=xvcJ8SoBW4ni=FG9-tXyw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55CE176D.3020902@xenomai.org>
Date: Fri, 14 Aug 2015 18:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAC-NLwzELS71XpnoR24fiqnSVzCv=xvcJ8SoBW4ni=FG9-tXyw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Query with rtdm_clock_read
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ashwin damle <ashwindamle@gmail.com>, Xenomai <xenomai@xenomai.org>

On 08/14/2015 05:30 PM, ashwin damle wrote:
> Hi,
> 
> I got Xenomai 3.0-rc4 working.
> 
> I wish to measure time between execution of two functions using
> rtdm_clock_read.in a real time thread.
> 
> Pseudo code is like below.
> .....
> start = rtdm_clock_read();
> 
> foo0();
> foo1();
> 
> stop = rtdm_clock_read();
> 
> execution_time= stop - start;
> .....
> 
> Since rtdm_clock_read is still valid in Xenomai3, I plan to use the same.
> However, I cannot find the API. I am surely missing something. I searched
> .h files in include/rtdm however, I cannot locate it.
> 
> Just wanted to know if I am moving in the right direction intending to use
> rtdm_clock_read or should I use other.
> 

RTDM is a kernel-based API, you can only access it from a driver by
including rtdm/driver.h.

-- 
Philippe.


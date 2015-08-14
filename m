MIME-Version: 1.0
Date: Fri, 14 Aug 2015 21:00:19 +0530
Message-ID: <CAC-NLwzELS71XpnoR24fiqnSVzCv=xvcJ8SoBW4ni=FG9-tXyw@mail.gmail.com>
From: ashwin damle <ashwindamle@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Query with rtdm_clock_read
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I got Xenomai 3.0-rc4 working.

I wish to measure time between execution of two functions using
rtdm_clock_read.in a real time thread.

Pseudo code is like below.
.....
start = rtdm_clock_read();

foo0();
foo1();

stop = rtdm_clock_read();

execution_time= stop - start;
.....

Since rtdm_clock_read is still valid in Xenomai3, I plan to use the same.
However, I cannot find the API. I am surely missing something. I searched
.h files in include/rtdm however, I cannot locate it.

Just wanted to know if I am moving in the right direction intending to use
rtdm_clock_read or should I use other.

Please let me know.

-- 
Ashwin M. Damle

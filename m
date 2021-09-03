From: <j.villena@ecler.com>
Subject: Using oob GPIO on RPi4B and evl_poll
Date: Fri, 3 Sep 2021 23:49:28 +0200
Message-ID: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
MIME-Version: 1.0
Content-Language: es
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

 

I am using the EVL Raspberry-PI-4 GPIO driver in oob mode for waiting for 4
GPI signals changes by monitoring raising and falling edges continuously.

 

The first version uses 4 diferent oob threads and it works as expected when
waiting forever in oob_read on each thread.

 

To optimize resources, I want to avoid to use the 4 threads approach, and I
want to create only one thread to handle all GPI functionality. Thus I have
added polling capabilities with evl_poll and related API to GPIO file
descriptors in only one thread.

 

At first it seems to work, but when I added another file descriptor to the
same polliing set (from an event flag group) the program freezes, and system
becomes unstable.

 

Then I noticed that in the "Polling file descriptors
<https://evlproject.org/core/user-api/poll/> " section of the EVL online
documentation, the GPIO real-time I/O driver is not listed in the
enumeration of pollable elements.

 

Is this true and the cause of the wrong behavior when using polled wait? If
yes, could it be easily fixed?

 

Thanks

 

 


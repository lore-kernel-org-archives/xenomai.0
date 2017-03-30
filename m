From: Marco Camurri <marco.camurri@iit.it>
Message-ID: <ca7e025d-cc64-f190-2fbb-37fa7dffa02c@iit.it>
Date: Thu, 30 Mar 2017 19:35:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] clock_gettime() vs gettimeofday() have offset when run in
	real-time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I need to get the wallclock time from a real-time thread under Xenomai 
2.6.4 running on a x86_64 architecture with Ubuntu 14.04

After realizing that calling the function gettimeofday() I was creating 
mode switches, I've replaced the call with the clock_gettime() (this 
one: 
http://www.xenomai.org/documentation/trunk/html/api/group__posix__time.html#ga10b73e75d375e5c244e32ea46be775bf)

with the parameter CLOCK_REALTIME.

Unfortunately, when comparing the value returned by the call of 
clock_gettime() from within the real-time thread and the gettimeofday() 
called from a non-realtime thread, they turned out to be about 6 seconds 
apart.

when running a single non real-time thread with both functions called, 
they return the same value.

Is there a way to have the same behavior of gettimeofday from within a 
real-time thread without having mode switches?

Thanks,
Marco.


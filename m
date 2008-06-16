Message-ID: <e4ef24880806151833n4e36005coadc1087c29f5b1cb@domain.hid>
Date: Sun, 15 Jun 2008 18:33:09 -0700
From: "Rob Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22787_357324.1213579989452"
Subject: [Xenomai-help] Thread scheduling on mult-processor systems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_22787_357324.1213579989452
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying execute 2 threads on 2 separate processors.  To do this I
created 2 threads, each using the FIFO scheduler where both threads have the
same priority defined by sched_get_priority_max(SCHED_FIFO).  Each thread is
initialized to run on a specific CPU with a call to
pthread_setaffinity_np(...); Thread 1 on CPU 0, and Thread 2 on CPU 1.  I
verified each thread was assigned correctly by calling
pthread_getaffinity_np(...), and also by looking at /proc/xenomai/sched,
while the program was running.

For the purposes of testing, both threads do the same thing:

        for(unsigned long i = 0; i != 9000000; i++)
        {
                if(!(i % 50000))
                {
                        std::cout << "tick" << std::endl;
                }

                sched_yield();
        }

        std::cout << "elapsed time: " << [elapsed time];

My hope was that when these threads would execute simultaneously, they would
truly run in parallel on their respective processor.  But, what I am
noticing is the elapsed time when both threads run is 12 seconds, while when
only one thread runs is 6 seconds.  So, I haven't seem to have bought any
performance improvements by assigning  the thread to run on a specific
processor.

 Where have I gone wrong in my line of thinking?

-Rob

------=_Part_22787_357324.1213579989452
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am trying execute 2 threads on 2 separate processors.&nbsp; To do this I created 2 threads, each using the FIFO scheduler where both threads have the same priority defined by sched_get_priority_max(SCHED_FIFO).&nbsp; Each thread is initialized to run on a specific CPU with a call to pthread_setaffinity_np(...); Thread 1 on CPU 0, and Thread 2 on CPU 1.&nbsp; I verified each thread was assigned correctly by calling pthread_getaffinity_np(...), and also by looking at /proc/xenomai/sched, while the program was running.<br>
<br>For the purposes of testing, both threads do the same thing:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(unsigned long i = 0; i != 9000000; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!(i % 50000))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; std::cout &lt;&lt; &quot;tick&quot; &lt;&lt; std::endl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_yield();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; std::cout &lt;&lt; &quot;elapsed time: &quot; &lt;&lt; [elapsed time];<br><br>My hope was that when these threads would execute simultaneously, they would truly run in parallel on their respective processor.&nbsp; But, what I am noticing is the elapsed time when both threads run is 12 seconds, while when only one thread runs is 6 seconds.&nbsp; So, I haven&#39;t seem to have bought any performance improvements by assigning&nbsp; the thread to run on a specific processor.<br>
<br>&nbsp;Where have I gone wrong in my line of thinking?&nbsp; <br><br>-Rob<br><br>

------=_Part_22787_357324.1213579989452--


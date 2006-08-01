Message-ID: <38215.155.98.4.39.1154456700.squirrel@domain.hid>
Date: Tue, 1 Aug 2006 12:25:00 -0600 (MDT)
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] native heap services and overloading new
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

I have some code where I'd like to be able to dynamically allocate memory
in realtime.  Since the code is written in C++, I was thinking of just
making a huge global RT_HEAP and overloading the new and delete operators
to use the rt_heap_alloc and rt_heap_free functions.  First off, I'm
wondering if there are any caveats to this sort of thing that wouldn't be
obvious to someone new to xenomai like myself.  Second, if I fail to call
rt_heap_delete before the program terminates, does the heap remain
registered hang potentially causing problems when I try to re-allocate the
heap when the program is run again?  Thanks.
-Brandt



Message-ID: <435D7D8C.1010004@domain.hid>
Date: Mon, 24 Oct 2005 17:34:20 -0700
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How to implement a GUI for RT apps?
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

Hello,

I'd like to have your opinion on the best way to implement a GUI for a 
RT application. The standard approach seems to be to split of the 
application in two processes that communicate using shared memory or 
queues. I've been using a different approach that's closer to what's 
done in many non-realtime apps. I tried to put both the GUI and RT code 
in a single process using threads, shared objects and mutexes. It seemed 
to work fairly well for a while but it stopped working after switching 
to GCC 4.0 (while upgrading Ubuntu Linux). After spending a few days 
debugging this problem, I get the feeling that I'm doing something 
"illegal" with RTAI/fusion that worked by accident until the upgrade.

Here's what I've been doing... I create some objects, each with its own 
RT_MUTEX. I then create two RT tasks: one for the GUI and one for my 
hardware. Both taks have pointers to the shared objects. They call the 
objects' methods directly. The object locks or tries to lock its mutex 
in its methods, as appropriate. Both tasks are thus using the same 
RT_MUTEX structure. I've been careful to lock the mutexes only for short 
amounts of time and to only try to lock it in critical code.

To summarize,

1. What's the best way to implement a GUI for a RT app?
2. Is my approach "legal" in fusion/xenomai?
3. I remember reading that RTAI and X don't play well together. Is that 
the case with Xenomai? Will things be better if I use the two-processes 
approach?

Thank you,

Vincent Levesque
vleves@domain.hid

P.S. I'll be upgrading to Xenomai 2.0 asap. Thanks for your great work!


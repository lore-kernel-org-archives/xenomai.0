Message-ID: <44B51D2C.10508@domain.hid>
Date: Wed, 12 Jul 2006 18:02:52 +0200
From: Khalil GHORBAL <kg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] handling threads within a pod
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

Hi,

I'm trying to implement a new skin (IMA380) using xenomai framework.

When creating multiple xnthreads within a pod,
I didn't found a way to access or handle these threads.
Threads are linked to the global queue of a pod but how can I access to 
the other fields of xnthread structure ?

hope it was clear :)

Regards,
--
Khalil


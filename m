Message-ID: <4B8D0EEA.3090409@domain.hid>
Date: Tue, 02 Mar 2010 14:13:14 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Which process synchronization primitive?
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

Hello. I'm writing a data acquisition system (the code will be released
open source soon) and i chose to use Xenomai to obtain real time
performances.

The design of the system is inspired from JACK http://jackaudio.org/.
Different functionalities are implemented in separate processes that
communicate via a shared memory segment. However I need a processes
synchronization primitive. In the first toy implementation of the system
I have been using simple pipes and blocking reads (as is done in jack)
and it work quite well. However I learned this mechanism is not suitable
for real time.

Given that I would like to use the Xenomai Posix skin, so that my
applications will build also without Xenomai support, which process
synchronization primitive you suggest? Which is the overhead of
different solutions?

I think message queues can work well but I'm not sure they are the best
choice when I do not have to communicate any message. Would be
semaphores best suited to my needs?

Thanks. Cheers,
-- 
Daniele


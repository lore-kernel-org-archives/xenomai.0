From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17311.11934.369273.220410@domain.hid>
Date: Tue, 13 Dec 2005 21:27:10 +0100
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - implementing a
	periodic thread
In-Reply-To: <439F0B78.2000002@domain.hid>
References: <439F0B78.2000002@domain.hid>
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

Paolo Gai wrote:
 > Dear all,
 > 
 > here is another small demo... this time of a periodic thread in POSIX.
 > 
 > It works under Xenomai, but it fails under Posix Real-Time.
 > 
 > The reason of the failure is the SIGUSR1 not being blocked by the main 
 > thread. If in main() the comments below the note "// REMOVE THE COMMENTS 
 > BELOW" are removed, then the signal is masked also in the main(), and as 
 > a result the POSIX version works.
 > 
 > The question I have is if the behavior in Xenomai (that is, not failing 
 > like the POSIX counterpart) is correct or not...

The answer is in section 2.4.2 of the standard, delivery of real-time
signals.

http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_04.html#tag_02_04_02

real-time signals are marked pending to the process, not a particular
thread. So, Linux implementation is correct, Xenomai is incorrect.

When creating a timer with timer_create, Xenomai assume that signals
will be delivered to the thread which created the thread.

Linux supports an extension which allows timer notifications to be
delivered to a particular thread; set the sigev_notify member of the
sigevent structure to 
SIGEV_SIGNAL | SIGEV_THREAD_ID
and set the member _sigev_un._tid to the thread ID of the target thread.

-- 


					    Gilles Chanteperdrix.


MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18429.6412.785941.128928@domain.hid>
Date: Wed, 9 Apr 2008 21:29:16 +0200
In-Reply-To: <000701c89a75$d349f630$9601a8c0@domain.hid>
References: <000701c89a75$d349f630$9601a8c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] mlockall questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

Robert McCullough wrote:
 > Hi,
 > 
 > I am converting part of a C++ application to real-time.
 > 
 > I noticed that all the Xenomai examples call
 > mlockall(MCL_CURRENT|MCL_FUTURE) at the beginning of main before creating
 > any real-time threads.
 > Is calling mlockall a requirement when using Xenomai?

Yes it is.

 > 
 > I have added a couple of Xenomai tasks to my C++ app.
 > A) Without calling mlockall my application seems to run fine but I noticed
 > in /proc/xenomai/stat that a few page faults occurred.

Well normally your application should stop with a message telling you
that you have not call mlockall. Do you happen to install a handler for
SIGXCPU ?

 > B) When calling mlockall at the beginning of my main() I do not see any page
 > faults but some of the C++ threads do not start.
 > 
 > Why would mlockall cause some threads not to start?

Well, you should check rt_task_create or pthread_create return
value. The usual error is that you run out of memory because of the
stack size problem explained in the TROUBLESHOOTING guide.

-- 


					    Gilles.


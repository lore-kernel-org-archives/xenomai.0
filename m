MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18491.19513.202182.217921@domain.hid>
Date: Tue, 27 May 2008 01:48:09 +0200
In-Reply-To: <2405.81.252.86.91.1211549465.squirrel@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
	<18484.28025.505865.374746@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
 > Results on the console :
 > 
 > TimeOutCreation thread
 > TimeOut thread
 > Display thread
 > Main condition broadcast
 > TimeOutCreation thread
 > TimeOut thread
 > Start of time out 1 - 5ms
 > Display thread
 > Start of time out 2 - 5ms
 > Start of time out 3 - 5ms
 > Display thread :8791		<---- the system crashed
 > 
 > 
 > I hope that you can help me. I will try to execute this program without
 > your patch to see what kernel traces I will have if the kernel crashes.

I tried your program, and first it was hard to compile because:
- you use UTF-8 accents in the comments;
- your mailer add carriage returns when lines are too long, which
  usually does not matter with C code, but...
- you use C++ style comments where a carriage return matters, so when
  your mailer adds carriage returns in the middle of C++ comments, the
  compiler ends up trying to interpret your comments (with their UTF-8
  accents) as code.

Anyway, it does not crash, it simply stops after displaying:

TimeOutCreation thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutCreation thread
TimeOut thread

However, when pressing ctrl-C, I had a segmentation fault because
cleanup_upon_sig used the timeOut*_ptr pointers without testint whether
they were NULL. 
Your program is way to big for me to try and understand it. So, no
sorry, unless you come up with a real small and understandable sample,
with understandable comments, I can not help you.

 > I wonder why my system is so unsteady...

If you ask me, I will tell you that it is because you use Xenomai posix
skin timers in user-space, that nobody else uses, since they bring
nothing when compared with Linux vanilla timers. But I think I already
told you that.

Anyway, I think I will try and re-implement the timers with a server
thread without resorting to signals. The thing I do not know yet is if I
can get the signal handlers without a system call.

 > 
 > Thanks a lot for your help.
 > 


-- 


					    Gilles.


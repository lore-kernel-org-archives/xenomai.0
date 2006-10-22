From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17723.27846.168894.602494@domain.hid>
Date: Sun, 22 Oct 2006 15:06:14 +0200
Subject: Re: [Xenomai-core] switchtest FPU register error on PPC 2.6.18 
In-Reply-To: <453B4816.4010007@domain.hid>
References: <453B4816.4010007@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > I just realized the error message:
 > 
 >    Error after context switch from task 8(rtup-8) to task
 >    10(rtup_ufpp-10), FPU registers were set to 1000 (maybe task
 >    sleeper_ufps-0)
 > 
 > when running "switchtest" on an PPC under Linux 2.6.18 with Xenomai head 
 > of SVN. I have attached the full output log.

Are you sure you did ?

 >  Can some tell me what went 
 > exactly wrong and where I should start looking at?

It means that after a switch from task 8 to task 10, the FPU context is
the one of task 0. So, some context switches which should have switched
the FPU did not. If you are lucky, you should get this error
systematically.

In order to investigate, you should try and reduce the number of tasks
created by switchtest. switchtest --help will tell you the list of tasks
created by switchtest by default, start from this list, and try removing
some tasks, keeping the failure. When you have the minimum set of tasks
that create the failure, try to trace the fpu switches, to see which one
does not do its job correctly.

-- 


					    Gilles Chanteperdrix.


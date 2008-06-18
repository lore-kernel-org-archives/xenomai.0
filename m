Message-ID: <4859299A.2010802@domain.hid>
Date: Wed, 18 Jun 2008 17:28:26 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PowerPC] Registers Corruption at Context Switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I'm facing a problem with the PowerPC version of Xenomai/Adeos that I 
have difficulties
to identify the exact source.

I'm running a Xenomai RT kernel thread that use to crash sometimes due 
to potential register corruption.
Problem occurs after a context switch and, in some cases, if the task 
gets interrupted and reschedule,
its registers values are not the same as they used to be before context 
switch.

The code is a bit complex and so, makes use of register that is 
generally rarely used (GPR r26 to be accurate).
Driver is compiled with -02 and compiling with -O0 (so disabling 
optimizations and so, not using r26) works fine
but is not what I'm looking for.

Can someone tell me where exactly in Adeos/Xenomai is context switching 
actually performed and where are the registers save/restore functions ? 
I've seen there is specific code for FPU registers handling but can't 
find the equivalent for GPR.

FYI, I'm running on PowerPC 603e core with Linux 2.6.23, Adeos 2.0-09 
(latest) and Xenomai 2.3.4 (latest).
I've seen there are adeos updates (but for updated kernels) but is there 
some ChangeLog of Adeos changes ?
Maybe this is a known bug that has been fixed in updated Adeos release ?

Thx to anyone who can help me on this,

Ben



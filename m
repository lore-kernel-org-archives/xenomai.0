Message-ID: <44327A26.8010003@domain.hid>
Date: Tue, 04 Apr 2006 15:52:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6ee4c8380604032304h2de399c6geffbbae78ab6124b@domain.hid>	<443225ED.6070104@domain.hid>
	<44322BDD.8010706@domain.hid>
	<6ee4c8380604040553t1ece4750waa548d1715be3e30@domain.hid>
	<44326FBB.9070405@domain.hid>
In-Reply-To: <44326FBB.9070405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Panic in rt_queue_create: bug or
	misuse?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Jan Kiszka wrote:
> Brian L. wrote:
> 
>>How could I forget mlockall? I've been calling it in rtai forever...Is
>>there any other neccessary boilerplate?
> 
> 
> This is a very frequently made mistake. Philippe, is there a chance add
> some simple debug check for this situation? Something to check when the
> first shadow thread is created for a process?

The following patch would cause SIGXCPU to be sent to emerging real-time 
threads from a non-fully mlocked program (i.e. not including 
MCL_FUTURE). We should make this conditionally compiled too. I'm not 
sure that we would not introduce problems when dealing with mmio areas 
mapped in user-space at least for older kernel revisions (the VM_IO 
issue might have been fixed in recent kernels, though), this is why I 
would tend to make it easy to work around this check by simply ignoring 
the signal, for handling specific init configurations for which people 
know what they are doing.

--- ksrc/nucleus/shadow.c	(revision 875)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -754,6 +754,9 @@
  		    current->pid,
  		    xnthread_base_priority(thread));

+    if (!(current->mm->def_flags & VM_LOCKED))
+	send_sig(SIGXCPU,current,1);
+
      current->cap_effective |=
  	CAP_TO_MASK(CAP_IPC_LOCK)|
  	CAP_TO_MASK(CAP_SYS_RAWIO)|

-- 

Philippe.


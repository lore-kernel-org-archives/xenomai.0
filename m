From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17467.53942.273504.865219@domain.hid>
Date: Tue, 11 Apr 2006 18:00:54 +0200
Subject: Re: [Xenomai-help] Vxworks skin & Task priority
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AA05846@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290AA05846@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Thomas, Brieuc (GE Healthcare)" <Brieuc.Thomas@domain.hid>
Cc: xenomai@xenomai.org

Thomas, Brieuc \(GE Healthcare\) wrote:
 > Hello,    
 > 
 > I'm trying to use the Vxworks skin,  with RealTime task. But I've got a
 > problem during a task test.
 > 
 > I would like to configure the scheduler in Round Robin mode and launch a
 > first blocking task, and a second one, with an higher priority, which
 > kill the first one after a while. But the first task never give back the
 > CPU and my computer freeze !    

Your code does not make what you believe: the first created task
preempts the module init code immediately, which never has a chance to
create a second task.

 > (...)
 >    xnpod_activate_rr(SSEXEC_TIMESLICE);

You are supposed to use kernelTimeSlice() to enable round-robin.

-- 


					    Gilles Chanteperdrix.


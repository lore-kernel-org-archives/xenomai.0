From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17469.4610.165002.315363@domain.hid>
Date: Wed, 12 Apr 2006 16:43:14 +0200
Subject: Re: [Xenomai-help] Re: Vxworks skin & Task priority 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AA52FC4@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290AA52FC4@domain.hid>
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
 > Unfortunately, I still have the same problem with the correction, see
 > bellow. Is my roundrobin configuration is entirely correct (RR,Ticks and
 > time slice)?

The first task created with taskSpawn preempts the module initialization
routine immediately and go in its infinite loop, so that the module
initialization routine never has a chance to create a second task.

 > is a task can take 100% of the CPU?

Yes. With Xenomai scheduler as with vxWorks', round-robin scheduling
only take place for tasks running in the same priority group. The module
initialization routine runs on the root context, the idle task, the
lowest priority task in the system. So, the first created task is alone
in its priority group, only yields to itself every 10 ticks, and uses
100% of the CPU.


-- 


					    Gilles Chanteperdrix.


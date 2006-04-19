MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17478.40636.563067.656256@domain.hid>
Date: Wed, 19 Apr 2006 22:34:04 +0200
Subject: RE: [Xenomai-help] my tick takes a break !! 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AC5B129@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290AC5B129@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
 >  
 > Thomas, Brieuc \(GE Healthcare\) wrote:
 >  > Hi every one !
 >  >
 >  > I really don't understand, my porting of application works very well
 > > (under vxworks skin), message, semaphore, timer... Except the task !!
 >  > I've got a curious behaviour, when I've got a heavy task, the kernel
 > > tick counter stop during the process!!
 >  >
 >  > And take back when this one is finish.
 >  >
 >  > Therefore the other tasks are freeze and my application crash.
 >  >
 >  >
 >  >
 >  > have You already seen this case?
 > 
 > I do not know if it is what you mean, but when running Xenomai, your
 > tasks are supposed to suspend sufficiently frequently to leave Linux
 > tick normally. This means that if you configured CONFIG_HZ=100, your
 > real-time activity (including kernel-space tasks and user-space tasks in
 > primary mode) is supposed to take a break at least once every 1/100
 > second.
 > 
 > -- 
 > 
 > 
 > 					    Gilles Chanteperdrix.
 > 
 > Oh no! Sorry, I mean the real-time tick counter!

If the heavy task is using intLock() then yes, it will prevent the timer
from ticking. If you are observing something else, could you send to
this mailing list a minimal test case illustrating what you are
observing?

 > But if my real-time activity don't take a break during a while (more
 > than 1/100 second), Is it dangerous for my real-time activity? 

If you do not let Linux run often enough, it will crash, and this is
dangerous for your real-time activity. 
I do not know exactly how much is "often enough", and it probably
depends on many factors, but if you want Linux timed services to work
normally, you should let Linux timer tick regularly.

-- 


					    Gilles Chanteperdrix.


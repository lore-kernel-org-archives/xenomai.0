From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17478.21685.31999.896405@domain.hid>
Date: Wed, 19 Apr 2006 17:18:13 +0200
Subject: Re: [Xenomai-help] my tick takes a break !! 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AC5AE4B@BUDMLVEM03.e2k.ad.ge.com>
References: <5B122FD931231D408AC32630D1B1F7290AC5AE4B@BUDMLVEM03.e2k.ad.ge.com>
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
 > Hi every one !
 > 
 > I really don't understand, my porting of application works very well
 > (under vxworks skin), message, semaphore, timer... Except the task !!
 > I've got a curious behaviour, when I've got a heavy task, the kernel
 > tick counter stop during the process!!
 > 
 > And take back when this one is finish.
 > 
 > Therefore the other tasks are freeze and my application crash.
 > 
 >  
 > 
 > have You already seen this case?

I do not know if it is what you mean, but when running Xenomai, your
tasks are supposed to suspend sufficiently frequently to leave Linux
tick normally. This means that if you configured CONFIG_HZ=100, your
real-time activity (including kernel-space tasks and user-space tasks in
primary mode) is supposed to take a break at least once every 1/100
second.

-- 


					    Gilles Chanteperdrix.


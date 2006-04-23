MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17483.30930.811656.336575@domain.hid>
Date: Sun, 23 Apr 2006 14:53:38 +0200
Subject: RE: [Xenomai-help] my tick takes a break !! 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AD31A20@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290AD31A20@domain.hid>
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
 > I tried it, but there isn't any change !
 > I've got the same behaviour.

I could reproduce your bug here. The uvm-timer thread is blocked in W
state, just as if the interrupts were locked.

-- 


					    Gilles Chanteperdrix.


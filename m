MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.57095.499792.910164@domain.hid>
Date: Wed, 9 Apr 2008 17:21:43 +0200
In-Reply-To: <47F2158F.307@domain.hid>
References: <47F2158F.307@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] difference between "alarm_wait"
	and	"task_wait_period"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mouaiad Alras <Mouaiad.Alras@domain.hid>
Cc: xenomai@xenomai.org

Mouaiad Alras wrote:
 > Hello,
 > is there any difference between "periodic task" and "periodic alarm 
 > triggered task" ??
 > 
 > are "task1" and "task2" the same in this example ? :

No, these are two ways to do the same thing. A periodic task uses a
timer that is built-in the task, whereas an alarm creates a different
timer. Of course, you can create as many alarms as you want whereas each
task has only one built-in timer.

-- 


					    Gilles.


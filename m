MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18436.57262.245122.638753@domain.hid>
Date: Tue, 15 Apr 2008 19:02:38 +0200
In-Reply-To: <1071035914@domain.hid>
References: <1071035914@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] system() call allowed from within RT task ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

Jochen Behnke wrote:
 > Hello,
 > 
 > within my application I use system() calls from within a xenomai task.
 > Is this allowed ?
 > 
 > The reason I'm asking this, is the following:
 > In my application I have multiple xenomai tasks. One of them is time critical (Task_A).
 > An other (non time critical) xenomai task (Task_B) is used to pass data back
 > and forth between Task_A and normal linux tasks. Task_B uses the system()-call
 > to accomplish certain requests.
 > I have set the T_WARNSW for Task_A in order to get a SIGXCPU, whenever it switches
 > to secondary mode. As long as Task_B is not executing a sytem() call, everything is fine.
 > But when for example Task_B executes a system("cp -R dirA dirB") the application terminates
 > due to a SIGXCPU signal.
 > 
 > I'm using 
 > - Linux Kernel 2.6.17 (I-PIPE 1.5-02)

I-pipe 1.5-02 is too old. only more recent I-pipe patches have the
necessary support to allow real-time applications to call fork (or
system).


-- 


					    Gilles.


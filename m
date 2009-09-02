Date: Wed, 2 Sep 2009 15:00:11 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <4A9E5917.8060200@domain.hid>
Message-ID: <Pine.LNX.4.64.0909021441160.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
	<Pine.LNX.4.64.0909021418300.22914@domain.hid>
	<4A9E5917.8060200@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2 Sep 2009, Gilles Chanteperdrix wrote:

:> :> :For instance, you would implement the "write" method of the driver to
:> :> :pass data between the user-space task and the driver.
:> :>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
:> :> call was running in RT task context. Now it is not clear how this can be 
:> :> achieved with new RTDM driver model in kernel space.
:> :The write method of an RTDM driver can run in rt context too. If the
:> :task which issues the call to "write" is a Xenomai user-space task
:> :running in primary mode.
:>  Please note - I do not have any Xenomai user-space tasks running - only 
:> normal user space programs. The Xenomai-2.4 allows developing of RT driver 
:> in kernel space - leaving untouchable user space processes. If such new 
:> paradigm need to write the intermediate user-space RT task proxy - than 
:> it is wrong. Simply because its adds unneeded complexity to developing RT 
:> kernel hardware drivers.
:
:You do not need a proxy. What you need to do is to create the previous
:non real-time task as a Xenomai task, using rt_task_create, or the
:Xenomai posix skin's pthread_create. Then you would change this task to
:use RTDM's write instead of write. That is all. Everything else stays
:the same. And as an additonal benefit, you have one less task running if

 No, this means I need to change the previous non-rt user-space software 
to RT one. Problem is that exists some projects that can't be simply 
changed in this way, for example we use asterisk as non-rt user space 
process - it changing means creating and supporting previously unneeded 
patches.

:Separating clearly the driver code running in kernel-space from the
:application code running in user-space is clear win. It leads to a code
:easier to maintain, and avoid taking risks of running too many code in
:the unprotected kernel-space.

 I do not see the win in decreasing number of the API functions. So I see 
the problem with porting Xenomai-2.4 apps, written by provided pipe.c 
example from the docs, to Xenomai-2.5 and later. Next - I do not 
understand why the previous model lets the _developer_ itself decide 
which of the application tasks will be running in kernel and which will 
be running in user space. The current model left the people without any 
choice. So the current model itself decided instead of developer what is 
better - I think this is wrong.


		Rus


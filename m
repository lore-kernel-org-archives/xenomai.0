Message-ID: <4E019368.9020800@domain.hid>
Date: Wed, 22 Jun 2011 09:02:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <737283.11182.qm@domain.hid>
	<4DEF2D3D.9090409@domain.hid>
	<213583.55278.qm@domain.hid>
	<4E01050D.8000800@domain.hid>
	<858255.34222.qm@domain.hid>
In-Reply-To: <858255.34222.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sanjay anvekar <sanjayanvekar@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/22/2011 05:29 AM, sanjay anvekar wrote:
> Hi Gilles, Thanks for your reply. With GDB I am able to run the
> application but it never hits configured breakpoints and it takes
> little longer time to start application. I tried changing priority of
> tasks, but it didn't help. In my application program I have not
> configured any interrupts and completely dependent on Linux drivers. 
> If I do not use rt_task_sleep() my program does not work correctly. I
> tried to suspend each task instead of

Without seeing any code it is hard to give any definite answer, but from
the way you describe it, you do not need Xenomai: as soon as a real-time
thread uses a Linux driver, it is no longer deterministic. A typical
real-time application waits for an external event, be it a timer event
or a real-time driver, and so suspend naturally to let Linux run.

-- 
                                                                Gilles.


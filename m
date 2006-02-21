Date: Tue, 21 Feb 2006 07:04:21 -0800
Subject: Re: [Xenomai-help] no-brainer realtime issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0206BF5.24A1%steve@domain.hid>
In-Reply-To: <43F5F2E0.7050201@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Just to let you know, I tried recompiling everything without periodic
support enabled and I can't even load the xeno_nucleus.ko module. I get an
-ENODEV presumably because my board won't work with the aperiodic timing
mode.


On 2/17/06 7:59 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Yous seem to be running in periodic timing mode, with a default slice of 125
> us.
> Which parameters are passed to rt_task_set_periodic() and
> rt_task_wait_period() in
> your sampling task?
> 



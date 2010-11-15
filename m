From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTimpBp3+w3thbLwCSiTz--h7HBZx+ZLtV4vhbemo@domain.hid>
References: <AANLkTimpBp3+w3thbLwCSiTz--h7HBZx+ZLtV4vhbemo@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 11:19:29 +0100
Message-ID: <1289816369.1933.97.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] psos+ Skin: argument passing to task body
 sometimes failing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid

On Wed, 2010-10-20 at 22:28 +0200, ronny meeus wrote:
> Hello
> 
> it is me again.
> 
> This is the configuration I'm using: Target based on QEMU, Xenomai
> 2.5.4 and the PSOS skin.
> [    0.623238] Xenomai: hal/i386 started.
> [    0.633758] Xenomai: scheduling class idle registered.
> [    0.636172] Xenomai: scheduling class rt registered.
> [    0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> [    0.723234] Xenomai: starting native API services.
> [    0.728107] Xenomai: starting pSOS+ services.
> 
> I sometimes observe issues in passing task arguments to the taskbody
> of the pSOS task.
> Observations:
> 1 During debugging I observe in 50% of the cases that all arguments of
> some task are 0 (all 4). There is no issue with this task if the
> debugger is not used.
> 2 During a task creation (in some scenarios) I see in 100% of the
> cases that all arguments are 0 while the parameters are fine for other
> application scenarios where the same code is used to create the task
> itself.
> 
> Conclusion: strange behavior is seen (looks like a race
> condition ...).
> 
> I did already some research in the code and on the web and came across
> following thread:
> http://www.mail-archive.com/xenomai@xenomai.org
> 
> This explains the mechanism and also talks about a problem that has
> been resolved in this area.
> I think there is still a gap somewhere.

That bug was never addressed actually (errno = EPROCRASTINATE). Try this
patch:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4f30d401be83bb7754b018c82f6f8791c75da06f

-- 
Philippe.




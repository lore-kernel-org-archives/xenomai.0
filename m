Message-ID: <48ADA5FF.5030703@domain.hid>
Date: Thu, 21 Aug 2008 19:29:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>	<488A073F.1090403@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170BF3DB1DB6@domain.hid>	<48ABDA75.70901@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170E9BD4FF66@domain.hid>
	<48AC23B6.3030902@domain.hid> <48AC4A2A.8080304@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BD4FFDD@PRI-MBX-101.dom1.vinci-energies.net>
	<48AD6368.7020504@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BD5002E@PRI-MBX-101.dom1.vinci-energies.net>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170E9BD5002E@PRI-MBX-101.dom1.vinci-energies.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BARRE Sebastien <sbarre@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

BARRE Sebastien wrote:
> Yes, I recompiled the kernel, copied the bzImage on my target, and rebooted it.
> 
> I had to apply the patch mannually because it doesn't work with the patch command. I had the message :
> 
> patch: **** malformed patch at line 6: *prev,

Ok. Could you try something else:

in the function gatekeeper_thread, could you replace:

if (xnthread_user_task(thread)->state == TASK_INTERRUPTIBLE) {

with

if (xnthread_user_task(thread)->state == TASK_INTERRUPTIBLE |
TASK_ATOMICSWITCH) {

Or comment out the if and the closing brace ?

-- 
                                                 Gilles.


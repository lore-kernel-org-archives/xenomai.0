Date: Thu, 5 Aug 2004 00:27:27 +0200
Subject: Re: [Adeos-main] adeos_enter/exit_syscall
Message-ID: <20040804222727.GA15475@domain.hid>
References: <0C53F2DBA565D411885300508B553B5204CCEAE9@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C53F2DBA565D411885300508B553B5204CCEAE9@domain.hid>
From: kleine-budde@domain.hid (Marc Kleine-Budde)
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: aaron durbin <aarondurbin@domain.hid>
Cc: "'adeos-main@gna.org'" <adeos-main@gna.org>

Hi!

Let's hope I've understand the concept... :)

On Wed, Aug 04, 2004 at 05:16:07PM -0500, aaron durbin wrote:
> I have a question concerning the adeos_enter_syscall routine.  Is there
> normally event monitors for syscall entry (SYSCALL_PROLOGUE)?  If so and

There can be a monitor, but there must not be one. 

> handle_event returns non-zero then one automatically restores the registers
> and returns w/o calling the system call.  Doesn't this destroy the call?

Yes - It should - This way you can handle syscall in the RTHAL domain
und substitute it with you own syscall, doing the same, but better then
linux (e.g. nanosleep).

Or the syscalls to the nucleus and skins, they are completely handled
outside of the linux kernel.

hth - Marc

-- 
#!/bin/sh
set - `type $0` 'tr "[a-zA-Z]" "[n-za-mN-ZA-M]"';while [ "$2" != "" ];do \
shift;done; echo 'frq -a -rc '`echo "$0"| $1 `'>$UBZR/.`rpub signature|'`\
echo $1|$1`'`;rpub "Jr ner fvtangher bs obet. Erfvfgnapr vf shgvyr!"'|$1|sh


Message-ID: <0C53F2DBA565D411885300508B553B5204CCEAE9@domain.hid>
From: aaron durbin <aarondurbin@domain.hid>
Date: Wed, 4 Aug 2004 17:16:07 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Adeos-main] adeos_enter/exit_syscall
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
To: "'adeos-main@gna.org'" <adeos-main@gna.org>

I have a question concerning the adeos_enter_syscall routine.  Is there
normally event monitors for syscall entry (SYSCALL_PROLOGUE)?  If so and
handle_event returns non-zero then one automatically restores the registers
and returns w/o calling the system call.  Doesn't this destroy the call?

-Aaron


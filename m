From: Peter Soetens <peter.soetens@domain.hid>
Subject: Re: [Xenomai-help] Debugging in Xenomai
Date: Fri, 24 Nov 2006 10:20:45 +0100
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241020.45706.peter.soetens@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Thursday 23 November 2006 16:25, Daniel Schnell wrote:
>
> One of the next steps would be finding out which actual function back
> trace the suspicious thread has. So I execute gdb and try to attach to
> the appropriate process, which works. Problem: sending Ctrl-C doesn't
> work, independant of if gdb is executed via ssh or serial console. So I
> cannot stop the actual program beeing debugged, rendering the gdb
> approach useless. Also sending SIGINT to the GDB process doesn't work.
> It seems to be simply ignored. As I understand CTRL-C is effectively
> sending SIGINT and is sent to GDB itself and not to the underlying appl.

We had a similar issue while debugging an RTNET app (main thread + 1 xenomai 
posix skin thread) under xenomai. I don't recall exactly the circumstances, 
but the app was blocked on a socket, and a Ctrl-C did not work. A 'killall 
gdb' (SIGTERM) did come through and killed gdb. If you (the Xeno/RTNet 
developers)'re interested in this case, I'll see if I can get more info.

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>


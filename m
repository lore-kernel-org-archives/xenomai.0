Message-ID: <486BC042.5030300@domain.hid>
Date: Wed, 02 Jul 2008 19:52:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> Hi,
> 
> I began using GDB to debug rt-tasks in addition to pthreads and I
> found that placing a breakpoint within an RT-Task causes a
> termination of the debug session
> 
> "Child terminated with signal = 5 " is the error I get from gdbserver
> on the target device
> 
> In the Eclipse environment on my non-Xeno desktop, I receive the
> following error: <terminated>gdbserver Debugger (7/2/08 1:27 PM)
> (Exited. Signal 'SIGTRAP' received. Description: Trace/breakpoint
> trap.)
> 
> 
> I did some googling and found out I need symbol information available
> to GDB for Xenomai functions (in addition to PThreads). Where can I
> find libraries with the symbols?

Read README.INSTALL

> Is there anything else I need to know to be able to set breakpoints
> within RT- Tasks for debugging?  I haven't used GDB until now, so
> this is still new to me.

The main reason for such kind of errors is not using the same version of
gdb and gdbserver.

-- 
                                                  Gilles.


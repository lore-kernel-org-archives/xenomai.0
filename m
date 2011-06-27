Message-ID: <4E0835D3.6010403@domain.hid>
Date: Mon, 27 Jun 2011 09:48:35 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4DF934BD.50505@domain.hid>
	<4DFA1F3C.7090209@domain.hid>
In-Reply-To: <4DFA1F3C.7090209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcanrecv output line-buffering
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 06/16/2011 05:20 PM, Andrew Tannenbaum wrote:
> I was trying to use the Xenomai RT-Socket-CAN rtcanrecv in a Tcl/Tk
> script GUI wrapper.
> 
> rtcanrecv uses printf to stdout, and it line-buffers when attached to a
> tty, but it uses larger buffers (so it is unusable) when run from a
> script with no tty.
> 
> Tcl does stdio with pipes rather than ptys (that is, Tcl thinks it has
> no tty for stdio).  I think both bash and perl use ptys (and so don't
> have this problem).  I haven't done a more thorough survey, but that's
> not the point.
> 
> I think it would be nice to modify rtcanrecv so it can write stdout in
> line-buffered mode.  If you think this is a good idea, please either set
> line buffering with
> 
>     setvbuf(stdout, NULL, _IOLBF, 0);
> 
> at the top of src/utils/can/rtcanrecv.c:rt_task() or
> 
>     fflush(stdout);
> 
> after the printf("\n") at the bottom of rt_task(), or you could add a
> command line getopt option for line-buffering that would do one of the
> above.

I would prefer the latter, patches are welcome. Be aware that using
printf will switch to secondary mode which should be avoided if
real-time is required.

Wolfgang.


Message-ID: <4E0A3A0E.7090001@domain.hid>
Date: Tue, 28 Jun 2011 22:31:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF934BD.50505@domain.hid>	<4DFA1F3C.7090209@domain.hid>	<261CC64699FF40F2937C31EEF248B8E5@domain.hid>
	<4E08C03D.9010407@domain.hid>
In-Reply-To: <4E08C03D.9010407@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

On 06/27/2011 07:39 PM, Andrew Tannenbaum wrote:
> Wolfgang Grandegger wrote:
>> On 06/16/2011 05:20 PM, Andrew Tannenbaum wrote:
>>> I was trying to use the Xenomai RT-Socket-CAN rtcanrecv in a Tcl/Tk
>>> script GUI wrapper.
>>>
>>> rtcanrecv uses printf to stdout, and it line-buffers when attached to a
>>> tty, but it uses larger buffers (so it is unusable) when run from a
>>> script with no tty.
>>>
>>> Tcl does stdio with pipes rather than ptys (that is, Tcl thinks it has
>>> no tty for stdio).  I think both bash and perl use ptys (and so don't
>>> have this problem).  I haven't done a more thorough survey, but that's
>>> not the point.
>>>
>>> I think it would be nice to modify rtcanrecv so it can write stdout in
>>> line-buffered mode.  If you think this is a good idea, please either set
>>> line buffering with
>>>
>>>      setvbuf(stdout, NULL, _IOLBF, 0);
>>>
>>> at the top of src/utils/can/rtcanrecv.c:rt_task() or
>>>
>>>      fflush(stdout);
>>>
>>> after the printf("\n") at the bottom of rt_task(), or you could add a
>>> command line getopt option for line-buffering that would do one of the
>>> above.
>>
>> I would prefer the latter, patches are welcome. Be aware that using
>> printf will switch to secondary mode which should be avoided if
>> real-time is required.
>>
>> Wolfgang.
>>
> 
> Wolfgang,
> 
> rtcanrecv already exists using printf, I'm just changing the buffering. 
>   I added a -L (line-buffer) getopt switch (default=off), as you 
> suggested.  I added it to the C source and the man page.
> 
> Attached are two diff patch files, one for rtcanrecv.c and one for 
> rtcanrecv.man.in .  I see there is a generated version of the html man 
> page in the tar file, I assume that is created automatically, so I 
> didn't patch it.  I created the patches within the folders containing 
> the source files, and I diffed from filenames foo.orig to foo.  I am not 
> aware of the naming protocol for patches in the development tree, but 
> these are simple patches so I hope they are sufficient.

Hi,

These patches look fine though we prefer usually to generate them such
that they can be applied with patch -p1. git makes them that way.

Anyway, Wolfgang, if you are OK with the patches I will merge them.

-- 
                                                                Gilles.


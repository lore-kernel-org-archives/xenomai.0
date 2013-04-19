Message-ID: <5171069C.3020909@grandegger.com>
Date: Fri, 19 Apr 2013 10:55:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
	<516E336C.1060509@xenomai.org>
	<CADVgf9=CJ0MQEpsub3g=bDZvxk3U3G1tDDvjvFm1jZRmke35fg@mail.gmail.com>
	<CAD1EtoiQm8rZtkDTjZK8Tq3xeDKHULjc7V6Stg=bZ9XpEp5o7w@mail.gmail.com>
	<516F9E87.6020002@grandegger.com> <516FA077.20400@grandegger.com>
	<CAD1EtoiZ05S5HXEvdq2+Sg6-1XbxHwMUpcVMrpYA6gv0JgLqJw@mail.gmail.com>
In-Reply-To: <CAD1EtoiZ05S5HXEvdq2+Sg6-1XbxHwMUpcVMrpYA6gv0JgLqJw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

Hi Daniel,

On 04/18/2013 11:49 PM, Daniel M. Drucker, Ph.D. wrote:
>> Thinking more about it, a specialized rtcanmultisend.c in
>> "examples/rtdm/profiles/can" would be nice. Please also provide an
>> example input file.
> 
> Here is my rtcansendmulti.c:
> 
>              https://gist.github.com/dmd/5416474
> 
> 
> By default, it operates exactly the same as the current rtcansend (so
> this could just replace the existing rtcansend - there's no real
> reason to have both).

Well, simply duplicating code/file/features was also not my idea. Reduce
it to the useful minimum, e.g. remove reading from the command line,
remove "-c", "-s" etc.

> If a filename option is provided, it ignores any <can-msg> that may be
> present on the command line, and instead reads that file line at a
> time, treating each line as if it were a command line. The updated
> help should explain this:
> 
>     Usage: ./rtcansendmulti <can-interface> [Global Options] [<can-msg>]
> 
>     Global Options:
>       -f, --file=filename   filename to read from, or - for stdin
>                             <can-msg> will be ignored if a file is specified
>       -L, --loopback=0|1    switch local loopback off or on
>       -v, --verbose         be verbose
>       -t, --timeout=MS      timeout in ms
>       -s, --send            use send instead of sendto
>       -h, --help            this help
> 
>     Global Options OR any line in file:
>       -i, --identifier=ID   CAN Identifier (default = 1)
>       -d, --delay=MS        delay in ms (default = 1ms)
>       -r  --rtr             send remote request
>       -e  --extended        send extended frame
>       -l  --loop=COUNT      send message COUNT times
>       -c, --count           message count in data[0-3]
>       -p, --print=MODULO    print every MODULO message
> 
>     filename (or - for stdin) contains lines of the format:
>     [Options] [<can-msg>]
> 
>     Blank lines are ignored.
>     # comments out the remainder of a line.
> 
> 
> If an option is given on a particular line in a file, that option
> overrides the specified global option for that line only.
> 
> For example, I might have a file foo which contains:
> 
> # this is a comment
> -i 0x601 0x40 0x41 0x60 0x00 #this is another comment
> 0x40 0x41 0x60 0x00
> 
> And I run:
> rtcansendmulti rtcan0 -v -i 0x602 -f foo
> 
> I will see:
>     interface rtcan0
>     s=1, ifr_name=rtcan0
>     <0x601> [4] 40 41 60 00
>     <0x602> [4] 40 41 60 00
>     Cleaning up...
> 
> Note that the first line was sent to cobid 0x601 (specified on that
> line), and the second to globally specified 0x602.

I would prefer removing -i, -r, -e, etc. and add it as data:

 s 0x601 0x40 0x41 0x60 0x00   (standard frame)
 e 0x12345678 0x40 0x41        (extended frame)
 sr 0x601                      (standard rtr frame)
 er 0x3456778                  (extended rtr frame)

You could also fill an array of CAN messages instead of parsing the
lines every time.

What do you think?

Thanks,

Wolfgang.


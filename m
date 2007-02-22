Message-ID: <bc4264770702220641me28831ahd9e10cf1b689510c@domain.hid>
Date: Thu, 22 Feb 2007 14:41:27 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] hello xenomai world?
In-Reply-To: <45DD99D1.9000600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>
	<45DD7E00.8020505@domain.hid>
	<bc4264770702220456se1cb181r8aee5fde75c93db4@domain.hid>
	<45DD99D1.9000600@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

> See, you seem to manage choosing the complicated, non-standard way of
> doing things first. Now try to solve your issues one by one, not in
> arbitrary order.
:)  Its not quite as arbitrary as it may seem.

> 1. Make your kernel boot fine, including all desired modules, without
> having it issue any kind of error messages. Bootlogs are under /var/log,
> just look into those files.
All sorted out! Remember that the kernel was fine.  I could only
realized that something was missing when I tried rtcanconfig and I
could not find the /rtcan0 and /rtcan1. For someone entirely new to
both xenomai and rt-can its not surprising this take place. I stuck as
closely as possible to the default suggestion in the kernel config.
AFAIK the virtual device was not selected.


> 2. Check where you have installed the user space part. Default is
> /usr/xenomai, and for a first run it's probably wise to keep this.
Sorted! Absolutely, this is where I have had it installed all the
time. It seems to be in perfect shape.

> 3. Check if you can build the examples repository. If you installed the
> user space part to default location, it must work with only providing
> the "make KSRC=<path-to-kernel-src>" as described in the Makefile.
> Inside examples/native, you even just need to type "make".
Well this is not quite the case. I install to the correct places
actually I have from the start used the directories exactly as they
are suggested int he documentation. I have jsut reinstalled and the
make procedure seems fine. My install directory works and the programs
therein are now all functioning. Even rtcongi rtcansend and rtcanrecv.
Running make in /examples/native says

Invoke make like this: make /path to xeno-config/. Which is why I was
going on about the config variables. I wil now try and find
xeno-config if it exists and see how that works. On the other hand I
don;t doubt that the application will compile. I need to find out what
libraries to include for this particular one for the next steps. See
later.

The point being that 1, 2 and 3 have been completed in that order. To
lay out the structure of what is planned next:

4-Get a task ala trivial-task compiled into a qt C++ project. (for
which I need to know what libraries are required)

5-Write this task to read CAN messages ever 1 ms and write them to console.

6-Get multiple tasks into the project running at different times

I do understand your consternation, I have been very verbose on this list today.

Thanks for the assistance, I really do appreciate it.

Kind regards,

Roland.




>
> >
> > I am also looking at your url to the xenomai CAN documentation. Strangely
> > when I read about it there is looks a lot more friendly than in the
> > code or the utils.
> >
> > I will presume (and hope)  that what I have to do is just much simpler
> > than what Wolfgang is doing there :)
> >
> > I won;t be using printf in my final application I hope. It will be in
> > C++ with Qt and I fear I am going to battle my bum off to get that
> > going......
> >
>
> We can come back to this once the first part is working.
>
> Jan
>
>
>


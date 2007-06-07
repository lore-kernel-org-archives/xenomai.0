Message-ID: <1759.194.254.210.7.1181247030.squirrel@domain.hid>
Date: Thu, 7 Jun 2007 22:10:30 +0200 (CEST)
From: desvages@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] [Fwd: Re: real time task disapears... memory problem
 ?]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

>>> What kind of statistics would you precisely need? And where would you
need it, means where is your scheduler located, what API does it use?
>>
>> I need execution time (and not response time). A patch for this has
been create by a former student (now Doctor David Robert) working
before me.
>
> Hmm, the patch looks like it consequently reimplements existing runtime
statistics instead of reusing them as a foundation...
>
> Anyway, I think we could discuss some API extension of Xenomai (for
native, probably via rt_task_inquire). Likely we would keep this report
optional, ie. make it return -1 or so if CONFIG_XENO_OPT_STATS is off.
Tracking stats is not as costly as other instrumentations, but it's also
not free. If you are interested, let us know. It won't be a one-liner,
but it doesn't look like it has to be as invasive as your approach.

It can be interesting to have something like that. My tutor will probably
explain better than me what could be the best. I let him open a new topic
on this patch.

>> You can find it enclosed with this mail. Anyway the problem doesn't
come from this patch, it appears also with vanilla xenomai.
>
> OK.
>
>>
>>> Primarily code. We need your code that demonstrates the weird
>>> behaviour.
>>> If you patched Xenomai in any way, that patch would be required as
well of course.
>>
>> I have reduced the size of the code to the thing that is not working. =
You
>> can find it enclosed.
>> The main program creates a task that calls the gsl_qp function (a
quadratic solver).
>> The problem appends during the call of ql0001_. If I remove this call,=
 it
>> works. I if keep it, the task disapears without any error (I only see =
that
>> in /proc/xenomai/stat ).
>
> This sounds like some fault is triggered and your program simply
terminates on report of the same ("Hey, if I add that printf, my program
stops. What's wrong with printf?" -- You can't imagine how often I
already heard this. ;) ).
>
>>
>>> BTW, did you already try to attach gdb to your disappearing process?
Maybe it can catch what makes it terminate.
>> I have tried without success, but I don really know how to use it in t=
hat
>> way...
>
> You should compile it with "-g", start it with "gdb <your program>" (or
the graphical front-end "ddd"), simply let it "run" and wait what gdb
reports. It should really say /something/.

Yes I only know how to use ddd in fact, and the -g flag is used at compil=
e
time. And with ddd, no bug is found... I don't catch anything. The proble=
m
only appears when I launch the program  in console mode.
The thing I didn't really know how to use is the attach command of gdb,
that I have read on the web it can catch errors on program launched from
outside gdb. Am I wrong ?

>
> I can't help anyway, some files are missing, at least gsl/gsl_matrix.h.
If I shall have a look, I really need a smaller test-case, only
> including Xenomai interaction.
>

It's a mistake, I forgot to remove this unuseful include line. I have
tried to reduce the program at the minimum (some heap data allocation wit=
h
random values, and a call to the optimizer function that cause the
termination of the task). Normally you can remove this include, and there
will only stay xenomai calls...

>>
>> My config: (I have install the last availlable xenomai since last mail=
)
- Linux kernel : 2.6.20.3
>> - xenomai : 2.3.1
>> - Adeos : 1.7-03
>> - Laptop compact Evo N600c Pentium 3M 1.2Ghz
>>
>>> .config, Xenomai version, and I-pipe version can be helpful too.
>> .config is enclosed (DentiX231)
>>
>>
>>> Jan
>>
>> Thanks for your help
>>
>> Arnaud DESVAGES
>>
>
> Jan

Hope these new information will help to solve it.

Thanks again,

Arnaud DESVAGES






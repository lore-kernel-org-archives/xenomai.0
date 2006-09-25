Message-ID: <9FB3A1B49A25D711A70700A0C9E1FABC017145F8@domain.hid>
From: "Weber, Jeff" <JWeber@domain.hid>
Date: Mon, 25 Sep 2006 09:18:10 -0400
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai-help] RE: difficulties with simulator
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

>-----Original Message-----
>From: Philippe Gerum [mailto:rpm@xenomai.org]
> Subject: Re: [Xenomai-help] difficulties with simulator
>
>On Thu, 2006-09-21 at 17:54 -0400, Weber, Jeff wrote:

>> I am having considerable difficulties building and running
>> the Xenomai simulator.  My goals are to run Xenomai
>> real time applications under both the Valgrind memory debugger
>> and gdb.  Is the Xenomai simulator the only environment for
>> doing these?
>
>At the moment, yes. Making Valgrind aware of Xenomai syscalls so that it
>does not choke on them is on the todo list.

Are there other non-proprietary memory debuggers that currently work with
C++/Linux/Xenomai?

thanks,
Jeff


Message-ID: <bc4264770702220456se1cb181r8aee5fde75c93db4@domain.hid>
Date: Thu, 22 Feb 2007 12:56:22 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] hello xenomai world?
In-Reply-To: <45DD7E00.8020505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>
	<45DD7E00.8020505@domain.hid>
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

Thanks that looks a lot more comprehensible. I cannot make it however
it seems to rely on a big heap of XENOCONFIG things. Due to my live
setup those must have got lost. Are they stored somewhere (I see a
xeno_config file mentioned somewhere) and can I load them in some easy
manner? Otherwise where would be the best place to learn what they are
and how I must get them into the shell environment?

I am also looking at your url to the xenomai CAN documentation. Strangely
when I read about it there is looks a lot more friendly than in the
code or the utils.

I will presume (and hope)  that what I have to do is just much simpler
than what Wolfgang is doing there :)

I won;t be using printf in my final application I hope. It will be in
C++ with Qt and I fear I am going to battle my bum off to get that
going......

Roland


Roland.


On 2/22/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> roland Tollenaar wrote:
> > Hi,
> >
> > I must be making a big mistake. I am browsing through latency in
> > testsuit trying to learn how to set up some tasks that will execute at
> > regular intervals. I kind of had RTAI examples in mind which seemed
> > rather simple to me. Looking at the code in latency is a horrible
> > shock.
> >
> > Is it at all possible to explain in a couple of lines how a periodic
> > task can be run, lets say a hello world example that puts out the line
> > "hello xenomai world" exactly every 1ms?
>
> See examples/native/trivial-periodic.c
>
> Also read the comments. :)
>
> To overcome the latency issue of printf, there is some patch in sight:
>
> https://mail.gna.org/public/xenomai-core/2007-02/msg00087.html
>
> specifically
>
> https://mail.gna.org/public/xenomai-core/2007-02/msg00089.html
>
> Jan
>
>
>


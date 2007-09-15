Message-ID: <1ce16a2c0709151528j24bf1eb8o220c2a8832b0fe4a@domain.hid>
Date: Sun, 16 Sep 2007 00:28:50 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <1189894209.25006.193.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709151255r52e63d66s7d626390c9d97f97@domain.hid>
	<1189894209.25006.193.camel@domain.hid>
Subject: Re: [Xenomai-help] pipe example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

No change.
I've pasted the full output with used Makefile here: http://pastebin.ca/698972

My guess is that some header is missing or other support missing?

thanks.
/BK

On 16/09/2007, Philippe Gerum <rpm@xenomai.org> wrote:
> On Sat, 2007-09-15 at 21:55 +0200, Bachman Kharazmi wrote:
> > Hi Philippe,
> >
> > I'm testing the snippet example code from:
> > http://svn.gna.org/viewcvs/xenomai/trunk/ksrc/skins/native/snippets/pipe.c?rev=525&view=markup
> > without touching the code at all.
>
> Redirected to xenomai-help. Please always use the mailing list for such
> questions.
>
> >
> > But there seem to be issues during compile :/
> > sandbox:/home/bkw/code/driver_v5# make
> > gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> > -L/usr/xenomai/lib -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
> > /usr/xenomai/lib  simpledriver_v5.c   -o simpledriver_v5
> > simpledriver_v5.c:47: error: expected '=', ',', ';', 'asm' or
> > '__attribute__' before 'task_desc'
> > simpledriver_v5.c: In function 'task_body':
> > simpledriver_v5.c:51: error: 'RT_PIPE_MSG' undeclared (first use in
> > this function)
> > simpledriver_v5.c:51: error: (Each undeclared identifier is reported only once
> > simpledriver_v5.c:51: error: for each function it appears in.)
> > simpledriver_v5.c:51: error: 'msgout' undeclared (first use in this function)
> > simpledriver_v5.c:51: error: 'msgin' undeclared (first use in this function)
> > simpledriver_v5.c:69: warning: passing argument 1 of 'strcpy' makes
> > pointer from integer without a cast
> > simpledriver_v5.c:74: error: 'msg' undeclared (first use in this function)
> > simpledriver_v5.c: At top level:
> > simpledriver_v5.c:81: error: expected '=', ',', ';', 'asm' or
> > '__attribute__' before 'init_module'
> > simpledriver_v5.c: In function 'cleanup_module':
> > simpledriver_v5.c:106: error: 'task_desc' undeclared (first use in
> > this function)
> > make: *** [simpledriver_v5] Error 1
> >
> > Is the purpose that the example code should be more or less compilable?
> >
>
> No, as you can see, it looks like a boilerplate, basically because...it
> is a boilerplate.
>
> Here is a compilable one, made of two separate items: a kernel module,
> and a userland program, both communicating through a message pipe.
> Finding what this example does and how to compile it is left to your
> interpretation.
>
>
> > thanks,
> > Bachman
> --
> Philippe.
>
>
>


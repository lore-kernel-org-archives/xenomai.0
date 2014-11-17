MIME-Version: 1.0
In-Reply-To: <20141117071006.GO4656@sisyphus.hd.free.fr>
References: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
 <CA+C+_XQBJ21AuO-rzeia9tPvtkZV1CWcieJV43Tmr8pJnEaa4Q@mail.gmail.com>
 <20141117071006.GO4656@sisyphus.hd.free.fr>
Date: Mon, 17 Nov 2014 01:17:36 -0600
Message-ID: <CA+C+_XRfJ010E+oV+JKZ2rcfpF9euvDgGcMTR5h0cyS7gPqpMw@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Remote debug question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry.  Yes, 2.6.3.  Good to know about the EINTR though.  And I'll check
gdb and gdbserver versions tomorrow.  But I think I fixed most of my
problems, except for a few nagging gdb quirks.  Just a few things that
weren't inherently obvious and didn't appear in the Doxygen docs. Thanks.

On Mon, Nov 17, 2014 at 1:10 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Nov 16, 2014 at 06:22:22PM -0600, Mathew Benson wrote:
> > GDB:  GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
> > Target xeno-config:
> > xeno-config --verbose
> >         --version="2.6.3"
>
> So, that is xenomai 2.6.3, not xenomai 3.
>
> --
>                                             Gilles.
>

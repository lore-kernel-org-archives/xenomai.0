Date: Thu, 12 Oct 2017 10:33:45 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171012103345.04d854c2@md1em3qc>
In-Reply-To: <CADYdroM8E7jhuyRoW4JkSzZfGg27VvpjLmHGmMmX79wgEqPJog@mail.gmail.com>
References: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
 <20170810114956.04f62bc6@md1em3qc>
 <CADYdroM8E7jhuyRoW4JkSzZfGg27VvpjLmHGmMmX79wgEqPJog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Won`t build on new Debian Stable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>
Cc: norbert.lange@andritz.com, Xenomai <xenomai@xenomai.org>

Hey Norbert,

thanks for looking into that again! Could you please explain how and
why that works, or point out what to look at in flint? Mailing list
thread, commit, something like that.

As far as i can see gcc now gets a "-r" which i do not find in the
manpage. And ld gets a "-U" which i do not find in its manpage. And
there is something about c++ constructors which might change the
behaviour of xenomai.

Henning

Am Tue, 10 Oct 2017 16:38:50 +0200
schrieb Norbert Lange <nolange79@gmail.com>:

> Some highly trivial fix attached!
> Its strange that this flag is not documented in the manual (I found
> out abaout this fix from https://launchpad.net/ubuntu/+source/flint)
> 
> Norbert Lange
> 
> 2017-08-10 11:49 GMT+02:00 Henning Schild
> <henning.schild@siemens.com>:
> > Hi Norbert,
> >
> > Thanks! In fact that issue has come up before and a similar
> > workaround was described. It should be fixed, patches welcome!
> >
> > Henning
> >
> > Am Wed, 9 Aug 2017 16:21:02 +0200
> > schrieb Norbert Lange <nolange79@gmail.com>:
> >  
> >> Hello,
> >>
> >> Building the xenomai package won`t work because debian now
> >> defaults to using pie, and the linker will complain with "ld: -r
> >> and -pie may not be used together"
> >>
> >> A workaround for now is to add the flags manually:
> >> ../xenomai-3.0.5/configure LDFLAGS=-no-pie CFLAGS="-fno-PIE
> >> -fno-pie -no-pie"
> >>
> >> A real fix would be similar to
> >> http://lists.gnu.org/archive/html/bug-grub/2016-11/msg00011.html
> >> (no-pie is not supported on old and other compilers)
> >>
> >> Kind regards,
> >> Norbert
> >>
> >> _______________________________________________
> >> Xenomai mailing list
> >> Xenomai@xenomai.org
> >> https://xenomai.org/mailman/listinfo/xenomai  
> >  



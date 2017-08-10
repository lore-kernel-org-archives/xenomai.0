Date: Thu, 10 Aug 2017 11:49:56 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170810114956.04f62bc6@md1em3qc>
In-Reply-To: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
References: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
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
Cc: Xenomai <xenomai@xenomai.org>

Hi Norbert,

Thanks! In fact that issue has come up before and a similar workaround
was described. It should be fixed, patches welcome!

Henning

Am Wed, 9 Aug 2017 16:21:02 +0200
schrieb Norbert Lange <nolange79@gmail.com>:

> Hello,
> 
> Building the xenomai package won`t work because debian now defaults to
> using pie, and the linker will complain with "ld: -r and -pie may not
> be used together"
> 
> A workaround for now is to add the flags manually:
> ../xenomai-3.0.5/configure LDFLAGS=-no-pie CFLAGS="-fno-PIE -fno-pie
> -no-pie"
> 
> A real fix would be similar to
> http://lists.gnu.org/archive/html/bug-grub/2016-11/msg00011.html
> (no-pie is not supported on old and other compilers)
> 
> Kind regards,
> Norbert
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai



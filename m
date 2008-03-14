Message-ID: <d6c8ef150803140407j496a8d9ah477b001a49e411bf@domain.hid>
Date: Fri, 14 Mar 2008 12:07:40 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150803140404y1febc9e0g7c6ab90497b347d3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803140404y1febc9e0g7c6ab90497b347d3@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] New I-pipe patch for ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

Sorry, my fingers are faster than my mind. The same happens when I
remove rt_task_set_mode call. In the meantime, I realized that
T_PRIMARY is invalid for kernel based tasks. So... maybe this is a
bug? :)

On Fri, Mar 14, 2008 at 12:04 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi,
>
>  now, I have a problem with our application. It is using native skin,
>  when I start it I get:
>
>  kernel BUG at kernel/ipipe/core.c:322!
>  Xenomai: suspending kernel thread bf00b4e8 ('do_upg') at 0xc001db14
>  after exception #0
>
>  It looks to me that this happens after rt_task_set_mode(0, T_PRIMARY,
>  NULL) call in our module. Maybe something changed from 2.3.x Xenomai
>  to 2.4.x?
>
>  On Wed, Mar 12, 2008 at 5:23 PM, Gilles Chanteperdrix
>
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>
> > Hi,
>  >
>  >  as you may have already noticed, the ARM I-pipe patch for linux 2.6.24
>  >  is available on Adeos download site and in Xenomai svn.
>  >
>  >  This patch incorporates modifications of all boards code to adapt to
>  >  the ipipe_tickdev system which couples timer requests with Linux
>  >  clockevent/clocksource framework.
>  >
>  >  As usual, it is tested only on AT91RM9200 and only compile-tested for
>  >  other boards. So, it would be nice if people could test this new patch
>  >  on their board.
>  >
>  >  Thanks and regards.
>  >
>  >  --
>  >   Gilles Chanteperdrix
>  >
>  >  _______________________________________________
>  >  Adeos-main mailing list
>  >  Adeos-main@domain.hid
>  >  https://mail.gna.org/listinfo/adeos-main
>  >
>


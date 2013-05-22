MIME-Version: 1.0
In-Reply-To: <519CAAEB.5050307@xenomai.org>
References: <CAMDpcBGxGUCtcnREr9AeQihhiNO8D7vvxbFCa7647fOO4rMzow@mail.gmail.com>
	<51960FB1.9030400@xenomai.org>
	<CAMDpcBF84ZRLG=eeyhus5qE5+t5Smf_jETtVGUSC9r7iu62ARg@mail.gmail.com>
	<CAMDpcBF-EkDjQyXNY2OLeDTSEgPujBEr3Y1BNL27AEYRaJ068Q@mail.gmail.com>
	<51967FC3.9020409@xenomai.org>
	<CAMDpcBHtLDBTN16X4uriZ9jb+hamnvrbAK9H6JzbuDaQK137PQ@mail.gmail.com>
	<5198D5D4.50905@xenomai.org>
	<CAMDpcBGUxTYk=1+2oUY3R9Z0PpONiVU1+ZVSGuw6tH6TCgz-6w@mail.gmail.com>
	<519CAAEB.5050307@xenomai.org>
Date: Wed, 22 May 2013 15:50:13 +0200
Message-ID: <CAMDpcBGP5Hq_eP9qCEYaYNnEhfugEJQ-y_fRp7_n370Xp2QvmA@mail.gmail.com>
From: kunming yang <yangkunming99@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] <6>Xenomai: scheduling class idle registered.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks for your quick reply! It becomes more and more complicate!!! Apply a
patch is not that easy as I though before.


On Wed, May 22, 2013 at 1:24 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 05/22/2013 11:47 AM, kunming yang wrote:
>
> > Thanks!!!
> >
> > There is still many problems. Why does the kernel hang after several
> > minutes? Every time, it takes almost the same time to "die". What might
> > cause that? Thanks for help!
>
>
> The usual cause is if your hardware timer is of the "free-funning
> counter and match register" type, if you are programming the match
> register for a date in the past. In that case, the kernel will unblock
> when the free-running counter wraps. Another reason is if your tsc is
> not a 64 bits tsc, if you are not refreshing the tsc in kernel-space
> often enough (by calling __ipipe_tsc_update()).
>
> But there are many causes of lockups, the first reflex should be to add
> all the debugging issues. If the lockup is not replaced with an error
> message, please run cat /proc/interrupts and verify that all the
> interrupt controllers which appear in the dump have been checked as
> explained here:
>
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Interrupt_controller
>
> The interrupt controller name in the dump (third column if you only have
> one cpu), should help you find the code associated to this interrupt
> controller.
>
>
> --
>                                                                 Gilles.
>

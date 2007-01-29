Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
From: Victor Shulyak <V.I.Shulyak@domain.hid>
In-Reply-To: <1169852516.3346.77.camel@domain.hid>
References: <1169811995.462.13.camel@domain.hid>
	<1169827668.3346.61.camel@domain.hid>
	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
	<1169851606.3346.75.camel@domain.hid>  <1169852516.3346.77.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Jan 2007 18:23:29 +0600
Message-Id: <1170073409.26457.8.camel@domain.hid>
Mime-Version: 1.0
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
Cc: Xenomai help <xenomai@xenomai.org>

Hello


> > > > However, since there seem to be a clean backtrace, maybe we could give a
> > > > try anyway. Could you objdump your kernel image, then locate the faulty
> > > > routine containing eip=0xc7b84d51?
I can apply objdump to kernel modules, but when this utility was applied
to kernel image, error message is displayed
objdump: /boot/vmlinuz-xenomai: File format not recognized
How could I objdump my kernel image?


> > > Let's suppose we can believe in sanity of the call trace, then would
> > > you, Victor, provide a disassembled code for
> > > __ipipe_handle_exception() ?
> > >
I will do this with pleasure, one thing to know, which tools can help
me?


> > --- arch/i386/kernel/entry.S~	2006-12-16 13:32:29.000000000 +0100
> > +++ arch/i386/kernel/entry.S	2007-01-26 23:44:59.000000000 +0100
> > @@ -1032,7 +1032,7 @@
> >  	RING0_INT_FRAME
> >  	pushl $0			# no error code
> >  	CFI_ADJUST_CFA_OFFSET 4
> > -	pushl $do_divide_error
> > +	PUSH_XVEC(do_divide_error)
> 
> s,PUSH_XVEC,PUSH_XCODE,
> 
> >  	CFI_ADJUST_CFA_OFFSET 4
> >  	jmp error_code
> >  	CFI_ENDPROC

I did so.


Thanks, Victor


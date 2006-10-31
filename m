Subject: RE: [Xenomai-help] Kernel OOps large appl.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D711@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D711@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 16:25:38 +0100
Message-Id: <1162308339.4996.107.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 15:07 +0000, Daniel Schnell wrote:
> Philippe Gerum wrote:
> 
> > This means that you are linking your application with the POSIX skin
> > too. So your setup is UVM/psos library + POSIX skin support? 
> > Please send your Makefile, this should help understanding what's
> > bound to your application. 
> > 
> Simply forget anything related to pSOS. There is no pSOS call anymore
> inside the app.

Ok, I got this from your previous mail.

>  And we are not using pSOS skins and even have not
> compiled the pSOS skin into the Kernel. Only the POSIX skin is used and
> the native skin is compiled into the kernel so we can start the
> testsuite.
> We are using no modules. Everything is compiled into the kernel. See my
> last mail with the attached configuration.
> 
> Our build environment is built around SCONS, so a Makefile alone
> wouldn't be of any help. I rather would have to post the whole build
> system ;) I am using the options in /usr/xenomai/bin/xeno-config
> --posix-cflags and --posix-ldflags

Ok.

> 
> > The stack trace does not even match the wrapped nanosleep syscall, so
> > there is some strange interactions ongoing between the interfaces
> > used.  
> > 
> 
> What exactly you mean ?
> 

This means that when issuing a nanosleep call emulated over the POSIX
skin, the kernel should not exhibit the backtrace given. So there is
something strange happening. The context represented by the backtrace
looks like the app binding to the POSIX skin, which must have happened
way earlier automatically through the POSIX skin library constructor,
before your app could even emit any Xenomai syscall. I initially thought
of some mismatches between the POSIX skin and the UVM support related to
some pSOS emulation use, but as there is no UVM/pSOS in the picture, I
now understand that your environment is purely POSIX-based, so the
latter cannot happen.

IOW, something seems out of sync in your configuration. Does the
testsuite work on your board, and specifically the "cyclic" test?

> > The setup for a lite5200 hw on a Denx 2.4.25 kernel should work out
> > of the box. This is much more likely a software issue, maybe related
> > to the strangenesses above.  
> 
> We have our own 5200B board and the lite5200 setup doesn't work with our
> hardware. In fact we had to tweak u-boot quite a bit to make it run on
> the board.
> 
> 
> Regards,
> 
> Daniel.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTinYnaJjMj-9R=UJd1j7DzT3kCYGZNa=w4LwXzXZ@mail.gmail.com>
References: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
	<1285054174.4114.30.camel@domain.hid>
	<AANLkTinYnaJjMj-9R=UJd1j7DzT3kCYGZNa=w4LwXzXZ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Sep 2010 08:46:52 +0200
Message-ID: <1285138012.1661.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] t_getreg / t_setreg undefined references in
 pSOS+ skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-09-21 at 16:59 +0200, ronny meeus wrote:
> Hello
> 
> There was a small copy-paste issue in your code.
> In the file src/skins/psos+/task.c:
> 
> +u_long t_setreg(u_long tid, u_long regnum, u_long regvalue)
> +{
> +       return XENOMAI_SKINCALL3(__psos_muxid, __psos_t_setreg,
> +                                tid, regnum, regvalue);
> +}
> +
> +u_long t_getreg(u_long tid, u_long regnum, u_long *regvalue_r)
> +{
> +       return XENOMAI_SKINCALL3(__psos_muxid, __psos_t_setreg,
> +                                tid, regnum, regvalue_r);
> +}
> 
> The function t_getreg should use __psos_t_getreg instead of
> __psos_t_setreg.
> 
> Once I changed this, the code seems to work.
> 
> BTW I'm really impressed by the code-quality and responsiveness of the
> Xenomai community.

Ok, thanks. This patch is now on its way to upstream.

> 
> Best regards,
> Ronny
> 
> On Tue, Sep 21, 2010 at 9:29 AM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         
>         On Mon, 2010-09-20 at 22:42 +0200, ronny meeus wrote:
>         > Hello
>         >
>         > I see in the psos.h file the function declaration for both
>         the
>         > t_getreg and the t_setreg functions.
>         > Also in the psos kernel module I see functionality
>         available.
>         > What I miss it the references for both service calls in the
>         syscall.c
>         > file.
>         >
>         > This results in undefined references if I try to use the
>         service call
>         > in my application.
>         >
>         > Is there any patch available that solves my problem?
>         
>         
>         Untested:
>         http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=740e3b9e5f77588f3df010752c255ecd24adea4e
>         
>         >
>         > Thanks
>         > Ronny
>         > _______________________________________________
>         > Xenomai-help mailing list
>         > Xenomai-help@domain.hid
>         > https://mail.gna.org/listinfo/xenomai-help
>         
>         --
>         Philippe.
>         
>         
> 

-- 
Philippe.




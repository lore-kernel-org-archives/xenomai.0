Message-ID: <67b6b3430811210903l75b9fb6aj31e30fd4af749094@domain.hid>
Date: Fri, 21 Nov 2008 09:03:40 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D533634@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_104328_2464064.1227287020061"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
	<491C0B50.6030507@domain.hid>
	<67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
	<491D39E8.3090105@domain.hid>
	<67b6b3430811170927t74f809edg1b0c6aaf1a9d2709@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533618@domain.hid>
	<6d17f533257138813c350472d9527033.squirrel@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533634@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_104328_2464064.1227287020061
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I finally had a chance to patch 2.6.23.12 w/ Xenomai-2.4.5.  Both the simple
test and larger apps worked incorrectly (i.e. had the same floating point
issues as described before).   What should the next step be?


Thanks,

Mark



On Thu, Nov 20, 2008 at 5:51 AM, Steven Seeger <
sseeger@domain.hid> wrote:

> I believe that you did already post this. Just so you know the situation
> I don't work at Mark's company anymore. I just help them out from time
> to time. I'm about 800 miles away now so I don't know everything that
> he's done. I'll be sure to hound him about it today.
>
> Thanks,
> Steven
>
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: Thursday, November 20, 2008 5:44 AM
> > To: Steven Seeger
> > Cc: Mark Saiia; Gilles Chanteperdrix; xenomai@xenomai.org
> > Subject: RE: [Xenomai-help] fpu context switch issue
> >
> >
> > Steven Seeger wrote:
> > > Have there been any thoughts on this issue? We have reverted back to
> > > 2.6.23.12 with r3415 for now. Our apps (including the test I posted
> > > earlier) work in this older environment. We'd like to use the newer
> > > environment because many other bugs have been fixed.
> > >
> > >
> > >
> > > BTW, the older environment works correctly on both our geode boards.
> >
> > We need to know whether the issue comes from Xenomai or from the
> I-pipe.
> > So, to know this, we need you to test the 2.6.23 I-pipe patch with
> > Xenomai
> > 2.4.6.1. Unless I am mistaken and forgot to post a mail, I have
> already
> > asked you this.
> >
> > --
> >                     Gilles.
>
>

------=_Part_104328_2464064.1227287020061
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I finally had a chance to patch <a href="http://2.6.23.12">2.6.23.12</a> w/ Xenomai-2.4.5.&nbsp; Both the
simple test and larger apps worked incorrectly (i.e. had the same floating point
issues as described before).&nbsp;&nbsp; What should the next step be?<br><br><br>Thanks,<br><br>Mark<br><br><br><br><div class="gmail_quote">On Thu, Nov 20, 2008 at 5:51 AM, Steven Seeger <span dir="ltr">&lt;<a href="mailto:sseeger@domain.hid">sseeger@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I believe that you did already post this. Just so you know the situation<br>
I don&#39;t work at Mark&#39;s company anymore. I just help them out from time<br>
to time. I&#39;m about 800 miles away now so I don&#39;t know everything that<br>
he&#39;s done. I&#39;ll be sure to hound him about it today.<br>
<br>
Thanks,<br>
<div class="Ih2E3d">Steven<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Gilles Chanteperdrix [mailto:<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>]<br>
</div><div class="Ih2E3d">&gt; Sent: Thursday, November 20, 2008 5:44 AM<br>
&gt; To: Steven Seeger<br>
</div><div><div></div><div class="Wj3C7c">&gt; Cc: Mark Saiia; Gilles Chanteperdrix; <a href="mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
&gt; Subject: RE: [Xenomai-help] fpu context switch issue<br>
&gt;<br>
&gt;<br>
&gt; Steven Seeger wrote:<br>
&gt; &gt; Have there been any thoughts on this issue? We have reverted back to<br>
&gt; &gt; <a href="http://2.6.23.12" target="_blank">2.6.23.12</a> with r3415 for now. Our apps (including the test I posted<br>
&gt; &gt; earlier) work in this older environment. We&#39;d like to use the newer<br>
&gt; &gt; environment because many other bugs have been fixed.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; BTW, the older environment works correctly on both our geode boards.<br>
&gt;<br>
&gt; We need to know whether the issue comes from Xenomai or from the<br>
I-pipe.<br>
&gt; So, to know this, we need you to test the 2.6.23 I-pipe patch with<br>
&gt; Xenomai<br>
&gt; <a href="http://2.4.6.1" target="_blank">2.4.6.1</a>. Unless I am mistaken and forgot to post a mail, I have<br>
already<br>
&gt; asked you this.<br>
&gt;<br>
&gt; --<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
<br>
</div></div></blockquote></div><br>

------=_Part_104328_2464064.1227287020061--


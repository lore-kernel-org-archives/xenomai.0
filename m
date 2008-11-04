Message-ID: <67b6b3430811040929xe679a22k1c0f0dc3163452b1@domain.hid>
Date: Tue, 4 Nov 2008 09:29:39 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D5332B4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_36335_27647275.1225819779314"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
	<490F2F23.2080307@domain.hid>
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
	<49101BFF.3060908@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5332B4@domain.hid>
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
To: xenomai@xenomai.org

------=_Part_36335_27647275.1225819779314
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've noticed the same erroneous behavior when CONFIG_XENO_HW_FPU is enabled
and when it is disabled.  I don't know if this information is relevant or
not.  Is this expected behavior?

Mark Saiia


On Tue, Nov 4, 2008 at 7:38 AM, Steven Seeger <
sseeger@domain.hid> wrote:

> Hi Gilles. Please let me know if this is ok. This is the datasheet for
> the part.
>
> Steven
>
>
>
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: Tuesday, November 04, 2008 2:55 AM
> > To: Mark Saiia
> > Cc: Steven Seeger; xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] fpu context switch issue
> >
> > Mark Saiia wrote:
> > > Hello,
> > >
> > > The switchtest output is as follows.  This was run on 2.4.5 with
> > 2.6.26.3
> > > AMD Geode LX800 board.
> > > In order to get it to run, I had to remove modprobe xeno_native from
> > my
> > > start-up script.  I don't know if that is an expected requirement
> > prior to
> > > running the test.
> >
> > Just to understand what I am doing, would you, or anybody else, have a
> > datasheet from AMD with the details of Geode FPU handling ?
> >
> > --
> >                                                  Gilles.
>

------=_Part_36335_27647275.1225819779314
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve noticed the same erroneous behavior when CONFIG_XENO_HW_FPU is enabled and when it is disabled.&nbsp; I don&#39;t know if this information is relevant or not.&nbsp; Is this expected behavior?<br><br>Mark Saiia<br><br><br><div class="gmail_quote">
On Tue, Nov 4, 2008 at 7:38 AM, Steven Seeger <span dir="ltr">&lt;<a href="mailto:sseeger@domain.hid">sseeger@domain.hid</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Gilles. Please let me know if this is ok. This is the datasheet for<br>
the part.<br>
<div class="Ih2E3d"><br>
Steven<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Gilles Chanteperdrix [mailto:<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>]<br>
</div><div class="Ih2E3d">&gt; Sent: Tuesday, November 04, 2008 2:55 AM<br>
&gt; To: Mark Saiia<br>
&gt; Cc: Steven Seeger; <a href="mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br>
&gt; Subject: Re: [Xenomai-help] fpu context switch issue<br>
&gt;<br>
</div><div><div></div><div class="Wj3C7c">&gt; Mark Saiia wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; The switchtest output is as follows. &nbsp;This was run on 2.4.5 with<br>
&gt; <a href="http://2.6.26.3" target="_blank">2.6.26.3</a><br>
&gt; &gt; AMD Geode LX800 board.<br>
&gt; &gt; In order to get it to run, I had to remove modprobe xeno_native from<br>
&gt; my<br>
&gt; &gt; start-up script. &nbsp;I don&#39;t know if that is an expected requirement<br>
&gt; prior to<br>
&gt; &gt; running the test.<br>
&gt;<br>
&gt; Just to understand what I am doing, would you, or anybody else, have a<br>
&gt; datasheet from AMD with the details of Geode FPU handling ?<br>
&gt;<br>
&gt; --<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</div></div></blockquote></div><br>

------=_Part_36335_27647275.1225819779314--


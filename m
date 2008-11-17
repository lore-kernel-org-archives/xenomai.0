Message-ID: <67b6b3430811170927t74f809edg1b0c6aaf1a9d2709@domain.hid>
Date: Mon, 17 Nov 2008 09:27:29 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <491D39E8.3090105@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53992_18813301.1226942849844"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>
	<67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
	<491C0B50.6030507@domain.hid>
	<67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
	<491D39E8.3090105@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_53992_18813301.1226942849844
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just a quick update.  I haven't had a chance to do as you suggested (2.6.23
w/2.4.5), but will get to it when I have a chance.  My previous post was
incorrect.  The older version of the app was somewhat different.  We
recreated the environment that was on on the app backup flash with Xenomai
2.6.23.12 w/ Xenomai r3415.  The newer version of the app still  exhibits
floating point errors on this older platform.  Yet we ran the simple test
program numerous times on the older platform and did not see any incorrect
behavior.  I am attempting to make a determination as to what in the larger
app causes the floating point issue to arise.

Mark

On Fri, Nov 14, 2008 at 12:42 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Mark Saiia wrote:
> > Gilles,
> >
> > No noticeable difference using 2.4.5 w/ 2.6.26.3.  I was testing using
> the
> > app we first noticed the behavior on.  I will run the simple test program
> > tomorrow, but fully expect to see the erroneous behavior.  I also had the
> > chance to test the patch on a GX1 board, and noticed the error as well.
> We
> > have a version of the app, that I was testing today, running on
> 2.6.23.12 w/
> > Xenomai svn of around February 2008 (I don't have the revision number in
> > front of me at the moment) that works properly.
>
> Could you test 2.6.23 with Xenomai 2.4.5? This way we would know if we
> are looking for a problem in the I-pipe patch or in Xenomai.
>
> --
>                                             Gilles.
>

------=_Part_53992_18813301.1226942849844
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just a quick update.&nbsp; I haven&#39;t had a chance to do as you suggested (2.6.23 w/2.4.5), but will get to it when I have a chance.&nbsp; My previous post was incorrect.&nbsp; The older version of the app was somewhat different.&nbsp; We recreated the environment that was on on the app backup flash with Xenomai <a href="http://2.6.23.12">2.6.23.12</a> w/ Xenomai r3415.&nbsp; The newer version of the app still&nbsp; exhibits floating point errors on this older platform.&nbsp; Yet we ran the simple test program numerous times on the older platform and did not see any incorrect behavior.&nbsp; I am attempting to make a determination as to what in the larger app causes the floating point issue to arise.<br>
<br>Mark<br><br><div class="gmail_quote">On Fri, Nov 14, 2008 at 12:42 AM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Mark Saiia wrote:<br>
&gt; Gilles,<br>
&gt;<br>
&gt; No noticeable difference using 2.4.5 w/ <a href="http://2.6.26.3" target="_blank">2.6.26.3</a>. &nbsp;I was testing using the<br>
&gt; app we first noticed the behavior on. &nbsp;I will run the simple test program<br>
&gt; tomorrow, but fully expect to see the erroneous behavior. &nbsp;I also had the<br>
&gt; chance to test the patch on a GX1 board, and noticed the error as well. We<br>
&gt; have a version of the app, that I was testing today, running on <a href="http://2.6.23.12" target="_blank">2.6.23.12</a> w/<br>
&gt; Xenomai svn of around February 2008 (I don&#39;t have the revision number in<br>
&gt; front of me at the moment) that works properly.<br>
<br>
</div>Could you test 2.6.23 with Xenomai 2.4.5? This way we would know if we<br>
are looking for a problem in the I-pipe patch or in Xenomai.<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

------=_Part_53992_18813301.1226942849844--


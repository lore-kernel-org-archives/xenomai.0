Message-ID: <353969d40710021127l252638e7m5f298b603028a614@domain.hid>
Date: Tue, 2 Oct 2007 20:27:47 +0200
From: "Guillaume Gaudonville" <guillaume.gaudonville@domain.hid>
In-Reply-To: <1191342752.6019.30.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13755_32931403.1191349667896"
References: <353969d40709180729s54307285i983eb7cc24c90642@domain.hid>
	<1190138931.15100.22.camel@domain.hid> <1191341918.6019.25.camel@domain.hid>
	<1191342752.6019.30.camel@domain.hid>
Subject: Re: [Xenomai-help] Can't create more than one watchdog under
	vxworks skin
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
Cc: xenomai@xenomai.org

------=_Part_13755_32931403.1191349667896
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your help, it will be very useful.

2007/10/2, Philippe Gerum <rpm@xenomai.org>:
>
> On Tue, 2007-10-02 at 18:18 +0200, Philippe Gerum wrote:
> > On Tue, 2007-09-18 at 20:08 +0200, Philippe Gerum wrote:
> > > On Tue, 2007-09-18 at 16:29 +0200, Guillaume Gaudonville wrote:
> > > > Hi,
> > > >
> > > > I use Xenomai since a few time. I have to port an application
> > > > running under VxWorks on Linux. This application uses a lot of
> > > > watchdog
> > > > to delay job it has to do.
> > > >
> > > > When I use the function wdCreate under the VxWorks skin (in User
> > > > Space),
> > > > I am not able to create more than 1 watchdog. I watched to the
> > > > function implementation in
> > > > user space and I saw that when I call wdCreate, a task is created
> with
> > > > the name: wdserver.
> > > >
> > > > When I call wdCreate a second time, it returns me 0 because he can't
> > > > create
> > > > another task with the same name (wdServer). But my watchdog seems to
> > > > be created in
> > > > kernel space because I can see it
> > > > in /proc/xenomai/registry/vxworks/watchdog.
> > > >
> > > > Is it a mistake? If not, what is the reason for this behaviour?
> > > >
> > >
> > > The current implementation is definitely silly. It should create one
> > > server for all outstanding watchdogs.
> >
> > The attached patch against -rc3 does this.
> >
>
> Please note the ABI change; we need this to be able to notify a
> per-process watchdog server. As a consequence of this change, the
> VxWorks shared library version has been incremented.
>
> --
> Philippe.
>
>
>


-- 
Guillaume Gaudonville
E-mail: guillaume.gaudonville@domain.hid

------=_Part_13755_32931403.1191349667896
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your help, it will be very useful.<br><br><div><span class="gmail_quote">2007/10/2, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2007-10-02 at 18:18 +0200, Philippe Gerum wrote:<br>&gt; On Tue, 2007-09-18 at 20:08 +0200, Philippe Gerum wrote:<br>&gt; &gt; On Tue, 2007-09-18 at 16:29 +0200, Guillaume Gaudonville wrote:<br>&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>&gt; &gt; &gt; I use Xenomai since a few time. I have to port an application<br>&gt; &gt; &gt; running under VxWorks on Linux. This application uses a lot of<br>&gt; &gt; &gt; watchdog<br>&gt; &gt; &gt; to delay job it has to do.
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; When I use the function wdCreate under the VxWorks skin (in User<br>&gt; &gt; &gt; Space),<br>&gt; &gt; &gt; I am not able to create more than 1 watchdog. I watched to the<br>&gt; &gt; &gt; function implementation in
<br>&gt; &gt; &gt; user space and I saw that when I call wdCreate, a task is created with<br>&gt; &gt; &gt; the name: wdserver.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; When I call wdCreate a second time, it returns me 0 because he can&#39;t
<br>&gt; &gt; &gt; create<br>&gt; &gt; &gt; another task with the same name (wdServer). But my watchdog seems to<br>&gt; &gt; &gt; be created in<br>&gt; &gt; &gt; kernel space because I can see it<br>&gt; &gt; &gt; in /proc/xenomai/registry/vxworks/watchdog.
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Is it a mistake? If not, what is the reason for this behaviour?<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt; The current implementation is definitely silly. It should create one<br>&gt; &gt; server for all outstanding watchdogs.
<br>&gt;<br>&gt; The attached patch against -rc3 does this.<br>&gt;<br><br>Please note the ABI change; we need this to be able to notify a<br>per-process watchdog server. As a consequence of this change, the<br>VxWorks shared library version has been incremented.
<br><br>--<br>Philippe.<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Guillaume Gaudonville<br>E-mail: <a href="mailto:guillaume.gaudonville@domain.hid">guillaume.gaudonville@domain.hid</a>

------=_Part_13755_32931403.1191349667896--


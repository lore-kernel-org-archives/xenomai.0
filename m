Message-ID: <e4ef24880806151610s634307efi73c47695eadde067@domain.hid>
Date: Sun, 15 Jun 2008 16:10:57 -0700
From: "Rob Gubler" <rgubler@domain.hid>
In-Reply-To: <18517.40944.439081.634345@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22333_21849041.1213571457446"
References: <e4ef24880806151540r477dbe2bq6162a7b781c60f7e@domain.hid>
	<18517.40944.439081.634345@domain.hid>
Subject: Re: [Xenomai-help] CPU affinity on a per thread basis
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

------=_Part_22333_21849041.1213571457446
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Jun 15, 2008 at 4:04 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Rob Gubler wrote:
>  > Hello,
>  >
>  > I am using Xenomai 2.4.  I'd like to explicitly control which CPU a
>  > particular thread executes on.  The Xenomai POSIX skin documentation
> says to
>  > achieve this with
>  > pthread_attr_setaffinity_np(...)<%28
> http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29
> >my
>  > thread needs to be created in the kernel space. I just want to verify
>  > that this can not be accomplished in a user space thread?
>  >
>  > I found a post<
> https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html>a
>  > year or so ago about this that mentions CPU affinity using
>  > sched_setaffinity(...).  My understanding though is that this particular
>  > call sets the affinity for the entire process/task and doesn't allow
> thread
>  > specific CPU affinity control.  Is this true?
>
> The posix skin documentation only documents the kernel-space service,
> because there is no special need to implement these services in
> kernel-space: the libc already implements both
> pthread_attr_setaffinity_np and pthread_setaffinity_np
>


Thanks Gilles.  Did you mean:  "The posix skin documentation only documents
the kernel-space service, because there is no special need to implement
these services in **user-space** ..."  ??

-Rob

------=_Part_22333_21849041.1213571457446
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sun, Jun 15, 2008 at 4:04 PM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Rob Gubler wrote:<br>
&nbsp;&gt; Hello,<br>
&nbsp;&gt;<br>
&nbsp;&gt; I am using Xenomai 2.4. &nbsp;I&#39;d like to explicitly control which CPU a<br>
&nbsp;&gt; particular thread executes on. &nbsp;The Xenomai POSIX skin documentation says to<br>
&nbsp;&gt; achieve this with<br>
</div>&nbsp;&gt; pthread_attr_setaffinity_np(...)&lt;%28<a href="http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29" target="_blank">http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29</a>&gt;my<br>

<div class="Ih2E3d">&nbsp;&gt; thread needs to be created in the kernel space. I just want to verify<br>
&nbsp;&gt; that this can not be accomplished in a user space thread?<br>
&nbsp;&gt;<br>
</div>&nbsp;&gt; I found a post&lt;<a href="https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html" target="_blank">https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html</a>&gt;a<br>
<div class="Ih2E3d">&nbsp;&gt; year or so ago about this that mentions CPU affinity using<br>
&nbsp;&gt; sched_setaffinity(...). &nbsp;My understanding though is that this particular<br>
&nbsp;&gt; call sets the affinity for the entire process/task and doesn&#39;t allow thread<br>
&nbsp;&gt; specific CPU affinity control. &nbsp;Is this true?<br>
<br>
</div>The posix skin documentation only documents the kernel-space service,<br>
because there is no special need to implement these services in<br>
kernel-space: the libc already implements both<br>
pthread_attr_setaffinity_np and pthread_setaffinity_np<br></blockquote><div><br><br>Thanks Gilles.&nbsp; Did you mean:&nbsp; &quot;The posix skin documentation only documents the kernel-space service, 
because there is no special need to implement these services in <b>*user-space*</b> ...&quot;&nbsp; ??<br><br>-Rob <br></div></div><br>

------=_Part_22333_21849041.1213571457446--


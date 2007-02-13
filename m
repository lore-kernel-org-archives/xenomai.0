Message-ID: <e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
Date: Tue, 13 Feb 2007 12:49:25 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <45D0666C.8070409@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_55327_11481498.1171351165847"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D029B8.1030805@domain.hid>
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>
	<45D0666C.8070409@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_55327_11481498.1171351165847
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi the libnative error is solved but know when i make it gives me error
stating:

Makefile:312: .deps/mytask-mytask.Po: No such file or directory
make: *** No rule to make target `.deps/mytask-mytask.Po'.  Stop.


On 2/12/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Preetam Joshi wrote:
> > hi,
>
> Please keep the CC when replying (reply-to-all).
>
> >
> > Itried adding the options as shown in the example latency in the SVN
> > repository but the latency example as well as my example both gve the
> same
> > error stating
> >
> > make: *** No rule to make target `../../skins/native/libnative.la',
> needed
> > by `latency'.  Stop.
> > make: *** No rule to make target `../../skins/native/libnative.la',
> needed
> > by `mytask'.  Stop.
> >
>
> You are doing something wrong. Does the user space part build AND
> install cleanly? If yes, check out the examples repository next:
>
> svn co svn://svn.gna.org/svn/xenomai/branches/v2.3.x/examples
>
> Then try to build the native examples:
>
> # cd examples/native
> # make XENO=<path-to-xenomai-installation>
>
> This should work out-of-the-box. You can then add your own example here,
> only extending APPLICATIONS in examples/native/Makefile.
>
> Jan
>
>
>

------=_Part_55327_11481498.1171351165847
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi the libnative error is solved but know when i make it gives me error stating:<br><br>Makefile:312: .deps/mytask-mytask.Po: No such file or directory<br>make: *** No rule to make target `.deps/mytask-mytask.Po&#39;.&nbsp; Stop.
<br><br><br><div><span class="gmail_quote">On 2/12/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Preetam Joshi wrote:<br>&gt; hi,<br><br>Please keep the CC when replying (reply-to-all).<br><br>&gt;<br>&gt; Itried adding the options as shown in the example latency in the SVN<br>&gt; repository but the latency example as well as my example both gve the same
<br>&gt; error stating<br>&gt;<br>&gt; make: *** No rule to make target `../../skins/native/libnative.la&#39;, needed<br>&gt; by `latency&#39;.&nbsp;&nbsp;Stop.<br>&gt; make: *** No rule to make target `../../skins/native/libnative.la&#39;, needed
<br>&gt; by `mytask&#39;.&nbsp;&nbsp;Stop.<br>&gt;<br><br>You are doing something wrong. Does the user space part build AND<br>install cleanly? If yes, check out the examples repository next:<br><br>svn co svn://svn.gna.org/svn/xenomai/branches/v2.3.x/examples
<br><br>Then try to build the native examples:<br><br># cd examples/native<br># make XENO=&lt;path-to-xenomai-installation&gt;<br><br>This should work out-of-the-box. You can then add your own example here,<br>only extending APPLICATIONS in examples/native/Makefile.
<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_55327_11481498.1171351165847--


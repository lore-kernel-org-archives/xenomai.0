Message-ID: <f48df4840610091233o6dc127b8ua94f29eff0281d2d@domain.hid>
Date: Mon, 9 Oct 2006 21:33:32 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
Subject: Re: [Xenomai-help] Native API manual in PDF format?
In-Reply-To: <17705.13155.675021.10130@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31057_31711976.1160422412599"
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>
	<4512E4A3.9050303@domain.hid>
	<17705.13155.675021.10130@domain.hid>
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
Cc: xenomai@xenomai.org, David Betz <david.betz@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_31057_31711976.1160422412599
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/8/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Jan Kiszka wrote:
> > David Betz wrote:
> > > Is there a PDF version of the Native API manual available? I'd like to
> > > be able to print a copy for reference.
> >
> > You can generate your own version: Set "GENERATE_LATEX = YES" in
> > doc/doxygen/Doxygen.in, build the documentation (don't forget to enable
> > it on configure), go to doc/doxygen/latex in your build directory and
> > run "make". The result is refman.pdf, a >500 pages monster (2.5M) that
> > looks rather unhandy to me. Maybe one can tune things and drop out
> > parts, you may want to play a bit with doxygen.
>
> I split the 500 pages monster into four parts; nucleus, native skin,
> rtdm skin and posix skin. I temporarily put them at the address:
> http://download.gna.org/xenomai/doxygen/


I think these pdf documents are more than acceptable. They are people that
really like to have paper documents. Even if it is not perfect, it's already
a good start.

If nobody dislikes them, they could be commited in the repository.


I think it is a good idea.


--
>
>
>                                             Gilles Chanteperdrix.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--
Bruno Rouchouse

------=_Part_31057_31711976.1160422412599
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 10/8/06, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Jan Kiszka wrote:<br> &gt; David Betz wrote:<br> &gt; &gt; Is there a PDF version of the Native API manual available? I'd like to<br> &gt; &gt; be able to print a copy for reference.<br> &gt;<br> &gt; You can generate your own version: Set &quot;GENERATE_LATEX = YES&quot; in
<br> &gt; doc/doxygen/Doxygen.in, build the documentation (don't forget to enable<br> &gt; it on configure), go to doc/doxygen/latex in your build directory and<br> &gt; run &quot;make&quot;. The result is refman.pdf, a &gt;500 pages monster (
2.5M) that<br> &gt; looks rather unhandy to me. Maybe one can tune things and drop out<br> &gt; parts, you may want to play a bit with doxygen.<br><br>I split the 500 pages monster into four parts; nucleus, native skin,<br>
rtdm skin and posix skin. I temporarily put them at the address:<br><a href="http://download.gna.org/xenomai/doxygen/">http://download.gna.org/xenomai/doxygen/</a></blockquote><div><br>I think these pdf documents are more than acceptable. They are
people that really like to have paper documents. Even if it is not
perfect, it's already a good start.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">If nobody dislikes them, they could be commited in the repository.
</blockquote><div><br>I think it is a good idea.<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br><br>_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help
</a><br></blockquote></div><br>--<br>Bruno Rouchouse<br>

------=_Part_31057_31711976.1160422412599--


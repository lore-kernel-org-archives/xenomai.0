Message-ID: <560b19a70703121726m6a82bbebhc5d0ea9a42218b33@domain.hid>
Date: Tue, 13 Mar 2007 00:26:09 +0000
From: "Ze Manel" <zemanel@domain.hid>
Subject: Re: [Adeos-main] Kernel 2.6.20.2
In-Reply-To: <1173739658.15636.35.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18376_29127466.1173745569071"
References: <560b19a70703121100x2a4a751dt4fc87b0176c3d587@domain.hid>
	<17909.47427.625596.896918@domain.hid>
	<560b19a70703121502w10bedeb8o27114ccdcd7b57c@domain.hid>
	<1173739658.15636.35.camel@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

------=_Part_18376_29127466.1173745569071
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes that solve the problem. I compiled the kernel with the adeos patch.
Thank you all.

On 12/03/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Mon, 2007-03-12 at 22:02 +0000, Ze Manel wrote:
> > Sorry I didn't post it a second time, I patched kernel 2.6.20 and got
> > the error and then got the 2.6.20.2 (the latest stable version) I
> > thought it could have something to do, and got the same error, it was
> > not a repost, more like a clarification of the problem, or an update
> > on the problem.
> > Sorry if it didn't seem so.
>
> > My .config is attached
> > Thanks for the help
> >
>
> Switch on CONFIG_X86_PC instead of CONFIG_X86_GENERICARCH for now
> (Processor type and features -> sub-architecture type = PC-Compatible).
> This will work around the issue until it is solved in a later Adeos
> patch, and might even be more appropriate for your hardware.
>
> --
> Philippe.
>
>
>


-- 
<img> http://www.deec.uc.pt/common/img/deezoom.gif </img>

------=_Part_18376_29127466.1173745569071
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes that solve the problem. I compiled the kernel with the adeos patch.<br>Thank you all. <br><br><div><span class="gmail_quote">On 12/03/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">
rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Mon, 2007-03-12 at 22:02 +0000, Ze Manel wrote:<br>&gt; Sorry I didn&#39;t post it a second time, I patched kernel 
2.6.20 and got<br>&gt; the error and then got the <a href="http://2.6.20.2">2.6.20.2</a> (the latest stable version) I<br>&gt; thought it could have something to do, and got the same error, it was<br>&gt; not a repost, more like a clarification of the problem, or an update
<br>&gt; on the problem.<br>&gt; Sorry if it didn&#39;t seem so.<br><br>&gt; My .config is attached<br>&gt; Thanks for the help<br>&gt;<br><br>Switch on CONFIG_X86_PC instead of CONFIG_X86_GENERICARCH for now<br>(Processor type and features -&gt; sub-architecture type = PC-Compatible).
<br>This will work around the issue until it is solved in a later Adeos<br>patch, and might even be more appropriate for your hardware.<br><br>--<br>Philippe.<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>&lt;img&gt; 
<a href="http://www.deec.uc.pt/common/img/deezoom.gif">http://www.deec.uc.pt/common/img/deezoom.gif</a> &lt;/img&gt;

------=_Part_18376_29127466.1173745569071--


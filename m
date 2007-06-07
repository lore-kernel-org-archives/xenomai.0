Message-ID: <7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
Date: Thu, 7 Jun 2007 09:42:08 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4667AA4D.6070505@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26764_1974923.1181202128944"
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>
	<1181143109.17978.101.camel@domain.hid>
	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
	<4667AA4D.6070505@domain.hid>
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_26764_1974923.1181202128944
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok. I'll do this.

But I don't understand why the same application compiled without any links
with Xenomai give different results if there is Xenomai in the kernel.


On 6/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> >> Did you double-check that you were not testing Xenomai with the
> >> "vanilla" cyclictest, ie. the one without libpthread_rt
> dependencies...?
> >> See "ldd cyclictest" when in doubt.
> >
> > Yes, I did. I wanted to know performances of cyclictest without Xenomai
> to
> > compare.
> > And I thought that even with Xenomai in the kernel, I would have the
> same
> > result.
>
> Then re-read Philippe's comment please.
>
> If you want to test average performance, rather use something like
> lmbench.
>
> Jan
>
>
>

------=_Part_26764_1974923.1181202128944
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Ok. I&#39;ll do this.</div>
<div>&nbsp;</div>
<div>But I don&#39;t understand why the same application compiled without any links with Xenomai give different results if there is Xenomai in the kernel.<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 6/7/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt;&gt; Did you double-check that you were not testing Xenomai with the<br>&gt;&gt; &quot;vanilla&quot; cyclictest, ie. the one without libpthread_rt dependencies...?
<br>&gt;&gt; See &quot;ldd cyclictest&quot; when in doubt.<br>&gt;<br>&gt; Yes, I did. I wanted to know performances of cyclictest without Xenomai to<br>&gt; compare.<br>&gt; And I thought that even with Xenomai in the kernel, I would have the same
<br>&gt; result.<br><br>Then re-read Philippe&#39;s comment please.<br><br>If you want to test average performance, rather use something like lmbench.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_26764_1974923.1181202128944--


Message-ID: <b054e88e0810060628r7d4f18bnb78b33c6dda0048b@domain.hid>
Date: Mon, 6 Oct 2008 15:28:36 +0200
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <48EA1127.6030405@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_73357_25175277.1223299716851"
References: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>
	<48E3541E.8090808@domain.hid>
	<b054e88e0810030957l3e25a1beo8866a3e8f79d9e9b@domain.hid>
	<48E66224.7060709@domain.hid>
	<b054e88e0810031129o1638c19cr1a1d096da5169aee@domain.hid>
	<b054e88e0810060529u7c5189qd2853385e7ac64ce@domain.hid>
	<48EA1127.6030405@domain.hid>
Subject: Re: [Xenomai-help] Error while building Xenomai on Powerpc with
	instrument function entries enabled
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
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_73357_25175277.1223299716851
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you. There's no hurry actually, just reporting the bug.

If there's something I can do to help...

Giammarco


On Mon, Oct 6, 2008 at 3:22 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> Giammarco Zacheo wrote:
> > I can confirm that with vmalloc'ed buffers it hangs anyhow.
> >
>
> The issue you face is typical from the internal mcount() call referring to
> unmapped memory in early boot code. Some routine there lacks a "notrace"
> specifier. Finding it will require some work.
>
> > Giammarco
> >
> > On Fri, Oct 3, 2008 at 8:29 PM, Giammarco Zacheo <g.zacheo@domain.hid
> > <mailto:g.zacheo@domain.hid>> wrote:
> >
> >     I'm quite sure it was enabled. I will confirm it on Monday.
> >
> >     Giammarco
> >
> >
> >     On Fri, Oct 3, 2008 at 8:19 PM, Gilles Chanteperdrix
> >     <gilles.chanteperdrix@xenomai.org
> >     <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >
> >         Giammarco Zacheo wrote:
> >         > I was wrong. I am able to compile the kernel, but it hangs
> >         very early,
> >         > giving this output:
> >         >
> >         > zImage starting: loaded at 0x00400000 (sp: 0x017ffe50)
> >         > Allocating 0x590acc bytes for kernel ...
> >         > OF version = 'EFIKA5K2,1.3'
> >         > gunzipping (0x01800000 <- 0x00407000:0x00619b3b)...done
> >         0x4cd39c bytes
> >         >
> >         > Linux/PowerPC load: root=/dev/nfs rw
> >         nfsroot=192.168.10.122:/opt/eldk/ppc_6xx
> >         > ip=dhcp console=ttyPSC0
> >         > Finalizing device tree... using OF tree (promptr=01003ed8)
> >         > cpu_exception:
> >         > SRR0 0x0180B338 SRR1  0x00043030 MSR  0x00003030
> >         > LR   0x01C704B4 CTR   0x01800000 CR   0x42002042   XER 0x0
> >         > DAR  0x00000000 DSISR 0x00000000 Type 2
> >         > GPR[] 0x40000000 0x017FFE20 0x00000000 0x41820014 0x01C704B4
> >         0x42002042
> >         > 0xC04D0000 0x017FFD90
> >         > GPR[] 0x00000001 0x00625C04 0x07C00008 0x07C00008 0x42002044
> >         0x1004A33C
> >         > 0x01C647A0 0x017FFC2C
> >         > GPR[] 0x01BDCA4C 0x01BDCA6C 0x01BF66C4 0x01BDCA78 0x08000000
> >         0x01BDCA10
> >         > 0xFFFFFFFF 0x07C53FC8
> >         > GPR[] 0x01800000 0x00590ACC 0x07C548A8 0x00000000 0x00000000
> >         0x004062C8
> >         > 0x0040E134 0x00000000
> >         > ibat0U 0x00001FFF ibat0L 0x00000012
> >         > ibat1U 0xF0001FFF ibat1L 0xF0000012
> >         > ibat2U 0x00000000 ibat2L 0x00000000
> >         > ibat3U 0x00000000 ibat3L 0x00000000
> >         > dbat0U 0xF0001FFF dbat0L 0xF000002A
> >         > dbat1U 0x80001FFF dbat1L 0x8000002A
> >         > dbat2U 0x00001FFF dbat2L 0x00000012
> >         > dbat3U 0xC0001FFF dbat3L 0xC000002A
> >         > HID0 0x0000C000
> >         > deadend:
> >         >
> >         > Any hint about?
> >
> >         Did you try using vmalloc for the tracer logs ?
> >
> >
> >         --
> >                                                    Gilles.
> >
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
>
> --
> Philippe.
>

------=_Part_73357_25175277.1223299716851
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thank you. There&#39;s no hurry actually, just reporting the bug. <br><br>If there&#39;s something I can do to help...<br><br>Giammarco<br><br>&nbsp;<br><div class="gmail_quote">On Mon, Oct 6, 2008 at 3:22 PM, Philippe Gerum <span dir="ltr">&lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Giammarco Zacheo wrote:<br>
&gt; I can confirm that with vmalloc&#39;ed buffers it hangs anyhow.<br>
&gt;<br>
<br>
</div>The issue you face is typical from the internal mcount() call referring to<br>
unmapped memory in early boot code. Some routine there lacks a &quot;notrace&quot;<br>
specifier. Finding it will require some work.<br>
<div class="Ih2E3d"><br>
&gt; Giammarco<br>
&gt;<br>
&gt; On Fri, Oct 3, 2008 at 8:29 PM, Giammarco Zacheo &lt;<a href="mailto:g.zacheo@domain.hid">g.zacheo@domain.hid</a><br>
</div><div class="Ih2E3d">&gt; &lt;mailto:<a href="mailto:g.zacheo@domain.hid">g.zacheo@domain.hid</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; &nbsp; &nbsp; I&#39;m quite sure it was enabled. I will confirm it on Monday.<br>
&gt;<br>
&gt; &nbsp; &nbsp; Giammarco<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; On Fri, Oct 3, 2008 at 8:19 PM, Gilles Chanteperdrix<br>
&gt; &nbsp; &nbsp; &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a><br>
</div><div><div></div><div class="Wj3C7c">&gt; &nbsp; &nbsp; &lt;mailto:<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Giammarco Zacheo wrote:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; I was wrong. I am able to compile the kernel, but it hangs<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; very early,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; giving this output:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; zImage starting: loaded at 0x00400000 (sp: 0x017ffe50)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; Allocating 0x590acc bytes for kernel ...<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; OF version = &#39;EFIKA5K2,1.3&#39;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; gunzipping (0x01800000 &lt;- 0x00407000:0x00619b3b)...done<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; 0x4cd39c bytes<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; Linux/PowerPC load: root=/dev/nfs rw<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; nfsroot=192.168.10.122:/opt/eldk/ppc_6xx<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ip=dhcp console=ttyPSC0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; Finalizing device tree... using OF tree (promptr=01003ed8)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; cpu_exception:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; SRR0 0x0180B338 SRR1 &nbsp;0x00043030 MSR &nbsp;0x00003030<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; LR &nbsp; 0x01C704B4 CTR &nbsp; 0x01800000 CR &nbsp; 0x42002042 &nbsp; XER 0x0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; DAR &nbsp;0x00000000 DSISR 0x00000000 Type 2<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; GPR[] 0x40000000 0x017FFE20 0x00000000 0x41820014 0x01C704B4<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; 0x42002042<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; 0xC04D0000 0x017FFD90<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; GPR[] 0x00000001 0x00625C04 0x07C00008 0x07C00008 0x42002044<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; 0x1004A33C<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; 0x01C647A0 0x017FFC2C<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; GPR[] 0x01BDCA4C 0x01BDCA6C 0x01BF66C4 0x01BDCA78 0x08000000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; 0x01BDCA10<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; 0xFFFFFFFF 0x07C53FC8<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; GPR[] 0x01800000 0x00590ACC 0x07C548A8 0x00000000 0x00000000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; 0x004062C8<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; 0x0040E134 0x00000000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ibat0U 0x00001FFF ibat0L 0x00000012<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ibat1U 0xF0001FFF ibat1L 0xF0000012<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ibat2U 0x00000000 ibat2L 0x00000000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; ibat3U 0x00000000 ibat3L 0x00000000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; dbat0U 0xF0001FFF dbat0L 0xF000002A<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; dbat1U 0x80001FFF dbat1L 0x8000002A<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; dbat2U 0x00001FFF dbat2L 0x00000012<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; dbat3U 0xC0001FFF dbat3L 0xC000002A<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; HID0 0x0000C000<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; deadend:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; Any hint about?<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; Did you try using vmalloc for the tracer logs ?<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; --<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div><div class="Ih2E3d">&gt; ------------------------------------------------------------------------<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
</div>--<br>
<font color="#888888">Philippe.<br>
</font></blockquote></div><br></div>

------=_Part_73357_25175277.1223299716851--


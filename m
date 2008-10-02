Message-ID: <b054e88e0810020807j8784f7ak2360d1ed590b33d1@domain.hid>
Date: Thu, 2 Oct 2008 17:07:57 +0200
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <48E3541E.8090808@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8106_1449224.1222960077935"
References: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>
	<48E3541E.8090808@domain.hid>
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
To: Philippe Gerum <spam@domain.hid>, xenomai-help <xenomai@xenomai.org>

------=_Part_8106_1449224.1222960077935
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It worked. Thanks a lot.

Giammarco

On Wed, Oct 1, 2008 at 12:42 PM, Philippe Gerum <spam@domain.hid> wrote:

> Giammarco Zacheo wrote:
> > While building the kernel with I-Pipe Tracer turned on with "Instrument
> > function entries" enabled i got the following error:
> >
> > giammarco@domain.hid> make
> > make -C /home/giammarco/xenomai-ppc/linux-2.6-denx
> > O=/home/giammarco/xenomai-ppc/linux-2.6-denx-build/.
> >   Using /home/giammarco/xenomai-ppc/linux-2.6-denx as source for kernel
> >   GEN     /home/giammarco/xenomai-ppc/linux-2.6-denx-build/Makefile
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CALL
> > /home/giammarco/xenomai-ppc/linux-2.6-denx/scripts/checksyscalls.sh
> >   CHK     include/linux/compile.h
> >   CALL
> >
> /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/systbl_chk.sh
> >   CALL
> >
> /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/prom_init_check.sh
> > Error: External symbol '_mcount' referenced from prom_init.c
> > make[3]: *** [prom_init_check] Error 1
> > make[2]: *** [arch/powerpc/kernel] Error 2
> > make[1]: *** [sub-make] Error 2
> > make: *** [all] Error 2
> >
> > The machine the kernel is configured for is a bPlan Efika computer,
> > based on mpc5200b.
> >
> > I'm using DENX linux kernel 2.6.26, Xenomai 2.4.5, and a gcc 4.3.1.
> > <http://4.3.1.>
> >
>
> --- arch/powerpc/kernel/prom_init_check.sh~     2008-07-30
> 11:38:19.000000000 +0200
> +++ arch/powerpc/kernel/prom_init_check.sh      2008-10-01
> 12:39:47.000000000 +0200
> @@ -20,7 +20,7 @@
>  _end enter_prom memcpy memset reloc_offset __secondary_hold
>  __secondary_hold_acknowledge __secondary_hold_spinloop __start
>  strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
> -reloc_got2 kernstart_addr"
> +reloc_got2 kernstart_addr _mcount"
>
>  NM="$1"
>  OBJ="$2"
>
> > Thank you
> >
> > Giammarco
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

------=_Part_8106_1449224.1222960077935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">It worked. Thanks a lot.<br><br>Giammarco<br><br><div class="gmail_quote">On Wed, Oct 1, 2008 at 12:42 PM, Philippe Gerum <span dir="ltr">&lt;<a href="mailto:spam@domain.hid">spam@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">Giammarco Zacheo wrote:<br>
&gt; While building the kernel with I-Pipe Tracer turned on with &quot;Instrument<br>
&gt; function entries&quot; enabled i got the following error:<br>
&gt;<br>
&gt; giammarco@domain.hid&gt; make<br>
&gt; make -C /home/giammarco/xenomai-ppc/linux-2.6-denx<br>
&gt; O=/home/giammarco/xenomai-ppc/linux-2.6-denx-build/.<br>
&gt; &nbsp; Using /home/giammarco/xenomai-ppc/linux-2.6-denx as source for kernel<br>
&gt; &nbsp; GEN &nbsp; &nbsp; /home/giammarco/xenomai-ppc/linux-2.6-denx-build/Makefile<br>
&gt; &nbsp; CHK &nbsp; &nbsp; include/linux/version.h<br>
&gt; &nbsp; CHK &nbsp; &nbsp; include/linux/utsrelease.h<br>
&gt; &nbsp; CALL<br>
&gt; /home/giammarco/xenomai-ppc/linux-2.6-denx/scripts/checksyscalls.sh<br>
&gt; &nbsp; CHK &nbsp; &nbsp; include/linux/compile.h<br>
&gt; &nbsp; CALL<br>
&gt; /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/systbl_chk.sh<br>
&gt; &nbsp; CALL<br>
&gt; /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/prom_init_check.sh<br>
&gt; Error: External symbol &#39;_mcount&#39; referenced from prom_init.c<br>
&gt; make[3]: *** [prom_init_check] Error 1<br>
&gt; make[2]: *** [arch/powerpc/kernel] Error 2<br>
&gt; make[1]: *** [sub-make] Error 2<br>
&gt; make: *** [all] Error 2<br>
&gt;<br>
&gt; The machine the kernel is configured for is a bPlan Efika computer,<br>
&gt; based on mpc5200b.<br>
&gt;<br>
&gt; I&#39;m using DENX linux kernel 2.6.26, Xenomai 2.4.5, and a gcc <a href="http://4.3.1." target="_blank">4.3.1.</a><br>
</div></div>&gt; &lt;<a href="http://4.3.1" target="_blank">http://4.3.1</a>.&gt;<br>
&gt;<br>
<br>
--- arch/powerpc/kernel/prom_init_check.sh~ &nbsp; &nbsp; 2008-07-30 11:38:19.000000000 +0200<br>
+++ arch/powerpc/kernel/prom_init_check.sh &nbsp; &nbsp; &nbsp;2008-10-01 12:39:47.000000000 +0200<br>
@@ -20,7 +20,7 @@<br>
&nbsp;_end enter_prom memcpy memset reloc_offset __secondary_hold<br>
&nbsp;__secondary_hold_acknowledge __secondary_hold_spinloop __start<br>
&nbsp;strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224<br>
-reloc_got2 kernstart_addr&quot;<br>
+reloc_got2 kernstart_addr _mcount&quot;<br>
<br>
&nbsp;NM=&quot;$1&quot;<br>
&nbsp;OBJ=&quot;$2&quot;<br>
<br>
&gt; Thank you<br>
&gt;<br>
&gt; Giammarco<br>
&gt;<br>
&gt;<br>
&gt; ------------------------------------------------------------------------<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
</blockquote></div><br></div>

------=_Part_8106_1449224.1222960077935--


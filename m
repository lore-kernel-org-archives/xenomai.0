From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4B3CC62D.6070709@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4AF04886.9040903@domain.hid>
	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid>
	<4AF15D68.7060001@domain.hid>
	<873433.54790.qm@domain.hid>
	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>
	<20091215213210.19d5b6a5@domain.hid>
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
	<4B3CC62D.6070709@domain.hid>
Content-Type: multipart/related; type="multipart/alternative";
	boundary="=-igNf0Pzx1Q0zZO/OPPWH"
Date: Mon, 04 Jan 2010 20:14:06 -0200
Message-Id: <1262643246.20365.10.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
Reply-To: flavio.alves@domain.hid
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


--=-igNf0Pzx1Q0zZO/OPPWH
Content-Type: multipart/alternative; boundary="=-fLjqXCz4UtvHtO7MrCv3"


--=-fLjqXCz4UtvHtO7MrCv3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Gilles,

Thanks for your advice, now I could continue the porting.

After implementing the tips and tricks number 1, I could see again the
boot messages. The trace is the following:

<6>Xenomai: hal/arm
started.                                                    
<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon)
loaded.                   
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000 
<1>pgd =
c0004000                                                               
<1>[00000000]
*pgd=00000000                                                     
Internal error: Oops: 5 [#1]
PREEMPT                                            
Modules linked
in:                                                              
CPU: 0    Not tainted  (2.6.29-rc8-davinci1
#23)                                
PC is at __ipipe_mach_get_tsc
+0x28/0x64                                         
LR is at xnarch_get_cpu_time
+0x10/0x18                                          
pc : [<c0037514>]    lr : [<c0077d24>]    psr:
20000013                         
sp : c1c17e68  ip : c1c17e78  fp :
c1c17e74                                     
r10: c03e0f90  r9 : 00000000  r8 :
c03b95e8                                     
r7 : c03b95e8  r6 : 00000001  r5 : 00000000  r4 :
97a862f8                      
r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 :
97a862f8                      
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
kernel             
Control: 0005317f  Table: c0004000  DAC:
00000017                               
Process swapper (pid: 1, stack limit =
0xc1c16268)                              
Stack: (0xc1c17e68 to
0xc1c18000)                                               
7e60:                   c1c17e84 c1c17e78 c0077d24 c00374fc c1c17eb4
c1c17e88   
7e80: c007a62c c0077d24 00000000 00000000 c1c17eb4 c1c17ea0 00000000
c03e0f90   
7ea0: 00000001 c03e0fc8 c1c17f34 c1c17eb8 c007a9d4 c007a584 00500080
00000000   
7ec0: 00000000 0000011c 736f685b 69742d74 5d72656d 019bfc00 c0014348
c035fc94   
7ee0: 00000000 00000000 544f4f52 c1c17e00 c02d5d14 c0043a5c c1c17f1c
c1c17f2c   
7f00: c0075664 c03e0f58 00000000 c03e2ccc c03e2cd8 c03e2ce4 c03e2cf0
c03e2cfc   
7f20: 00000000 c03e2c80 c1c17f5c c1c17f38 c0083710 c007a700 c0024acc
00000000   
7f40: 00000000 c0083658 00000001 00000000 c1c17fd4 c1c17f60 c002d464
c0083668   
7f60: 00000000 c035c631 c03dc160 000000db c1c33000 00000000 00000000
00000000   
7f80: c1c17fac c1c17f90 c0106158 c0105e38 00000000 c1c33180 c1c17fc4
c03dc160   
7fa0: c1c17fc4 c1c17fb0 c0070f60 c01060e8 c0024978 c0024acc 00000000
00000000   
7fc0: 00000000 00000000 c1c17ff4 c1c17fd8 c00085a4 c002d418 00000000
00000001   
7fe0: 00000000 00000000 00000000 c1c17ff8 c0046638 c000852c fffdf7ff
ffeffedf   
Backtrace:                                                                      
[<c00374ec>] (__ipipe_mach_get_tsc+0x0/0x64) from [<c0077d24>]
(xnarch_get_cpu_)
[<c0077d14>] (xnarch_get_cpu_time+0x0/0x18) from [<c007a62c>]
(xnpod_enable_tim)
[<c007a574>] (xnpod_enable_timesource+0x0/0x17c) from [<c007a9d4>]
(xnpod_init+)
 r7:c03e0fc8 r6:00000001 r5:c03e0f90
r4:00000000                                
[<c007a6f0>] (xnpod_init+0x0/0x35c) from [<c0083710>]
(__native_skin_init+0xb8/)
[<c0083658>] (__native_skin_init+0x0/0x278) from [<c002d464>]
(do_one_initcall+)
[<c002d408>] (do_one_initcall+0x0/0x1a4) from [<c00085a4>] (kernel_init
+0x88/0x)
 r8:00000000 r7:00000000 r6:00000000 r5:00000000
r4:c0024acc                    
[<c000851c>] (kernel_init+0x0/0xfc) from [<c0046638>] (do_exit
+0x0/0x7e8)       

r4:00000000                                                                    
Code: 03a02000 03a03000 0a00000a e5922000
(e892000c)                            
<4>---[ end trace
da227214a82491b7 ]---                                         
<0>Kernel panic - not syncing: Attempted to kill
init!                          

Looking at the code (and perform some analysis) I saw that the call that
is crashing the kernel is:

 __asm__("ldmia %1, %M0\n":
	    "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));

And looking into the implementation of this function for other
platforms, I can see that it is the same instruction, without
difference.

In my implementation (port for the TI OMAP L-138 processor), I have
CONFIG_GENERIC_CLOCKEVENTS and CONFIG_GENERIC_TIME.

Could you please give me some advice about how to solve this issue?

Thank you for all your help.

Flavio

On Qui, 2009-12-31 at 16:41 +0100, Gilles Chanteperdrix wrote:

> Flavio de Castro Alves Filho wrote:
> > Hello,
> >  
> > I am currently working on the port of Xenomai for the TI OMAP L-138
> > processor (DaVinci platform). I didn't finish yet. As soon as I finish,
> > I will send the patch, and I intend to do so next week.
> >  
> > I followed the instructions from Xenomai's wiki page. Until now, I am
> > able to boot my ported kernel with the I-Pipe feature. When I build the
> > kernel with Xenomai feature, the kernel stops to boot.
> >  
> > I have some questions:
> >  
> > 1) How is the better way to debug the boot process? When my kernel stops
> > booting, after the message "Uncompressing .........." the boot halts. I
> > don't know what is going on and I don't know what to do in order to
> > follow the processes internally. Both debuggers (kernel and i-ipipe) are
> > enabled in the kernel configuration.
> 
> This is tips and tricks number 1:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks.
> 
> >  
> > 2) How tested the code must be done in order to send you a patch? Is
> > there any minimal set of tests that I should perform just before sending
> > you a patch for revision?
> 
> The validation tool I use is LTP. You can check that LTP returns the
> same results with a vanilla kernel, and with the Xenomai patched kernel
> when running LTP while a latency test is running. Unfortunately, to run
> ltp on low-end arms, I had to make a few local changes. Which means I am
> using an out-dated, patched version of LTP:
> http://sisyphus.hd.free.fr/~gilles/ltp-20081130-patched.tar.bz2
> 










Flavio de
Castro Alves
Filho
flavio.alves@domain.hid

Tel.: + 55 11
8494-5676
Embedded
Software
Services

www.phiinnovations.com











Escritórios::
São Paulo
Campinas



--=-fLjqXCz4UtvHtO7MrCv3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.24.1.1">
</HEAD>
<BODY>
Hello Gilles,<BR>
<BR>
Thanks for your advice, now I could continue the porting.<BR>
<BR>
After implementing the tips and tricks number 1, I could see again the boot messages. The trace is the following:<BR>
<BR>
&lt;6&gt;Xenomai: hal/arm started.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&lt;6&gt;Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&lt;1&gt;Unable to handle kernel NULL pointer dereference at virtual address 00000000 <BR>
&lt;1&gt;pgd = c0004000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&lt;1&gt;[00000000] *pgd=00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Internal error: Oops: 5 [#1] PREEMPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Modules linked in:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
CPU: 0&nbsp;&nbsp;&nbsp; Not tainted&nbsp; (2.6.29-rc8-davinci1 #23)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
PC is at __ipipe_mach_get_tsc+0x28/0x64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
LR is at xnarch_get_cpu_time+0x10/0x18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
pc : [&lt;c0037514&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;c0077d24&gt;]&nbsp;&nbsp;&nbsp; psr: 20000013&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
sp : c1c17e68&nbsp; ip : c1c17e78&nbsp; fp : c1c17e74&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
r10: c03e0f90&nbsp; r9 : 00000000&nbsp; r8 : c03b95e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
r7 : c03b95e8&nbsp; r6 : 00000001&nbsp; r5 : 00000000&nbsp; r4 : 97a862f8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
r3 : 00000001&nbsp; r2 : 00000000&nbsp; r1 : 00000000&nbsp; r0 : 97a862f8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Flags: nzCv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA ARM&nbsp; Segment kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Control: 0005317f&nbsp; Table: c0004000&nbsp; DAC: 00000017&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Process swapper (pid: 1, stack limit = 0xc1c16268)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Stack: (0xc1c17e68 to 0xc1c18000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
7e60:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c1c17e84 c1c17e78 c0077d24 c00374fc c1c17eb4 c1c17e88&nbsp;&nbsp; <BR>
7e80: c007a62c c0077d24 00000000 00000000 c1c17eb4 c1c17ea0 00000000 c03e0f90&nbsp;&nbsp; <BR>
7ea0: 00000001 c03e0fc8 c1c17f34 c1c17eb8 c007a9d4 c007a584 00500080 00000000&nbsp;&nbsp; <BR>
7ec0: 00000000 0000011c 736f685b 69742d74 5d72656d 019bfc00 c0014348 c035fc94&nbsp;&nbsp; <BR>
7ee0: 00000000 00000000 544f4f52 c1c17e00 c02d5d14 c0043a5c c1c17f1c c1c17f2c&nbsp;&nbsp; <BR>
7f00: c0075664 c03e0f58 00000000 c03e2ccc c03e2cd8 c03e2ce4 c03e2cf0 c03e2cfc&nbsp;&nbsp; <BR>
7f20: 00000000 c03e2c80 c1c17f5c c1c17f38 c0083710 c007a700 c0024acc 00000000&nbsp;&nbsp; <BR>
7f40: 00000000 c0083658 00000001 00000000 c1c17fd4 c1c17f60 c002d464 c0083668&nbsp;&nbsp; <BR>
7f60: 00000000 c035c631 c03dc160 000000db c1c33000 00000000 00000000 00000000&nbsp;&nbsp; <BR>
7f80: c1c17fac c1c17f90 c0106158 c0105e38 00000000 c1c33180 c1c17fc4 c03dc160&nbsp;&nbsp; <BR>
7fa0: c1c17fc4 c1c17fb0 c0070f60 c01060e8 c0024978 c0024acc 00000000 00000000&nbsp;&nbsp; <BR>
7fc0: 00000000 00000000 c1c17ff4 c1c17fd8 c00085a4 c002d418 00000000 00000001&nbsp;&nbsp; <BR>
7fe0: 00000000 00000000 00000000 c1c17ff8 c0046638 c000852c fffdf7ff ffeffedf&nbsp;&nbsp; <BR>
Backtrace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
[&lt;c00374ec&gt;] (__ipipe_mach_get_tsc+0x0/0x64) from [&lt;c0077d24&gt;] (xnarch_get_cpu_)<BR>
[&lt;c0077d14&gt;] (xnarch_get_cpu_time+0x0/0x18) from [&lt;c007a62c&gt;] (xnpod_enable_tim)<BR>
[&lt;c007a574&gt;] (xnpod_enable_timesource+0x0/0x17c) from [&lt;c007a9d4&gt;] (xnpod_init+)<BR>
 r7:c03e0fc8 r6:00000001 r5:c03e0f90 r4:00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
[&lt;c007a6f0&gt;] (xnpod_init+0x0/0x35c) from [&lt;c0083710&gt;] (__native_skin_init+0xb8/)<BR>
[&lt;c0083658&gt;] (__native_skin_init+0x0/0x278) from [&lt;c002d464&gt;] (do_one_initcall+)<BR>
[&lt;c002d408&gt;] (do_one_initcall+0x0/0x1a4) from [&lt;c00085a4&gt;] (kernel_init+0x88/0x)<BR>
 r8:00000000 r7:00000000 r6:00000000 r5:00000000 r4:c0024acc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
[&lt;c000851c&gt;] (kernel_init+0x0/0xfc) from [&lt;c0046638&gt;] (do_exit+0x0/0x7e8)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
 r4:00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
Code: 03a02000 03a03000 0a00000a e5922000 (e892000c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&lt;4&gt;---[ end trace da227214a82491b7 ]---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
&lt;0&gt;Kernel panic - not syncing: Attempted to kill init!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
<BR>
Looking at the code (and perform some analysis) I saw that the call that is crashing the kernel is:<BR>
<BR>
 __asm__(&quot;ldmia %1, %M0\n&quot;:<BR>
	&nbsp;&nbsp;&nbsp; &quot;=r&quot;(result.full): &quot;r&quot;(local_tsc), &quot;m&quot;(*local_tsc));<BR>
<BR>
And looking into the implementation of this function for other platforms, I can see that it is the same instruction, without difference.<BR>
<BR>
In my implementation (port for the TI OMAP L-138 processor), I have CONFIG_GENERIC_CLOCKEVENTS and CONFIG_GENERIC_TIME.<BR>
<BR>
Could you please give me some advice about how to solve this issue?<BR>
<BR>
Thank you for all your help.<BR>
<BR>
Flavio<BR>
<BR>
On Qui, 2009-12-31 at 16:41 +0100, Gilles Chanteperdrix wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Flavio de Castro Alves Filho wrote:
&gt; Hello,
&gt;  
&gt; I am currently working on the port of Xenomai for the TI OMAP L-138
&gt; processor (DaVinci platform). I didn't finish yet. As soon as I finish,
&gt; I will send the patch, and I intend to do so next week.
&gt;  
&gt; I followed the instructions from Xenomai's wiki page. Until now, I am
&gt; able to boot my ported kernel with the I-Pipe feature. When I build the
&gt; kernel with Xenomai feature, the kernel stops to boot.
&gt;  
&gt; I have some questions:
&gt;  
&gt; 1) How is the better way to debug the boot process? When my kernel stops
&gt; booting, after the message &quot;Uncompressing ..........&quot; the boot halts. I
&gt; don't know what is going on and I don't know what to do in order to
&gt; follow the processes internally. Both debuggers (kernel and i-ipipe) are
&gt; enabled in the kernel configuration.

This is tips and tricks number 1:
<A HREF="http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks">http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks</A>.

&gt;  
&gt; 2) How tested the code must be done in order to send you a patch? Is
&gt; there any minimal set of tests that I should perform just before sending
&gt; you a patch for revision?

The validation tool I use is LTP. You can check that LTP returns the
same results with a vanilla kernel, and with the Xenomai patched kernel
when running LTP while a latency test is running. Unfortunately, to run
ltp on low-end arms, I had to make a few local changes. Which means I am
using an out-dated, patched version of LTP:
<A HREF="http://sisyphus.hd.free.fr/~gilles/ltp-20081130-patched.tar.bz2">http://sisyphus.hd.free.fr/~gilles/ltp-20081130-patched.tar.bz2</A>

</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100">
<TR>
<TD ALIGN="left" VALIGN="bottom">
<IMG SRC="cid:1262642717.20365.0.camel@domain.hid" ALIGN="bottom" BORDER="0">
</TD>
<TD WIDTH="7" VALIGN="bottom">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</TD>
<TD WIDTH="188" VALIGN="bottom">
<B><FONT SIZE="1"><FONT COLOR="#5d9db5">Flavio de Castro Alves Filho</FONT></FONT></B><BR>
<FONT SIZE="1"><FONT COLOR="#000080"><A HREF="mailto:hayram.nicacio@domain.hid">flavio.alves@domain.hid.</A><A HREF="mailto:hayram.nicacio@domain.hid">com</A></FONT></FONT><BR>
<BR>
<FONT SIZE="1"><FONT COLOR="#272976">Tel.: + 55 11 8494-5676</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">Embedded Software Services</FONT></FONT><BR>
<BR>
<FONT SIZE="1"><FONT COLOR="#6f7072"><A HREF="http://www.phiinnovations.com">www.phiinnovations.com</A></FONT></FONT>
</TD>
<TD WIDTH="7" VALIGN="bottom">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</TD>
<TD WIDTH="69" VALIGN="bottom">
<FONT SIZE="1"><FONT COLOR="#6f7072">Escrit&#243;rios::</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">S&#227;o Paulo</FONT></FONT><BR>
<FONT SIZE="1"><FONT COLOR="#272976">Campinas</FONT></FONT>
</TD>
</TR>
</TABLE>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-fLjqXCz4UtvHtO7MrCv3--

--=-igNf0Pzx1Q0zZO/OPPWH
Content-ID: <1262642717.20365.0.camel@domain.hid>
Content-Disposition: attachment; filename="logo.gif"
Content-Type: image/gif; name="logo.gif"
Content-Transfer-Encoding: base64

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
6Zze6Z6+hEEAADs=


--=-igNf0Pzx1Q0zZO/OPPWH--



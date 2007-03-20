Message-ID: <fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>
Date: Tue, 20 Mar 2007 11:22:35 -0700
From: "Muruganandam Ganapathy" <muruganandam.ganapathy@domain.hid>
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
In-Reply-To: <17914.63535.18893.207257@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_260362_32481912.1174414955259"
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>
	<17914.63535.18893.207257@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_260362_32481912.1174414955259
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Muruganandam Ganapathy wrote:
> > Hello,
> >
> > I am new to Xenomai and trying to understand whether it is suitable for
> our
> > need.
> > We have a board based on ARM926EJ. I would like to know
> >
> >
> > 1. is there Xenomai support for ARM926
>
> Xenomai supports most ARM processor cores. For example, the ARM926 is
> supported with the ARM integrator board. The real question is: does it
> support the particular board you use ? If not, then all you have to do
> is to adapt the I-pipe patch to the board you use.
>
>
> >    I did google through and found that Xenomai is for the user
> application
> >    In our case, we have a kernel mode driver/application which is very
> time
> >    critical and we were unable to meet the timing requirement using the
> > regular kernel.
>
> No, Xenomai APIs exist both in kernel and user space and are symetrical
> as much as possible. So, it is up to you to choose if you want to
> program your application in kernel or user-space. Note however that for
> future-proof designs, it is recommended to only write driver code in
> kernel-space, using the RTDM API, and to write the rest of your
> application in user-space.
>
>
> >
> > 2. If support is available, what is the version to use. I am running
> 2.6.19
> >    on the board.
>
> 2.6.19 is only supported by the latest v2.3.x branch; since it has not
> yet been released you will have to download the sources via svn, by
> typing something like:
>
> svn co http://svn.gna.org/svn/xenomai/branches/v2.3.x xenomai
>
> Note that if the board you use is not supported, you will get undefined
> symbols building the kernel, and this is where your work will start:
> implementing the missing functions for the board you use. The missing
> functions concern hardware timer management, tsc emulation using the
> hardware timer, and interrupts demultiplexing. We can help you doing
> this work if you tell us which board you use.




The board is based on the Fujitsu SOC which has the ARM926EJ processor core.

This board has SPI, I2C and 10/100 ethernet interfaces and it can support
16/32MB SDRAM
and 4/8MB flash memory.


In addition, I would like to know the interrupt reponse  mesaured with
Xenomai in ARM9
processor based platforms, if any.
The interrupt response expected is around 40 -50 microseconds in our case.
The interrupt response I mean, it is the time between the generation of the
interrupt and the actual ISR invocation.


Whether use of Xenomai will enable us meet this timing reqirement.

Looking forward to hear from you.


Thanks
G.Muruganandam







--
>
>
>                                            Gilles Chanteperdrix.
>

------=_Part_260362_32481912.1174414955259
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 3/16/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Muruganandam Ganapathy wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I am new to Xenomai and trying to understand whether it is suitable for our
<br>&gt; need.<br>&gt; We have a board based on ARM926EJ. I would like to know<br>&gt;<br>&gt;<br>&gt; 1. is there Xenomai support for ARM926<br><br>Xenomai supports most ARM processor cores. For example, the ARM926 is<br>
supported with the ARM integrator board. The real question is: does it<br>support the particular board you use ? If not, then all you have to do<br>is to adapt the I-pipe patch to the board you use.<br><br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I did google through and found that Xenomai is for the user application
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;In our case, we have a kernel mode driver/application which is very time<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;critical and we were unable to meet the timing requirement using the<br>&gt; regular kernel.<br><br>No, Xenomai APIs exist both in kernel and user space and are symetrical
<br>as much as possible. So, it is up to you to choose if you want to<br>program your application in kernel or user-space. Note however that for<br>future-proof designs, it is recommended to only write driver code in<br>kernel-space, using the RTDM API, and to write the rest of your
<br>application in user-space.<br><br><br>&gt;<br>&gt; 2. If support is available, what is the version to use. I am running 2.6.19<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;on the board.<br><br>2.6.19 is only supported by the latest v2.3.x branch; since it has not
<br>yet been released you will have to download the sources via svn, by<br>typing something like:<br><br>svn co <a href="http://svn.gna.org/svn/xenomai/branches/v2.3.x">http://svn.gna.org/svn/xenomai/branches/v2.3.x</a> xenomai
<br><br>Note that if the board you use is not supported, you will get undefined<br>symbols building the kernel, and this is where your work will start:<br>implementing the missing functions for the board you use. The missing
<br>functions concern hardware timer management, tsc emulation using the<br>hardware timer, and interrupts demultiplexing. We can help you doing<br>this work if you tell us which board you use.</blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>The board is based on the Fujitsu SOC which has the ARM926EJ processor core. </div>
<div>This board has SPI, I2C and 10/100 ethernet interfaces and it can support 16/32MB SDRAM </div>
<div>and 4/8MB flash memory.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>In addition, I would like to know the interrupt reponse&nbsp; mesaured with Xenomai in ARM9</div>
<div>processor based platforms, if any. </div>
<div>The&nbsp;interrupt response&nbsp;expected is around 40 -50 microseconds in our case.</div>
<div>The interrupt response I mean, it is the time between the generation of the interrupt and the actual ISR invocation.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Whether use of Xenomai will enable us meet this timing reqirement. </div>
<div>&nbsp;</div>
<div>Looking forward to hear from you.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>G.Muruganandam</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_260362_32481912.1174414955259--


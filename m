In-Reply-To: <4E5B3C2C.7000503@domain.hid>
MIME-Version: 1.0
From: George Broz <GBroz@domain.hid>
Message-ID: <OF9BF5BF14.213BBBB0-ON882578FC.000C6A33-882578FC.000F90B7@domain.hid>
Date: Mon, 29 Aug 2011 19:45:21 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 000F8FD7882578FC_="
Subject: Re: [Xenomai-help] milli-second overruns under heavy load on x86,
 running Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--=_alternative 000F8FD7882578FC_=
Content-Type: text/plain; charset="US-ASCII"

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
08/29/2011 12:13:48 AM:

> On 08/26/2011 11:49 PM, George Broz wrote:
> >> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
> > 08/26/2011 02:18:05 PM:
> >> On 08/26/2011 10:42 PM, George Broz wrote:
> >>> Hello,
> >>>
> >>> I'm experiencing very large overruns in the neighborhood of 10 to 50 

> >>> *milli-seconds* as reported by the Xenomai latency tool in user-task 

> > mode 
> >>> whenever the Linux OS is heavily loaded. Under lighter loads these 
are 
> > in 
> >>> the 30 to 70 micro-second (normal) range. 
> >>>
> >>> My system is:
> >>> - Linux 2.6.37.6 (32-bit), Ubuntu 10.10 distribution
> >>> - Xenomai 2.5.6 using I-pipe patch adeos-ipipe-2.6.37.6-x86-2.9-02
> >>> - Intel x86 Atom (dual-core) CPU D510 @ 1.66GHz 
> >>> - Emb. dev board from Intel (ICH8M ctrlr, Ethernet h/w for e1000e)
> >>> - Xenomai configured w&w/o --enable-smp --enable-x86-tsc options
> >>> - gcc version 4.4.5
> >>>
> >>> I've followed all of the recommendations for kernel configuration 
and 
> > have 
> >>> disabled CPU sleep features in the BIOS such as SpeedStep and 
> > C-States. 
> >>> Legacy USB has been disabled in the BIOS. Hyperthreading has also 
been 
> > 
> >>> disabled, although I don't think it matters.
> >>
> >> Have you tried to enable the SMI workaround?
> >>
> >> -- 
> >> Gilles.
> >>
> > 
> > Yes - SMI workaround was enabled when the overruns were observed.
> 
> Could you try disabling CONFIG_SMP to see if you get the same behaviour,
> and take a few traces?
> If you processor supports 64 bits mode, could you try running a 64 bits
> kernel?
> 
> 
> -- 
>                                                                 Gilles.
> 

I disabled CONFIG_SMP and did not get the same behaviour - latencies were 
normal (albeit now slightly increased). The processor supports 64 bit 
mode, but my initial attempt to get that working failed (for unrelated 
reasons).

I then started looking at the hardware some more after Jan's comment, and 
found another CPU frequency throttling mechanism that exists in the Atom 
N450 and D510. This is the "thermal monitor" (TM1) as described in this 
Intel document: 
http://download.intel.com/embedded/processors/thermalguide/323439.pdf

Even though my dev. board had a fan, adding even more cooling 
significantly reduced the occurrence of the overruns (but they would still 
occur occasionally). I then disabled the thermal monitor (TM1) feature 
from the BIOS, and since then have not seen any more happen (after about 2 
hours of testing). I will test more tomorrow, and post if I see the 
problem still exists.

Thanks very much for your (and Jan's) help. 

--George
--=_alternative 000F8FD7882578FC_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><tt><font size=2>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;
wrote on 08/29/2011 12:13:48 AM:<br>
<br>
&gt; On 08/26/2011 11:49 PM, George Broz wrote:<br>
&gt; &gt;&gt; Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;
wrote on <br>
&gt; &gt; 08/26/2011 02:18:05 PM:<br>
&gt; &gt;&gt; On 08/26/2011 10:42 PM, George Broz wrote:<br>
&gt; &gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I'm experiencing very large overruns in the neighborhood
of 10 to 50 <br>
&gt; &gt;&gt;&gt; *milli-seconds* as reported by the Xenomai latency tool
in user-task <br>
&gt; &gt; mode <br>
&gt; &gt;&gt;&gt; whenever the Linux OS is heavily loaded. Under lighter
loads these are <br>
&gt; &gt; in <br>
&gt; &gt;&gt;&gt; the 30 to 70 micro-second (normal) range. <br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; My system is:<br>
&gt; &gt;&gt;&gt; - Linux 2.6.37.6 (32-bit), Ubuntu 10.10 distribution<br>
&gt; &gt;&gt;&gt; - Xenomai 2.5.6 using I-pipe patch adeos-ipipe-2.6.37.6-x86-2.9-02<br>
&gt; &gt;&gt;&gt; - Intel x86 Atom (dual-core) CPU D510 @ 1.66GHz <br>
&gt; &gt;&gt;&gt; - Emb. dev board from Intel (ICH8M ctrlr, Ethernet h/w
for e1000e)<br>
&gt; &gt;&gt;&gt; - Xenomai configured w&amp;w/o --enable-smp --enable-x86-tsc
options<br>
&gt; &gt;&gt;&gt; - gcc version 4.4.5<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I've followed all of the recommendations for kernel configuration
and <br>
&gt; &gt; have <br>
&gt; &gt;&gt;&gt; disabled CPU sleep features in the BIOS such as SpeedStep
and <br>
&gt; &gt; C-States. <br>
&gt; &gt;&gt;&gt; Legacy USB has been disabled in the BIOS. Hyperthreading
has also been <br>
&gt; &gt; <br>
&gt; &gt;&gt;&gt; disabled, although I don't think it matters.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Have you tried to enable the SMI workaround?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -- <br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; Gilles.<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; Yes - SMI workaround was enabled when the overruns were observed.<br>
&gt; <br>
&gt; Could you try disabling CONFIG_SMP to see if you get the same behaviour,<br>
&gt; and take a few traces?<br>
&gt; If you processor supports 64 bits mode, could you try running a 64
bits<br>
&gt; kernel?<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Gilles.<br>
&gt; <br>
</font></tt>
<br><tt><font size=2>I disabled CONFIG_SMP and did not get the same behaviour
- latencies were normal (albeit now slightly increased). The processor
supports 64 bit mode, but my initial attempt to get that working failed
(for unrelated reasons).</font></tt>
<br>
<br><tt><font size=2>I then started looking at the hardware some more after
Jan's comment, and found another CPU frequency throttling mechanism that
exists in the Atom N450 and D510. This is the &quot;thermal monitor&quot;
(TM1) as described in this Intel document: http://download.intel.com/embedded/processors/thermalguide/323439.pdf</font></tt>
<br>
<br><tt><font size=2>Even though my dev. board had a fan, adding even more
cooling significantly reduced the occurrence of the overruns (but they
would still occur occasionally). I then disabled the thermal monitor (TM1)
feature from the BIOS, and since then have not seen any more happen (after
about 2 hours of testing). I will test more tomorrow, and post if I see
the problem still exists.</font></tt>
<br>
<br><tt><font size=2>Thanks very much for your (and Jan's) help. </font></tt>
<br>
<br><tt><font size=2>--George</font></tt>
--=_alternative 000F8FD7882578FC_=--


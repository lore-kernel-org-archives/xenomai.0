Date: Fri, 22 Aug 2008 03:48:10 -0700 (PDT)
From: Stankiewicz Bredkjaer <stan.bred@domain.hid>
In-Reply-To: <48AE8620.4090307@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1594675846-1219402090=:92816"
Message-ID: <985677.92816.qm@domain.hid>
Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai
Reply-To: stan.bred@domain.hid
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

--0-1594675846-1219402090=:92816
Content-Type: text/plain; charset=us-ascii


Hi,

thanks for the quick answer. I think, I will follow your advice and first move to a vanilla Kernel and see how i can easily port the drivers if needed.

Regards,

Stan.

--- On Fri, 8/22/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai
To: stan.bred@domain.hid
Cc: xenomai@xenomai.org
Date: Friday, August 22, 2008, 7:25 PM

Stankiewicz Bredkjaer wrote:
> Hi all,
> 
> As a newbie with no experience with Xenomai, I would like to know if
> Texas Instruments Davinci Evaluation boards, especially the ARM926EJ
> arch. have been already ported? I'm working with the Davinci dm6467
> board and it is delivered with a montavista patched 2.6.10 Linux
> kernel on which I would like to install Xenomai. Is it possible? Is
> there something i have to know prior installing Xenomai on the Board?

Hi,

usually, adding an ARM board to the I-pipe patch is just a few days
work, and is documented in Xenomai wiki.

However, it is easy for vanilla kernels where the board-independent
infrastructure already exists, which means 2.6.1[4-5] or 2.6.2[0,4-6]

I have already heard about these davinci boards, and they seem to have a
lot of drivers. It is not easy, but I would advise you to migrate to the
latest kernel (2.6.26), port the drivers to this new kernel (this is the
non-easy part, because kernel APIs have a tendency to evolve rapidly
over time), then port Xenomai for your board.

Regards.

-- 
                                                 Gilles.



      
--0-1594675846-1219402090=:92816
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><br>Hi,<br><br>thanks for the quick answer. I think, I will follow your advice and first move to a vanilla Kernel and see how i can easily port the drivers if needed.<br><br>Regards,<br><br>Stan.<br><br>--- On <b>Fri, 8/22/08, Gilles Chanteperdrix <i>&lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">From: Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;<br>Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai<br>To: stan.bred@domain.hid<br>Cc: xenomai@xenomai.org<br>Date: Friday, August 22, 2008, 7:25 PM<br><br><pre>Stankiewicz Bredkjaer wrote:<br>&gt; Hi all,<br>&gt; <br>&gt; As a newbie with no experience with Xenomai, I would like to know if<br>&gt; Texas Instruments Davinci Evaluation boards, especially the ARM926EJ<br>&gt; arch. have been
 already ported? I'm working with the Davinci dm6467<br>&gt; board and it is delivered with a montavista patched 2.6.10 Linux<br>&gt; kernel on which I would like to install Xenomai. Is it possible? Is<br>&gt; there something i have to know prior installing Xenomai on the Board?<br><br>Hi,<br><br>usually, adding an ARM board to the I-pipe patch is just a few days<br>work, and is documented in Xenomai wiki.<br><br>However, it is easy for vanilla kernels where the board-independent<br>infrastructure already exists, which means 2.6.1[4-5] or 2.6.2[0,4-6]<br><br>I have already heard about these davinci boards, and they seem to have a<br>lot of drivers. It is not easy, but I would advise you to migrate to the<br>latest kernel (2.6.26), port the drivers to this new kernel (this is the<br>non-easy part, because kernel APIs have a tendency to evolve rapidly<br>over time), then port Xenomai for your board.<br><br>Regards.<br><br>-- <br>                           
                      Gilles.<br></pre></blockquote></td></tr></table><br>



      
--0-1594675846-1219402090=:92816--


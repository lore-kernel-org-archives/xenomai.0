Message-ID: <20060803231039.7184.qmail@domain.hid>
Date: Thu, 3 Aug 2006 16:10:39 -0700 (PDT)
From: shailesh joshi <zoshi_s@domain.hid>
Subject: Re: [Xenomai-help] Interrupt Problem.
In-Reply-To: <44D26C50.20000@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2112521151-1154646639=:7016"
Content-Transfer-Encoding: 8bit
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
Cc: xenomai@xenomai.org

--0-2112521151-1154646639=:7016
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

The board is custom made, the PCI card is of the make ADLink but has no Linux support. However, the same card worked for RTLinux, however, we had to drop the Idea for latency reasons. 
   
  i am guessing i am doing something wrong while initialising the handler. Like i said, the Card is generatimg the interript signal but linux is not acknowledging it, aka, the code does not enter the handler....I am using a sleep function in the user application but i guess that does not affect the RT code oder?? I am a beginner so I might be sounding very stupid. I request you to bare with me for the time being till i sharpen up.
   
  Regards,
  Shailesh.
   
  P.S: I am initialising the handler with rtdm_irq_request. Have also tried rthal_irq_request. Any suggestions there??
   
  Jan Kiszka <jan.kiszka@domain.hid> wrote:
  shailesh joshi wrote:
> Hello,
> 
> I am trying to interfce a DAQ board to a PC via a PCI card. I am facing the following problem:
> 
> I am trying to send an interrupt from the Board to the PC. However, the interrupt is only registered in the PCI cards internal registers and not by Xenomai, ie. the /proc/xenomai/ interface registers interrupt 10 in the list (namely, handler is being installed) but the count for both cpus remains at 0. 
> 
> To give a hint of the code, i am using a modified version of the RTDM driver example from captain.at. The only parts i haven't incorporated are those for MMAP, else the code is fast the same. Could anyone suggest what i might be doing wrong here??

Do you happen to have some standard Linux driver for your DAQ board?
Does it work on your target? Are you sure you correctly initialise and
enable IRQ delivery on the board?

BTW, already tried the irqbench the comes with recent Xenomai? Does it
work on your box (yet another IRQ delivery test, and it's RTDM based)?

Jan



 		
---------------------------------
Do you Yahoo!?
 Next-gen email? Have it all with the  all-new Yahoo! Mail Beta.
--0-2112521151-1154646639=:7016
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>The board is custom made, the PCI card is of the make ADLink but has no Linux support. However, the same card worked for RTLinux, however, we had to drop the Idea for latency reasons. </div>  <div>&nbsp;</div>  <div>i am guessing i am doing something wrong while initialising the handler. Like i said, the Card is generatimg the interript signal but linux is not acknowledging it, aka, the code does not enter the handler....I am using a sleep function in the user application but i guess that does not affect the RT code oder?? I am a beginner so I might be sounding very stupid. I request you to bare with me for the time being till i sharpen up.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Shailesh.</div>  <div>&nbsp;</div>  <div>P.S: I am initialising the handler with rtdm_irq_request. Have also tried rthal_irq_request. Any suggestions there??</div>  <div>&nbsp;</div>  <div><B><I>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq
 style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">shailesh joshi wrote:<BR>&gt; Hello,<BR>&gt; <BR>&gt; I am trying to interfce a DAQ board to a PC via a PCI card. I am facing the following problem:<BR>&gt; <BR>&gt; I am trying to send an interrupt from the Board to the PC. However, the interrupt is only registered in the PCI cards internal registers and not by Xenomai, ie. the /proc/xenomai/ interface registers interrupt 10 in the list (namely, handler is being installed) but the count for both cpus remains at 0. <BR>&gt; <BR>&gt; To give a hint of the code, i am using a modified version of the RTDM driver example from captain.at. The only parts i haven't incorporated are those for MMAP, else the code is fast the same. Could anyone suggest what i might be doing wrong here??<BR><BR>Do you happen to have some standard Linux driver for your DAQ board?<BR>Does it work on your target? Are you sure you correctly initialise and<BR>enable IRQ delivery on
 the board?<BR><BR>BTW, already tried the irqbench the comes with recent Xenomai? Does it<BR>work on your box (yet another IRQ delivery test, and it's RTDM based)?<BR><BR>Jan<BR><BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Do you Yahoo!?<br> Next-gen email? Have it all with the <a href="http://us.rd.yahoo.com/evt=42241/*http://advision.webevents.yahoo.com/handraisers"> all-new Yahoo! Mail Beta.</a>
--0-2112521151-1154646639=:7016--


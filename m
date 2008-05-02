Date: Fri, 02 May 2008 09:26:38 -0700
From: Thomas Schaefer <ThomasSchaefer@domain.hid>
Message-id: <d3c1a9c622573.481ade4e@domain.hid>
MIME-version: 1.0
Content-type: multipart/alternative; boundary=--69bdfb225bc01b25762
Content-language: en
Subject: Re: [Xenomai-help] MSI Interrupt Crash
Reply-To: thomasschaefer@domain.hid
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

----69bdfb225bc01b25762
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of
> Philippe Gerum
> Sent: Friday, May 02, 2008 8:02 AM
> To: Thomas Schaefer
> Cc: Jeff Koftinoff; xenomai@xenomai.org
> Subject: Re: [Xenomai-help] MSI Interrupt Crash
> 
> Thomas Schaefer wrote:
> >
> >> Does this help?
> >>
> >> --- include/asm-x86/wrappers_64.h    (revision 3719)
> >> +++ include/asm-x86/wrappers_64.h    (revision 3720)
> >> @@ -31,8 +31,8 @@
> >>  #define rthal_irq_descp(irq)        (irq_desc + irq)
> >>  #define rthal_irq_desc_status(irq)  (rthal_irq_descp(irq)->status)
> >>
> >> -#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> >>> enable(irq); 0; })
> >> -#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> >>> disable(irq); 0; })
> >> +#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> >>> unmask(irq); 0; })
> >> +#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> >>> mask(irq); 0; })
> >>  #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)-
> >>> ipipe_end(irq, rthal_irq_descp(irq));
> >> 0; })
> >>
> >>  typedef irq_handler_t rthal_irq_host_handler_t;
> >
> > We are using the current version from the SVN repository and those
> > changes are already in there.
> >
> 
> Please send the output back:
> 
> 
> --
> Philippe.

Here it is:

Xenomai: NULL unmask handler for irq 248, chip none (->enable=ffffffff8026f480)


Thomas

----69bdfb225bc01b25762
Content-Type: text/html; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

<DIV>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; -----Original Message-----</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Philippe Gerum</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Sent: Friday, May 02, 2008 8:02 AM</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT size=2><FONT face="Courier New">&gt; To: <?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><st1:PersonName w:st="on">Thomas Schaefer</st1:PersonName></FONT></FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Cc: <st1:PersonName w:st="on">Jeff Koftinoff</st1:PersonName>; xenomai@xenomai.org</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Subject: Re: [Xenomai-help] MSI Interrupt Crash</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; <st1:PersonName w:st="on">Thomas Schaefer</st1:PersonName> wrote:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; Does this help?</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; --- include/asm-x86/wrappers_64.h<SPAN style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </SPAN>(revision 3719)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; +++ include/asm-x86/wrappers_64.h<SPAN style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </SPAN>(revision 3720)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; @@ -31,8 +31,8 @@</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>#define rthal_irq_descp(irq)<SPAN style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>(irq_desc + irq)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>#define rthal_irq_desc_status(irq)<SPAN style="mso-tab-count: 1">&nbsp; </SPAN>(rthal_irq_descp(irq)-&gt;status)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; -#define rthal_irq_chip_enable(irq)<SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>({ rthal_irq_descp(irq)-&gt;chip-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;&gt; enable(irq); 0; })</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; -#define rthal_irq_chip_disable(irq)<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>({ rthal_irq_descp(irq)-&gt;chip-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;&gt; disable(irq); 0; })</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; +#define rthal_irq_chip_enable(irq)<SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>({ rthal_irq_descp(irq)-&gt;chip-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;&gt; unmask(irq); 0; })</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; +#define rthal_irq_chip_disable(irq)<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>({ rthal_irq_descp(irq)-&gt;chip-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;&gt; mask(irq); 0; })</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>#define rthal_irq_chip_end(irq)<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>({ rthal_irq_descp(irq)-</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;&gt; ipipe_end(irq, rthal_irq_descp(irq));</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt; 0; })</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>typedef irq_handler_t rthal_irq_host_handler_t;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt; We are using the current version from the SVN repository and those</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt; changes are already in there.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; &gt;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Please send the output back:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; </FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; --</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>&gt; Philippe.</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>Here it is:</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>Xenomai: NULL unmask handler for irq 248, chip none (-&gt;enable=ffffffff8026f480)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2></FONT>&nbsp;</P>
<P class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New" size=2>Thomas</FONT></P></DIV>

----69bdfb225bc01b25762--


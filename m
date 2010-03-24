Date: Wed, 24 Mar 2010 10:54:13 +0800 (CST)
From: robert165 <robert165@domain.hid>
Message-ID: <2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>
In-Reply-To: <4BA8F900.5000602@domain.hid>
References: <4BA8F900.5000602@domain.hid> <4BA39C3D.1040802@domain.hid>
	<4BA4EF75.7010202@domain.hid> <4BA74820.2090401@domain.hid>
	<4BA8752E.8090407@domain.hid> <4BA8C15E.5050707@domain.hid>
	<4BA8F517.3060705@domain.hid> <4BA8F732.10206@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_171999_23513692.1269399253416"
Subject: [Xenomai-help] Problem in irq_handle
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-help <xenomai@xenomai.org>

------=_Part_171999_23513692.1269399253416
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi Jan,
I am new to xenomai, I am writing a gpio driver based on  your "RTDM skeleton v1.1". There is a problem that when I complied and run your skeleton in a at91rm9200 broad with TIMERINT, the output is not show one line one second but very fast. The problem is still whenever I changed the following codes in demo_interrupt()
 
#ifdef TIMERINT
        if (events > XXX){
                rtdm_event_signal(&ctx->irq_event);
                 event=0;
          }
       ...
      events++;
 
And, it seems likely in my own irq_handle of a gpio irq. When the irq arrive, the irq_handle repeats many times. Should I mask the same irq in irq_handle? I did it by write the PIO interrupt mask register, but no effect.
 
Best wishes.
 
Luo

------=_Part_171999_23513692.1269399253416
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<DIV>Hi Jan,</DIV>
<DIV>I am new to xenomai, I&nbsp;am writing a gpio driver&nbsp;based on &nbsp;your "RTDM skeleton v1.1". There is a problem that when I complied and run your skeleton in a at91rm9200 broad with TIMERINT, the output is not show&nbsp;one line&nbsp;one second but very fast. The problem is still whenever I changed the following codes in demo_interrupt()</DIV>
<DIV>&nbsp;</DIV>
<DIV>#ifdef TIMERINT</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (events &gt; XXX){</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_event_signal(&amp;ctx-&gt;irq_event);</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event=0;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; events++;</DIV>
<DIV>&nbsp;</DIV>
<DIV>And, it seems likely in my own irq_handle of a gpio irq. When the irq arrive, the irq_handle repeats many times. Should I mask the same irq in irq_handle? I did it by write the PIO interrupt mask register, but no effect.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Best wishes.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Luo<BR></DIV><br><br><span title="neteasefooter"/></span>
------=_Part_171999_23513692.1269399253416--



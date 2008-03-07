Message-ID: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
Date: Fri, 7 Mar 2008 14:26:09 +0100
From: "axel axel" <softaxel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_436_7401719.1204896369520"
Subject: [Xenomai-core] WIRED INTERRUPT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_436_7401719.1204896369520
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i used the xenomai kernel side interrupt handler in this mode:

err = rt_intr_create( &rtFujInt, INTFUJITSUNAME, IRQFUJITSU, isrIntFujitsu ,
NULL, 0 );
if ( err != 0 )
{
   printk( "Impossible to create interrupt handler: %d\n", err );
   return 1;
}

STARTIRQ();


I saw with the oscilloscope that there is a significant latency ( max ~110us
on ARM ep9315 ) before executing the first instruction of the handler
"isrIntFujitsu".
I listen that eventually i can use WIRED interrupt that is more fast.

How can i use it ?


Thanks for all

Roberto Bielli

------=_Part_436_7401719.1204896369520
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi,<br><br>i used the xenomai kernel side interrupt handler in this mode:<br><br>err = rt_intr_create( &amp;rtFujInt, INTFUJITSUNAME, IRQFUJITSU, isrIntFujitsu , NULL, 0 );<br>if ( err != 0 )<br>{<br>&nbsp;&nbsp; printk( &quot;Impossible to create interrupt handler: %d\n&quot;, err );<br>
&nbsp;&nbsp; return 1;<br>}<br><br>STARTIRQ();<br><br><br>I saw with the oscilloscope that there is a significant latency ( max ~110us on ARM ep9315 ) before executing the first instruction of the handler &quot;isrIntFujitsu&quot;.<br>
I listen that eventually i can use WIRED interrupt that is more fast. <br><br>How can i use it ? <br><br><br>Thanks for all<br><br>Roberto Bielli<br> 

------=_Part_436_7401719.1204896369520--


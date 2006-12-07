Message-ID: <OF0E0E01F1.79314A79-ONC125723D.002F4B91-C125723D.004B0598@domain.hid>
From: juergen.lanner@domain.hid
Date: Thu, 7 Dec 2006 14:39:25 +0100
MIME-Version: 1.0
Content-type: multipart/related; 
	Boundary="0__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01"
Subject: [Xenomai-help] problems using rt_queue_alloc: returns 0 although
 enough memory available (xenomai 2.2.3)
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

--0__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01
Content-type: multipart/alternative; 
	Boundary="1__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01"

--1__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01
Content-type: text/plain; charset=US-ASCII


Hi gentlemen!

I had a problem with real time queues recently and want to know if I
understood something wrong or if it is a real problem.

The problem was that I couldn't alloc enough memory for my message in the
internal buffer before sending it.

I tried to bring some light into the problem by printing the data I get
from rt_queue_inquire to see the queue's state in more detail.
But this seems ok (at least from my point of view)

Did anybody see the problem as well? What could be the reason?

Thanx

juergen






it works this way (buffer size is 4*4096 bytes)

    int err = rt_queue_create(&g_qevents, "qevents", 4*4096, Q_UNLIMITED,
Q_SHARED|Q_PRIO);

[FM]   Name = qevents, #waiters = 1, #msg = 0, qlimit = 0, poolsize =
20480, mode = 513
[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 60

[FM]   Name = qevents, #waiters = 0, #msg = 0, qlimit = 0, poolsize =
20480, mode = 513
[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 8


but doesn't work this way: (buffer size half the size of before but should
be sufficient anyway since I want to alloc only 8 Byte for my msg)

    int err = rt_queue_create(&g_qevents, "qevents", 2*4096, Q_UNLIMITED,
Q_SHARED|Q_PRIO);

[FM]   Name = qevents, #waiters = 0, #msg = 0, qlimit = 0, poolsize =
12288, mode = 513
[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 8
[FM]   __sendEvent: rt_queue_alloc() failed. requested len = 8


code trying to alloc memory in buffer

      // lets look
            {
            RT_QUEUE_INFO oInfo;
            if (0 == rt_queue_inquire(&m_qEvents, &oInfo))
                  {
                  fm_debug("Name = %s, #waiters = %d, #msg = %d, qlimit =
%d, poolsize = %d, mode = %d",
                               oInfo.name, oInfo.nwaiters, oInfo.nmessages,
oInfo.qlimit, oInfo.poolsize, oInfo.mode);
                  }
            else
                  {
                  fm_debug("cannot get info from queue to find problem");
                  }
            }
      fm_debug("__sendEvent: rt_queue_alloc() try to alloc len = %d", len);
    msg = rt_queue_alloc(&m_qEvents, len);
    if (!msg)
      {
      fm_debug("__sendEvent: rt_queue_alloc() failed. requested len = %d",
len);





Juergen Lanner
Software Development
Datacon Technology GmbH
Tel.: +43 5337 600-403
www.datacon.at

IMPORTANT: The contents of this email and any attachments are confidential.
They are intended for the named recipient(s) only.
If you have received this email in error, please notify the system manager
or the sender immediately and do not disclose the contents to anyone or
make copies thereof.

--1__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font face="Arial">Hi gentlemen!</font><br>
<br>
<font face="Arial">I had a problem with real time queues recently and want to know if I understood something wrong or if it is a real problem.</font><br>
<br>
<font face="Arial">The problem was that I couldn't alloc enough memory for my message in the internal buffer before sending it.</font><br>
<br>
<font face="Arial">I tried to bring some light into the problem by printing the data I get from rt_queue_inquire to see the queue's state in more detail.</font><br>
<font face="Arial">But this seems ok (at least from my point of view)</font><br>
<br>
<font face="Arial">Did anybody see the problem as well? What could be the reason?</font><br>
<br>
<font face="Arial">Thanx</font><br>
<br>
<font face="Arial">juergen</font><br>
<br>
<br>
<br>
<br>
<br>
<br>
<font face="Arial">it works this way (buffer size is 4*4096 bytes)</font><br>
<br>
<tt>&nbsp; &nbsp; int err = rt_queue_create(&amp;g_qevents, &quot;qevents&quot;, 4*4096, Q_UNLIMITED, Q_SHARED|Q_PRIO);</tt><br>
<br>
<font face="Arial">[FM]   Name = qevents, #waiters = 1, #msg = 0, qlimit = 0, poolsize = 20480, mode = 513</font><br>
<font face="Arial">[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 60</font><br>
<br>
<font face="Arial">[FM]   Name = qevents, #waiters = 0, #msg = 0, qlimit = 0, poolsize = 20480, mode = 513</font><br>
<font face="Arial">[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 8</font><br>
<br>
<br>
<font face="Arial">but doesn't work this way: (buffer size half the size of before but should be sufficient anyway since I want to alloc only 8 Byte for my msg)</font><br>
<br>
<tt>&nbsp; &nbsp; int err = rt_queue_create(&amp;g_qevents, &quot;qevents&quot;, 2*4096, Q_UNLIMITED, Q_SHARED|Q_PRIO);</tt><br>
<br>
<font face="Arial">[FM]   Name = qevents, #waiters = 0, #msg = 0, qlimit = 0, poolsize = 12288, mode = 513</font><br>
<font face="Arial">[FM]   __sendEvent: rt_queue_alloc() try to alloc len = 8</font><br>
<font face="Arial">[FM]   __sendEvent: rt_queue_alloc() failed. requested len = 8</font><br>
<br>
<br>
<font face="Arial">code trying to alloc memory in buffer</font><br>
<br>
<tt>	// lets look</tt><br>
<tt>		{</tt><br>
<tt>		RT_QUEUE_INFO oInfo;</tt><br>
<tt>		if (0 == rt_queue_inquire(&amp;m_qEvents, &amp;oInfo))</tt><br>
<tt>			{</tt><br>
<tt>			fm_debug(&quot;Name = %s, #waiters = %d, #msg = %d, qlimit = %d, poolsize = %d, mode = %d&quot;,</tt><br>
<tt>					 oInfo.name, oInfo.nwaiters, oInfo.nmessages, oInfo.qlimit, oInfo.poolsize, oInfo.mode);</tt><br>
<tt>			}</tt><br>
<tt>		else</tt><br>
<tt>			{</tt><br>
<tt>			fm_debug(&quot;cannot get info from queue to find problem&quot;);</tt><br>
<tt>			}</tt><br>
<tt>		}</tt><br>
<tt>	fm_debug(&quot;__sendEvent: rt_queue_alloc() try to alloc len = %d&quot;, len);</tt><br>
<tt>&nbsp; &nbsp; msg = rt_queue_alloc(&amp;m_qEvents, len);</tt><br>
<tt>&nbsp; &nbsp; if (!msg)</tt><br>
<tt>	{</tt><br>
<tt>	fm_debug(&quot;__sendEvent: rt_queue_alloc() failed. requested len = %d&quot;, len);</tt><br>
<br>
<font face="Arial"><br>
</font><br>
<img src="cid:1__=4EBBF8AEDFBCCD018f9e8a93df938@domain.hid" width="120" height="71"><font face="Arial"><br>
<br>
Juergen Lanner <br>
Software Development <br>
Datacon Technology GmbH <br>
Tel.: +43 5337 600-403 </font><u><font face="Arial"><br>
</font></u><a href="http://www.datacon.at/"><u><font face="Arial">www.datacon.at</font></u></a><font face="Arial"> <br>
</font><br>
<i><font face="Arial">IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. <br>
If you have received this email in error, please notify the system manager or the sender immediately and do not disclose the contents to anyone or make copies thereof. </font></i><br>
<font face="Arial"><br>
</font></body></html>

--1__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01--


--0__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01
Content-type: image/gif; 
	name="21956275.gif"
Content-Disposition: inline; filename="21956275.gif"
Content-ID: <1__=4EBBF8AEDFBCCD018f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlheABHAPcAAACcSgClSgClUgClWgCtUgCtWgCtYwitWgitYxCtYxCtaxC1axitaxi1ayG1
ayG1cym1czExMTG1ezG9czG9ezkxMTkxOTk5OTm9ezm9hEI5OUI5QkJCQkK9hEK9jELGhEpKSkrG
jFJKSlJKUlJSUlLGjFLGlFpSUlpSWlpaWlrGlFrGnGNaY2NjY2POlGPOnGtra2vOnHNrc3Nzc3PO
pXPWpXtzc3tze3t7e3vOrXvWpXvWrYR7e4R7hISEhITWrYTWtYyEhIyEjIyMjIzWrYzWtZSUlJTe
tZTevZTexpyUnJycnJzevZzexqWcnKWcpaWlpaXexqXnxq2lra2tra3nxq3nzrWttbW1tbXnzr21
tb21vb29vb3nzr3n1r3vzr3v1sa9vca9xsbGxsbv1sbv3s7Gzs7Ozs7v3s7v59bOztbW1tbv59b3
597e3t7359737+fn5+f35+f37+f39+f/7+/v7+/37+//9/fv9/f39/f/9/f/////9///////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////ywAAAAAeABHAAAI/gD9CBxI
sKDBgwgTKlzIsKHDhxAjSpxIsaLFixgzatzIsaPHjyBDihxJsqTJkyhTqlwZkU+fgi/9oGEDk46X
gTH98DHYZydPmD4HBiWYkyhMnAz3II14B0iHDi8OdvgB08uAgzljBqXBxI/WngqZPAXyEs8LqHd0
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

--0__=4EBBF8AEDFBCCD018f9e8a93df938690918c4EBBF8AEDFBCCD01--



Message-ID: <54b161f50611030603m2ca82ff5uda2f874ba0ccc4bb@domain.hid>
Date: Fri, 3 Nov 2006 15:03:50 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27235_20278687.1162562630203"
Subject: [Xenomai-help] -EPERM from message queue
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

------=_Part_27235_20278687.1162562630203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

my application creates and deletes some message queues like the following
(pseudo-code):

for (i = 0; i < max_queues; i++)
{
  rt_queue_create(&(queues[i]), queue_name+i, 15kb, etc);
}

// sleep for a few seconds

for (i = 0; i < max_queues; i++)
{
  rt_queue_delete(&(queues[i]));
}

The strange thing is that everything goes fine, except for the deletion of
the very last queue. It doesn't matter how many queues I try, every time
only the last one doesn't get deleted.

This seems a bit strange to me, does anyone has experience with this
'problem'?

Thanks very much.

Best regards,

Frits

------=_Part_27235_20278687.1162562630203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br>
<br>
my application creates and deletes some message queues like the following (pseudo-code):<br>
<br>
for (i = 0; i &lt; max_queues; i++)<br>
{<br>
&nbsp; rt_queue_create(&amp;(queues[i]), queue_name+i, 15kb, etc);<br>
}<br>
<br>
// sleep for a few seconds<br>
<br>
for (i = 0; i &lt; max_queues; i++)<br>
{<br>
&nbsp; rt_queue_delete(&amp;(queues[i]));<br>
}<br>
<br>
The strange thing is that everything goes fine, except for the deletion
of the very last queue. It doesn't matter how many queues I try, every
time only the last one doesn't get deleted.<br>
<br>
This seems a bit strange to me, does anyone has experience with this 'problem'? <br>
<br>
Thanks very much.<br>
<br>
Best regards,<br>
<br>
Frits<br>

------=_Part_27235_20278687.1162562630203--


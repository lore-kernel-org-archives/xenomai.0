Message-ID: <54b161f50611030613y283e9999s492c580f4157c816@domain.hid>
Date: Fri, 3 Nov 2006 15:13:09 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
In-Reply-To: <54b161f50611030603m2ca82ff5uda2f874ba0ccc4bb@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27407_14577715.1162563189105"
References: <54b161f50611030603m2ca82ff5uda2f874ba0ccc4bb@domain.hid>
Subject: [Xenomai-help] Re: -EPERM from message queue
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

------=_Part_27407_14577715.1162563189105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/3/06, Frits de Klark <mailing.xenomai@domain.hid> wrote:
>
> Hello everyone,
>
> my application creates and deletes some message queues like the following
> (pseudo-code):
>
> for (i = 0; i < max_queues; i++)
> {
>   rt_queue_create(&(queues[i]), queue_name+i, 15kb, etc);
> }
>
> // sleep for a few seconds
>
> for (i = 0; i < max_queues; i++)
> {
>   rt_queue_delete(&(queues[i]));
> }
>
> The strange thing is that everything goes fine, except for the deletion of
> the very last queue. It doesn't matter how many queues I try, every time
> only the last one doesn't get deleted.
>
> This seems a bit strange to me, does anyone has experience with this
> 'problem'?
>

Ok now. I have found the problem. It was the old 'out of range' programming
mistake. It didn't came to my mind earlier because creation of the queue
goes alright. Ah well, another 'problem' solved.

Thanks anyway :D

Best regards,

Frits

------=_Part_27407_14577715.1162563189105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/3/06, <b class="gmail_sendername">Frits de Klark</b> &lt;<a href="mailto:mailing.xenomai@domain.hid">mailing.xenomai@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
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
This seems a bit strange to me, does anyone has experience with this 'problem'? <span class="sg"><br>

</span></blockquote></div><br>
Ok now. I have found the problem. It was the old 'out of range'
programming mistake. It didn't came to my mind earlier because creation
of the queue goes alright. Ah well, another 'problem' solved.<br>

<br>

Thanks anyway :D<br>

<br>

Best regards,<br>
<br>
Frits<br>
<br>

------=_Part_27407_14577715.1162563189105--


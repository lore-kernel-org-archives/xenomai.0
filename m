Message-ID: <e39c9190707300602i43d94665v33adf44a9870e757@domain.hid>
Date: Mon, 30 Jul 2007 15:02:50 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <46ADC051.7020608@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_28124_33133205.1185800570428"
References: <e39c9190707291316l237d572btd75f570d39ab75e@domain.hid>
	<46ADC051.7020608@domain.hid>
Subject: Re: [Xenomai-help] RTDM driver hints
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

------=_Part_28124_33133205.1185800570428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan..
On 7/30/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Before going into details on how to pass references between driver tasks
> etc.:
>
> Why do you want to establish a dedicated task for transmission? Is the
> job you have to perform there too heavy for IRQ context?


The application has two issues related on:
1.- The transmission setup would be really time extensive, so the ISR will
be really too busy sucking the data from the FIFO and pushing it into the
chipset
2.- Due to system specifications, we have focused the ISR performance in the
data reception flow, so the transmission irq context management must/need be
really fast.
We would like to hold as much as possible both features and this is the
reason to evaluate the rt_task approach..

Keep in mind that such a task requires additional management (assign
> reasonable
> priorities e.g.) and adds further latencies. It's no magic bullet, but
> it may be appropriate if there is actually a lot of work to do that
> shall not block other, more important jobs.


I mean the application specifications allow us to block a little bit the
internal driver write capabilities but the isr read management should be
inherently the most priority program flow.

Jan


As I have mentioned in the previous mail the driver is also a formal design
review, so lot of  variables and data addresses have been re-arranged and
re-structured, one of their was the killer one cause was pointed to the
hyperspace into the thread symbol..
I have checked the context pass argument with the decoded one at the thread
and all is ok now, no troubles related on.
The writer thread is always coupled to the "context" area reference through
the "open" call softly. Anyway, I think that a more generic question could
be stated right now.

Could i assume that the memory references coupled with the context argument
at the "open" call are stables along the context cycle life?
I think that this is not any data trusting if i always link the thread
creation/destroy to the "open"/"close" call entries, but i assume also that
i could have a fully wrong picture about all this stuff.

If you are so kind to give me any extra hints i would be really grateful
Thanks a lot..

------=_Part_28124_33133205.1185800570428
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan..<br><div><span class="gmail_quote">On 7/30/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Before going into details on how to pass references between driver tasks<br>etc.:<br><br>Why do you want to establish a dedicated task for transmission? Is the<br>job you have to perform there too heavy for IRQ context? </blockquote>
<div><br>The application has two issues related on:<br>1.- The transmission setup would be really time extensive, so the ISR will be really too busy sucking the data from the FIFO and pushing it into the chipset<br>2.- Due to system specifications, we have focused the ISR performance in the data reception flow, so the transmission irq context management must/need be really fast.
<br>We would like to hold as much as possible both features and this is the reason to evaluate the rt_task approach..<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Keep in mind that such a task requires additional management (assign reasonable<br>priorities e.g.) and adds further latencies. It&#39;s no magic bullet, but<br>it may be appropriate if there is actually a lot of work to do that
<br>shall not block other, more important jobs.</blockquote><div><br>I mean the application specifications allow us to block a little bit the internal driver write capabilities but the isr read management should be inherently the most priority program flow. &nbsp;  
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan</blockquote><div><br>As I have mentioned in the previous mail the driver is also a formal design review, so lot of&nbsp; variables and data addresses have been re-arranged and re-structured, one of their was the killer one cause was pointed to the hyperspace into the thread symbol..
<br>I have checked the context pass argument with the decoded one at the thread and all is ok now, no troubles related on. <br>The writer thread is always coupled to the &quot;context&quot; area reference through the &quot;open&quot; call softly. Anyway, I think that a more generic question could be stated right now. 
<br><br>Could i assume that the memory references coupled with the context argument at the &quot;open&quot; call are stables along the context cycle life?<br>I think that this is not any data trusting if i always link the thread creation/destroy to the &quot;open&quot;/&quot;close&quot; call entries, but i assume also that i could have a fully wrong picture about all this stuff. 
<br><br>If you are so kind to give me any extra hints i would be really grateful<br>Thanks a lot..<br></div></div>

------=_Part_28124_33133205.1185800570428--


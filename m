Message-ID: <2f7417810806170109j7b9e7b85hfbeaace299f67b3e@domain.hid>
Date: Tue, 17 Jun 2008 10:09:47 +0200
From: quinty <webquinty2@domain.hid>
In-Reply-To: <485765FF.20606@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3130_22987549.1213690187211"
References: <2f7417810806160933v43b88a2ek6232473fc7efd100@domain.hid>
	<485765FF.20606@domain.hid>
Subject: Re: [Xenomai-help] Hello, doubts with RT-CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_3130_22987549.1213690187211
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/6/17 Wolfgang Grandegger <wg@domain.hid>:

> quinty wrote:
>
>> Hello,
>>
>> I am testing RT-CAN with MPC5200 and linux 2.6.23.14 <http://2.6.23.14> ,
>> xenomai 2.4.2. <http://2.4.2.>
>> Well I have some doubts:
>> 1.- In kernel configuration, there is a parameter to change lenght of RX
>> CAN buffer, 1024 by default.
>> What units???, 1024 bytes, 1024 telegrams??'
>>
>
> It is in bytes and must be 2^n.
>
>
>  2.- RT-CAN is a block or non-block??? in other words, when I use rtcanrecv
>> examples, code wait in this line of code
>>
>> ret = rt_dev_recvfrom <
>> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd>(s,
>> (void *)&frame, sizeof(can_frame_t <
>> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html>),
>> 0,(struct sockaddr *)&addr, &addrlen);, until driver recieve  message.
>>
>
> Yes, unless you have opened the socket with the non-blocking flag.
>
>
>> 3.- Have RT-CAN TX buffer???
>>
>
> No, Out-going messages are not queued.
>
> What is your problem?
>
> Wolfgang.
>
> Hello Wolfgang,

well, in this moment I have not clear what is my problem. I have made some
examples with my board to try understand rt-can.

About non-block

ret = rt_dev_recvfrom(can_fd, (void *)&frame, sizeof(can_frame_t), *
MSG_DONTWAIT*,
            (struct sockaddr *)&addr, &addrlen);

I have used this flag to not wait a message, but now, you told me that I
must open the socket with the non-blocking flag.

can_fd = rt_dev_socket(PF_CAN, SOCK_RAW, CAN_RAW);
ret = rt_dev_ioctl(can_fd, SIOCGIFINDEX, &ifr);

but in this lines, I do not known how to set non-blocking flag.

I am going to explaind you my problem. I am connected a device with CAN.
This device send message every 5ms with differents ID, for example, 0x136,
0x624, 0x664, etc etc, then I need to read this telegrams and the same time,
I must calculate some values to send and check other process. If driver is
block, I can not check other process.

That is all.

John Martin
Automation and Research.
Best regards

------=_Part_3130_22987549.1213690187211
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/6/17 Wolfgang Grandegger &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
quinty wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br>
<br>
I am testing RT-CAN with MPC5200 and linux <a href="http://2.6.23.14" target="_blank">2.6.23.14</a> &lt;<a href="http://2.6.23.14" target="_blank">http://2.6.23.14</a>&gt; , xenomai <a href="http://2.4.2." target="_blank">2.4.2.</a> &lt;<a href="http://2.4.2" target="_blank">http://2.4.2</a>.&gt;<div class="Ih2E3d">
<br>
Well I have some doubts:<br>
1.- In kernel configuration, there is a parameter to change lenght of RX CAN buffer, 1024 by default.<br>
What units???, 1024 bytes, 1024 telegrams??&#39;<br>
</div></blockquote>
<br>
It is in bytes and must be 2^n.<br>
<br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">
2.- RT-CAN is a block or non-block??? in other words, when I use rtcanrecv examples, code wait in this line of code<br>
<br></div>
ret = rt_dev_recvfrom &lt;<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd</a>&gt;(s, (void *)&amp;frame, sizeof(can_frame_t &lt;<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html</a>&gt;), 0,(struct sockaddr *)&amp;addr, &amp;addrlen);, until driver recieve &nbsp;message.<br>

</blockquote>
<br>
Yes, unless you have opened the socket with the non-blocking flag.<div class="Ih2E3d"><br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
3.- Have RT-CAN TX buffer???<br>
</blockquote>
<br></div>
No, Out-going messages are not queued.<br>
<br>
What is your problem?<br><font color="#888888">
<br>
Wolfgang.<br>
<br>
</font></blockquote></div>Hello Wolfgang,<br><br>well, in this moment I have not clear what is my problem. I have made some examples with my board to try understand rt-can.<br><br>About non-block<br><br>ret = rt_dev_recvfrom(can_fd, (void *)&amp;frame, sizeof(can_frame_t), <b>MSG_DONTWAIT</b>,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (struct sockaddr *)&amp;addr, &amp;addrlen);<br><br>I have used this flag to not wait a message, but now, you told me that I must open the socket with the non-blocking flag.<br><br>can_fd = rt_dev_socket(PF_CAN, SOCK_RAW, CAN_RAW);<br>
ret = rt_dev_ioctl(can_fd, SIOCGIFINDEX, &amp;ifr);<br><br>but in this lines, I do not known how to set non-blocking flag.<br><br>I am going to explaind you my problem. I am connected a device with CAN. This device send message every 5ms with differents ID, for example, 0x136, 0x624, 0x664, etc etc, then I need to read this telegrams and the same time, I must calculate some values to send and check other process. If driver is block, I can not check other process.<br>
<br>That is all. <br><br>John Martin <br>Automation and Research.<br>Best regards<br>

------=_Part_3130_22987549.1213690187211--


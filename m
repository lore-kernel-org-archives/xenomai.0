Message-ID: <2f7417810806160933v43b88a2ek6232473fc7efd100@domain.hid>
Date: Mon, 16 Jun 2008 18:33:39 +0200
From: quinty <webquinty2@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_741_11265243.1213634019294"
Subject: [Xenomai-help] Hello, doubts with RT-CAN
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

------=_Part_741_11265243.1213634019294
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am testing RT-CAN with MPC5200 and linux 2.6.23.14 , xenomai 2.4.2.
Well I have some doubts:
1.- In kernel configuration, there is a parameter to change lenght of RX CAN
buffer, 1024 by default.
What units???, 1024 bytes, 1024 telegrams??'
2.- RT-CAN is a block or non-block??? in other words, when I use rtcanrecv
examples, code wait in this line of code

ret = rt_dev_recvfrom
<http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd>(s,
(void *)&frame, sizeof(can_frame_t
<http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html>),
0,(struct sockaddr *)&addr, &addrlen);, until driver recieve  message.


3.- Have RT-CAN TX buffer???

Best regards.
John
Automation & Research

------=_Part_741_11265243.1213634019294
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am testing RT-CAN with MPC5200 and linux <a href="http://2.6.23.14">2.6.23.14</a> , xenomai <a href="http://2.4.2.">2.4.2.</a><br>Well I have some doubts:<br>1.- In kernel configuration, there is a parameter to change lenght of RX CAN buffer, 1024 by default.<br>
What units???, 1024 bytes, 1024 telegrams??&#39;<br>2.- RT-CAN is a block or non-block??? in other words, when I use rtcanrecv examples, code wait in this line of code<br><pre class="fragment">ret = <a class="code" href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd" title="Receive message from socket.">rt_dev_recvfrom</a>(s, (<span class="keywordtype">void</span> *)&amp;frame, <span class="keyword">sizeof</span>(<a class="code" href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html" title="Raw CAN frame.">can_frame_t</a>), 0,(<span class="keyword">struct</span> sockaddr *)&amp;addr, &amp;addrlen);, until driver recieve  message.</pre>
<br>3.- Have RT-CAN TX buffer???<br><br>Best regards.<br>John<br>Automation &amp; Research<br>

------=_Part_741_11265243.1213634019294--


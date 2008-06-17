Message-ID: <485765FF.20606@domain.hid>
Date: Tue, 17 Jun 2008 09:21:35 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <2f7417810806160933v43b88a2ek6232473fc7efd100@domain.hid>
In-Reply-To: <2f7417810806160933v43b88a2ek6232473fc7efd100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: quinty <webquinty2@domain.hid>
Cc: xenomai@xenomai.org

quinty wrote:
> Hello,
> 
> I am testing RT-CAN with MPC5200 and linux 2.6.23.14 <http://2.6.23.14> 
> , xenomai 2.4.2. <http://2.4.2.>
> Well I have some doubts:
> 1.- In kernel configuration, there is a parameter to change lenght of RX 
> CAN buffer, 1024 by default.
> What units???, 1024 bytes, 1024 telegrams??'

It is in bytes and must be 2^n.


> 2.- RT-CAN is a block or non-block??? in other words, when I use 
> rtcanrecv examples, code wait in this line of code
> 
> ret = rt_dev_recvfrom <http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__userapi.html#g0cc144457c649f197d485581686273dd>(s, (void *)&frame, sizeof(can_frame_t <http://www.xenomai.org/documentation/branches/v2.4.x/html/api/structcan__frame.html>), 0,(struct sockaddr *)&addr, &addrlen);, until driver recieve  message.

Yes, unless you have opened the socket with the non-blocking flag.

> 
> 3.- Have RT-CAN TX buffer???

No, Out-going messages are not queued.

What is your problem?

Wolfgang.



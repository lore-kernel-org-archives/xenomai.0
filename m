Message-ID: <4177C29E.1000405@domain.hid>
Date: Thu, 21 Oct 2004 23:07:26 +0900
From: =?EUC-KR?B?yLK8rsGk?= <hwoarang@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] While developing new OS over Adeos
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Dear Adeos members.

Now I'm trying to develope a new RTOS over Adeos.
But I have a problem that I cannot understand.

The problem occurred while context switching on My OS.
When the control reaches an instruction to change stack pointer
like 'movl (%ecx), %esp', my machine halts or reboots.
It's beacause of general protection fault according to Linux Oops message.

Does anyone solve this problem?
I wanna refer to the source code of RTAI but I don't understand.
Please give me help!!!!
I'm on very urgent situation!! :-<

Regards,
Seok-jeong Hwang.


Message-ID: <46EBB128.4030509@domain.hid>
Date: Sat, 15 Sep 2007 12:17:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] writing to file from user space
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

I need to write data to a file every cycle in a rt task. I plan to use 
the normal call fopen(), having googled and seen that it seems to be 
used together with xenomai regulary. I.e. I may thus safely presume it 
does not break rt behaviour?

If there is something special that has to be taken into account to 
preserve low latency would anyone care to mention this?

Are there any examples where it is well implemented that could be 
suggested off-hand?

Thanks in advance for any advice.

Regards,

Roland.


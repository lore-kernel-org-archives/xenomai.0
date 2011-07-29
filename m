MIME-Version: 1.0
Message-ID: <OF525F5E1C.0654BB8B-ONC12578DC.004AEEB3-C12578DC.004B73F2@domain.hid>
From: julien.delange@domain.hid
Date: Fri, 29 Jul 2011 15:44:09 +0200
Content-Type: text/plain; charset="US-ASCII"
Subject: [Xenomai-help] Use of a4l_dtoraw
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I try to use the RTDM API to communicate with my boards. In fact, I 
adapted a driver from comedi to RTDM ; the low-level aspects seem to work 
(meaning : when I send something on a channel, I see an output on this 
channel). However, now, I would like the analogy API to interact with my 
device. So, I'm wondering how the conversion functions work.

For example, for the a4l_dtoraw function, if some arguments are easy to 
understand, some others need more explanations. In particular,what means 
the cnt argument of this function and how should we use it ? Is there some 
example of the usage of the level 2 API of the analogy level ? It would 
really help in understanding how this API interacts with the boards.

Thanks in advance for any help regarding the use of this API.

Best regards,



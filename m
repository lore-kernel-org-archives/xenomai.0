Message-ID: <54b161f50612040334v3244d551l56868ec221bd5dcb@domain.hid>
Date: Mon, 4 Dec 2006 12:34:52 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32196_26064193.1165232092890"
Subject: [Xenomai-help] size of the struct can_frame
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

------=_Part_32196_26064193.1165232092890
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

I noticed that the sizeof() function reports that the struct can_frame has a
size of 16 bytes. I know that this is because of memory aligning done by the
GNU compiler.
But now I wonder if there are actually 16 bytes transferred over the CAN
bus. I guess not, since it has such a strict and well-defined format, but
I'd like to have this confirmed by someone, please.
The size of 16 bytes though, is also passed to the rt_dev_recv() and
rt_dev_send() functions, so this is where I get confused: Are the correct
bytes extracted from this 16 byte block at a later stage (the CAN driver)?

I'm asking this to make sure that if, for example, I'd like to store all the
received frames in a binary file, I don't need to store all 16 bytes, just
the 13 (right?) that are in use.

I hope I made myself clear.

Thanks in advance and best regards!

Frits

------=_Part_32196_26064193.1165232092890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br>
<br>
I noticed that the sizeof() function reports that the struct can_frame
has a size of 16 bytes. I know that this is because of memory aligning
done by the GNU compiler. <br>
But now I wonder if there are actually 16 bytes transferred over the
CAN bus. I guess not, since it has such a strict and well-defined
format, but I'd like to have this confirmed by someone, please.<br>
The size of 16 bytes though, is also passed to the rt_dev_recv() and
rt_dev_send() functions, so this is where I get confused: Are the
correct bytes extracted from this 16 byte block at a later stage (the
CAN driver)?<br>
<br>
I'm asking this to make sure that if, for example, I'd like to store
all the received frames in a binary file, I don't need to store all 16
bytes, just the 13 (right?) that are in use.<br>
<br>
I hope I made myself clear.<br>
<br>
Thanks in advance and best regards!<br>
<br>
Frits<br>
<br>
<br>

------=_Part_32196_26064193.1165232092890--


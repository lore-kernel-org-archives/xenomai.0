Message-ID: <bc4264770702281208u7d7ee013qa5be819a5856d4ea@domain.hid>
Date: Wed, 28 Feb 2007 20:08:22 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] CAN rt_dev_recvfrom
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

Hi,

Ok the issue I posted earlier regarding the read function. It seems
that it IS recieving can messages and displaying them correctly. Only
its behaviour is not as I expected. I thought the function

rt_dev_recvfrom

would simply perform a read one frame from a buffer (which in my
experience holds a number of can messages) then exit.

By the look of things I will have to implement the aforementioned
buffer myself. I.e

run rt_dev_recvfrom in a separate thread other than my periodic task
and store an x number of messages in BUFFER that I recieve there. The
can_read() function which I implement in the periodic task must then
simply read the messages from BUFFER.

Can this be confirmed or is rt_dev_recvfrom() behaving incorrectly in my case?

Kind regards,

Roland.


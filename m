Message-ID: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
Date: Sat, 3 Mar 2007 13:54:57 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] catching CAN errors
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

What I cannot find an example of is how to filter for more than one error?

ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
&err_mask, sizeof(err_mask));

will pick out the messages that correspond to err_mask. At the moment
I seem to be picking up CAN_ERR_BUSERROR but not for example
CAN_ERR_CRTL (mind you I presume the latter should have been
CAN_ERR_CTRL which is a bit more intuitive). If I want to pick up both
can I do this


ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
&err_mask1, sizeof(err_mask1));

ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
&err_mask2, sizeof(err_mask2));

to set up to get errors of two types or can I only pick up one at a time.?

This is what my CanID and the data sequence looks like:

!0x00000088!<0x088> [8] 00 00 80 19 00 00 00 00

0x00000080 is CAN_ERR_BUSERROR  and
0x00000008 is protocol violation CAN_ERR_PROT.

So I seem to have those two errors. Correct?

-What is a protocol error?

The values in data 2 and 3 seem to say

data 2:  80 Error occurred on transmission
data 3 19 Ack Slot?

The first one I can understand I have nothing connected to the bus,
the second one
What does the second one mean?


Regards,

Roland.


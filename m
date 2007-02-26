Message-ID: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>
Date: Mon, 26 Feb 2007 19:08:08 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] newby question, can/socket stuff
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

I am looking through the rtcan code provided with the xenomai package
and I realize one thing:

I know too little of the basic socket programming. Not even sure my
wording in the previous sentence is capturing the correct area of
ignorance.

I suspect very strongly that the rtcan functionality is designed to
piggyback on whatever standard iocontrol is taking place in functions
like

ret = rt_dev_ioctl(can_fd, SIOCGIFINDEX, &ifr);

and
ret = rt_dev_ioctl(can_fd, SIOCSCANBAUDRATE, &ifr);

But exactly what is happening is beyond me at the moment.

Now I can obviously try to copy like a chinaman (no disrespect
intended!) and not understand what I am doing but it is not really a
mode of operation I relish.

I have briefly tried to locate the rt_dev_ioctl back to a xenomai
header but have not managed to trace it yet.

Is it defined in the standard linux ioctl headers? Where can I find
some info on what arguments these functions are passed etc?

Much appreciated.

Regards,

Roland.


Message-ID: <bc4264770703051332u682ddd0av8fbd49520b3cf1b9@domain.hid>
Date: Mon, 5 Mar 2007 21:32:23 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] need help. RT gone for a ball of chalk due to CAN
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

This is the same issue as we were on about earlier. Only now i have
brought the baud rate down and there is no logging of errors. dmesg
stays clean.

The application is still working in the sense that it reads the Can
messages it recieves etc. Only the problem of the rocking period times
as soon as I move the sensor and messages are read is as bad as ever.

This can only mean that either I am calling some non-real-time
function (which i am certainly not, no printf or that kind of thing)
or rtcan is not as real-time as it is supposed to be. There are no
error masks set so I don't know whether there are any errors.

The only thing worth noting is that since I brought the baudrate down,
the state is "passive" and I cannot get it into "active" with start.

Might this be the cause? Why would it be passive and not active like
it used to be?

Regards,

Roland


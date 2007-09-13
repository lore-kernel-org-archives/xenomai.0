Message-ID: <cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
Date: Thu, 13 Sep 2007 13:34:01 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
Subject: Re: [Xenomai-help] too fast write to serialport?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

2007/9/13, Bachman Kharazmi <bahkha@domain.hid>:
> Hi!
> I try to print to serialport using rtdm according to: http://pastebin.ca/695418
>
> But if I don't have sleep(1) only "hello   " or similar is written to
> the serialport.
> But if I've sleep(1) "helloworld" is written every second as expected.

I'm no xenomai expert but I think
you shouldn't write to serial device in such a tight loop:

while(counter <100){
        rt_dev_write(fd, myString, strlen(myString));
       printf("%d\n",counter);
      // sleep(1);  WITHOUT THIS SLEEP helloworld is sent on serial once.
     counter++;
}

because you will certainly fills the send buffer without giving a chance
to the drive to send more data than the one that fits in the buffer
(this heavily depends wether if the device is opened in blocking
 or non-blocking mode)

FIRST of ALL you should check the return value of your function call

rt_dev_write should return either the number of written bytes
http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__userapi.html#ge966625748b547779bb8c5385e7fb2aa

or a negative error code:
http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__rtserial.html


> Is this some kind of limit how quickly I can write stuff on the rtser0?

Yes there must be.
Serial device are not as fast as any recent CPU.
Beginning with the fact that you did configure the serial link at 115200 bauds
it would'nt wise to try to feed at an "average" speed that exceed this number.


> How do I handle this?

Check the return value of your rt_dev_write calls :)


-- 
Erk


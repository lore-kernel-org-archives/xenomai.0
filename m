Message-ID: <cbe23c50709130716q6f9985ffj2c9c5300dc8755e4@domain.hid>
Date: Thu, 13 Sep 2007 16:16:14 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <1ce16a2c0709130706g34e5cbffh8d11781044e26f32@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
	<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
	<1ce16a2c0709130706g34e5cbffh8d11781044e26f32@domain.hid>
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
> while(counter<100){
>         sem.take()
> size = rt_dev_write(fd, myString, strlen(myString));
>         sem.give()
>         if(size<0){
>         printf(MAIN_PREFIX "3 : error %s (write), %s\n", WRITE_FILE, strerror(-size));
>         return size;
>         }
>         printf("%d\n",counter);
> usleep(100000);  //sleep a few millis
> counter++;
> }
> There should be solutions to with a flag or similar which can tell
> when rt_dev_write() actually is finished. Until then wait()/sleep()
> would probabily be the best solution.
>
> Are there suitable solutions where no polling is made and make me wait
> until the data have been written out to rtser0?

You want a blocking semantic.
It seems that the rt_serial config structure contains
some send timeout value.

http://www.xenomai.org/documentation/branches/v2.3.x/html/api/structrtser__config.html

which "may" be used for that purpose.

I am no xenomai rt serial expert I cannot answer precisely
about the usage of those parameters
and/or how to configure rtserial in blocking mode.

The fact is usually in realtime task you don't want to block...
So fixing an appropriate timeout for sending is usually
the user jobs since this is the only one which knows his
RT constraint.

-- 
Erk


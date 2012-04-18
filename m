MIME-Version: 1.0
In-Reply-To: <4F8E7B7C.3040408@domain.hid>
References: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
	<4F8D5458.6070603@domain.hid> <4F8D553B.6010101@domain.hid>
	<CAM1yFZ_kvvh019OMe-_BCf_qqyuDAumL0mw4XdMx5TSRGRAWAw@domain.hid>
	<4F8E7B7C.3040408@domain.hid>
Date: Wed, 18 Apr 2012 14:12:41 +0530
Message-ID: <CAM1yFZ9VNSJih2GBrCvHb7ySssXbmek2dXfF+xto=_thdJOquQ@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Understanding the output of hackbench when run
 together with xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 18 April 2012 13:59, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>> I tried `dohell` separately with `hackbench` and `seconds` parameter
>> as follows (and it worked properly):
>> _____________________________________________________________
>> linux-dopx:~ # /usr/xenomai/bin/dohell -b
>> "/home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
>> process 100 seconds" 2
>
> "seconds" is a count of seconds, the number of seconds you want dohell
> to run. Like 14400 for 4 hours.
>


Yes, I understood that. I did mention 2 as number of seconds (in the
above quoted command), and I also tried that as follows:
/usr/xenomai/bin/dohell -b
"/home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
process 100" 2

This `dohell` command result too is showing the proper output.

The problem is that when I run the same dohell command with xeno-test,
it doesn't show the results of hackbench.
Please read the other commands I tried (in my previous mail).

I feel it is the syntax problem which I am not able to figure out.


-Anisha


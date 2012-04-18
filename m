MIME-Version: 1.0
In-Reply-To: <4F8E7E35.6090402@domain.hid>
References: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
	<4F8D5458.6070603@domain.hid> <4F8D553B.6010101@domain.hid>
	<CAM1yFZ_kvvh019OMe-_BCf_qqyuDAumL0mw4XdMx5TSRGRAWAw@domain.hid>
	<CAM1yFZ-emKxt2D2x7DCS4mNzbD5x-9_W-Z0w4AhtMBo1P9kTeQ@mail.gmail.com>
	<4F8E7E35.6090402@domain.hid>
Date: Wed, 18 Apr 2012 14:39:06 +0530
Message-ID: <CAM1yFZ8=Q9afvQ11Oer=9c7yfpm_zQzmxq=xw5JE39SirfVQ1Q@mail.gmail.com>
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

On 18 April 2012 14:11, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Try: xeno-test -l "dohell -b /home/anisha/Desktop/RealTime/downloadedPages/hackbench 14400"

and that worked! I tried it with 2 seconds.

I realize now that the problem is in the "parameters" which I specify
with hackbench:

xeno-test -l "dohell -b
/home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
process 100 2"

The sub `dohell` command (with hackbench parameters) work well, but it
doesn't work when attached with `xeno-test`. I remove the hackbench's
parameters ("-pipe 100 process 100"), then it starts working.

Thanks for your help, but what should I do if I want those parameters?
Hardcoding them in the hackbench's code as a temporary solution? Or I
am still missing a point?

-Anisha


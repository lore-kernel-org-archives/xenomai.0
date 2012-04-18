Message-ID: <4F8E7E35.6090402@domain.hid>
Date: Wed, 18 Apr 2012 10:41:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>	<4F8D5458.6070603@domain.hid>
	<4F8D553B.6010101@domain.hid>	<CAM1yFZ_kvvh019OMe-_BCf_qqyuDAumL0mw4XdMx5TSRGRAWAw@domain.hid>
	<CAM1yFZ-emKxt2D2x7DCS4mNzbD5x-9_W-Z0w4AhtMBo1P9kTeQ@mail.gmail.com>
In-Reply-To: <CAM1yFZ-emKxt2D2x7DCS4mNzbD5x-9_W-Z0w4AhtMBo1P9kTeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Anisha Kaul <born.rebel.83@domain.hid>
Cc: xenomai@xenomai.org

On 04/18/2012 09:25 AM, Anisha Kaul wrote:
> On 17 April 2012 17:04, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Ok, it is not clear: but you need to pass a duration if you do not pass
>> the patch to LTP, which means either the "-l path" or "seconds" argument
>> is mandatory.
> 
>  Thanks for replying. I couldn't have made it out myself that the last
>  argument is compulsory.
>  The problem isn't solved yet, actually.
> 
>  I tried `dohell` separately with `hackbench` and `seconds` parameter
>  as follows (and it worked properly):

Try:
xeno-test -l "dohell -b
/home/anisha/Desktop/RealTime/downloadedPages/hackbench 14400"

-- 
                                                                Gilles.


Message-ID: <4D7A3FE1.1050006@domain.hid>
Date: Fri, 11 Mar 2011 16:29:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik+Mm_0Xn4kAOs-9B-AGVi0+G8k+ZJUd4LTAJ-j@domain.hid>	<4D79CCE7.6020504@domain.hid>
	<AANLkTinb7eG-KoLe38LNsfxE+pUBV2aKfOJq19BMdvfX@mail.gmail.com>
In-Reply-To: <AANLkTinb7eG-KoLe38LNsfxE+pUBV2aKfOJq19BMdvfX@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] removing Xenomai modules hangs system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> On Fri, Mar 11, 2011 at 1:19 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Jeff Weber wrote:
>>> xeno2:~ # rmmod -v
>>>
>> /lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
>>> rmmod xeno_rtdm, wait=no
>> What is this "wait=no" ?
>>
>> I don't know.  When I run 'rmmod -v" the verbose reporting reveals that
> rmmod is doing that on my behalf.
> 
yeah, but the first time, you use modprobe -r, why using rmmod the
second time? how do we know that it is not using rmmod with wait=no
which causes the issue?

-- 
					    Gilles.


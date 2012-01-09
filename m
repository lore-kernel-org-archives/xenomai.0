Message-ID: <4F0AD982.5050106@domain.hid>
Date: Mon, 09 Jan 2012 13:11:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>	<4F046865.9000408@domain.hid>	<000001cccafd$1c6046b0$5520d410$@soterem.fr>	<4F049054.4000302@domain.hid>	<4F062D33.3060606@domain.hid>
	<4F06C191.1090704@domain.hid> <4F09FEA8.9080001@domain.hid>
	<4F0A1422.5010304@domain.hid> <4F0A1A38.1070506@domain.hid>
In-Reply-To: <4F0A1A38.1070506@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol -
	check	the	xenomai	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: xenomai@xenomai.org

On 01/08/2012 11:35 PM, Jakub Nowacki wrote:
> On 08/01/12 22:09, Philippe Gerum wrote:
>> References should precede definitions. Try swapping libxenomai.so and
>> libnative.so in your link order. As Gilles already suggested, using the
>> xeno-config script in your Makefile to get the proper link flags would
>> have prevented this issue.
>>
> Thanks for the answer. The problem is I do not have just a Makefile but 
> it is generated with autotools. In autotools xeno-config is used but 
> apparently order is not OK.

The flag returned by xeno-config are in the right order if you use the
"new" syntax that is --skin=native --ldflags instead of the "old" syntax
--xeno-ldflags which required you to add -lnative -lxenomai by hand.

Another solution, since xenomai 2.6.0, is to use pkg-config. How to use
pkg-config with the autotools is described here, for instance:

http://bec-systems.com/site/121/autotools-quick-reference

The name of xenomai .pc files are libxenomai_skin, so libxenomai_native
for the native skin, or libxenomai_posix for the posix skin.

-- 
                                                                Gilles.


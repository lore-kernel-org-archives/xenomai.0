Message-ID: <4A1D73B6.1050602@domain.hid>
Date: Wed, 27 May 2009 19:09:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <abaf774b0905270831q6c8aeb44mb2cf10f7ca3b926f@domain.hid>	
	<4A1D6ED4.3060104@domain.hid> <1243443636.22014.79.camel@domain.hid>
In-Reply-To: <1243443636.22014.79.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test hangs during latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Wed, 2009-05-27 at 18:48 +0200, Gilles Chanteperdrix wrote:
>> Steve wrote:
>>> After installing the latest version of Xenomai last week I have
>>> encountered a problem with Xenomai applications hanging linux
>>> completely, requiring restart.  This has also occured while running
>>> xeno-test, during the latency tests.
>>>
>>> I have tried to follow the various suggestions on this board about
>>> preventing hanging of Xenomai, however I am still experiencing the
>>> problem.
>>>
>>> I am using:
>>> Vanilla Linux Kernel 2.6.24
>>> Adeos Patch 2.6.24-x86-2.0-07
> 
> ^^^^^

Yeah, right, please try the latest version, Xenomai 2.4.7, and the
patches it contains. If you need debian packages, the package ship with
its own debian directory allowing to build the packages from sources. If
it does not work, then report bugs.

Also, depending on your deadlines, 2.4.8 should be out soon, so you may
want to wait for this release.

-- 
                                                 Gilles.


Message-ID: <50F8D03E.3070905@xenomai.org>
Date: Fri, 18 Jan 2013 05:31:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
	<50F239E1.40400@zultron.com> <50F2A59D.5050600@xenomai.org>
	<50F30781.3050302@zultron.com> <50F30DE5.7030007@xenomai.org>
	<50F38DD5.5010105@zultron.com> <50F3F2C6.2040900@xenomai.org>
	<50F3F359.9020502@siemens.com> <50F409C0.7050701@siemens.com>
	<50F46FF8.5050100@zultron.com> <50F48CBB.7080605@xenomai.org>
	<50F5025E.1040500@zultron.com> <50F505C3.3090803@xenomai.org>
	<50F8C7F3.8000406@zultron.com>
In-Reply-To: <50F8C7F3.8000406@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.7 posix/mprotect fixed;
	(Was:  posix/mprotect failure)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/18/2013 04:56 AM, John Morris wrote:

> On 01/15/2013 01:31 AM, Gilles Chanteperdrix wrote:
>> On 01/15/2013 08:16 AM, John Morris wrote:
>>> 1)  "xddp_test" fails:  "...IPCPROTO_XDDP): Address family not supported
>>> by protocol".  DRIVERS_RTIPC_XDDP is enabled in the config.  Doesn't
>>> look like others have experienced this before.  LinuxCNC doesn't use
>>> XDDP, but it should be fixed for the general audience.
>>
>>
>> You are missing some kernel drivers. I used the following options in the
>> Debian configuration: basically, all options enabled (some as module,
>> because they are expected to be used less often).
>>
>> CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
> 
> I think the problem was here.  xddp was compiled in as a module in my
> original config, and wasn't loaded by the test suite.


The testsuite does not load any module. It makes more sense to have xddp
builtin anyway.

-- 
                                                                Gilles.


Message-ID: <50DCCE5B.4040802@xenomai.org>
Date: Thu, 27 Dec 2012 23:40:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CD8E87.2070906@xenomai.org>	<201212170945.47992.leo@alaxarxa.net>	<50CEFB24.9000306@antcom.de>	<201212171453.44318.leo@alaxarxa.net>	<50DC9C51.9090300@antcom.de>
	<50DCA2B1.6070805@xenomai.org> <50DCB69A.9000004@nta-inc.net>
	<50DCB84C.8070401@xenomai.org> <50DCBAFF.2080300@nta-inc.net>
In-Reply-To: <50DCBAFF.2080300@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Another dpkg build issue for Xenomai 2.6.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 12/27/2012 10:17 PM, Jeff Webb wrote:

> On 12/27/2012 03:06 PM, Gilles Chanteperdrix wrote:
>> On 12/27/2012 09:59 PM, Jeff Webb wrote:
>>
>>> When building dpkgs on Ubuntu 12.04, this line in the debian/rules file gives me trouble because there are no longer any adeos-ipipe-*.patch files for the x86 architecture:
>>>
>>> cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
>>>
>>> As a workaround, I did this before building:
>>>
>>> touch ./ksrc/arch/x86/patches/adeos-ipipe-2.6.0-x86-dummy.patch
>>
>>
>> That is one of the "other issues".
>>
> 
> Thanks, Gilles.
> 
> 



You can try the following commit:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=89ff2edf76dae49e4a3643f17e118954b68a692e

-- 
                                                                Gilles.


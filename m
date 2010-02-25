Message-ID: <4B867FF9.2020709@domain.hid>
Date: Thu, 25 Feb 2010 14:49:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>
	<4B867EB5.9090504@domain.hid>
In-Reply-To: <4B867EB5.9090504@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi,
> 
> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>> <snip>
>> In any case, thanks for your work so far. We probably need to discuss
>> the packaging issues on this list, so that we get both consistency and
>> usability in the future.
>>
>> Gilles and Roland, if this is fine with you, I'll handle the liaison
>> role with upstream packagers, so please CC me explicitly on those mails.
>> We'll sort out this issue, it doesn't look that bad anyway.
> 
> udev/xenomai.rules sets the group for realtime devices to "xenomai".
> Patch attached to create the group "xenomai" on installation.
> 
> Additionally, it would be nice to set "xeno_nucleus.xenomai_gid" to
> group "xenomai" too. Is this possible with a udev rule ?

Well, no, xeno_nucleus.xenomai_gid is a kernel parameter, so it is boot
loader stuff. However, if xeno_nucleus is compiled as a module, you can
add parameters in /etc/modprobe.d. Well, that would have been the place
to do it some time ago. I may not be completely up-to-date.

> 
> regards
> kisda
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
					    Gilles.


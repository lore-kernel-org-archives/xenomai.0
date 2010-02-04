Message-ID: <4B6AA0EF.5010406@domain.hid>
Date: Thu, 04 Feb 2010 11:26:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B69D077.7000307@domain.hid> <4B69D2F8.6000201@domain.hid>
	<4B69DDE6.1000903@domain.hid> <4B69DE8B.8080409@domain.hid>
	<4B6A9EE2.8010907@domain.hid>
In-Reply-To: <4B6A9EE2.8010907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] howto build debion packages from a Xenomai Git
 repository
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am 03.02.2010 21:37, schrieb Gilles Chanteperdrix:
>> Stefan Kisdaroczi wrote:
>>> Am 03.02.2010 20:48, schrieb Gilles Chanteperdrix:
>>>> Stefan Kisdaroczi wrote:
>>>>> Hi all,
>>>>>
>>>>> below a howto which works for me on a Debian Lenny system.
>>>>>
>>>>> Regards, Stefan
>>>> That is nice. Would you mind putting it in the wiki, including the
>>>> kernel build? If you agree, please tell me what your login on the wiki
>>>> is, and I will give you the permissions to write.
>>> ok, my login is 'kisda'.
>> you should have the permission to write now.
> 
> Worked. I did not modify the kernel building howto, but i plan to extend it
> according to the howto I sent last year to the list:
> https://mail.gna.org/public/xenomai-help/2009-10/msg00203.html

Ok, no problem. You may remove the note about xenomai having been merged
into an official debian package, since the official debian package is 5
releases behind Xenomai, and ships with versions of the I-pipe patches
which have been announced as bogus on Xenomai mailing lists. So, it is
not a good idea to advise people to use that.

You may also want to mention your "unofficial" apt repository.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


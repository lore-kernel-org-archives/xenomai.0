Message-ID: <4CB3424A.5090504@domain.hid>
Date: Mon, 11 Oct 2010 18:58:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid> <4CB338AB.3070803@domain.hid>
	<4CB339F9.5080202@domain.hid> <4CB33F04.3000600@domain.hid>
	<4CB34031.5090505@domain.hid>
In-Reply-To: <4CB34031.5090505@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am 11.10.2010 18:49, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 11.10.2010 18:23, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> enabling the Xenomai watchdog should provide a reasonably safe&secure
>>>> environment.
>>> AFAIK, the BIG FAT warning at the bottom of this page still applies. You
>>> can make an environment with no hardware lockups, but secure, I do not
>>> think so. We do not know how Xenomai APIs could be exploited for a
>>> non-root user to become root.
>>
>> For sure, no one audited the interface for security so far. There is no
>> hole in design that comes to my mind ATM, but I would be surprised as
>> well if you couldn't develop any exploit for some bug or missing check.
>> Still, there is a huge difference between giving anyone root access and
>> confining Xenomai access this way.
> 
> I was just reacting to "reasonably secure". The experience proves that
> if you do not do any particular effort for security, then your code is
> not secure. Not even reasonably.

This is no black-or-white domain, and I wouldn't say we spend no effort
on security at all. We do have interest in making the userspace APIs
robust which addresses security up to a certain level as well.

What is still definitely not secure, though, is RTnet as it consequently
lacks any kind of check on user-passed addresses. But that's not
Xenomai's fault (rather mine).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux


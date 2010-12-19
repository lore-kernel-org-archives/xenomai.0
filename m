Message-ID: <4D0E30A1.2040307@domain.hid>
Date: Sun, 19 Dec 2010 17:19:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikm-ERjxUBYZ1d7r06rmfdsZWPyibdVRVVKPNU+@mail.gmail.com>
	<201012181117.46352.kisda@domain.hid>
In-Reply-To: <201012181117.46352.kisda@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] non-root user access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>, Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am Freitag 17 Dezember 2010, 09:48:18 schrieb Gajamohan Mohanarajah:
>> Hi,
>>
>> I am running xenomai-2.5.5.2 with Ubuntu 10.04.
>> Is there a way to allow a non-root user access.
>> Now I get : [Xenomai: binding failed: Operation not permitted.]
> 
> Hi,
> 
> http://xenomai.org/index.php/Non-root_RT
> 
> If you have installed xenomai as a debian package, just add the user 
> to the group xenomai:
>   adduser gajan xenomai
> 
> http://xenomai.org/index.php/Building_Debian_packages

As a side note: this does not guarantee that the filesystem is secured,
when you crash the kernel, you may well crash the filesystem.

-- 
                                                                Gilles.


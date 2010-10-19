Message-ID: <4CBD56E1.1060507@domain.hid>
Date: Tue, 19 Oct 2010 10:29:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikYfNHc3ZZz+KCFtt80n8nLA4sN9SK1yjH0w2So@domain.hid>
In-Reply-To: <AANLkTikYfNHc3ZZz+KCFtt80n8nLA4sN9SK1yjH0w2So@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support of PSE51
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Private Inf <privateinf@domain.hid>
Cc: xenomai@xenomai.org

Private Inf wrote:
> Hello All,
> It is said that profile for minimal RTOS in standard POSIX.13-2003 is
> called PSE51.
> If RTOS supports this profile there should be defined
> _POSIX_AEP_REALTIME_MINIMAL with value 200312L in <unistd.h>.
> I was not able to locate this constant anywhere in Xenomai code. Does it
> mean that it is non compliant to PSE51?

Xenomai POSIX skin is not, to my knowledge, a certified POSIX RTOS. To
get it certified, you would need to have a look here:
http://get.posixcertified.ieee.org/

However, we care to follow the POSIX specification with regard, mostly,
to the POSIX services interface and behaviour, and if you feel like some
part of our implementation does not follow this specification, we will
welcome any contribution.

-- 
					    Gilles.


Message-ID: <4D224F71.8080500@domain.hid>
Date: Mon, 03 Jan 2011 23:36:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D21CE64.6010605@domain.hid> <4D223014.9050806@domain.hid>
	<201101032332.45435.kisda@domain.hid>
In-Reply-To: <201101032332.45435.kisda@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] debian: update debian/control for debian
 6.0 "squeeze"
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Stefan Kisdaroczi wrote:
> Am Montag 03 Januar 2011, 21:22:44 schrieb Gilles Chanteperdrix:
>> Stefan Kisdaroczi wrote:
>>> Hi,
>>>
>>> patch attached for upcoming debian 6.0 "squeeze".
>> Does not it create an artificial limitation? I mean, does not it prevent
>> us from building Xenomai with an older version?
> 
> I tested the package building with "old" debian 5.0 "lenny", works still fine.

Ok, I saw "Standards-Version: 3.9.1" as a sort of requirement. Will
merge your patch then, thanks.

-- 
                                                                Gilles.


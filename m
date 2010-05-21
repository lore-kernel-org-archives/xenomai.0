Message-ID: <4BF6316B.6030305@domain.hid>
Date: Fri, 21 May 2010 09:08:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTil5O99TYi2HF9QsN2kz8em4pFiJXTAmteBoee1Z@mail.gmail.com>	
	<4BF50C56.5040307@domain.hid>
	<AANLkTikSzbCnuC3Y2eki4pAPaQH2mzAD_l_90W1Twnc-@domain.hid>
In-Reply-To: <AANLkTikSzbCnuC3Y2eki4pAPaQH2mzAD_l_90W1Twnc-@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to compile xenomai examples?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> Hi Gilles,
> 
> Thanks for your kind reply. If I do that, the result is similar:
> 
> make XENO=/media/Angstrom/usr/xenomai ARCH=arm
> KSRC=/home/everett/tmp/xenomai-2.5.3/ksrc

try:
DESTDIR=/media/Angstrom make XENO=/media/Angstrom/usr/xenomai ARCH=ARM SRC=/home/everett/tmp/xenomai-2.5.3/ksrc

-- 
					    Gilles.


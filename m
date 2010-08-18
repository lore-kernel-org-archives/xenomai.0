Message-ID: <4C6B870C.7090600@domain.hid>
Date: Wed, 18 Aug 2010 09:09:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>	<4C698E16.5050806@domain.hid>,
	<1282040830.1730.232.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>
	<4C6AA99D.3010907@domain.hid>
In-Reply-To: <4C6AA99D.3010907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
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
> On 17.08.2010 15:51, Hemal C.Bavishi wrote:
>> When I tried to compile it with the latest version of kernel with xenomai 2.5.4, I am getting following errors in Xenomai (disable CONFIG_SMP, enable CONFIG_X86_UP_APIC and
>> CONFIG_X86_UP_IOAPIC (*).)
>>   
> 
> Just tested, got the same build error with 2.6.34.
> If I patch 2.6.34 with prepare-kernel [1] it compiles,
> if I use the debian packaged patch generated with prepare-patch [2] it
> fails.
> 
> I guess a fix is needed in prepare-patch for 2.6.34, but no time to look
> closer now.
> 
> Stefan
> 
> [1] xenomai-2.5.4/scripts/prepare-kernel.sh
> [2] xenomai-2.5.4/debian/prepare-patch.sh

prepare-kernel.sh has a "--outpatch" option, which seems to be able to
generate patches, so, would not it be possible to modify prepare-patch
to simply call prepare-kernel.sh with the --outpatch option?

This way, we will not have to duplicate into prepare-patch.sh the
modifications we make to prepare-kernel.sh.

-- 
					    Gilles.


Message-ID: <49929EEE.1040006@domain.hid>
Date: Wed, 11 Feb 2009 09:48:30 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0ef0a9d0902081422j35e1cfe8s9bf53083b87ef1cb@domain.hid>
	<49904BCF.4020509@domain.hid>
In-Reply-To: <49904BCF.4020509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting xenomai on uclinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ghanem Lafi <lafi.ghanem@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Ghanem Lafi wrote:
>> Hello,
>>
>> It is my first time with xenomai and i  have to port xenomai on
>> uclinux on the first step.
>> Then i ask about the compatible version of xenomai and uclinux and the
>> version of linux kernel if it is necessary.
> 
> Xenomai should not care much about whether uclinux or linux is used,
> since at least one port exists of xenomai over an architecture using
> uclinux (blackfin).
> 
> Now, for the specific case of ARM, the uclinux patch for ARM is no
> longer published since some part of it have started to been merged into
> the mainline linux, but since not all of it has been merged, uclinux is
> not yet selectable in the mainline linux kernel configuration. So
> basically, I do not know. You should probably ask to the uclinux/arm
> maintainers/mailing list (you can find information on this site:
> http://opensrc.sec.samsung.com/profile.html) for the way of having
> uclinux on arm with a recent kernel.

I missed it, but a uclinux patch exists for a reasonably recent kernel
version containing support for ARM:
http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.25-uc0-big.patch.gz

You can start from that.

-- 
                                                 Gilles.


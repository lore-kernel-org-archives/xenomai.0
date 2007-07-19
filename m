Message-ID: <2ff1a98a0707190136o48f3934ar55a5fc579f719775@domain.hid>
Date: Thu, 19 Jul 2007 10:36:14 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707190105j79e9357ehbba9285c2f8a250c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707190105j79e9357ehbba9285c2f8a250c@domain.hid>
Subject: Re: [Xenomai-help] Cross Compile the Xenomai-2.3.2 for AT91 - ld
	terminated with signal 11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/19/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> Dear all,
>
> I have tried to cross compile the xenomai-2.3.2 for AT91RM9200 but run in to
> the following problems:
>
> (...)
> collect2: ld terminated with signal 11 [Segmentation fault]
> (...)

No, Xenomai compilation flags trigger a bug of the toolchain you use.
Could you try xenomai-2.3.1 to see if the bug does not come from some
recent changes ?
If you have the same problem with xenomai-2.3.1, I am afraid you will
have to change your toolchain.

-- 
                                               Gilles Chanteperdrix


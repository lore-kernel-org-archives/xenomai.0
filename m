Message-ID: <4D64CBE3.3020901@domain.hid>
Date: Wed, 23 Feb 2011 09:57:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=M7Nzd2Yw-99H=zvweAy15LzwhZwDm1TW1U3DT@mail.gmail.com>
In-Reply-To: <AANLkTi=M7Nzd2Yw-99H=zvweAy15LzwhZwDm1TW1U3DT@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Which arm gcc version should be used to build
 xenomai 2.5.5.2?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sonic Zhang <sonic.adi@domain.hid>
Cc: xenomai@xenomai.org

Sonic Zhang wrote:
> Hi,
> 
> Which arm gcc version should be used to build xenomai 2.5.5.2? I get
> build error if latest arm gcc from code sourcery is use.

Hello,

yes, actually 2.5.5.2 starts to be a bit old, and dates back from before
I started using this new release.

Anyway, you may find the fix for this compilation error here:
http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=895afb35078f11a776ed192d139ea4c4f25f40a8;hp=1e4df2d9e4fc6c12d9dbaa4c574c4d84021d0ec6
and here:
http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=2671234528f92c96d77066e774dbeffdfb922c6e;hp=895afb35078f11a776ed192d139ea4c4f25f40a8

Regards.

-- 
                                                                Gilles.


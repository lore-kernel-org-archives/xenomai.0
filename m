Message-ID: <4EFC7EC8.2040805@domain.hid>
Date: Thu, 29 Dec 2011 15:52:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
	<000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
	<4EFB0D66.8060306@domain.hid>
	<000801ccc580$d9117ef0$8b347cd0$@soterem.fr>
	<4EFB4BC9.4050903@domain.hid>
	<000001ccc632$da3d80f0$8eb882d0$@soterem.fr>
	<4EFC753D.90005@domain.hid>
	<000101ccc638$7aff1f30$70fd5d90$@soterem.fr>
In-Reply-To: <000101ccc638$7aff1f30$70fd5d90$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: 'xenomai-help' <xenomai@xenomai.org>

On 12/29/2011 03:45 PM, Gregory Gosse wrote:
> No . What i wanted to do , starting from the examples, is write
> rapidly a simple program that perform periodically a task like
> writing on the serial port . And verify physically what happens.

Running the latency test under load an hour or two is recommended, to 
check if your platform has no issues.

Other than that, in order to compile the examples, you should read
this page:
http://www.xenomai.org/index.php/Examples

The following patch fixes some compilation issues, but even without 
this patch some of the examples do compile. The "unresolved references" 
you get are probably due to some missing arguments on make command line.

http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff_plain;h=87ac1c1f32181b5bcf4961aea30b9df34ba8a7ce;hp=472c85b997a5ab72355dd831af3a61183d371a83

-- 
                                                                Gilles.


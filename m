Subject: Re: [Xenomai-help] Timer problems?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17649.37187.585271.837835@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid>
	<44F17616.9080701@domain.hid> <1156680494.4325.68.camel@domain.hid>
	<17649.37187.585271.837835@domain.hid>
Content-Type: text/plain
Date: Sun, 27 Aug 2006 15:02:21 +0200
Message-Id: <1156683742.4325.75.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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
Cc: xenomai@xenomai.org

On Sun, 2006-08-27 at 14:34 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > - It is automatically solved by Xenomai over Linux 2.4, and should be
>  > solved by disabling CONFIG_VT entirely over Linux 2.6 for configurations
> 
> Disabling PC speaker is not enough to avoid the conflict on 2.6 ?
> 

CONFIG_INPUT_PCSPKR? Yes, it should actually be even better, since I
don't see any dependency of CONFIG_VT on CONFIG_INPUT_PCSPKR. Only the
input sub-system infrastructure is required.

-- 
Philippe.




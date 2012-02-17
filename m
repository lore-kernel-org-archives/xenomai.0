Message-ID: <4F3E276E.3080406@domain.hid>
Date: Fri, 17 Feb 2012 11:09:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOx7Giq4tKYk-5KgKAUJ7CPCx5KtRO_fDfEQZ+KBLHLZtPaSZA@mail.gmail.com>	<4F3E161A.2060106@domain.hid>
	<CAOx7GirhPs-vPtTC7i-3bKWZk7i_bH9Wdai4J=GivVNWxz5Faw@domain.hid>
In-Reply-To: <CAOx7GirhPs-vPtTC7i-3bKWZk7i_bH9Wdai4J=GivVNWxz5Faw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] porting of xenomai on on arm board(pandaomap4430)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramarao mundru <ramarao.mundru@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 02/17/2012 10:49 AM, ramarao mundru wrote:
> thankq for your kind response,i attached the my .config file please check
> the attached document

The kernel is configured for versatile, which xenomai does not support,
not for OMAP4. In a config file with OMAP4 enabled, you should have
CONFIG_ARCH_OMAP=y
CONFIG_ARCH_OMAP4=y

-- 
					    Gilles.


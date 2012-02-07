Message-ID: <4F3152FB.4030700@domain.hid>
Date: Tue, 07 Feb 2012 17:36:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F294E43.7060102@domain.hid> <4F2957A0.6040806@domain.hid>
	<4F29597F.8050500@domain.hid> <4F295C71.6090503@domain.hid>
	<4F295F39.7080003@domain.hid> <4F299EB7.604@domain.hid>
	<4F314F18.6020908@domain.hid> <4F314FBE.1090209@domain.hid>
	<4F315138.3020204@domain.hid>
In-Reply-To: <4F315138.3020204@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Built-in libxenomai dependency
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On 2012-02-07 17:28, Gilles Chanteperdrix wrote:
> This causes a -L/usr/lib to be added on the link-edit command line,
> which causes the link to fail by finding /usr/lib/libpthread.so instead
> of the cross-compiler one, and fail.

How does libxenomai.la look like? Is it different from a native build?

Hmm, there must be some valid way to express library dependencies inside
you package.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux


Message-ID: <489FF566.4090900@domain.hid>
Date: Mon, 11 Aug 2008 10:16:38 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <f52fe4ab0808102210q1602ec37rf885178fe0ae41ea@domain.hid>
In-Reply-To: <f52fe4ab0808102210q1602ec37rf885178fe0ae41ea@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error : Compiling 2.6.15 with xenomai-2.3.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?windows-1252?Q?=3F=3F?= <feiyeahfar@domain.hid>
Cc: xenomai@xenomai.org

> Hello :
> I've got errors when I compiled linux kernel 2.6.15 with
> adeos-ipipe-2.6.15-arm-1.5-08.patch, my gcc version is 3.4.1, my target
> board is at91rm9200(arm) which is said to be supported by xenomai-2.3.4,

The I-pipe patch 1.5 does not support your board. There is a second 
patch shipped with this Xenomai version which should work for you. It is 
for kernel 2.6.20.

-- 
Sebastian


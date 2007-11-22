Message-ID: <2ff1a98a0711220640i475b9d94h9b59cb07fe00cb61@domain.hid>
Date: Thu, 22 Nov 2007 15:40:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1806495015@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1806495015@domain.hid>
Subject: Re: [Xenomai-help] boot hang up with lapic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

You selected 586 as a processor, a processor without tsc, so Xenomai
uses the tsc emulation, maybe this is what causes the problem ? In
order to know, try selecting a processor with a tsc (586tsc or
better), the best option is to select the processor that you really
use, it allows linux makefile to select the best compilation options
for your processor.

-- 
                                               Gilles Chanteperdrix


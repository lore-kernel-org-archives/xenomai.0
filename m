Message-ID: <4582D65A.9010708@domain.hid>
Date: Fri, 15 Dec 2006 18:07:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Registering Interrupt Handler [Scanned]
References: <45814504.7050905@domain.hid> <4581526A.7010304@domain.hid>
	<45825668.3030703@domain.hid> <45827471.8000606@domain.hid>
	<45828192.4020105@domain.hid>
In-Reply-To: <45828192.4020105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Niklaus Burren <niklaus.burren@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Niklaus Burren wrote:
> When I apply the patch the kernel hangs while startup with a dot (see 
> line 3):
> 
> 01 eth0: link down
> 02 Sending BOOTP requests .<6>eth0: link up, full-duplex, lpa 0x45E1
> 03 .

Are you sure it is related with the patch ? Does the ethernet driver use
a GPIO ?

-- 
                                                 Gilles Chanteperdrix


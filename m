Message-ID: <4795DA26.70306@domain.hid>
Date: Tue, 22 Jan 2008 12:57:26 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <4e0b9cb00801220251v6506ed7eq962ccedf617f9bba@domain.hid>
In-Reply-To: <4e0b9cb00801220251v6506ed7eq962ccedf617f9bba@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Proprietary RTOS on top of Adeos
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Remi Lefevre <rlefevre@domain.hid>
Cc: adeos-main@gna.org

Remi Lefevre wrote:

> I have a simple question : does the Adeos licence and integration with
> Linux allows to port a proprietary RTOS on top of Adeos without
> setting it in GPL (as a whole or as a skin) ?

Everything which fiddles with the internals of the Linux kernel has to 
be seen as extension of GPL software, thus falls under the GPL, too. For 
this reason, Adeos is also licenced under the GPL, and so are the kernel 
parts of Xenomai and its skins. Normally, an RTOS emulation skin 
consists of a kernel part and userspace libraries. If you follow this 
path for your proprietary RTOS at least the kernel part must be GPL 
compliant.

-- 

Sebastian


Message-ID: <4601993C.5010701@domain.hid>
Date: Wed, 21 Mar 2007 21:44:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Socket Buffer overflow
References: <460191E0.7020606@domain.hid>
In-Reply-To: <460191E0.7020606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Robin Walser <robinwalser45@domain.hid>
Cc: xenomai@xenomai.org

Hello,

Robin Walser wrote:
> Hello,
> 
> I must write on my socket(rt_dev_sendmsg()) verry fast. Often I have 
> then a memory overflow. Is it possible?
> How can I examine whether sufficient memory is available?

Are you using RT-Socket-CAN? Could you please provide more detailed 
information like what is the returned error code and are there kernel 
log messages (visible with $ dmsg)?

Wolfgang.


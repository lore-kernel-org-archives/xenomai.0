Message-ID: <4399CC7D.3060909@domain.hid>
Date: Fri, 09 Dec 2005 19:27:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Clean-up powerpc SMP timer support
References: <4399C027.5030501@domain.hid>
In-Reply-To: <4399C027.5030501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Follow-up for the previously posted powerpc SMP timer support code.
> 
> It's better to let each processor set its own disarm_decr. Additionally, 
> cuts down unused code from UP build. Tested on a G5 SMP & UP.

Applied, thanks.

-- 

Philippe.


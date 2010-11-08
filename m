Message-ID: <4CD8246B.1080307@domain.hid>
Date: Mon, 08 Nov 2010 08:25:15 -0800
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <1289211836.298721730@domain.hid> <4CD817BB.80404@domain.hid>
	<1289232845.384714670@domain.hid>
In-Reply-To: <1289232845.384714670@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported cPCI systems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "edward.robbins@domain.hid" <edward.robbins@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Lockhart,
	Thomas G (388G)" <Thomas.G.Lockhart@domain.hid>

> Does the PP421 work with consistently low latencies?
> Did you need to modify Xenomai or the kernel at all?
> Could you tell me what kernel and xenomai versions you are using?

Yes, latencies are good (small with a few usec jitter as I recall). We 
did not need any patching or modifications beyond the basic Xenomai 
patching itself. We are using vanilla 2.6.26 kernels (due to constraints 
from a non-real-time driver). It is a 2.6.26-8 kernel and Xenomai-2.4.3.

hth

                       - Tom


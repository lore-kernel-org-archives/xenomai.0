Message-ID: <4CC9CBE1.6030006@domain.hid>
Date: Thu, 28 Oct 2010 21:15:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC998FB.3070102@domain.hid>
In-Reply-To: <4CC998FB.3070102@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm: Unprotected access to irq_desc field?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles,
> 
> I happened to come across rthal_mark_irq_disabled/enabled on arm. On
> first glance, it looks like these helpers manipulate irq_desc::status
> non-atomically, i.e. without holding irq_desc::lock. Isn't this fragile?

I have no idea. How do the other architectures do? As far as I know,
this code has been copied from there.


-- 
                                                                Gilles.


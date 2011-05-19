Message-ID: <4DD55E3E.2030203@domain.hid>
Date: Thu, 19 May 2011 20:15:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1305813493.2118.112.camel@domain.hid>
In-Reply-To: <1305813493.2118.112.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Getting rid of the NMI latency watchdog
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 05/19/2011 03:58 PM, Philippe Gerum wrote:
> For this reason, I'm considering issuing a patch for a complete removal
> of the NMI latency watchdog code in Xenomai 2.6.x, disabling the feature
> for 2.6.38 kernels and above in 2.5.x.
> 
> Comments welcome.

I am in the same case as you: I no longer use Xeno's NMI watchdog, so I
agree to get rid of it.

-- 
                                                                Gilles.


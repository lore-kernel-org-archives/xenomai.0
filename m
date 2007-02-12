Message-ID: <45D0652D.4070500@domain.hid>
Date: Mon, 12 Feb 2007 14:01:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>	
	<17864.63903.244809.994959@domain.hid>	
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>	
	<45C9B7C4.8050705@domain.hid>	
	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>	
	<45CB4291.408@domain.hid>	
	<cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>	
	<45CCA96C.7080605@domain.hid>
	<cbe23c50702120058s2bf042d0o95bb1a69997e921a@domain.hid>
	<45D034FF.90900@domain.hid>
In-Reply-To: <45D034FF.90900@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
> But can someone explain *why* there is a clash? Is it due to I-pipe
> injecting tick events *aside* HPET-generated ticks? I think we should
> address this clash when I-pipe has to be adopted to clock_event/dyntick
> in 2.6.21.

Maybe the rthal code assume that the local APIC is initialized, whereas
it is not, when using the HPET ?

-- 
                                                 Gilles Chanteperdrix


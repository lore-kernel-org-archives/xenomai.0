Message-ID: <4CDC0FBD.9050402@domain.hid>
Date: Thu, 11 Nov 2010 16:46:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	
	<1288816871.1842.84.camel@domain.hid>	
	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>	
	<4CD1E890.5010702@domain.hid>	<4CD1EC2F.4040603@domain.hid>	
	<4CD1ED16.8030103@domain.hid>	<4CD1EDA8.10007@domain.hid>	
	<4CD1F33C.5070208@domain.hid>	<4CD1F3F5.5080505@domain.hid>	
	<4CD1F4FE.9020908@domain.hid>	<4CD1F69B.9070100@domain.hid>	
	<4CD1F906.1070703@domain.hid>	<4CD1FABD.1080301@domain.hid>	
	<4CD2612C.2070507@domain.hid>	<4CD279F7.7070502@domain.hid>	
	<4CD27C46.8010302@domain.hid>	<4CD27DC2.7060607@domain.hid>	
	<4CD2A96B.3080001@domain.hid>	<4CD2B2A7.9010900@domain.hid>	
	<4CD2C50F.1090604@domain.hid>	<4CD32E76.3080004@domain.hid>	
	<4CD33F0C.1050403@domain.hid>	<4CD340AA.60002@domain.hid>	
	<4CD34355.5020304@domain.hid> <4CD35DC7.1000507@domain.hid>	
	<4CD3DAC5.6000400@domain.hid> <4CD4A0EF.1@domain.hid>	
	<4CD5B9FC.6050602@domain.hid> <4CD5BC82.6060106@domain.hid>
	<1289083796.1842.239.camel@domain.hid> <4CD5FA26.4090504@domain.hid>
In-Reply-To: <4CD5FA26.4090504@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> I just hope we finally converge over a solution. Looks like all
> possibilities have been explored now. A few more comments on this one:
> 
> It probably makes sense to group the status bits accordingly (both their
> values and definitions) and briefly document on which status field they
> are supposed to be applied.
> 
> I do not understand the split logic - or some bits are simply not yet
> migrated. XNHDEFER, XNSWLOCK, XNKCOUT are all local-only as well, no?
> Then better put them in the _local_ status field, that's more consistent
> (and would help if we once wanted to optimize their cache line usage).
> 
> The naming is unfortunate: status vs. lstatus. This is asking for
> confusion and typos. They must be better distinguishable, e.g.
> local_status. Or we need accessors that have debug checks built in,
> catching wrong bits for their target fields.
> 
> Good catch of the RPI breakage, Gilles!

Hi Jan,

I just pushed a modified version of this patch, including your remarks
as well as the ones of Philippe. I suspect some of the cleanup patches
you sent still make sense over this patch, would it be possible to
rebase them over this pushed version?

TIA,

-- 
                                                                Gilles.


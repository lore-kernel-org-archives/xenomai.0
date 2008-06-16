Message-ID: <48562EC1.9000507@domain.hid>
Date: Mon, 16 Jun 2008 11:13:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4850DC9D.4010607@domain.hid>	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid> <485174A7.7040505@domain.hid>
	<485227E2.3030603@domain.hid> <48523BE4.8070403@domain.hid>
	<48523E11.40702@domain.hid> <4854CF37.20001@domain.hid>
	<485627D1.7060702@domain.hid>
In-Reply-To: <485627D1.7060702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High latencies on Core2Duo
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Philippe Gerum wrote:
>> Could you try booting with idle=poll just to make sure that we don't
>> get trapped
>> into long wakeup latency from some idling instruction? We explicitly
>> avoid mwait
>> unless forced to use it by a bootparam, but maybe something goes wrong
>> with the
>> default idle code as well.
> 
> Attached is a new trace, I've booted with idle=poll. The latency spots
> are still there. Maybe Gilles is right and the SMI disabling code needs
> an adaption to new chipsets.
> 

Looking at the trace, Gilles is very likely right indeed.

-- 
Philippe.


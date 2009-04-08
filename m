Message-ID: <49DC6612.40802@domain.hid>
Date: Wed, 08 Apr 2009 10:53:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>	
	<b131c9f0903240037q446193f5hbfdd3ade40ea2af4@domain.hid>	
	<49C91B24.2020304@domain.hid>	
	<b131c9f0903241437s661b9bd3v504b14f83b1b9c86@domain.hid>	
	<49C95A76.4020802@domain.hid>	
	<b131c9f0903250636o85af46au240a04ab33ebb599@domain.hid>	
	<b131c9f0904060126n12158c5dqd37d71769cc8aff5@domain.hid>	
	<49D9E000.4070009@domain.hid>	
	<1239099594.9869.65.camel@domain.hid>	
	<49DB3717.4090402@domain.hid>
	<b131c9f0904080057v49b2caf3s5c2096827dd1576d@domain.hid>
In-Reply-To: <b131c9f0904080057v49b2caf3s5c2096827dd1576d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Vikesh Rambaran <vikesh.rambaran@domain.hid>

vikesh rambaran wrote:
> Hi
> 
> On Tue, Apr 7, 2009 at 1:20 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> 
>> Hmm, maybe we have issues with MTRR again. Can you also try X without
>> CONFIG_MTRR set in the kernel?
> 
> 
> Tried the following combinations on intel and amd platforms
> 
> 1. No MTRR on 2.6.28.7 + Xenomai 2.4.7 for Intel core 2
> 2. No MTRR on 2.6.28.7 + Xenomai 2.4.7 + LTTng for Amd Athlon
> 
> Lockup still persists (:

OK, something to rule out. So I'm hoping for serial/netconsole dumps now
(don't forget to switch off klogd for this, otherwise the information
may get lost between crashing ipipe/xenomai and klogd.

> 
> Going to compare the vanilla installation message log with that of the
> xenomai patched installation
> ("Unable to set hardware clock" is something i don't remember seeing in the
> vanilla logs - will check again)

The RTC issue is most probably unrelated, should rather have something
to do with conflicting old/new RTC config switches (sorry, don't recall
details ATM).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


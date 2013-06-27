Message-ID: <51CC85FE.7080308@xenomai.org>
Date: Thu, 27 Jun 2013 20:35:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1371808801.4609.xenomai@xenomai.org>	<1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>
	<51C45C6F.9080109@siemens.com>
In-Reply-To: <51C45C6F.9080109@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High latency and smi with intel vendor chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Franz Engel <franz_lambert_engel@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/21/2013 04:00 PM, Jan Kiszka wrote:

> On 2013-06-21 15:07, Franz Engel wrote:
>> Hi,
>>
>> In my dmesg I get the following message:
>> dmesg | grep -i xeno
>> [    4.478964] I-pipe: head domain Xenomai registered.
>> [    4.494089] Xenomai: hal/x86_64 started.
>> [    4.505969] Xenomai: scheduling class idle registered.
>> [    4.521300] Xenomai: scheduling class rt registered.
>> [    4.538525] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loaded.
>> [    4.559065] Xenomai: debug mode enabled.
>> [    4.579351] Xenomai: SMI-enabled chipset found
>> [    4.592628] Xenomai: SMI workaround failed!
>> [    4.605677] Xenomai: starting native API services.
>> [    4.619979] Xenomai: starting POSIX services.
>> [    4.633088] Xenomai: starting RTDM services.
>>
>>
>> And I have very high latencies. I read that I should try to insert my the ID of my LCP into the /usr/src/xenomai/ksrc/arch/x86/smi.c file.
> 
> That is no longer true since 2.6.2.1. Xenomai already detects your LPC
> (see above), but the BIOS has apparently locked SMI disabling down.


This change was made after 2.6.2.1. With 2.6.2.1, it is still necessary
to add the ISA bridge ids to the list.

You do not have to bother if you use the smictrl tool, though.

-- 
                                                                Gilles.


Message-ID: <46C1B498.8060600@domain.hid>
Date: Tue, 14 Aug 2007 15:56:40 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>
In-Reply-To: <46C07005.8000504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
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
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>

Hi,

Some new insight:

I have included the rtnet list because I think this is of interest and I 
don;t know exactly where the problem arises. Most likely EML but which 
goes unnecessarily haywire when xenomai has a latency glitch which seems 
to be caused by rtcan but may also be rtnet (so the rest of you can stop 
reading here :) )

To refresh, I am running EML and rtcan together and separately they 
appear to function perfectly but when combined, EML sometimes starts 
ejecting the error:

EC_Telegram::index_check() : index not the same,
low_level_input() :  framebuilding failed.

Or something pretty closely to that effect.

Despite EML warning that the frame could not be built, the inputs (which 
rely on the framebuilding being succesful pretty stringently) seem to 
function perfectly. It seems as though EML is emitting a false warning.

I have now killed the warning from EML with the following hack:

In EC_Telegram::check_index() I have effectively killed the check by 
snubbing the holler and always returning true. Now the application no 
longer emits warnings and everything functions well (or so it seems). I 
have a sawtooth analog output on a scope which triggers well. It 
fluttered sometimes when EML emitted the warning. Presumably the 
fluttering is caused by some latency which I thought might be the result 
of EML emitting the warnings. However even without the warnings from EML 
this fluttering incidentally takes place. Generally I can increase the 
chance of this flutter (I will confirm this with a latency test later 
on) by clicking about in the user interface of my application (QT).


So EML seems to go haywire when there is latency and there seems to be 
latency when I am using rtcan. (Bit of latency can also be caused by 
clicking about but I think it is mainly rtcan causing the latency spikes 
and the clicking about just knocks it over the edge more often.)

I have also made the index that is supposedly not the same visible. For 
the EML chaps: index and m_idx and the output seems to be something like 
this

index	m_idx
0	1
0	0
1	2
2	3
2	3
3	4
4	5
:	:
:	:
253	254
0	2

or something to that effect. Can anyone comment on this?


P.S.

Everything else is sorted out now, application closes neatly all 
sockets, no buffer overruns, no errors in syslog etc.

Also I have managed to get the initialization of the socket to the non 
real-time context but the problem persists in exactly the same manner.

I have increased the rtskbf_cache_size. The problem occurs less 
frequently but certainly does not subside completely. Irrespective of 
how big I make it after that.  There is no mention of any problem in 
this regard in any of the logs anymore (dmesg syslog etc)

Roland.









These are the comments that have been made which may be relevant:



Jan Kiszka wrote:
> In 9 of 10 cases (if not more): timing. Running both alone doesn't
> expose some timing issue (race) or transient overload. I can't help with
> EML complaints, maybe the FMTC guys have an idea what can trigger this
> and how to debug it.

>>>>>> RTnet:rtskb allocation from real-time cache failed.

> You have created the socket for some/all EML activity from primary mode
> of some Xenomai thread, thus network buffer allocation is ought to run
> against the real-time rtskb pool - which is by default empty :p. See
> README.pools from the RTnet documentation on this.

Although this was a problem


> 
> I don't have the EML design at hand, but you might be able to avoid this
> by initialising before creating the shadow task or by explicitly
> switching to secondary mode before initialising. [Sorry for this issue,
> it's at least partly due to some outdated RTnet design.]
> 
> Jan
> 


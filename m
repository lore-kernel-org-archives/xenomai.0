From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DBA8655.9050400@domain.hid>
References: <4DBA8655.9050400@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Apr 2011 12:31:07 +0200
Message-ID: <1304159467.1823.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to interpret /proc/xenomai/stat CPU time of
 threads with priority 0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thierry Bultel <thierry.bultel@domain.hid>
Cc: xenomai@xenomai.org, Nicolas Mabire <nicolas.mabire@domain.hid>, Jean-Baptiste Tredez <jean-baptiste.tredez@domain.hid>

On Fri, 2011-04-29 at 11:35 +0200, Thierry Bultel wrote:
> Hi all,
> 
> I was wondering if the displayed CPU time was, for these particular
> threads, 
> the only time spent in primary mode, of the total amount of time spent
> on the CPU.
> 
> I am namely currently debugging an application which has such kind of
> thread,
> with a period of 50ms, and that takes up to 23% of the CPU.
> That is bad, but not a real issue if that time is spent only in
> secondary mode,
> but I do not know how to figure it out. 
> The mode switches frequency is equal to the period of my thread, since
> it uses rt_task_wait_period
> 
> I am a little bit concerned, my fear is that secondary mode time would
> be counted in the ROOT task ...
> BTW, I am using version 2.5.2 (I know, it's old ;-) ).

23% is the time spent by your thread in primary mode, secondary mode is
indeed charged to the root thread.
> 
> Any help would be appreciated.
> 
> Thanks
> Thierry
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.




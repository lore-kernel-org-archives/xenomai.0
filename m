Message-ID: <4C61401D.8010202@domain.hid>
Date: Tue, 10 Aug 2010 14:03:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C573CCB.7090006@domain.hid> <4C610855.1080105@domain.hid>
In-Reply-To: <4C610855.1080105@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Wolfgang Mauerer wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> you will find Xenomai 2.5.4, aka "Sleep Walk", at the usual place:
>> http://download.gna.org/xenomai/stable/xenomai-2.5.4.tar.bz2
>>
>> It contains the usual amount of bug fixes and I-pipe patches update, as 
>> well as a new piece of nice code: the so-called mayday support, which 
>> should allow Xenomai watchdog to work less brutally (namely, avoid 
>> killing the tasks occupying too much CPU, and send them a signal), and 
>> be the base for a new version of user-space signals in the 2.6 branch.
>>
>> Alex also pushed a lot of improvements for the analogy support.
>>
>> So, it seems not everybody has been lazy like me for this last version.
> 
> to satisfy my curiosity: What was the exact reason for not including
> the hostrt stuff? After having spent quite some (obviously wasted)
> effort to make the code compliant with the maintainer's requests, I
> wonder what could have been missing.

I was Ok with the Xenomai part, but we needed Philippe to review the
Adeos part, and release new versions of the patches, and having delayed
the 2.5.4 release for some time, and did not feel like delaying it much
longer.

Besides, we have started the 2.6 branch, and such a big change makes
perfect material for this new branch.

Your patches are not wasted, they have just been put on hold.

-- 
					    Gilles.


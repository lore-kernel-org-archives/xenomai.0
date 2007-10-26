Message-ID: <47219808.9090703@domain.hid>
Date: Fri, 26 Oct 2007 09:32:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4721048B.3040703@domain.hid> <472105E2.4040801@domain.hid>
	<472108F1.6060007@domain.hid> <47210A44.7060203@domain.hid>
In-Reply-To: <47210A44.7060203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Compile-time patch for mm_struct
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> Thank you very much.  I hate to make extra work for you - is there a git
> repository for adeos-ipipe that I should be pulling from?
> 

git://www.denx.de/git/ipipe-2.6

>     Steve
> 
> 
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>   
>>> Steven A. Falco wrote:
>>>     
>>>> I needed the following patch to fix a forward reference (caught by gcc 4.1.1).  I posted this as part of an earlier discussion, but I then realized that it might be overlooked, so I'm reposting it as a new thread:
>>>>
>>>>       
>>> Thanks. This one was caught a few days back and only recently merged. I guess
>>> it's time to roll out a new 2.6.23/powerpc I-pipe patch.
>>>
>>>     
>>
>> http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch
>>
>>   


-- 
Philippe.


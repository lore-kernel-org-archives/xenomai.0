Message-ID: <4B9BE14E.1040109@domain.hid>
Date: Sat, 13 Mar 2010 20:02:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1268327902.27899.106.camel@domain.hid>	
	<4B9BC504.8070704@domain.hid> <4B9BCB7F.9070307@domain.hid>
	<1268505730.27899.173.camel@domain.hid>
In-Reply-To: <1268505730.27899.173.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] Blackfin upgrade and minor fixes
 for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Sat, 2010-03-13 at 18:29 +0100, Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>> The following changes since commit 55b0aa9de28891fcfd4b4ab097583bd7619223ab:
>>>>   Philippe Gerum (1):
>>>>         native: introduce rt_task_same()
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://xenomai.org/xenomai-rpm.git for-upstream
>>>>
>>>> Philippe Gerum (5):
>>>>       testsuite/latency: fix false positive in mode switch detection
>>>>       powerpc: remove dandling reference
>>>>       blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
>>> Could you upgrade the blackfin README file to include the tag to use,
>>> for applying this patch?
>>>
>> In fact, it seems the ipipe-blackfin git has no tags.
>>
>>
> 
> ipipe-blackfin only contains reference snapshots of the kernel code for
> the pre 2.6.33 releases we still support; the Blackfin dev trunk we used
> to be based on is periodically rebased, which requires us to keep those
> stable snapshots.
> 
> ipipe-blackfin is now dead, only kept for reference. The pipeline dev
> now occurs in ipipe-2.6 with other supports for mainlined architectures.

I understand that, but I need tags in the ipipe-blackfin git tree to get
the kernel sources to build-test the blackfin patches. I mistakenly
removed these directories I had been using for a long time.

There seems to be something wrong with the ipipe-blackfin git tree:

gilles@domain.hid:~$ git clone git://git.denx.de/ipipe-blackfin.git
Initialized empty Git repository in /home/gilles/ipipe-blackfin/.git/
remote: Counting objects: 1280727, done.
remote: Compressing objects: 100% (208654/208654), done.
remote: Total 1280727 (delta 1063759), reused 1280727 (delta 1063759)
Receiving objects: 100% (1280727/1280727), 278.55 MiB | 544 KiB/s, done.
Resolving deltas: 100% (1063759/1063759), done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.

gilles@domain.hid:~$ cd ipipe-blackfin/
gilles@domain.hid$ git branch
gilles@domain.hid$ git tag
gilles@domain.hid$

-- 
					    Gilles.


Message-ID: <547779CF.3080903@siemens.com>
Date: Thu, 27 Nov 2014 20:21:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com> <20141127185603.GM7842@hermes>
In-Reply-To: <20141127185603.GM7842@hermes>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-11-27 19:56, Gilles Chanteperdrix wrote:
> On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
>> On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
>>> On Thu, Nov 27, 2014 at 05:25:59PM +0100, Jan Kiszka wrote:
>>>> The following changes since commit c13ff82ac09f6daa94778dcd8b51902efd754f3d:
>>>>
>>>>   rtnet: update at91_ether driver (2014-11-16 20:06:04 +0100)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.xenomai.org/xenomai-jki.git for-forge
>>>>
>>>> for you to fetch changes up to d36ae28f9c0549c0af66e896711dde21ea769587:
>>>>
>>>>   regd: Switch to tmpfs as default (2014-11-27 17:19:33 +0100)
>>>
>>> According to the filesystem hierarchy standard, /mnt is the standard
>>> place for "temporarily mounted filesystems".
>>>
>>> http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
>>
>> Right, another reason to NOT mess around with it: if something was
>> temporarily mounted there, we will create the mountpoint inside that
>> filesystem with unforeseeable side effects.
> 
> Note the plural: filesystemS
> It is very very very common to have multiple directories in /mnt and
> mount filesytems in there.
> 
>>
>>>
>>> /run is a deviation to the standard, and does not seem to be
>>> indicated as a mount point (though debian mounts things there).
>>
>> "Modern" distros do, according to that article, so I suppose the
>> majority. It's about to become standard.
>>
>>>
>>> The standard equivalent of /run would be /var/run.
>>>
>>> But why do we need to change that globally, is not this configurable?
>>
>> We must stop writing to potentially read-only and/or non-local
>> directories. If it's /run or /var/run, I don't care too much.
> 
> Your change currently breaks Xenomai with the tool I, Philippe and
> Jorge are using to test xenomai on the platforms I have at home. So,
> there better be a good reason, and that does not look like one. If
> you want mnt to be a tmpfs, then make it one, who is stopping you
> from doing it ?

/mnt existed before Xenomai 3 came around, so the latter has to accept
the rules, not the former. We must fix this default behaviour before
release.

Again, if /var/run is preferred, I'll change the commit, but /mnt is an
absolute no-go.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


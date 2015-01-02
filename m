Message-ID: <54A69D42.2010408@xenomai.org>
Date: Fri, 02 Jan 2015 14:29:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de>
In-Reply-To: <54A67CD1.10103@web.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 01/02/2015 12:11 PM, Jan Kiszka wrote:
> On 2015-01-02 11:58, Philippe Gerum wrote:
>> On 01/02/2015 11:28 AM, Jan Kiszka wrote:
>>> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
>>>> Module: xenomai-3
>>>> Branch: next
>>>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
>>>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=d351f712bc9b03d621b454b55fe3e46a0000294a
>>>>
>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>> Date:   Thu Jan  1 18:15:36 2015 +0100
>>>>
>>>> copperplate: add configuration tunable for registry moint point
>>>>
>>>> --enable-registry[=/registry-mount-point]
>>>>
>>>> Defaults to /mnt/xenomai.
>>>
>>> Do we really have to leave this as default? Then at least the debian
>>> rules must be fixed to use a FHS-conforming path for distributed packages.
>>>
>>
>> I don't care about which default is picked, really. I would agree with
>> both options equally, i.e. using /mnt or /var/run, since /mnt has been a
>> sensible and documented root for temporary mount points for ages in the
>> *nix world, although I find /var/run a reasonable choice for
>> non-persistent mount points as well.
> 
> As I explained (and I wasn't alone with this view), this is not a matter
> of taste but standard compliance: FHS requires us - as soon as we
> consider Xenomai being part of the platform and not some self-written
> admin script - to keep away from /mnt. You would have a hard time
> finding a distro package that writes to /mnt without being explicitly
> told by the admin.

FHS 2.3 required volatile data to go to /var/run, and then Debian and
others found out that it might not be the most usable choice, and went
for /run+symlink to cope with legacy, until FHS 3.0 validates this
arbitrary change eventually.

So, I'm ok with FHS, but in that particular case, FHS has been wrong for
years it seems. I'd rather discuss about usability then. The kind of
issues I'd like to see people discussing instead of going ballistic for
a freaking mount point would rather be:

/var/run means tmpfs, which implies rw.
/mnt means root fs, which might imply ro in some embedded cases.

x3 applications can mention the registry mount point to be used
dynamically when starting up, so keeping /mnt would request ro fs users
to either select a different mount point dynamically (e.g. to /var/run),
or have /mnt/xenomai persistent in their read-only root fs.

It could be acceptable, or maybe there are arguments against requiring
this. Please discuss about usability issues first and foremost.

-- 
Philippe.


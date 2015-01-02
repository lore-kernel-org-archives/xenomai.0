Message-ID: <54A679D5.20903@xenomai.org>
Date: Fri, 02 Jan 2015 11:58:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de>
In-Reply-To: <54A672BA.8090209@web.de>
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

On 01/02/2015 11:28 AM, Jan Kiszka wrote:
> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
>> Module: xenomai-3
>> Branch: next
>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=d351f712bc9b03d621b454b55fe3e46a0000294a
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Thu Jan  1 18:15:36 2015 +0100
>>
>> copperplate: add configuration tunable for registry moint point
>>
>> --enable-registry[=/registry-mount-point]
>>
>> Defaults to /mnt/xenomai.
> 
> Do we really have to leave this as default? Then at least the debian
> rules must be fixed to use a FHS-conforming path for distributed packages.
> 

I don't care about which default is picked, really. I would agree with
both options equally, i.e. using /mnt or /var/run, since /mnt has been a
sensible and documented root for temporary mount points for ages in the
*nix world, although I find /var/run a reasonable choice for
non-persistent mount points as well.

However, there does not seem to be a consensus on this issue among other
maintainers, therefore I'm going for backward compatibility with early
x3 code some people have been running for two years now, keeping /mnt.

The patch I have issued allows to override this default using a
configuration switch, so that everyone can define this path statically
at build time.

If people eventually come to a consensus on a different but still
reasonable default value before the last -rc is released, I'll be glad
to merge it.

-- 
Philippe.


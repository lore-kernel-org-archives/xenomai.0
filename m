Message-ID: <54A697D0.7010007@web.de>
Date: Fri, 02 Jan 2015 14:06:24 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <20150102125607.GB1492@daedalus>
In-Reply-To: <20150102125607.GB1492@daedalus>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-01-02 13:56, Gilles Chanteperdrix wrote:
> On Fri, Jan 02, 2015 at 12:11:13PM +0100, Jan Kiszka wrote:
>> On 2015-01-02 11:58, Philippe Gerum wrote:
>>> On 01/02/2015 11:28 AM, Jan Kiszka wrote:
>>>> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
>>>>> Module: xenomai-3
>>>>> Branch: next
>>>>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-3.git;a=3Dcommit;h=3Dd351=
f712bc9b03d621b454b55fe3e46a0000294a
>>>>>
>>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>>> Date:   Thu Jan  1 18:15:36 2015 +0100
>>>>>
>>>>> copperplate: add configuration tunable for registry moint point
>>>>>
>>>>> --enable-registry[=3D/registry-mount-point]
>>>>>
>>>>> Defaults to /mnt/xenomai.
>>>>
>>>> Do we really have to leave this as default? Then at least the debian
>>>> rules must be fixed to use a FHS-conforming path for distributed packa=
ges.
>>>>
>>>
>>> I don't care about which default is picked, really. I would agree with
>>> both options equally, i.e. using /mnt or /var/run, since /mnt has been a
>>> sensible and documented root for temporary mount points for ages in the
>>> *nix world, although I find /var/run a reasonable choice for
>>> non-persistent mount points as well.
>>
>> As I explained (and I wasn't alone with this view), this is not a matter
>> of taste but standard compliance: FHS requires us - as soon as we
>> consider Xenomai being part of the platform and not some self-written
>> admin script - to keep away from /mnt. You would have a hard time
>> finding a distro package that writes to /mnt without being explicitly
>> told by the admin.
>>
> =

> Also, there are other places where Xenomai does not conform to
> standards that suck. For instance, we do not implement
> PTHREAD_MUTEX_INITIALIZER and PTHREAD_COND_INITIALIZER, which put us
> clearly in violation of the POSIX standard. And this is a violation
> which as more consequences on users porting code to Xenomai.

Sure, but there is at least an implementation-related reason behind it,
not just legacy naming.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/47f7dd0=
6/attachment.sig>

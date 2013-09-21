Message-ID: <523D6445.901@web.de>
Date: Sat, 21 Sep 2013 11:17:57 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <E1VN5el-0002Ct-8K@xenomai.org> <523D594F.1050605@xenomai.org>
In-Reply-To: <523D594F.1050605@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/posix/sem: Fix
 locking imbalances in cobalt_sem_open
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-09-21 10:31, Philippe Gerum wrote:
> On 09/20/2013 08:42 PM, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: 8775720ae828d1e1be076f91b93a3eeac1b7ed90
>> URL:   =

>> http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D8775720ae828d=
1e1be076f91b93a3eeac1b7ed90
>>
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Fri Sep 20 20:39:18 2013 +0200
>>
>> cobalt/posix/sem: Fix locking imbalances in cobalt_sem_open
>>
>> We hold cobalt_assoc_lock, not nklock.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
> =

> This fix should be backported to 2.6.

I don't find this pattern in 2.6. There we seem to use only nklock.

Jan

> =

>> ---
>>
>>   kernel/cobalt/posix/sem.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
>> index 076f2d2..60906fd 100644
>> --- a/kernel/cobalt/posix/sem.c
>> +++ b/kernel/cobalt/posix/sem.c
>> @@ -916,7 +916,7 @@ int cobalt_sem_open(unsigned long __user *u_addr,
>>       if (assoc) {
>>           usm =3D container_of(assoc, struct cobalt_usem, assoc);
>>           ++usm->refcnt;
>> -        xnlock_put_irqrestore(&nklock, s);
>> +        xnlock_put_irqrestore(&cobalt_assoc_lock, s);
>>           goto got_usm;
>>       }
>>
>> @@ -936,7 +936,7 @@ int cobalt_sem_open(unsigned long __user *u_addr,
>>       assoc =3D cobalt_assoc_lookup(&cc->usems, (u_long)sm->sem);
>>       if (assoc) {
>>           container_of(assoc, struct cobalt_usem, assoc)->refcnt++;
>> -        xnlock_put_irqrestore(&nklock, s);
>> +        xnlock_put_irqrestore(&cobalt_assoc_lock, s);
>>           xnfree(usm);
>>           usm =3D container_of(assoc, struct cobalt_usem, assoc);
>>           goto got_usm;
>>
>>
>> _______________________________________________
>> Xenomai-git mailing list
>> Xenomai-git@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai-git
>>
> =

> =



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130921/bac4704=
f/attachment.pgp>

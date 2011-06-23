Message-ID: <4E030956.5030702@domain.hid>
Date: Thu, 23 Jun 2011 11:37:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid>
	<4DFDCBEA.6010905@domain.hid>	<4DFDDAB8.4090709@domain.hid>
	<4DFDF2E1.1060106@domain.hid> <4DFF7E4A.3070807@domain.hid>
In-Reply-To: <4DFF7E4A.3070807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40798AD2B6F662FE128A3BBB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40798AD2B6F662FE128A3BBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-20 19:07, Jan Kiszka wrote:
> On 2011-06-19 15:00, Gilles Chanteperdrix wrote:
>> On 06/19/2011 01:17 PM, Gilles Chanteperdrix wrote:
>>> On 06/19/2011 12:14 PM, Gilles Chanteperdrix wrote:
>>>> I am working on this ppd cleanup issue again, I am asking for help t=
o
>>>> find a fix in -head for all cases where the sys_ppd is needed during=

>>>> some cleanup.
>>>>
>>>> The problem is that when the ppd cleanup is invoked:
>>>> - we have no guarantee that current is a thread from the Xenomai
>>>> application;
>>>> - if it is, current->mm is NULL.
>>>>
>>>> So, associating the sys_ppd to either current or current->mm does no=
t
>>>> work. What we could do is pass the sys_ppd to all the other ppds cle=
anup
>>>> handlers, this would fix cases such as freeing mutexes fastlock, but=

>>>> that does not help when the sys_ppd is needed during a thread deleti=
on hook.
>>>>
>>>> I would like to find a solution where simply calling xnsys_ppd_get()=

>>>> will work, where we do not have an xnsys_ppd_get for each context, s=
uch
>>>> as for instance xnsys_ppd_get_by_mm/xnsys_ppd_get_by_task_struct,
>>>> because it would be too error-prone.
>>>>
>>>> Any idea anyone?
>>>
>>> The best I could come up with: use a ptd to store the mm currently=20
>>> being cleaned up, so that xnshadow_ppd_get continues to work, even
>>> in the middle of a cleanup.
>>
>> In order to also get xnshadow_ppd_get to work in task deletion hooks=20
>> (which is needed to avoid the issue at the origin of this thread), we =

>> also need to set this ptd upon shadow mapping, so it is still there=20
>> when reaching the task deletion hook (where current->mm may be NULL). =

>> Hence the patch:
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index b243600..6bc4210 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -65,6 +65,11 @@ int nkthrptd;
>>  EXPORT_SYMBOL_GPL(nkthrptd);
>>  int nkerrptd;
>>  EXPORT_SYMBOL_GPL(nkerrptd);
>> +int nkmmptd;
>> +EXPORT_SYMBOL_GPL(nkmmptd);
>> +
>> +#define xnshadow_mmptd(t) ((t)->ptd[nkmmptd])
>> +#define xnshadow_mm(t) ((struct mm_struct *)xnshadow_mmptd(t))
>=20
> xnshadow_mm() can now return a no longer existing mm. So no user of
> xnshadow_mm should ever dereference that pointer. Thus we better change=

> all that user to treat the return value as a void pointer e.g.
>=20
>> =20
>>  struct xnskin_slot {
>>  	struct xnskin_props *props;
>> @@ -1304,6 +1309,8 @@ int xnshadow_map(xnthread_t *thread, xncompletio=
n_t __user *u_completion,
>>  	 * friends.
>>  	 */
>>  	xnshadow_thrptd(current) =3D thread;
>> +	xnshadow_mmptd(current) =3D current->mm;
>> +
>>  	rthal_enable_notifier(current);
>> =20
>>  	if (xnthread_base_priority(thread) =3D=3D 0 &&
>> @@ -2759,7 +2766,15 @@ static void detach_ppd(xnshadow_ppd_t * ppd)
>> =20
>>  static inline void do_cleanup_event(struct mm_struct *mm)
>>  {
>> +	struct task_struct *p =3D current;
>> +	struct mm_struct *old;
>> +
>> +	old =3D xnshadow_mm(p);
>> +	xnshadow_mmptd(p) =3D mm;
>> +
>>  	ppd_remove_mm(mm, &detach_ppd);
>> +
>> +	xnshadow_mmptd(p) =3D old;
>=20
> I don't have the full picture yet, but that feels racy: If the context
> over which we clean up that foreign mm is also using xnshadow_mmptd,
> other threads in that process may dislike this temporary change.
>=20
>>  }
>> =20
>>  RTHAL_DECLARE_CLEANUP_EVENT(cleanup_event);
>> @@ -2925,7 +2940,7 @@ EXPORT_SYMBOL_GPL(xnshadow_unregister_interface)=
;
>>  xnshadow_ppd_t *xnshadow_ppd_get(unsigned muxid)
>>  {
>>  	if (xnpod_userspace_p())
>> -		return ppd_lookup(muxid, current->mm);
>> +		return ppd_lookup(muxid, xnshadow_mm(current) ?: current->mm);
>> =20
>>  	return NULL;
>>  }
>> @@ -2960,8 +2975,9 @@ int xnshadow_mount(void)
>>  	sema_init(&completion_mutex, 1);
>>  	nkthrptd =3D rthal_alloc_ptdkey();
>>  	nkerrptd =3D rthal_alloc_ptdkey();
>> +	nkmmptd =3D rthal_alloc_ptdkey();
>> =20
>> -	if (nkthrptd < 0 || nkerrptd < 0) {
>> +	if (nkthrptd < 0 || nkerrptd < 0 || nkmmptd < 0) {
>>  		printk(KERN_ERR "Xenomai: cannot allocate PTD slots\n");
>>  		return -ENOMEM;
>>  	}
>> diff --git a/ksrc/skins/posix/mutex.c b/ksrc/skins/posix/mutex.c
>> index 6ce75e5..cc86852 100644
>> --- a/ksrc/skins/posix/mutex.c
>> +++ b/ksrc/skins/posix/mutex.c
>> @@ -219,10 +219,6 @@ void pse51_mutex_destroy_internal(pse51_mutex_t *=
mutex,
>>  	xnlock_put_irqrestore(&nklock, s);
>> =20
>>  #ifdef CONFIG_XENO_FASTSYNCH
>> -	/* We call xnheap_free even if the mutex is not pshared; when
>> -	   this function is called from pse51_mutexq_cleanup, the
>> -	   sem_heap is destroyed, or not the one to which the fastlock
>> -	   belongs, xnheap will simply return an error. */
>=20
> I think this comment is not completely obsolete. It still applies /wrt
> shared/non-shared.
>=20
>>  	xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
>>  		    mutex->synchbase.fastlock);
>>  #endif /* CONFIG_XENO_FASTSYNCH */
>>
>>
>=20
> If we can resolve that potential race, this looks like a nice solution.=


We still have to address that ordering issue I almost forgot:
do_cleanup_event runs before do_task_exit_event when terminating the
last task. The former destroys the sem heap, the latter fires the delete
hook which then tries to free msendq.fastlock to an invalid heap.

Should be fixable by setting sem_heap NULL in the ppd on destroy and
skipping the fastlock release in __task_delete_hook if the heap pointer
is found like that.

Jan


--------------enig40798AD2B6F662FE128A3BBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4DCVYACgkQitSsb3rl5xRAQwCfWSAiDcY/CyFt8JnTLv1Wx1Ch
BhYAmwb5lBlwnXhvNwUSXZSVJ2AFtoRU
=lM7e
-----END PGP SIGNATURE-----

--------------enig40798AD2B6F662FE128A3BBB--


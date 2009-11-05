Message-ID: <4AF2AEF9.2050207@domain.hid>
Date: Thu, 05 Nov 2009 11:54:49 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
References: <4AF1474C.7000701@domain.hid>
	<1257331856.2210.85.camel@domain.hid>
In-Reply-To: <1257331856.2210.85.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------020604040900030203070300"
Subject: Re: [Xenomai-core] [Xenomai-help] How to fix t_delete call in psos
	skin?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020604040900030203070300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Philippe Gerum a écrit :
> On Wed, 2009-11-04 at 10:20 +0100, Alexandre Coffignal wrote:
>   
>> Hello,
>>
>> I'm trying to use t_delete routine in psos skin (xenomai-2.4.7) from a 
>> user space application .
>> I'm encountring two different behaviors:
>> -1- Calling t_delete(0) from a psos task seems to work perfectly (e.g. 
>> task self deletes).
>> -2- Calling t_delete(task_id) with another task id (e.g. current task 
>> tries to delete another task) doesn't result in task deletion but 
>> returns 0 (success).
>>
>> I've been through both psos skin (ksrc/psos+/task.c) and nucleus 
>> (ksrc/nucleus/pod.c) source code.
>>
>> xnpod_delete_thread() behaves differently depending on previously 
>> described t_delete calls:
>>
>> -1- First case (t_delete(0)):
>>
>> Execution skip condition in ksrc/nucleus/pod.c at line 1173:
>>
>>   if (xnthread_user_task(thread) != NULL &&
>>       !xnthread_test_state(thread, XNDORMANT) &&
>>       !xnpod_current_p(thread)) {
>>       if (!xnpod_userspace_p())
>>           xnshadow_send_sig(thread, SIGKILL, 1);
>>       /*
>>        * Otherwise, assume the interface library has issued
>>        * pthread_cancel on the target thread, which should
>>        * cause the current service to be called for
>>        * self-deletion of that thread.
>>        */
>>       goto unlock_and_exit;
>>   }
>> #endif /* CONFIG_XENO_OPT_PERVASIVE */
>>
>> and continues to run after it. This results in a successful deletion.
>>
>>
>> -2- Second case:
>>
>> Execution enters one of the first conditions (if 
>> (xnthread_user_task(thread))...)  but skip the second one : 
>> xnshadow_send_sig(thread, SIGKILL, 1) is not executed;
>> goto unlock_and_exit; instruction is then executed.
>> ->Our thread is never deleted.
>>
>> -3-
>> Modifing actual source code by commenting goto intruction or moving it 
>> into second condition (if (!xnpod_userspace_p()) mentioned above) 
>> results in a working t_delete (task_id).
>>
>> - I'm not sure of the possible side effects of such a modification?
>> - Is it correct to do so?
>>
>>     
>
> Nope, this would defeat the purpose of testing those conditions, and end
> up breaking the nucleus. The implicit logic behind such block is that a
> real-time task should always exit on behalf of its own context, so that
> its Linux side never survives the removal of the mated Xenomai shadow
> TCB. Otherwise, you would get a real-time Xenomai task running without
> any Xenomai TCB.
>
> The fix has to happen in userland, and only there, by implementing what
> the comment suggests, which is still missing from the psos skin. i.e.
> have the t_delete() wrapper issue pthread_cancel() under the hood, in
> src/skins/psos/task.c. The native and POSIX APIs illustrate what is
> needed in this respect, albeit the way they implement this is not 100%
> portable to the psos skin context.
>
> PS: this discussion should rather happen on xenomai-core. Redirecting
> now.
>
>   

Hello,

Thank you for your response.
I tried to adopt the same philosophy as in the native API.
Please find attached a patch that modifies psos skin this way:

in /src/skins/psos+/task.c
A reference on pthread is kept at task creation time (in 
psos_task_trampoline and t_shadow routines) to be retrieved at deletion 
time (in t_delete routine, when tid isn't 0).
When t_delete is called with tid != 0, pthread_cancel() is issued with 
this reference.

include/psos+/task.h
Pthread reference has been added in psostask struct (kernel side) and is 
passed to it by using SKINCALL at creation time.

ksrc/skins/psos+/syscall.c & /include/psos+/syscall.h
Pthread reference is passed to it by using SKINCALL at creation time (in 
__t_create).
An additional skin call (__t_get_pthread) allow to retreive pthread 
reference from user space

Does this fix seem more suitable to you?
Do you see someting else missing?

Please advice.

Fabrice Gasnier


>> As mentioned in the source code comment, it is assumed "the interface 
>> library has issued pthread_cancel" ...
>> I assume it might be missing somewhere?
>>
>> Please can you help on this topic?
>>
>> Thanks in advance.
>>
>> Please find a patch regarding this modification.
>>
>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>> index 9348ce1..ee362df 100644
>> --- a/ksrc/nucleus/pod.c
>> +++ b/ksrc/nucleus/pod.c
>> @@ -1177,14 +1177,16 @@ void xnpod_delete_thread(xnthread_t *thread)
>>             !xnthread_test_state(thread, XNDORMANT) &&
>>             !xnpod_current_p(thread)) {
>>                 if (!xnpod_userspace_p())
>> +               {
>>                         xnshadow_send_sig(thread, SIGKILL, 1);
>> +                       goto unlock_and_exit;
>> +               }
>>                 /*
>>                  * Otherwise, assume the interface library has issued
>>                  * pthread_cancel on the target thread, which should
>>                  * cause the current service to be called for
>>                  * self-deletion of that thread.
>>                  */
>> -               goto unlock_and_exit;
>>         }
>>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
>>  
>>     
>
>   
>> Fabrice.
>>
>>
>> --------------------------------
>> CénoSYS <http://www.cenosys.com>
>> 10, Rue Xavier Bichat
>> F-72000 Le MANS
>> --------------------------------
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>     
>
>
>   



--------------020604040900030203070300
Content-Type: text/plain;
 name="patch_psos_t_delete"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch_psos_t_delete"

SW5kZXg6IHhlbm9tYWktMi40LjdfYnVnbGVzcy9pbmNsdWRlL3Bzb3MrL3N5c2NhbGwuaAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSB4ZW5vbWFpLTIuNC43X2J1Z2xlc3Mub3JpZy9pbmNsdWRlL3Bz
b3MrL3N5c2NhbGwuaAkyMDA5LTExLTA1IDA5OjEyOjI5LjAwMDAwMDAwMCArMDEwMAorKysg
eGVub21haS0yLjQuN19idWdsZXNzL2luY2x1ZGUvcHNvcysvc3lzY2FsbC5oCTIwMDktMTEt
MDUgMDk6MTM6MTQuMDAwMDAwMDAwICswMTAwCkBAIC03Myw2ICs3Myw3IEBACiAjZGVmaW5l
IF9fcHNvc19hc19zZW5kICAgICAgNDUKIC8qIFhlbm9tYWkgZXh0ZW5zaW9uOiBnZXQgcmF3
IGNvdW50IG9mIGppZmZpZXMgKi8KICNkZWZpbmUgX19wc29zX3RtX2dldGMgICAgICA0Ngor
I2RlZmluZSBfX3Bzb3NfdF9nZXRfcHRocmVhZAkJNDcJLyogZ2V0IGhpZGRlbiBwdGhyZWFk
X3QgaWRlbnRpZmllci4gKi8KIAogI2lmZGVmIF9fS0VSTkVMX18KIApJbmRleDogeGVub21h
aS0yLjQuN19idWdsZXNzL2tzcmMvc2tpbnMvcHNvcysvc3lzY2FsbC5jCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHhlbm9tYWktMi40LjdfYnVnbGVzcy5vcmlnL2tzcmMvc2tpbnMvcHNvcysvc3lz
Y2FsbC5jCTIwMDktMTEtMDUgMDk6MTY6NDguMDAwMDAwMDAwICswMTAwCisrKyB4ZW5vbWFp
LTIuNC43X2J1Z2xlc3Mva3NyYy9za2lucy9wc29zKy9zeXNjYWxsLmMJMjAwOS0xMS0wNSAw
OToxNjo1Ny4wMDAwMDAwMDAgKzAxMDAKQEAgLTY3LDI5ICs2NywzNyBAQAogCXhuY29tcGxl
dGlvbl90IF9fdXNlciAqdV9jb21wbGV0aW9uOwogCXVfbG9uZyBwcmlvLCBmbGFncywgdGlk
LCBlcnI7CiAJY2hhciBuYW1lW1hOT0JKRUNUX05BTUVfTEVOXTsKKwlzdHJ1Y3QgYXJnX2J1
bGs1IGJ1bGs7CiAJcHNvc3Rhc2tfdCAqdGFzazsKIAotCWlmICghX194bl9hY2Nlc3Nfb2so
Y3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzEocmVncyksIDQpKQorCWlmICghX194
bl9hY2Nlc3Nfb2soY3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzEocmVncyksIHNp
emVvZihidWxrKSkpCisJCXJldHVybiAtRUZBVUxUOworCisJX194bl9jb3B5X2Zyb21fdXNl
cihjdXJyLCAmYnVsaywgKHZvaWQgX191c2VyICopX194bl9yZWdfYXJnMShyZWdzKSwKKwkJ
CSAgICBzaXplb2YoYnVsaykpOworCisJaWYgKCFfX3huX2FjY2Vzc19vayhjdXJyLCBWRVJJ
RllfUkVBRCwgYnVsay5hMSwgc2l6ZW9mKG5hbWUpKSkgewogCQlyZXR1cm4gLUVGQVVMVDsK
Kwl9CiAKIAkvKiBHZXQgdGFzayBuYW1lLiAqLwotCV9feG5fc3RybmNweV9mcm9tX3VzZXIo
Y3VyciwgbmFtZSwgKGNvbnN0IGNoYXIgX191c2VyICopX194bl9yZWdfYXJnMShyZWdzKSwK
KwlfX3huX3N0cm5jcHlfZnJvbV91c2VyKGN1cnIsIG5hbWUsIChjb25zdCBjaGFyIF9fdXNl
ciAqKWJ1bGsuYTEsCiAJCQkgICAgICAgc2l6ZW9mKG5hbWUpIC0gMSk7CiAJbmFtZVtzaXpl
b2YobmFtZSkgLSAxXSA9ICdcMCc7CiAJc3RybmNweShjdXJyLT5jb21tLCBuYW1lLCBzaXpl
b2YoY3Vyci0+Y29tbSkpOwogCWN1cnItPmNvbW1bc2l6ZW9mKGN1cnItPmNvbW0pIC0gMV0g
PSAnXDAnOwogCiAJaWYgKCFfX3huX2FjY2Vzc19vawotCSAgICAoY3VyciwgVkVSSUZZX1dS
SVRFLCBfX3huX3JlZ19hcmc0KHJlZ3MpLCBzaXplb2YodGlkKSkpCisJCShjdXJyLCBWRVJJ
RllfV1JJVEUsIGJ1bGsuYTQsIHNpemVvZih0aWQpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAK
IAkvKiBUYXNrIHByaW9yaXR5LiAqLwotCXByaW8gPSBfX3huX3JlZ19hcmcyKHJlZ3MpOwor
CXByaW8gPSBidWxrLmEyOwogCS8qIFRhc2sgZmxhZ3MuIEZvcmNlIEZQVSBzdXBwb3J0IGlu
IHVzZXItc3BhY2UuIFRoaXMgd2lsbCBsZWFkCiAJICAgdG8gYSBuby1vcCBpZiB0aGUgcGxh
dGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBpdC4gKi8KLQlmbGFncyA9IF9feG5fcmVnX2FyZzMo
cmVncykgfCBUX1NIQURPVyB8IFRfRlBVOworCWZsYWdzID0gYnVsay5hMyB8IFRfU0hBRE9X
IHwgVF9GUFU7CiAJLyogQ29tcGxldGlvbiBkZXNjcmlwdG9yIG91ciBwYXJlbnQgdGhyZWFk
IGlzIHBlbmRpbmcgb24uICovCi0JdV9jb21wbGV0aW9uID0gKHhuY29tcGxldGlvbl90IF9f
dXNlciAqKV9feG5fcmVnX2FyZzUocmVncyk7CisJdV9jb21wbGV0aW9uID0gKHhuY29tcGxl
dGlvbl90IF9fdXNlciAqKV9feG5fcmVnX2FyZzIocmVncyk7CiAKIAllcnIgPSB0X2NyZWF0
ZShuYW1lLCBwcmlvLCAwLCAwLCBmbGFncywgJnRpZCk7CiAKQEAgLTk5LDcgKzEwNyw4IEBA
CiAJCSAqIGFib3V0IHRoZSBuZXcgdGhyZWFkIGlkLCBzbyB3ZSBjYW4gbWFuaXB1bGF0ZSBp
dHMKIAkJICogVENCIHBvaW50ZXIgZnJlZWx5LiAqLwogCQl0aWQgPSB4bnRocmVhZF9oYW5k
bGUoJnRhc2stPnRocmVhZGJhc2UpOwotCQlfX3huX2NvcHlfdG9fdXNlcihjdXJyLCAodm9p
ZCBfX3VzZXIgKilfX3huX3JlZ19hcmc0KHJlZ3MpLCAmdGlkLAorCQl0YXNrLT5vcGFxdWUy
ID0gYnVsay5hNTsgLyogaGlkZGVuIHB0aHJlYWRfdCBpZGVudGlmaWVyLiAqLworCQlfX3hu
X2NvcHlfdG9fdXNlcihjdXJyLCAodm9pZCBfX3VzZXIgKikgYnVsay5hNCwgJnRpZCwKIAkJ
CQkgIHNpemVvZih0aWQpKTsKIAkJZXJyID0geG5zaGFkb3dfbWFwKCZ0YXNrLT50aHJlYWRi
YXNlLCB1X2NvbXBsZXRpb24pOyAvKiBNYXkgYmUgTlVMTCAqLwogCX0gZWxzZSB7CkBAIC0x
NDQzLDYgKzE0NTIsMzYgQEAKIAlyZXR1cm4gYXNfc2VuZCgodV9sb25nKXRhc2ssIHNpZ25h
bHMpOwogfQogCisKKy8qCisgKiBpbnQgX190X2dldF9wdGhyZWFkKHVfbG9uZyB0aWQsIHVf
bG9uZyAqcHRocmVhZCkKKyAqLworc3RhdGljIGludCBfX3RfZ2V0X3B0aHJlYWQoc3RydWN0
IHRhc2tfc3RydWN0ICpjdXJyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sKKwl4bmhhbmRs
ZV90IGhhbmRsZTsKKwlwc29zdGFza190ICp0YXNrOworCXVfbG9uZyBwdGhyZWFkOworCisJ
aGFuZGxlID0gX194bl9yZWdfYXJnMShyZWdzKTsKKworCWlmICghX194bl9hY2Nlc3Nfb2so
Y3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzIocmVncyksIHNpemVvZih1X2xvbmcp
KSkKKwkJcmV0dXJuIC1FRkFVTFQ7CisKKwlpZiAoaGFuZGxlKQorCQl0YXNrID0gKHBzb3N0
YXNrX3QgKil4bnJlZ2lzdHJ5X2ZldGNoKGhhbmRsZSk7CisJZWxzZQorCQl0YXNrID0gX19w
c29zX3Rhc2tfY3VycmVudChjdXJyKTsKKworCWlmICghdGFzaykKKwkJcmV0dXJuIEVSUl9P
QkpJRDsKKworCXB0aHJlYWQgPSB0YXNrLT5vcGFxdWUyOyAvKiBoaWRkZW4gcHRocmVhZF90
IGlkZW50aWZpZXIuICovCisKKwlfX3huX2NvcHlfdG9fdXNlcihjdXJyLCAodm9pZCBfX3Vz
ZXIgKikgX194bl9yZWdfYXJnMihyZWdzKSwgJnB0aHJlYWQsIHNpemVvZih1X2xvbmcpKTsK
KworCXJldHVybiBTVUNDRVNTOworfQorCiBzdGF0aWMgdm9pZCAqcHNvc19zaGFkb3dfZXZl
bnRjYihpbnQgZXZlbnQsIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IHBzb3NfcmVzb3VyY2Vf
aG9sZGVyICpyaDsKQEAgLTE1MjQsNiArMTU2Myw3IEBACiAJW19fcHNvc190bV9zaWduYWxd
ID0geyZfX3RtX3NpZ25hbCwgX194bl9leGVjX3ByaW1hcnl9LAogCVtfX3Bzb3NfYXNfc2Vu
ZF0gPSB7Jl9fYXNfc2VuZCwgX194bl9leGVjX2NvbmZvcm1pbmd9LAogCVtfX3Bzb3NfdG1f
Z2V0Y10gPSB7Jl9fdG1fZ2V0YywgX194bl9leGVjX2FueX0sCisJW19fcHNvc190X2dldF9w
dGhyZWFkXSA9IHsmX190X2dldF9wdGhyZWFkLCBfX3huX2V4ZWNfYW55fSwKIH07CiAKIGV4
dGVybiB4bnRiYXNlX3QgKnBzb3NfdGJhc2U7CkluZGV4OiB4ZW5vbWFpLTIuNC43X2J1Z2xl
c3Mvc3JjL3NraW5zL3Bzb3MrL3Rhc2suYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSB4ZW5vbWFpLTIu
NC43X2J1Z2xlc3Mub3JpZy9zcmMvc2tpbnMvcHNvcysvdGFzay5jCTIwMDktMTEtMDUgMDk6
MTc6MzEuMDAwMDAwMDAwICswMTAwCisrKyB4ZW5vbWFpLTIuNC43X2J1Z2xlc3Mvc3JjL3Nr
aW5zL3Bzb3MrL3Rhc2suYwkyMDA5LTExLTA1IDA5OjE3OjU2LjAwMDAwMDAwMCArMDEwMApA
QCAtMjYsNiArMjYsMTUgQEAKICNpbmNsdWRlIDxtZW1vcnkuaD4KICNpbmNsdWRlIDxwc29z
Ky9wc29zLmg+CiAKK3N0cnVjdCBhcmdfYnVsazV7CisKKyAgICB1X2xvbmcgYTE7CisgICAg
dV9sb25nIGEyOworICAgIHVfbG9uZyBhMzsKKyAgICB1X2xvbmcgYTQ7CisgICAgdV9sb25n
IGE1OworfTsKKwogZXh0ZXJuIGludCBfX3Bzb3NfbXV4aWQ7CiAKIHN0cnVjdCBwc29zX3Rh
c2tfaWFyZ3MgewpAQCAtNzMsNiArODIsNyBAQAogCXN0cnVjdCBzY2hlZF9wYXJhbSBwYXJh
bTsKIAlpbnQgcG9saWN5OwogCWxvbmcgZXJyOworCXN0cnVjdCBhcmdfYnVsazUgYnVsazsK
IAogCXBvbGljeSA9IHBzb3NfdGFza19zZXRfcG9zaXhfcHJpb3JpdHkoaWFyZ3MtPnByaW8s
ICZwYXJhbSk7CiAJcHRocmVhZF9zZXRzY2hlZHBhcmFtKHB0aHJlYWRfc2VsZigpLCBwb2xp
Y3ksICZwYXJhbSk7CkBAIC04MSwxMCArOTEsMTQgQEAKIAogCW9sZF9zaWdoYXJkZW5faGFu
ZGxlciA9IHNpZ25hbChTSUdIQVJERU4sICZwc29zX3Rhc2tfc2lnaGFyZGVuKTsKIAotCWVy
ciA9IFhFTk9NQUlfU0tJTkNBTEw1KF9fcHNvc19tdXhpZCwKLQkJCQlfX3Bzb3NfdF9jcmVh
dGUsCi0JCQkJaWFyZ3MtPm5hbWUsIGlhcmdzLT5wcmlvLCBpYXJncy0+ZmxhZ3MsCi0JCQkJ
aWFyZ3MtPnRpZF9yLCBpYXJncy0+Y29tcGxldGlvbnApOworCWJ1bGsuYTEgPSAodV9sb25n
KWlhcmdzLT5uYW1lOworCWJ1bGsuYTIgPSAodV9sb25nKWlhcmdzLT5wcmlvOworCWJ1bGsu
YTMgPSAodV9sb25nKWlhcmdzLT5mbGFnczsKKwlidWxrLmE0ID0gKHVfbG9uZylpYXJncy0+
dGlkX3I7CisJYnVsay5hNSA9ICh1X2xvbmcpcHRocmVhZF9zZWxmKCk7CisKKwllcnIgPSBY
RU5PTUFJX1NLSU5DQUxMMihfX3Bzb3NfbXV4aWQsIF9fcHNvc190X2NyZWF0ZSwgJmJ1bGss
IGlhcmdzLT5jb21wbGV0aW9ucCk7CisKIAlpZiAoZXJyKQogCQlnb3RvIGZhaWw7CiAKQEAg
LTE3MiwxNCArMTg2LDE5IEBACiAJCXVfbG9uZyBmbGFncywKIAkJdV9sb25nICp0aWRfcikK
IHsKKwlzdHJ1Y3QgYXJnX2J1bGs1IGJ1bGs7CisKIAlwdGhyZWFkX3NldGNhbmNlbHR5cGUo
UFRIUkVBRF9DQU5DRUxfQVNZTkNIUk9OT1VTLCBOVUxMKTsKIAogCW9sZF9zaWdoYXJkZW5f
aGFuZGxlciA9IHNpZ25hbChTSUdIQVJERU4sICZwc29zX3Rhc2tfc2lnaGFyZGVuKTsKIAot
CXJldHVybiBYRU5PTUFJX1NLSU5DQUxMNShfX3Bzb3NfbXV4aWQsCi0JCQkJIF9fcHNvc190
X2NyZWF0ZSwKLQkJCQkgbmFtZSwgcHJpbywgZmxhZ3MsCi0JCQkJIHRpZF9yLCBOVUxMKTsK
KwlidWxrLmExID0gKHVfbG9uZyluYW1lOworCWJ1bGsuYTIgPSAodV9sb25nKXByaW87CisJ
YnVsay5hMyA9ICh1X2xvbmcpZmxhZ3M7CisJYnVsay5hNCA9ICh1X2xvbmcpdGlkX3I7CisJ
YnVsay5hNSA9ICh1X2xvbmcpcHRocmVhZF9zZWxmKCk7CisKKwlyZXR1cm4gWEVOT01BSV9T
S0lOQ0FMTDIoX19wc29zX211eGlkLCBfX3Bzb3NfdF9jcmVhdGUsICZidWxrLCBOVUxMKTsK
IH0KIAogdV9sb25nIHRfc3RhcnQodV9sb25nIHRpZCwKQEAgLTE5Niw2ICsyMTUsMTggQEAK
IAogdV9sb25nIHRfZGVsZXRlKHVfbG9uZyB0aWQpCiB7CisJbG9uZyBlcnI7CisJdV9sb25n
IHB0aHJlYWQ7CisKKwlpZih0aWQpCisJeworCQllcnIgPSBYRU5PTUFJX1NLSU5DQUxMMihf
X3Bzb3NfbXV4aWQsIF9fcHNvc190X2dldF9wdGhyZWFkLCB0aWQsICZwdGhyZWFkKTsKKwkJ
aWYgKGVycikKKwkJCXJldHVybiBlcnI7CisJCWVyciA9IHB0aHJlYWRfY2FuY2VsKChwdGhy
ZWFkX3QpcHRocmVhZCk7CisJCWlmIChlcnIpCisJCQlyZXR1cm4gZXJyOworCX0KIAlyZXR1
cm4gWEVOT01BSV9TS0lOQ0FMTDEoX19wc29zX211eGlkLCBfX3Bzb3NfdF9kZWxldGUsIHRp
ZCk7CiB9CiAKSW5kZXg6IHhlbm9tYWktMi40LjdfYnVnbGVzcy9pbmNsdWRlL3Bzb3MrL3Rh
c2suaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSB4ZW5vbWFpLTIuNC43X2J1Z2xlc3Mub3JpZy9pbmNs
dWRlL3Bzb3MrL3Rhc2suaAkyMDA5LTExLTA1IDA5OjE5OjQ5LjAwMDAwMDAwMCArMDEwMAor
KysgeGVub21haS0yLjQuN19idWdsZXNzL2luY2x1ZGUvcHNvcysvdGFzay5oCTIwMDktMTEt
MDUgMDk6MTk6NTguMDAwMDAwMDAwICswMTAwCkBAIC0yNiw2ICsyNiwxNiBAQAogCiAjZGVm
aW5lIFBTT1NfVEFTS19NQUdJQyAweDgxODEwMTAxCiAKK3N0cnVjdCBhcmdfYnVsazV7CisK
KyAgICB1X2xvbmcgYTE7CisgICAgdV9sb25nIGEyOworICAgIHVfbG9uZyBhMzsKKyAgICB1
X2xvbmcgYTQ7CisgICAgdV9sb25nIGE1OworfTsKKworCiB0eXBlZGVmIHN0cnVjdCBwc29z
dGFzayB7CiAKICAgICB1bnNpZ25lZCBtYWdpYzsgICAvKiBNYWdpYyBjb2RlIC0gbXVzdCBi
ZSBmaXJzdCAqLwpAQCAtNjQsNiArNzQsOCBAQAogCiAgICAgfSB3YWl0YXJnczsKIAorICAg
IHVfbG9uZyBvcGFxdWUyOyAvKiBoaWRkZW4gcHRocmVhZF90IGlkZW50aWZpZXIuICovCisK
IH0gcHNvc3Rhc2tfdDsKIAogc3RhdGljIGlubGluZSBwc29zdGFza190ICp0aHJlYWQycHNv
c3Rhc2sgKHhudGhyZWFkX3QgKnQpCg==
--------------020604040900030203070300--


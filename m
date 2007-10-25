Message-ID: <4720CF7F.7000201@domain.hid>
Date: Thu, 25 Oct 2007 13:16:47 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4720A719.7090100@domain.hid> <4720AB1B.4060300@domain.hid>
	<4720AC27.9040705@domain.hid> <4720AFF2.9090309@domain.hid>
In-Reply-To: <4720AFF2.9090309@domain.hid>
Content-Type: multipart/mixed; boundary="------------020304020402090602030101"
Subject: Re: [Xenomai-core] kernel BUG running cyclictest on powerpc 405
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020304020402090602030101
Content-Type: multipart/alternative;
 boundary="------------090704010101090608080503"


--------------090704010101090608080503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I upgraded to the new ipipe patch and your uic fix.  Attached is a new 
patch I needed - without it, I get the error message:

.../include/linux/ipipe.h:298: warning: 'struct mm_struct' declared 
inside parameter list
.../include/linux/ipipe.h:298: warning: its scope is only this 
definition or declaration, which is probably not what you want

Also, there is a problem with the uic fix.  It now gives this 
compile-time error:

  CC      arch/powerpc/sysdev/uic.o
.../arch/powerpc/sysdev/uic.c: In function 'uic_init_one':
.../arch/powerpc/sysdev/uic.c:234: error: incompatible types in assignment

I believe this is caused by the definition in spinlock.h:

# define spin_lock_init(lock)                    \
    do { *(lock) = SPIN_LOCK_UNLOCKED; } while (0)

The SPIN_LOCK_UNLOCKED should perhaps be IPIPE_SPIN_LOCK_UNLOCKED, but I 
don't know if this is the right way to fix it.

    Steve

Philippe Gerum wrote:
> Steven A. Falco wrote:
>   
>> Thanks!  I'll try your patch and report if I still have trouble.
>>
>> I've attached my patch for PPC405.
>>
>>     
>
> Thanks. You may also want to upgrade to this I-pipe patch; it should
> apply properly against -rc7:
>
> http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-02.patch
>
> You would still need the quick fix for the UIC on top of that one, though.
>
>   
>>     Steve
>>
>> Philippe Gerum wrote:
>>     
>>> Steven A. Falco wrote:
>>>   
>>>       
>>>> I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3. 
>>>> Architecture is powerpc, processor is a 405GP.
>>>>
>>>> I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
>>>> can submit a patch if someone tells me where to post it.
>>>>
>>>>     
>>>>         
>>> Here would be nice, or to the Adeos list, indifferently - I would pick
>>> it from both anyway.
>>>
>>>   
>>>       
>>>> However, while the kernel boots and runs, the xenomai user apps do not
>>>> work correctly.  Specifically, when running cyclictest, I get the following:
>>>>
>>>>     
>>>>         
>>> This patch should fix this issue.
>>>
>>> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
>>> index eeb38e2..5a38086 100644
>>> --- a/arch/powerpc/sysdev/uic.c
>>> +++ b/arch/powerpc/sysdev/uic.c
>>> @@ -48,7 +48,7 @@ struct uic {
>>>  	int index;
>>>  	int dcrbase;
>>>
>>> -	spinlock_t lock;
>>> +	ipipe_spinlock_t lock;
>>>
>>>  	/* The remapper for this UIC */
>>>  	struct irq_host	*irqhost;
>>>   
>>>       
>>>> How do I debug this?  I have done a little kernel hacking, but I am a
>>>> noob when it comes to Xenomai...
>>>>
>>>>     
>>>>         
>>> Well, actually, it's shame on me. I did not notice that the universal
>>> interrupt controller code was missing some bits in post-2.6.21 I-pipe
>>> patches.
>>>
>>>   
>>>       
>
>
>   

--------------090704010101090608080503
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>I upgraded to the new ipipe patch and your uic fix.  Attached is a
new patch I needed - without it, I get the error message:<br>
<br>
.../include/linux/ipipe.h:298: warning: 'struct mm_struct' declared
inside parameter list<br>
.../include/linux/ipipe.h:298: warning: its scope is only this
definition or declaration, which is probably not what you want<br>
<br>
Also, there is a problem with the uic fix.  It now gives this
compile-time error:<br>
<br>
  CC      arch/powerpc/sysdev/uic.o<br>
.../arch/powerpc/sysdev/uic.c: In function 'uic_init_one':<br>
.../arch/powerpc/sysdev/uic.c:234: error: incompatible types in
assignment<br>
<br>
I believe this is caused by the definition in spinlock.h:<br>
<br>
# define spin_lock_init(lock)                    \<br>
    do { *(lock) = SPIN_LOCK_UNLOCKED; } while (0)<br>
<br>
The </tt><tt>SPIN_LOCK_UNLOCKED should perhaps be
IPIPE_SPIN_LOCK_UNLOCKED, but I don't know if this is the right way to
fix it.<br>
<br>
    Steve<br>
</tt><br>
Philippe Gerum wrote:
<blockquote cite="mid:4720AFF2.9090309@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks!  I'll try your patch and report if I still have trouble.

I've attached my patch for PPC405.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Thanks. You may also want to upgrade to this I-pipe patch; it should
apply properly against -rc7:

<a class="moz-txt-link-freetext" href="http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-02.patch">http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-02.patch</a>

You would still need the quick fix for the UIC on top of that one, though.

  </pre>
  <blockquote type="cite">
    <pre wrap="">    Steve

Philippe Gerum wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Steven A. Falco wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3. 
Architecture is powerpc, processor is a 405GP.

I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
can submit a patch if someone tells me where to post it.

    
        </pre>
      </blockquote>
      <pre wrap="">Here would be nice, or to the Adeos list, indifferently - I would pick
it from both anyway.

  
      </pre>
      <blockquote type="cite">
        <pre wrap="">However, while the kernel boots and runs, the xenomai user apps do not
work correctly.  Specifically, when running cyclictest, I get the following:

    
        </pre>
      </blockquote>
      <pre wrap="">This patch should fix this issue.

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index eeb38e2..5a38086 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -48,7 +48,7 @@ struct uic {
 	int index;
 	int dcrbase;

-	spinlock_t lock;
+	ipipe_spinlock_t lock;

 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">How do I debug this?  I have done a little kernel hacking, but I am a
noob when it comes to Xenomai...

    
        </pre>
      </blockquote>
      <pre wrap="">Well, actually, it's shame on me. I did not notice that the universal
interrupt controller code was missing some bits in post-2.6.21 I-pipe
patches.

  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------090704010101090608080503--

--------------020304020402090602030101
Content-Type: text/plain;
 name="fix.mm_struct"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fix.mm_struct"

LS0tIC9ob21lL3NmYWxjby9pcGlwZS5oCTIwMDctMTAtMjUgMTI6NTk6MTIuMDAwMDAwMDAw
IC0wNDAwCisrKyBpbmNsdWRlL2xpbnV4L2lwaXBlLmgJMjAwNy0xMC0yNSAxMjo1OToyMy4w
MDAwMDAwMDAgLTA0MDAKQEAgLTMxLDYgKzMxLDggQEAKICNpbmNsdWRlIDxsaW51eC9pcGlw
ZV9jb21wYXQuaD4KICNpbmNsdWRlIDxhc20vaXBpcGUuaD4KIAorc3RydWN0IG1tX3N0cnVj
dDsKKwogI2lmZGVmIENPTkZJR19JUElQRQogCiAjZGVmaW5lIElQSVBFX1ZFUlNJT05fU1RS
SU5HCUlQSVBFX0FSQ0hfU1RSSU5HCg==
--------------020304020402090602030101--


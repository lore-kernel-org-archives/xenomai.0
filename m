References: <1461854390-27536-1-git-send-email-tbultel@free.fr>
 <20160429194018.GO1881@hermes.click-hack.org> <5723C928.3020400@free.fr>
 <20160429211504.GA1781@hermes.click-hack.org>
From: Thierry Bultel <tbultel@free.fr>
Message-ID: <57247DCD.1080008@free.fr>
Date: Sat, 30 Apr 2016 11:41:33 +0200
MIME-Version: 1.0
In-Reply-To: <20160429211504.GA1781@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH 1/1] posix skin: fix address passed to
 pse51_mutex_check_init in syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 29/04/2016 23:15, Gilles Chanteperdrix a =E9crit :
> On Fri, Apr 29, 2016 at 10:50:48PM +0200, Thierry Bultel wrote:
>> Le 29/04/2016 21:40, Gilles Chanteperdrix a =E9crit :
>>> On Thu, Apr 28, 2016 at 04:39:50PM +0200, Thierry Bultel wrote:
>>>> The address passed to pse51_mutex_check_init was the one of userland,
>>>> not the kernel one.
>>>>
>>>> Signed-off-by: Thierry Bultel <tbultel@free.fr>
>>>> ---
>>>>    ksrc/skins/posix/syscall.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
>>>> index 87b95fa..31e2705 100644
>>>> --- a/ksrc/skins/posix/syscall.c
>>>> +++ b/ksrc/skins/posix/syscall.c
>>>> @@ -1202,7 +1202,7 @@ static int __pthread_mutex_check_init(struct pt_=
regs *regs)
>>>>    	} else
>>>>    		attr =3D NULL;
>>>>   =20
>>>> -	return pse51_mutex_check_init(&umx->shadow_mutex, attr);
>>>> +	return pse51_mutex_check_init(&mx.shadow_mutex, attr);
>>>>    }
>>> Ah, what a coincidence, Jan reported this issue a long time ago:
>>> https://xenomai.org/pipermail/xenomai/2015-December/035656.html
>>> and I have merged a patch for it just a few days ago in my local
>>> branch (soon to be Xenomai 2.6.5).
>>>
>> As you probably read in my previous emails, I am currently achieving
>> to port ipipe to 4.5.
>> Whereas the existing version does not seem to make any problems
>> with kernel 3.18.12, it does a kernel crash with 4.5.
>> I did not investigate why this makes a difference.
>> With the patch, the 'leaks' non regression test successfully passes.
> Fine, but how is that relevant? The patch is already merged, and Jan
> probably explained the reason for the crash.
>
Yes, absolutely.
I was just wondering why this used to work with older kernels
and why it does not any longer with newer ones.


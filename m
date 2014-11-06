From: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Date: Thu, 6 Nov 2014 15:52:45 +0000
Message-ID: <545B994D.1080008@cgglobal.com>
References: <545B9297.2090003@cgglobal.com> 
 <20141106153738.GC30908@sisyphus.hd.free.fr>
In-Reply-To: <20141106153738.GC30908@sisyphus.hd.free.fr>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2EF135C282AE3E48A5B58E2748321B51@cgglobal.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
Reply-To: alberto.ozalla@cgglobal.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

Sorry about missing references to function cu_log().
You can omit cu_log calls (It is like printf).
There are in place to see where the log traces are taken.

Regards
Alberto
On 06/11/14 16:37, Gilles Chanteperdrix wrote:
> On Thu, Nov 06, 2014 at 03:24:08PM +0000, ZIV-Alberto Ozalla Cantabrana w=
rote:
>> Hi all,
>>
>> enclosed you will find two examples:
>>
>>    *   rt_task_sleep_until() missing release point, and
>>    *   rt_task_sleep_until() working fine.
>>
>> In the first example:
>>
>> Current time: t1=3D4205571 ms - Calculated next release point: t2=3D 420=
5572 ms
>> Real release: t3=3D4205574 ms
>>
>> Many Thanks
>> Alberto Ozalla
>>
>> Simplest example that shows the issue:
> When you post an example, please post a "self contained" one, i.e.
> one that can be compiled and run without:
> - any missing code or ellipses
> - references to functions not contained in the code or xenomai
> librairies, such as cu_log.
>
>> #1 SMP 20<6>kernel: [    0.000000] CPU: ARMv7 Processor [413fc082] revis=
ion 2 (ARMv7), cr=3D10c5387d
> You do not need CONFIG_SMP on an uniprocessor, this adds some
> overhead. The overhead is mitigated on Xenomai 3, but not on xenomai
> 2.x.
>

--=20
Saludos,
Alberto Ozalla


CG DISCLAIMER: This email contains confidential information. It is intended=
 exclusively for the addressees. If you are not an addressee, you must not =
store, transmit or disclose its contents. Instead please notify the sender =
immediately; and permanently delete this e-mail from your computer systems.=
 We have taken reasonable precautions to ensure that no viruses are present=
. However, you must check this email and the attachments, for viruses. We a=
ccept no liability whatsoever, for any detriment caused by any transmitted =
virus.


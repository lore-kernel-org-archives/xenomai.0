Message-ID: <54577374.9010609@bmwedler.de>
Date: Mon, 03 Nov 2014 13:22:12 +0100
From: Registrierungen <regist@bmwedler.de>
MIME-Version: 1.0
References: <54509406.4000600@bmwedler.de> <54509629.8080107@bmwedler.de>
In-Reply-To: <54509629.8080107@bmwedler.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry for the late feedback.

I found the source where it goes wrong:

     if (poolsize > 0) {
         ret = __RT(setsockopt(sock, SOL_XDDP, XDDP_POOLSZ,
                       &poolsize, sizeof(poolsize)));
         if (ret)
             goto fail_sockopt;
     }

Hope there could be found a solution for me.




Am 29.10.2014 08:24, schrieb Registrierungen:
>
>
> Sure. i compiled xenomai as your suggestion.
> Ive got a a little problem with my eclipse debug enviroment.
> It still does not debug into the xenomai files at moment. so i will fix
> it first and come back with new informations.
>
>
> Am 29.10.2014 08:04, schrieb Philippe Gerum:
>> On 10/29/2014 07:56 AM, Registrierungen wrote:
>>> Addendum:
>>> I am using a x64 Kernel.
>>> Does it matter?
>> No, it does not. Do you plan to debug with gdb as I suggested?
>>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai



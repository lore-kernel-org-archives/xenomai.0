Message-ID: <55072D34.1070405@xenomai.org>
Date: Mon, 16 Mar 2015 20:21:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F5E958.2090701@xenomai.org>	<54F5EA06.4040104@xenomai.org>	<CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>	<54F60A62.3020708@xenomai.org>	<54F60C16.5070500@xenomai.org>	<CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>	<54F614EF.7040307@xenomai.org>	<CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>	<54F6C50F.5040301@xenomai.org>	<CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>	<54F6EF2E.1090705@xenomai.org>	<CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>	<54F716CC.1010600@xenomai.org>	<CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>	<54F73E7A.2070100@xenomai.org>	<CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>	<5505B14F.4060107@xenomai.org>
 <CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>
In-Reply-To: <CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/16/2015 07:58 PM, Helder Daniel wrote:
> Hi Philippe,
> 
> I tried on Mercury and Cobalt and now it binds fine.
> Thank you.
> 
> However sometimes after interrupting a task it is needed to restart
> registry again:
> 
> pkill sysregd
> fusermount -u /var/run/xenomai/anon/system
> /usr/xenomai/sbin/sysregd --linger --daemonize
> 
> 

That should not be the case. What is the issue requiring to restart
sysregd manually?

-- 
Philippe.


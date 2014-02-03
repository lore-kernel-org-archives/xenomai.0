Message-ID: <52EF7C99.6020203@xenomai.org>
Date: Mon, 03 Feb 2014 12:25:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
 <52EBE4B7.6060800@xenomai.org>
 <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
 <52EC054C.9070707@xenomai.org>
 <CAN1+YZX=cnRDcadrUHMzLaNBjNPnNbVuBnBHfEK-mTFYmx+3fA@mail.gmail.com>
 <52EC1079.2040300@xenomai.org>
 <CAN1+YZVq7cwFnUX=bkJs8MbAkpio3azSvev2fmZwqQpgjTnvfg@mail.gmail.com>
 <52ECF912.10308@xenomai.org> <52ECFB5F.4070907@xenomai.org>
 <CAN1+YZUOYLPwB45um_FpkQejr5prR936KnmzKkHEnHJzcae7rQ@mail.gmail.com>
 <52EEBFD7.8070901@xenomai.org> <52EECA63.6070609@xenomai.org>
 <CAN1+YZXQVX0awpJbGeGP-2eXEZcethOj_G+7SPRLhwqCmNPBuQ@mail.gmail.com>
In-Reply-To: <CAN1+YZXQVX0awpJbGeGP-2eXEZcethOj_G+7SPRLhwqCmNPBuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 02/03/2014 01:25 AM, Andy Pugh wrote:
>>>>>> Could you try and apply the following patch?
> 
> 
> Not necessarily due to the patch, but first reboot was:
> 
> (...)
>
> Now, where did I leave that bootable kernel?
> 

The issue you have seems clearly related to the cache initialization,
it happens a little after the cache initialization. So, the patch is
probably the culprit.

-- 
                                                                Gilles.


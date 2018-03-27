References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
 <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
 <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
 <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
 <49cd0e96-fde0-4d7a-17bc-5ae18d10baac@xenomai.org>
 <CAOuPNLgpwc4+nk=5V_3E0k6V_oYVs1q_gfLpwiN_8jfbsYNq9g@mail.gmail.com>
 <1dd59300-7763-e9f3-cda8-2f2548e9e96c@xenomai.org>
 <CAOuPNLiwFdBO1A34A8CU6iVTPQ0VRBq6g7NR=Z3hDvke0+nbdQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <823c2008-4b4b-9b0a-a84c-ee60b4304506@xenomai.org>
Date: Tue, 27 Mar 2018 15:05:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiwFdBO1A34A8CU6iVTPQ0VRBq6g7NR=Z3hDvke0+nbdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/27/2018 02:09 PM, Pintu Kumar wrote:
> Hi,
> 
> Thank you so much for all your explanation.
> But, before I dig deeper, I have some simple questions which is troubling me.
> 
> 1) In Idle case, we see latency improvement (~2-3 micro-seconds on
> average) using Xenomai native task application, compared to normal
> posix thread application (with 100 us sleep).
>     Then why not it is seen with RTDM driver and its application ?
> 
> 2) In the idle case itself, we have seen read/write latency
> improvement using RTNET (loopback) and simple UDP client/server
> application using Xenomai posix skin
>     Then why not same is visible with RTDM driver?
>

All answers have already been given, or can be inferred fairly easy from
what was said earlier.

On a general note, it is safer not to compare apples and oranges when it
comes to benchmarking: two different codes usually do things
differently, so you may simply not be measuring the same work load. If
you really want to figure out what happens, you may need to dive into
the implementation.

> 3) How to choose, when to develop a Xenomai native application, and
> when to simply convert using posix skin ?
> 

Choose portability with POSIX. The so-called "native" - now Alchemy API
- was defined 14 years ago for a single purpose: make greybards coming
from the traditional RTOS world comfortable with API semantics close to
what they were used to with VxWorks, VRTX, pSOS and friends.

Alchemy exists in Xenomai 3 only for the purpose of making the life of
people migrating from 2.x easier.

-- 
Philippe.


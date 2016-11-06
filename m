References: <CA+X=5XiGUYkKiAiffg-A82ywtSJjpcbJS2C1fV4aOiHQw2i5Gw@mail.gmail.com>
 <5be8ae5e-24de-b98c-6b5a-b95cc50725a9@xenomai.org>
 <CA+X=5Xgr8B6pqpxfJBOEp15pnAxtG7EC6zsE7g0iRMdyJvUmcg@mail.gmail.com>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <d6b12bef-a2b6-0b64-be8d-9f4e7dad93ba@xenomai.org>
Date: Sun, 6 Nov 2016 20:37:54 +0100
MIME-Version: 1.0
In-Reply-To: <CA+X=5Xgr8B6pqpxfJBOEp15pnAxtG7EC6zsE7g0iRMdyJvUmcg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/Cobalt on ARM64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vivien LEGER <vivien.leger@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 11/06/2016 11:29 AM, Vivien LEGER wrote:
> Thanks for this very fast anwser.
>
> I d love to say that i wish to bring my part to the edifice , still as a
> young father of two that would be unmanageable for now.
>
> I ll be using A53 series with xenomai a lot (running as an armv7), i
> quickly hope to jump to a A72 for work purpose.

even thought we haven't been able to make much progress on aarch64 - in 
terms of merging- please see the link below on some early demos
http://www.96boards.org/blog/xenomai-on-the-96boards/

During San Diego ELC-A 2016 I demonstrated Xenomai controlling motors on 
AOSP(Android) and Debian using the HiKey board (armv8) - basically 
having a service controlling the pwm signal to a number of servos using 
gpios. For the AOSP the service was using glibc (not bionic)
http://www.96boards.org/blog/servo-motor-control/

if you are looking for arm64 platforms to work these are two of the ones 
I use (HiKey and db410c)
http://www.96boards.org/products/ce/


>
> Thus there is some chance i end up diving in the ipipe patch for aarch64,
> be sure i ll keep in touch if i came close to something sharable.
>
> VL.
>
> Note : several of my colleague and Iare building a xenomai based distro as
> a side project, 3 of us are really arm enthousiasts, we hope to be able to
> contribute some day.



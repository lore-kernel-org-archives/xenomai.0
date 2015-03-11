Message-ID: <8dc6116b7b5868d884c9f8c3e3de3c84.squirrel@xenomai.org>
In-Reply-To: <5500A3DD.2070306@xenomai.org>
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
 <54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
 <54F97E05.8010107@xenomai.org>
 <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
 <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
 <54FF64AF.5000300@xenomai.org>
 <CAKk99t2159Do6Rj0GSRPkPFcbN-qT9JpWBD1ojmFOHYv7ZKkGg@mail.gmail.com>
 <5500A3DD.2070306@xenomai.org>
Date: Wed, 11 Mar 2015 22:01:42 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>


Philippe Gerum wrote:
> On 03/11/2015 06:30 PM, Helder Daniel wrote:
>>     You need /lib/modules/$(shell uname -r)/build to refer to a kernel
>> tree
>>     prepared with the Xenomai kernel sources, i.e.
>> scripts/prepare-kernel.sh
>>     should have run in this source tree at some point. The errors you
>> get
>>     indicate that no Xenomai code can be found there.
>>
>>
>> I had
>>
>> /lib/modules/$(shell uname -r)/build
>>
>> pointing to the kernel headers installed from a .deb package.
>> This package was created when compiling the Cobalt kernel with:
>>
>> make-kpkg --initrd kernel_image kernel_headers
>>
>> so I assumed that all Xenomai code is included in that package.
>>
>> Now I pointed to the kernel source tree and I can compile the module.
>>
>> This is strange. I was expecting that the kernel headers package created
>> with debian build to store all Xenomai info, so that I can install a
>> cobalt kernel image + headers in another computer, from 2 debian
>> packages (I did this before successfully with Xenomai 2.5.x) without
>> having to copy all the kernel source tree.
>>
>
> Following the current kernel standards, Xenomai 3 introduces a strict
> split between kernel headers and user-space ones, with a uapi/ section
> for the shared portion which exposes the ABI. Maybe debian/rules does
> not reflect that change.
>

make-kpkg does not use the debian rules. It uses its own rules, and yes,
you may have issues if you use an old version of make-pkkg (like for
instance the one in debian stable) with a newer kernel. The solution is to
install make-kpkg from debian unstable. Or maybe use a backport if it
exists. Now, I do not know if make-kpkg will resolve the symbolic links
in the kernel sources, or if it keeps them. If it keeps them, you need
to keep the xenomai headers at the place they were when running
prepare-kernel.sh.

-- 
                    Gilles.



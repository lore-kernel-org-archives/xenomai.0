Message-ID: <54F5D34A.90005@xenomai.org>
Date: Tue, 03 Mar 2015 16:29:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
 <54F47A0B.7090900@xenomai.org>
In-Reply-To: <54F47A0B.7090900@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bart Vissers <bvissers@e2mtechnologies.eu>
Cc: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 03/02/2015 03:56 PM, Philippe Gerum wrote:
> On 02/25/2015 09:33 AM, Bart Vissers wrote:
>> Hi Philippe,
>>
>> Before making any changes, I ran xeno-config --info:
>> Xenomai version: Xenomai/cobalt v3.0-rc3 --
>> Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 2015
>> i686 GNU/Linux
>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
>> root=UUID=0925426e-e058-4093-963c-8b7de072e229 ro quiet
>> I-pipe release #2 detected
>> Cobalt core 3.0-rc3 detected
>> Build args: --prefix=/usr --includedir=/usr/include/xenomai
>> --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite
>> --build i486-linux-gnu build_alias=i486-linux-gnu
>>
>> namelist did not work, as latency does not contain any symbols. How
>> can I include these when building debian packages?
>>
>> Unfortunately, I got compilation errors after applying the patch to
>> xenomai-3.0-rc3: error: ‘XENO_WARNING’ undeclared (first use in this
>> function)
>> So I decided to repeat my steps with the git next branch, 52fb91e...
>> So, same linux kernel, i-pipe patch and kernel config. Also included
>> the printk patch. Output:
>>
>> == Sampling period: 100 us
>> == Test mode: periodic user-mode task
>> == All results in microseconds
>> warming up...
>> latency: failed to set periodic, code 9
>> ^C---|-----------|-----------|-----------|--------|------|-------------------------
>> RTS|  10000.000|      0.000| -10000.000|       0|     0|    00:03:26/00:03:26
>>
>> Notice the ^C. I killed it because it was running indefinitely. This
>> was also the case in my previous attempts.
>>
>>
> 
> Can any of you send me the generated debian package privately? I would
> also need to know the gcc version used.
> 

Never mind, I could reproduce this bug eventually. This issue is due to
some register trashing at work in the pipeline code, not to the Xenomai
core. More later.

-- 
Philippe.


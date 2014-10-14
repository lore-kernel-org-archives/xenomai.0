From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 13 Oct 2014 22:31:35 -0400
Message-ID: <20141014023135.GE4435@csclub.uwaterloo.ca>
References: <CABVE6k0wMQ-qzuvgueGY0AVOdRJZ5Vgq2JX8q=w_WG65GD5CRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVE6k0wMQ-qzuvgueGY0AVOdRJZ5Vgq2JX8q=w_WG65GD5CRw@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai: /dev/rtheap is missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hasret =?utf-8?Q?Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Cc: Xenomai <Xenomai@xenomai.org>

On Tue, Oct 14, 2014 at 03:18:22AM +0300, Hasret Sarıyer wrote:
> I installed xenomai 2.6.4 and linux kernel 3.14.17 without any error using
> below guide.
> 
> http://xenomai.org/2014/06/building-debian-packages/#Building_a_Xenomai_patched_Linux_kernel_package
> 
> Kernel Configuration :
> 
> * `Real-time sub-system`
>    * ENABLE `Xenomai`
>  * `Power management and ACPI options`
>    * `ACPI (Advanced Configuration and Power Interface) Support`
>      * DISABLE `Processor`
>    * `CPU Frequency scaling`
>      * DISABLE `CPU Frequency scaling`
>  * `Processor Type and Features`
>    * SET `Processor family`
> 
> Processor family is x86. "uname -a"'s command output is
> "3.16.0-031600-generic #201408031935 SMP Sun Aug 3 23:36:11 UTC 2014
> x86_64 x86_64 x86_64 GNU/Linux"

You applied the 3.14.17 patch to a 3.16.0 kernel?  I would imagine a
lot of work to make that happen.

> After these steps, is the xenomai ready for use? When I run below code, the
> output was there.
> 
> $/usr/share/libxenomai-dev/examples/native/
> $sudo make
> $sudo ./trivial-periodic
> 
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)

Well either you are not running the xenomai enabled kernel at all,
or you made it a module and did not load the module yet.

-- 
Len Sorensen


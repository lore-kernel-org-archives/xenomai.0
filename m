Message-ID: <511D3366.6020504@xenomai.org>
Date: Thu, 14 Feb 2013 19:56:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAA+HEuk86rVdKy1DDWmzRGjpvNkDpVsAmG+H-R4mg1Bu2RLy+A@mail.gmail.com>
	<511BEACC.5030705@xenomai.org>
	<CAA+HEukK5Abf5V1DSu0UN+hpDBXJokdZ9aqTP6HR9wepCn6dRg@mail.gmail.com>
In-Reply-To: <CAA+HEukK5Abf5V1DSu0UN+hpDBXJokdZ9aqTP6HR9wepCn6dRg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfault error 4 when running latency test (and all
 userspace tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kris Ellis <drfrankencopter@gmail.com>
Cc: xenomai@xenomai.org

On 02/14/2013 07:32 PM, Kris Ellis wrote:
> I've now tried Xenomai 2.6.2.1 over Linux 3.2.21 using buildroot, and get
> the same result.
>
> The only difference is now dmesg | grep Xenomai shows me v2.6.2.1 (Day At
> The Beach) instead of 2.6.1 (Light Years Away)
>
> Still get a segfault. Has anyone had success using buildroot to build a
> Xenomai system?
>

Definitely, yes. This is how we routinely build our software test 
platform for all supported archs, including x86. You can find our 
buildroot-based generator there:

git://git.xenomai.org/mkrootfs.git

Did you provide a gdb backtrace of this problem?

Please check that your CPU as selected in your kernel configuration 
supports sysenter/sysexit if --enable-x86-sep is enabled in your build 
configuration for the user-space programs and libraries.

-- 
Philippe.


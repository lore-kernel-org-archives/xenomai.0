References: <b9dc71b8-119f-71dc-56f8-ae59bfb51a27@foxmail.com>
 <b338d27d-a4f7-3d8f-4b6e-c5edbaf1f6f3@xenomai.org>
 <60d13f7c-4bab-382b-3e2c-b391d74d7245@foxmail.com>
 <79259a0a-53c6-c8fa-3f1a-11b5534dfe7d@xenomai.org>
 <07dce87d-955a-fe9e-1230-1f11d143b90c@foxmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <beb3d65a-0743-0e2b-f64e-3fedd12d46d1@xenomai.org>
Date: Tue, 28 Nov 2017 10:13:58 +0100
MIME-Version: 1.0
In-Reply-To: <07dce87d-955a-fe9e-1230-1f11d143b90c@foxmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Linux 4.1.18 with xenomai 3.0.3,
	libraries build failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 11/28/2017 10:10 AM, Jack Lee wrote:
> On 11/28/2017 04:41 PM, Philippe Gerum wrote:
>> On 11/28/2017 02:05 AM, Jack Lee wrote:
>>>
>>> On 11/27/2017 05:13 PM, Philippe Gerum wrote:
>>>> On 11/27/2017 05:00 AM, Jack Lee wrote:
>>>>> My board cpu is intel Atom N2800, OS is Lubuntu 17.10, gcc version is
>>>>> 7.2.0.
>>>>> Since the newest 3.0.6 cannot setup on my board, I tried the older
>>>>> version.
>>>>> It works now. But when I build the xenomai libraries, it encounters
>>>>> the
>>>>> following error:
>>>>>
>>>>> -r and -pie can not be used together.
>>>>>
>>>>> then I changed the configuration to
>>>>>
>>>>> ../configure --with-core=cobalt --enable-smp --enable-pshared
>>>>> CFLAGS="-no-pie"
>>>>>
>>>>> It didn't work with the new error:
>>>>>
>>>>> In file included from ../../../utils/analogy/calibration_ni_m.h:27:0,
>>>>>                    from ../../../utils/analogy/calibration_ni_m.c:26:
>>>>> ../../../utils/analogy/analogy_calibrate.h: In function ‘__debug’:
>>>>> ../../../utils/analogy/analogy_calibrate.h:95:2: error: implicit
>>>>> declaration of function ‘clock_gettime’
>>>>> [-Werror=implicit-function-declaration]
>>>>>     clock_gettime(CLOCK_MONOTONIC, &now);
>>>>>     ^~~~~~~~~~~~~
>>>>> ../../../utils/analogy/analogy_calibrate.h:95:16: error:
>>>>> ‘CLOCK_MONOTONIC’ undeclared (first use in this function)
>>>>>     clock_gettime(CLOCK_MONOTONIC, &now);
>>>>>                   ^~~~~~~~~~~~~~~
>>>>> ../../../utils/analogy/analogy_calibrate.h:95:16: note: each
>>>>> undeclared
>>>>> identifier is reported only once for each function it appears in
>>>>>
>>>>> Can anyone help?
>>>> Instead of downgrading to a release with known core issues, you have
>>>> the
>>>> option to pull fixes for v3.0.6 from the maintenance branch:
>>>>
>>>> URL: http://git.xenomai.org/xenomai-3.git/
>>>> branch: stable-3.0.x
>>> This one seems to have no configure script.
>>> When I run autoconf in the top directory, I get the following error:
>>>
>>> configure.ac:51: error: possibly undefined macro: AM_CONDITIONAL
>>>        If this token and others are legitimate, please use
>>> m4_pattern_allow.
>>>        See the Autoconf documentation.
>>> configure.ac:88: error: possibly undefined macro: AC_PROG_CC_FOR_BUILD
>>> configure.ac:106: error: possibly undefined macro: AM_INIT_AUTOMAKE
>>> configure.ac:108: error: possibly undefined macro: AM_MAINTAINER_MODE
>>> configure.ac:109: error: possibly undefined macro: AM_PROG_AS
>>> configure.ac:110: error: possibly undefined macro: AM_PROG_LEX
>>> configure.ac:164: error: possibly undefined macro: AC_ENABLE_SHARED
>>> configure.ac:165: error: possibly undefined macro: AC_PROG_LIBTOOL
>>> configure.ac:238: error: possibly undefined macro: AM_CPPFLAGS
>>>
>>>
>>>
>>>
>> You need to run the bootstrap script first, see
>>
>> https://xenomai.org/installing-xenomai-3-x/#Installing_the_Xenomai_libraries_and_tools
>>
>>
> Thanks, but there is something wrong still.
> 
> configure.ac:164: error: possibly undefined macro: AC_ENABLE_SHARED
>       If this token and others are legitimate, please use m4_pattern_allow.
>       See the Autoconf documentation.
> configure.ac:165: error: possibly undefined macro: AC_PROG_LIBTOOL
> autoreconf: /usr/bin/autoconf failed with exit status: 1
> 
> 
> 
> 

The doc I pointed out also mentions:

"If you plan to build from the sources available from the Xenomai GIT
tree (git.xenomai.org), the autoconf (>= 2.62), automake and libtool
packages must be available on your build system."

-- 
Philippe.


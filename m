References: <45EE64EE-9FEE-49D4-B676-2A712AB5A7F4@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <96fb24f1-94b6-c9b3-88b6-cffb4767d61e@xenomai.org>
Date: Fri, 6 Oct 2017 10:29:32 +0200
MIME-Version: 1.0
In-Reply-To: <45EE64EE-9FEE-49D4-B676-2A712AB5A7F4@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Patch] Add missing header file to analogy_calibrate.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>, xenomai@xenomai.org

On 10/06/2017 09:55 AM, Christoph Müllner wrote:
> Hi Xenomai-List,
> 
> attached is a patch, which solved a compilation issue when building Xenomai next (c4baa9a84).
> Note, that I am building Xenomai in Buildroot with aarch64 as target architecture.
> I'm using GCC 6, glibc 2.25 and Linux headers from 4.12.
> 
> The complete error message is:
> 
>>   ke[3]: Entering directory '/home/cmuellner/rk3399/buildroot/buildroot-2017.08/output/build/xenomai-next/utils/analogy'
>> [...]
>>   CCLD     insn_read
>> In file included from calibration_ni_m.h:27:0,
>>                  from calibration_ni_m.c:26:
>> analogy_calibrate.h: In function ‘__debug’:
>> analogy_calibrate.h:95:2: error: implicit declaration of function ‘clock_gettime’ [-Werror=implicit-function-declaration]
>>   clock_gettime(CLOCK_MONOTONIC, &now);
>>   ^~~~~~~~~~~~~
>> analogy_calibrate.h:95:16: error: ‘CLOCK_MONOTONIC’ undeclared (first use in this function)
>>   clock_gettime(CLOCK_MONOTONIC, &now);
>>                 ^~~~~~~~~~~~~~~
>> analogy_calibrate.h:95:16: note: each undeclared identifier is reported only once for each function it appears in
>> cc1: all warnings being treated as errors
>> Makefile:693: recipe for target 'calibration_ni_m.o' failed
> 

Merged, thanks.

-- 
Philippe.


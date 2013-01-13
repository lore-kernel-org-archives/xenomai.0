Message-ID: <50F29F69.3030409@xenomai.org>
Date: Sun, 13 Jan 2013 12:50:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50ED750B.4010606@siemens.com> <50F19966.9050008@xenomai.org>
	<50F297D1.2090800@web.de>
In-Reply-To: <50F297D1.2090800@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] prepare-kernel: Only purge links from target
	directories
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 01/13/2013 12:17 PM, Jan Kiszka wrote:

> On 2013-01-12 18:12, Gilles Chanteperdrix wrote:
>> On 01/09/2013 02:47 PM, Jan Kiszka wrote:
>>
>>> Only remove files from the target directory of patch_link if they are
>>> missing in Xenomai AND are actually symbolic links. This is required
>>> when merging Xenomai directories into non-empty kernel dirs.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> This is not required for the current patch workload but helps us in 2.6
>>> with integrating ftrace (we patch into include/trace/events there).
>>> Would reduce our queue length by one if this could be merged
>>> nevertheless.
>>
>>
>> Despite the fact that it is a one-liner, I do not understand what this
>> patch does, and I am not sure it is not going to break things.
> 
> One way to install Xenomai into a kernel source tree is by adding
> symbolic links to the individual source files. In preparation of this
> step, the prepare-kernel script first purges all files from affected
> directories that are not present in the Xenomai sources (anymore). That
> works fine for our current Xenomai dirs as they are exclusively used but
> fails once we have to patch dirs that are also used by the original
> kernel (like the cited trace event dir).


The thing I do not understand is why Xenomai would patch the trace event
dir? This is the I-pipe's job.

-- 
                                                                Gilles.


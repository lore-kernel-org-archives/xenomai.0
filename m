Subject: Re: Building deb packages
References: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
 <378aee64-da86-da9f-eb46-5059949e37d7@siemens.com>
 <rOql7M13UpQ86c6D3l2RkZfn2hfdic4R0_-GagsurIAJJqe5mwDdFHqYOrDo8LSpNcCCw-_wiOjBp2WaWcyTagPWwE461jmNCgwW5ead5vk=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cdbee450-251e-b79b-ac38-ddf1f9aaf568@siemens.com>
Date: Tue, 26 Nov 2019 19:15:46 +0100
MIME-Version: 1.0
In-Reply-To: <rOql7M13UpQ86c6D3l2RkZfn2hfdic4R0_-GagsurIAJJqe5mwDdFHqYOrDo8LSpNcCCw-_wiOjBp2WaWcyTagPWwE461jmNCgwW5ead5vk=@codecraftsmen.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>
Cc: Xenomai <xenomai@xenomai.org>

On 26.11.19 19:06, Jeff Webb wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Tuesday, November 26, 2019 11:45 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 26.11.19 18:33, Jeff Webb via Xenomai wrote:
>>
>>> I have previously used make-kpkg to build deb packages for my Ubuntu systems. This process worked, but the linux-headers package was never quite right. I could not build my own kernel drivers (e.g. custom UDD drivers) on another system without copying the build directory over or monkeying with the headers package.
>>> With my latest builds, I tried make deb-pkg with 4.19.84 and 4.4.199-cip39. The linux-headers package built with this process almost works. There were, however just a few Xenomai headers that were missing. This following patch to 4.19.84 fixed the issue:
>>
>> How did you prepare the kernel with Xenomai, link or patch mode?
>>
>> If link: This looks incomplete because link targets to Xenomai sources
>> should be missing from the package.
>>
>> If patch: Which links exactly do we miss here?
> 
> I'm not sure... I didn't give any specific option regarding this and I am away from my system.  The linux-headers package had links to the xenomai header files in the xenomai source package.  Most of the required links to xenomai headers were there, just a handful in one extra deep subdirectory were missing -- hopefully you can tell which ones from the patch.  (I can follow up with specifics later, if it is not clear what is missing -- just let me know.)

That explains what went wrong: The link approach, default mode of 
prepare-kernel.sh, is not intended to be the source of a kernel 
packaging. It create a dependency between the header package and the 
xenomai source package that is likely not modeled in your approach as well.

Use prepare-kernel with --outpatch, apply that patch to the kernel 
before the build, and then generate the package. That kernel-header 
package should then be fine without further patching.

Just noticed that we do the same mistake in xenomai-images [1], but we 
didn't noticed it there as we are builing no external module so far.

Jan

[1] 
https://gitlab.denx.de/Xenomai/xenomai-images/blob/master/recipes-kernel/linux/linux-xenomai.inc

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


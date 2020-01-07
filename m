Subject: Re: how to make an ipipe patch
References: <5E142C68.1040506@kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2a638305-e12d-db7a-d314-cdf9dba59a47@siemens.com>
Date: Tue, 7 Jan 2020 08:10:51 +0100
MIME-Version: 1.0
In-Reply-To: <5E142C68.1040506@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@kylinos.cn>, xenomai@xenomai.org

On 07.01.20 07:59, chensong via Xenomai wrote:
> Hi,
> 
> i'm working on enabling xenomai in a specific arm64 device, 
> unfortunately, the kernel version in its sdk is 4.4.154, which doesn't 
> have an available ipipe patch in 
> https://xenomai.org/downloads/ipipe/v4.x/arm64/ (like 
> ipipe-core-4.4.164-arm64-4.patch )

Right, I-pipe was never developed on 4.4 for ARM64. That arch 
effectively started to work with 4.14, and now it's on 4.19. 4.4 will be 
a tough challenge. Better double-check with your vendor if they have a 
more recent SDK - or, much better, if their support is in mainline by now.

> 
> I'm trying to make the patch on my own, however, i haven't found any 
> guide about this online, i would appreciate it if someone can guide me 
> here, step by step, many thanks.

The most detailed guild is the patch queue for 4.19 in git now. It's 
generic part is already available on 4.4-cip via x86 and ARM, but the 
arm64-specific would have to be backported, somehow.

Some information may also be derivable from 
https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC, 
though that was targeting ARM.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


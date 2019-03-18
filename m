Subject: Re: Cobalt compatible distribution
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
 <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
 <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
 <544217707.857557.1552467189711.JavaMail.zimbra@wolfram.com>
 <1283d7c0-b719-8c63-6c7f-abbefe269a7a@gmail.com>
 <192645678.5721329.1552685329163@mail.yahoo.com>
 <cece8f69-d8c5-7165-e918-444398bea154@gmail.com>
 <990066230.5891305.1552722294814@mail.yahoo.com>
 <79b82a59-788d-e7b5-8465-8fb1d37bc20c@gmail.com>
 <1723459381.6926353.1552936352861@mail.yahoo.com>
 <697763087.6947921.1552936385419@mail.yahoo.com>
From: Don Newbold <d.o.newbold@gmail.com>
Message-ID: <7125eb31-9429-bcd1-2821-ca78ed2e0755@gmail.com>
Date: Mon, 18 Mar 2019 15:59:40 -0500
MIME-Version: 1.0
In-Reply-To: <697763087.6947921.1552936385419@mail.yahoo.com>
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
To: Alec Ari <neotheuser@ymail.com>, Xenomai--- via Xenomai <xenomai@xenomai.org>

Alec,

The source of this info might come from pages such as the below which 
includes kernel version numbers. This is what led me down the path to 
looking for a specific kernel version number.

> https://gitlab.denx.de/Xenomai/ipipe/tags

Even the main ipipe page below gives a kernel version number. Yes, I see 
the note "Interrupt pipeline support for legacy kernel releases (up to 
4.9.x series)". This though, tells me it works only with 4.9.x series 
kernels.

> https://gitlab.denx.de/Xenomai/ipipe

Is there documentation somewhere that makes it clear what kernel 
versions each Cobalt release supports?

Don

On 3/18/2019 2:13 PM, Alec Ari via Xenomai wrote:
>> All I was looking to distriwatch for was a
>> distribution which shipped with a kernel version supported by Cobalt.
> 
> Ahhhh, got it!!! Kernel version and distro don't matter at all. People run 4.14 kernels on distros shipped with 2.6.32 and it works fine. The old saying, kernel space always breaks, user space never breaks. Kernel.org does a good job at providing legacy/obsolete calls+functions so it is all backwards compatible with old tools, whether it be I2C, ACPI SCSI, etc.
> 
> That being said, I do not know where this kernel version/distro kernel version must match rumor started but I've been seeing it more lately. That is just propaganda and can safely be ignored.
> 
> Alec
> 
> 
> ---
> This email has been checked for viruses by AVG.
> https://www.avg.com
> 
> 


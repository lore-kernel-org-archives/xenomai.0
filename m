References: <f9fc1bc9-5794-4408-8f85-f7ad3a12a05e@xenomai.org>
 <alpine.DEB.2.20.1806271450060.17374@af78237-pc.mitre.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <57e502f2-b7d6-3a2f-29e6-d2876615492c@xenomai.org>
Date: Wed, 27 Jun 2018 21:44:48 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1806271450060.17374@af78237-pc.mitre.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Melvile <jmelville@mitre.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/27/2018 08:54 PM, Jeff Melvile wrote:
> Philippe,
> 
> Thanks again for all your work on this release.
> 
> On Mon, 25 Jun 2018, Philippe Gerum wrote:
> 
>>
>> Xenomai 3.0.7 is out [1]. The GIT repository can be cloned from [2].
>>
>> Some GPIO driver updates, several bug fixes in the Cobalt core, and a
>> critical bug removed from the pshared heap (for users of non-POSIX APIs
>> building with --enable-pshared).
>>
>> An effort to sanitize some legacy from RTnet causing invalid accesses
>> from kernel space to userland memory also stands out, although more work
>> remains in this area.
>>
>> This release supports up to the Linux 4.14 series for ARM, ARM64 and
>> PPC32. Work is still ahead for running Cobalt over 4.14/x86 though.
> 
> Is ARM64 a typo? The v3.0.7 tag doesn't have ARM64 directories in 
> {kernel,lib}/cobalt/arch
> 

Yes, ARM64 is supported over Xenomai's -next branch only. I-pipe/4.14
does support ARM64 already though.

-- 
Philippe.


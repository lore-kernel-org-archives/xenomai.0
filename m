Subject: Re: Exception #14 in kernel space when using rttcp
References: <1293572894.22066.1591975586278.JavaMail.zimbra@wolfram.com>
 <f545866d-efc1-e35e-5f69-6a40102a5cb0@siemens.com>
 <544072279.25640.1591976851898.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <393bccc6-8d64-b382-dc54-14893cbd385c@siemens.com>
Date: Fri, 12 Jun 2020 17:54:39 +0200
MIME-Version: 1.0
In-Reply-To: <544072279.25640.1591976851898.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 12.06.20 17:47, Per Oberg via Xenomai wrote:
> ----- Den 12 jun 2020, på kl 17:33, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>> On 12.06.20 17:26, Per Oberg via Xenomai wrote:
>>> Hi list
> 
>>> I get a massive amount of "swithching ... to secondary mode after exception #14
>>> in kernel-space ..." followed by a WARNING as shown below.
> 
>>> Can someone enlighten me regarding the meaning of exception #14 ?
> 
>>> Is the "WARNING: CPU: 0 ..." the cause or the symptom ? It has a macro at fd.c
>>> calling "XENO_WARN_ON(COBALT, fd->refs <= 0);
> 
> 
>> Likely related: The WARN_ON triggers a stack dump and that may trigger
>> fixable or ignorable faults. We may consider converting that
>> XENO_WARN_ON into XENO_WARN_ON_ONCE.
> 
>> What is actually interesting is the warning itself. Reference counting
>> became imbalanced. How do you trigger that?
> 
> Where do you see that? I can't figure out anything about what is going on from that warning...
> 

Warning at .../rtdm/fd.c:299:

static void __put_fd(struct rtdm_fd *fd, spl_t s)
{
	...
	XENO_WARN_ON(COBALT, fd->refs <= 0);

So, the file descriptor is released although its internal reference
counter says it's not held. That is a bug in the kernel, likely leading
to use-after-release issues.

> Not sure what I am actually doing, but I'd be glad to debug it if I knew where to start. 
> 
> I'm working on compiling a network library for use in Xenomai. It uses a lot of extra stuff to get everything up and running,but in the end it will use UDP for the data exchange. So switching to secondary mode may be ok during the startup. 
> 

I suppose you are writing a userspace application that uses RT-TCP here.
That usage pattern up to the point you see the first warning would be
interesting, ideally as minimal testcase. Also the configuration of the
RTnet stack (compile-time and runtime).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


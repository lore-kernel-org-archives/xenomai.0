Message-ID: <537DDDDB.8040207@xenomai.org>
Date: Thu, 22 May 2014 13:22:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.3.1398938401.5042.xenomai@xenomai.org>
 <EF7485C1EA725C47A37C7090FD7DDF78442128BC@S3-EXCHMB05.shared-svc.local>
In-Reply-To: <EF7485C1EA725C47A37C7090FD7DDF78442128BC@S3-EXCHMB05.shared-svc.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Digest, Vol 25,
 Issue 1 ( ipipe-core-3.10 patch for arm)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lim Tao Ming (SIMTech)" <tmlim@simtech.a-star.edu.sg>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2014 12:40 PM, Lim Tao Ming (SIMTech) wrote:
>> Hello,
>>
>> I saw from your past discussion that there is a patch for kernel 
>> version 3.10 but was not released. It just so happened that the 
>> provided kernel source code with support for my hardware is always 
>> released with version sublevel=0 (i.e. 3.10 but not 3.10.18 or 
>> 3.10.32). Can I get this patch from you to try out xenomai? BTW I am a 
>> newbie at this and I've tried patching the 3.10 source code using the 
>> 3.10.18 and 3.10.32 patches without success.
> 
> A simple solution is to apply the 3.10.18 stable patch to your vendor kernel based on 3.10.0, then apply the I-pipe patch.
> 
I am sorry, I can not quote your mail, because you replied under the
signature, and my MUA (correctly) trims the signature when replying.
You did not prefix the lines you quoted with "> ", which is the usage on
this mailing list (and almost all mailing lists I know).

The message does not say that AT91 is not supported, it says:
AT91 processor unsupported by Adeos

It means that the particular AT91 for which you want to compile the
Adeos I-pipe kernel (an at91 SAMA5D3 if I understood correctly) is not
supported.

The simplest solution is to use the I-pipe kernel for Linux 3.14.0
(branch stable/ipipe-3.14.0 in git://git.xenomai.org/ipipe.git), as it
has support for SAMA5D3, and its support for AT91 has been reworked to
use the TCLIB component, so should work with any AT91.

In the event it does not work, or not correctly, check:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

If you want to use Xenomai with a vendor fork, you will need some work
to merge the I-pipe changes with that fork, you can not expect the
patches to apply cleanly.

-- 
                                                                Gilles.


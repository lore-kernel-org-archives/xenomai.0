Message-ID: <5360E48A.40705@xenomai.org>
Date: Wed, 30 Apr 2014 13:54:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EF7485C1EA725C47A37C7090FD7DDF784420DE08@S3-EXCHMB05.shared-svc.local>
In-Reply-To: <EF7485C1EA725C47A37C7090FD7DDF784420DE08@S3-EXCHMB05.shared-svc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe-core-3.10 patch for arm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lim Tao Ming (SIMTech)" <tmlim@simtech.a-star.edu.sg>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/30/2014 04:36 AM, Lim Tao Ming (SIMTech) wrote:
> Hello,
>
> I saw from your past discussion that there is a patch for kernel
> version 3.10 but was not released. It just so happened that the
> provided kernel source code with support for my hardware is always
> released with version sublevel=0 (i.e. 3.10 but not 3.10.18 or
> 3.10.32). Can I get this patch from you to try out xenomai? BTW I am
> a newbie at this and I've tried patching the 3.10 source code using
> the 3.10.18 and 3.10.32 patches without success.

A simple solution is to apply the 3.10.18 stable patch to your vendor 
kernel based on 3.10.0, then apply the I-pipe patch.

-- 
					    Gilles.


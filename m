MIME-Version: 1.0
In-Reply-To: <20150430183147.GZ1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
Date: Thu, 30 Apr 2015 13:04:07 -0700
Message-ID: <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 11:31 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, Apr 30, 2015 at 08:53:10AM -0700, Hongfei Cheng wrote:
>> 4). High resolution counter is not yet supported as we're exploring
>> different way(s) to implement TSC.
>
> Note the implications here: if you say "all armv8 will use
> architected timer", we can get away with a unique implementation. If
> you want to use another timer, then we will have to implement kernel
> helpers with a constant kernel/user ABI, so probably in the vdso.
> All this for an improved accuracy that may well not be worth the
> trouble.

Currently we're not concerned about tsc accuracy.

Could you elaborate a bit more on the "architected timer" and the
possible implementation you envision on Cortex-A53/A57?

Is the I-pipe tracer dependent upon a live/running tsc counter?

Thanks again,
Hongfei


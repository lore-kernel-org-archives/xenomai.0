MIME-Version: 1.0
Date: Fri, 20 Mar 2015 09:45:59 -0700
Message-ID: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles,

Do you mind to share the maker of the ARMv8 board which you are
working on, as indicated in the posting below?

Thanks,
Hongfei

Gilles Chanteperdrix gilles.chanteperdrix at xenomai.org
Mon Feb 16 21:44:38 CET 2015

On Mon, Feb 16, 2015 at 12:15:41PM -0800, Gary Gitelson wrote:
> Hi,
>
>     There is an excellent guide for porting Xenomai to other ARM-based SOCs.
> But this seems to assume that they are 32-bit ARM SOCs, based on ARMv7 or
> lower.  Is there active work, or a guide or assistance, on porting to SOCs
> based on ARMv8 architectures (specifically, in my case, the Qualcomm
> MSM8994).

No, everything needs to be done for armv8.

>  I assume that almost everything in the arch/arm portion of the
> kernel would need to exist in the arch/arm64 subtree, but I am not sure
> exactly what is involved here.
>     Any assistance, or leads on existing work, would be much appreciated.

Linaro donated an ARMv8 board, I will start working on the I-pipe
port soon, but can not promise it will be finished rapidly.

-- 
   Gilles.


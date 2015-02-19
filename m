Date: Thu, 19 Feb 2015 14:45:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150219134544.GT30317@hermes.click-hack.org>
References: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
Subject: Re: [Xenomai] Compiling issue Xenomai 3.0 rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Feb 19, 2015 at 03:40:35PM +0200, Michael Smith wrote:
> Hi. I'm having trouble compiling the newest release (Xenomai 3.0-rc3).
> With the error
> 
> autotune.c: In function ‘main’:
> autotune.c:298:16: error: ignoring return value of ‘daemon’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>           daemon(0, 0);
> 
> Is there an way to override the -Werror flags so it doesn't break on
> warnings without editing the make files?
> Or is the policy on Xenomai to always compile cleanly without warnings.
> Is this maybe my compilation method, but then again I did compile Xenomai
> 3.0-rc2 without an issue.
> But I assume when a release is done it does compile cleanly.

It compiles cleanly with the maintainer's compiler, which is not
necessarily the same as the one you are using.

Anyway, this is all my fault, this bug has already been signaled. I
said I would fix it, which obviously I did not.

-- 
					    Gilles.


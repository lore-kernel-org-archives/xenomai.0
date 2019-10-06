Subject: Re: Dovetail status clarification
References: <CABaOOZ0nqvBR+PMCWvZieY+b3j3nAcq_0FVSY42F0FjcXKD_hQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5317e633-f1a4-9826-267a-9bd2c827baec@xenomai.org>
Date: Sun, 6 Oct 2019 19:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <CABaOOZ0nqvBR+PMCWvZieY+b3j3nAcq_0FVSY42F0FjcXKD_hQ@mail.gmail.com>
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
To: Stratiyenko Roman <picoworm@gmail.com>, xenomai@xenomai.org

On 10/2/19 9:06 AM, Stratiyenko Roman wrote:
> Hello xenomai community,
> 
> As you may already know kernel v5.4-rc1 released yesterday and according
> to releases page on kernel.org <http://kernel.org> this version is LTS.
> 
> So it make sense to start porting of xenomai to this release. 
> 
> Some time ago dovetail were announced and It should replace ipipe for
> xenomai.
> 
> Do you have any plans to start this migration in nearest time?
> 

Dovetail currently runs 5.4-rc1 on x86_64, arm(v7) and armv8. Real-time
response and stability are routinely tested using EVL [1] which is the
reference rt core for Dovetail. Results look promising enough at this
stage for me not to consider porting the I-pipe/arm* to 5.4. I'd rather
contribute time and energy to improve Dovetail instead.

The initial groundwork for interfacing Xenomai 3 with Dovetail has
started some time ago by abstracting the I-pipe specific code from
Cobalt, since the current option is to allow enabling either I-pipe (for
pre-5.x kernels) or Dovetail at build time. I recently rebased that
stuff over the -next branch [2]. However, significant work remains to be
done for Dovetail support, including in libcobalt.

Switching to Dovetail will affect the ABI, so this would definitely be
post-3.1 material.

[1] https://evlproject.org/ports/
[2] https://lab.xenomai.org/xenomai-rpm.git/log/?h=wip/dovetail

-- 
Philippe.


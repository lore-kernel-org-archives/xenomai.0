References: <201609010907237204378@empower.cn>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <22892efa-ca53-f6c0-6b51-d8cd968f9334@xenomai.org>
Date: Thu, 1 Sep 2016 09:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <201609010907237204378@empower.cn>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] The dual kernel configuration's questions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "liufei@empower.cn" <liufei@empower.cn>, xenomai <xenomai@xenomai.org>

On 09/01/2016 03:07 AM, liufei@empower.cn wrote:
> Dear all:
>   Yesterday,Philippe answered my questions but there are some new questions in my mind.
> 
>   Both Xenomai 2 and Xenomai 3 can support the dual kernel configuration.This should mean that Xenomai 2 can run side by side with RT-PREEMT.So Xenomai 2 just can solve the proting a RT-PREEMT embedded application's problem.
>    Is there any difference between Xenomai 2 with Xenomai 3 in dual kernel which's native kernel is RT-PREEMT?I know a point that Xenomai 2 and Xenomai 3 are dependency on different linux kernels.

The main difference is that the Cobalt core from Xenomai 3 was
implemented with the possibility of such combination in mind, whereas
only the latest Xenomai 2.6.x releases have been fixed occasionally to
support this when an issue popped up in a specific project.
This said, most of the work for getting this combination to work happens
in the I-pipe code, not in the Xenomai code base.

> 
>   How do i set up the dual kernel configuration if i want the native kernel to be RT-PREEMT kernel?
> 

You need to merge the interrupt pipeline (aka I-pipe) patch into the
preempt-rt enabled kernel sources. Since the I-pipe is developed against
the mainline kernel tree, you may have a few conflicting changes to fix
up. If unlucky, in some cases, you might stumble upon runtime issues as
well, but they tend to be seldom seen with recent kernels.

-- 
Philippe.


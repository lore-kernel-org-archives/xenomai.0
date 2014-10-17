Message-ID: <54413268.3080206@xenomai.org>
Date: Fri, 17 Oct 2014 17:14:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECAF9EF@exchmbx1.int.pason.com>
In-Reply-To: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECAF9EF@exchmbx1.int.pason.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6 Kernel Panic Caused by IO Permissions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brian Eley <Brian.Eley@pason.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/29/2014 10:57 PM, Brian Eley wrote:
> Hi All,
> 
> I've been trying out Xenomai 2.6 for several weeks for use in an embedded system. Xenomai has been working great, but I can make it crash (Kernel Panic) in a repeatable way by starting and stopping processes that use IO Permissions (for directly accessing IO ports from user space). Interestingly, the process with IO permissions doesn't need to use Xenomai to cause the panic.
> 
> I believe I have found the root cause, and I have come up with a potential fix for the issue, but because I am an embedded systems designer with very little kernel programming experience, I would really like to leave it to the Xenomai team to decide on and implement a proper fix.
> 
> Following is a description of my setup along with crash dumps, instructions for reproducing, my analysis of the crash, and a patch I used to fix the problem on my test system.
> 

Your analysis, and the related fix are both correct. I merged the latter
in the mainline repo, along with additional protection for the FPU fixup
code exactly for the same reason. Thanks for this thorough
investigation, and sorry for the late reply.

http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=1b59795aaf0ae26b7d024c6311a9788b5256ec7e

-- 
Philippe.


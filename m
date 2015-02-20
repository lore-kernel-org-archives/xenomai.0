Message-ID: <54E765A4.20909@xenomai.org>
Date: Fri, 20 Feb 2015 17:49:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1YOpt4-0000oo-4D@sd-51317.xenomai.org>
In-Reply-To: <E1YOpt4-0000oo-4D@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/posix/syscall:
 Exclude sc_cobalt_get_current from debug warnings
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 02/20/2015 04:53 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: fc2d70475f4f86da30e68a569e7641982f4dd8e1
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=fc2d70475f4f86da30e68a569e7641982f4dd8e1
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Feb 20 16:50:15 2015 +0100
> 
> cobalt/posix/syscall: Exclude sc_cobalt_get_current from debug warnings
> 
> This syscall is used for probing the context, thus may be triggered by
> non-RT threads as well which we should not report as potential error.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 

This would mean that sc_cobalt_get_current is considered valid from any
process, including those which did not issue sc_cobalt_bind in the first
place.

Do we depend on this today, or are we granting an extended access with
this patch?

-- 
Philippe.


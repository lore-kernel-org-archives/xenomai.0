References: <E1ZAgI1-0000jO-Kb@sd-51317.xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <559557C2.3040004@xenomai.org>
Date: Thu, 2 Jul 2015 17:24:50 +0200
MIME-Version: 1.0
In-Reply-To: <E1ZAgI1-0000jO-Kb@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 07/02/2015 05:20 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Jul  2 17:12:39 2015 +0200
> 
> cobalt/kernel: Remove unused mode parameter from COBALT_SYSCALL

We want to keep this. At some point, maybe, we will be able to use this
information to instrument the code with calling context guards, or as
the source of the mode data in the syscall table. Today, it's at least
useful inline documentation, without having to browse the table.

-- 
Philippe.


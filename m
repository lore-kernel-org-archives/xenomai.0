References: <E1eKej3-00067a-2h@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9d97e4c0-e77c-b4d2-ab00-cf01058dc6d9@xenomai.org>
Date: Fri, 1 Dec 2017 15:58:05 +0100
MIME-Version: 1.0
In-Reply-To: <E1eKej3-00067a-2h@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/rtdm: Avoid
 dereferencing NULL device in __rtdm_dev_ioctl_core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 12/01/2017 07:23 AM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: dfec6f1f9448b4e207e36280a0e48923687a1cee
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=dfec6f1f9448b4e207e36280a0e48923687a1cee
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Nov 30 21:39:44 2017 +0100
> 
> cobalt/rtdm: Avoid dereferencing NULL device in __rtdm_dev_ioctl_core
> 
> File descriptors created by message queues or timerfds do not have
> devices associated with them. Dereferencing that pointer prior to
> checking if we have device fd in the first place is a recipe for
> crashes.
> 

Merged, thanks.

-- 
Philippe.


Date: Fri, 23 Jun 2017 13:49:26 -0400
Message-ID: <20170623174926.GE18556@csclub.uwaterloo.ca>
References: <343a14c9.12901.15cd3ef5a81.Coremail.kirayamato@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343a14c9.12901.15cd3ef5a81.Coremail.kirayamato@zju.edu.cn>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] System freezed when loading initial ramdisk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kirayamato@zju.edu.cn
Cc: xenomai@xenomai.org

On Fri, Jun 23, 2017 at 03:51:37PM +0800, kirayamato@zju.edu.cn wrote:
> Hi, everyone.
> I patched kernel 3.14.17 with xenomai 2.6.4 on my laptop, but the system freezed when booting process showed loading initial ramdisk. I do not find any hints on the trouble shooting manual. Can anyone tell me how to fix it?

Did you generate a new ramdisk with modules built with your new kernel?

Modules built for a different kernel config rarely work with a new kernel.

-- 
Len Sorensen


References: <1509727458-9486-1-git-send-email-ckiorpes@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e393a77e-8f35-77af-5e4e-8d87a1d930c6@xenomai.org>
Date: Sun, 5 Nov 2017 15:42:39 +0100
MIME-Version: 1.0
In-Reply-To: <1509727458-9486-1-git-send-email-ckiorpes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Fix unneeded pre-commit of memory pool when
 CONFIG_XENO_PSHARED set
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On 11/03/2017 05:44 PM, Charles Kiorpes wrote:
> When CONFIG_XENO_PSHARED is set, heapobj_pkg_init_private() was causing unneeded pages to be locked into memory by performing a temporary allocation of the size of the entire memory pool.
> 
> This patch reduces the size of this temporary allocation to a single page when CONFIG_XENO_PSHARED is set.
> 
> Signed-off-by: Charles Kiorpes <ckiorpes@gmail.com>

Merged, thanks.

-- 
Philippe.


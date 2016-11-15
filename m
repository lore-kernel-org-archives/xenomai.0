References: <1478369343-17564-1-git-send-email-romain.naour@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bdc61eee-55be-8a05-0725-67c452761684@xenomai.org>
Date: Tue, 15 Nov 2016 09:51:37 +0100
MIME-Version: 1.0
In-Reply-To: <1478369343-17564-1-git-send-email-romain.naour@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] bfin: remove inline keyword
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@gmail.com>, xenomai@xenomai.org

On 11/05/2016 07:09 PM, Romain Naour wrote:
> Xenomai user space tools fail to build for bfin target since it's
> provide it's own pthread_atfork(), shm_open() and shm_unlink()
> definition using the inline keyword and weak attribute.
> 
> With gcc 5+ the weak attribute is discarded by the inline keyword,
> so each symbol are global and are redefined several time while
> linking.
> 
> Fixes:
> http://autobuild.buildroot.net/results/0c2/0c2e5eb4edd4f9427f61d3c9b67a12a7a0e24140
> 
> Signed-off-by: Romain Naour <romain.naour@gmail.com>

Merged, thanks.

-- 
Philippe.

